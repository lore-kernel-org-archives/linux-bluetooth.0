Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006AB2207A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952858; cv=none; b=WqsERnFH+i20POGxVIPIn0oywhy+4HvaqARZjERlJ/m9Jn4xHx1rrVOkifsttZ250VEK5mQc9SHK0VGwyeU+UeTVs5p5xBfNjLzYzC7uDg1TQimXiGijj7KAcsKLFBifAl9xuXZwmHeZDjWUgTZfJQL46Xie5/5E3WJ+uR2zdmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952858; c=relaxed/simple;
	bh=wJFjDXVUwaLlc2uOUh1NPcOsQd0Qb8C+9Bhdu6xpaDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PGE1el6WFv4hDi7Rbwij9ugaASrlCb1ED9IuRnYErMJc+xpx0yB9Y/owRcctr0PKmMumYFA7uRTL4/rrojSaOTyMo4yG8+9KSN88JYSedyxZlZ2DJ60l5IeJMi526OBQ7RwWZx6b2YvXkRPdPufHHwhkfNywPEk5wQ6OS7LDMAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WUv1cIps; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WUv1cIps"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN6mNDI004607
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 11:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=j5Nt+ZFRX/fvkd1+xCV0fD
	HQ3zx6Ugt+Qpn0c4RB8SU=; b=WUv1cIpswzRGE7VnYWUEPxvnFMdzdd31cVOuea
	yItd2hzrwC49D6HvAZJI1MzOIWXdrt9yofcL067kD3SFBkEYdPxCSxufDpP+ZaTd
	oEwyVLMgb0QXjn6robkA9XSYUWasnd8K9iOshFH1orIbkrOk9q5pNl1wnJ5UYvT1
	MQBxWhlPJKe2qvAQSgFSoDB4wndL0zBGs70VB33N5KR3xdVwvEX0ZkrNiQDTsYSJ
	IdXxqZlPJNmfFyaVGJrCwZ+l8E1/qrCdRsesHzHDnPKDPxc6rbS4cjZJarjv9juk
	CmS45aVHVdyW7cI4O7ypAkLFhs4wnkhnEAhuJCxwrGudSsBg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q2ww8wcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 11:20:56 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BNBKtwb013268
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 11:20:55 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 23 Dec 2024 03:20:53 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v3] Doc: Obex Implement support for message listing format version 1.1
Date: Mon, 23 Dec 2024 16:50:41 +0530
Message-ID: <20241223112041.2657934-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Lrdgf7a5BkXLMV07d3k5Wr7YzWyqEJaX
X-Proofpoint-GUID: Lrdgf7a5BkXLMV07d3k5Wr7YzWyqEJaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=959 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230101

Add the documentation for the ‘Messages-Listing Format Version 1.1’
feature for MCE.

---
 doc/org.bluez.obex.Message.rst | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/doc/org.bluez.obex.Message.rst b/doc/org.bluez.obex.Message.rst
index 082f87271..9878dffe7 100644
--- a/doc/org.bluez.obex.Message.rst
+++ b/doc/org.bluez.obex.Message.rst
@@ -137,3 +137,42 @@ boolean Protected [readonly]
 ````````````````````````````
 
 	Message protected flag
+
+string DeliveryStatus [readonly] [optional]
+```````````````````````````````````````````
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
+string ConversationName [readonly] [optional]
+`````````````````````````````````````````````
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
+string AttachmentMimeTypes [readonly] [optional]
+````````````````````````````````````````````````
+
+	MIME type of the attachment
-- 
2.34.1

