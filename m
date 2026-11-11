Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390280;
	b=ZU+n4gOWOVHv2atST4G4W0Gj/K1o5IL+jkLRG1TD5iBG37z8Apmo7CHxkZpj/tQtvFp5
	 nRCT+KDpenLARokc5g6Yhws9cDoulIzXRIMJSWNOZjtTfbeqLY/WSsd52NhB4H+u3+aCS
	 VC6KhahcxcUUXMeKiMnIDLgcsBDqzso0EeBkWAqSsbeJlOqGFGtiE654kpufO0PrTL7L/
	 LCjovQ1O1/pKr2FjoP8zCT4V2ENvHTJx7FIerJ8uelIM+ATzd7VycUobR4Pbgs3+Yh/80
	 gmYzHKH/cinfkZ6/YIKyTQ0ekduuVIDBOtpHUxk3bvvyE1UMYFMwp578LsPB6TQkaHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390280;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HLVlmLmDP1wzDohQXtZvE/KTISH4jVUcuGsU1NuQDrQ=;
	b=DiBEwrnlbIUGkS2R4s7beST9ekYZwCJURh9GxDzae0AERxkdKWg9LTTQkPotdxnTDmX4
	 YDYmEls3eDVgkxhEbUvd3qH4Lb86aIRESzjSoHBz53mF4uPBR2S5ed2J+SSDyeQMpSJ/m
	 Gdb6gcvXazobOVZ+TFyFkmEeTJ0fkVfE/NXo6QWY873ITw8uYiX7KJJmb+y4KKwv/e+IL
	 hnCA8ptVMxylD6UiNkXSmsPJUWX//ZWPmEy689FLpAhed9xCRxXJFsxQVvX42WDbAliqw
	 MJ1UWPplX9pgfQTBxztWE8G+y5K1S4g/tqgYX1DhXJ98xSZCWILq4cRLNiaPbPdHrbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I2Nh29uI;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB560A260F
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EABB560A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I2Nh29uI
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KNgV3958971;
	Wed, 11 Nov 2026 09:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HLVlmLmDP1w
	zDohQXtZvE/KTISH4jVUcuGsU1NuQDrQ=; b=I2Nh29uIXYFUvirSGYAH3ntdnNO
	72gm0S1ianrIpjxpN/vUWYHyzU/iF/M42vktfl71CN+HWQMQlpXUlLZXvW2rAxty
	Lp0DI5CPYyJBHitkU09L/a7HnFNh80xwmeeusf45HnubwNKQH9WoL14cWt+rkjaR
	ZN+Cbp9buf1eyguRuaLeI8q7rmg+CHAZzSZ9oLpMZ3xO6zVUp7WQQArYwUccH9nD
	meHYaGHqxhH9/ni8tI6NNf2FUgFsZo25NueGm0IFpGLLtYNC4DvGAu1prLosEUao
	EzezvA028VXRe0+PYn5bMoJ7pJ5ZhvMVD2FEtIZVr+p3kozDqfJzBbGCxBQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b32y5h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iawg2424447;
	Wed, 11 Nov 2026 09:44:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AB9iavx2424435
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:36 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 6F9A9243E4; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 17/20] obexd/pbap: Include folder version counters in responses
Date: Wed, 11 Nov 2026 17:44:22 +0800
Message-Id: <20261111094425.1444893-18-jinwang.li@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af43906 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=SRSfDciscjayFaDP9Z0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX9+5WKpyLpq3d
 UFazwCIeIknG+iz96leskWRj0SlsEtb9XVFiiM+wOJKA1ZGbpBK88S+TTKcqFjSe7skYMVdmdaV
 5EgviIjtxm8QsemkED9spsQaEACr8W+Twjj7lBJyjfqed1MRxZ8zu4aKHcCqBdRmSz52WQi2oMS
 LgcCQiMaF/W4FGQlw+RCGJ2r1NomMbvf1T9JiAsV9hQmwgMEvYZ+7PDM35msXYKPM4wvYpYku9x
 UuZ+HSNfhi5LFFjmQDq1WGndgY0NU/0YqsNBu/CDFO4a42MOFaJMH4cPTCbPB+7YcF+g1Z2VNfi
 LhSVgiXMh+nMwjVHibrQtLlCYFiaO6JlMcMAO2f5IfGhS8pe2jQ/H/kCPGihhtz0v6SGA7fe327
 b7T4W4GKggTz8HUWTgMLdkN1voqfLk5xhm1vQQkWzixrVRhNPzGGjvVzLUZ+HMZEb3ICBRFdIZt
 jBYkDR3p817M4lgGLsA==
X-Proofpoint-GUID: k64BOCId05HMtMZfNVnskY-ddBLoWXsr
X-Proofpoint-ORIG-GUID: k64BOCId05HMtMZfNVnskY-ddBLoWXsr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX8V3B8UdQzsoT
 KepumFCcEywVd2BfN5NYILNc+Ne25642L7gA7+N4S+EO1q/UR6KV+KH538XEA/e9+uoA+JtJXYH
 tdqISntRzt2m6fkm0klLFy+FfEzJA68=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

Add the primary and secondary folder version counters to the phonebook
and vCard listing responses when the feature is negotiated. The Database
Identifier is reported as zero when the folder has no counters.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c               | 47 ++++++++++++++++++++++--------
 obexd/plugins/phonebook-metadata.c | 15 ++++++++--
 obexd/plugins/phonebook-metadata.h |  3 +-
 obexd/plugins/phonebook.c          |  5 ++--
 obexd/plugins/phonebook.h          |  5 +++-
 5 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index f271547a3..c47be81ab 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -51,16 +51,19 @@
 #define FORMAT_TAG			0x07
 #define PHONEBOOKSIZE_TAG		0x08
 #define NEWMISSEDCALLS_TAG		0x09
+#define PRIMARY_COUNTER_TAG		0x0A
+#define SECONDARY_COUNTER_TAG		0x0B
 #define DATABASEID_TAG			0x0D
 #define SUPPORTED_FEATURES_TAG		0x10
 
 #define DOWNLOAD_FEATURE	0x00000001
 #define BROWSE_FEATURE		0x00000002
 #define DATABASEID_FEATURE	0x00000004
+#define FOLDER_VERSION_FEATURE	0x00000008
 
 #define PSE_SUPPORTED_FEATURES \
 	(DOWNLOAD_FEATURE | BROWSE_FEATURE | \
-	DATABASEID_FEATURE)
+	DATABASEID_FEATURE | FOLDER_VERSION_FEATURE)
 
 struct cache {
 	gboolean valid;
@@ -171,22 +174,42 @@ static void cache_clear(struct cache *cache)
 }
 
 /* Adds the metadata application parameters to the response. */
-static void response_add_metadata(struct pbap_session *pbap)
+static void response_add_metadata(struct pbap_session *pbap,
+						gboolean include_counters)
 {
 	struct phonebook_metadata metadata;
+	gboolean database_id, folder_version;
+	const char *folder = pbap->obj->folder;
 
-	if (!(pbap->negotiated_features & DATABASEID_FEATURE))
-		return;
+	database_id = pbap->negotiated_features & DATABASEID_FEATURE;
+	folder_version = include_counters &&
+			(pbap->negotiated_features & FOLDER_VERSION_FEATURE);
 
-	memset(&metadata, 0, sizeof(metadata));
+	if (!database_id && !folder_version)
+		return;
 
-	if (!phonebook_get_metadata(&metadata))
+	if (!phonebook_get_metadata(folder, &metadata))
 		DBG("Metadata unavailable");
 
-	pbap->obj->apparam = g_obex_apparam_set_bytes(pbap->obj->apparam,
-					DATABASEID_TAG,
+	if (database_id)
+		pbap->obj->apparam = g_obex_apparam_set_bytes(
+					pbap->obj->apparam, DATABASEID_TAG,
 					metadata.database_identifier,
 					sizeof(metadata.database_identifier));
+
+	if (folder_version) {
+		pbap->obj->apparam = g_obex_apparam_set_bytes(
+					pbap->obj->apparam,
+					PRIMARY_COUNTER_TAG,
+					metadata.primary_counter,
+					sizeof(metadata.primary_counter));
+
+		pbap->obj->apparam = g_obex_apparam_set_bytes(
+					pbap->obj->apparam,
+					SECONDARY_COUNTER_TAG,
+					metadata.secondary_counter,
+					sizeof(metadata.secondary_counter));
+	}
 }
 
 static void response_add_missed_calls(struct pbap_session *pbap, uint8_t missed)
@@ -230,7 +253,7 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 	pbap->obj->firstpacket = TRUE;
 
 	response_add_missed_calls(pbap, missed);
-	response_add_metadata(pbap);
+	response_add_metadata(pbap, TRUE);
 
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
@@ -279,7 +302,7 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 	/* Application parameters go in the first response packet only */
 	if (first) {
 		response_add_missed_calls(pbap, missed);
-		response_add_metadata(pbap);
+		response_add_metadata(pbap, TRUE);
 
 		if (pbap->obj->apparam)
 			pbap->obj->firstpacket = TRUE;
@@ -300,7 +323,7 @@ static void vcard_result(const char *buffer, size_t bufsize, int vcards,
 
 	/* Application parameters go in the first response packet only */
 	if (first) {
-		response_add_metadata(pbap);
+		response_add_metadata(pbap, FALSE);
 
 		if (pbap->obj->apparam)
 			pbap->obj->firstpacket = TRUE;
@@ -428,7 +451,7 @@ static int generate_response(struct pbap_session *pbap, uint8_t missed)
 	DBG("");
 
 	response_add_missed_calls(pbap, missed);
-	response_add_metadata(pbap);
+	response_add_metadata(pbap, TRUE);
 
 	if (max == 0) {
 		/* Ignore all other parameter and return PhoneBookSize */
diff --git a/obexd/plugins/phonebook-metadata.c b/obexd/plugins/phonebook-metadata.c
index dffdcda91..5a1acf7af 100644
--- a/obexd/plugins/phonebook-metadata.c
+++ b/obexd/plugins/phonebook-metadata.c
@@ -163,7 +163,7 @@ gboolean metadata_file_open(const char *file)
 	return TRUE;
 }
 
-gboolean metadata_read(struct phonebook_metadata *metadata)
+gboolean metadata_read(const char *folder, struct phonebook_metadata *metadata)
 {
 	memset(metadata, 0, sizeof(*metadata));
 
@@ -174,8 +174,17 @@ gboolean metadata_read(struct phonebook_metadata *metadata)
 	if (metadata_dirty)
 		return FALSE;
 
-	if (!metadata_get("identifier", "value", metadata->database_identifier))
-		DBG("identifier not found in metadata");
+	/* Report incomplete metadata as zero values. */
+	if (!metadata_get("identifier", "value",
+				metadata->database_identifier) ||
+			!metadata_get(folder, PRIMARY_COUNTER,
+						metadata->primary_counter) ||
+			!metadata_get(folder, SECONDARY_COUNTER,
+						metadata->secondary_counter)) {
+		DBG("Metadata of %s is incomplete", folder);
+		memset(metadata, 0, sizeof(*metadata));
+		return FALSE;
+	}
 
 	return TRUE;
 }
diff --git a/obexd/plugins/phonebook-metadata.h b/obexd/plugins/phonebook-metadata.h
index a2f921f13..cc87c7ce4 100644
--- a/obexd/plugins/phonebook-metadata.h
+++ b/obexd/plugins/phonebook-metadata.h
@@ -24,7 +24,8 @@ gboolean metadata_file_open(const char *file);
 void metadata_file_close(void);
 
 /* Reads metadata and zeroes invalid or unsaved values. */
-gboolean metadata_read(struct phonebook_metadata *metadata);
+gboolean metadata_read(const char *folder,
+				struct phonebook_metadata *metadata);
 
 /* Stores a hex encoded byte array. */
 void metadata_set(const char *group, const char *key,
diff --git a/obexd/plugins/phonebook.c b/obexd/plugins/phonebook.c
index 059414446..45e383d92 100644
--- a/obexd/plugins/phonebook.c
+++ b/obexd/plugins/phonebook.c
@@ -48,7 +48,8 @@ void phonebook_exit(void)
 	metadata_file_close();
 }
 
-int phonebook_get_metadata(struct phonebook_metadata *metadata)
+int phonebook_get_metadata(const char *folder,
+					struct phonebook_metadata *metadata)
 {
-	return metadata_read(metadata);
+	return metadata_read(folder, metadata);
 }
diff --git a/obexd/plugins/phonebook.h b/obexd/plugins/phonebook.h
index 1bd6ff229..1b5ced180 100644
--- a/obexd/plugins/phonebook.h
+++ b/obexd/plugins/phonebook.h
@@ -60,6 +60,8 @@ struct apparam_field {
 /* Metadata identifying the current database contents. */
 struct phonebook_metadata {
 	uint8_t database_identifier[16];
+	uint8_t primary_counter[16];
+	uint8_t secondary_counter[16];
 };
 
 /*
@@ -110,7 +112,8 @@ char *phonebook_set_folder(const char *current_folder,
  * Returns the metadata identifying the current database contents. A zero
  * database identifier means the values are not persistent.
  */
-int phonebook_get_metadata(struct phonebook_metadata *metadata);
+int phonebook_get_metadata(const char *folder,
+					struct phonebook_metadata *metadata);
 
 /*
  * phonebook_pull should be used only to prepare pull request - prepared
-- 
2.34.1

