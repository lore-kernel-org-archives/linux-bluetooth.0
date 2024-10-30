Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC311E22FF
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285440; cv=none; b=arfmvmssFyquXN7wi95cI6grpPFcCombjfY7QkX4TLFvo/rgbOrSGrGmoKuGVhvcIZ1G7Qoc28lsx0ORjtzM1rDMuQmRWK1d5Zh/kWz8/ZkXc7p9WNaJsGPKuCeCXD3CSvQUXR1mJ5osCeyaq1qAbpmTiPyLYundogtCzWj6K3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285440; c=relaxed/simple;
	bh=xc4ZoOH6Gfpv7rwlZdMBXuugdj575m5z6YP9bDM5MD8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k7owINNQmDT0u+9G5GCcTKTTLyoYh5deBU7BS8Tzl5NJ4u0ik/SzGiZKXRgd9CsKo+xqvmFZqpLKSW+atfnYdTjNfLI7WhY1UUJsRHVb9Dk/LtuPi2bMT99L95+0OHeI4HKHEly5U5cX1OyBNKFxGeDK0xS/xlzskekSxojqKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qr+wyax5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qr+wyax5"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U9uRZ6009582;
	Wed, 30 Oct 2024 10:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0svuSJ2hqmPSe04oVaatg2
	IlhdiUfpemBU/eE2WxYNE=; b=Qr+wyax5vEp2QKDm9il3qOi8cZI2XhLWOLWbDd
	O9ZlV8HLhaiFS+cjxzQBVHOPqUFZUTE7bmg8Z1Wi5AxBkosBwojzTGICVgwnq6Lx
	qcrWN2ykiF6jH83krLGSZPEC747Q2CoMewc3KtUsrtoO2raCsg8N6p3M81SNTA58
	EhRn2YgWRlL1t8J6Rbt2tWcy2Z7Q4M9Xyaj+GChW7uJLykilivyBK2FP7VCcM4g+
	TdVdQcDVhkrOk+ICT8/Ef+OJH0Y029xd3PL4RdarIqe0uCa7IE3vX1QiVcc1RyCA
	CWl1Nbb6LIrmNecAj52j3nDyiCZcAeZV2Ubhw9gBkC2ajLng==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kjm184y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 10:50:35 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UAoYNL003164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 10:50:34 GMT
Received: from nasanex01c.na.qualcomm.com (10.45.79.139) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 03:50:34 -0700
Received: from nasanex01c.na.qualcomm.com ([fe80::cfa9:539b:fb6d:d257]) by
 nasanex01c.na.qualcomm.com ([fe80::cfa9:539b:fb6d:d257%13]) with mapi id
 15.02.1544.009; Wed, 30 Oct 2024 03:50:34 -0700
From: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>,
        "Mohammed Sameer Mulla
 (QUIC)" <quic_mohamull@quicinc.com>
Subject: Profile versions are not supported with BT Sig
Thread-Topic: Profile versions are not supported with BT Sig
Thread-Index: AdsquYn/8+RxTpZIQfanhC4hE11s2Q==
Date: Wed, 30 Oct 2024 10:50:34 +0000
Message-ID: <494bda1fd71a4b3099910f3a9cfaac65@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: omP8BlCTdD8AkmX8YhaIgmDEETJRaxDD
X-Proofpoint-ORIG-GUID: omP8BlCTdD8AkmX8YhaIgmDEETJRaxDD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 mlxlogscore=938 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300084

Hi Luiz,
We are verifying the PTS testcases for all supported profiles.=20
We are seeing profile version issues for below profiles as current supporte=
d versions are in withdrawn state by BT Sig.
BLUEZ Version - 5.72

>> A2DP
     Current version 1.3 - Withdrawn
     Subversion 1.3.2 is adopted

>> AVRCP CT
     1.6 - Withdrawn
     Subversion 1.6.2 is adopted

>> HFP
     1.7.1 - Withdrawn
     1.7.2 need to be supported

>> PBAP
     1.1 - Withdrawn
     Subversion 1.1.1 is adopted


>> OPP
     1.2 - Withdrawn
     Subversion 1.2.1 is adopted

>> FTP
     1.2 - Withdrawn
     1.3 need to be supported

>> MAP
     1.2 - Withdrawn
     1.4.2 need to be supported


So how do we upgrade the profiles versions so it must be aligned with the B=
T Sig ?



Thanks,
Amisha




