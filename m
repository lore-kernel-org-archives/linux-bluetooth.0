Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6751E5738
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250357; cv=none; b=kbsmAJTpCrLyEhh50I5XFIuYJnZHhd9JNkpILGmkTxPL7wEJaww0w0HQqoD0zuEswjcFY4pUGOyjioFoe5nupj/NDq3foGeg5yWyl6ak4dDg3qO+xmq2w84BVO65nRjd0WrxEJWGNoCjhyQq1qB6EzOt+PXPCAwaXwjCID2pEF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250357; c=relaxed/simple;
	bh=wJFjDXVUwaLlc2uOUh1NPcOsQd0Qb8C+9Bhdu6xpaDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e6jkeeEZzfTp2k1r2w6OlXh7qV1wr/+p0c03SKkndZSrVplyHLtHM3wp7IwVHqgbW7dE2UjSqxWgVF1du4bC8GyMKzzjshV0IDocMsgvbpmONfg9y3rYrdk2ly+rooJN5tbbQeuGRsqUNcFJQld0k4LS8mWs9o/WNAbzKX+1B+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lls+d8aR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lls+d8aR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5073xYW7008546
	for <linux-bluetooth@vger.kernel.org>; Tue, 7 Jan 2025 11:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=j5Nt+ZFRX/fvkd1+xCV0fD
	HQ3zx6Ugt+Qpn0c4RB8SU=; b=Lls+d8aRBixXq+7fpSbPu5YogSwQ14saG58aIs
	ZD0PpAViFrFGkD+hlz/nh4F6d5n57i2F/j1ZTZ5M1wHTrZWsVwFsKxn49HpYjdRk
	NuqDy4n6KaCdX9z+6djWyjYps1cJh8eJew9sCARtOSy3zd2JCIIWOWESui4GtUYg
	699xhgeNazmqXyzodBW7YUmGfYsCxCZ8lb3mY41uv0RGBzT0XvNC4sWazEBshbQG
	ol0R3bHse9XvRUvyjIQixzlsiQS37olB7zPuUKj8gx6tMJaCulGUwZMfHtKqh5ME
	PtBPKmqYnsaBjpXFLyFtyufdHPE7Bc7m4XeMSlC8hLszznTQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440vuq9279-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2025 11:45:53 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507BjrgH012461
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 7 Jan 2025 11:45:53 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 Jan 2025 03:45:51 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v3] Doc: Obex Implement support for message listing format version 1.1
Date: Tue, 7 Jan 2025 17:15:32 +0530
Message-ID: <20250107114532.3593843-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: O8h9-YUgw5znG4wBoBcKoCro6gwlSUmf
X-Proofpoint-GUID: O8h9-YUgw5znG4wBoBcKoCro6gwlSUmf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=951 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070098

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

