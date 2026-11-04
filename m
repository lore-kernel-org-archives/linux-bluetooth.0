Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781290;
	b=mHuWsg2ACv3Tl4sj9ecaYrxONXqne/BF2nUSjo/HtYbEQdWppJ+LnFBlSvmza/3rqleW
	 HT7ErA/nTjFKodg+XF5lyCF0m6zBd21s4UGjLKOCLvjG3NMjrnIyI3sJg1/HzBcwfSxwY
	 laefRQlTd5I98CDb+kEh5Cf+3KRoDmuqA/OUZ/4K5Um3V39t2eOdCydidork2qVU+f+Hp
	 qQeCYCBfzkik01kg+EFGAjonNs0d7F6SUZjV+BPteLM2452EU6dOUKfAquF25Gwts1wbq
	 WWcIBHfjWNIOd4ue9EOwYjaaTgZch656GjdmnqRypBx+Lp5DMQ+2gIb0pejKSj9UalQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781290;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=c8m15C0J/jyukNOtDNai+sXZ9RrYYX32aHR0sKoxqUc=;
	b=xQIOCoh7csEEMtAjq1AhtL+bnG7Xjrp0UIt+BRXnk4XRNIVO9Tt+Ynbk5eH6rO+SB4hu
	 tuUwpgTTyeb1P7TEbaAGeAdWEOC5wnSf927ZwwR86dgu/DLh3nsOhz/zN9W1A2a5e6Bq6
	 dHZO2bEVWN0/om+/BNdh2pz92bDT+EOqH1pI4D9ZYSPcT84IsswoFlRiZuDCIQILrlzV8
	 nGp77hOjbyIX6lWxUe0zP9p1YUjjKvVp/XbPV5HexBlJJc8ds754EVurKMIjxSM9MGpCn
	 DoPjUQ4YAMyY/Z/n3v9KNd15GIKDhHw8E7tiik5Nz/ar8VOP5Qsy0DTumagOv0vpF6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X0v+TE7c;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655EB606D802
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 655EB606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X0v+TE7c
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48KeHO1263928
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=c8m15C0J/jy
	ukNOtDNai+sXZ9RrYYX32aHR0sKoxqUc=; b=X0v+TE7ch2vjD9HNPszsLMUtju5
	P+NB6Ia1pV98X/S8wW6XdtsjddxuOGE4sFC6HZmTrDPA9mYpSL1FQlmXFDyzG0c4
	W/pJHPO6YZoz5HNo8IhVQtmvhwdSu+AHOw9Om+7JgHUxZquJYXcH5QDABj+dtku+
	YPoZhkF0WwgBZb64PXphVlZsDenPfhALk3mPIBUHvdTnsD3M/yfhIL1+vLS5yXqL
	Qn0te/IZaKVWwBcSKtBtZaujgJsl5SuEqEj1n1KkSWtRB17ja2YvvmNblBj/uJp6
	Dd41Iq3crZ5q89+O8N/UKkjJikX+Tm0HpWS9r4rB40XnwbdGG9ENYI412JA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqjubkn27-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48Ya732686460;
	Wed, 4 Nov 2026 08:34:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6A48Yae12686433
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:36 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 84F1D279BF; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 13/18] obexd/pbap: Include database identifier in responses
Date: Wed,  4 Nov 2026 16:34:24 +0800
Message-Id: <20261104083429.4111632-14-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX7mWd/f1YCM/I
 Blu9MqtkeyFyZxtp/96Cml4rQ/cP6642HF1E2EVeGxZoKmlxDlWqRBVWq3tpoHj89G91E0uGvFX
 EVP2ObtfqhoL+ZHn4ka5Lfg11e8wLsc=
X-Authority-Analysis: v=2.4 cv=JeUpPkKV c=1 sm=1 tr=0 ts=6aeaee1f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=ER4LHCsl7VUvPlyGgpIA:9
X-Proofpoint-GUID: PiGb3Zm3Bca1vELLtKReQwcZIKnfZj3u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX1RG4UcGRu2JN
 qYLxbbgtI9txqPgarRGMNzNo3wJNAj5MxLufcOjKFBXVvVdM2ovyulNGMm1Q0fpJnodNWgTO1Pq
 gR06PNjghrPIYfzaxT6ohDfqi/73tMkO5aG+LcjAA1Tu9XJ7KJ1LbnBWE+665YKnjvA7PXt4RkN
 ht8w1lOf4eLpZPqE980TDrnZTBDZPfkGZ+itg3z4wS1QJbLJhvgKE0DOPbkrAicH6W3omHaRosA
 Gyb5eQipiUZi8RXt3NCu3EP1EyIlrRp3cd45Vf2/3C2Ss75/XVpqUsMAcAnYc0ST1KyJAW6ZCuo
 r4d/peKWe4c+zJdw/AcYPWFoFynaNoy/OLxdWyTrKRrIezrFyfKgLTNB1on3YJNtjt66EStN8vi
 g7RncDB+oxDE4//iPPyM1Tyr83EievdktpEPyRBcbFg5+rBtgPO28FMzewyoPtJ/SaKXPUrsn/t
 6gHU2nBducynrQknw7g==
X-Proofpoint-ORIG-GUID: PiGb3Zm3Bca1vELLtKReQwcZIKnfZj3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040034

Add the Database Identifier parameter to the phonebook, vCard listing
and vCard entry responses when the feature is negotiated, and enable the
feature in PSE_SUPPORTED_FEATURES.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 92794b968..f271547a3 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -51,13 +51,16 @@
 #define FORMAT_TAG			0x07
 #define PHONEBOOKSIZE_TAG		0x08
 #define NEWMISSEDCALLS_TAG		0x09
+#define DATABASEID_TAG			0x0D
 #define SUPPORTED_FEATURES_TAG		0x10
 
 #define DOWNLOAD_FEATURE	0x00000001
 #define BROWSE_FEATURE		0x00000002
+#define DATABASEID_FEATURE	0x00000004
 
 #define PSE_SUPPORTED_FEATURES \
-	(DOWNLOAD_FEATURE | BROWSE_FEATURE)
+	(DOWNLOAD_FEATURE | BROWSE_FEATURE | \
+	DATABASEID_FEATURE)
 
 struct cache {
 	gboolean valid;
@@ -167,6 +170,25 @@ static void cache_clear(struct cache *cache)
 	cache->entries = NULL;
 }
 
+/* Adds the metadata application parameters to the response. */
+static void response_add_metadata(struct pbap_session *pbap)
+{
+	struct phonebook_metadata metadata;
+
+	if (!(pbap->negotiated_features & DATABASEID_FEATURE))
+		return;
+
+	memset(&metadata, 0, sizeof(metadata));
+
+	if (!phonebook_get_metadata(&metadata))
+		DBG("Metadata unavailable");
+
+	pbap->obj->apparam = g_obex_apparam_set_bytes(pbap->obj->apparam,
+					DATABASEID_TAG,
+					metadata.database_identifier,
+					sizeof(metadata.database_identifier));
+}
+
 static void response_add_missed_calls(struct pbap_session *pbap, uint8_t missed)
 {
 	const char *folder = pbap->obj->folder;
@@ -208,6 +230,7 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 	pbap->obj->firstpacket = TRUE;
 
 	response_add_missed_calls(pbap, missed);
+	response_add_metadata(pbap);
 
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
@@ -256,6 +279,7 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 	/* Application parameters go in the first response packet only */
 	if (first) {
 		response_add_missed_calls(pbap, missed);
+		response_add_metadata(pbap);
 
 		if (pbap->obj->apparam)
 			pbap->obj->firstpacket = TRUE;
@@ -274,6 +298,14 @@ static void vcard_result(const char *buffer, size_t bufsize, int vcards,
 	if (first < 0)
 		return;
 
+	/* Application parameters go in the first response packet only */
+	if (first) {
+		response_add_metadata(pbap);
+
+		if (pbap->obj->apparam)
+			pbap->obj->firstpacket = TRUE;
+	}
+
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
 
@@ -396,6 +428,7 @@ static int generate_response(struct pbap_session *pbap, uint8_t missed)
 	DBG("");
 
 	response_add_missed_calls(pbap, missed);
+	response_add_metadata(pbap);
 
 	if (max == 0) {
 		/* Ignore all other parameter and return PhoneBookSize */
@@ -902,7 +935,7 @@ fail:
 	return NULL;
 }
 
-static ssize_t vobject_pull_get_next_header(void *object, void *buf, size_t mtu,
+static ssize_t vobject_get_next_header(void *object, void *buf, size_t mtu,
 								uint8_t *hi)
 {
 	struct pbap_object *obj = object;
@@ -1006,7 +1039,7 @@ static const struct obex_mime_type_driver mime_pull = {
 	.open = vobject_pull_open,
 	.close = vobject_close,
 	.read = vobject_pull_read,
-	.get_next_header = vobject_pull_get_next_header,
+	.get_next_header = vobject_get_next_header,
 };
 
 static const struct obex_mime_type_driver mime_list = {
@@ -1026,6 +1059,7 @@ static const struct obex_mime_type_driver mime_vcard = {
 	.open = vobject_vcard_open,
 	.close = vobject_close,
 	.read = vobject_vcard_read,
+	.get_next_header = vobject_get_next_header,
 };
 
 static int pbap_init(void)
-- 
2.34.1

