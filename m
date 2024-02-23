Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71571286A6
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678393; cv=none; b=TvmXoWgaKiohfpCqa2gRAcjGI5xPhrTLfLhgfMnCevqvwUFhudI5pe0dki5zHPjhF8djaYSIrJGu7I945sotcvU/eV69+1t2KZFd8IZLKyE9IX3ur3KFqVotB7OvP1KRgOmRK98c+WV0C1914aWErVo5ZWUqe4IqLyTnArSbDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678393; c=relaxed/simple;
	bh=XSz0jKNH1n8eCBx82g0+ys+wamiiwRqJhcoAIM5tyhQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AN7eCXP/td4Aly4Gg64jkMaRBq5mI8t4RyIC14klWA7fGOIEng9T9dyoOMoMkvMweLRsTGQF0EiOi+9sdGtCYSzSl8q7KDXpSKs406AwyEPn8aH3+JdGBfCsOPDsEVo+9KH+VE1GdE3QDlHmJleAg2Aige5FTy8B/i/1AIbX8nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PifSMHst; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PifSMHst"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N6vRhI021242;
	Fri, 23 Feb 2024 08:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=Rj1UnjwW5MY1y+1XNzdWS7I7b/rCvuHtA2QHcA5h7V4=; b=Pi
	fSMHstYnKlbIbx1kG0g0QDWgXc+MgKYZJ3M+G2ok8pTrrEzkNkdpC2V5CHAsDtW1
	I/dH0KEtoK30pEQ13dXPbm1EXfOfl9eCAT4lLVw2KJ6JJojzNwDfy21bT/r3yrZF
	uaLQN2DKkOSxsiAD/3D7og+QVphGsinD8+f5Faz4E2GR0kPwieQZORPyrJX7/QDk
	byXvlHsEB2OmW+pKqrFjGQ2DTFYOrfvyRLOOLSTR9Wr+ad64eCETkGspLMMe0dCR
	4yx62LWAjau53Bh+P/6OuoJHsBDpzjbhLZf6C8hX3Eo4/ZMtTzo/BwzZaSeEZiB7
	to+u8wGqL9jRA2vG6PNg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weg88ryk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 08:53:07 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41N8r6nQ023436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 08:53:06 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 00:53:04 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH] Bluetooth: btusb: Correct timeout macro argument used to receive control message
Date: Fri, 23 Feb 2024 16:53:01 +0800
Message-ID: <1708678381-29622-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KjptUf8xzf_QzZab7cyr66BxS9Mq0d_Z
X-Proofpoint-GUID: KjptUf8xzf_QzZab7cyr66BxS9Mq0d_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230062

USB driver defines macro @USB_CTRL_SET_TIMEOUT for sending control message
timeout and @USB_CTRL_GET_TIMEOUT for receiving, but usb_control_msg()
uses wrong macro @USB_CTRL_SET_TIMEOUT as argument to receive control
message, fixed by using @USB_CTRL_GET_TIMEOUT to receive message.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/btusb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index edfb49bbaa28..07935751e4c7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2949,7 +2949,7 @@ static int btusb_mtk_uhw_reg_read(struct btusb_data *data, u32 reg, u32 *val)
 	err = usb_control_msg(data->udev, pipe, 0x01,
 			      0xDE,
 			      reg >> 16, reg & 0xffff,
-			      buf, 4, USB_CTRL_SET_TIMEOUT);
+			      buf, 4, USB_CTRL_GET_TIMEOUT);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to read uhw reg(%d)", err);
 		goto err_free_buf;
@@ -2977,7 +2977,7 @@ static int btusb_mtk_reg_read(struct btusb_data *data, u32 reg, u32 *val)
 	err = usb_control_msg(data->udev, pipe, 0x63,
 			      USB_TYPE_VENDOR | USB_DIR_IN,
 			      reg >> 16, reg & 0xffff,
-			      buf, size, USB_CTRL_SET_TIMEOUT);
+			      buf, size, USB_CTRL_GET_TIMEOUT);
 	if (err < 0)
 		goto err_free_buf;
 
@@ -3681,7 +3681,7 @@ static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
 	 */
 	pipe = usb_rcvctrlpipe(udev, 0);
 	err = usb_control_msg(udev, pipe, request, USB_TYPE_VENDOR | USB_DIR_IN,
-			      0, 0, buf, size, USB_CTRL_SET_TIMEOUT);
+			      0, 0, buf, size, USB_CTRL_GET_TIMEOUT);
 	if (err < 0) {
 		dev_err(&udev->dev, "Failed to access otp area (%d)", err);
 		goto done;
-- 
2.7.4

