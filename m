Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014D1246BA1;
	Tue, 15 Jul 2025 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589646; cv=none; b=Yy8yqzd+vDUPV+025xswRFn1mO0O+7npNm1RoKgcTLe708OCq/NsvUlP7la2zUNi/XGg3dQ0bFbEBJlAwXcEEDro3lruZkPGdC/ZcA4XkV+3dn/BhGJyugGPqsLgfTHhi9tfDcsqWkPe0sI8lkXRDHWQSb7rmMp0z2mXg1Cq4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589646; c=relaxed/simple;
	bh=djpAuc7wGYIOtTCMVwhJ6yD9geIQKZMJqHGijKTNuuU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=QDghrByTJj/5qJoodtZuku0SwwR4N2idhFgGEVZCcffoVK43wAnVTFq/FcQadrPsfbFaQdTszdsQUsO2S3WfW2r4hsZkqC/Wed+t/kPkkPRZwpDcyYKs0b1TeEoVsNgFGr05qvP6K/tnb+Q6KsaTku4LVov+aA2U6stTXJLL7mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DWxCK2fW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DWxCK2fW"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FC78KA017093;
	Tue, 15 Jul 2025 14:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=okSl5B6B9KXiMB8Qn17lLM
	ruvxPlPKNxZPpbsU1wjxg=; b=DWxCK2fWkKWE/PdbW6Atw4WPgVsKZuTR8JCn+Q
	KG4U0/qyRq3EtEWOluSKIERV7tgc1DZRYSWX1rG5gK7ElSFeBprIWdOWPRCD0d8N
	AMltKpKLaFZmL4H/KuNmTbx2cYyc86nMVfAYV4W0kE8ql29l6srQ66Hw5RiupHGg
	wkNTrNL2fycpoT9RpBWhBnjvdajRJuII4Wkf1FRSpNpyt+X98+eXm6dSvbnaNWJD
	U2raDxQumNfbpeURoDbwRvML5/Uacnk5lCFeWiGf5fb1T/WM1zoDv7XGUDzSIXQh
	vHHf48j+7pQXXsru1GNFVjLgYkUf1yjFICJBV4yAesrevd7g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu88f1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 14:27:11 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56FERAGS031324
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 14:27:10 GMT
Received: from hu-zijuhu-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 15 Jul 2025 07:27:10 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH 0/2] Bluetooth: btusb: Sort WCN6855 device IDs and add one
 more ID
Date: Tue, 15 Jul 2025 07:27:06 -0700
Message-ID: <20250715-q_newid-v1-0-8a1120c61fc9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADpldmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0NT3cL4vNTyzBRdc3MLgzRz82RDS4sUJaDqgqLUtMwKsEnRsbW1AK8
 Vq99ZAAAA
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: Zijun Hu <zijun_hu@icloud.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zijun Hu <Zijun.Hu@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzMiBTYWx0ZWRfXz0p6+COcokzd
 rk0jusqpoanwwxjZXlFttTnVGah+0yfMwov49PfAuVUQVYet2pksQgAJFUG9bNOT/+jDPKye3yj
 s1fVHkCRrFEw1UDsQWNYBtuJJnw7IILRZRTvUw73XlWBX1KRxzi+RyCO6TF4Rm4RK4Xtqjhz44w
 4AQymjHVyX2x16tdlkoXmVSkA4yDjOr3Hc0UOKTgLYh1IFXmhy0fEQW1h1YG7sIQHa+zePLMsAx
 V5ZGJH2lNNwbfxwbLHbuTnrVe4wVOQdRDujY4R3tkexDxXXS0sqWD/9IiAouFpCTJSfbK40ZDNG
 8bK/XxwDTerM1SaVPwBWlPrUjmu6q/G9f14VpzZ76ZgTWPgus0MZgBNafrLDUCFQiHpmzXfSNQZ
 lBYUjVdAS9JOXz/B+dmcifuC8mB9jbcAOqN9nsDfBe54m37I28pVlq+X9CZsbj7cbPFXB0Pk
X-Proofpoint-ORIG-GUID: 3tRfHFH8KcfkyW8CnadZ5hiCENyNOSCC
X-Proofpoint-GUID: 3tRfHFH8KcfkyW8CnadZ5hiCENyNOSCC
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=6876653f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=3H110R4YSZwA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8
 a=mvP_5nSk6tWnLvtW27UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=725 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150132

This patch series is to:
1) Sort WCN6855 device IDs by VID and PID
2) Add one more WCN6855 device ID

Signed-off-by: Zijun Hu <Zijun.Hu@oss.qualcomm.com>
---
Zijun Hu (2):
      Bluetooth: btusb: Sort WCN6855 device IDs by VID and PID
      Bluetooth: btusb: Add one more ID 0x28de:0x1401 for Qualcomm WCN6855

 drivers/bluetooth/btusb.c | 70 ++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 34 deletions(-)
---
base-commit: e96d7056e3dfdeab0105d5b3604eb8e8d1af0fe2
change-id: 20250715-q_newid-7780f77c198d

Best regards,
-- 
Zijun Hu <Zijun.Hu@oss.qualcomm.com>

