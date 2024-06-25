Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB41CFB6
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 06:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297367; cv=none; b=NwUJ8Lk8FlUtmN98iLDUYxwS7lSnOde8bjlLfRaixr4hqwYZNot92cApTfBFBslLix3UlLY1+9I2gyBRHSrCSQZvMr1edvav5Q8bHhnN95z8JYVEJZLvR8xnqptY6NUZ80HYDUbbgnDmVXzlV61AyQAw3mLq/4UtHvWaychwNoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297367; c=relaxed/simple;
	bh=0AYK0hkvjTabxPYRFX7ETdPe819Duf6ITIvky/gP/pQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HYM6hMz3vE/+k/Z5tCYQDgL+pFN/7cjq70DpacQ2AWLGDhdo+PDzwG8onp4xylkUI2r7vWNlGdR8sT2oI62pABd0JrQ9cCyuTOgZCgMQ8uhPJKSO5w+JTq1RvpA1j+p8QjduQvu3rYm8IQTgonKOc2TqJ4UV2YXiPtP9rTY0A/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jCBXWdt7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jCBXWdt7"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OIkYaQ023773
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 06:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=FIMId5XhZGltfVu7JzpvBlzHfY5AFJm0gB4zah5HRjI=; b=jC
	BXWdt7Wo8+JxmVfQVAW7hXrbezIf1dz1e7RDMG5YTofhxBLHgz7VqS1yO/y5Y1mi
	McFsUebE+H5NxHY5/pfEV5F5JvjiZRgY+t8+s2KwpfdCBbqtMaMoX9Qnalve+XbE
	LerT62+P7VZ7kUnLkXto/dz9WwjqvIhuMBo3fpdC3X+yQaDQtfeAe1/EscSJxudr
	K+CtlSwHPHwkf5po06WFJGBa607GvDurR4aGoKura1eb2GEpRrOAigl+opWD78IA
	AytrL0N5t7tTR10SjX6IOal99qxjwEcvJm/PxwH+NOk5TiBJ4Vfg/dV6E/zvy3aw
	tBiOPInVI8wzd47T99Pw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqshnnkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 06:36:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45P6a13d025514
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 06:36:01 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Jun 2024 23:35:59 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v2] Bluetooth : Update the mas session structure
Date: Tue, 25 Jun 2024 12:05:33 +0530
Message-ID: <20240625063533.30536-1-quic_amisjain@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rpc9DJHBIbV25fj7vIQOIEF7d2VjWvY9
X-Proofpoint-GUID: rpc9DJHBIbV25fj7vIQOIEF7d2VjWvY9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_03,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406250049

Update the 'mas_session' structure such that
manager_emit_transfer_property(os->service_data, "Size")
will get the proper structure in arguments as
expected like structure 'obex_transfer' and transfer->path
won't be populated with inappropriate value.

As there is no new transfer registered during mas connect,
hence setting the path to NULL to avoid invoking the
g_dbus_emit_property_changed() property.

Signed-off-by: Amisha Jain <quic_amisjain@quicinc.com>
---
 obexd/plugins/mas.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
index 10b972d65..71bf12ad3 100644
--- a/obexd/plugins/mas.c
+++ b/obexd/plugins/mas.c
@@ -51,6 +51,8 @@
 #define ML_BODY_END "</MAP-msg-listing>"
 
 struct mas_session {
+	uint8_t notification_status;
+	char *path;
 	struct mas_request *request;
 	void *backend_data;
 	gboolean finished;
@@ -59,7 +61,6 @@ struct mas_session {
 	GObexApparam *inparams;
 	GObexApparam *outparams;
 	gboolean ap_sent;
-	uint8_t notification_status;
 };
 
 static const uint8_t MAS_TARGET[TARGET_SIZE] = {
@@ -125,6 +126,7 @@ static void *mas_connect(struct obex_session *os, int *err)
 		goto failed;
 
 	manager_register_session(os);
+	mas->path = NULL;
 
 	return mas;
 
-- 
2.17.1

