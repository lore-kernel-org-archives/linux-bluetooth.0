Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9C1FAA;
	Wed, 22 Jan 2025 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737517645; cv=none; b=hZwtAWpMKjKk1B0W9A8Kkh3DghrgkoOUN6U0A9gR8S423aMBKISL87S7qmh/RT3pvdxd6YmpnGjiWDHZWweC1G6WvZkQ1z3ooxlBa/yQ+aV5TeynVRLtWGNNm+nvNcUrkA7WMzl89L9SXSPQqJ293CGoBLKMcm1nkviYH0ORUVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737517645; c=relaxed/simple;
	bh=QFHiCbUJjcAb08amFgYGhCUlfsf7Y7RKau6wJLEMh90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=AzpHNE+0jo33gxZcVhv1i9TaPcwm9wwnfrquOSszxyv8fcq3j1cH67wcCjNk/PVsNtoeurxcN8UYQJkMNrqUG7znhfKC6T8Nxl2h9GDs6QhxIlQJz16j+EoQvZUHxX0aDgbqtcEwz3fNH2OJJ3BK/uZ3k2ViodfZH2sgVItAAH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AsGd95yp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AsGd95yp"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M1seMX014528;
	Wed, 22 Jan 2025 03:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=I4+4u2x5Cia25Xq2qybEbZ
	7LkHDMXrDzDdLmNPWdoFk=; b=AsGd95ypY+fDYijsC/UN29NSGzdIZ56Ym+Rk/K
	tnrB4d3O+VnBcZv4ZsmBHIxI46zEfywMWss0CBkdE0rmNaheBmQ7jF/ZUcJ+rjkD
	vOtRFA+96+GBdxuIVvZshGNU9q9e71b02Tn50TKxsi7TtuP0rUZ61ENBLQzIgn6b
	w/X2o8R8vaDcrpIcSwW/Y1Y/H69CR6AtxTeg/JVxVNRiAeffnznkJv86ptIvmscf
	D8Bg7uPiQHB2SMXMaxo6dONeY1PFAy2QFo2NL0TeUYR8d2KcFxi5iqacvu8JD3Ys
	H/zJCWrt6v08QZcv56p68PU4ygKwN1qMey1oWR2gieFSyGBw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44aqe707t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 03:47:15 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50M3lEiC022864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 03:47:14 GMT
Received: from hu-zijuhu-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 21 Jan 2025 19:47:13 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Tue, 21 Jan 2025 19:46:42 -0800
Subject: [PATCH v2] Bluetooth: btusb: Add 13 USB device IDs for Qualcomm
 WCN785x
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250121-qc_wos_btusb-v2-1-377b3dc2a706@quicinc.com>
X-B4-Tracking: v=1; b=H4sIACFqkGcC/3XMQQ6CMBCF4auQWVvDtLQSV97DEAJDlVlIpYWqI
 b27lb3L/yXv2yBYzzbAudjA28iB3ZRDHgqgsZvuVvCQG2QpdYmoxUzty4W2X9bQC9NVUhGeaqU
 k5MvT2xu/d+7a5B45LM5/dj3ib/0DRRQoakRjKrJ6MNVlXpl4oiO5BzQppS/1bDHtqgAAAA==
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: Zijun Hu <zijun_hu@icloud.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, gs <gregoire.s93@live.fr>,
        Zijun Hu
	<quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c072ii_bUwfgGD5ICgnFVuEfmA3XE41t
X-Proofpoint-GUID: c072ii_bUwfgGD5ICgnFVuEfmA3XE41t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_01,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 mlxlogscore=884
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220025

Add 13 USB device IDs for Qualcomm WCN785x, and these IDs are
extracted from Windows driver inf file for various types of
WoS (Windows on Snapdragon) laptop.

Cc: gs <gregoire.s93@live.fr>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Remove a conflict ID since later post change is merged firstly.
- Correct title and commit message.
- Link to v1: https://lore.kernel.org/r/20250115-qc_wos_btusb-v1-1-811664ce5d64@quicinc.com
---
 drivers/bluetooth/btusb.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 75a0f15819c4..1caf7a071a73 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -375,12 +375,38 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0f3), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe100), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe103), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe10a), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe10d), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe11b), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe11c), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe11f), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe141), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe14a), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe14b), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe14d), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3623), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3624), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2c7c, 0x0130), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2c7c, 0x0131), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2c7c, 0x0132), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },

---
base-commit: 07b6216dfc34029a7663100fad7cc2c22dd77a74
change-id: 20250115-qc_wos_btusb-6a423c178332

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>

