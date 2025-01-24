Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB4F1D6DC8
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737700917; cv=none; b=hMqpvCcMKP4huUe4zsaG4H0VAaiTUdm5f5dSgAme4xoiAzQx8PkBQrPrinh8Dp9glDtocLktoupCgZUElvm9EiaJafVVQl3nOamv8AFpLbS7wbVrb/qZdDVGrHKFKPpsTj1NoV+OXxUfemjZcSlHSBi+3Z5zYwOqR+eglPLkKco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737700917; c=relaxed/simple;
	bh=joZnUU8i0fCfRaIAEKqlLfDmlCF7N7D8mkmwzrWLEaA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k1sPTCdeszNm0ktpoDiFC8Ns9tzxBXD/tAfDirMQ9rxop42OZgvAp0rom6HoW0xJuxImqAkTShYu+DsF3TX6Ra/VvCSINjxbJrKRJggkGNpG10oix5/p42N5A5U2bk5pEWrLdn+g2IKAgS4GcC8ZoC0unTEuaMlQWMpbLu6sKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YPWWnP1H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YPWWnP1H"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O3Ib6W026503
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 06:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=D3wtnnrMGB/7yMz7EPUCJq
	NUifkTT+fj3hzFfmaODmA=; b=YPWWnP1HBfFXVi0EuyjN2YEvjrh6/dslmO1LBW
	aDNSBi6RbCoNQdRoEzvnkyuDkvUw/JeamkAXdQ3XP9mSPdpf9pWG2mJ5beMBwM1z
	V1m8IGGeBe5Pm4fuV01ZDPSZ1wHOcnADsDwUR6BZHzH5VH6uSok/JpMJH8uJePd9
	174PXSwAveRZuQBZNOQmYeTaFd6aJ1xWqgWVasLSb3mY7qT0P10U9rseXSjh3COb
	Y0rIOokDFC3i9AiN3UlmZcMqh0MtmwLGzrPCNfXyCJXwOMAbmAPt0fpinTFaNDWD
	YmTTE2xFuFHqp6JDQJ0J9/wJ+UFtcPFQneriojiUutNPz6Ig==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c2uj8c7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 06:41:55 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O6fsCE008179
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 06:41:54 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 Jan 2025 22:41:52 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex: Add supported features tag in MAP Client Connect Request
Date: Fri, 24 Jan 2025 12:11:40 +0530
Message-ID: <20250124064140.1071458-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: fuy9uMBEFwHov5lGRdnpemPfShjPNevL
X-Proofpoint-GUID: fuy9uMBEFwHov5lGRdnpemPfShjPNevL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_02,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240046

This change is required for below PTS testcase -

1. MAP/MCE/MFB/BV-06-C
Verify that the MCE sends its MapSupportedFeatures in the
OBEX Connect request if the MSE declares support for the
feature MapSupportedFeatures in Connect Request in
its SDP record.

If Server's SDP record contains the field 'MapSupportedFeatures in
Connect Request' as supported then include the supported features tag in
obex connect request.

---
 obexd/client/map.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index b8820335b..2fd0f74ec 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -39,6 +39,7 @@
 #define OBEX_MAS_UUID \
 	"\xBB\x58\x2B\x40\x42\x0C\x11\xDB\xB0\xDE\x08\x00\x20\x0C\x9A\x66"
 #define OBEX_MAS_UUID_LEN 16
+#define SUPPORTED_FEATURES_TAG  0x29
 
 #define MAP_INTERFACE "org.bluez.obex.MessageAccess1"
 #define MAP_MSG_INTERFACE "org.bluez.obex.Message1"
@@ -2179,6 +2180,23 @@ static void parse_service_record(struct map_data *map)
 		map->supported_features = 0x0000001f;
 }
 
+static void *map_supported_features(struct obc_session *session)
+{
+	const void *data;
+
+	/* Supported Feature Bits */
+	data = obc_session_get_attribute(session,
+					SDP_ATTR_MAP_SUPPORTED_FEATURES);
+	if (!data)
+		return NULL;
+
+	if(*(uint32_t *)data & 0x00080000)
+		return g_obex_apparam_set_uint32(NULL, SUPPORTED_FEATURES_TAG,
+				0x0000027f);
+
+	return NULL;
+}
+
 static int map_probe(struct obc_session *session)
 {
 	struct map_data *map;
@@ -2224,6 +2242,7 @@ static struct obc_driver map = {
 	.uuid = MAS_UUID,
 	.target = OBEX_MAS_UUID,
 	.target_len = OBEX_MAS_UUID_LEN,
+	.supported_features = map_supported_features,
 	.probe = map_probe,
 	.remove = map_remove
 };
-- 
2.34.1

