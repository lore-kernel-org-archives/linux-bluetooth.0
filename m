Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0530D11CA0
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 05:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710912517; cv=none; b=Q5FvU4ERyKbT0LK5wVePQ/MYnqtMaFpFmEJaR1XfoyfWJU8GujrILzg6vn0ilP8wpWCgjEK7/9JorLs3EhSi7pToUkZq4En3kou4bM4MfWxjmvbgTculrjg6lPd4GN0niyruxW6NHZAZ7P+XdPaM+Y4k+Zf0xF273bZBMSBvVJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710912517; c=relaxed/simple;
	bh=6jVV6g+nAFQk57WKxUUOE9rDOB738dtBkZaRvEXFTFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OF9zTuVxQLEpUvL74udkqDPj9hv8Dw4oeCL/rQdE0PYGm0W7BYn8858qhqlRGncOMfL1XLCF/lDtqoFIDFt/WJ6Asmu7eatIU1bqvatZ8Dhfy5c18inA0dJMoW84GtUxIRbCMbNBoh9hKTdqaFqEPeb2xTdyOmfUnh31AOclGvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IgNjviay; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IgNjviay"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K5Lk0o018511;
	Wed, 20 Mar 2024 05:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=iLJc6YVK+HyEaAHKTOKH
	D7NMx+9WOM/RlrFVwQLtdq4=; b=IgNjviayoLe1Hk7rYPS4bY7iv6rKGULYbqky
	BWXsaCpdrPZOgPcV0XG48QQaSawFLqsbsKZclIbHD2IfxtP76XBz8d0u49uble7D
	c1TifIPua1QT8nI2qS4k+4qMC2WUVq7hYZJe9hlEBc5Er3fIhCvN7DfCafzBXdJP
	fJKbw6HsDdcbj2VuFsjQQNp1iZBQCFAL5AcDjW9qqOHKtS4ahWxukV8KRgyL+ndZ
	Ml7swbymx/aA47IjjiL6lmNA/arO/OQtfPhuTR67gX7XZewv+51zO1kVXXljTEGE
	+xI6tc9qjOy6ybr77qG34WH8k0dK+WbLfbDN6kUPZF+ldLuZNw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyq60r82f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 05:28:30 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42K5STD7019336
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 05:28:29 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 22:28:28 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <jiangzp@google.com>
CC: <linux-bluetooth@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v3] Bluetooth: qca: Fix crash when use tool btattach for QCA_ROME
Date: Wed, 20 Mar 2024 13:28:24 +0800
Message-ID: <1710912504-25416-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1704970181-30092-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1704970181-30092-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: LNUPf0U-G2nTcohvmh8hQc_7vGgQPNds
X-Proofpoint-GUID: LNUPf0U-G2nTcohvmh8hQc_7vGgQPNds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_02,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200040

A crash will happen when use tool btattach for a BT controller
with soc_type QCA_ROME, and it is caused by dereferencing nullptr
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
Changes since v2:
 - Correct tile and commit message
Changes since v1:
 - Correct tile and commit message based on Paul's suggestions

 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 8a60ad7acd70..24d45c5c47ad 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1961,7 +1961,7 @@ static int qca_setup(struct hci_uart *hu)
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

