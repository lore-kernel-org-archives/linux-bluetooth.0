Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781290;
	b=XDl8vnNX6qJiOP+BeWxHvtnVevZ8RlgM29PPcBfn1JLe8tH9RVtlWN00tmzOFwCzUfNl
	 /Tjqer/kg7VTWjv1IvSFH6BibuKDm4EK9L42kLb2PeQYzcjt/zkGplhLgfM7kDlEbfrYM
	 UHzXXnKu7O//zq+uJI0O/LC0p+ZmO9nyeVS/hppNOUbm0Janog/mnO6JQpw1W69b5WZ6u
	 ZrhiBV3GxLaKraQFojSQeqpJ61fAiX0j9ndh7IIr8QWTCBonZLmEYsCqLRRFhSmjv8JqU
	 gBPlvQzAcvjyK8z254kFQwDpqvXssKHi+vMgPVaM93ORgGOXn8AtQ3CzAJBiPS8xVRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781290;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HLVlmLmDP1wzDohQXtZvE/KTISH4jVUcuGsU1NuQDrQ=;
	b=nA5kZHBpe5hikGUHR0NFKgGjA03bD0gViUbeNjMVP2EsnJd/9I8BGamOPxrpxz3WaSj4
	 /pYULbecNZVyl81I2TFYpuM4EHxUBwf80cSOy+B/3PiO3ySiqdlOpCTkYSGV9/Pvq8Wcx
	 KQKUXSHi5fw85CKzH10asqSDq4VO/cSrzV2t3XjUtpPvwqN0hZ0FOlfRYGYepOwjZ+0lO
	 OhPsT4twrJ0Y7U7c/SJhb6YOaUBIEOL+mn2oFeRGNq7tc56qFqqcIuUgmXaNiLKfqU1a3
	 mEUC2GTl5WF/p9KcoIpppj5UJ5CVe8oy+XtMmJwzd71MwO27+ohkfDgNT9AE5BAyuZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZgC2WD3z;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77056606A330
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77056606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZgC2WD3z
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48KajR2232010
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HLVlmLmDP1w
	zDohQXtZvE/KTISH4jVUcuGsU1NuQDrQ=; b=ZgC2WD3zUtuHPQQ0ye4r6dBXW5Q
	qBCy14Myv091pFZfGotlMDCO8X2AVJmUFzN0X0aFHyRgB2IOhXaXbsjk1m0iK7Zb
	00p/171+7ZhfWCtH5NiYe+smI9/jvOH7GUR2j5qzaizaECMYb5MyxGpkgYfFYAn7
	lHhrc7OSNxg95eufW6EUYzOIyFL3AB0RyNr/aUhx9rH8TmgGIGdW1qjY8Zy2YEK3
	CpHveXUVEu3MiRjRxSpzJl39GD5S6eLf8LLr7qSW8Sm2fFJHsojgpJMaMhKihEv8
	LFk0mcpWUfl7FBFV+aVnFYE9AhSotVWB5dLQpPPApFI6Xpen1rSApCZ7OSQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2pk58s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:39 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48YbSI2688081;
	Wed, 4 Nov 2026 08:34:37 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A48YbBR2688069
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:37 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 8DD89279C1; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 15/18] obexd/pbap: Include folder version counters in responses
Date: Wed,  4 Nov 2026 16:34:26 +0800
Message-Id: <20261104083429.4111632-16-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX6i3SC1ywTPZs
 i0YSIbcZyZ/miEG0V7YdTBSKmRHQ9RnIOPH/qpdEtu9gBJEuT6hZNK8L7o8B5I67iYf/AXpNDyg
 Sf2FeJ2FcUYQCn+LCA7XzBlR0avsutc5R2hQsd+P3ENh3C910VPgaX2sJBTTFCM1C0iPGwkTFii
 hi/nVfE0d1IFDrWvqBFKnrP5o5kBf6SnIVBx5l0ZEz4xH/nw7WKAYPfktKNs9XzHjvoAw1B8lE9
 1yyAoYXnbKhmJ1vvdVvlu/gYdGJTp3/QUpoRq9fUhdVQ9O0Gji8Y9xByTTjBYWE3eoG3OYzsdDM
 VNb7hIyJk0w3yTJoY/CtHJgy99FWQwHlKQfK6fXaGBb78avxcl9WVCFY4PfC2gng13X4sbpmv4B
 FUopQ6NCDtsEt9GGiR02F2rZx6Y4EbmeS1GhCcm7PPi5C5QGbxjS+Zek70g1HA5DDPD5sTgWLt6
 1Bd2zEzzGXHElq3F+iA==
X-Proofpoint-GUID: U5NXSHB0C7PGOcJB888uw7hUQd3cpALS
X-Proofpoint-ORIG-GUID: U5NXSHB0C7PGOcJB888uw7hUQd3cpALS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX65sx8Z1hiaPw
 coHFumcHfdsKtzDTKNqOz4DFK0p/FRruh/YSpYjGFFozD1n9O5aDBtWB23t6D8czqbpBWndp5wU
 EZsLqe6hKq93JoOHPeBFP63tMa1U5Dw=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aeaee1f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=SRSfDciscjayFaDP9Z0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040033

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

