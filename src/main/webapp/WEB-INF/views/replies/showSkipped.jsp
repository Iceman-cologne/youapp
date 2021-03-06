<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
    $(document).ready(
            function() {
                $('button.edit-question').click(function() {
                	button = $(this);
                    button.addClass('loading-animation');
                	
                	var parent = $(this).parent();
					
                	//get the id of the question
                    var questionId = parent.data('questionid');
					var insert = parent.find("ul");
					
					// get the edit form of the question with the questionId      
					$.get(baseUrl + '/replies/edit.html?selectedquestion='+ questionId, function(data) {
					    insert.html(data);
					
					    $(parent).find(".edit-question").hide();
					    $(parent).find(".save-question").show();
					}).complete(function() {
	                    button.removeClass('loading-animation');
	                });             
                });

                $('button.save-question').click(function() {
                	button = $(this);
                    button.addClass('loading-animation');
                	
                	var parent = $(this).parent();
                    var form = parent.find("form");
                    var insert = parent.find("ul");
                    
                    // post the form input to the controller
                    $.post(baseUrl + '/replies/unskip.html', form.serialize(), function(data){                        
                    	// if the response is empty, everything is fine --> remove the question
                    	// else show the error-form
                    	if(data == "") {                          
                            parent.slideUp("normal",function() {
                                parent.remove();
                            });
                        } else {
                        	insert.html(data);
                        }
                    }).complete(function() {
                        button.removeClass('loading-animation');
                    }); 
                    
                    
                });
            });
</script>

<h2 class="content-heading"><spring:message code="replies.showSkipped.headings.title"/></h2>
<spring:message code="replies.showSkipped.headings.subtitle"/>
<br><br>
<div class="bluediv"> 
<ul>
    <c:forEach items="${repliesList}" var="reply">
        <li class="question" data-questionid="${reply.questionId}">
			<h4 class="questiontitle">
            	<c:out value="${questionMap[reply.questionId].question}" escapeXml="false" />
            </h4>
            <button class="edit-question floatright"><spring:message code="replies.showSkipped.button.answer"/></button>
            <button class="save-question floatright" style="display: none;"><spring:message code="replies.showSkipped.button.send"/></button>
            <ul>
                <c:if test="${not empty questionMap[reply.questionId].answerA}">
                    <li <c:if test="${reply.answerA}"> class="selected"</c:if>><c:out
                            value="${questionMap[reply.questionId].answerA}" /></li>
                </c:if>
                <c:if test="${not empty questionMap[reply.questionId].answerB}">
                    <li <c:if test="${reply.answerB}"> class="selected"</c:if>><c:out
                            value="${questionMap[reply.questionId].answerB}" /></li>
                </c:if>
                <c:if test="${not empty questionMap[reply.questionId].answerC}">
                    <li <c:if test="${reply.answerC}"> class="selected"</c:if>><c:out
                            value="${questionMap[reply.questionId].answerC}" /></li>
                </c:if>
                <c:if test="${not empty questionMap[reply.questionId].answerD}">
                    <li <c:if test="${reply.answerD}"> class="selected"</c:if>><c:out
                            value="${questionMap[reply.questionId].answerD}" /></li>
                </c:if>
                <!-- as reserve for other implementations -->
                <c:if test="${not empty questionMap[reply.questionId].answerE}">
                    <li <c:if test="${reply.answerE}"> class="selected"</c:if>><c:out
                            value="${questionMap[reply.questionId].answerE}" /></li>
                </c:if>
			<br>
            </ul>
        </li>
    </c:forEach>
</ul>
</div>