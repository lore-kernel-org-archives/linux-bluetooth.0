Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781279;
	b=qbAHxeKlf58zeCHwkBm7aykxUcWph34C99mntpDTTrPpyQIMe04HtJq777VyfBb8QTtC
	 r5MlHW6isQNRATd+UwWGhe1sQ+jrAP27HSF1+OWFaiTk1rSXbZ3eWHujqJZ6tU+Ndv4qy
	 8914X2ErOa99LnKz4qr7KRqcM8YGfnk3rw/GGtm6cx7uDEXfnkt057vmd/G0zACaIXlq2
	 tRqN/5p4rQg2Y5UWaCx1j9D4F3Abw+51MYp6FuNqwzGqH7mCC9/CdOBPaKCJBMav/wa03
	 K6YgPIpfoyp7bfeC5UHMvhrbLMuZjwmn0iTogNsNAchls//M5ZpwWy4fxCeWn2YQD0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FVm10lD8bz4fjxbklZqd/CfX5QG3n7JGE3wTCYa/vyU=;
	b=EDVX68CaPWYj4mTbXPhLWfL9PO/lxDGQ9IUa7jlvxvRlOPrK91ujeUq2Zyw7/20NnYZy
	 fwKTdZu7Ax0Q94mMTDZcuYCPqtJHIQtIgg3HD0zi/f4eS2oBihenNCEhF3xWo/sfIPlqr
	 BLT/vPUBe3SdmUMjtdz01590ZK5nquUG6pCbYo6zO9hWoGJqIYAwq7ptRFyLQZemah11g
	 aRAk+VT9dTEBJ7GJm0l/AwqJ9nMrktUXLC/UtS4i/AJr5XdWCUrnDDr43OGhFZABaJfg2
	 LvQ+vGGC0sQy8Kf2q5/EGwazikLbEGB8KOHSFk8WPONesNfyDmARqMy4JZVazP25UxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L21v3d9e;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575BF606A33F
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 575BF606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L21v3d9e
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48KiQj1229292
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FVm10lD8bz4
	fjxbklZqd/CfX5QG3n7JGE3wTCYa/vyU=; b=L21v3d9e8q6Pz1vPdZ1xSyw73m+
	voyNKH92MiatVPuLpG+Es5hUT/M94YX8VLWYtPDCTCPGhBgA1t9y2U0OD+spTLch
	UiVQP7DmYmJTqb8POQOuZx3E6u8IyqoLBl6BYXShyGkMXCBPbBH9fW9VWKVE20fE
	8jsBK4qVt3oMT0ZmzfLnzapQZDPjydROQOKEeSicnwEDTojvkjMKEPcL0VI+gjmu
	RQQLbn3Ik1LX2z2qtcVR8tB5yZimvt+U9/9HvbNydUOAP3H1YM3+205qqvFpdS2U
	NRY4aKnMz+pDXqxjWRb8VW+YJmTTpkURW2nNbXJTqoSQXHoRhuDfNJcU15Q==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8nju47-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48YZbO2687994
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A48YaNA2688018
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:36 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 6B327279B9; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 07/18] obexd/pbap: Limit NewMissedCalls to mch responses
Date: Wed,  4 Nov 2026 16:34:18 +0800
Message-Id: <20261104083429.4111632-8-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfXxI22s6drgoZU
 QndGWOjgksxhivnBJq3PMBd1msn1cefxz/uMmQIxtLrKUzczii9+1odziGRdW1LkeBKXngjzhdK
 tKx9F5M3+d0KzrdkUE0MCDkDokmDPPku8y1eQpe2hxZRtlE9CQWRNQQ1THnFbHfdtqDZ0JY8Htr
 PzQU93NlJFecfLE8hWGKZrDihxMs5gi4B/ECT0sOSwugYJBPaJwdfwtvhZatIOR3TdVDarhjjM+
 WOfqaq0lr3WmTwjfDg4tey4EMRFeiKv0RLn5vRHG/Ote3uhrF3CJdshYTE4sJgBrj14teQcS8tx
 yJ9aAmTLbeGH7IJpWg6DiFm2BDCV8qkpAtif3e8hxGKKj/nm2aDPXLSYzjPm6d+26quMj+k5Sqk
 mvJhXiUTOv4go/PwpGyM8eF49OBTr82xvV9F8mnzBgWbisY8XwaanysyyDBFWLc+lyu2CrB6MLE
 CrsvzrDDtwKCJURmVSQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX7rn5tEKxAIvU
 qbf3nWC3wzRn40yO4Jc8FN5Fhx1cACH+y9V/ChRHSuVafH3f5WiODYGqDFNl4gOHHd6l9xK/B/H
 U3XRALTvswGg3rP1VUlUjwkarye9A4U=
X-Proofpoint-GUID: ciUmYpabVvlm8C48zpx7wOqxvbdbPmOE
X-Proofpoint-ORIG-GUID: ciUmYpabVvlm8C48zpx7wOqxvbdbPmOE
X-Authority-Analysis: v=2.4 cv=As17T+9P c=1 sm=1 tr=0 ts=6aeaee1e cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=QQasEqQ8TEV5XbeRH2wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040033

Include NewMissedCalls only in mch responses and send it in the
first response packet.

Fixes: f82b81e01502 ("obexd: New NewMissedCalls added for phonebook_pull.")
Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c | 56 +++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 9176fc92a..e0d0cf1ab 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -77,6 +77,7 @@ struct pbap_session {
 struct pbap_object {
 	GString *buffer;
 	GObexApparam *apparam;
+	char *folder;
 	gboolean firstpacket;
 	gboolean lastpart;
 	struct pbap_session *session;
@@ -158,6 +159,22 @@ static void cache_clear(struct cache *cache)
 	cache->entries = NULL;
 }
 
+static void response_add_missed_calls(struct pbap_session *pbap, uint8_t missed)
+{
+	const char *folder = pbap->obj->folder;
+	gboolean include;
+
+	include = folder && g_str_has_suffix(folder, PB_CALLS_MISSED_FOLDER);
+
+	if (!include)
+		return;
+
+	DBG("missed %u", missed);
+
+	pbap->obj->apparam = g_obex_apparam_set_uint8(pbap->obj->apparam,
+						NEWMISSEDCALLS_TAG, missed);
+}
+
 static void phonebook_size_result(const char *buffer, size_t bufsize,
 					int vcards, uint8_t missed,
 					gboolean lastpart, void *user_data)
@@ -182,13 +199,7 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 
 	pbap->obj->firstpacket = TRUE;
 
-	if (missed > 0)	{
-		DBG("missed %d", missed);
-	}
-
-	pbap->obj->apparam = g_obex_apparam_set_uint8(pbap->obj->apparam,
-							NEWMISSEDCALLS_TAG,
-							missed);
+	response_add_missed_calls(pbap, missed);
 
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
@@ -197,6 +208,7 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 			uint8_t missed, gboolean lastpart, void *user_data)
 {
 	struct pbap_session *pbap = user_data;
+	gboolean first;
 
 	DBG("");
 
@@ -212,22 +224,22 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 		return;
 	}
 
-	if (!pbap->obj->buffer)
+	first = !pbap->obj->buffer;
+
+	if (first)
 		pbap->obj->buffer = g_string_new_len(buffer, bufsize);
 	else
 		pbap->obj->buffer = g_string_append_len(pbap->obj->buffer,
 							buffer,	bufsize);
 
-	if (missed > 0)	{
-		DBG("missed %d", missed);
+	/* Application parameters go in the first response packet only */
+	if (first) {
+		response_add_missed_calls(pbap, missed);
 
-		pbap->obj->firstpacket = TRUE;
+		if (pbap->obj->apparam)
+			pbap->obj->firstpacket = TRUE;
 	}
 
-	pbap->obj->apparam = g_obex_apparam_set_uint8(pbap->obj->apparam,
-							NEWMISSEDCALLS_TAG,
-							missed);
-
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
 
@@ -648,7 +660,7 @@ static const struct obex_service_driver pbap = {
 };
 
 static struct pbap_object *vobject_create(struct pbap_session *pbap,
-								void *request)
+						void *request, const char *path)
 {
 	struct pbap_object *obj;
 
@@ -657,6 +669,11 @@ static struct pbap_object *vobject_create(struct pbap_session *pbap,
 	pbap->obj = obj;
 	obj->request = request;
 
+	if (g_str_has_suffix(path, ".vcf"))
+		obj->folder = g_strndup(path, strlen(path) - 4);
+	else
+		obj->folder = g_strdup(path);
+
 	return obj;
 }
 
@@ -699,7 +716,7 @@ static void *vobject_pull_open(const char *name, int oflag, mode_t mode,
 	if (err)
 		*err = 0;
 
-	return vobject_create(pbap, request);
+	return vobject_create(pbap, request, name);
 
 fail:
 	if (err)
@@ -726,6 +743,7 @@ static int vobject_close(void *object)
 	if (obj->request)
 		phonebook_req_finalize(obj->request);
 
+	g_free(obj->folder);
 	g_free(obj);
 
 	return 0;
@@ -763,7 +781,7 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 	if (err)
 		*err = 0;
 
-	return vobject_create(pbap, request);
+	return vobject_create(pbap, request, name);
 
 fail:
 	if (err)
@@ -816,7 +834,7 @@ done:
 	if (err)
 		*err = 0;
 
-	return vobject_create(pbap, request);
+	return vobject_create(pbap, request, pbap->folder);
 
 fail:
 	if (err)
-- 
2.34.1

