Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154113D268
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564239; cv=none; b=eB5LybqeL7OtMLrneY4ph55fOz3a3hfhip/GQzM+hQ/xmtOBAIfm3r2vViF6mM1iAijapakD+/zDQj/G4PaMR8dJb9akzIxPGnPrFKyBl00yRnBLLV/Qv8He6x5Fil8LY4WsIXsHeKR0wMCiZkdXsx0Li1QQ/xPl42hXMF4QPUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564239; c=relaxed/simple;
	bh=u1RdMf1JjgQEGGMyNOxRVLLYurhBngdKMpG/t83+FWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/0eEUQs5phhCNQhw9nWqtvCMM8g3mjG7EGXOGQDEMMuCCPCflzh3wPk+E5v/hRTWdTKfERRP3V2g+ve2FfxBoYHqSlnl+BgDJPR73p5U2b4PIejbO/hP5VWT8ZpnszO6g6IXQ8s3RKADpWG7foVQIRBGSob6w6ngqy6qvVIA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZfC1tN7c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZfC1tN7c"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JLd62U006872;
	Fri, 19 Apr 2024 22:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=40psHldI0d6DgERkB26a
	DuYtLZZzL2pwVUvvXHQK6FI=; b=ZfC1tN7cYesB/Omi0VXngfG6W6RtecLmZS64
	jxGQZIh1dQ+e0EIxd4xJ2FXpolLTmX4jM75Vl1XQo9koCaJlz2mzKT3iIVrO0Pj2
	4TuS7M/LQEBR4o3K5YmHMXxH7D2RFYCfVAzb7XctK7thc6DXDnldQJjACpm6dJQx
	AlIyzcHGeGVuTzQTR2npKi2kQ0ph9NiatBuS7yFCgviuXxcRNkuqPh8yfNQ5mmd4
	VT43jV18M5SNiTKQ3XdiqxE4wq6NrtRGqwlAlvtOQ06vrYgz95O6Ken7s3SoMDnf
	UJC+xJjJrgk7WSd1m2qvCo+FF2U4nEqwRZ4dMJZGh1CMDj+UTA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xkkss9qbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 22:03:45 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JM3i7b019976
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 22:03:44 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 19 Apr 2024 15:03:42 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <wt@penguintechs.org>
Subject: [PATCH v3 2/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable then warm reboot
Date: Sat, 20 Apr 2024 06:03:32 +0800
Message-ID: <1713564212-21725-3-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 1TJvE5JW1eQs2qBqShBa_6-1tDMJ-2rR
X-Proofpoint-GUID: 1TJvE5JW1eQs2qBqShBa_6-1tDMJ-2rR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_15,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=846 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190171

From: Zijun Hu <zijuhu@qti.qualcomm.com>

Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
serdev") will cause below regression issue:

BT can't be enabled after below steps:
cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
if BT reset pin is not configured within DT|ACPI for QCA_QCA6390.

Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
once BT was ever enabled.

Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
Reported-by: Wren Turkal <wt@penguintechs.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
Signed-off-by: Zijun Hu <zijuhu@qti.qualcomm.com>
Tested-by: Wren Turkal <wt@penguintechs.org>
---
 drivers/bluetooth/hci_qca.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 0934e74112a6..3f5173f1180b 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2438,13 +2438,12 @@ static void qca_serdev_shutdown(struct device *dev)
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

