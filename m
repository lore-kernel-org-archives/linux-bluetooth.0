Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3AE253F1E
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466561; cv=none; b=V9uIKeOzQVsAE8Q54OWtY8tDFrDHeXAVHMQpnDECpM6Q4nIpUjTfd7Q5mMKygu3xGgaOnqkO1ifVORhB+zIe4QO5yoMSCWLe3+8Z4HN1SQFK23QuMR2TJV2dP8E2ac+x1GZ7eZBSo5e39aQHE5ohdwarEhKzl6jXOOGc3VbSjEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466561; c=relaxed/simple;
	bh=CWXVJPRaE5vgLsLcn6pPE7Stlt+gGCDUKYPk9GE2LZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qiJy/KUHfYyfgf4VfaLU1hCq+ckVp4smdqwM2JPKXQLSnzLnDy0cCocCHqWAjVcf8MeL/osuqLoxPotk36Z1kyoLNuXhibxPyEYN2u8JWYeM/5tk+zB7uLb6VB9ma6w/SHIeSeP0EQ3UMzND6ahpK6cr5Aj9l+69uNvBEqtSrek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mLu9IsDH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mLu9IsDH"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5599LcND016705
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Jun 2025 10:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=b7zusUyzY2lsSoorkEk7N+QaOhw04dRe8+8
	bBOWfdO4=; b=mLu9IsDH2TFWp6zNJEtH609QR4JIS3/A5YdVOYtZJOpmAct0Lkq
	xIxPD6/TD3bj9++QkSYmmyi89WvBnF4UpHOyNKo8OHzmO5lG0SXju9+MWp1nwEHS
	C1hFg6/dol8G9P1+m72ch8sXZVeGiKV1VkCyGomCJxnQBJXTLe9bsOtmkj8rS36c
	1f4S8G3JaZ2sHWPSx1EYmSZ31/oIrba+wc2i8QtGdvgzd1Es98QOsxURSMo5C8WJ
	0tw5bfk68cLZsnmMrjkWPs1/muV1tecYvN9PRoIIF+0u4VZWetLQuhPr+lPIzEPc
	Lb/tPYOuin5oBEZLlsFX92QHVYB2ESZYbeQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dn65nx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 10:55:58 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 559Atuar014247
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Jun 2025 10:55:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 474egksaj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 10:55:56 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 559At4gA013078
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Jun 2025 10:55:56 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 559AtuhO014243
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 10:55:56 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id 7AEA422479; Mon,  9 Jun 2025 18:55:55 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: linux-bluetooth@vger.kernel.org
Cc: quic_bt@quicinc.com, Shuai Zhang <quic_shuaz@quicinc.com>
Subject: [PATCH v1] driver: bluetooth: hci_qca: fix ssr fail when BT_EN is pulled up by hw
Date: Mon,  9 Jun 2025 18:55:53 +0800
Message-Id: <20250609105553.3756688-1-quic_shuaz@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MyBTYWx0ZWRfX9IpNPdNhbqeb
 32h3sSNtP8rTlCSjQG69wD3yF879gfyWh8tD5YGDdugUnCwAU6MiPdwQqB7fGpLzxXVY6zpvEhv
 9wyYp3kNndYj0Ujz20T36jKy+lmsEs94/ioUGrExdmAQaNGF3/KgOt41LbC/XT75FcPbz5RROsb
 idHZ+RhjChT28qvM6NOmcqQgHi2zZ87OIOeJb/RWA8S74AIhFF/xeObgzeBqTQt+dcatxxzFMWV
 KKs8DtZzgA3L+RvHngJYGmqRgrnfptxFvedF9SyUa0kNuuY8pxXTTI/02dSJ44M7tB4kb5cQxjo
 9SVb5IQVMCB7IKwzskWnfiQNDRm4nSvP/3gQ+36TsXggk2o8M3ZHQbfeemzUdP4pqrLkVliOqw+
 O1bSaz9uG7faEqkzsor1A459UHJjLsuvd4IEUHynUCCmU7QpS9aPZ6JbvJDa8VewdqaZDqBd
X-Proofpoint-GUID: 1774xlt11rQAFVCtAABZmlKrm1W0HsFJ
X-Authority-Analysis: v=2.4 cv=FaQ3xI+6 c=1 sm=1 tr=0 ts=6846bdbe cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=TfFMHS9iAAPzH1I8D5MA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 1774xlt11rQAFVCtAABZmlKrm1W0HsFJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090083

If the SoC always enables the bt_en pin via hardware and the driver
cannot control the bt_en pin of the SoC chip, then during SSR,
the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
This leads to a reset command timeout failure.

To address this, clear QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits
after the coredump collection is complete.
Also, add msleep delay to wait for controller to complete SSR.

Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a2dc39c00..1c3df6e30 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1653,6 +1653,22 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
 	}
 
 	clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
+
+	/*If the SoC always enables the bt_en pin via hardware and the driver
+	* cannot control the bt_en pin of the SoC chip, then during SSR,
+	* the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
+	* This leads to a reset command timeout failure.
+	*
+	* To address this, clear QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits
+	* after the coredump collection is complete.
+	* Also, add msleep delay to wait for controller to complete SSR.
+	*/
+	if(!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
+		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
+		clear_bit(QCA_IBS_DISABLED,&qca->flags);
+		qca->tx_ibs_state = HCI_IBS_TX_AWAKE;
+		msleep(50);
+	}
 }
 
 static void qca_reset(struct hci_dev *hdev)
-- 
2.34.1

