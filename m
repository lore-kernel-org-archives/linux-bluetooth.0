Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390279;
	b=vewNEv3TEeClMH0gz+Js1n+W1TeR+rIi3yUKogk0xN2bcpvSKDS9iaIr5CUxPSK4qPOa
	 bkpAtmHJIUEW5M/nGRI/8LItpbmVpLmy1n/sgyf61zx5MWmKILqLcfrhgBbj03Yz1EQ18
	 yp/FaL9SKFjcL1oOjvkWyE/djhJSuBBgfiw+p8tX4PNsiqA+SnSZnIKMd6hN/4jbv/DOQ
	 OPlie3nneTHNNsZzpTiY5Il98XteDxLBOSbZOPbiGqBzSeCgyzy7ANGdYv+BffPCQBbWp
	 mUP621UhkzJ6tbRXBtmjAoPTlt6u2AD1UM8GBuT2bjNONw4aO/S+239EqpukWIJFmnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=x+rWaWjWipGh7NmQPIVs/tMmoaLPlC27BnQBrHGgdCs=;
	b=rNL6hLudz3dFKCCYEV8txzsDgL1BRA7CWcjuemWckT3Hxgf38maO1hmxrcKuFe6YLmAL
	 EL8w4570IDNmbUcRm4F8IfK94iAjO3qtmQtWIkqFMh6EQImVWack5Ww5dSz7A14/LYoM0
	 daUHm69tqF2YWbP6CQ9vKg48XWOF/4+Nz5LuGhIx3/0WhdF3LgAO1M+mamQdNHF5Ulb6N
	 LBHT5jO5vPOZ+K5Unw+fb+k7ZqzcdyvhE+hs+uslGcssRTWEiuj32UE0Yvju9ORHjN6+K
	 +3VfFk1JHKxvZMdIA+rRDar0G1ITnLDDOgAxQ4CbGk9qg+VPK9Bgbhio8CSf/S2/XVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BG0LZbxJ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9D606A32D
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1B9D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BG0LZbxJ
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KKTO1386397;
	Wed, 11 Nov 2026 09:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=x+rWaWjWipG
	h7NmQPIVs/tMmoaLPlC27BnQBrHGgdCs=; b=BG0LZbxJeDqsHl9hhdV/ev84Qiu
	3Y+jcSOixYxkgxbh3T9bsPZNwTVPWl1lweIJj+SsMul2M232+VRFk8AzTR90k6Ih
	bu4yWU6/kHzaQspxO9I9c0cwSt0Ot4mZCCy5GYKMr7/d4mtuW3JQngE4Y52xv4/g
	vE8QivUcT1ZsDAxu++rEn+uZLvKZHJeiSibEl+RNGyloGa8n8yFjWNPcjHXrAsn1
	XkNXmN8moogzpf7lrSIKw5zVVC3S0oBPeJycGl1wLveK3q3u0B2ZDVNW5PoKJ5yn
	T2L3sSyzBsLZfOVMfO5JNKKJ8wwN6uGLAVA73SKf4QSEbEEgmzJW3lEdLrg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnm9xe5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iZQQ2424216;
	Wed, 11 Nov 2026 09:44:35 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AB9iZnK2424175
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:35 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 5AFCF243D2; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 12/20] obexd: Parse application parameters in CONNECT request
Date: Wed, 11 Nov 2026 17:44:17 +0800
Message-Id: <20261111094425.1444893-13-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111094425.1444893-1-jinwang.li@oss.qualcomm.com>
References: <20261111094425.1444893-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 4_1-rEk7c_6QP7LTJc_V4G7rLPx230K3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX2F7Mj+TCTLxs
 6Op5eoc5NwJ9751OtqBZ8aYNQvhhAUs09OpOcrPOSTvhqm4wkfXXiX4Fb+HhgxIrSrqkPRNkJ+E
 f0sJpvDQL8nOR3HUo2Tejx0aYmwxOGo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX3kO3YS7cYuO9
 LyXsO5GkrInkoSjCwgTdyTrLVnmT49MNGVegKiicG+lzFV9z1aYxsdWL5TvvzlboeY+yOYq0FS8
 CQyp/DtZ1B9Dtl8N6crtPODlfQefBlcouWQ1muJYRXB8b338Ew68YaDME/Yg3teSqKvZKZOsToH
 7eKe3ObvWrJ0xysDogtTsHv/S/WzxzzWV6ywMVTR0mdlLs4U87AHwM2Ym9n9JG81jPS553i/WOW
 EI6LwB6Oc5UjHJGgrG5INNahs5zMlrfxA5yN7f7bD5yr/pkImnhuiRbRywzP5eJ6/R4EkJja0pS
 It6uhl9eLRWRubt2rRHI8KvWVflXhiy0TCqw75ziKU2UaOpsell7T3mbTUXY6kW/V44qVgSsjYG
 sMzi+HFjQjIO3OXJPNm1oA0b+Kt1vHc2Mj7CDO47PiHcrYC+wjM7/3rsC06LfvrY0E9s5Qi4bMx
 r8GHlXsSJvdEtQpwNKg==
X-Proofpoint-GUID: 4_1-rEk7c_6QP7LTJc_V4G7rLPx230K3
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af43905 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=XfG1ypK_2n-0LpLddPoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

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

