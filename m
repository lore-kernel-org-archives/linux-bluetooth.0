Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3424F13D2BD
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358385; cv=none; b=K6hIQZtSkZTiK0i61ZFOdD1LUMQQr4CgJcR6VDJfC/6EfgpGp/psLXx28ggvDcy+wweZlUl0Pc2b3Am2yRop5bgajS+z/b4iSSxJOVAvl1b2j0CCWmHsVn8EDm3G3pA06hwz3DeUyyxshPPWFcE2NUFPsz/h7SGL0KDZbOQataQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358385; c=relaxed/simple;
	bh=2/0X7FRfyjGBCSToTSuA//BVfSa1LcfsCK7DeLXmxdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPwpZf1d5K7xNUyidYoMttJ6Zpii08MfLa2noIo7tOtIdtkzsS/86pp6o9a4J7GkA6VDu1TJVPlRhSeM+VniERNKkdLpo+HP38T6uwAFBiDGUT+kMTEQpNRNTq6xSiq466uPE+I2BH4wlu8qAwBds6tKTD9HBeXO2FshKI5Ssnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=duDCsISu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="duDCsISu"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H6tKAS018492;
	Wed, 17 Apr 2024 12:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=vNjJi2eQTlb9I4zDZ4Gx
	mioq7hosmZFnhGoavP4qz+Q=; b=duDCsISuacv9fD+K51HI8uzlpTDqgphr7nqc
	Q9u1EkHBchuE8U5GYEtwOeKjzVG9G9X/zk587xoaxs/Wly3aCP9b1Jpzlb99lVAG
	BLP/DNSudHPGXbvNLiLlf9al8odo/UsrdGP5CNkQA8QgAN44Wx6Y2XiTDPvzPWET
	aRGfQ9K1S/NaXhJ9jZ9GtMq8QAuPo5XWU1rfoQ6qKQrLL/jSTLUCmX3bStXiWc+N
	naJRehhVTIKq9nzIH1bdNDL1D1sF6vptnJPu2N0hOjR5qUeUYXO3/yyJJhzGzN1r
	SJJiC9UU9+65zI/uywiiJgg21aB9J0gnwm0YCRkuhAFTvByZBg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj8auryd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:53:00 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HCqxpe012346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:52:59 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 05:52:57 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v2 1/4] Bluetooth: qca: Fix crash caused by tool btattach for QCA_ROME
Date: Wed, 17 Apr 2024 20:52:13 +0800
Message-ID: <1713358336-29619-2-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4bEKLhcT1mJYBEeLipAcX1kQtkPEJoA7
X-Proofpoint-GUID: 4bEKLhcT1mJYBEeLipAcX1kQtkPEJoA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170087

A kernel crash will happen when use tool btattach for a BT controller
with soc type QCA_ROME, and it is caused by dereferencing nullptr
hu->serdev, fixed by null check before access.

sudo btattach -B /dev/ttyUSB0 -P qca
Bluetooth: hci1: QCA setup on UART is completed
BUG: kernel NULL pointer dereference, address: 00000000000002f0
......
Workqueue: hci1 hci_power_on [bluetooth]
RIP: 0010:qca_setup+0x7c1/0xe30 [hci_uart]
......
Call Trace:
 <TASK>
 ? show_regs+0x72/0x90
 ? __die+0x25/0x80
 ? page_fault_oops+0x154/0x4c0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? kmem_cache_alloc+0x16b/0x310
 ? do_user_addr_fault+0x330/0x6e0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? exc_page_fault+0x84/0x1b0
 ? asm_exc_page_fault+0x27/0x30
 ? qca_setup+0x7c1/0xe30 [hci_uart]
 hci_uart_setup+0x5c/0x1a0 [hci_uart]
 hci_dev_open_sync+0xee/0xca0 [bluetooth]
 hci_dev_do_open+0x2a/0x70 [bluetooth]
 hci_power_on+0x46/0x210 [bluetooth]
 process_one_work+0x17b/0x360
 worker_thread+0x307/0x430
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xf7/0x130
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x46/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

Fixes: 03b0093f7b31 ("Bluetooth: hci_qca: get wakeup status from serdev device handle")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Tested-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 92fa20f5ac7d..fdaf83d817af 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1955,7 +1955,7 @@ static int qca_setup(struct hci_uart *hu)
 		qca_debugfs_init(hdev);
 		hu->hdev->hw_error = qca_hw_error;
 		hu->hdev->cmd_timeout = qca_cmd_timeout;
-		if (device_can_wakeup(hu->serdev->ctrl->dev.parent))
+		if (hu->serdev && device_can_wakeup(hu->serdev->ctrl->dev.parent))
 			hu->hdev->wakeup = qca_wakeup;
 	} else if (ret == -ENOENT) {
 		/* No patch/nvm-config found, run with original fw/config */
-- 
2.7.4

