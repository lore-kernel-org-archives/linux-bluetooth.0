Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820019;
	b=cR2B7y+dzWJASw8B8oDn7HfU0BeSoSSf5ibXr+weD9DIjQCvglW8lho5EhCdgWpIEFZp
	 QR8Ut9NPmw9eAABKyJPAvl29WrYz5QRI+zqJ7x0CerIBBRUysJdkUgOcP+N3FUKfLY7Ix
	 gEw7ntN3M/cGbs5etMOAPN10jrZ7BhAKyMZB69itzJa6fu2stqt9rl6RyziJ0DDIirv4K
	 APXS4EzhoEzFChnMlkASpOkCtgNfhNo/fTqQtpCfqSAIzTaNELtjvxQZ6CgyvBOLTE3K0
	 OoHmoR/pfUUqJvwayF6iaK2nL8cnm2LQ5O5B4Rs14XPnS+nXN34TXZnijwakX4ypVXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820019;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FVm10lD8bz4fjxbklZqd/CfX5QG3n7JGE3wTCYa/vyU=;
	b=iedaTjW95M6u7wgQMxmgUNR6AZijqNnNP3hb3LMmRw8FBh+Nxdq9uinXtv5mlrmQkNzm
	 bPW6WFmC6UrTAVWavnRC72SAcnIQHJFbI23mkRzR/6pmvzyl0Bp2X45dH0X/DuM0HsrAC
	 yH0rvV2fxSCP+XKq+AOG6ftQ8cQvJu0c0oik43gshmNOa/p+oel3U7vOygPjxFKpydLpw
	 WXxiAO+sdWDJjRgGIZzY4QC2dT0W5arEZ9TYWXwzj7NbdnIH0ZbpSxFMVwPt7PyqHAZDR
	 JyJcXt2wLKUovT8yVDDfeM1zr4S8uZRZG6v+QjpexZXuCVVtSZG1ugOOqDtdnyLI5FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eiGKRAfE;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE7A606A331
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AE7A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eiGKRAfE
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7enTk1109776;
	Mon, 16 Nov 2026 09:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FVm10lD8bz4
	fjxbklZqd/CfX5QG3n7JGE3wTCYa/vyU=; b=eiGKRAfEwBPmUA8EPZ+AkGeLlFg
	dE7aJ/h5aKwHWn/0FeRZvGncvt8OR6m2xTHOklVHRSb/6VafF9SmQWVbLFdPd9fy
	BLnxRRWX+W7nHIITvWHZkSCBEbwmK+P49KdDE5SmOBtlSrFiLYpDlTIDRzayyVSx
	AXPMnp4MFfuKXnF4xCyDGOpcsHTm03b/2QNYT9g5UmLpVR7qxUjCtmPb75WuXGWA
	GoZ42870+DNPQlXwW+GMQ/ozTs4Oa4dClWNCe50U5s17GduXbiDwp4qaUTnuzpM7
	fcGfZcSrSIPltIpWSZTrPthnulzoEwCcFMK+5jQpI97px8TSFutUG766wsw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyrmc1d7p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:57 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96tgq2942878;
	Mon, 16 Nov 2026 09:06:56 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AG96tNx2942846
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:55 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id A340E27A04; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 09/20] obexd/pbap: Limit NewMissedCalls to mch responses
Date: Mon, 16 Nov 2026 17:06:23 +0800
Message-Id: <20261116090634.1222593-10-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX+m7Ja9Q4S1yV
 qh2S2wEJlFa2iYWSUxAjThzFkLLTznHJfpqFUJOPfFm/rEm414x6WMnjHO/nzv1eyfCJ8AwPQeU
 80xGo2ZxpRH84xLg5qa7TLrkR1ITNj8=
X-Authority-Analysis: v=2.4 cv=C9N8WgP+ c=1 sm=1 tr=0 ts=6afac7b1 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=QQasEqQ8TEV5XbeRH2wA:9
X-Proofpoint-ORIG-GUID: fA1TBsPxrqQdmYBkyHutkBdI5Q5-VWdx
X-Proofpoint-GUID: fA1TBsPxrqQdmYBkyHutkBdI5Q5-VWdx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfXwTLKGJ1G7+VW
 gvyP+f67bzU/ifhBl8zjaoMrO1ImO8yDOvpP2noup3vaOT3e6lq8D2pvcgkjBme6q6O6SdCRAww
 n8Fjixe/ov2S/B6p5dS1N2tYaq8vwPHJYylNPXgTkKIEc0U92o35dfx3hk+ZfzUYhrKrBjocoVC
 3XqRLUZEZCCwkcWWh8nRmf+/ZggitOFstAdhJt6Cpsl4rZeigMJXaVdZlqaoaLwiGonmZCUeXbJ
 powZPPidpf8lIP0zgILzQWukS5Dt5H+TP8xmJltBRp6ezWU3Bz+cHo2829Ie8IXf2N+isTLPgsN
 xcQqw1KV7C0HRWfe5Cb1qVZpfCwcR6NFf1ZESs2eNXGXXRD1o9k1ZwsUbiO2vbV3C14R8p3vlUt
 /Ze2WvxEznVczQSwWZrpLLk4I0ToekBVsiLmIuQptwrlDqL/CvqK89SjB4WaZGxr2UyUM04RZjU
 9mzUYRHThoQr08mbcjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160036

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

