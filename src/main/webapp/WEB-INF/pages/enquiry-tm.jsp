<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="с" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page pageEncoding="UTF-8"%>
<style><%@include file="./css/fio.css"%></style>
<style><%@include file="./css/fio-responsive.css"%></style>
<style><%@include file="./css/footer_responsive.css"%></style>
<style><%@include file="./css/header_responsive.css"%></style>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css"
    />

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500;700;900&family=Ubuntu:wght@300;400;500;700&display=swap" rel="stylesheet">
    <title>Личная информация</title>
    <link rel="stylesheet" href="./styles/fio.css">
    <link rel="stylesheet" href="./styles/fio-responsive.css">
    <link rel="stylesheet" href="./styles/footer_responsive.css">
    <link rel="stylesheet" href="./styles/header_responsive.css">
</head>
<body>
<div class="wrapper">
    <header>
        <div class="container header-container">
            <a href="/" class="logo__link"><img class="logo" src="./img/logo.svg" alt=""></a>
            <navbar class="navbar">
                <a href="exchange" class="navbar__link">Замены</a>
                <a href="shedule" class="navbar__link">Расписание</a>
                <a href="specialty" class="navbar__link">Специальности</a>
                <a href="resourses" class="navbar__link">Электронные ресурсы</a>
                <a href="educator" class="navbar__link">Преподаватели</a>
                <a href="contacts" class="navbar__link">Контакты</a>
                <security:authorize access="hasRole('TEACHER')"> <%--  access="hasRole('HR') указываеться роля кому будет видна--%>
                    <a href="/profile" class="navbar__link navbar__link-profil navbar__link-profil-hidden"><img class="profile-photo-mini" src="./img/${people.name_img}" alt="Фото профиля"></a>
                </security:authorize>
                <security:authorize access="hasRole('STUDENT')"> <%--  access="hasRole('HR') указываеться роля кому будет видна--%>
                    <a href="/profile" class="navbar__link navbar__link-profil navbar__link-profil-hidden"><img class="profile-photo-mini" src="./img/${people.name_img}" alt="Фото профиля"></a>
                </security:authorize>
                <security:authorize access="isAnonymous()"> <%--  access="hasRole('HR') указываеться роля кому будет видна--%>
                    <a href="/profile" class="btn btn-sign">Вход</a>
                </security:authorize>
                <a href="#" class="btn btn-out">Выйти</a>
            </navbar>
            <button class="button-open">
                <div class="line"></div>
                <div class="line"></div>
                <div class="line"></div>
            </button></div>
    </header>



    <section class="content">
        <div class="container content-container">
            <div class="tab-header">
                <a href="/profile" class="tabs__item"           data-tab="#tab3">Личная информация</a>
                <a href="/enquiry-td" class="tabs__item "           data-tab="#tab3">Оценки</a>
                <a href="/enquiry-tm" class="tabs__item is-active"           data-tab="#tab4">Атестационные оценки</a>
                <a href="/fio_t" class="tabs__item"           data-tab="#tab5">Информация о студенте</a>
                <a href="/enquiry_t" class="tabs__item"           data-tab="#tab5">Справки студента</a>
            </div>

            <div class="tabs-content tabs-content-2 tab-is-active" id="tab4">
                <%--@elvariable id="attestations" type="com"--%>
                <p>${NameGroup}</p>
                <p>${NameItem}</p>
                    <p>${NameSemester}</p>
                <div class="content-wrapper content-wrapper-2">
                    <div class="block">
                        <form:form action="/enquiry-tm" modelAttribute="attestations" method="get">
                            <form:select path="semester">
                                <form:option value="1" label="1 семестр"/>
                                <form:option value="2" label="2 семестр"/>
                            </form:select>
                            <form:select path="nameGroup">
                                <form:options items="${attestations.nameGroups}"/>
                            </form:select>
                            <form:select path="nameItem">
                                <form:options items="${attestations.nameItems}"/>
                            </form:select>
                            <input class="btn" type="submit" value="Поиск" onclick="window.location.href='/enquiry-tm'">
                        </form:form>
                        <table>
                            <tr>
                                <th>ФИО студента</th>
                                <th>Название предмета</th>
                                <th>Итоговая оценка за месяца</th>
                                <th>Оценка за зачетную работу</th>
                                <th>Итоговая оценка за семестр</th>
                            </tr>
                            <c:forEach var="emp" items="${semesterAssessment}">

                            <с:url var="updateButton" value="http://localhost:8080/enquiry_update_assessments"><%--  // сылаеться на @RequestMapping("/updateInfo")--%>
                                <c:param name="empId" value="${emp.id}"/>
                            </с:url>
                            <tr>
                                <td>${emp.lastName} ${emp.firstName} ${emp.middleName}</td>
                                <td>${emp.itemName}</td>
                                <td>${emp.monthlyEstimate}</td>
                                <td>${emp.creditWork}</td>
                                <td>${emp.semesterResult}</td>
                                <td>
                                    <input type="button" value="Изменить оценку за зачетную работу" onclick="window.location.href='${updateButton}'"/>
                                </td>
                            <tr>
                                </c:forEach>
                            </tr>
                        </table></div>



                </div>
            </div>
            <div class="tabs-content tabs-content-2" id="tab5">
                <div class="content-wrapper content-wrapper-2">
                    <div class="block">  <table>
                        <tr>
                            <th>Название предмета</th>
                            <th>Высшая математика</th>
                            <th>Высшая математика</th>
                            <th>Высшая математика</th>
                            <th>Высшая математика</th>
                            <th>Высшая математика</th>
                            <th>Высшая математика</th>
                            <th>Высшая математика</th>
                            <th>Высшая математика</th>
                            <th>Высшая математика</th>
                            <th>Высшая математика</th>
                            <th>Высшая математика</th>
                            <th>Высшая математика</th>
                            <th>Высшая математика</th>
                            <th>Высшая математика</th>
                            <th>Высшая математика</th>
                        </tr>
                        <tr>
                            <td>А</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td>Б</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td>В</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td>Г</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                    </table></div>
                </div>
            </div>
        </div>
    </section>

</div>




<footer class="footer">
    <div class="container footer-container">
        <div class="footer-logo"><a href="index.html" class="logo__link"><img class="logo big-logo" src="./img/logo.svg" alt=""></a></div>
        <div class="footer-main-col">
            <p class="footer__title">Полезные ссылки</p>
            <a href="./exchange.html" class="footer__link">Замены</a>
            <a href="./specialty.html" class="footer__link">Специальности</a>
            <a href="./resourses.html" class="footer__link">Электронные ресурсы</a>
            <a href="./contacts.html" class="footer__link">Контакты</a>
        </div>
        <div class="footer-main-col">
            <p class="footer__title">Полезные ссылки</p>
            <a href="./sign-in.html" class="footer__link">Войти в профиль</a>
            <a href="./educator.html" class="footer__link">Преподаватели</a>
            <a href="./kdm.html" class="footer__link">Комитет по делам молодежи</a>
            <a href="./shedule.html" class="footer__link">Расписание</a>
        </div>
        <div class="footer-main-col footer-social-col">
            <p class="footer__title">Мы в социальных сетях:</p>
            <div class="social-container">
                <a href="https://www.instagram.com/apc_stories/" class="footer__link"><img src="./img/Instagram.svg" alt="логотип Instagram" class="footer__img"></a>
                <a href="https://t.me/polytech_astana" class="footer__link"><img src="./img/tg.svg" alt="логотип telegram" class="footer__img"></a>
                <a href="https://vk.com/polytech_astana" class="footer__link"><img src="./img/vk.svg" alt="логотип Vk" class="footer__img"></a>
                <a href="https://www.facebook.com/polytech.astana/" class="footer__link"><img src="./img/fb.svg" alt="логотип FaceBook" class="footer__img"></a>
            </div>
        </div>
    </div>
</footer>


<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
<script src="./script/index.js"></script>
<script type="text/javascript" src="../../js/menu.js"></script>
</body>
</html>