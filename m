Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2613D249
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563368; cv=none; b=POYluZ2l/MFPqknXlfrRmObi/GKyBAQs9WHl0ag9mODGIktaLkSyophgOqQU7gkh4NOxKF8L1vLzalWW4jjos/TYswWcW9+K7k6TV7V3O9fF2g/i50oHjYtNy/7/4rzht8Ga1cFXA4CFfRYM+wnQRVRKBB08jrgHpuAHcZy5iPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563368; c=relaxed/simple;
	bh=fFbhpSx4GR4P5ZLGzERvBMt53UUK8yRCw379KJCrQOI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANuGKVDQldDoqVIq8zxS9PEu+rWxHP7ZRn1q4mr89xj2BCVa1qfJYKSSGlDKgAYYuhg4+AjeUtRlYjApImPIfZ+3zePiUvrHUy/GD1TwJuJmadl6/boy3pHeyMP0DovEErcOnh5AAAaEN1rQ6yimUM+TaG1a1L4DbIYPqEU7x/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VZlAQiYo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VZlAQiYo"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JLjEWh017750;
	Fri, 19 Apr 2024 21:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=wgIG5sWd+zesmQD+EXRB
	HBMeSI2VOK8xCskInPl4bg8=; b=VZlAQiYozjx5gweuhBezqEq0tTHb7OGXL0nj
	PoAqKfp+080KMsDxY9WA4UQA9ZCcHfDMBOhAj92jIFjipBn359S47Pwqx4oKVx9k
	fZdc65zEvZuoMFD0WmmsVS6dGGCj/hSPOHSwGf7l8A3UcduHHd6bMalp89iUtbk+
	5b32GhtNSs9BLeLf46q/AsWa1eh0CEXpr98YBWbwcVk6R1/OZFUhpanm76/M5v4b
	jh+/Elfdb+tN1mv62auIJQhbmE7sprQlMVVCGniHJ82LLVaYGbtCbYHYQRkeSOqI
	YCOBgGr2hXm4jFKZ6yhbCqqtD1J9gbAx3slGFvnJnEXGwec61g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xksuvrwxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 21:49:20 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JLmsfT031183
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 21:48:54 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 19 Apr 2024 14:48:52 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <wt@penguintechs.org>
Subject: [PATCH v1 0/2] Fix two regression issues for QCA controllers
Date: Sat, 20 Apr 2024 05:48:45 +0800
Message-ID: <1713563327-19694-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: _yCpIQCRjwRN59QeYYjdqirA6DgjLY8-
X-Proofpoint-ORIG-GUID: _yCpIQCRjwRN59QeYYjdqirA6DgjLY8-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_15,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=937
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404190170

This patch series are to fix below 2 regression issues for QCA controllers
1) BT can't be enabled once BT was ever enabled for QCA_QCA6390
2) BT can't be enabled after disable then warm reboot for QCA_QCA6390

the links for these issues are shown below:
https://bugzilla.kernel.org/show_bug.cgi?id=218726
https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f

Zijun Hu (1):
  Bluetooth: qca: Fix BT enable failure for QCA_QCA6390

 drivers/bluetooth/hci_qca.c |  3 ++-
 net/bluetooth/mgmt.c        | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.7.4

