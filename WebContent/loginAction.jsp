<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"  %> <%--우리가 만든 로그인 기능 자바 파일 연결 --%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TOGETHER</title>
</head>
<body>
	<%
		String userID = null; //유저 아이디값이 널이면
		if(session.getAttribute("userID") != null) { //유저 아이디로 세션 이름이 정해져 있다면
			userID = (String) session.getAttribute("userID"); //변수가 자신에게 할당 된 세션아이디를 받을 수 있음
		}
		if (userID != null) { //유저 아이디 값이 널이 아니라면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if (result == 1) {
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
			//아이디와 비밀반호가 일치하면 메인 화면으로
		}
		else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
			//아이디가 존재하나 비밀번호가 틀릴때 그 전 페이지로 돌아가기(로그인 화면)
		}
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
			//아이디가 존재하지 않을때 -1
		}
		else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} //결과 값에 따라 다른 결과 
	%>
 
</body>
</html>