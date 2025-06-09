Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589E253F1E
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466547; cv=none; b=VjxH+f4JaCCFMgOSe+r0I7+7J6LsiRVN+gGvJE98NqGxbGVRvvmOWfExoaKvWSo+Ri0hCyYAxYlOLPZt0xWDDpHxZ6GZy2SBWzASN6U4DsO1/TZVfUVk8tPp26YPY7O/esluxkk6maWmu9RM0uf/B2G+ZTRE3VWbHA99USsAL+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466547; c=relaxed/simple;
	bh=Kdm7wGTdAs/Anruyge+iCOhVV7Dz8AYGAYl9if+qvZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eM02s3Z/jsPmqTYaN8HuLcyLAZAB8TY42M5fCaQQ3aJOuillDioFsSRuJOkabevYFTJyvrN3G2bdYxhrthfghm+AoNP45qwAxqixh5BJzZxW+BfMsq5miT+HMyY44vTX9GLm36gfdy+7e+bqkGEZ4WP+J61fWqwIytU4zd9AEY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=McawUCIo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="McawUCIo"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5599A8Tv000639
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Jun 2025 10:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=q0u5atGeIk3mLaPpndjgjOognGgV87kUH4i
	/SfsKWfg=; b=McawUCIo8sLt/0Wz4YkWq5F6Qe3lFjLFVEsjiDxqxp93E+zgeuX
	Ed9PF2ovQN8Fz7Aq9Mt8u0Tgf2hPFWYkVsG7rDGswkU9xJbgHiesIDGU2sJ9+pAa
	EQUq0HPEGq5r4YoCsZeEL4zmdJo7VbH0dpKe9aTHvrvyGUmnW3Hp2VlpGdiYERhU
	9Fra2J9q9omhL8lNiHp/kOfmwS/hTB8mnQ0ffb9zJ5NgwQPDZ2pIKWCPheRnwyE2
	/0+Ka+jRKIiKcfX6KPn4th0y2BCpUkeDINbn+hUG5qV+QDYEIL4rJN9AOexakxX6
	z0g1YSbs5br9L5Da8Du1ITwM4X2c0/iymMA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dn65nwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 10:55:44 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 559AtgDS032023
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Jun 2025 10:55:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 474egm1a0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 10:55:42 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 559Atg1P032020
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Jun 2025 10:55:42 GMT
Received: from bt-iot-sh01-lnx.qualcomm.com ([10.253.136.182])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 559Atg1k032019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 10:55:42 +0000
Received: by bt-iot-sh01-lnx.qualcomm.com (Postfix, from userid 4467449)
	id 5DD96529; Mon,  9 Jun 2025 18:55:41 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: linux-bluetooth@vger.kernel.org
Cc: quic_bt@quicinc.com, Shuai Zhang <quic_shuaz@quicinc.com>
Subject: [PATCH v1] driver: bluetooth: hci_qca: Disable auto_off when BT_EN is pulled up by hw
Date: Mon,  9 Jun 2025 18:55:38 +0800
Message-Id: <20250609105538.4090716-1-quic_shuaz@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MyBTYWx0ZWRfX1XZ4h7Vd9yss
 nVLjV+Vu2LL6JNPfLIkCKKkUeBOMsxYmkaTQQnKztatm4OTi/UdQSxzn/Ke+v2cxuJ0HmPLFYUH
 4CavQP4EdF5ShX4jvaJy/HphjbOM9DGY0h3SQCCf+w0Vrn659URZkpafpfUvqmARjAZn9bePkkh
 bJTdmD04A3CYsZpIKkIq/xUP8E/uTh6LHOdLWJN94pbqpWOauj24wJo+7jL3vVftW+LNsKzdXX+
 BSzhWG9dW0v+6pdITQA9+KFQ+H4d1MDiF2YiUymwbkHagWFEvG4en07+PLz9BZaSHfCHOT51HYg
 oq/mFuxCHzqTPHJCVpkgCcTjnMrXh2XYe9iEOwLUKkmkutUy4YB1OE1etYHIWRco3UsdVS2H68U
 F3sgF1ooGzd36aZV7Kg3Nrq/LJ8KJOCPBcjDGtxzyn6hSmgIHzsR/LfgQtLJ+m50uqYzTt75
X-Proofpoint-GUID: NTgzIdKSlXFQ57_L4_lKcUSj7MgxY54n
X-Authority-Analysis: v=2.4 cv=FaQ3xI+6 c=1 sm=1 tr=0 ts=6846bdb0 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=0wUWtdZKXph8n2MIYw0A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: NTgzIdKSlXFQ57_L4_lKcUSj7MgxY54n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=844 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090083

If the BT SoC BT_EN is controlled by hardware, disable the AUTO_OFF
feature. Otherwise, BT will close the HCI layer except for the UART
after firmware download. However, the SoC remains active. If the SoC
sends a packet to the Host after firmware download, the Host cannot
respond since the HCI layer is closed, which will cause the firmware
to enter an incorrect state.

Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a2dc39c00..0cb70a3cf 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2483,6 +2483,15 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 		hdev->shutdown = qca_power_off;
 	}
+	/* If the BT SoC BT_EN is controlled by hardware, disable the AUTO_OFF
+	 * feature. Otherwise, BT will close the HCI layer except for
+	 * the UART after firmware download. However, the SoC remains active.
+	 * If the SoC sends a packet to the Host after firmware download,
+	 * the Host cannot respond since the HCI layer is closed, which will
+	 * cause the firmware to enter an incorrect state.
+	 */
+	else
+		hci_dev_clear_flag(hdev, HCI_AUTO_OFF);
 
 	if (data) {
 		/* Wideband speech support must be set per driver since it can't
-- 
2.34.1

