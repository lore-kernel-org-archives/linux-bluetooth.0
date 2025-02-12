Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8131D86F2
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351169; cv=none; b=TnckhTGfaLY2RTLX83y42hUSzd6+WRjFMxrQdkrX4owMmiVos0PaRAuXa1CS4X3RoqD96+gpsFMWnYp58tEEg0LxU6J52q9bQuAjMxQVdxayhTMNQljZernvK+0LdLuhOkBv8DDfS+rSCNAHYwFnUqd7dxjubrM12aXh41D/xWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351169; c=relaxed/simple;
	bh=6agQOk3pORJEt6URRFJCAmA1D1sdYaCLEnL4438SjVA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qvvP3Aksj2hiHfD2ilhiqkqDIp2GVGfPS4muNzVPPYT3sSz+yi8gEgcE/IK66PzbBS9hIfmzrHUxTIiOorv8TLyFvWo8kMOn0kAwC+zpv1Tp6XJNPnwLMnPTu2Aon3LRgG9YXMW0vAW7E7DDhcycU72I88rf8thM999hGDFu6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cb/1BUyK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cb/1BUyK"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C0gMBt030148
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 09:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=7wttJNCBCyq/
	60isp69kH9ne9Dgg/J+hQfSL829+afc=; b=cb/1BUyKrwhAMBtzxdISbFc+F0LK
	eOWt5f4Z+qJ7CaV4XFs21n09fjmwL7hzUaN4gN9X5zNxAcPLjOnVRuY3KwfBDRCB
	Is4js+itSYCfuCrYJJ9ZRv/hJl7e2sEudpkFCO1qPoDPKCliQH83vHpSEddrGUYg
	A0vHt/ee4Y9aezZS9d2QV2KcAqcKnpRhlJ44wPsUCj1MH3AW69j9dM1oYnpyseYz
	jVjhE0CoKBI3z8cQr4PX8trMd/nFFcz/+fDOBRkmjKIrfYsDv301KK1km8pifcGh
	WYHzN4/aKKLuoEkIBn+P9uVBJ4+HCT/4oJgePDzebnwrKE8h4CUPtPIJhA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qxg9may7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 09:06:02 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 51C95A5T003800
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 09:05:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 44p0bm69k3-1
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 09:05:58 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51C95wXX004428
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 09:05:58 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-rbujala-hyd.qualcomm.com [10.213.107.103])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 51C95wr1004427;
	Wed, 12 Feb 2025 09:05:58 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4130939)
	id 9F7DB5005D0; Wed, 12 Feb 2025 14:35:57 +0530 (+0530)
From: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
To: linux-bluetooth@vger.kernel.org
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
Subject: [PATCH v1] Audio Profile version upgrade.
Date: Wed, 12 Feb 2025 14:35:53 +0530
Message-Id: <20250212090553.3775-1-quic_rbujala@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DWGH4zSCi6w9WdcCtO0qmSCwGkyOmMl5
X-Proofpoint-GUID: DWGH4zSCi6w9WdcCtO0qmSCwGkyOmMl5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_03,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=962 lowpriorityscore=0 phishscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120070
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

Most of the existing profile versions are withdrawn
to make PTS successfull, need to upgrade the version
for audio profiles and there are no mandatory feature
changes between these versions are seen.

Version changes
A2DP from 1.3 to 1.4
HFP from 1.7 to 1.8
AVRCP TG from 1.5 to 1.6
AVCTP from 1.3 to 1.4

Signed-off-by: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
---
 profiles/audio/a2dp.c  | 2 +-
 profiles/audio/avrcp.c | 6 +++---
 src/profile.c          | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c97bd6e89..961a6e89d 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1595,7 +1595,7 @@ static sdp_record_t *a2dp_record(uint8_t type)
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
 	uint16_t lp = AVDTP_UUID;
-	uint16_t a2dp_ver = 0x0103, avdtp_ver = 0x0103, feat = 0x000f;
+	uint16_t a2dp_ver = 0x0104, avdtp_ver = 0x0103, feat = 0x000f;
 
 	record = sdp_record_alloc();
 	if (!record)
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 9fe8f55e5..86b59a379 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -138,7 +138,7 @@
 
 #define AVRCP_BROWSING_TIMEOUT		1
 #define AVRCP_CT_VERSION		0x0106
-#define AVRCP_TG_VERSION		0x0105
+#define AVRCP_TG_VERSION		0x0106
 
 #define AVRCP_SCOPE_MEDIA_PLAYER_LIST			0x00
 #define AVRCP_SCOPE_MEDIA_PLAYER_VFS			0x01
@@ -414,7 +414,7 @@ static sdp_record_t *avrcp_ct_record(bool browsing)
 	sdp_record_t *record;
 	sdp_data_t *psm[2], *version, *features;
 	uint16_t lp = AVCTP_CONTROL_PSM;
-	uint16_t avctp_ver = 0x0103;
+	uint16_t avctp_ver = 0x0104;
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
 					AVRCP_FEATURE_CATEGORY_2 |
 					AVRCP_FEATURE_CATEGORY_3 |
@@ -493,7 +493,7 @@ static sdp_record_t *avrcp_tg_record(bool browsing)
 	sdp_record_t *record;
 	sdp_data_t *psm_control, *version, *features;
 	uint16_t lp = AVCTP_CONTROL_PSM;
-	uint16_t avctp_ver = 0x0103;
+	uint16_t avctp_ver = 0x0104;
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
 					AVRCP_FEATURE_CATEGORY_2 |
 					AVRCP_FEATURE_CATEGORY_3 |
diff --git a/src/profile.c b/src/profile.c
index 70ac058f4..cb74bd819 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -2075,7 +2075,7 @@ static struct default_settings {
 		.authorize	= true,
 		.auto_connect	= true,
 		.get_record	= get_hfp_hf_record,
-		.version	= 0x0107,
+		.version	= 0x0108,
 	}, {
 		.uuid		= HSP_HS_UUID,
 		.name		= "Headset unit",
@@ -2095,7 +2095,7 @@ static struct default_settings {
 		.authorize	= true,
 		.auto_connect	= true,
 		.get_record	= get_hfp_ag_record,
-		.version	= 0x0107,
+		.version	= 0x0108,
 		/* HFP 1.7.2: By default features bitfield is 0b001001 */
 		.features	= 0x09,
 	}, {
-- 
2.17.1

