Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C948E19D8A3
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086128; cv=none; b=edGcyhgOY/+eH6mgGQHsYNMuiFXyDvROcsLi41C8133RFEJIeacaGtttoui6V65gJozsVXsOe83S7M9K8Xbah8K2xONCdic1xlGQP53LmYbtWTx7dqZVH17YvosG0bpG9CQs4GZ7NZqpdBPjGVpe/tFvDHqyMG2KO3aGffIHo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086128; c=relaxed/simple;
	bh=YwswkQBuX10d8PhsrRKXnLWEL5OdxlGpp8WFyRYJKDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RVRO2rIfJaqAordRiuOeyq+gXjctRx17bBtyM+O5KEQpubkHujg8qRZ0VbdpCkuLb1TEkBRGP1/EnGonKMHNGscTdaz6meqIy99gf9Gez3uETXg3az0YnUV5QSNmBPM0/EIRkQhI4mTmI2BiipwPLhloMLcIQLH9MEk1z1Mwlzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H+vgzWbI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H+vgzWbI"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SCiY3c028790
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 17:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zqTKXqkgsWh0ec4bqFvYwn
	Z5tgPTJ0+BTdYIdnLBJG8=; b=H+vgzWbIFaAzHwsH9Lorsu1wlfDADAb+rS33/Y
	d7UwBB1HA6CHVlBWnZFdYIZcJZRLOYzqI3VSKNib3UWBnBzvbxZnq8xGp0xHoy2R
	cJpG8rdW79oC36f45NXMblzEiObMxuapBHWP2u/rcGpuwlVroIjwN8xmnk/zEe2j
	g3cFL59OBizlOfjmWm3DSQjtzWjE/hII7Vzz4x/gw0NKf+9hHzZsZttR+fOI4wLS
	ADf9Yg7Y7QrYbYNreKkj5YfSeN0iwUf06VmI5u6DRbuVjnCDc5NeJitwsaj4Quj/
	ND0HoO32C5wGVFbBUQyg4TztQs3xSu+vHK8vtcwMTTKbiH3g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44eygu8rer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 17:42:05 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50SHg4SA023366
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 17:42:04 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 Jan 2025 09:42:02 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex: Update the MAP Client version to 1.4 in SDP record
Date: Tue, 28 Jan 2025 23:11:30 +0530
Message-ID: <20250128174130.1476094-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-GUID: 2zfdskyvr3Pu_BC4l0SJMws6X4dpi796
X-Proofpoint-ORIG-GUID: 2zfdskyvr3Pu_BC4l0SJMws6X4dpi796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=886 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280130

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

