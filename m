Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D30433D8
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175938; cv=none; b=TAPAn1U9TFKXseyS5XEETOn0yEkmEwibuge/m/AhCi0Gm5/u3lqTIl2W+SKUZFYt04B9JTXmp9Foz5j7ced0oqAmpZ64njlZNGI7Ny8U30ePFIQXIMnEDg+gbk3lutWmICWT/5fVvp4+SFL7cpLkCa0999sB9rAA9dBv2/mZmNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175938; c=relaxed/simple;
	bh=CrBn+TrfrocrH9kcWMR0b/I/GmlHPFBIgM6v/UuiwYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPHC2Q4Tu34X8G6+bskp1RIwhMO9nWQlZnvpoa18WnURZ3L71h92N2QMBLgh4uYbh5ndsmsNG+Mdw38hV/YX2CufxMSVmBlfjXKJjuwqiufU1JY7OKKfDToZ3kvMsc19f3/9703bbVjHeygvdkQi2wVJ4oKv55eS3Mpgtov/Lj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aCSfboHi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aCSfboHi"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43F5GDex004070;
	Mon, 15 Apr 2024 10:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=pV+f0bJoI08UZ7ri2Ts9
	cCtn2UvcAycmper3Q5lELRo=; b=aCSfboHiwMKS4XUf7k0et+mS7gE2R2Zt1P7c
	FCFZPx3VmAllHIfskKFt/aNN9Qcl6EBTP5f/N2BjkgXuJltjrXMuUH4QYBQMBEyv
	0/P8Zn86ZhWKlaFqfRZbE+K95XLE91OFOUDIsKlrMg5c6baGPCaJPpeAEgzrHKrk
	NcsT2ZpCTQQh3Q2PfGWx9J17l4ux5N9nYqLEMnqcZ2V0SW2JIc522CfD5IUANJOP
	FC28Ck/kO/npUP5OVFf4/zR6Hx8nFl04CdVcT9sCTh0Z11aDp9jcccSmBIHPGFrd
	9+O+rivwFN3swuZ7b0SuN+GfcDI1zHO9E7/vkJsmK+oJvgoORw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xgwdpgn0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 10:12:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43FACBSi019675
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 10:12:11 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Apr 2024 03:12:10 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v2] Bluetooth: qca: Fix QCA6390 enable failure after reboot or disable
Date: Mon, 15 Apr 2024 18:12:07 +0800
Message-ID: <1713175927-13093-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713095825-4954-3-git-send-email-quic_zijuhu@quicinc.com>
References: <1713095825-4954-3-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: QAYH95zTCYlt9lnRTtX5Z3chnRsEyQKR
X-Proofpoint-GUID: QAYH95zTCYlt9lnRTtX5Z3chnRsEyQKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404150066

Fix QCA6390 enable failure after reboot or disable.

Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes v1 -> v2
 Revert commit 56d074d26c58

 drivers/bluetooth/hci_qca.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b61ca9828284..d8a6d6b1bbea 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2362,7 +2362,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			BT_INFO("%s: Got enable gpio(%d) ", __func__, desc_to_gpio(qcadev->bt_en));
 		else
 			BT_INFO("%s: qcadev->bt_en(nullptr)", __func__);
-		if (IS_ERR(qcadev->bt_en) &&
+		if (IS_ERR_OR_NULL(qcadev->bt_en) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855)) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
@@ -2378,7 +2378,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 				desc_to_gpio(qcadev->sw_ctrl));
 		else
 			BT_INFO("%s: qcadev->sw_ctrl(nullptr)", __func__);
-		if (IS_ERR(qcadev->sw_ctrl) &&
+		if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
@@ -2404,7 +2404,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	default:
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 							GPIOD_OUT_LOW);
-		if (IS_ERR(qcadev->bt_en))
+		if (IS_ERR_OR_NULL(qcadev->bt_en))
 			BT_ERR("%s: default Get enable gpio ERROR", __func__);
 		else if (qcadev->bt_en)
 			BT_INFO("%s: default Got enable gpio(%d) ",
@@ -2499,14 +2499,19 @@ static void qca_serdev_shutdown(struct device *dev)
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
+			BT_INFO("%s: Don't need to send EDL_RESET_REQ", __func__);
+			return;
+		}
+
+		if (hci_dev_test_flag(hdev, HCI_SETUP)) {
+			BT_INFO("%s: Don't send EDL_RESET_REQ due to NOT setup ", __func__);
 			return;
+		}
 
 		BT_INFO("%s: Start to send EDL_RESET_REQ", __func__);
 		serdev_device_write_flush(serdev);
-- 
2.7.4

