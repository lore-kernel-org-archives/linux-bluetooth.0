Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390280;
	b=SwO/KWj/r0MyGTlXGE9XGpglLsTRjkoHZfbYvv15q9Osj0WjVr5CUnIumTbYtTHV1GvC
	 CBN8cj58yrvig5yl7N26Mx0q6cEQtBUzv3jFqMGCqDRHjL/yPl7/fItbVbsxF2ygNomgz
	 PSyvV7YHCusWgzseg5btf1fJHJ2QgauG6tN0G/a6N3FLXCblapG/e1wGtzQyCPlfzXIrZ
	 p/BailfnYUFUkuPcqXVdNLUARSipU7SLMnAYMnJ2MxzWnyCGa4ccF+CBfOqITfWtkAHXX
	 2PUuOM2pU+d4l9pMG7L14DAuVQ0k1eXMrmmohseRcAiDUUdQNrJ8rP1ehRzMXLIKtQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390280;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=IGu4b47bxxKd3GXX2AX2oFm/z+ayII5ERrexF485aBQ=;
	b=DtgiA7c3cE6Du48KDJCA+RgGMHu9JVldDoaydNrN/U9H29YcEdXgDBggza9Wn00IG+Ex
	 fLzsnjVAh4nAXIeD2byVQ9hh2IG++wP4jk0jVMcJQwGL5azYsaBXOjCspmMQp9DXGFKHL
	 6NhqGDbUyKk8yFZfzP6bQJZc7oGbudSxYL3TObs0Is99yr2buXgyjc3/upL7RyUah76Xs
	 sH5Aqvr+ghHj4Wks9N34l+zxFyFqBiauBXdYWpmmwpB+TtkoJ5Jr5hrA0w4oYI+0/2S5B
	 RrdEsREcLSaAt7M9IRvUd4ky+yX3RsswI3t51WyyBYBnTjEwADYfRT64Z/1p/7GqbYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fc9t1EOF;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77935606A33A
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77935606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fc9t1EOF
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5Kx5s1052694;
	Wed, 11 Nov 2026 09:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IGu4b47bxxK
	d3GXX2AX2oFm/z+ayII5ERrexF485aBQ=; b=fc9t1EOFhIPmiVevYcZxU1X1FY+
	mI2yRxN5m4APwo3jhD3eDX5B8maa15e+t60+th3tyagzsaHIbKtRQODZfMYA7MIE
	pSGyAWL0ndJYphu4BO0D0yx1m4TKzhuCoxSm9u2t23F8raTmIRHGlGLagCG3Wht1
	z2xyVOe6mOSQUS5ifDFALuVe2A0Yw5bLUF3qtH1dyKsSheKhDVZ6XIqKXPuJ5L11
	Iq4RCaZ830pN9BvvRztUOf/Q6aUadfR3l30sFoRSVTPQFKVLmBg6mWawdbN58mt8
	SZm4+3F0fi4UPNIGvde5/DcB5OD8icFn/HmspDaKaA2RJV8x7amzlzDUlgQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdrh1xm3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iYpM2424154;
	Wed, 11 Nov 2026 09:44:35 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AB9iZfx2424173
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:35 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 56AB9243CD; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 11/20] obexd/pbap: Separate vCard entry response handling
Date: Wed, 11 Nov 2026 17:44:16 +0800
Message-Id: <20261111094425.1444893-12-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX60oonWiMOYSK
 IAWMUUq0UdbYAd8CGgvptLGB3RB1Esak8uUqoQgDv82zCky8ldOLBZYKBUaVR8cpl3Ywas4o1xc
 Dii1dXl7s1RaSDyZGe4lf+6HwZuZ1lk=
X-Authority-Analysis: v=2.4 cv=PoQG/AM3 c=1 sm=1 tr=0 ts=6af43906 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=-kA4-gwvgZqZ59HjwO0A:9
X-Proofpoint-GUID: 3P1clhqxo2duQwXIUC4UbYYVFOMwrA1P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX+J4mKzLeb/ge
 vjmH8wdffu2o8rU1e5sjkTK6EWOKuZhZKV/o5XbJAktVFthkocq0RpWObEDjMzunau2Cx341wRf
 8ckuC3TlQ455v1P1MrOToBagNOGuYs2yv5riySEFq21nxsKaw58f+biYA5aTRhCaFL/A37dIRzw
 yC0IpjKEfs5a23cACdLC6cmmV0e/GJwpyNUCfBgKQ+e+WeMPCeIHQ2Oi/k7tkLPGA0rjh/pWA7J
 BKm6xdbHAcr8SNv0gb/tTnYRwL9PQbFbETpyCuUw3fFHy6zML5AGP3qUX3zHCSi8YtbBDuyKggR
 EvFbZHc+DLXt5s5NXZv8IGWkRIr3T37fUSp/atn52GwVLZ0jLoopQVAD/EoEx1+MfK4+BhFvw6J
 ZpeGA4H9k6tSIqbDGhSEugAGSAYRAsm90PAtAXVhh7u8n8ijGOpSCOOAdScs60h1AVKqW4PYRQ3
 q77N4xXqbQW+QVVi2Jg==
X-Proofpoint-ORIG-GUID: 3P1clhqxo2duQwXIUC4UbYYVFOMwrA1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110038

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

