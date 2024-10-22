Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF8E198E7A
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592565; cv=none; b=IX0J+V9p/kft7VipG/P9gB5jEVUq3jt4AWC+2mc90MIyvGZrLbqMnTIVNf2EbE8+lCn3f+NypFkXKgqE6VWmTn5vX60MO14bAneS4z+c0D20CFoT081/bZGwElTQmSfndX9XWDaaxcfwKRxCQgcsPzT9vocl+YPqNa80u0F34L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592565; c=relaxed/simple;
	bh=RF7caUZFMp/+5Ae3vSq+VW9kRzV7Asz20Gl3TtoPbk0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ou6hPPvVLXQPnRyVmFsrZ+TK6r2+vPI2On4OFDvnPx0hrNBvmmpoyBkgvDBjrSzexZ5H2iHS0d7k5DOCiwXPyLiEC8ldsT+ZIiyi7iwTKPummjtlgYiB0C1+vLNuX8Na3MHYlWvq+6dB6sUEgGiVa1md41FZM0ogRRNIyJps+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pYxSkvbj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pYxSkvbj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M6W3Os014410
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 10:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=oHJd7tM7g+CwYwKQLxZ+cR
	oooJj0seoJ4kNq+Q5v5DI=; b=pYxSkvbjlwgqXemW8/JagYXOUT8dD2yl2i68P3
	0yM6J6bi94/aMnLVQV000DGXwmGXxr+M9t3yLVH5T9t4XE4Bbzr4CAPiBLddw6A/
	GGIxMdreSrpm5zTubYf8DATIZ+VskzZlobwhMHCkR6hersGQJ+CA9RcRfJjKcvN7
	amRnR8i7/hhvcIg8pQZygw5yvNtufHsXBFMVIrKEaIU4pWs8SyXsbjOIpcJAtgkC
	opHd2hGjqveMOBtR3r5+8Wg8CrDxDugBtuUaPir3uB6BF0nEwEIVlMRZrWrfWzrB
	N4faB1NXDXfMsIsY8ItnwpS1wXquhtFPGrvkPV6i1LVJXQ9g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkhd41u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 10:22:42 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49MAMfCC006517
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 10:22:41 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 03:22:39 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v2] obex: Resolve SRM issue for PTS testcases
Date: Tue, 22 Oct 2024 15:52:22 +0530
Message-ID: <20241022102222.279614-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ab0xBLBRs1h04o7hP4GppWAAN-1sQB8E
X-Proofpoint-GUID: ab0xBLBRs1h04o7hP4GppWAAN-1sQB8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=919
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410220066

Add check for unknown/undefined srm value.

This fix is required to pass the below the PTS testcases :
1. OPP/SR/GOEP/SRM/BI-02-C
2. FTP/SR/GOEP/SRM/BI-02-C
3. PBAP/PSE/GOEP/SRM/BI-05-C

Description - Verify that the Server ignores a SRM header with an
invalid value in the PUT/GET request and carries on with the
PUT/GET operation with SRM disabled.

Current Behaviour - Server is sending SRM enable in the response even
though receiving the unknown SRM value.

To fix this, I have added the check to verify the valid SRM values
before continuing with SRM enable.

---
 gobex/gobex.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 40d6b8129..e072205ea 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -317,6 +317,10 @@ static void set_srm(GObex *obex, guint8 op, guint8 srm)
 	struct srm_config *config = obex->srm;
 	gboolean enable;
 
+	if (srm != G_OBEX_SRM_DISABLE && srm != G_OBEX_SRM_ENABLE
+			&& srm != G_OBEX_SRM_INDICATE)
+		return; //unknown srm value
+
 	if (config == NULL) {
 		if (srm == G_OBEX_SRM_DISABLE)
 			return;
-- 
2.34.1

