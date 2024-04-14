Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0284B23763
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Apr 2024 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713095842; cv=none; b=Oe0yIwuxygyqCpxAbdJ0Rgr7NsG4mT9Jvf+ilM7YwPU730YYkZPaYb03xH4FzD103JIJLwXxu+5XKXDRORS27E56J2hjUYqUcO53/9rRwqoziD8Pld8oj1p3P/6vt+l4+v/A26YWhJhS4ay5SV5+R2BOkkIbO5PUnPvJ3hm+U40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713095842; c=relaxed/simple;
	bh=ghSKYWP5x0FlYPCZCZwNLjQwzg/OtUN7guLUs9gpl9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrOGJgyqZKWRmrtd773zD2kjBnuAZyxSG9ddfScD3U5xPBPkY8ARRarnExeSRAEU31hxfeyp21ZzHCM80H2KGJV9WCVKKPBT9Uznrs/ZLK8c7v4bcyLHeKCEkDAWfFiY/6G5y7MJWjS0qU+12RKu+NVmxRpZdDn3fAA6PFHtqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oHAlI5bA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oHAlI5bA"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43EBroLJ014940;
	Sun, 14 Apr 2024 11:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=SpQ1Sh1daCr9mnGe/dXN
	GgJQA6ioZ7iyNQIKuwgkLiQ=; b=oHAlI5bAMAoYNpvHTNTrlw6H3sU4aAvXrepg
	BIi4+nnErFa2kHGoz629XzJcTeV0QjSsOOintKvQ6wVz1/59J/oG/oILlXT+6Icd
	IqJLVFDB3k3OdfGdLRoaJN+QzSIDQ+2Ck9BtFLiVDL8b4KFCmItrkII9M1ZJQvXN
	ymL3sagwSSeNa7yqxudbATZx7cxA81x0MwKXxs6aunFpmF3SkpQHB5t/4+fy8+aP
	kfzvY9SXz7Gg1Ft0hvwK4370SGXaBdU7UnGUcsR5DbGHoxwetWWYLfqpqQFX/gCd
	soKUSC/qZ0F3Q8zGdBIpDF1XVpXQcIrtaSg/avV2p4+6UqVRhA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfhcnhu7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 11:57:18 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43EBvHkX015840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 11:57:17 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 14 Apr 2024 04:57:16 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <wt@penguintechs.org>
CC: <linux-bluetooth@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v1 2/2] Bluetooth: qca: Fix QCA6390 enable failure after reboot or disable
Date: Sun, 14 Apr 2024 19:57:05 +0800
Message-ID: <1713095825-4954-3-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: DDPJJShc53vM0fl6Fod02IDX89s5C_Mx
X-Proofpoint-ORIG-GUID: DDPJJShc53vM0fl6Fod02IDX89s5C_Mx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404140086

Fix QCA6390 enable failure after reboot or disable.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b61ca9828284..d390d68a831a 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
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

