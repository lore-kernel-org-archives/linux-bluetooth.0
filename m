Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9523ABA8;
	Tue, 15 Jul 2025 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589643; cv=none; b=Akxb/nH8oADMPYiUMVUPKdpFLhdHhXtO4UjAmv86Kfn0GhTU4TJrmZqwyAXCOyJPrI9o2EkNcQ8qro625625arX3TP05GMdmtlNSZonQxRGbYJfQQMwey3eJxm0hyiOl83Pmjv3oHbt+lKSC1OIjndia8J4a+dHgFOh9BVk3HcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589643; c=relaxed/simple;
	bh=azOA20WhlcScuYawwD2YcYQuTXsETYQo2IlMe5Oga+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kC1xxuHLITv4sanP7YaD2AdSR62vbFICpCG9ZmEn0O9zGPANxIl0uLiKG7ndX02yBk1VSCJKLg+y/nMwOkWzDOMkJlvJBgWUHcu/tnv6Su0NASIjO/vkYm9Y/Ci5FsbKfx//XVerKk5W9MdYomhhZI2mmNCpKn4mjGy/CD34gsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N4ra/U5O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N4ra/U5O"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FAk8xD008849;
	Tue, 15 Jul 2025 14:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l6JXToBQJz5YFQNxYZp6DvoVAPOS/aEMZxCWectfw+4=; b=N4ra/U5Oz8dcswr/
	dOk2P6U58WuM2C69S+I6ex6C8vX+wPLIWpTWD0XegrRafwfWmEHKJHh5AnbU6h+8
	b6/TiajFFzvdWbv8SDolBsX+4X38OTdN/+0wchSjokAto7Zui64ollPMtCd52edT
	XKFrDaEDG+/ZGA5PtZJQFw9dxNnIxACVCr0oJY87vadMnKmIhDRuBnkzmtrvgCQe
	e4+A6+8K9Au/gKdRYEh6NhOKpI44ls4qrf9FRYntiyCDulVZbiKa22jFeamaYkn2
	Cw3S22l/v4Qanv4uN5T09ELwucW7rvZ4q6yQbviTB7ZwBSQSx0CHdoHUTExJ3MaD
	nJCsIQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5rp73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 14:27:11 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56FERBlK026349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 14:27:11 GMT
Received: from hu-zijuhu-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 15 Jul 2025 07:27:10 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Tue, 15 Jul 2025 07:27:07 -0700
Subject: [PATCH 1/2] Bluetooth: btusb: Sort WCN6855 device IDs by VID and
 PID
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250715-q_newid-v1-1-8a1120c61fc9@oss.qualcomm.com>
References: <20250715-q_newid-v1-0-8a1120c61fc9@oss.qualcomm.com>
In-Reply-To: <20250715-q_newid-v1-0-8a1120c61fc9@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: Zijun Hu <zijun_hu@icloud.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zijun Hu <Zijun.Hu@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=6876653f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=3H110R4YSZwA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8
 a=XUOHylsD4iBfPMCdw_AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YIovyvILOxQzdEf9X7XI1UTSFL4SWLUU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzMiBTYWx0ZWRfX6iX97h+iETHt
 Y5iwCBGQ895jsaixc4KFm+jzE+MmbYSzl3m/Bg7bioPrlEaBYQDhDrbP6kJjRDgxJA8Z/tH9mqu
 LcLIffcTLEM2xl8a8aMeUCUy2HIhjk7MziduMuNJbbuMpfDxA2p2OqQSRrkc9v8PpfdPB3OO0a9
 ADXr+ojvJZk0HhEPUbCGEWtc1ZXw9TdyFyssKXRNY7icdlpbfo/xF6VwX09VJ7fpur5a1nVVJdk
 tuuOBYARxBUbMeHaFsaQHJtop7Em5o7Af5OpnXdnWSMRkDSRvTp7Gv2zUlkiPtSLyLoCk3kSlwb
 3eF0yx/MhfXoX87mF0/uS+aHAfT0F0zTHglaTUOBVW6cUuS58HeBboXv7YNxIGz2wJwCGy6SVNU
 Jf0p/rWlsJhA22I3Q0jShqAEwIMq0ZQ60CmQ8+eKbtzGiiXJssUxz8t4aOSaa2g4cwq6LsQg
X-Proofpoint-ORIG-GUID: YIovyvILOxQzdEf9X7XI1UTSFL4SWLUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 mlxlogscore=966 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150132

From: Zijun Hu <Zijun.Hu@oss.qualcomm.com>

Sort WCN6855 device IDs to more easily manage them.

Signed-off-by: Zijun Hu <Zijun.Hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 68 +++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f302c3f1e4cf..1b7458f3ad74 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -298,75 +298,75 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 
 	/* QCA WCN6855 chipset */
-	{ USB_DEVICE(0x0cf3, 0xe600), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x0489, 0xe0c7), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x0489, 0xe0cc), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x0489, 0xe0c9), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x0489, 0xe0d6), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x0489, 0xe0ca), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x0489, 0xe0e3), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x0489, 0xe0cb), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x10ab, 0x9309), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x0489, 0xe0cc), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x10ab, 0x9409), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x0489, 0xe0ce), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0d0), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x10ab, 0x9108), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x0489, 0xe0d6), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x10ab, 0x9109), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x0489, 0xe0de), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x10ab, 0x9208), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x0489, 0xe0df), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x10ab, 0x9209), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x0489, 0xe0e1), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x10ab, 0x9308), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x0489, 0xe0e3), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x10ab, 0x9408), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x0489, 0xe0ea), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x10ab, 0x9508), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x0489, 0xe0ec), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x10ab, 0x9509), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x04ca, 0x3022), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x10ab, 0x9608), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x04ca, 0x3023), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x10ab, 0x9609), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x04ca, 0x3024), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x10ab, 0x9f09), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x04ca, 0x3a22), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x04ca, 0x3022), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x04ca, 0x3a24), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x0489, 0xe0c7), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x04ca, 0x3a26), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x0489, 0xe0c9), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x04ca, 0x3a27), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x0489, 0xe0ca), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x0cf3, 0xe600), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x0489, 0xe0cb), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x10ab, 0x9108), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x0489, 0xe0ce), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x10ab, 0x9109), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x0489, 0xe0de), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x10ab, 0x9208), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x0489, 0xe0df), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x10ab, 0x9209), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x0489, 0xe0e1), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x10ab, 0x9308), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x0489, 0xe0ea), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x10ab, 0x9309), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x0489, 0xe0ec), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x10ab, 0x9408), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x04ca, 0x3023), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x10ab, 0x9409), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x04ca, 0x3024), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x10ab, 0x9508), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x04ca, 0x3a22), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x10ab, 0x9509), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x04ca, 0x3a24), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x10ab, 0x9608), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x04ca, 0x3a26), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x10ab, 0x9609), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x04ca, 0x3a27), .driver_info = BTUSB_QCA_WCN6855 |
+	{ USB_DEVICE(0x10ab, 0x9f09), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
 
 	/* QCA WCN785x chipset */

-- 
2.34.1

