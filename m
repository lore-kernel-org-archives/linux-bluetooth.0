Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17C1C5488
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734699582; cv=none; b=GtRuT/oxFdsn4IxnKL6UTMTzR5WrF4wIOISKJry6ten839OsQlgd6axnd1WoL4cDS1PpnK8fPdkZI+kQOwKCa/2QPOz5huiQ5FPb++TmWPwgH54MsyDdK4OKKYM+XV0p5jLvRYc/l60e3d+Oc+wQZrvpLFDO0u8EcHlebb0n0eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734699582; c=relaxed/simple;
	bh=9xaC5VR4jL68zdRIjO40Kll/mReODSHx4O4IWR5P+Ow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KxtTMUsBg9/m2B/1wnbibXEMtVQs9mo0SR6cOWX/BsGPNol6QyPZ8CIORuMdMHIAgBcPtVrUu/tGo6NhtRwtzcq5PtWsvgp0cGk1OUnwBDVPz1+pUu7DaBtM4VIjaqTGqf3SXr1wjehYdTpjtOWuVxw9w5jhjEdJooDd9mGJYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NIx8aQSD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NIx8aQSD"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKADfJ6008335
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 12:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=D+O8SRH2WQKUpvgarxkpyb
	y8SHfljGT5Oo4Y83UI2D8=; b=NIx8aQSDj7yaaIUHOoxSI/BJVpULgj3N+BJQ3x
	4UwIviyFEVzeiZwIXByssz+DszEqp+Ng/W5fbZ0RbqJZoy3WVACeH04xyXTtADuW
	zv7VhZLKHjo1xlll7M/qk1iUHr8SMNcirZZTo8CBN0Viv7PoakR9/xsfm65//N4z
	JYl6GXrL3Vhm4mtvm4EdjwBAus0jx4tE+BXu3Ye3nX1MLLenlAcMiAqVVsrgj/Yz
	6C8v2e9BKBHYt52XBwOaz/F9OAY9b6hfncAXXZZ9ylT2R/fOS8z7iEQC17o/drVe
	PN5VIDitoCAQ1y5CcI6Ih/NGd1wJjH9tQd4emsxSqkhPFKOg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n6n4gbxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 12:59:40 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BKCxd6g020059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 12:59:39 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Dec 2024 04:59:37 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] Doc: Obex Implement support for message listing format version 1.1
Date: Fri, 20 Dec 2024 18:29:27 +0530
Message-ID: <20241220125927.84698-1-quic_amisjain@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Dt5Gd0JuIlamAPg9kJsXHzX_w0bzkv_W
X-Proofpoint-ORIG-GUID: Dt5Gd0JuIlamAPg9kJsXHzX_w0bzkv_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 mlxlogscore=944 lowpriorityscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412200107

Add the documentation for the ‘Messages-Listing Format Version 1.1’
feature for MCE.

---
 doc/org.bluez.obex.Message.rst | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/doc/org.bluez.obex.Message.rst b/doc/org.bluez.obex.Message.rst
index 082f87271..260445970 100644
--- a/doc/org.bluez.obex.Message.rst
+++ b/doc/org.bluez.obex.Message.rst
@@ -137,3 +137,42 @@ boolean Protected [readonly]
 ````````````````````````````
 
 	Message protected flag
+
+string DeliveryStatus [readonly]
+````````````````````````````````
+
+	Message delivery status
+
+	Possible values:
+
+	:"delivered":
+	:"sent":
+	:"unknown":
+
+uint64 ConversationId [readonly]
+````````````````````````````````
+
+	Message conversation id
+	Identification of the conversation
+
+string ConversationName [readonly]
+````````````````````````````````
+
+	Human readable name of the conversation
+
+string Direction [readonly]
+````````````````````````````````
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
+string AttachmentMimeTypes [readonly]
+````````````````````````````````
+
+	MIME type of the attachment
\ No newline at end of file
-- 
2.34.1

