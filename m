Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C518165FB3
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449214; cv=none; b=FpL8mk0oOj2BnnpmtgFtNANVHcml/AGjcEu1jnEssGkWmwGPQmOllv08z6DbmidsRqvwTYFhUhckBocz5zYlTaEPBz/42U/6FG7bXbRueMABBETFQQPIoBzFfgSczqcp3XyltCqaW1e7/NxU3QeKBXsegCjs22iVbN+F0z/GWFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449214; c=relaxed/simple;
	bh=B1kAv0SkaxmxdDVKqBirKSGFkXZxtuvmkhSBX3G5eLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HpmKS1xoYly/2TwhXxg+ar5Q1F9nzAVYXjUMCbTJfDLsHelFyQ6FCThseMCL1XcWQ0P8YKE7SeyBj8Amu3iNUOT1+InaoouhI4s2Vm7hj8JvrI86u+HfCff3LOQ2/2LVpXDEERjVDZ4eek/4Q14l45yP3AUgdTYw7/E+2dVsyn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZRWgNHmY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZRWgNHmY"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IDsOc5022522;
	Thu, 18 Apr 2024 14:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=4i9fUcjkHTXxtHErQfGlAshksCzLT76SDuszqQ3xnZg=; b=ZR
	WgNHmYAw8vKn/XGm/68GhhYxZ5ojeXhazi8NT3RvJmLJ9RE/M8q7ui+T7hgunVZU
	kcpQNaRkErznDc1/Ql6ay0VUREXFkfSWwlDwyP1Nfm7+V5o/ZVcd+8MCLCOmAo4p
	JOJ1RYFPAZM34VGYgmTuHjbO5JnmtywpojLliT5HRxKYsFocy8Ad4BwUZP2wOvEC
	ebVKu6h3oDW6m60vw5A90oFOUFq6kj/VM0b2F9GRr7nHJQKE/QjF9vGRxDUEy9VM
	+srfc8NtSoQAoPtg+5LX+fr9cc0VWa62seGA25gqTy4uX1b07SpKIdvCVb8+CyGk
	kf8YlSlsIGegcCsaTz+A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjx51h06y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 14:06:38 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IE6cZt014529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 14:06:38 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 07:06:36 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <wt@penguintechs.org>, <bartosz.golaszewski@linaro.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v1 0/2] Fix two regression issues for QCA controllers
Date: Thu, 18 Apr 2024 22:06:30 +0800
Message-ID: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OdjX_7g4UxZhcV1kzDKiCNRerR2l3YVe
X-Proofpoint-GUID: OdjX_7g4UxZhcV1kzDKiCNRerR2l3YVe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_12,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=852 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180100

From: Zijun Hu <zijuhu@qti.qualcomm.com>

This patch series are to fix below 2 regression issues for QCA controllers
1) BT can't be enabled once BT is disabled for several QCA controllers
2) BT can't be enabled after disable then warm reboot for QCA_QCA6390

the links for these issues are shown below:
https://bugzilla.kernel.org/show_bug.cgi?id=218726
https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f

Zijun Hu (2):
  Revert "Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with
    gpiod_get_optional()"
  Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable
    then warm reboot

 drivers/bluetooth/hci_qca.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.7.4

