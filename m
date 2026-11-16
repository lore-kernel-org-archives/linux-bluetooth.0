Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820024;
	b=z4S/VpTIXih1XBCir/0Fq1+Q0UY4jl00qlFJZNIvCgDD8YhiL2EYl9JOzKF8tkAd0bHK
	 bUwOvcWpgI/o95HEaf/75+WBr1MBObxd6vYvJOjo36D91DErc1XzZD1axlJkuiTfGYBwY
	 biFIxuWqJukL63dqwb/AD07kDFaEsBSTTDRRGE6pMUblWpkV4wkCZT5w1xB+JhOa5o5Qe
	 b5oJQnez2wwKLHYXFKYo9/z2cDSkhxLth3Zd0gtbg02W+gyGd9uoQ646H77gLMIu8iFv5
	 J36jiGrwTVvLoaojs/oaYY3tmLmTMW5/L0xr8RMl7xCO35meT7jeaxmAEbH9X7QUDPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820024;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=c8m15C0J/jyukNOtDNai+sXZ9RrYYX32aHR0sKoxqUc=;
	b=fu5TcpnjkugEtD3uLlCHc2/2/tGv4q10P7Ixg/0k6pf6Xvk7nOGIJVmEgZYAsEFaRkJ2
	 YLHGNDobYZtBx3HyNeTAjEDkyGX9Q9Q6gIcgciXefDDtPj4rwVMp0F97vC76RbhYvK6lR
	 aoLqx4oO3iVUKmulgv4vM/oFYlA2qUq+a+ySpHXBdhmLx5InDwzR2lSbZ2BpNMq0n+0BU
	 9YvuTg48Mikz6ryyno1lkMFHF+nz2G3lg9j+Pz+muL8uh8koCSjjN2inhrZNw4XRM8jQg
	 GRW07JvnaaSxSd+pE5sl0GXjv+MIWfP0Y+Xwye7lRQA/tOgjBW/ijx+amzi3XHGCWHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Iz7POFjI;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ED1606A339
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5ED1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Iz7POFjI
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7enSc1109755;
	Mon, 16 Nov 2026 09:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=c8m15C0J/jy
	ukNOtDNai+sXZ9RrYYX32aHR0sKoxqUc=; b=Iz7POFjIePqGGIyFn16XzG0VIiz
	ObU0gkH8Hx5z76I3W0urquHM2xwRytsQt0hT4XO5HPpHmtkmsggut8RAWgal4bUx
	FyFgyzlgwIy+nysAHNg8S5p+KZNywJSc/KKtFGmfotaA9FXIa1XDdx/22j1LyPYT
	zDfTIuQlwaKcBHmWWjRM79EuhoEaLV29bWaUlyDgitBJYtcA5v8QKc3xlFGD0EQB
	+UGfMHho8g5n6ksoLrd/cuBymZ+40Z+k8siy61zQwedjeoxHcT5VLq5RCfRXdzOq
	CyqN/3kfYHlSLStZ+waILnOerHxiGNDGksu4DGFJGfb/pSH/dcVHrQnhGVg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyrmc1d8k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:07:02 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96tLS2942802;
	Mon, 16 Nov 2026 09:06:57 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AG96u1Z2942839
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:56 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id BC5C227A0A; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 15/20] obexd/pbap: Include database identifier in responses
Date: Mon, 16 Nov 2026 17:06:29 +0800
Message-Id: <20261116090634.1222593-16-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX4MXwj1I4XyPO
 kBOf+476vmMZyUdw2k27ByL0XxoBfhHA4Pq/r3RN0vGGXXctSLlk3zT/4FPcRJpEfsjkcd5xwLE
 H4N/4Mf9rDH2egMVl7GUsl+7WUsfybg=
X-Authority-Analysis: v=2.4 cv=C9N8WgP+ c=1 sm=1 tr=0 ts=6afac7b6 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=ER4LHCsl7VUvPlyGgpIA:9
X-Proofpoint-ORIG-GUID: yO4dc483M7qe5oQY_NyKdArE4eru2laX
X-Proofpoint-GUID: yO4dc483M7qe5oQY_NyKdArE4eru2laX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX+7N9tXDPdRXM
 EeVGVI3YnUeG2fFii6k/8icfOsGCx84ECZlWVRs2XxMblBWwSmUVkV/O9F80/2aprhKn8HAyD/A
 qPqBA8ClEfNQZLXoiWlvO8Uow1sn4xNGkgqRlbOJjRT3WIfbRwgv6ojbO0T7kYVUJXwGyWW3ZG5
 HhKPUN/RAEJsDH50KVmKeDSR/h64GmUi3a6Xm0uyt2EyHSdSmqMjdWZOQDuGHYSDvrwkJgvpJlm
 0PDY42evSaS2EHuxC67m76xpqn5de0A80hGNOmrkq9NWX55Z2Dqsl70buA5k7NzEF7bbpGyWwx1
 XUHuByzzhWVrusIU66El0XEi4ybGErMHOMJIf/YwR7ZLovNAIF/vD9I3YbG5UM1IB2CAheseYvi
 vKXXPMjkYao4lNeqjOGACFCxE4AhHgqx0iYp/HjROFxOnbEdXbuLs7cTt/6QfqmprCJ6d8CzGxF
 9K44fhV0mvEGAuzkIxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160036

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

