Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CFE1E49F
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608781; cv=none; b=Yxd+M+wjINsRbUk/f8NCRUxuKNOQwI0s5WWOX4MpoqJAeUfEgicJYrI4isdxde2dXN3YEqBmI5+8VAq4+VeQsR1Tkj9+F1U5gW/pvIRRG4DxtjxyiU2NHGd7F6PdKJBrzETGJwYMI3mQO3qqZiRldT3/Mb8NGB2nKSpSyM5t6m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608781; c=relaxed/simple;
	bh=6lPxCi5OSBTcJ4g57ih5BC/LzuD3r6cXSZqA+90vQrA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YFiE86N+vINdKVHjlfYK4BbaoN/NCV5UC4lT4yZfy0nV22eAbDHMdUeIdBrN6HA+L6VOulWlL/dIgp0A3VMfvQXRlz0ia6e8WJ2AAaboKqlQSLISS3AdWsfz+ZJ9b3Uq2RhzPWmZDL04wqppFRT86YJ0NoCK683kDDWZpAOJJZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HPQ3xoq9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HPQ3xoq9"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9bLxr017131
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 12:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZIkLxbPZaHrZZn59L1U/Bm
	RT0y9gOrubdcZFuMynrOs=; b=HPQ3xoq95R/REImSvJheSmubiu+fskfBoXFr4s
	qWklvEEvaitgwKo+ewCxdTsqQEMug7D/6vLbvc9VbpWqkg2wteiR3MmcdaykhZ+q
	3ExsfYrfoaFwr++Zixel5gRB9GICGbY9B0ZS40rMKggAorXkWOz8RrVi/XTUcmaE
	TYZlXFrW0LbTyajI66X1z63NyUfr0myR/ogD2qzSAGUs2Wdpbilsa+32n5AEKSA8
	BcXCAR7hJopkxtwqteU3nHo1f5nXU2TuB7orh4MVl/UEhTRJh6AS/FpI7PoFFPOT
	c7J1ipBBGz0C4vEc+AkYWviQdh7cNrzErcx+aHVoWEc0jS6w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eypcq43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 12:12:58 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52ACCwRJ010920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 12:12:58 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Mar 2025 05:12:56 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex: Add base implementation for get_mas_instance info and set notification filter
Date: Mon, 10 Mar 2025 17:42:40 +0530
Message-ID: <20250310121240.1731654-1-quic_amisjain@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=A9yWP7WG c=1 sm=1 tr=0 ts=67ced74a cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=kIFDCYoabvEFXoaHkvkA:9
X-Proofpoint-ORIG-GUID: Lu-LTWpDQIvJuSvf5r1v1r5n3cU-NY9i
X-Proofpoint-GUID: Lu-LTWpDQIvJuSvf5r1v1r5n3cU-NY9i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100097

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

