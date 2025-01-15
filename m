Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D022459BF;
	Wed, 15 Jan 2025 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948060; cv=none; b=ZRQN4MNYSvuYDVLsS04bm6C2MxVXpIE3iYrFBG+97XJJFbeYpFLcT/PDtSR6xC5DkKoClw6C0rUGJRbufqiFQ99R1lXE8JvD7lcsDlBrtT+D4w27xdXfvYJ/atXsnMWOaMlMDBv1k2zA9fvYR/qg8JCUhph957IESi8YOBELE18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948060; c=relaxed/simple;
	bh=FjBXeE/zuyBr+q28ue/5ZT3hlGKj7j3hYaspkx0o5eI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ZQtpO1Jh6jSIo6qfwSPqdZfeRjyr5gyL5BERy72n7hgHcfvajRrXJdAWg+i8JzM/d8dXVuFtT6+OYyZDi1NvAU1uh41Fuq0z17zWNFU/RlveYEOc1OALmsqFgp3L/846QEunkvBUixgeLXV7Jk2F5Rk7/aQ+u/ICpRUsmEJSSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UdmscCWt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UdmscCWt"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F7GCqR031075;
	Wed, 15 Jan 2025 13:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Orzhyf4NdEnesO098a2o3/
	NWT0Fn85yPcrVi/6lMu0Q=; b=UdmscCWtLlvV9nW1Ea3aDBcH9gdDz0K82tkmVB
	i/t9JnvM9FN6tjmtgQoFDGYs4SI2JPS+5JNwlNGU3Xg27stGZ2h/aIoOCs8i+/Ic
	fEHYDk+36iH2q+JHQQGaK2plq9SB0fovDqPJV+CSdXZG5MHyHR7C86jmNrmJbUpm
	DtIyErd+sVblKjaYvMSSFIVTQNbDPb7coJFEZL3ZK/cfMDhL925swc/dLzFgo6AP
	hT4GoFsufGkpMs/8ZzNeemCeAvfShMQsQuheCnXzy8gOdmuF9E/RKPCI2Rh6wdzq
	V7NTpsD1cSnl0FYayY8JqchilyZTDPKjvdrDtpgcKQILX5Dg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4468fs0xhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 13:34:11 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50FDYALE007918
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 13:34:10 GMT
Received: from hu-zijuhu-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 Jan 2025 05:34:09 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Wed, 15 Jan 2025 05:33:40 -0800
Subject: [PATCH] Bluetooth: btusb: Add 14 USB device IDs for Qualcomm
 WCN785x
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250115-qc_wos_btusb-v1-1-811664ce5d64@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADO5h2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQ0NT3cLk+PL84vikktLiJF2zRBMj42RDcwtjYyMloJaCotS0zAqwcdG
 xtbUAhc7YkF4AAAA=
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: Zijun Hu <zijun_hu@icloud.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I6lPic9rhe2Ssnyl3BDQGQSwXnAtkbAz
X-Proofpoint-ORIG-GUID: I6lPic9rhe2Ssnyl3BDQGQSwXnAtkbAz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_05,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=932 impostorscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150103

Add 14 USB device IDs for Qualcomm WCN785x, and these IDs are extracted
from driver inf file within various types of WoS(Windows on Snapdragon)
laptop.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/btusb.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9aa018d4f6f5..633a0d11474d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -375,10 +375,38 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0f3), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe100), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe103), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe10a), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe10d), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
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
base-commit: 1f2ae3fb1cdc552b38e625fa807800ffbb858ce3
change-id: 20250115-qc_wos_btusb-6a423c178332

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>

