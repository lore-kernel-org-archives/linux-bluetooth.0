Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820019;
	b=zGi7tB0kTMLtX+jAdJH91NX6Rl/NJXZHkdgV5kaqWD0EtP1xmfCMFIyjWUqSsxZ+634l
	 JzS9+7Xzbz5Un65jlIoCiMfafaWQa+A2EAKAbD0lr2xu7UBg4/eJkeNVLOh8YsMW6QnMX
	 iOjNP8rxiJcqwFagUD/NZmUw7TgC4fcN04ukwDdmtFEDzW5FmWJYmUK5qEAANxf1zAa3e
	 /qOR39WyX8aEvOLXgGcDxG78FNVchCsWhya2WNn8DCkcLhV5WTHFCeQ0Gxof7Yd9cWB5m
	 1k4MdvfTFR+vgPlUTrApJSZGt16Gb7ZSIwfTMIRlW1G+VZBmXUn2K22qNibkAo+cp5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820019;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=IGu4b47bxxKd3GXX2AX2oFm/z+ayII5ERrexF485aBQ=;
	b=NjRHaVKnybjypr59F3eT3e0StTUQxL0/rp8USIdaH8XI66KqToSu8002IPW9U0wmH0hT
	 zpiwdF0XGOl/G5GIMK3jW5VSynPRXuTvS9P1LmZS58BCrpI+PYnIyQgJphz6nW0IwfnkL
	 tQTmBl4ffbuy/vfs4S8L/5lTvpiNMlQAZnomptQF1kSS+bTHqTE7LHoJjR30RwkW04XHH
	 FQ0jpTSq5secasLz4XuTAwHIHb8/6Ie+Pg3V4LYS+/qaDklt0YoqpdKwwVyf3XAmvrdFM
	 Yp4lajsOiKs0orZ4Z7DIHnxIs6pR4ZXc79W4zajI6xGVW8hlMKQmTQUCEbMsI1Wsd6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=evnHqB+M;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A1606A339
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C94A1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=evnHqB+M
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7f0ff424040;
	Mon, 16 Nov 2026 09:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IGu4b47bxxK
	d3GXX2AX2oFm/z+ayII5ERrexF485aBQ=; b=evnHqB+MivUl3VABjJ7YMYREe9x
	ca0w8oBEeSgEHd1CUkMtETB7mfo4BGSVxbq46vWAEjuDNWI/V1pAJvwTGA9Hp60G
	85upPZVSmNZ8ebXtppgwVVilc7kyYnbny9RtC4SDyuLd2z+VWSFZA5OtmOJ/zjz+
	d7ZMCM1GbQAqBvVp75UoNKUy/kEfHpnAUvubekPLiz3nn7kWRqwafOHanQfpwdHG
	1QnTaCNM6V2fkUd6J9n/PDc8vVCEGtq2PB5P0t2uAX9y1vm0XZAe/TGu0LRDL+SI
	VHiG3bWe9NTcUyvPjcuT8RoZqMt3colOQlJNsHvKf3TtqFDQaiGtCV0NWNw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhkwdn4v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:57 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96twF2942812;
	Mon, 16 Nov 2026 09:06:56 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AG96toq2942783
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:55 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id AB9EF27A06; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 11/20] obexd/pbap: Separate vCard entry response handling
Date: Mon, 16 Nov 2026 17:06:25 +0800
Message-Id: <20261116090634.1222593-12-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX6P7kgU2Ut3RU
 AQ+627o8+Gdb9uC5Y9vHIjZzzfdmkV4+DfIZWyD0XVHYymNezk2LTs9RUSscUUCH2wd0bIGHg3p
 kGfYih+GuN06GDiOVO5N+OWxwqSPN5Es2ysueWc+f+3w+omosiIOm7BDhhEhQVFF5iaRud/0umO
 NH7t/xmyxBO/esb6Nygv4gJpPanJfvnuecRcOXBnI/JYiySdw/19F73jpS9ELiWd8LHNDtrRxR4
 r8fa6Mzij7z0wtt9y83V9Ja2SwIfmuvNYiNEVRYqYXElFCX0neYuyhEROkI8xKvLrN0nTy0R2cp
 Gkigv3NwSPGCWhGAWX9j6zx9fjEoBfOHsXn+NtYv0N+TROhWX1hg2vCQUQ4Go8FkJiw813NXB4I
 ihIDiwmUobpMZQFnZjN6nFKWzrEY8s6dVapGePPbvuTjyZRTLjlietTEaug7syJ++VVyqXtThLk
 MWVyLWSYhR2hadKmKfQ==
X-Authority-Analysis: v=2.4 cv=YPYKWhGx c=1 sm=1 tr=0 ts=6afac7b1 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=-kA4-gwvgZqZ59HjwO0A:9
X-Proofpoint-GUID: 3yqXAwISnUyiNBoWYsEXfUfUcVc7nfWS
X-Proofpoint-ORIG-GUID: 3yqXAwISnUyiNBoWYsEXfUfUcVc7nfWS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX+l7g+PlPNapo
 EmhuWwBm1dBjWuEcVZE2sWkCTLydVhBxK7x7NTyUepkEpF8rxSCvNuGLA6ufvFZ7eHW67HIEzFj
 s9nemdkHdB4KbcHSx+gMStdLT3wZHNM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036

Separate the vCard entry response callback from phonebook responses
and share buffer handling between them.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 02664e538..83256c98c 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -204,14 +204,12 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
 
-static void query_result(const char *buffer, size_t bufsize, int vcards,
-			uint8_t missed, gboolean lastpart, void *user_data)
+/* Returns -1 on error, otherwise whether this is the first packet. */
+static int vobject_append(struct pbap_session *pbap, const char *buffer,
+			size_t bufsize, int vcards, gboolean lastpart)
 {
-	struct pbap_session *pbap = user_data;
 	gboolean first;
 
-	DBG("");
-
 	if (pbap->obj->request && lastpart) {
 		phonebook_req_finalize(pbap->obj->request);
 		pbap->obj->request = NULL;
@@ -221,7 +219,7 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 
 	if (vcards < 0) {
 		obex_object_set_io_flags(pbap->obj, G_IO_ERR, -ENOENT);
-		return;
+		return -1;
 	}
 
 	first = !pbap->obj->buffer;
@@ -232,6 +230,21 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 		pbap->obj->buffer = g_string_append_len(pbap->obj->buffer,
 							buffer,	bufsize);
 
+	return first;
+}
+
+static void query_result(const char *buffer, size_t bufsize, int vcards,
+			uint8_t missed, gboolean lastpart, void *user_data)
+{
+	struct pbap_session *pbap = user_data;
+	int first;
+
+	DBG("");
+
+	first = vobject_append(pbap, buffer, bufsize, vcards, lastpart);
+	if (first < 0)
+		return;
+
 	/* Application parameters go in the first response packet only */
 	if (first) {
 		response_add_missed_calls(pbap, missed);
@@ -243,6 +256,19 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
 
+static void vcard_result(const char *buffer, size_t bufsize, int vcards,
+			uint8_t missed, gboolean lastpart, void *user_data)
+{
+	struct pbap_session *pbap = user_data;
+	int first;
+
+	first = vobject_append(pbap, buffer, bufsize, vcards, lastpart);
+	if (first < 0)
+		return;
+
+	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
+}
+
 static void cache_entry_notify(const char *id, uint32_t handle,
 					const char *name, const char *sound,
 					const char *tel, void *user_data)
@@ -442,7 +468,7 @@ static void cache_entry_done(uint8_t missed, void *user_data)
 
 	phonebook_req_finalize(pbap->obj->request);
 	pbap->obj->request = phonebook_get_entry(pbap->folder, id,
-				pbap->params, query_result, pbap, &ret);
+				pbap->params, vcard_result, pbap, &ret);
 	if (ret < 0)
 		obex_object_set_io_flags(pbap->obj, G_IO_ERR, ret);
 }
@@ -829,7 +855,7 @@ static void *vobject_vcard_open(const char *name, int oflag, mode_t mode,
 	}
 
 	request = phonebook_get_entry(pbap->folder, id, pbap->params,
-						query_result, pbap, &ret);
+						vcard_result, pbap, &ret);
 
 done:
 	if (ret < 0)
-- 
2.34.1

