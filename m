Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820022;
	b=rWKtpmooGWqt32dTnO6Y158BxuFEkQU2rVb7TJWJNZtnytJ+GNr9Z2FGu3HEuMXKI7Yg
	 g5uA4eRW5R+GyynMusrSWOZ/YpKfaW52ovDKWpEAwSWcmUh/K12CGRu2UZw5Gn9dIwPZY
	 p5G/uxPTHrYEwEK1TaX6cXy+jRrwEqgcOcypDXHzDaeExeLmp7ihRYzMCcoZCw++U9FKR
	 jKKn9sTr/zTdtNtWSNSw7zcoW/kO/i8gLqBId+azWuFN8CcOHcgOvtNx9AEQTO+0SUZah
	 CUEMGj98ZG/2faA+luNFkksCgdSkPqb/wFBHm9ppkajIPnFxCTNvRUNYqRMCtkSgUWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820022;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lA7kQfMM1FEdlO3FJ13n4+cFE/oGMaiGdDZm3mBa29A=;
	b=Zc5nUqdq+m2gc60+xthW03NjrGGbIrPN+j5iIgI1fB/FcvkIhHju/EBkmmS9TbIJAGGJ
	 wX4qaCp7PW2APXU64SltctkvZoSNlP9roaEbW+kbVIGirz614GsodMFrikmkNy1jPT6/y
	 e65YhtXWCvdtgtbcX2IEcSyuub07Zn4JZ0D8MkD5Gws3vx6G4EwDZZlPQAZntGaFhcF5u
	 ZkTxJ4pCT0IElKQZcZn26bEiiLCZUucac5NnT76ISsRPTvNp3IhgBBgWT5IsWUTNyGXUe
	 kOhzNkHWOIch2ZaYePd8cityHNgn8qJIsTRcPmJvRWZ6JGhdZ553Z3xWkiQQd6YIn8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O+5IPmFZ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6340606A8BB
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6340606A8BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O+5IPmFZ
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7esqe524901;
	Mon, 16 Nov 2026 09:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lA7kQfMM1FE
	dlO3FJ13n4+cFE/oGMaiGdDZm3mBa29A=; b=O+5IPmFZquLB80uX6v74Bea+1YK
	RUEzYwZhTjjvdK696FXUIgQPU32lP+4v0C/fRcPfxvmgjoyUXUUdXQc1UaQ0JucO
	LT7BIo+LGBs2O03h5dvzBs/zE7TBNm4J43zhX+lGRGl9PYK7AegtTDJc5YpVKL/8
	DaEdSDGVZbQGSc7bw/uYM1LCcfMzpJJDt/WbQKSM2WVQurqTtqx5vEHMHKKgQbiP
	fptBZkmZB6hjxcqYcUoItIPZJI7IzhrXKK8x1QCYQXe0bhq1HSmFLi5hkGP048pr
	/wQ708RhCnW67H2LHlPbtiZT51BM2PDmaN4IuVnC2E+NkPjyBYYv7zLWChg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqnsu2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:59 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96tAH2942876;
	Mon, 16 Nov 2026 09:06:57 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AG96uax2942914
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:56 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id C546527A0C; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 17/20] obexd/pbap: Include folder version counters in responses
Date: Mon, 16 Nov 2026 17:06:31 +0800
Message-Id: <20261116090634.1222593-18-jinwang.li@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=KelHIgYD c=1 sm=1 tr=0 ts=6afac7b3 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=w7hw7xgAHL67B7LTLTsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX82eWXDyD0XiA
 62Mmt72dwJ2Ijw2QxHkTay+g9oEPHxqdEaiF62dOPv52baSIBQZS4Dvx7kEDLHSoMCYEyCRsJG4
 V4o4UDrvc4ptTO/vXhLHkC+AFC4ZjyY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX1nOK8eSdDVw3
 /sWtpjr9g/fxYIy8Jv4qYBx79GKhr6f0DpsVPeU7E0Z3pyuDp6P73Z5v9uTivF6Ipeyk7Rh6V2a
 SHZMJnn19CWwqNhU5XW5avsQivGS5k8K8kYFsWucHh0i57rRS6xbANHAg/aVlkttnf2TpoJ8EwR
 jN1kKEmh6Qja3bglF4dZFvr6o6Yuk8Q+Deme4MFxTkRpACWSfV3yA5juKkk+PJKDHoIXnR+2dbX
 LK2p4UAdxOsUotrqm1jl9MPhYFepnib06Eqlq3Xrv6SQYulyGarQO514NelXmGsyWcK9a9BMAEX
 iJVD+b82oZP81go08rPVA0g9uJc5TD1GquJl/uivj0MQMM+LAlfCX0NX1T32Ve2v/MLTryAoHVQ
 EcAuD+9HazbBqOnkEff4QyfRFkeGY7LEjaE7o0W6yWwovTWdkz/XzWLgNxsRHjQ9/U6PFJ0tXHa
 TwSj9kqRyu7cNoxyELQ==
X-Proofpoint-GUID: bQWF7x4c58IMNZNJZy3b9Ssh00UYDJF2
X-Proofpoint-ORIG-GUID: bQWF7x4c58IMNZNJZy3b9Ssh00UYDJF2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036

Add the primary and secondary folder version counters to the phonebook
and vCard listing responses when the feature is negotiated. The Database
Identifier is reported as zero when the folder has no counters.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c               | 47 ++++++++++++++++++++++--------
 obexd/plugins/phonebook-metadata.c | 13 +++++++--
 obexd/plugins/phonebook.h          |  2 ++
 3 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 1ba5f0b63..c47be81ab 100644
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
 
-	if (!phonebook_get_metadata(pbap->obj->folder, &metadata))
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
index 005ed3b9e..5a1acf7af 100644
--- a/obexd/plugins/phonebook-metadata.c
+++ b/obexd/plugins/phonebook-metadata.c
@@ -174,8 +174,17 @@ gboolean metadata_read(const char *folder, struct phonebook_metadata *metadata)
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
diff --git a/obexd/plugins/phonebook.h b/obexd/plugins/phonebook.h
index b2b2a3ab7..1b5ced180 100644
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
-- 
2.34.1

