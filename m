Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296F17548
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710914944; cv=none; b=Xo5r9GAAejt8eBy+QOIlplTFmsyg54YP3meTe76pqIYZL7BXLVnq/cXz0lk+hWXQn/74iLoou5CSkHIenDZr7/YlfdhWeHZiCeFVaoMkczuIB1vB7KeX7g0/WrUM7IKHEZeBj4X8siOrwUlfNSIpwKg+1w3Uhhadn+nm5ve4bb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710914944; c=relaxed/simple;
	bh=6Fpp7Et4/rFCDQak1UvP6i4IyL8s7+YWc+m7tcPqTlU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AvIXoUukh+mTinXK5axcz2d+zxWG4kmcrSmlJ+c0QVY8K61uFj2M5VzU/mnSEOn5PDKNnyHG7rw4yUe8dwjeCVAezHxjDmntfBbKafM6ZC9OgyOdnhjMOygRBN/rEldPgyw6STZo/e/YHakMGhoHWPVpp+TXAsRyJrtBZgOgmsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nvdYeTKG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nvdYeTKG"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K4edli029777;
	Wed, 20 Mar 2024 06:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=r+v3XUw7YkiiUtTM+gKj
	nFHhbtREOnJzAdtL9EVC75I=; b=nvdYeTKG3a4b+13hxvqz8xMVz6aLNmvExWRS
	2tsZ0M4EpOKtohpUMfvZiLIlyPGvkbcuVmWH2yxqrv4kqs1mmVmUkYRXLoxJh8ZS
	5Nh/6xRZ9rCh9lqz2sKeV8wh6E+RfDvmFEQP3UC0p2Dcsjm7J4aUonVuEp3DoVzM
	c7np7Jnu4qQ+iOvzkWIY32wzlACDjGBcuUN0JOSvj4t5BiYDXMrITovHEiHqtoT1
	fMVSAqiEReNnHZBwHxtx33ZVNOsI7HQrf6+q/wq32kl9boO0PsQGzYupTmWtOoIu
	kZGKyGzMg4H0oahBzrx6eRkciDlTAFULLa02/luctH6sIoTm4A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wygbbh3jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 06:08:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42K68tnV009902
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 06:08:55 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 23:08:54 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v1 2/2] Bluetooth: qca: Fix wrong soc_type returned for tool btattach
Date: Wed, 20 Mar 2024 14:08:27 +0800
Message-ID: <1710914907-30012-3-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: dqvUUy5KOQVdu0qo-e0ji-CfZxH_RUnw
X-Proofpoint-GUID: dqvUUy5KOQVdu0qo-e0ji-CfZxH_RUnw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_03,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200046

qca_soc_type() returns wrong soc_type QCA_ROME when use tool btattach
for any other soc_type such as QCA_QCA2066, and wrong soc_type will
cause later initialization failure, fixed by using user specified
soc_type for hci_uart derived from tool btattach.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/btqca.h   | 1 +
 drivers/bluetooth/hci_qca.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index dc31984f71dc..a148d4c4e1bd 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -153,6 +153,7 @@ enum qca_btsoc_type {
 	QCA_WCN6750,
 	QCA_WCN6855,
 	QCA_WCN7850,
+	QCA_MAX,
 };
 
 #if IS_ENABLED(CONFIG_BT_QCA)
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 8a60ad7acd70..06bbcc678f88 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -238,12 +238,17 @@ static void qca_dmp_hdr(struct hci_dev *hdev, struct sk_buff *skb);
 
 static enum qca_btsoc_type qca_soc_type(struct hci_uart *hu)
 {
+	/* For Non-serdev device, hu->proto_data records soc_type
+	 * set by ioctl HCIUARTSETPROTODATA.
+	 */
+	int proto_data = (int)hu->proto_data;
 	enum qca_btsoc_type soc_type;
 
 	if (hu->serdev) {
 		struct qca_serdev *qsd = serdev_device_get_drvdata(hu->serdev);
-
 		soc_type = qsd->btsoc_type;
+	} else if ((proto_data > 0) && (proto_data < QCA_MAX)) {
+		soc_type = (enum qca_btsoc_type)proto_data;
 	} else {
 		soc_type = QCA_ROME;
 	}
@@ -2286,6 +2291,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		return -ENOMEM;
 
 	qcadev->serdev_hu.serdev = serdev;
+	qcadev->serdev_hu.proto_data = 0;
 	data = device_get_match_data(&serdev->dev);
 	serdev_device_set_drvdata(serdev, qcadev);
 	device_property_read_string(&serdev->dev, "firmware-name",
-- 
2.7.4

