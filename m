Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54405261572
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203172; cv=none; b=V+xyxwMo0H6h4t0CR9sp8dL2++XxYXQu75WDCdrFqbbBlcDy4A8E3XL6qbUgSnoUBBQreHjXTk5WykWwbH4pxDRSEgW/UKY4M5BtwMReRJFtUG+CAvFYfVofaIPOuhCctyE7Rvdnj8NXTuhfiRLeKlCNNjAODUZvbNoLpWQhNXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203172; c=relaxed/simple;
	bh=laFJ+NAB5dzmpkElsJcZlT1j4uHjJByO+6zwPaIyWHk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XTeqjqjnUuKfFtA9hIQe4tHajK2C6vJMW2Zcz79M/N1GWDkZenGpr9eb/w8Jh73NAUV4dnM40OBjGOYjCVKw0/HVuiMVZ8SbLgqO+FS2JrqV33leJ3playl2vOFEwrbsTDxz7Xy2zIxpLWXFeoIKIK+Kse0G+JhRvgM76Vb0KQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EJIddI88; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EJIddI88"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5398WDLn030143
	for <linux-bluetooth@vger.kernel.org>; Wed, 9 Apr 2025 12:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=D96BAy9Kur+5jmyNd3ydPz
	rao+lvAvJ+MLkaJetakAc=; b=EJIddI88RaGDadTbNGi9zjbMmtkzH7d4VKECtQ
	SDWDh6/fV/9CL9XDHBcAjuUnR5CgJIXPxwTrjXIQblFa5v5nnKjmI4JVPG3wc3/l
	im1MKtXbVwRdDK5WcWKvu9q8Ur4EtoOvsfFr9MBHRYl84nZQmT7CsVFSn5ZcLDFR
	NKE78uGTgT4awR0n8TRkj2Xi4oBxgkAtWgjzjvDjD+Z8aJPLPT1L9xKgw6zeKO4A
	x0l5ehOvLTXoP+Rgi5SuqcX7jT+bq4JAy71GKc8E4AtQJYWKhJzSZEavzI1ISPF8
	dDkyEZ/1ETP//sQikZZ+9R8SL63ZGRAcdCb2xnaod2QLc1iA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpmb95c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 09 Apr 2025 12:52:49 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 539CqmHG009671
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 9 Apr 2025 12:52:48 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 9 Apr 2025 05:52:46 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex: Send response to client for Abort request
Date: Wed, 9 Apr 2025 18:22:32 +0530
Message-ID: <20250409125232.1385922-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-GUID: W487xsTeCYh5eoBGV6JM1hUYZAI9Sl0t
X-Proofpoint-ORIG-GUID: W487xsTeCYh5eoBGV6JM1hUYZAI9Sl0t
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f66da1 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=tyeDOegBlPOMNIItdlAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=885 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090077

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
index 370bfac9e..a9bc3d3a9 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -389,6 +389,8 @@ static void transfer_complete(GObex *obex, GError *err, gpointer user_data)
 
 	if (err != NULL) {
 		error("transfer failed: %s\n", err->message);
+		if(strcmp(err->message,"Request was aborted")==0)
+			os_set_response(os, 0);
 		goto reset;
 	}
 
-- 
2.34.1

