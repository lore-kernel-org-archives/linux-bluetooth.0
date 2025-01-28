Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E7319D8A3
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086224; cv=none; b=ZWowh01Ty0GuH1y2tOCB7JXD5MNTkSedeVS6Qu3CzdfjVxUwKmRxNqSmB1LplLg1uUv9IqwDqVCmWE+L61Zu+9u2Njs1gWVAm0vERGmHUohCtXhKApEHCm3l6JeJEtnTK0cPOGwAjMbqT6XtzofFz0qc7fBITQVNjpwcYX80WXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086224; c=relaxed/simple;
	bh=joZnUU8i0fCfRaIAEKqlLfDmlCF7N7D8mkmwzrWLEaA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f3/oG6ygrvIGO/9s8l9r3qIguMtigSciS8CtC0kY3UNymtN5pP468Tl+fefmJ1eIYbwODEA/nxsCtRwVb2PMRweZqUn5L38DF6/UxRF/l4efFdga+ERCfKL6PjD/VB5N0l9/KxsUQm4Fv72BLitfSg7EwD29GTfmqorEOP5pbzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nFoq9r6V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nFoq9r6V"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SH6iX7032661
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 17:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=D3wtnnrMGB/7yMz7EPUCJq
	NUifkTT+fj3hzFfmaODmA=; b=nFoq9r6VjDy3MDBusVulWJP37VmCW/sTODppoH
	AbQ6q0K2ni4E+h7afwtn/1e3/Iwnrj5a2yXMHN+BV2X05j5AZsyTORHgv9ikGePV
	f2wwnHAB3oxIX7VycNyOLwDHIL4DWBFpayJ4DjU0+C1n4WdB1FiOaEtQPQeCwyue
	NICflQ7kGdjpls3JsAi6i/U0jiFRxx2CL1D6V0XdfJiQojYNMomIV0NjjQZaD8Tz
	fRs9XcuYfotLPgTC5QyUP3ZcB++bTJSAXxSrWcm4+h8JEVuNt9PhDZ5JrbnrgJxr
	VXHcLTu2kHZtRiqyDnmLAjXlp2d7NkqWUAM9IhDcpfL4snqQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ernksr6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 17:43:40 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50SHhdsB009998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 17:43:40 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 Jan 2025 09:43:38 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex: Add supported features tag in MAP Client Connect Request
Date: Tue, 28 Jan 2025 23:13:27 +0530
Message-ID: <20250128174327.1477546-1-quic_amisjain@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Wn4no7GKj-ulOiwQhX5GVbRaJHb3AYJL
X-Proofpoint-ORIG-GUID: Wn4no7GKj-ulOiwQhX5GVbRaJHb3AYJL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280130

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

