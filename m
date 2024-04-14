Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8100536B1C
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Apr 2024 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713095846; cv=none; b=PhOUoALNeUojkkHLk7CGDiONJFrWu8DOfj86lFAsn1cj0IrHLRvPWthq0DNEhGuZ5I9mB8YDiKo7JrJiEKIAb/ZR/AyFbqSRv4EYbvx2pljUcEV9wf+iJM2vqFzCpFFTC0hhSpotZcJ6IGOwCmZ+ZmF/5nMKmKHsw5H+wUvA4W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713095846; c=relaxed/simple;
	bh=qNfyP6+N47Nnq8yDNAPSuzYpS17ThV2sImlbgnsxS80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nS4eReFoIusSMieSLHblgqVEOy5HPknESzO+Vz8aEd1NmT9ykAw9eHVBDKVhtVa+62uVOTQSVHyVR1P9jiEVnPdy900VvYaPTFaRkGPpefZ7vbbXaxgaNnHVU0lJk60RxpH+i5CL7vkVcLfPvY/dn0bX8SkqaN3dKgi3xpFBnPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jmKyru0O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jmKyru0O"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43EBlr8f022735;
	Sun, 14 Apr 2024 11:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=GNfnvJZlFkANxj9Bcqjg
	Ei6JSCU/JhG2IWWZGbP80/Y=; b=jmKyru0OaG+XXR5J5d1uW+/EtbJp21+TcCFI
	HzQww0BEFmpMMh8JTSkevYrQIC4u0102t2FNvfxGgFVIAuWQ+HrgNku/e4wVAM3P
	jQm8XukEt/bwntL2KjLgxOoiwfK2HTEXh1xK3P/AMeeA04bEBBQaiXVx+xLVqD9E
	63FpCa+kebL4Y8V4uXiQeFi9mUjJZr2DU/o7aNOZ2C/oprTjGENoI3R8O0bhSm3u
	d006/lqE2+MmBP5FCAw8jnAK6Me047EH/PrduK3vhUsHUfg0JPOPoyKGPWxNcxSR
	9JDpU32S09Eb/KQ1CDhMBTES59LePFjLd47WxsgnIMepMox7lA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xffrka1dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 11:57:16 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43EBvFkk015821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 11:57:15 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 14 Apr 2024 04:57:13 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <wt@penguintechs.org>
CC: <linux-bluetooth@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v1 1/2] Bluetooth: qca: Dump more config info for debugging
Date: Sun, 14 Apr 2024 19:57:04 +0800
Message-ID: <1713095825-4954-2-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713095825-4954-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713095825-4954-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: glcJOAkL2NFtfo3YvUSlo9fFO7iTsH7Q
X-Proofpoint-GUID: glcJOAkL2NFtfo3YvUSlo9fFO7iTsH7Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404140086

Dump more config info for debugging.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 67 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ecbc52eaf101..b61ca9828284 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1883,8 +1883,12 @@ static int qca_setup(struct hci_uart *hu)
 		soc_name = "wcn7850";
 		break;
 
+	case QCA_QCA6390:
+		soc_name = "QCA6390";
+		break;
+
 	default:
-		soc_name = "ROME/QCA6390";
+		soc_name = "ROME";
 	}
 	bt_dev_info(hdev, "setting up %s", soc_name);
 
@@ -2281,18 +2285,33 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	if (!qcadev)
 		return -ENOMEM;
 
+#ifdef CONFIG_GPIOLIB
+	BT_INFO("%s: CONFIG_GPIOLIB is defined", __func__);
+#else
+	BT_INFO("%s: CONFIG_GPIOLIB is Undefined", __func__);
+#endif
+
 	qcadev->serdev_hu.serdev = serdev;
 	data = device_get_match_data(&serdev->dev);
 	serdev_device_set_drvdata(serdev, qcadev);
 	device_property_read_string(&serdev->dev, "firmware-name",
 					 &qcadev->firmware_name);
+	if (qcadev->firmware_name)
+		BT_INFO("%s: firmware-name is \"%s\"", __func__, qcadev->firmware_name);
+
 	device_property_read_u32(&serdev->dev, "max-speed",
 				 &qcadev->oper_speed);
+	BT_INFO("%s: max-speed(%d)", __func__, qcadev->oper_speed);
 	if (!qcadev->oper_speed)
 		BT_DBG("UART will pick default operating speed");
 
 	qcadev->bdaddr_property_broken = device_property_read_bool(&serdev->dev,
 			"qcom,local-bd-address-broken");
+	BT_INFO("%s: bdaddr_property_broken(%d)", __func__, (int)qcadev->bdaddr_property_broken);
+	if (data) {
+		BT_INFO("%s: soc_type(%d)", __func__, (int)data->soc_type);
+		BT_INFO("%s: capabilities(%#x)", __func__, data->capabilities);
+	}
 
 	if (data)
 		qcadev->btsoc_type = data->soc_type;
@@ -2320,11 +2339,29 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			BT_ERR("Failed to init regulators:%d", err);
 			return err;
 		}
+		{
+			int i;
+
+			BT_INFO("%s: num_vregs(%d)", __func__, (int)data->num_vregs);
+			for (i = 0; i < data->num_vregs; i++)
+				BT_INFO("%s: %d regulator %s I(%duA) is %p",
+					__func__, i,
+					qcadev->bt_power->vreg_bulk[i].supply,
+					data->vregs[i].load_uA,
+					qcadev->bt_power->vreg_bulk[i].consumer);
+		}
+
 
 		qcadev->bt_power->vregs_on = false;
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
+		if (IS_ERR(qcadev->bt_en))
+			BT_ERR("%s: Get enable gpio ERROR", __func__);
+		else if (qcadev->bt_en)
+			BT_INFO("%s: Got enable gpio(%d) ", __func__, desc_to_gpio(qcadev->bt_en));
+		else
+			BT_INFO("%s: qcadev->bt_en(nullptr)", __func__);
 		if (IS_ERR(qcadev->bt_en) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855)) {
@@ -2333,7 +2370,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
-					       GPIOD_IN);
+							  GPIOD_IN);
+		if (IS_ERR(qcadev->sw_ctrl))
+			BT_ERR("%s: Get sw_ctrl gpio ERROR", __func__);
+		else if (qcadev->sw_ctrl)
+			BT_INFO("%s: Got sw_ctrl gpio(%d) ", __func__,
+				desc_to_gpio(qcadev->sw_ctrl));
+		else
+			BT_INFO("%s: qcadev->sw_ctrl(nullptr)", __func__);
 		if (IS_ERR(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
@@ -2341,6 +2385,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
 
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
+		if (IS_ERR(qcadev->susclk))
+			BT_ERR("%s: Get clock ERROR", __func__);
+		else
+			BT_INFO("%s: susclk(%p)", __func__, qcadev->susclk);
 		if (IS_ERR(qcadev->susclk)) {
 			dev_err(&serdev->dev, "failed to acquire clk\n");
 			return PTR_ERR(qcadev->susclk);
@@ -2355,13 +2403,24 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	default:
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
-					       GPIOD_OUT_LOW);
+							GPIOD_OUT_LOW);
+		if (IS_ERR(qcadev->bt_en))
+			BT_ERR("%s: default Get enable gpio ERROR", __func__);
+		else if (qcadev->bt_en)
+			BT_INFO("%s: default Got enable gpio(%d) ",
+				__func__, desc_to_gpio(qcadev->bt_en));
+		else
+			BT_INFO("%s: default qcadev->bt_en(nullptr)", __func__);
 		if (IS_ERR(qcadev->bt_en)) {
 			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
 			power_ctrl_enabled = false;
 		}
 
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
+		if (IS_ERR(qcadev->susclk))
+			BT_ERR("%s: default Get clock ERROR", __func__);
+		else
+			BT_INFO("%s: default susclk(%p)", __func__, qcadev->susclk);
 		if (IS_ERR(qcadev->susclk)) {
 			dev_warn(&serdev->dev, "failed to acquire clk\n");
 			return PTR_ERR(qcadev->susclk);
@@ -2384,6 +2443,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	hdev = qcadev->serdev_hu.hdev;
 
+	BT_INFO("%s: power_ctrl_enabled(%d)", __func__, (int)power_ctrl_enabled);
 	if (power_ctrl_enabled) {
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 		hdev->shutdown = qca_power_off;
@@ -2448,6 +2508,7 @@ static void qca_serdev_shutdown(struct device *dev)
 		    !test_bit(HCI_RUNNING, &hdev->flags))
 			return;
 
+		BT_INFO("%s: Start to send EDL_RESET_REQ", __func__);
 		serdev_device_write_flush(serdev);
 		ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
 					      sizeof(ibs_wake_cmd));
-- 
2.7.4

