Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781286;
	b=3BQNMmFyUTkvUlUL4MeKxVwAoGFqr0WUIdwYnhvfki/f+tnocxltvbMVbeX2fVwbXsNl
	 chi2QrHycMJwLq5q1vyWZPIRAqdy2rJscGUD5/z5jCrPOixWrmITiPYlSOuljFZl1dcrj
	 YToptcJ4G11SaFnZU6S+bT/eLiTM0bz8XkWN1T0ZNnp552PTEhY2XIRWgijzzFOFr3PUm
	 b/wo1FH4skHVI+J3gGJE58f5VCi5wza8b6tu57+b89d66tg+cXLwgWrRWpJoxT/yLJwFu
	 4v3DPAvt/+8jscaophppIq2T4UWOB8XWw4azkx05V1aWbYERKsnjRj2QnvaytW9B1hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781286;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IGu4b47bxxKd3GXX2AX2oFm/z+ayII5ERrexF485aBQ=;
	b=cN181wmvs94PU3LwxAq66YHLKiEd8rOkPYvobqpB+8ngi1UhCj70OrN7WkCLLWhtobnq
	 TJlpVWXNt2laWE3irmLz7AsoA7FAFNYT3yKKqZxgRCia95YeFjaqdJKOf/s00JxI/8/Sx
	 kxrn/X0AoZZM5Jc8huwkEpOv+dMBzPMxhiPty4fy/MzX0otKB1YmeuW2qssA1HJIlZ/bo
	 e7YSR5Gj/8Ek0KfZgoXuNzd7V15oiaLF8+w/Y1veOnwXNBKQPw1+4Kq5203WX1KUT8W+G
	 vl+OfCO1b0/jU8YOev49DQ4W4jvATYbqeI7kdWQXzprGAOMEkICQ5euXvAkI6utnaCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RM2qGMo9;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C9A606D811
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2C9A606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RM2qGMo9
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48KIYt918329
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IGu4b47bxxK
	d3GXX2AX2oFm/z+ayII5ERrexF485aBQ=; b=RM2qGMo92j/Y64ChsKhzmLczlXt
	3eEauyL1CAjtT5NXbvM4tsMU1LA0KgrZhj8uSTqFrt7HTWl+bv2GObcyqzTF2RtQ
	YGg3qXVj+HKolB2rEGiYViD1fAddAbToJHNg7de0ppZypCDSqwozpVCXib1kNWl8
	trPdt9V3sVxhF1ymYUxTaOVLLk0NMdzn5u8GIOQGN+cNSZfUUJY51/QizxeXST8S
	H44MIA+JYbk+y7e+/uCYkY4QUglFb1slwgy7HIcRfwNlzrE1bkFQLgYkW7kyA9NN
	A2RMT8AuQwbWF3w9GUjqU5vS9U4NhHAGrKmLbo91+bmJdxtS93Ph2HTNmtA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqvsg94q5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:39 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48YZSI2686402
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6A48YaVk2686435
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:36 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 74056279BB; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 09/18] obexd/pbap: Separate vCard entry response handling
Date: Wed,  4 Nov 2026 16:34:20 +0800
Message-Id: <20261104083429.4111632-10-jinwang.li@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=GtnXaU1C c=1 sm=1 tr=0 ts=6aeaee1f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=-kA4-gwvgZqZ59HjwO0A:9
X-Proofpoint-ORIG-GUID: cccxG7XWO7rq0d0xlPYo8NpGoZlMq_nD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX4v1c/hwzS5wR
 uKyMB0avhrEXLPMz8Mieh4pSVguADK1ygiOSrTVVuOrnp3KHySC0/d2mT3zPWPF9E7AMDIN7l0y
 W7cboludZb7e2suaoIVbL7KHIX9IuOKqY5RPzN35nVqJouQrgRZ3jBK3H9jGKoSAwHHI2LB+wsG
 bN4YdDy7haEK8A6A5Yarhb1M/+7rql6x4d7nYpZ89XijFDJ6SLLJc1oL++nRVc9CHmdy1O43Ux3
 W5ad6BaJh0iQ5IRTyMArtpxualgWgKlRivXbUvFbmv4BPBGCyI8+DbORM/ZS/llBbwdZWsBw40/
 WdRjKT3E1np/+4oWaETLSzwWenn1dGZo0Wevub4BAtMpslyOd1Uig7eDHXs5TQPGX7uy+N1RxFa
 IRwQtbKexbl1hZ1rbAAeqs15wmx8fg0U0B+pQx+VwWCOLp21iZaYBRirqsKQdD2yT3u7Ds8dm7J
 FrKd16v29Qe0YYv6Jwg==
X-Proofpoint-GUID: cccxG7XWO7rq0d0xlPYo8NpGoZlMq_nD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX344wTceRCz2m
 5lyGMtwBk7+X9SyOplFPoHVpRNd4NvIL9RvF5e2wUJExbYgfLVLyGNHowxchZpOntluKPuGP7zA
 euMwcTGKONckgnG1JG2/fLZAkkbj+qs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040033

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

