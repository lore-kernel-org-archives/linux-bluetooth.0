Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF2E148FE6
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939272; cv=none; b=KZzZC196IE0MZ43kRprxZ5DE6h8qoGveU+43MbjaaMQCYCcmGCFWHOjD+AEgcPCEN9kaFAI7lII3n1u/dwOG+q1v9wtjnIZPjEDFuEf0WSp1g7ZPZ+gSbxic/+2K9jyVQCR2ezKwVh+upTZGHPplAmknfwB24NcQVVUPkVTvSVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939272; c=relaxed/simple;
	bh=GOkeYu/UvQsfV+vd2RobpnBmlXHmV+3Rwr9I2cAMeRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1ypmRishGviiZYVl86CduixWZ9VcQebNzEPbW2veq01WgMH1uqXk3zCRhLgaj6FDd8V1QX6QnwuruJF+rUfuKR7clqQcOsnz8ymabp15Etxtiwac/qdsPwj5L/opwbOqBQ+4b4AAe/38+tmnivQRLyTv9RWsMPH1sMCHQS4fuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MXFdfrjO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MXFdfrjO"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CFlxlC020876;
	Fri, 12 Apr 2024 16:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=Og/l8PVchQqE2E56jeqL
	fxMqaT3T+ihz9UC36bAVkL8=; b=MXFdfrjOB9U6R+ITT51r1kOmNcwAP95ayjDA
	hHixOxxK03EXObNhp8d6gzF62oiqzIqPf+pw4kb7tkAlnvPSAlDl39KuD2RcvLpZ
	eTvj36As9NvECA50M3deib0ziJ2VsEL0sr0feNWBUqQybSS+X9Ou6hrFcWpYcw57
	CVPYFH1wJqJQOv2WwYwQ3L/tNO1rBkMZVVKydlR5bKBu8WBBrNlebuqysagYky2h
	K8Cy5wk7AU7iOK7bRFOi2fkRBXBA/rSUqxOeh7/nB0+g/LpU+beaCFR7UbvhMmhP
	Dv2JVW4A0D/VDeVi0SQ/RBjeHTJcqWWIIZot2pTYmfieCZCGFw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xf6khr8du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 16:27:46 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CGRjjZ032583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 16:27:45 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 12 Apr 2024 09:27:43 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <jiangzp@google.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v1 1/3] Bluetooth: qca: Fix crash caused by tool btattach for QCA_ROME
Date: Sat, 13 Apr 2024 00:26:25 +0800
Message-ID: <1712939188-25529-2-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1712939188-25529-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
 <1712939188-25529-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: s9mC87bGtLtDqMSgaiIF_JxComC0XEeB
X-Proofpoint-GUID: s9mC87bGtLtDqMSgaiIF_JxComC0XEeB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120120

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
index ecbc52eaf101..158567774cec 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1957,7 +1957,7 @@ static int qca_setup(struct hci_uart *hu)
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

