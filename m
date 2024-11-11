Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B523F19F113
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329734; cv=none; b=Tt8rRcqXGrMoeSXqDff01YaEgMZsiU4KcQLS7sWxqG18egnriTusfUISaQzpeM6mzWFI0TWvs4LkJRQmu/rVsSpvhjcQXWt8tTYDlQs2k6kLc4EesMQaBZQtOQu3oa1BYqOZ0v0LFkWA7fvQEildwPgCEKAwom9PJ+VhWT69Tag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329734; c=relaxed/simple;
	bh=Aw6XArLmsnlEJXalplei2dff3DGKkM4fxlReO9CUF3w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L9MI4j2i6RS6AZ2bCR4Uw/z9ALwD53AN5fGSLYcxbjU+UMztnj9ySH2AxtZdbCJNuKb0MB5upX6AToocomKdR0ta58aVbvtv/j4DzVRCOz2X9M0/NOLTdEsdVHLaHdDWNm2Itdzy8D83AHxqmS7JjqGzAOavZErbppRgF5Z+TeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gaf6B8EP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gaf6B8EP"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABBmXMB000954
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 12:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TDTwirWrzIBfCeNQ4JrPCz
	Q55M42I3MrvREdOWGkWss=; b=Gaf6B8EPbN5AlBG5gahhy9qsLNAYGiL8WiuaFI
	F2TnGoNCOfIb43vPRf1FRw1Dfzc7vdDb/pQtS2f4vCmmPheqVMv91cx9fjmv5jcb
	wQSe9R5CK2WiOukmEhHIdn9AJ90hoVK0HUMYbG8y206moQsdbuHe/hO7D9/thuLc
	W4MWTg/XsqsKcu+aAHVvhlDen8zGUnGyhveuDEXBUuvY8vI2aIPiaHgBrMryNSfF
	HJ/iuXescWfUKPSpkExB7J2t5hMvujb19+MNq5FI/Vxvl3SJULMGeTx0n7RML3Tp
	gJyFDNht72GeeYOD4Pr5PVmJZS0crnxCnLRIayza7aK8ZfgA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t0gkv5qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 12:55:31 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ABCtVJ6005989
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 12:55:31 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 11 Nov 2024 04:55:29 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex: Add Newmissedcalls tag in PBAP GET response
Date: Mon, 11 Nov 2024 18:25:18 +0530
Message-ID: <20241111125518.2039073-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 95LT1jBHOEsH44GMJCK4-ZY0nhq2AI5W
X-Proofpoint-GUID: 95LT1jBHOEsH44GMJCK4-ZY0nhq2AI5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411110107

This fix is required for passing below PTS testcases:

1. PBAP/PSE/PBD/BV-05-C
2. PBAP/PSE/PBD/BV-17-C
3. PBAP/PSE/PBB/BV-11-C

Even if the new missed calls value is zero, send it in GET response.
As per the PBAP spec, it is mandatory to include Newmissedcalls
tag in response incase of object name is 'mch.vcf' or 'cch.vcf'.
It will be better to include it in all GET response.

---
 obexd/plugins/pbap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 64641c798..74976890d 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -184,12 +184,11 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 
 	if (missed > 0)	{
 		DBG("missed %d", missed);
+	}
 
-		pbap->obj->apparam = g_obex_apparam_set_uint16(
-							pbap->obj->apparam,
+	pbap->obj->apparam = g_obex_apparam_set_uint16(pbap->obj->apparam,
 							NEWMISSEDCALLS_TAG,
 							missed);
-	}
 
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
@@ -223,12 +222,11 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 		DBG("missed %d", missed);
 
 		pbap->obj->firstpacket = TRUE;
+	}
 
-		pbap->obj->apparam = g_obex_apparam_set_uint16(
-							pbap->obj->apparam,
+	pbap->obj->apparam = g_obex_apparam_set_uint16(pbap->obj->apparam,
 							NEWMISSEDCALLS_TAG,
 							missed);
-	}
 
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
-- 
2.34.1

