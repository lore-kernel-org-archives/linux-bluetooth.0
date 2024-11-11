Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1241215746E
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331373; cv=none; b=S9yit2PjvX+enRGoCWdrvUvTovVqzoEd/JdeUaKWU8c+WIdMrZwiCY/dvpmS4bdf1sDZoeP4axPL0OJexYe0EaWkx9eNyK15HY7Mn2cPxcwUYZCh0yiJ70zkbew4ODePrvn2eDyDZxeQutf6RZsJBuREMbkzHEqkO6bKs4flOsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331373; c=relaxed/simple;
	bh=Ai3nQePRy6cV0HMP1HzH73ywj9NuMjNqF9W6X3dDJeA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dfFaO0ohoFcYbRfMbrsNUH+zbKZfCcVr2ebQu5tDi+x8ntMntUS7ji9YVr6HIv9+CoJjHWc8yuniGd5dyXUtlbKeTj6Ve774yQQi4QaHdN5r8hrZRC3SkTBgGRHErnJrdep+FfbfadEaB33vpihdQV7q5MPKHvmw18tIQcriuMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AoIQfmzq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AoIQfmzq"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABCKNpj031792
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 13:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FSzwrcGuMxpV6D4eGzam+W
	umKqpJwpLuB+Vtcr4EQKU=; b=AoIQfmzqf/h07SCwk6lvr0HIVd40IITV4PEXYw
	jQaiXkRD19jPRmwILMwK/AlWK5yz/AvOxA2WxszgMbDG08893i3nqVV8AG2bZkpc
	qA7Sn/XnPx4PhzRK6bscrwj8eN13BE4vn6Qz8AobfCivD2/YtzIOEoYzeadgrPef
	2etp6ouNKC4UGpLROkNYs1cI6qiShgiEqxSuC42jZpvAjQrbVeg+hnO/NnPjGcT2
	6bCEUXBudm653p/ZVqr4vRRO41thgixDEj9J3o3Tuphif/i3Hw0v2y5HcP0p8Jal
	orYN9V6cdLrnMxl5juR4jSZYsUxEo3xtcTp3M84HpGjtgpYA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t11846yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 13:22:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ABDMoR7000905
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 13:22:50 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 11 Nov 2024 05:22:48 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex: Update the FTP version to 1.3 in SDP record
Date: Mon, 11 Nov 2024 18:52:38 +0530
Message-ID: <20241111132238.2162878-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: XTffwxPyrl7MYUistX9ziz-3uMQ80Pup
X-Proofpoint-GUID: XTffwxPyrl7MYUistX9ziz-3uMQ80Pup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110111

This change is required in below PTS testcase:
1. FTP/SR/SGSIT/ATTR/BV-02-C
Attribute GSIT - Bluetooth Profile Descriptor List

Current FTP version 1.2 is being deprecated and withdrawn
from BT Sig, so it is mandatory to update the version to 1.3.

No additional changes are needed for supporting the new version.

---
 doc/supported-features.txt | 2 +-
 src/profile.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/supported-features.txt b/doc/supported-features.txt
index f04cf4a2f..8b71bfe17 100644
--- a/doc/supported-features.txt
+++ b/doc/supported-features.txt
@@ -36,7 +36,7 @@ AVCTP			1.3		CT, TG
 AVRCP			1.5		CT, TG
 
 GOEP			2.0		Client, Server
-FTP			1.2		Client, Server
+FTP			1.3		Client, Server
 OPP			1.2		Client, Server
 SYNCH			1.1		Client
 PBAP			1.1		Client, Server
diff --git a/src/profile.c b/src/profile.c
index c62224af9..6bc6778de 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -2126,7 +2126,7 @@ static struct default_settings {
 		.mode		= BT_IO_MODE_ERTM,
 		.authorize	= true,
 		.get_record	= get_ftp_record,
-		.version	= 0x0102,
+		.version	= 0x0103,
 	}, {
 		.uuid		= OBEX_SYNC_UUID,
 		.name		= "Synchronization",
-- 
2.34.1

