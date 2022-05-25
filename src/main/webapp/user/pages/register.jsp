<%@ page import="com.wcdexercise.wcdexercise4.entity.Account" %><%--
  Created by IntelliJ IDEA.
  User: Nghĩa Hà
  Date: 5/25/2022
  Time: 3:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Account account = (Account) request.getAttribute("account");
    if(account == null) {
        account = new Account();
    }
%>
<!DOCTYPE html>
<html lang="en">

<jsp:include page="/user/includes/head.jsp"></jsp:include>

<body>

    <jsp:include page="/user/includes/sidenav.jsp"></jsp:include>

    <div id="wrapper">

        <jsp:include page="/user/includes/header.jsp"></jsp:include>

        <jsp:include page="/user/includes/discount.jsp"></jsp:include>

        <!-- ****** Checkout Area Start ****** -->
        <div class="checkout_area">
            <div class="container">
                <div class="row">

                    <div class="col-12 col-md-12">
                        <div class="checkout_details_area mt-50 clearfix">

                            <div class="cart-page-heading">
                                <h5>Sign-up New Account</h5>
                            </div>

                            <form action="/register" method="post">
                                <div class="row">
                                    <div class="col-lg-8 col-md-8">
                                        <%
                                            if(account.getListErrors().size() > 0) {
                                        %>
                                        <p class="error_code">
                                            <ul>
                                                <% for (int i = 0; i < account.getListErrors().size(); i++) { %>
                                                <li><%=account.getListErrors().get(i)%></li>
                                                <% } %>
                                            </ul>
                                        </p>
                                        <% } %>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-6">
                                        <label>First Name <span>*</span></label>
                                        <input type="text" class="form-control" value="<%= account.getFirstName() %>" name="firstName" required>
                                    </div>
                                    <div class="col-md-6 mb-6">
                                        <label>Last Name <span>*</span></label>
                                        <input type="text" class="form-control" value="<%= account.getLastName() %>" name="lastName" required>
                                    </div>
                                    <div class="col-md-8 mb-3">
                                        <label>Username<span>*</span></label>
                                        <input type="text" class="form-control" value="<%= account.getUsername() %>" name="username" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label>Phone <span>*</span></label>
                                        <input type="text" class="form-control" value="<%= account.getPhone() %>" name="phone" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label>Email <span>*</span></label>
                                        <input type="text" class="form-control mb-3" value="<%= account.getEmail() %>" name="email" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label>Password <span>*</span></label>
                                        <input type="password" class="form-control" name="password" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label>Confirm Password <span>*</span></label>
                                        <input type="password" class="form-control" name="rePassword" required>
                                    </div>
                                    <div class="row text-center">
                                        <button type="submit" class="btn karl-checkout-btn">Register</button>
                                        <button type="reset" class="btn karl-checkout-btn">Reset Information</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- ****** Checkout Area End ****** -->

        <jsp:include page="/user/includes/footer.jsp"></jsp:include>

    </div>
    <!-- /.wrapper end -->

<jsp:include page="/user/includes/script.jsp"></jsp:include>
<script src="https://upload-widget.cloudinary.com/global/all.js" type="text/javascript"></script>
<script>
    $(function () {
        // Summernote
        $('#summernote').summernote()

        var myWidget = cloudinary.createUploadWidget({
                cloudName: 'dab9sgwgk',
                uploadPreset: 'hgbett7h'}, (error, result) => {
                if (!error && result && result.event === "success") {
                    console.log('Done! Here is the image info: ', result.info.secure_url);
                    document.forms['product-form']['thumbnail'].value = result.info.secure_url;
                    document.getElementById('preview-img').src = result.info.secure_url;
                    document.getElementById('preview-img').style.display = "block";
                }
            }
        )

        document.getElementById("upload_widget").addEventListener("click", function(){
            myWidget.open();
        }, false);
    })
</script>
</body>

</html>
