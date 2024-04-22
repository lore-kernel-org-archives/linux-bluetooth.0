Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898DB4D131
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771519; cv=none; b=MJeyrIbZupjZty9RjVqJQnnrjUtZNe675K0zFeiNrZ76Da7skdCFzkaSXMpa5MmEDtuANk34/fOWdOKb0XO2ZfiLzed0cShDPg67c4a6uDZpgflFQUnMZumc+f9r4Sc6d3IuRATRzyPwwp/NO2kjH5M1F9yxVm5SJ3ncmUxTpEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771519; c=relaxed/simple;
	bh=wRBc6p7YOjaMGkLGK6ZJlt/Izb6l/9SnLDW/KT9sY88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hl1DaaOzAaCBElQiO1QVisztD5HgOlPkHVROisnjllU+/vseLzralRgGjUKDETCFJfhzhAIe0ysRvIIbJk5fiIIGX+IqN/bRyrcz/r+xcwCA05lGFdDVn3bj3Ywt2P1xu0PQ6z8JAKB1hIJO53ZYeG7SiKM38ZwRlYDwtZZ6dGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=opunBoFC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="opunBoFC"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M2Juc5021044;
	Mon, 22 Apr 2024 07:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=04kFvIkJp4VAasd0cXiB
	L3Z6P+vk3iQOLwquN2wRl8w=; b=opunBoFCEbkusSWFneEZ/ZNo8ljIefozalsg
	ecpEbJAgT0kZEdbKCR3dzsHSs615lVIvAP9euzmcHkpNkVOq2RjxDJIpN+UO2Rvg
	iIbK1V79xOzQQZEMqiwqFT8drbd+Wd5KBYF84vwMmjaArz4tUjG0jIftI0wvn+MX
	glgnEyfyIZVScZsssps8GAakXQPpXk9dwDzMTS76Uob98Rz4SEdn9KiX+ldOpoLW
	r2kNBTcP141VcEKv5QtDdfBy11yEJ7YuIPj0WxrVRD1ViBOhytDqo5aE8046HrKs
	88K85O98syurBP1gM35s2c8pLOTU49fCfTbNNrsJzalETRuLxA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xned0gk37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 07:38:31 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M7cUWC031909
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 07:38:30 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 00:38:28 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <wt@penguintechs.org>, <regressions@lists.linux.dev>
Subject: [PATCH v5 2/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable then warm reboot
Date: Mon, 22 Apr 2024 15:38:17 +0800
Message-ID: <1713771497-5733-3-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713771497-5733-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713650800-29741-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713771497-5733-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: HmVQdDldeRhvCo9FxVrL8ROFsP0_wpld
X-Proofpoint-GUID: HmVQdDldeRhvCo9FxVrL8ROFsP0_wpld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_04,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=867 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404220034

From: Zijun Hu <zijuhu@qti.qualcomm.com>

Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
serdev") will cause below regression issue:

BT can't be enabled after below steps:
cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
if property enable-gpios is not configured within DT|ACPI for QCA_QCA6390.

The commit is to fix a use-after-free issue within qca_serdev_shutdown()
during reboot, but also introduces this new issue regarding above steps
since the VSC is not sent to reset controller during warm reboot.

Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
once BT was ever enabled, and the use-after-free issue is also be fixed
by this change since serdev is still opened when send to serdev.

Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
Reported-by: Wren Turkal <wt@penguintechs.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
Signed-off-by: Zijun Hu <zijuhu@qti.qualcomm.com>
Tested-by: Wren Turkal <wt@penguintechs.org>
---
 drivers/bluetooth/hci_qca.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 4079254fb1c8..fc027da98297 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2439,13 +2439,12 @@ static void qca_serdev_shutdown(struct device *dev)
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 	struct hci_uart *hu = &qcadev->serdev_hu;
 	struct hci_dev *hdev = hu->hdev;
-	struct qca_data *qca = hu->priv;
 	const u8 ibs_wake_cmd[] = { 0xFD };
 	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
 
 	if (qcadev->btsoc_type == QCA_QCA6390) {
-		if (test_bit(QCA_BT_OFF, &qca->flags) ||
-		    !test_bit(HCI_RUNNING, &hdev->flags))
+		if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) ||
+		    hci_dev_test_flag(hdev, HCI_SETUP))
 			return;
 
 		serdev_device_write_flush(serdev);
-- 
2.7.4

