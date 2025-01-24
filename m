Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937781D6DC8
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737700887; cv=none; b=OHIMmGSMykzJTJsoXRF1mHU7g2MEuqgOlvb7l01jEpG4sD44JfxoDz8gZLpKR6vl+4hyGkImH3gmNppUV39l0UTwcqV5sWYL/0mh4H8K36MfiipNY1BKxEsWm8k/07Bzb+oZjFyXEt8Mp/Bvil9rbxX38MzElAdLfATz+yUsfDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737700887; c=relaxed/simple;
	bh=YwswkQBuX10d8PhsrRKXnLWEL5OdxlGpp8WFyRYJKDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B7Z3GtLIVd+iFC16hC5KXBXB+H4sC8Oep1TKLN8OCaYBPtkljQWci5NZs0GgSz16rU1iZbEKLoJdOpnlGVHfu5AB/IPi7ayRdGf6D9xOU9S3TS+joVbp3IO2U2/vG596erpVN/EQIDNlYobGnH1S+t9qANIevMcZnRX3X2nEKkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z8XpoLBl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z8XpoLBl"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NK1gMU025117
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 06:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zqTKXqkgsWh0ec4bqFvYwn
	Z5tgPTJ0+BTdYIdnLBJG8=; b=Z8XpoLBlw9dTwZJLXILZujZAFuJGBExaQ30Cmh
	JzndsXnj8hS5npDdK1q6y+PvS7CGm8K1pi0uV3z3AEcXSCMpWr02+TcTwhzWzvLo
	PBf9ZDguJ//KJg2rol6joEP94B9V7d5HF1eFS8bIZCRXvIfz6EIgsD8OR8rmP4BE
	l7CMUSh+P4xSvcHIokOMzbd+651EVWn+x7F2i7202INZWXJZ5u53wVanPL8pY2eL
	ONm43sCxE+Q7q/HGy2PLMBGjkRFnHe2gq9gHbLEZa6zav5tEtZbNvEXxn9kAe5qv
	0sgX1ynyT/Cmi4K6wEKgp2pX/iTKtjNcEHK1yBhGwlkitaGQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bvenh39f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 06:41:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O6fOXs016021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 06:41:24 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 Jan 2025 22:41:22 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex: Update the MAP Client version to 1.4 in SDP record
Date: Fri, 24 Jan 2025 12:11:05 +0530
Message-ID: <20250124064105.1071400-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-GUID: gXREcq6_HOtGsAhpM64RxMtUvktRg0zo
X-Proofpoint-ORIG-GUID: gXREcq6_HOtGsAhpM64RxMtUvktRg0zo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_02,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=889
 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240047

This change is required in below PTS testcase:
1. MAP/MCE/SGSIT/ATTR/BV-10-C
Attribute GSIT - Bluetooth Profile Descriptor List, MAP 1.4

Current MAP Client version 1.2 is being deprecated and withdrawn
from BT Sig, so it is mandatory to update the version.

No additional changes are needed for supporting the new version.

---
 doc/supported-features.txt | 3 ++-
 src/profile.c              | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/supported-features.txt b/doc/supported-features.txt
index 8b71bfe17..5318dc68d 100644
--- a/doc/supported-features.txt
+++ b/doc/supported-features.txt
@@ -40,7 +40,8 @@ FTP			1.3		Client, Server
 OPP			1.2		Client, Server
 SYNCH			1.1		Client
 PBAP			1.1		Client, Server
-MAP			1.0		Client, Server
+MAP			1.0		Server
+MAP			1.4		Client
 
 HID			1.1		Host
 
diff --git a/src/profile.c b/src/profile.c
index 70ac058f4..af32dbd9f 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -2167,7 +2167,7 @@ static struct default_settings {
 		.mode		= BT_IO_MODE_ERTM,
 		.authorize	= true,
 		.get_record	= get_mns_record,
-		.version	= 0x0102
+		.version	= 0x0104
 	},
 };
 
-- 
2.34.1

