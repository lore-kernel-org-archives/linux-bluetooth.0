Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390280;
	b=AQ1tpefJy5jc30RNvwWeA8HvYWSmUOdrJvJTwjZxUI5XAzSChzqiVa0YN7wTVo8Q5dhF
	 lqwIGjAR9Go27EmuCJ8vuUJG1p15nTLCMKgzdJQOpZLqN/wsTi0/tyibzVsldhrOgk9hQ
	 Mhi+JW7E6kZvtuCy68czug2cxChlJiDHfMia5wLaM7MSfygToQng5Sokc2UEH4tF+91G0
	 0fcIYw7F8H13IomCOMSp5o7xEMVUklkwJVO4eOHjafHBXMI8GFW1cPFdVNLcp/ABPYeIj
	 rFTI99KYZGVmdANOAYEgUHs7bPaonCN/gRqC12iKUvPLCd2IyMbV39jaHRKpD08qvRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390280;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=c8m15C0J/jyukNOtDNai+sXZ9RrYYX32aHR0sKoxqUc=;
	b=KWIauAWUhjrxr3vKlDPSmyWZZJWPVKIvUYbTa2Whmbcab5yCZ/fhGnUUvhy033K9XqlI
	 cfjbvk+43SB4C0FeQGOreB0HammwvMyGkGwdQ6ZOMToD7eYAsJ5U8vc02PSdHrEthZOAO
	 sYZT9cHqyBfmWicXjSLsOvmiZ3OKatbO+KsXoA2ecmB1MlZnDOG/pBtN1OzVXHpjwxPct
	 PeEuSRV4LEjDIrSFjYQttLu3vFwBx8M9olSf9TnDDmjaMlQsuYRaDEVndIYxV26+Ym9oi
	 U2rNFDzzsr3uVcQt/dEkR6Oi+ZcHIPq7YVg1OUNVIw8eqDsMacjYBhmCxrCNpfVrlCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rfpc0dVV;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E7606A33E
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F1E7606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rfpc0dVV
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5K8jU1408970;
	Wed, 11 Nov 2026 09:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=c8m15C0J/jy
	ukNOtDNai+sXZ9RrYYX32aHR0sKoxqUc=; b=Rfpc0dVVvrI+GYpV3+LAZFL1pLz
	3sk+BafX7TAVWZ69+ievRazCFfm1gswhOvE+v5d3kLXBWPCFoc/Y6af0AouQJBWy
	10F8u/Tjz7c2SLHzKl4vsgCRQjzfVsATgYAjdTfaw7i4YSdgdog29c5jGQoqYET5
	4Bpbn7QAPuZlCoScYlq8bGhKZJP45ZoxpzIzrfolowZg4naXuN9KWw0Ql59btLBk
	XJWg1VQBx2T2cyWAFN99l8AVhpv0udso5PRoNuFThRLSXkMj4AsSIgKWh0cIv87z
	fNKU48nc/Tks3oBvsBXysgZcnPPx52muw9s9J4CAkbME0ZRlrU8vkHOqwaw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvgjdh9bu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iZNH2424196;
	Wed, 11 Nov 2026 09:44:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AB9ia3I2424272
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:36 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 66F18243D5; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 15/20] obexd/pbap: Include database identifier in responses
Date: Wed, 11 Nov 2026 17:44:20 +0800
Message-Id: <20261111094425.1444893-16-jinwang.li@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6af43906 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=ER4LHCsl7VUvPlyGgpIA:9
X-Proofpoint-ORIG-GUID: ivLogGW3971jJKnhntpV3sYGLWR88_lL
X-Proofpoint-GUID: ivLogGW3971jJKnhntpV3sYGLWR88_lL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX7VxFOG9FihQg
 4BbNoekd+sXsBs8cdMfcxjLQ4m/xW7vyN59MjrkIOYAark1kSy/Mc+nHMo9dH/YUCGoGyIvMVgi
 LqDrqNmoGBFawstgCd+210pdRox+B49Y0kfXiyadntEJZqEnSxIbKL+/IH8VFXOpNMaiZeohI2h
 9Jlch3RDkGe8J1AV4t8r2+OhFlCZmGNTiY53fMIRFHz+V3FV8r0tKt2uYy/MWoBoDTfjajhau+X
 cbHBrDC6NHO88sgBtwrxeoZwrIkpAbTDSQzuMYH98QmNw9JhQnms6WcPW7ELTSrtL9aFJtp/qSL
 c38wXlKsCLaPADEVxIsqVhSAOQb/y1+PsSFaxOC1aLzcHVaHB3rrrNKVi2hpii+9mLGdi7B3Gzp
 I2+eGb7ko2UftaXWkMZGOQXoosq59+2Uv0B6DDG2ebpHBFTzm/s0En6jutEuehBYf/7coa8HzkP
 KK5L1TXlNESZ4H619LQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfXz0DijW5rSA3/
 bgiVTQAwjVeHRBEMOlwdif3YiZFmfQRGsvLykPNMExQp/vEgoqwzvcPYRprLQg7JlS6on+0cahU
 nO742bCb0SHVX1w514iUWskk8BzpziY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

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

