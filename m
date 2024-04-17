Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EEA146A84
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366281; cv=none; b=GpmuGcI7tmbRNT+2uJy+cd9cLwkWdHP6dx2OM4tK1Px0QFfEO4L/c3eaYt9HT6jCitejhanABA+Pgk4fOOX4zF4BM5eNTSMFrEidIKfial6uGQBQye5I+GCEV4aEOQJLkojReNQ7LBPw8VoWuk/6nWGsFmKHvSLLAIhF3r3epJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366281; c=relaxed/simple;
	bh=i7fwWTLxZUl049Po97pgfO1PZoSDn7N8QaMFxl6qvwc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CR1SijwMxDOJNblcS2+bXGg+1bX65CDvrHA0GCzAFKsMi5BqkEIJPObK9mJEj9rwVSv674n03hzAgkc/+ROCNSMS/lfDYEaFWJdF/XRLT3UJwGPozWL7oTIJkIBHOn84qL3M+ELxauHBbUFedqFd6hYbsB41jL6G5ZInENYFB7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZP78PvnA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZP78PvnA"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HCQZY6028532;
	Wed, 17 Apr 2024 15:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=oUh//TYJlwYCt0KzVIUH
	DcWK35AMlLWz7I/B7wwn9b0=; b=ZP78PvnACchEUypVg4ptX/3n6i3O+t7bSA1z
	VtRbhnRMvc++RWS0xtFrOd6tV4CPQxfxvFl3aALF3aTNvozH9/PSOHZgtAPYhxLZ
	ZF+SjPwxvdnN2Yjo4Le5oudIJlqSXYilRJq2NyIP8JPIZkm2aMtahKB9mX6Snr+E
	1foE1Z5/QFXN3+qUnBazOUuJgturzFaCSHxI7UY+ShgaHbl8C+zJM3OHuq5ijr0s
	EgCmo0yh8aeSLk+gK8rlX6qiRhVPZmarSvi2gBEtEoI6ND/nW+suV/NLqXkC9dKG
	1KT3HcoXabuxTOW8vNPsSCW1RcX/Tl1o/AAjjEzEv9C64NFizw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj7tr1djd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:04:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HF4Gjn007849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:04:16 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 08:04:15 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <wt@penguintechs.or>,
        Zijun Hu
	<quic_zijuhu@quicinc.com>
Subject: [PATCH v3] Bluetooth: qca: Fix QCA6390 enable failure after reboot or disable
Date: Wed, 17 Apr 2024 23:04:11 +0800
Message-ID: <1713366251-22144-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713175927-13093-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713175927-13093-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: u7zal1AGwAmXd5UF0g3wuKs9j4_LlvOz
X-Proofpoint-GUID: u7zal1AGwAmXd5UF0g3wuKs9j4_LlvOz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_12,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170104

Fix QCA6390 enable failure after reboot or disable.

it is a debugging change and don't merge.

Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes v2 -> v3
 - Fix Reverting the 56d074d26c58 error
Changes v1 -> v2
 - Revert part of 56d074d26c58

 drivers/bluetooth/hci_qca.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b61ca9828284..f58bce5448ee 100644
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
@@ -2411,7 +2411,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 				__func__, desc_to_gpio(qcadev->bt_en));
 		else
 			BT_INFO("%s: default qcadev->bt_en(nullptr)", __func__);
-		if (IS_ERR(qcadev->bt_en)) {
+		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
 			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
 			power_ctrl_enabled = false;
 		}
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
 			return;
+		}
+
+		if (hci_dev_test_flag(hdev, HCI_SETUP)) {
+			BT_INFO("%s: Don't send EDL_RESET_REQ due to NOT setup ", __func__);
+			return;
+		}
 
 		BT_INFO("%s: Start to send EDL_RESET_REQ", __func__);
 		serdev_device_write_flush(serdev);
-- 
2.7.4

