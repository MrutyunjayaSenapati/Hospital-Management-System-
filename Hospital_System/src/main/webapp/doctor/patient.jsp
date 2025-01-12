<%@page import="com.entity.Doctor"%>
<%@page import="com.dao.AppointmentDAO"%>
<%@page import="com.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Details</title>
<%@include file="../component/allcss.jsp"%>
<style type="text/css">
.paint-card {
	box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
}
</style>
</head>
<body>
    <c:if test="${empty doctObj}">
        <c:redirect url="../doctor_login.jsp"></c:redirect>
    </c:if>
    <%@ include file="navbar.jsp" %>
    <div class="col-md-12">
        <div class="card paint-card">
            <div class="card-body">
                <p class="fs-3 text-center">Patient Details</p>
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th scope="col">Full Name</th>
                            <th scope="col">Gender</th>
                            <th scope="col">Age</th>
                            <th scope="col">Appointment</th>
                            <th scope="col">Email</th>
                            <th scope="col">Mob No</th>
                            <th scope="col">Diseases</th>
                            <th scope="col">Doctor Name</th>
                            <th scope="col">Address</th>
                            <th scope="col">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        try {
                            Doctor d = (Doctor) session.getAttribute("doctObj");
                            AppointmentDAO dao = new AppointmentDAO(DBConnect.getConn());
                            List<Appointment> list = dao.getAllAppointmentByDoctorLoginId(d.getId());

                            if (list != null && !list.isEmpty()) {
                                for (Appointment ap : list) {
                        %>
                        <tr>
                            <td><%= ap.getFullName() %></td>
                            <td><%= ap.getGender() %></td>
                            <td><%= ap.getAge() %></td>
                            <td><%= ap.getAppoinDate() %></td>
                            <td><%= ap.getEmail() %></td>
                            <td><%= ap.getPhNo() %></td>
                            <td><%= ap.getDiseases() %></td>
                            <td><%= d.getFullName() %></td>
                            <td><%= ap.getAddress() %></td>
                            <td>
                                <% if ("Pending".equals(ap.getStatus())) { %>
                                    <a href="comment.jsp?id=<%= ap.getId() %>" class="btn btn-success btn-sm">Comment</a>
                                <% } else { %>
                                    <a href="#" class="btn btn-success btn-sm disabled">Comment</a>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="10" class="text-center">No Appointments Found</td>
                        </tr>
                        <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
