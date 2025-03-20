Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B518216E05
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460261; cv=none; b=DROhIguH6j06ZerRe3QC1yUIgCL8STCJ439AUZeLq4jeSGIpdj6F/x6llxuISzecxaDdZmT5/CtyKQ1PkO9fol/UMV6P6WzADZhlxy7XLpf29z4LhMDmqmE9LCz8vXhi7tmqdeQQOnde4BxxnPoROxwJGWfT0P/K2KgYhRUqm4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460261; c=relaxed/simple;
	bh=6lPxCi5OSBTcJ4g57ih5BC/LzuD3r6cXSZqA+90vQrA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aZg6K9+JY7swQnUgsLeZeeBifAbi/ldFxu7bdTyXPR7MIZ5+z7PV7F2E2lH9ww5vaG0uxVtSZ+9ayRZSFNhojZCIiaHb/b6IjAhZ4VBpipQQ5LVujXwYsX+m5SNcjts2WPa+BZufBW9wP6EEpqO4dCs2OdLug+6fStNgTJAF0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YVoS5Kso; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YVoS5Kso"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6YtAG004905
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 08:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZIkLxbPZaHrZZn59L1U/Bm
	RT0y9gOrubdcZFuMynrOs=; b=YVoS5KsoLm61+KkP1t9oWVPn08N9kKFsxROjag
	GkvrBjGzL5CFcZv0t+dxYGNxm6e5TsvWRs0rbumcAzaduVwzi+EsaUN0rqI7to/A
	sy5slIF4lNu9MnKTdZWjuW3ZV3idG95lRieAbXrcqT9ms4zaXOd2PLiCTHoON+Dq
	Y+Z8bUneSuvJCNTO8RB9kKJmb5zicpmDyCpxNDXzbU6ODtz2KfpjJzLG3VA8UAen
	mXXrWHGdmALg4mEIl57qjfgAdZyDyyQ6nh+m+vcikvLLR6UU2Ipnv80V/GGs3B2q
	1wmWHOKHh030HrqOcx9kHbmKXJkfD2UKyNP8bHga6FTlp8Tw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45gcd18hre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 08:44:15 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52K8iEhH020283
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 08:44:14 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Mar 2025 01:44:12 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [RESEND PATCH v1] obex: Add base implementation for get_mas_instance info and set notification filter
Date: Thu, 20 Mar 2025 14:13:56 +0530
Message-ID: <20250320084356.4050233-1-quic_amisjain@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=bfFrUPPB c=1 sm=1 tr=0 ts=67dbd55f cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=kIFDCYoabvEFXoaHkvkA:9
X-Proofpoint-GUID: m-6nlXS_tNuSVtLeLwmg393KhFtV-g-4
X-Proofpoint-ORIG-GUID: m-6nlXS_tNuSVtLeLwmg393KhFtV-g-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200052

This change is required for passing below testcases-
1. MAP/MSE/MMI/BV-02-C
   Verify that the MCE can return user-readable information about the
   MAS-instance to the MCE
2. MAP/MSE/MMN/BV-06-C
   Verify that the MSE correctly responds to a request
   to filter notifications.

We are adding the raw skeleton implementaton for PTS certification.
Although the functionality can be added later as per requirement.

---
 obexd/plugins/mas.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
index bf8d689ad..6076ad44c 100644
--- a/obexd/plugins/mas.c
+++ b/obexd/plugins/mas.c
@@ -782,6 +782,36 @@ static void *notification_registration_open(const char *name, int oflag,
 	return mas;
 }
 
+static void *message_get_instance_open(const char *name, int oflag,
+					mode_t mode, void *driver_data,
+					size_t *size, int *err)
+{
+	struct mas_session *mas = driver_data;
+
+	DBG("");
+
+	mas->buffer = g_string_new("Mas Instance 0");
+	mas->finished = TRUE;
+	*err = 0;
+
+	return mas;
+}
+
+static void *message_notification_filter_open(const char *name, int oflag,
+					mode_t mode, void *driver_data,
+					size_t *size, int *err)
+{
+	struct mas_session *mas = driver_data;
+
+	DBG("");
+
+	//TODO notifcation filter add
+	mas->finished = TRUE;
+	*err = 0;
+
+	return mas;
+}
+
 static const struct obex_service_driver mas = {
 	.name = "Message Access server",
 	.service = OBEX_MAS,
@@ -866,6 +896,26 @@ static const struct obex_mime_type_driver mime_message_update = {
 	.write = any_write,
 };
 
+static struct obex_mime_type_driver mime_message_instance = {
+	.target = MAS_TARGET,
+	.target_size = TARGET_SIZE,
+	.mimetype = "x-bt/MASInstanceInformation",
+	.open = message_get_instance_open,
+	.close = any_close,
+	.read = any_read,
+	.write = any_write,
+};
+
+static struct obex_mime_type_driver mime_message_notification_filter = {
+	.target = MAS_TARGET,
+	.target_size = TARGET_SIZE,
+	.mimetype = "x-bt/MAP-notification-filter",
+	.open = message_notification_filter_open,
+	.close = any_close,
+	.read = any_read,
+	.write = any_write,
+};
+
 static const struct obex_mime_type_driver *map_drivers[] = {
 	&mime_map,
 	&mime_message,
@@ -874,6 +924,8 @@ static const struct obex_mime_type_driver *map_drivers[] = {
 	&mime_notification_registration,
 	&mime_message_status,
 	&mime_message_update,
+	&mime_message_instance,
+	&mime_message_notification_filter,
 	NULL
 };
 
-- 
2.34.1

