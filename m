Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820020;
	b=MTZ9QfNSKPYF/Py4DLWrD3HMUgPPk9lAZPKaamnDGUl19Kv0oELG+Ym5UCR4oBiJhSxK
	 5F642COQJAlHYcQ7dcdQ4GKvQL5YRRg9gxipbwGY0TyZZbNxMfQvPGq+nxWiRRoCZKtEv
	 YPzxr9w0VOriYNsGbQqKV+/XwzDYN6m43lBSrCM7gGa84q6juzWCgZn/5ibfb6uyGVrxj
	 FzTeHySEr7QoQH4ijE2pmjrlGYlXkCscOJngmCLqjjsywlfqzMy7UNo6yzwy4LkaGS0ai
	 heeAnf1gb5vExUygSzKT78fll5OWQ1hCgn1+WPOlhz/wzrqbcYRAZtwyzlcKOcnRsVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820020;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=x+rWaWjWipGh7NmQPIVs/tMmoaLPlC27BnQBrHGgdCs=;
	b=BWBtW/by0DZLzAuZ+m7IFAp6re+WusSzKbiMZZ0rqyjV7Z9QKHPqsV8pnH8iyjj6MRg0
	 rjxTfylhXJME/+xV4bkDO7oklyR4Y3foEjz8lbW3QnL4NqkvjYlNTB4+CyyNe8f8USw5I
	 mGba39bR81bhQrO2kOrlKSKuNKkuTxP36MEx8xB0XvB5boWvA3WZWlLi/lTJh3c766FMm
	 qvScFcRbjRZPcv9GbX77HuPCgRPfx8npOsTTl16PW3pM0iBflix8RHJrC+LZze62VU0UP
	 cUOjHOrO4dCG2aoQon3jaMS9HuLTfA6v9uVcdmmngTGBfueJSX+MXpJWMAikaqvFKzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z7GP3Wiz;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C296E606A888
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C296E606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z7GP3Wiz
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7es1K524913;
	Mon, 16 Nov 2026 09:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=x+rWaWjWipG
	h7NmQPIVs/tMmoaLPlC27BnQBrHGgdCs=; b=Z7GP3WizwYMdq3FC9bD2WYpqKdn
	svw6MqkQFYMUbDWFJKu51F44IZxIazkMn2jANtqoaZvPiFiAUPjTCg7bKgBwu4Cd
	tsrZakPymtxm+gQAKoqCcShrQ1BeAEuALgMOFFEeP3yDMpRGdz3dgVd5EXCxU9QD
	2KDaD0Rtk3Xh4fmxs2K9VaSSnWS0SPiQXp+qfhklsoWXDmXioUKRvYKkL2qHUICC
	01zljq1oTEvdjgDUwKGEh3pfzceAFRllC82+6LpxDS+lhLwrh+d8sBlrwJaSnFZj
	L38xeLYkwqXlJ/pRhDlw9C21VBcRCgOBf58mTBHh8YR6SNkaGdigvsWJjYA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqnstx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:58 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96tN52942815;
	Mon, 16 Nov 2026 09:06:56 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AG96tXJ2942784
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:55 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id AFBBE27A07; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 12/20] obexd: Parse application parameters in CONNECT request
Date: Mon, 16 Nov 2026 17:06:26 +0800
Message-Id: <20261116090634.1222593-13-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
References: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=KelHIgYD c=1 sm=1 tr=0 ts=6afac7b2 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=XfG1ypK_2n-0LpLddPoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfXwv+y5GwDDgTV
 B94zO5QM4Ob/NjGgkHQlv8i9OSF5Gy43YqsAr3TOvLNL57QjgRAAFqtFsRbzJj7kqKXgJOHtcoD
 xPAXo79oHlbpFixIg4zZzbEgMKi4e7A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX0uozV1kErkPx
 q+Y6ULIvpF/bpiH9Vf2AU1N+VRP7I1Pi3A1vr08y/k978KBI3q8T5eI5e3vH7EanDUoSjh4DSWT
 D1EgI1aP33ZBHwHTL/bP20kFjIEo+a/dD3zLolceHt7M7rfW3cAAnZ1TrIdsJqHR1LiCyerNcgH
 AeNZnbLtX2ETNlIjDWR2vLIQuRGhfPxOsu+XXc+iAA0HA2HoaT6YI8AHiyXaWHrLmgum/Q6Zhdg
 oVuaYbk+lxNHCZQm0pwq2FV0X2tcEDzgQtyN1wBPqmJEsH97PSFR2YyUdfve1mRUwTBE3GlqOE1
 0PIeGrfDWJk93WRA1WUeOfFkCUvXMh9nHqtvQ9BXxvXkhzzFWG8j/lIHfNixubJF+AKSyUxEpCS
 0rlkVrWM4Ii3FcLfbp1DjXoa6knghbss9Sjwn/dO1ES5trOz8QhVUAT0IQedxQ235YMafcxrUfR
 miW3ycEtaV1r7DN38Qw==
X-Proofpoint-GUID: RbjTdv9M_vvn2xhf7ezfBh3mA6d2j1Vm
X-Proofpoint-ORIG-GUID: RbjTdv9M_vvn2xhf7ezfBh3mA6d2j1Vm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036

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

