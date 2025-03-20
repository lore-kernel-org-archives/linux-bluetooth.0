Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFAE4A0C
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473908; cv=none; b=TRbl+Xlxrz9uEKvuw6jTb10NSYC2VnBTWxvFjbQ974SZO1KmMXhxqLfMaBw7YIeVFGSBYQa5mjoeWlOVH0G5nPW/zzRlNPmcGcUItfUKL9v3xwdN3d5HwnGSTu/sKHYiuOQy1s9T2/SerTirZ6NlvarFPh5MG9dl59e5iEZFBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473908; c=relaxed/simple;
	bh=fupfRx1TvMh4XdlZVFiICPTJi37wc5O67LALrJ3pEQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AqrY3C+/JbSYtbE9HlYFmhv0Flg/dvymVBZieyrZ7grzUxHEE1F5zI7Xzdj1jtgHU22cP6ScQv91elMCVDVYl8jteemAlIRBcjGFleE3midHIJVk6Ft1xMD0HaETqmmMTGAPBTrNq2tGrrnGq/Ccr/1rWETZ8HunqzMWHOvJk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cyHGSPCu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cyHGSPCu"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6Yx6l016231
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 12:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pxvDNZReTF0MMiUKx8a6do
	tME+z3ea6OWQR+7mDxjSQ=; b=cyHGSPCuvXWPvPhMT3O7Dc0lnh4w6+gA/V91r6
	nUvUAMFAsGdHfwEbZOzWT20ICjNZ6c+fTr7oU/a91mJIrWDghHv9urNdK8kBTuOM
	yDP2k+1O4HtrMkNFR+izDS0sV41QR/mxdcxyLnoM/Klcw4IbPvMsvyg2qWZC8+5C
	KTTwEcpUhhvQ7n9w5H2OGzvxwiAIWEP8YlpMaJ5EVBBmUJ+1ZAnmhWusOjUrpJsQ
	gWHeTinlxGq9dhhBj/QM9dMJbMNCi0LWxC/sRieAgLS8k8B1Kjd6bE0AagOqbs7b
	aYSk7BGJRvqvB3CPNDNeB7WWdJZsiq567ZLghqReGUPqOjTQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g4t42bxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 12:31:45 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52KCVjfk013102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 12:31:45 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Mar 2025 05:31:43 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex: Add supported-features tag in MAP Client Connect Request
Date: Thu, 20 Mar 2025 18:01:26 +0530
Message-ID: <20250320123126.216903-1-quic_amisjain@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=HMPDFptv c=1 sm=1 tr=0 ts=67dc0ab2 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=85FCtsih8eyOagDshgwA:9
X-Proofpoint-GUID: GlrSsuU-uiv_2tEBaMeCi_fvNoxP2e-U
X-Proofpoint-ORIG-GUID: GlrSsuU-uiv_2tEBaMeCi_fvNoxP2e-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503200076

This change is required for below PTS testcase -

1. MAP/MCE/MFB/BV-06-C
Verify that the MCE sends its MapSupportedFeatures in the OBEX Connect
request if the MSE declares support for the feature MapSupportedFeatures
in Connect Request in its SDP record.

If Server's SDP record contains the field 'MapSupportedFeatures in Connect
Request' as supported then include the supported features
apparam in obex connect request.

---
 obexd/client/map.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 7ca33cfe0..ef0bff3ee 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -39,6 +39,17 @@
 #define OBEX_MAS_UUID \
 	"\xBB\x58\x2B\x40\x42\x0C\x11\xDB\xB0\xDE\x08\x00\x20\x0C\x9A\x66"
 #define OBEX_MAS_UUID_LEN 16
+#define SUPPORTED_FEATURES_TAG  0x29
+
+#define NOTIFICATION_REGISTRATION_FEATURE 0x00000001
+#define NOTIFICATION_FEATURE 0x00000002
+#define BROWSING_FEATURE 0x00000004
+#define UPLOADING_FEATURE 0x00000008
+#define DELETE_FEATURE 0x00000010
+#define INSTANCE_INFORMATION_FEATURE 0x00000020
+#define EXTENDED_EVENT_REPORT_1_1 0x00000040
+#define MESSAGES_LISTING_FORMAT_VERSION_1_1 0x00000200
+#define MAPSUPPORTEDFEATURES_IN_CONNECT_REQUEST 0x00080000
 
 #define MAP_INTERFACE "org.bluez.obex.MessageAccess1"
 #define MAP_MSG_INTERFACE "org.bluez.obex.Message1"
@@ -2224,6 +2235,35 @@ static void parse_service_record(struct map_data *map)
 		map->supported_features = 0x0000001f;
 }
 
+static void *map_supported_features(struct obc_session *session)
+{
+	const void *data;
+	uint32_t supported_features;
+
+	/* Supported Feature Bits */
+	data = obc_session_get_attribute(session,
+					SDP_ATTR_MAP_SUPPORTED_FEATURES);
+	if (!data)
+		return NULL;
+
+	supported_features = *(uint32_t *) data;
+	if (!supported_features)
+		return NULL;
+
+	if (supported_features & MAPSUPPORTEDFEATURES_IN_CONNECT_REQUEST)
+		return g_obex_apparam_set_uint32(NULL, SUPPORTED_FEATURES_TAG,
+				NOTIFICATION_REGISTRATION_FEATURE |
+				NOTIFICATION_FEATURE |
+				BROWSING_FEATURE |
+				UPLOADING_FEATURE |
+				DELETE_FEATURE |
+				INSTANCE_INFORMATION_FEATURE |
+				EXTENDED_EVENT_REPORT_1_1 |
+				MESSAGES_LISTING_FORMAT_VERSION_1_1);
+
+	return NULL;
+}
+
 static int map_probe(struct obc_session *session)
 {
 	struct map_data *map;
@@ -2269,6 +2309,7 @@ static struct obc_driver map = {
 	.uuid = MAS_UUID,
 	.target = OBEX_MAS_UUID,
 	.target_len = OBEX_MAS_UUID_LEN,
+	.supported_features = map_supported_features,
 	.probe = map_probe,
 	.remove = map_remove
 };
-- 
2.34.1

