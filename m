Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3134F1EB
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713409928; cv=none; b=TGMrATODDRMbGo9T2zFhJciGYUqeNdpFtWYV9SuwRBJr0wc3kPIGz5tp8a1NEd3ZIQwsE8iRkowz4w7o7IjWyX83Ay/VMCIDcZuhAMSPsc0Rcegpd42H1qlEFrKFQurh2y9fZY+3XaxEDvMBNyfq7KJH1hJQ0jpZ9bqNQ796bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713409928; c=relaxed/simple;
	bh=2/0X7FRfyjGBCSToTSuA//BVfSa1LcfsCK7DeLXmxdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTRNLyFrQCoiyI9X/m4fZMZdP3HGHc5Rg+UawNyLVtvqraL1yJIZC9SxU80JnfQmm3heyRdXGwxmvgy2QS44FyctDwZ1O+hlb1eE/bzs8GvZ4dPXwGg6+HFRxpQs8xdaDCTs9KoB2nYiqVsoKv5e5rnKJWQViHyKUDbPyO0VpF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MA1pIkfu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MA1pIkfu"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43I1AEpX024044;
	Thu, 18 Apr 2024 03:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=vNjJi2eQTlb9I4zDZ4Gx
	mioq7hosmZFnhGoavP4qz+Q=; b=MA1pIkfuUEDcGat+9kd8uyyRsnwobbmqMLr0
	7FvuIkKHTZG2Ha1xZQDVtiE3IqJ1Qy7IMCGdp1vVA5P+cFOLtIQJV7yzT9o5AZSv
	QcApF/Wybmk7NdsjB3EbUDsZns3VPHsBFF1s4mId7tRrlUXGs0qQ/7Zn3zuREAB2
	91QTFKuE0K3Kpzv1XlCMASjQ7kTU6Um8/X+QtmVV4YgSC1E2h5hYM7b1mpALpkme
	iTp72E5GJsuzsHp2yfTnjLdi3oNR1xg4hqLyMu6XE4X3FSm7i6LmfnQP27/kERis
	pXQz6XG2IzZ8eQORqcKLQ0H2+7PzxCNCa0QKz+17qDCGh2XPdQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjrfxggv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 03:12:03 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I3C2qK020332
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 03:12:02 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 20:12:00 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v3 1/4] Bluetooth: qca: Fix crash caused by tool btattach for QCA_ROME
Date: Thu, 18 Apr 2024 11:11:50 +0800
Message-ID: <1713409913-13042-2-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713409913-13042-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713409913-13042-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: dCCYKupiipKtfrKk5OxrBXn4qklP7D5-
X-Proofpoint-GUID: dCCYKupiipKtfrKk5OxrBXn4qklP7D5-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_02,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180021

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

