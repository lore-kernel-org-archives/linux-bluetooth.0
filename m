Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781287;
	b=0fnPahKQKonVdSQN+hFcSXL9CyrvjYIjZYiYQxqHImxT+PaJ5hSW4txFeWCvjowJ6iYz
	 ydyaObarp4L74DZcH7FSUHgpviIGL7LAdCFSkUkVgFb7NQ3N+CXPJEFkijpehgEfcuFPN
	 QhwxbAItJ6TXxifR1FQDshw6n8+NesJIuQ3AobT2vrUJGvHWErNOFD1cXnZJkBdpKpzQN
	 YkEykc/xElbVXdC1WqbhnqrmhL/1InbLaNUXz9RYRa8W9bNew5mgosbtKSWJvBg8LpVG7
	 OGdbnAa6XNeN+e/8j1lUbS7hfUXLUu0et4hHcziBBXQ6nE/JKiDD9soK6tm+g6Xh4yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781287;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=x+rWaWjWipGh7NmQPIVs/tMmoaLPlC27BnQBrHGgdCs=;
	b=R1gj2rhUTfns3pXTE5B73N44NSWO+nXH2jGVI4KhuzSQXecDhcrIu+hehZxzuriaC3Y5
	 d2Iqp6yg/9O2se667y7CWUIgajt8JcQpNaatjlEv3wOUD5kcsiPJ30iiXCItRveDL3osy
	 R/NrGIFv+xPgzPGtq11ftA7gzZdmDFtaPnmLbTGkLqtPJ+wIPkxiSa41sOkmQ4iZnQodh
	 pAlWPBJA2ZL2zSv4bCCv2dpsxnJithkMnsH0N7Q39TIha0pajaWjG/ct+QyaNT2tUlqGj
	 zNtSYucofr7Gne1iicRDjkaX9xXk9bGkt7KixeJwWF95DA4gK4gUkXRhUk5e1HpyjuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Ms6PysB/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F06606D80D
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39F06606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ms6PysB/
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48KeC51849241
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=x+rWaWjWipG
	h7NmQPIVs/tMmoaLPlC27BnQBrHGgdCs=; b=Ms6PysB/h+sSSxz8qSw+VNAhBjO
	wNIGy8Aw2BQvYWMNQGu95Ibjql630W2hdzEgF5ueMMYrQq+pdC7ZsBAPjldN53tv
	RFDxOP4OINhKIPKzsYhgEV0xNZ6YeaE6Bu8VvpXoepxA4Fcs/R54zqjtOJYjMdyi
	W3/uR1VT8HBtESoFk8jtfPDPfm3FrxLPvtNkPzImsOdOELGcjO89YAdomWcS2nTk
	11xcR/qR/88K6a1dUOF23i1Rc/nF34Q4Dv9GcE32cB2q/o1Bfu7IpLmAsFPzZ/FB
	uzLTqpfh9wos03LxLrFt4BBEFc4AhCR1qoaRSUThjmwJxT7bN+jQgEBZIGA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqkgpbfwu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48Ya2k2688037;
	Wed, 4 Nov 2026 08:34:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A48YaR72688017
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:36 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 782F3279BC; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 10/18] obexd: Parse application parameters in CONNECT request
Date: Wed,  4 Nov 2026 16:34:21 +0800
Message-Id: <20261104083429.4111632-11-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104083429.4111632-1-jinwang.li@oss.qualcomm.com>
References: <20261104083429.4111632-1-jinwang.li@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX9COJLwxHx00Z
 ZI78TEC7sA32xs1yLCCVzxiajB5K8QnLP+McLqK57WZRQzt0uzAb6MxFMF6noHXZ5i0fb3uiI8d
 94maioRnsYIOpEFg6ZpX42i5tjNzYoJsZNoE8BiZkt74vyd1DoKTQv9XilpCrYGyiTo1Hzp8nQv
 oq6X/DUex81lh4dIeuNteenCB0BcoJNQDcsslDp9LwzKspEGn/cV3XqO8pF1elR9QinnGb9+1Ip
 vgxs/+F0qLmOBDF0MJuYjLRr/WiAWGXrBByLnToejX1OiQbB77t7i9tFRQ0uJHxsR8Qb5zxzIAq
 zUIhjU1cND+yr4e1boGgtongYJGn2nIEGK91vV3yBLmrvg/C0OdoktPiwmTVOItiK/cfHzhjpyk
 ngOLuCQst71W+MhA+oeH1LNZ6+KimXafV9KlgCvI73o5YWpAZiczrRHsUW8XyJFNpAlNC+JQ0+H
 v+FlnumG5ee9j2AtkBQ==
X-Proofpoint-GUID: tWMeEtxLBFc5TLN2TDQCNL2Fe6sv6LJq
X-Authority-Analysis: v=2.4 cv=Yoya1IYX c=1 sm=1 tr=0 ts=6aeaee1e cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=XfG1ypK_2n-0LpLddPoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfXznLaf4+cLJfS
 RmJriG02wI1E4D88dn1qhUHGYJ/70GLy2fMtyKOW0ymyiFr2PdjBJ/LlEo2YEZ8AdpHnDVGwhHj
 94DR7+zVoZtg0v73dpq6yyH1zVP24x8=
X-Proofpoint-ORIG-GUID: tWMeEtxLBFc5TLN2TDQCNL2Fe6sv6LJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040033

Make the application parameters of a CONNECT request available to the
service plugins while the connection is being set up.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/src/obex.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index 370bfac9e..4d2c86b6a 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -254,6 +254,24 @@ probe:
 						who, who_size);
 }
 
+static void parse_apparam(struct obex_session *os, GObexPacket *req)
+{
+	GObexHeader *hdr;
+	const guint8 *apparam;
+	gsize len;
+
+	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_APPARAM);
+	if (hdr == NULL)
+		return;
+
+	if (!g_obex_header_get_bytes(hdr, &apparam, &len))
+		return;
+
+	os->apparam = util_memdup(apparam, len);
+	os->apparam_len = len;
+	DBG("APPARAM");
+}
+
 static void cmd_connect(GObex *obex, GObexPacket *req, void *user_data)
 {
 	struct obex_session *os = user_data;
@@ -275,7 +293,13 @@ static void cmd_connect(GObex *obex, GObexPacket *req, void *user_data)
 
 	DBG("Selected driver: %s", os->service->name);
 
+	parse_apparam(os, req);
+
 	os->service_data = os->service->connect(os, &err);
+	free(os->apparam);
+	os->apparam = NULL;
+	os->apparam_len = 0;
+
 	if (err < 0) {
 		os_set_response(os, err);
 		return;
@@ -582,24 +606,6 @@ static void parse_name(struct obex_session *os, GObexPacket *req)
 	DBG("NAME: %s", os->name);
 }
 
-static void parse_apparam(struct obex_session *os, GObexPacket *req)
-{
-	GObexHeader *hdr;
-	const guint8 *apparam;
-	gsize len;
-
-	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_APPARAM);
-	if (hdr == NULL)
-		return;
-
-	if (!g_obex_header_get_bytes(hdr, &apparam, &len))
-		return;
-
-	os->apparam = util_memdup(apparam, len);
-	os->apparam_len = len;
-	DBG("APPARAM");
-}
-
 static void cmd_get(GObex *obex, GObexPacket *req, gpointer user_data)
 {
 	struct obex_session *os = user_data;
-- 
2.34.1

