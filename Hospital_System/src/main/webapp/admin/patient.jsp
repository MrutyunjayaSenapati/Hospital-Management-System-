<%@page import="com.entity.Doctor"%>
<%@page import="com.dao.AppointmentDAO"%>
<%@ page import="com.dao.DoctorDao" %>

<%@page import="com.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                            AppointmentDAO dao = new AppointmentDAO(DBConnect.getConn());
                            DoctorDao dao2 = new DoctorDao(DBConnect.getConn());
                            List<Appointment> list = dao.getAllAppointment();

                            if (list != null && !list.isEmpty()) {
                                for (Appointment ap : list) {
                                    Doctor d = dao2.getDoctorById(ap.getDoctorId());
                        %>
                        <tr>
                            <td><%= ap.getFullName() %></td>
                            <td><%= ap.getGender() %></td>
                            <td><%= ap.getAge() %></td>
                            <td><%= ap.getAppoinDate() %></td>
                            <td><%= ap.getEmail() %></td>
                            <td><%= ap.getPhNo() %></td>
                            <td><%= ap.getDiseases() %></td>
                            <td><%= d != null ? d.getFullName() : "N/A" %></td>
                            <td><%= ap.getAddress() %></td>
                            <td><%= ap.getStatus() %></td>
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
