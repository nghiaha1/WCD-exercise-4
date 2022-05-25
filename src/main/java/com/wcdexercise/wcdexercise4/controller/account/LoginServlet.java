package com.wcdexercise.wcdexercise4.controller.account;

import com.wcdexercise.wcdexercise4.entity.Account;
import com.wcdexercise.wcdexercise4.model.AccountModel;
import com.wcdexercise.wcdexercise4.model.MySqlAccountModel;
import com.wcdexercise.wcdexercise4.util.SHA512Hasher;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private AccountModel accountModel;

    public LoginServlet() {
        this.accountModel = new MySqlAccountModel();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/user/pages/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        Account account = accountModel.findByUsername(username);
        if (account != null) {
            boolean loginSuccess = SHA512Hasher.checkPassword(account.getPasswordHash(), password, account.getSalt());
            if (!loginSuccess) {
                account.addErrors("username", "Username or password is Not correct");
            }
        }else {
            account = new Account();
            account.addErrors("username", "Username or password is Not correct");
        }
        if (account.getListErrors().size() > 0) {
            req.setAttribute("account", account);
            req.getRequestDispatcher("user/pages/login.jsp").forward(req, resp);
        }else {
            HttpSession session = req.getSession();
            session.setAttribute("currentLogin", account);
            resp.sendRedirect("/home");
        }
    }
}
