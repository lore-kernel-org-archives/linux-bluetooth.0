Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5868317548
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710914929; cv=none; b=ivmhkYoTQzt68vRh8eALQj1+ykRW0YbaU26yxgWwn/CemVOda5OqHNEpGjCbpFgR4K3ykPgyitWODPMYqX0wcNF4Z2lCzYHteuouMuFtbOXuenCAF1qRJEAmC0vcG4B5uXtTGP+iIMbTxwmZ9Br/8guT5Ml4Jr28d+dSsmcQ2ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710914929; c=relaxed/simple;
	bh=UkR3yjgDdZDrbN4CQHr3DIAmhTbHo79rmzE6Bq+7DKY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KgyiOXoL+6u7bWAR9u61I9Ah5RrBPl9n41tHS3boI0ZgMRoAkZzPtiAcaPiy4mpgh+q8nlfqniJ06Sjc+UjWPdZ38hicEPvEiTCE7KPcJ4z2ZAM3KgYGpuQ4rBgkoiercfULBTYQ4hT55G4Ar3y+eEcUcA8jlywMkYkFOSRU9tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mwW+7WKW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mwW+7WKW"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K5gXGg029739;
	Wed, 20 Mar 2024 06:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=cPv6cHto9ESmeQudaEOtQy6u81xNwQ3McGgy/v7tp2w=; b=mw
	W+7WKWel10+q6R1cKX8EVuFKGzINK+rEw3rR2JbUUEzn2AM3cgcIVwrqw2FHu1Gx
	1mwbSi9r2X2lo1FC9qB7XV4Rhr7BFU9DgID2DNMalBotrMg2ETD0x+05bx1VlF42
	W+rGMM9kgJ2IhnJR+DkUqkodUFXs06m24FHsMLJCCnlRvKzGHdFPhuJmr+nbGbo0
	43f/sEvC/NrjntMk9+ahMZJsCJZWtUnHss+svVzueIql3iYnSpqAPvLIjT6pxRSE
	KdMKc4P6IIT1nCBwuqowxUB50n5z5gc9A848aSC9/nAlHNouB1ebVtZ4Yiu7gl5w
	SdR7Djt79nhsZjta68rg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyke2rpcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 06:08:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42K68foo009824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 06:08:41 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 23:08:40 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v1 0/2] Bluetooth: qca: Add tool btattach support for more QCA soc types
Date: Wed, 20 Mar 2024 14:08:25 +0800
Message-ID: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 1_NQ3kdaeH50DcfOPL2-1iyKtEID4hDm
X-Proofpoint-GUID: 1_NQ3kdaeH50DcfOPL2-1iyKtEID4hDm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_03,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=609 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403200045

Kernel header drivers/bluetooth/btqca.h defines many soc types as following:
enum qca_btsoc_type {
	QCA_INVALID = -1,
	QCA_AR3002,
	QCA_ROME,
	QCA_WCN3988,
	QCA_WCN3990,
	QCA_WCN3998,
	QCA_WCN3991,
	QCA_QCA2066,
	QCA_QCA6390,
	QCA_WCN6750,
	QCA_WCN6855,
	QCA_WCN7850,
	QCA_MAX,
};
and every soc type stands for a kind of QCA BT controller, but tool btattach currenlty
only supports default soc type QCA_ROME, this patch series are to add support for other
all other QCA soc types by adding a option for tool btattach to specify soc type.

Zijun Hu (2):
  Bluetooth: hci_ldisc: Add a ioctl HCIUARTSETPROTODATA
  Bluetooth: qca: Fix wrong soc_type returned for tool btattach

 drivers/bluetooth/btqca.h     |  1 +
 drivers/bluetooth/hci_ldisc.c | 10 ++++++++++
 drivers/bluetooth/hci_qca.c   |  8 +++++++-
 drivers/bluetooth/hci_uart.h  |  3 +++
 4 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.7.4

