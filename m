Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781279;
	b=5gZUNbX9YYaZK8hHJcwHekcm193qsOQFAnWNrZvzU58fEdaMA1zH7xw+YqkM+FIDXIQD
	 +b/SgQkLPLUeHpte7URlOnBWNAW5aDk0cpsx6sGsnN2PvC2A8VXH86tpbf+BkdiBsc+1T
	 53169S8PgS5+JSbkm9kN4xdK+BXFSfIxyAIUj/FMYXbAI+JCXkGZUfEOEEmxngTeA+5qq
	 sBhLXeeFvBV4swAV+fsyF/10bvs9XkSKNiJggkdTmvxKlM6IinDQk8pXVUzhP/uKr+e+k
	 IrkUToTS7cmTPlO4WDnyvF9XWgHOvsqBvqmFUL7AafjWsf6p/bUuuBypbRL5XwQArQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sa/nBZbLaVvfVdOspOPbxC74pQg9iBW59WbSpO/KrpM=;
	b=vJERrGFv5/rot0kCBdeZr2Z9igiDmPA35fQmbPd0540LKvmmhNlO2U5mchjKUdJfOQiz
	 ZiO8cx+m1OjNYZF4jn/lvimKPdXLEUt1ZHjjzeJNmZYJoX13Kj7stidYzhfd2MeCGS1aL
	 jbFxmvj67B2Nwuz45B085FatrdkdbdD9Lc4AFUm30kJMeltf9K3rSnLcF/o6h5rzpROP6
	 a20YdmOosBKCCBXw9+PqENE96ok9XIT4JuIl751y1Ovs9MB7X26Py8FF1O6DoCkDPXw7A
	 3T1QoJefCKZI+m27NFmJ1rxuPPnLHZBBquRQVtN4NxZjpBhtKcG4FBateS9X2vaMEOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bR5ARris;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EFC606A33C
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27EFC606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bR5ARris
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48KsAH715346
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sa/nBZbLaVv
	fVdOspOPbxC74pQg9iBW59WbSpO/KrpM=; b=bR5ARrisqaspwUnfUrhSBTsnGWH
	3Ot8JuckR+/pAn6kOit5TZ8dqpgvLZcgiiGDJlzRbwrwEXmvFcBffJZv2JwfCAAZ
	EhMWI2WFi77Ukh9bVLUh4TjURn59qGOHW8V8HZGxUhyLO7A7jSFjTwijXte07ege
	oz0R8H9nMozLcDdHRo7FfeUSXxyCvcXDe83q+7YSMltlYl9W4BlMojf5aOuP5KmS
	1crPZD8IiM+IrRkGaVuLT9zkvp6qUwEW3z9L5/C5OgrfSL0CghdFJtIlN2A4eeTw
	pzOeW/WTZbFYiI0MJ67DiYLbi+ZGaCr4WaEyHcmQK6RX8AwXUfEI/QmV82g==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8y2skk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48YarG2688035;
	Wed, 4 Nov 2026 08:34:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A48YaXh2688016
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:36 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 7C546279BD; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 11/18] obexd/pbap: Parse PbapSupportedFeatures in connect request
Date: Wed,  4 Nov 2026 16:34:22 +0800
Message-Id: <20261104083429.4111632-12-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-GUID: 1YmHyxTpkYwIzg0fYx5o6PgJKE56iBCO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX64EODV+b5ehY
 184y78xAaCBPnEpcLB227bX005f98uoG/JbjwdqHY2KVzePARnhmJ9e7paDDzgYb3rC5EOCRzcF
 +aPndahtjf1s+f8sI6gdjUnOKd5pA9HQtlaiaYAvgyKoWRm9Ahxetl87QxukX7OJ96eCQP5AAUO
 uO5EXysB9Yu3rNY+VKs9ymIZteDuctg21fHOje1t5DF9efauxpsInue/Kr3spTDgUySlztuED1i
 EwldHbIbmByw4OFkyEnT0p3rQz6yGI3Co0fWv6zpuABTgnOQm7lmPBykoHIbQTqujKdMCyoYxCx
 SOcsmbvEnZwBEW8cHuww7Ff/KztjcUaslG+dK0NeRr8/1N/vBz/HnS12yRJTq6SLlbezIqB+xj8
 6GlFS3qVkkgom/NXuC/sAtQxcjPNBnXHv8zHdVF6ke/Y9Dns+bgaoYb2z/t/D3QXE9tN/JW/GXC
 /jFStCPDSaXCB6pgoPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX9tpDcFnLfn+R
 Gj0iyLHbc88X8nPJK8aDSLPbCzebpnCqVze+aRnvmHBaJvKvOYjvo5pbp++g8dPcChVTr0xNgF5
 /vVtJ8oD0g+E1GuWxmk+XazixGwymI4=
X-Proofpoint-ORIG-GUID: 1YmHyxTpkYwIzg0fYx5o6PgJKE56iBCO
X-Authority-Analysis: v=2.4 cv=NP5AaE6g c=1 sm=1 tr=0 ts=6aeaee1e cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=_H_TX8z6i7KVAPa1vQQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040034

Parse the PbapSupportedFeatures tag of the CONNECT request, combine it
with the features supported by the PSE and store the result in the
session.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c | 47 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 83256c98c..92794b968 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -42,15 +42,22 @@
 #define VCARDLISTING_TYPE	"x-bt/vcard-listing"
 #define VCARDENTRY_TYPE		"x-bt/vcard"
 
-#define ORDER_TAG		0x01
-#define SEARCHVALUE_TAG		0x02
-#define SEARCHATTRIB_TAG	0x03
-#define MAXLISTCOUNT_TAG	0x04
-#define LISTSTARTOFFSET_TAG	0x05
-#define FILTER_TAG		0x06
-#define FORMAT_TAG		0X07
-#define PHONEBOOKSIZE_TAG	0X08
-#define NEWMISSEDCALLS_TAG	0X09
+#define ORDER_TAG			0x01
+#define SEARCHVALUE_TAG			0x02
+#define SEARCHATTRIB_TAG		0x03
+#define MAXLISTCOUNT_TAG		0x04
+#define LISTSTARTOFFSET_TAG		0x05
+#define FILTER_TAG			0x06
+#define FORMAT_TAG			0x07
+#define PHONEBOOKSIZE_TAG		0x08
+#define NEWMISSEDCALLS_TAG		0x09
+#define SUPPORTED_FEATURES_TAG		0x10
+
+#define DOWNLOAD_FEATURE	0x00000001
+#define BROWSE_FEATURE		0x00000002
+
+#define PSE_SUPPORTED_FEATURES \
+	(DOWNLOAD_FEATURE | BROWSE_FEATURE)
 
 struct cache {
 	gboolean valid;
@@ -72,6 +79,7 @@ struct pbap_session {
 	uint32_t find_handle;
 	struct cache cache;
 	struct pbap_object *obj;
+	uint32_t negotiated_features;
 };
 
 struct pbap_object {
@@ -513,6 +521,10 @@ static struct apparam_field *parse_aparam(const uint8_t *buffer, uint32_t hlen)
 static void *pbap_connect(struct obex_session *os, int *err)
 {
 	struct pbap_session *pbap;
+	const uint8_t *buffer;
+	GObexApparam *apparam;
+	uint32_t pce_features;
+	ssize_t rsize;
 
 	manager_register_session(os);
 
@@ -520,6 +532,23 @@ static void *pbap_connect(struct obex_session *os, int *err)
 	pbap->folder = g_strdup("/");
 	pbap->find_handle = PHONEBOOK_INVALID_HANDLE;
 
+	rsize = obex_get_apparam(os, &buffer);
+	pce_features = DOWNLOAD_FEATURE | BROWSE_FEATURE;
+
+	if (rsize > 0) {
+		apparam = g_obex_apparam_decode(buffer, rsize);
+		if (apparam) {
+			g_obex_apparam_get_uint32(apparam,
+						SUPPORTED_FEATURES_TAG,
+						&pce_features);
+			g_obex_apparam_free(apparam);
+		}
+	}
+
+	pbap->negotiated_features = PSE_SUPPORTED_FEATURES & pce_features;
+
+	DBG("negotiated features 0x%08x", pbap->negotiated_features);
+
 	if (err)
 		*err = 0;
 
-- 
2.34.1

