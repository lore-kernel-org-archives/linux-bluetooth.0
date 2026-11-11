Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390279;
	b=uYsr4zlvP3JArPPuo3aVWZeAMm0HPWqfHak9/XI2jXZl/aJQsCkHcJoMQVAXDJLzagb6
	 5R9aAqyNYlR8Ntpc1aJHA9oGXRp9FvuGwPxyctX67qEsgzcPwXc27DwobMLZYynNrsLFx
	 ELc2O/mpMG4gfQiylBH3xnSuq3xZv7qmXvmfZhXkrXNzxQliKM1lSow/MWPYFz0q+8bM7
	 RG0JvvjAftF8PvnJtahklDE9EMS+HwLbMydmePcadHxN8OVyPp1VV2+zjbC+rZsJCqi9J
	 Zi1EdUYtNX0THSZvwheL9L7Ch2cHM6zJHIVaUbqEKp5KKTd0WyyCiVETdbj+7+PCCgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FVm10lD8bz4fjxbklZqd/CfX5QG3n7JGE3wTCYa/vyU=;
	b=x73Y7fg1KpNVkz6pgDPSBAtL1SffCTJ0n0qb950vu8DCe+lTclDsRSHUpuZ+j1kFpU2j
	 uPJiriNmmK2cJsMVCSrwKiWx3DFrqrdzXQNganEapb+JSKDUWAGDek9jY5PEI6IoBV33A
	 r4KkEKznpcK1RjWUEcXyYJciWlGMismWQaE85LI01foAktX5IMeXbNu5OYXPhzhJRJnig
	 aXCKfeO/yNkPY9oBmdcYi7ByvKQKsc5a14p8IFRu7/1lrK1s/BSWQKrKEK7lV75HbUENc
	 cQMZfnZyXA2EDcNDB6BecDP762SbmACy1sMlqTr/Btb6LNuENs3sgDWMTLUzNmvDGXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h3cFOJgb;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2D606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD2D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h3cFOJgb
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KPsB864189;
	Wed, 11 Nov 2026 09:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FVm10lD8bz4
	fjxbklZqd/CfX5QG3n7JGE3wTCYa/vyU=; b=h3cFOJgbE+uXmuXPkk78l4Igz1N
	ZICHeAxW0Q54Yo024LI6HZqKQx8d85qg10ul7F5ET8xzJPmMZOsgiZL4JA9+bXMJ
	Id5WD//nZHwtANzSlfM+Cy0Lz7dtLBnH4hC0CaBJzLCFfq/zR8gEj2lEzhXyGtDp
	tN8uKKkteinXTyC95wJrH3By4MYOcz6omM5o954urblDbxmMUxKjfPTEJJSFeCxd
	uEOINa8PbihMHVF6f/GeY6AKixvXTHmVGumQ0FJMMEcWQVBmqtnqrL6Hf5bw1Dxj
	YqWI5cgFveVo03dr5pQsERaZJqLiyZgkQvjqVIftGrk8OJyGByBMqtVFrqg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawhjcw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iZ3h2424407;
	Wed, 11 Nov 2026 09:44:35 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AB9iZol2424365
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:35 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 4EB2D243CB; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 09/20] obexd/pbap: Limit NewMissedCalls to mch responses
Date: Wed, 11 Nov 2026 17:44:14 +0800
Message-Id: <20261111094425.1444893-10-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX99p3YUOFIDR+
 TCQrGu1UERq49dCRU4tBltuteZ3eDV39CTSEZmBePF1u9Xcnl56DO7mPDeztKpO7H5IaL15SyRN
 B+UTZ7hB0NtC28EHio8lTC3IYLHmbZ0=
X-Proofpoint-ORIG-GUID: zPZqdAWrq2-XBaS8jsUyoyxG8HRclBZp
X-Proofpoint-GUID: zPZqdAWrq2-XBaS8jsUyoyxG8HRclBZp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX1GXrXfOzlDM/
 2wm+3OzSqMJ4O9ZEwG4ic2cNopZ/7UwEB+Sf6Ct203rwDD1Rh74G5T+HiERWMQu1HxajSBWO+oz
 MamUf2kJaCGjqmxFEfb2NDv/OHpzgHMEpoIxnEP3Yk7fibD2E9y3hbZUI1QNsoCbg0rGzcM933O
 cC8uHVOu9Qr+5FhyaBr4LB42xjmDztQXs/YMOtSc9FLx4DBS2ksoZUzpjpkupOtVq1FkGHaTe1D
 9NjdkUq4n90Oy/RgktS/4BF6z6JnQsp6WnAXIVbxg0LxeO4YmYPeY3WIBYdn5ACh+o0oGzJAb9z
 /iU24XgVCQNRjFMeuEPkOZNd9x8draZHyyFOBQNdeEnG78eUSyw15dHAQoKblnDkYbHFUZbnt+d
 DlS3sBzViYtsXwikQs4rbV43XfGqpgGd2ZqG6kGiyU4niwqRybs4Eqd5hsRp2+CHeC2nrRDwcbU
 WRQT8kkAuaivF2xqxeQ==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af43905 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=QQasEqQ8TEV5XbeRH2wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

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

