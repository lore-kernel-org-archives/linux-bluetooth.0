Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0991F0994
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Apr 2025 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744266083; cv=none; b=VDlr49KMaDyEaxU23aKT0SOeA7kPTgKyGHzOJsrddjXgng2W11p1RE4K4f/d0xYQds3QCIlrSYa1mutE5etVkBRzL/fhEUYf1O5ST+asmIImB/V3ENmz9ktrKPFiR2jRl/aU4xxSfdXNEmWF5bno/67o4qWVXRjg2CGenYlYuD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744266083; c=relaxed/simple;
	bh=drVSs0OnMn/i4EbqepB3H6+1ipgbGHnRf03D5GK3Sn8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mh/kP93DPdTrOa5N36pj7hYSLWVIf6BW+AmFy61Ao4V9ewWYCvgs4rvQP9A3Yjezr4TkE/CroZz2YzlnLVz8l4nTj1/wFpAYdB2ovWzJefvbr2xG3yva+TvpHFr35Wo2QYCLcodjGb7mxhwebzkvJjDw6RL6+3Asq1lvnfGDsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PUZ2ZGh+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PUZ2ZGh+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A5UjY2018561
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Apr 2025 06:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6NejW+GrER4Q46fdiElw6V
	PA7BEGtV2pFPZRWn4ufls=; b=PUZ2ZGh+hdKSsh5YNgBiZaYL4gHhAJE/gBEkif
	anNMrFgc0oXCL323zH7bv2FCBwPmXZNc/KISnM/rPKo86X6qIw2p+gi7DFRWGhBP
	DU1SqYvA0APK7IC0KToAnyHIwf5kUqFSgcoTRx0VGGdsaP/7VN9hPeXWBGscUekt
	lZ0JhjCLVVB0q41aZoDVIXlKsGVNcB+6CvEdegKQdk+3/QRQBGerIxAIe5+341nj
	YSyVfMm9N+gc+4A89G8Nb0fS5Nxws4A/8O6bvjAux0g+21JQDIUmJnt1L68W7LCk
	DSl+EglKsVTXnjrVXxc4sbpHDp13RhlwjFATiLzz/+LB/Nyw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd2wsya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Apr 2025 06:21:21 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53A6LJ1c030733
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Apr 2025 06:21:19 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 9 Apr 2025 23:21:17 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v2] obex: Send response to client for Abort request
Date: Thu, 10 Apr 2025 11:50:57 +0530
Message-ID: <20250410062057.1845550-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: UVrGjCkbyL_FYAf3CfiYFmD24xcxxKX-
X-Proofpoint-GUID: UVrGjCkbyL_FYAf3CfiYFmD24xcxxKX-
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f76361 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=tyeDOegBlPOMNIItdlAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=885 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100046

Incase of ongoing transfer, If the client sends Abort request, Server is not
sending any response back.

Ideally it should send OK or Success reponse code for the abort command.

This is required in PTS testing for passing below testcases -
1) OPP/SR/OPH/BV-27-I
To verify that a server can respond to an ABORT from the client during an OBEX operation.
2)FTP/SR/OTR/BV-02-C
To verify that the pushed file is aborted normally.
3)PBAP/PSE/PDF/BV-06-I
Verify that the PCE can abort a Phone Book object download from the PSE.
4)PBAP/PSE/PBF/BV-03-I
Verify that the PCE can abort a vCard-listing object download from the PSE.

---
 obexd/src/obex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index 370bfac9e..0330d5a7c 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -389,6 +389,8 @@ static void transfer_complete(GObex *obex, GError *err, gpointer user_data)
 
 	if (err != NULL) {
 		error("transfer failed: %s\n", err->message);
+		if (strcmp(err->message, "Request was aborted") == 0)
+			os_set_response(os, 0);
 		goto reset;
 	}
 
-- 
2.34.1

