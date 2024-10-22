Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E93B84A22
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581888; cv=none; b=NfLmHR06YHcWSLifx6FcYJv1w67RxwEcGr2mtMZP+ZesvUYVd8KBwKgItoPDElNX6BCCLj+fv3hFk4EL7zTuFse8y+jCrcOpmp79M4kyt37vrT0A5mCCKzs9tmWDAqPlAg1oXSHAsrYCM22ns/lzsYN6zEDzpAxRIgU5hEOId/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581888; c=relaxed/simple;
	bh=sbTqdKY0dxaFB7r3wb+gisp5JGqP4dbRVR5dkGFYps8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gs77uXKa6keUaWevsXhhr48zNbUH0TTbo/Ju2e7WLyjLLCAkLBvB2s7myZ/9PEkchDs5jjR6utxYB+wqBWtbUsR7V2036T32Zv+g2Y/P23z3PRm0RYJG63fXDsKd0TulWYzkEMGujiroeIM6zff76meASAUKYDipW2ofykGeZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aEroBrgE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aEroBrgE"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LGiJ3Y014452
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 07:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4a0p3IfEcHgj85rVOboxjW
	ak3T9L0uaVbkMP3cSTpDY=; b=aEroBrgEJCr8H//VQeuhVNlHLFCl1i5XIkMyfe
	WImpmEVwATCmbN7zdFUt0wC8JGxVml/LAaJ4J0sWF32fh6idoZBVP87PrmS5jHR4
	8h0kQcyixHyItZf2PASAPYRLO3UEZJo523fQ/yfDKwRKITk4eYg4SuQISOBLOcLJ
	uNsb9MYnrxV3Oi1jihtWKEe/xRsGL8cXZMTeHD+7mMgm2PAzroXtkJ4Z2GbSiMmb
	TPgs8IGs7lHQi7T3bxgnevPOrYltsTylISZyyS1KHFAkcvwvzQfI50qpLELtnhEl
	WOcNI3yVWPWNMpXMYwZZYx/gy34fxGFnnZiX+P0sUcoalSsA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkhd3h6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 07:24:45 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49M7OheL022170
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 07:24:43 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 00:24:42 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex: Resolve SRM issue for PTS testcases
Date: Tue, 22 Oct 2024 12:54:23 +0530
Message-ID: <20241022072423.4080043-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: mtqMONBhbwsWkjQOTgIU17Qc8PGG8kes
X-Proofpoint-GUID: mtqMONBhbwsWkjQOTgIU17Qc8PGG8kes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=703
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410220046

Add check for unknown/undefined srm value.

This fix is required to pass the below the PTS testcases :
1. OPP/SR/GOEP/SRM/BI-02-C
2. FTP/SR/GOEP/SRM/BI-02-C
3. PBAP/PSE/GOEP/SRM/BI-05-C

Description - Verify that the Server ignores a SRM header with an invalid
value in the PUT/GET request and carries on with the PUT/GET operation with SRM disabled.

Current Behaviour - Server is sending SRM enable in the response even
though recieving the unknown SRM value.

To fix this, I have added the check to verify the valid SRM values
before continuing with SRM enable.

Change-Id: I399b1daacdcfa118137dc9798529514d36fd78ed
---
 gobex/gobex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 40d6b8129..4dc3d8b23 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -317,6 +317,9 @@ static void set_srm(GObex *obex, guint8 op, guint8 srm)
 	struct srm_config *config = obex->srm;
 	gboolean enable;
 
+	if(srm != G_OBEX_SRM_DISABLE && srm != G_OBEX_SRM_ENABLE && srm != G_OBEX_SRM_INDICATE)
+	      return; //unknown srm value
+
 	if (config == NULL) {
 		if (srm == G_OBEX_SRM_DISABLE)
 			return;
-- 
2.34.1

