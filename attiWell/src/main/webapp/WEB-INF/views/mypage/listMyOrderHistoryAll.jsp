<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<style>
a {
	color: grey; /* 또는 원하는 색상으로 변경 */
}

.input-form {
	max-width: 1000px;
	margin-top: 80px;
	padding: 32px;
	background: #fff;
	border-radius: 10px;
	box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
}
</style>
<script>
	function search_order_history(fixedSearchPeriod) {
		var formObj = document.createElement("form");
		var i_fixedSearch_period = document.createElement("input");
		i_fixedSearch_period.name = "fixedSearchPeriod";
		i_fixedSearch_period.value = fixedSearchPeriod;
		formObj.appendChild(i_fixedSearch_period);
		document.body.appendChild(formObj);
		formObj.method = "get";
		formObj.action = "${contextPath}/mypage/listMyOrderHistoryAll.do";
		formObj.submit();
	}

	function fn_cancel_order(order_id) {
		var answer = confirm("주문을 취소하시겠습니까?");
		if (answer == true) {
			var formObj = document.createElement("form");
			var i_order_id = document.createElement("input");

			i_order_id.name = "order_id";
			i_order_id.value = order_id;

			formObj.appendChild(i_order_id);
			document.body.appendChild(formObj);
			formObj.method = "post";
			formObj.action = "${contextPath}/mypage/cancelMyOrder.do";
			formObj.submit();
		}
	}

	/* function searchOrder() {
	     // 검색 조건 선택값 가져오기
	     var searchCondition = document.getElementsByName("search_condition")[0].value;
	     // 검색 입력값 가져오기
	     var searchInput = document.getElementsByName("searchInput")[0].value;

	     // 선택된 검색 조건에 따라 다르게 처리
	     switch (searchCondition) {
	         case "2012":
	             // 주문번호로 조회
	         
	             break;
	         case "2013":
	             // 주문자로 조회

	             break;
	         case "2014":
	             // 수령자로 조회

	             break;
	         default:
	             // 전체 처리

	     }
	 } */
</script>
<style>
.custom-btn {
	background-color: #1b7340; /* 초록색 배경색 설정 */
	border: none; /* 테두리 없애기 */
	border-radius: 15px; /* radius 설정 */
}
</style>

</head>
<body>
	<div class="container" style="margin-left: 40px">
		<div class="input-form">
			<H3>주문 배송 조회</H3>
			<form method="post">
				<table>
					<tbody>
						<tr>
							<button type="button"
								class="btn btn-primary btn-sm custom-btn mr-3"
								onclick="search_order_history('today')">오늘</button>
							<button type="button"
								class="btn btn-primary btn-sm custom-btn mr-3"
								onclick="search_order_history('one_week')">최근 1주</button>
							<button type="button"
								class="btn btn-primary btn-sm custom-btn mr-3"
								onclick="search_order_history('two_week')">최근 2주</button>
							<button type="button"
								class="btn btn-primary btn-sm custom-btn mr-3"
								onclick="search_order_history('one_month')">최근 1개월</button>
							<button type="button"
								class="btn btn-primary btn-sm custom-btn mr-3"
								onclick="search_order_history('two_month')">최근 2개월</button>
							<button type="button"
								class="btn btn-primary btn-sm custom-btn mr-3"
								onclick="search_order_history('three_month')">최근 3개월</button>
							<button type="button"
								class="btn btn-primary btn-sm custom-btn mr-3"
								onclick="search_order_history('four_month')">최근 4개월</button>
						</tr>
						<tr>
							<td><select name="search_condition">
									<option value="2015" checked>전체</option>
									<option value="2014">수령자</option>
									<option value="2013">주문자</option>
									<option value="2012">주문번호</option>
							</select> <input type="text" name="searchInput" size="30" /> <input
								type="button" value="조회" onclick="searchOrder()" /></td>
						</tr>

					</tbody>
				</table>
				<div class="clear"></div>
			</form>
			<div class="clear"></div>
			<table class="list_view">
				<tbody align=center>
					<tr style="background: #EFE7E1">
						<td class="fixed">주문번호</td>
						<td class="fixed">주문일자</td>
						<td>주문내역</td>
						<td>주문금액/수량</td>
						<td>주문상태</td>
						<td>주문자</td>
						<td>수령자</td>
						<td>주문취소</td>
					</tr>
					<c:choose>
						<c:when test="${empty myOrderHistList }">
							<tr>
								<td colspan=8 class="fixed"><strong>주문한 상품이 없습니다.</strong></td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="item" items="${myOrderHistList }" varStatus="i">
								<c:choose>
									<c:when test="${item.order_id != pre_order_id }">
										<tr>
											<td><a
												href="${contextPath}/mypage/myOrderDetail.do?order_id=${item.order_id }"><strong>${item.order_id }</strong>
											</a></td>
											<td><strong>${item.pay_order_time }</strong></td>
											<td><strong> <c:forEach var="item2"
														items="${myOrderHistList}" varStatus="j">
														<c:if test="${item.order_id ==item2.order_id}">
															<a
																href="${contextPath}/goods/goodsDetail.do?goods_id=${item2.goods_id }">${item2.goods_title }</a>
															<br>
														</c:if>
													</c:forEach>
											</strong></td>
											<td><strong> <c:forEach var="item2"
														items="${myOrderHistList}" varStatus="j">
														<c:if test="${item.order_id ==item2.order_id}">
                         ${item.goods_sales_price*item.order_goods_qty }원/${item.order_goods_qty }<br>
														</c:if>

													</c:forEach>
											</strong></td>
											<td><strong> <c:choose>
														<c:when
															test="${item.delivery_state=='delivery_prepared' }">
                      배송준비중
                   </c:when>
														<c:when test="${item.delivery_state=='delivering' }">
                      배송중
                   </c:when>
														<c:when
															test="${item.delivery_state=='finished_delivering' }">
                      배송완료
                   </c:when>
														<c:when test="${item.delivery_state=='cancel_order' }">
                      주문취소
                   </c:when>
														<c:when test="${item.delivery_state=='returning_goods' }">
                      반품
                   </c:when>
													</c:choose>
											</strong></td>
											<td><strong>${item.orderer_name }</strong></td>
											<td><strong>${item.receiver_name }</strong></td>
											<td><c:choose>
													<c:when test="${item.delivery_state=='delivery_prepared'}">
														<input type="button"
															onClick="fn_cancel_order('${item.order_id}')"
															value="주문취소" />
													</c:when>
													<c:otherwise>
														<input type="button"
															onClick="fn_cancel_order('${item.order_id}')"
															value="주문취소" disabled />
													</c:otherwise>
												</c:choose></td>
										</tr>
										<c:set var="pre_order_id" value="${item.order_id }" />
									</c:when>
								</c:choose>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>

			<div class="clear"></div>
		</div>
	</div>
</body>
</html>