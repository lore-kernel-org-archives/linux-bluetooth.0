Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43689204F60
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112836; cv=none; b=QEVXyzkCJUK3aVOfCEhapHxD/lEEpqU10Na7WqtaEfX7tcZ9p3PdGZ1j6LxS0KukfKx1we7m8HrhlWdz+I3m+S1r3srJwKQGDZAXVjurG/wyrVVUfookMvLFepHqaqs13E3JAgLa3IOktkxah8inQ016DRXVmrhjZz9PCXh7hmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112836; c=relaxed/simple;
	bh=kRwF+iQil8pRdXzoI0z6A/MwBtTM3YZkUGgVpi62Zuo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g2oZZcHLsodBI8KEVT9vbYH0jMHkHV/wWykaI2EEMz/pFrnvaL5yPuzCgYxV0tDqUnnNKAjXGMsTm52W3rxW/RZ3w19RoqACrmxNOZn+KxOG9waxWRD5YyprvVBdAdDj15VIvCluPpFkxwZXAF3dI2fh6t8pj6YG7AKE26K1GjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TOAbs5Du; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TOAbs5Du"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SAQK2F003192
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 10:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/6cY4TOXdLPeDVhBqOBOuo
	jNaSoStSRZ5yPurLxwArQ=; b=TOAbs5DuCh2ERoNF5svvWO++8feO3YsLjor5I8
	yAFwLhX+cVL/IKZdz4ZqiP0GeCju+/5beUX6ZERQOX/W3nAtq/T+JbDtBKBzcJAi
	/Qt65dkOfgu/rvGRPXvRz3XStrfJKm5KQFTGxJe75FKSVNDfYmN8u58vUsDIRWZY
	XsW1/YiCRSxrCHIvGFY8oOjgibjfdl+34utzk4b0XPPw3klwoQe6tCcwNIZqnLdP
	20iQOjf0FXAYChD5qHa68WH/kZ6KyYu6h6chXREaIuiwXqOPcxjt6hMNk3A9Ke0W
	Ld54/Q5i4L5l7kvK0Nre5OUumKZZzP1pIZeHt2fnILkc4c6Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gp4dvss3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 10:53:53 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49SArqol017129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 10:53:52 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 28 Oct 2024 03:53:50 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex : Fix for PBAP GET request in PTS testing
Date: Mon, 28 Oct 2024 16:23:26 +0530
Message-ID: <20241028105326.3159618-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Zehssr85IBTU2aPzXXg81gFiGPPJ8gYI
X-Proofpoint-GUID: Zehssr85IBTU2aPzXXg81gFiGPPJ8gYI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxlogscore=895 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280088

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

---
 obexd/plugins/pbap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 4175f9de8..3c23815ba 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -524,6 +524,11 @@ static int pbap_get(struct obex_session *os, void *user_data)
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

