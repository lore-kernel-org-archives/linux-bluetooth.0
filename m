Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD58855C29
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328304; cv=none; b=ZR5+llV0MmHaxMZfa/XKezPcvlAdHowCjTlFFSqldIRqd1VuWnd47jZ2j5jMSjXTvnoGKwHiNIK6P3xLGNF5RB2qLAsc16Aah6mGii1si5/FGrMJTB67EM1gBxK2uN/OS2uyzvUF4D+6dWX7oo3wMBfrNSTljG5Th+qmdmlgMhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328304; c=relaxed/simple;
	bh=8bT+CA0r5j6kpOiOfcchQDOyCpVafm5lOwJ/yQa5t+A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EUZtdkagl36aNQumB8I3OZggv9shIMHsptdUrApUv+O4mjaAIA7+nuMqnc+T/1eJMftJxkb3wdDyeJ2OuV/xxfx6Q6GoZYaAJ0RTbEeu7g6Zg+Ws2N8yHJzKpsWCbcmXF2RTPGzDU2fCvnLxIrXRZhc+qUUmFOTApm3Eg7qnMlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hAP/YPw6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hAP/YPw6"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAMvrP5018965
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 12:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MPK1dfXQ+OWR0ExRWQqh8v
	jUZJNiKzjoBQyK8OYiXd0=; b=hAP/YPw6+yLdNySP8k4tKUsD90ZTpcg85QN53d
	92pgSLQv3kI24jFiTC6tz4GUQJGxd8LT5rjx0R3X0r5SM9B/ogD4TC5t6M77Yoze
	7+8vHZREVo91d+SpQK1+vr0HTRVsGDT5Go+ui9QNvwLGAWRv/AyOz3QOyhrGGx7k
	oZJq2XbSm11WTxThvk3zo2f7xgH1V0o3Kzinbn09cL5ZL6BFClgR9DxnFb8c9QNP
	CECa+6N/apM5zNW2oJuaA+DTWDk37stikgGZjZj7SADo7ooZJ06I9tjSaVST1TND
	Tn4XZqT3VR0CIxvasVir7ZluILxuVlTQ9C1d1r+v3QvLC68g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sw3m4df1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 12:31:41 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ABCVehQ005567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 12:31:40 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 11 Nov 2024 04:31:38 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex: Check for supported features bit value for legacy server
Date: Mon, 11 Nov 2024 18:01:25 +0530
Message-ID: <20241111123125.2034898-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-GUID: GRH0tKy4jCRJpHfBMY3e-SBUY-DszJ_N
X-Proofpoint-ORIG-GUID: GRH0tKy4jCRJpHfBMY3e-SBUY-DszJ_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110104

This fix is required for below PTS testcase:

1. PBAP/PCE/SSM/BV-10-C
Description - Verify that the PCE does not share its
PbapSupportedFeatures bits with a legacy server.

Incase of legacy server, check for 'supported features bit'
uint_32_t value instead of directly checking the pointer
holding the attribute.
As pointer 'data' won't be null as PbapSupportedFeatures
attribute is present in SDP record but it's value is zero.

---
 obexd/client/pbap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index bc3fdcf9f..09d3fd425 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -1219,6 +1219,7 @@ static void *pbap_supported_features(struct obc_session *session)
 {
 	const void *data;
 	uint16_t version;
+	uint32_t features;
 
 	/* Version */
 	data = obc_session_get_attribute(session, SDP_ATTR_PFILE_DESC_LIST);
@@ -1233,7 +1234,9 @@ static void *pbap_supported_features(struct obc_session *session)
 	/* Supported Feature Bits */
 	data = obc_session_get_attribute(session,
 					SDP_ATTR_PBAP_SUPPORTED_FEATURES);
-	if (!data)
+
+	features = *(uint32_t *) data;
+	if (!features)
 		return NULL;
 
 	return g_obex_apparam_set_uint32(NULL, SUPPORTED_FEATURES_TAG,
-- 
2.34.1

