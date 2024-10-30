Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25481D1309
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730272161; cv=none; b=OA9JokAH8obhtTrwQMNifZ3lE5DskvexdCFMmKuUc8aRHRYybBlu/C+kd4WaCIgKopjC58oU0iupzKOkKH+rm/vJepp32DxCGfUbFWE5F6gMojSfy9x+RTLbS7Ol7m0Eqd2nm/3R65DXYmH8afC1suY0fLgM8YMr84Lh3iIKN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730272161; c=relaxed/simple;
	bh=Jj6p5GdZ3o6ARCYi2rb8DmzrHduPsfKwhEJ3+Qp6VHU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MMIjFXlfYjVIMTni6Z9rJCinf6gbBei6WCgT+esKAIhYDmoj9rFTwaF8ZYsYkn9oLBbAObH26x0UhtNofi+fSrNLUs5+WpLzbgH7/iFUThvYpPxNBTevxXuFvItzVkksPN2cq3Xo2TJuQ041ZWVXl+dlqJ0El4gYqGhqKEwh5Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=doe0KU/B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="doe0KU/B"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TLipVs027417
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 07:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3qlSOUfHlMeF0v8YvtZqXr
	N8+1A0b36A7OsRHIsTrvA=; b=doe0KU/BT+UEqaOx1K0Bm4vYTopKBsimenoZZN
	mgHjGS1xhIbrH7DdAXJk1LYeDBK00SNFQjKR/VloWtJoa5BY0/vCfYLIPepJsGDC
	OifaVaLMiD0iG1KYSIrdp25aBE2LzMcxUdJ9DQ4cyMlh3nBOfoXGa2AfTiC4Ux3A
	E9EjaXinVo175xy/bJZUhhUMZTrozZAk2MvfBJimhqztloa81JQha4Rz+sWOdhdh
	WbH/MHF/kHM2cbjDMD4O5tVXiTnqn4DUgyzkGe8RrFVVXhrAY2tNTNFBouhlIx7L
	S4MHfxoyGWozofe1xx7pddwLKJJucSNBK6hL1zOHGK6f+GYQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grn532b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 07:09:17 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49U79HoB019070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 07:09:17 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 00:09:15 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v2] obex : Fix for PBAP GET request in PTS testing
Date: Wed, 30 Oct 2024 12:39:00 +0530
Message-ID: <20241030070900.104716-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-GUID: tKQMJKbhm3LpY6mK64472-gxa4Pvmggj
X-Proofpoint-ORIG-GUID: tKQMJKbhm3LpY6mK64472-gxa4Pvmggj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300054

This change is required for passing below PTS testcases -
1. PBAP/PSE/PBD/BV-02-C
2. PBAP/PSE/PBD/BV-03-C
3. PBAP/PSE/PBD/BI-01-C
4. PBAP/PSE/PBD/BV-13-C
5. PBAP/PSE/PBD/BV-14-C
6. PBAP/PSE/PBD/BV-17-C

For all the GET phonebook request sent by PTS has no extra params
added in it, therefore PBAP server is rejecting the request
by sending 'Bad Request' as response.
So appending few default params in GET request to avoid
testcase failure.
This params are already added for Vcardlisting and Vcardentry
operations.

---
 obexd/plugins/pbap.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 4175f9de8..3d1d53dff 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -511,7 +511,21 @@ static int pbap_get(struct obex_session *os, void *user_data)
 		rsize = 0;
 	}
 
-	/* Workaround for PTS client not sending mandatory apparams */
+	/* Workaround for PTS client not sending mandatory apparams
+	 *
+	 * Add MaxListCount attribute, description as per PBAP spec
+	 *
+	 * 5.1.4.3 MaxListCount :
+	 * This header is used to indicate the maximum number of
+	 * entries of the <x-bt/phonebook> object that the PCE
+	 * can handle. The value 65535 means that the number of
+	 * entries is not restricted. The maximum number of entries
+	 * shall be 65,535 if this header is not specified.
+	 *
+	 * 	0x04 - Tag id
+	 * 	0x02 - length
+	 * 	next 2 bytes are value - 0xffff */
+
 	if (!rsize && g_ascii_strcasecmp(type, VCARDLISTING_TYPE) == 0) {
 		static const uint8_t default_apparams[] = {
 			0x04, 0x02, 0xff, 0xff
@@ -524,6 +538,11 @@ static int pbap_get(struct obex_session *os, void *user_data)
 		};
 		buffer = default_apparams;
 		rsize = sizeof(default_apparams);
+	} else if (!rsize && g_ascii_strcasecmp(type, PHONEBOOK_TYPE) == 0) {
+		static const uint8_t default_apparams[] = {
+			0x04, 0x02, 0xff, 0xff };
+		buffer = default_apparams;
+		rsize = sizeof(default_apparams);
 	}
 
 	params = parse_aparam(buffer, rsize);
-- 
2.34.1

