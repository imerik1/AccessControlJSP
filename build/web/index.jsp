<%-- 
    Document   : index
    Created on : 20 de set. de 2021, 20:36:12
    Author     : EkerSteve
--%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%
    // Sessão
    String name = String.valueOf(session.getAttribute("name"));
    String password = String.valueOf(session.getAttribute("password"));
    Boolean sessionActive = name != "null" && password != "null";
    
    // Login
    String nameRequest = String.valueOf(request.getParameter("name"));
    String passwordRequest = String.valueOf(request.getParameter("password"));
    Boolean isValid = nameRequest != "null" && passwordRequest != "null";
    
    // Listagem
    String listaNumeros = String.valueOf(session.getAttribute(nameRequest == "null" ? name : nameRequest));
    List<String> listaFixa = new ArrayList();
    
    if(listaNumeros != "null"){
        String formatList = listaNumeros.replace("[", "").replace("]", "");
        listaFixa = Arrays.asList(formatList.split(",",-1));
    }
    
    // Se for válido o request
    if (isValid) {
        session.setAttribute("name", nameRequest);
        session.setAttribute("password", passwordRequest);
        if (listaNumeros == "null") {
            Random gerador = new Random();
            List<Integer> list = new ArrayList();
            for (Integer i = 0; i < 6; i++) {
                list.add(1+ gerador.nextInt(59));
            }
            session.setAttribute(nameRequest, String.valueOf(list));
        }
        response.sendRedirect("index.jsp");
    }
    
    // Logout
    String logout = String.valueOf(request.getParameter("logout"));
    if (logout != "null") {
        session.removeAttribute("name");
        session.removeAttribute("password");
        response.sendRedirect("index.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ERIKSANTANAAPP</title>
        <style>
            form {
                display: flex;
                flex-flow: column nowrap;
                gap: 1rem;
                width: 100%;
            }
            form div {
                display: flex;
                flex-flow: column nowrap;
                width: 100%;
            }
            form :not(input[type="submit"]) input {
                border-radius: 0.5rem;
                padding: 0.4rem 1rem;
                border: 1px solid #247BA0;
                margin: 0.2rem 0;
            }
            form input[type="submit"] {
                background: #247BA0; 
                padding: 0.4rem 1rem;
                color: white;
                border-radius: 0.5rem;
                margin: auto;
                cursor: pointer;
            }
            table {
                border-collapse: collapse;
                width: 100%;
            }
            table td, table th {
                border: 1px solid #ddd;
                padding: 8px;
            }
            table tbody th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: white;
                color: black;
            }
            table thead th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: center;
                background-color: #04AA6D;
                color: white;
            }
        </style>
    </head>
    <body>
        <%@include file="WEB-INF/header.jspf" %>
        <div class='container'>
            <%if (!sessionActive) {%>
            <form action="index.jsp">
                <div>
                    <label for='name'>Nome</label>
                    <input required type='text' id='name' name='name' placeholder='Seu nome de usuário'/>
                </div>
                <div>
                    <label for='password'>Senha</label>
                    <input required type='password' name='password' id='password' placeholder='Sua senha' />
                </div>
                <input type='submit' value='Fazer login' />
            </form>
            <%} else {%>
            Olá <%=name%>
                <table>
                    <thead>
                        <tr>
                            <th>Posição</th>
                            <th>Número</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (int i = 0; i < listaFixa.size(); i++) { %>
                            <tr>
                                <th><%=i+1%></th>
                                <th><%=listaFixa.get(i)%></th>
                            </tr>
                        <%}%>
                    </tbody>
                </table>
            <%}%>
        </div>
    </body>
</html>