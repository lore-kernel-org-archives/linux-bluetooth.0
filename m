Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03F165FC5
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449217; cv=none; b=Z5+mRdEORQkAFBWKES0UM3cqUNLclB0mUW1OGPGnL5Kaa/q1H71TdTYCIzOOcUK51S8mtHRQeKiRGOmfQlNZzT8dJ1AUc0B1CHL8dYwmwcETc1zp9N/+lx+smH1+WTNb43DyC+l4jysqrz5N4JCLBt2qKvFCPH6SyTVP/HU1J/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449217; c=relaxed/simple;
	bh=LDmdH5XMFB6FWthdt5JCrGF9gLjwqDqr53dxCLC4hYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GB7rW7CviuurRf9XArDuCgtjZ3wj9ai05P07TCbnLV4V0iKqoNSnSqWAGGXmIrO8egKyhKzF4a9LfKZP7aKTQ1mGV551Z/PSdkAjZnv+Txm1oRwvaBCtpwmEjGoLw5slvB/UDIRy6EMBmZPehTYZnTMYyaR10TBIOJ7Ug8hJB5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OAm1h444; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OAm1h444"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IDUVcw021857;
	Thu, 18 Apr 2024 14:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=EhoyPe6LL2trXjcv0c+R
	faxiuYi20NHlwruBMh80Mac=; b=OAm1h444THn8z2uqZjVg0iEqDcbEepyDXztQ
	8P7inuCGrnQxxNYcYOVgeU2os/wJNrrVa/h1cAiI9J/VwAHpK6qMBeUNknoglLIi
	5o7m4XDyE7BzwzAWRqVh4C2tbULVkTJyb9ZLwIMT1Ef/50KraeZBrTA3H5VHA1dp
	HcaO1iLo5+0+4V6wc3addQxxUdsC+uDoghc6n9f3xTAQf1uWN7VhBEnDGdlg4iBd
	4Idl6n5IHoPGtsVwQFyIrWV8DyoN/kW8fTvPvumkStZUDzprDt7nHl0BTJ6aol6f
	ZV2ImvEoSOvJcG7LUAADIdxYq79NcZWpVipkJjXKB5ojJfmuyw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjx51h07d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 14:06:45 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IE6iPM028187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 14:06:45 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 07:06:42 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <wt@penguintechs.org>, <bartosz.golaszewski@linaro.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v1 2/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable then warm reboot
Date: Thu, 18 Apr 2024 22:06:32 +0800
Message-ID: <1713449192-25926-3-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: k5JlDGo3V6oERkPDoTDsJ6mdhKVAtPdk
X-Proofpoint-GUID: k5JlDGo3V6oERkPDoTDsJ6mdhKVAtPdk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_12,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=989 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180100

From: Zijun Hu <zijuhu@qti.qualcomm.com>

Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
serdev") will cause regression issue for QCA_QCA6390 if BT reset pin is
not configured by DT or ACPI, the regression issue is that BT can't be
enabled after disable then warm reboot, fixed by correcting conditions
for sending the VSC reset controller within qca_serdev_shutdown().

Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
Reported-by: Wren Turkal <wt@penguintechs.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
Signed-off-by: Zijun Hu <zijuhu@qti.qualcomm.com>
Tested-by: Wren Turkal <wt@penguintechs.org>
---
 drivers/bluetooth/hci_qca.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 160175a23a49..2a47a60ecc25 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2437,15 +2437,21 @@ static void qca_serdev_shutdown(struct device *dev)
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 	struct hci_uart *hu = &qcadev->serdev_hu;
 	struct hci_dev *hdev = hu->hdev;
-	struct qca_data *qca = hu->priv;
 	const u8 ibs_wake_cmd[] = { 0xFD };
 	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
 
 	if (qcadev->btsoc_type == QCA_QCA6390) {
-		if (test_bit(QCA_BT_OFF, &qca->flags) ||
-		    !test_bit(HCI_RUNNING, &hdev->flags))
+		if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
+			BT_INFO("QCA do not need to send EDL_RESET_REQ");
 			return;
+		}
+
+		if (hci_dev_test_flag(hdev, HCI_SETUP)) {
+			BT_INFO("QCA do not send EDL_RESET_REQ");
+			return;
+		}
 
+		BT_INFO("QCA start to send EDL_RESET_REQ");
 		serdev_device_write_flush(serdev);
 		ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
 					      sizeof(ibs_wake_cmd));
-- 
2.7.4

