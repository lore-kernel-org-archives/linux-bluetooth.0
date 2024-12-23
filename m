Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB92AF1D
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947786; cv=none; b=rFKhDH9Os1Y3/qjFO83X6++wGKzi5nSTtt3ipAhgcTJStTh1wN5aAVLtqO+10yNyiTP7xgxTvjgAEcoCMUU3Oqi1K7v/TCTZ031To+5dAozAmwm3YaW3tsAgkzFKaOjJcvoh2hQn66kLz8+P4AODb2f9s1kW3JHn8n5OXJuyJDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947786; c=relaxed/simple;
	bh=u8X2hkFMM6AG5dtzCm5Q8gG9BrXokMprFfsLH66/ZNs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PihhKgwc5F7rAvPDJmvaePipnELcDIQjwkHelOQa+NyCGN9PXWvw8YYqIRdzMMff9ZiO07WmEPWtIUSVIdDZ5avFDuJpje3n4rf3WKlrEpiLZzKI24Ul4FFl9ceRqX372uEVGd/aC4YBhx001Mp257LCDrTMtKKdgscCWZEN9TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=guoNMnMk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="guoNMnMk"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN9P24M014128
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 09:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=aJkAyze4mMIQhO0gY+f4At
	DwcoozNz/yK88MKsg7evI=; b=guoNMnMkI3ckOlw4zSEA+w0HsS51qRgz8X41W8
	hWJCVfvRieEbDBflh67/3A7/DPaAjCuyofgZOuidOz3Tbrpt13enIdO34UwkYhmF
	dDCfV0gQHUgE/YD5V418W+QCndIfZLmq21yh5aLX1LTX9z3uePNreUSORQCNqno8
	YCTeBjIUivdY6z8MlV2rH6RqR5ocHcE0QzaT0IPgKOt+S41IJlYQP/0QqwUdBlti
	5lpYJ9Li8+KNgfFhIgX75e2fDf6PBfoPEDlqF75J8VMa5Lzf1o+Jfcq/dZ7YyCJi
	suc7lca7jzWMcLo1XxBndhjWSpQG3mxUi6v5a/66xgr0xL2w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43nn8vrn4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 09:56:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BN9uAFP013698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 09:56:10 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 23 Dec 2024 01:56:08 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v2] Doc: Obex Implement support for message listing format version 1.1
Date: Mon, 23 Dec 2024 15:25:52 +0530
Message-ID: <20241223095552.2193911-1-quic_amisjain@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1NIRv-rYhEau7DrA0HsBl_kx6V-Kta8g
X-Proofpoint-ORIG-GUID: 1NIRv-rYhEau7DrA0HsBl_kx6V-Kta8g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=945 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412230089

Add the documentation for the ‘Messages-Listing Format Version 1.1’
feature for MCE.

---
 doc/org.bluez.obex.Message.rst | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/doc/org.bluez.obex.Message.rst b/doc/org.bluez.obex.Message.rst
index 082f87271..6acd18583 100644
--- a/doc/org.bluez.obex.Message.rst
+++ b/doc/org.bluez.obex.Message.rst
@@ -137,3 +137,42 @@ boolean Protected [readonly]
 ````````````````````````````
 
 	Message protected flag
+
+string DeliveryStatus [readonly] [optinal]
+``````````````````````````````````````````
+
+	Message delivery status
+
+	Possible values:
+
+	:"delivered":
+	:"sent":
+	:"unknown":
+
+uint64 ConversationId [readonly] [required]
+```````````````````````````````````````````
+
+	Message conversation id sent by Server
+	Unique identification of the conversation
+
+string ConversationName [readonly] [optinal]
+````````````````````````````````````````````
+
+	Human readable name of the conversation
+
+string Direction [readonly] [required]
+``````````````````````````````````````
+
+	Indicate the direction of the message
+
+	Possible values:
+
+	:"incoming":
+	:"outgoing":
+	:"outgoingdraft":
+	:"outgoingpending":
+
+string AttachmentMimeTypes [readonly] [optinal]
+```````````````````````````````````````````````
+
+	MIME type of the attachment
-- 
2.34.1

