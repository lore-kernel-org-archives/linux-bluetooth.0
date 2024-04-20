Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA7205E36
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713650814; cv=none; b=TSE8xnIE0MK/QtxjGx1aueADXRnlOoccu9mtbfOGhSCNwLESHpamhX2GPscSSPVK+wez0GMHN6J8zeJk0GfdRtqGhsD8DjFP6HcApZc7SZ5uAPfi4P4U0SqtxoCB23eFMHBB/S97+FUK/ZGO5oPyyiQ4zSrRfJs1nVT+3Pi32wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713650814; c=relaxed/simple;
	bh=26Hnbn68OAYoFUR9tsvBSDQzWISNRfWvG/tylAn6zck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saZNsw+H/3NKAPIBxMYb8J14oxzHj3yW6tTqEfJ52VMDI4Ybyzt6D6D8QTftY/TU/ue/2Ysr5hDlL/A4GlMfut0lmh1Z8LBFZb5zmJ8NN8iuFVY2oUzj1EwW/3EUHO26GvNNuK0Vz2P3V+5sJY3WeLREtMIgCQZlcPZ4Elh+mh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ObZE1JaS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ObZE1JaS"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43KM1uJw008626;
	Sat, 20 Apr 2024 22:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=lNq026D7joSeeGzfXWXO
	bph1M5kPsBw2Gi8CZ91g8OY=; b=ObZE1JaS8ErAiVoRB4qswgX4IPBWLMOVq++X
	rq+Y6rPy+Nd0MeC2OhiNg6OP9jHQIJndhOys/jaDnB7+OZ/sx4T9IbjOLZSkL4DH
	Px3kNLiMf7E0u1MpX70HJ8CGsTfT5mtDXaai9rsYLcs+E23gXlcoI2Zxx7PD2+ra
	qzDEeG1WBLIXPwGT8J0KFnIWeB5iy7GxB5iZYShSnvaVDUmGZsuC9NOorju4ArVQ
	kwTrv6YKLlj3hfF0gr8/y6ixxaeCAZO/D83MRkmiitMWCIopN/hdD2+/XoCTRhT1
	R5HxS0zLvwIq3WCQMtpdiZJHcqDSrGcSH4IBecpoMxgqBNSxog==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm6fkh9p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 22:06:46 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43KM6jhW017081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 22:06:45 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 20 Apr 2024 15:06:43 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <wt@penguintechs.org>
Subject: [PATCH v4 0/2] Fix two regression issues for QCA controllers
Date: Sun, 21 Apr 2024 06:06:38 +0800
Message-ID: <1713650800-29741-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NWM4qKxaZgYHdL_ZX57wZGvSI4XjdrR0
X-Proofpoint-ORIG-GUID: NWM4qKxaZgYHdL_ZX57wZGvSI4XjdrR0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_19,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=990
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404200163

This patch series are to fix below 2 regression issues for QCA controllers
1) BT can't be enabled once BT was ever enabled for QCA_QCA6390
2) BT can't be enabled after disable then warm reboot for QCA_QCA6390

the links for these issues are shown below:
https://bugzilla.kernel.org/show_bug.cgi?id=218726
https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f

Changes:
V3 -> V4: Correct code stype and commit message
V2 -> V3: Wrong patch sets are sent
V1 -> V2: Remove debugging logs

Zijun Hu (2):
  Bluetooth: qca: Fix BT enable failure for QCA_QCA6390
  Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable
    then warm reboot

 drivers/bluetooth/hci_qca.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.7.4

