Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBD91E49F
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797842; cv=none; b=o7OQg3O+M+rtAUoEM4IXcI2GrZN8/NX90wB9y/d6IUOyVPldjc3wy6+igaAha17lXYr8GlUiQSw/LK+cDQ0cDq/p7/hFvYHS2qYHZhsKgYctAnhkPTh69aDCLQQRKV+xxVZBKk5BWjfKSg9iXpLWDUGZYEkzpEH48C/KYxpfVQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797842; c=relaxed/simple;
	bh=2IcCtKJCDri9KwfFWHuwSRy4cd7UnDeGvsfeuKaYjVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1E3CBvxiK9qX1BwMnLMTJD0P7jF8r3ow8Q8Y/Flw/siFTxEGVqdcNQQvIMXxiLYhRFKv1Dbc6aVPqFQsxCwsfTDl1Rt1onh0MIKW8dHFWcpVIYNED5eV3iHkxqMURnAA5ZhogvpWD8ko2iKfRvQqrXirX2OMSjzrI8BZ1vS4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N3KPYi8v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N3KPYi8v"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M25eJb027623;
	Mon, 22 Apr 2024 14:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=Z6QOjYQ8QKuKUYzDXlyL
	28BvcsfUr5HKH+6RBl6WzoQ=; b=N3KPYi8v9F9JHHjbiLkTsyOpy0RH8bdtWvDP
	fEHKWPXU38UQWup8OOcEuQBJ8KUUuDSKWpbUHjZQ7fOZWU4gmzBnw4KPvi6T/dp0
	IzTGULdYorjxVm56mC9CTEa6yZ6eJYtwRhVJUhR8TM72VY4sdKSRzmMnFob4lFMa
	rHG42l+JnPsaCKuS+9YyUF0H0yMdV2mkDC7xFEvJ41mbu4OBkHnJBJSMjxSjecR8
	nX7Z4XfMT4v7ZCCPhiJyVKJf3bFQ6TO0Qe0HHYyfV27imBrjFt99qYzeul4gL+IC
	PEzrEnHXwoeud1mjVFG6cT4Tl2rkVoAhxIyURNFHrIheQIzoIw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnet79m4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 14:57:16 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MEvFSx028682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 14:57:15 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 07:57:13 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v1 RESEND] Bluetooth: btusb: Correct timeout macro argument used to receive control message
Date: Mon, 22 Apr 2024 22:57:10 +0800
Message-ID: <1713797830-24600-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1708678381-29622-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1708678381-29622-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: Q42chH-AQBXPvDTny7FcpOA-hFsz9BX5
X-Proofpoint-ORIG-GUID: Q42chH-AQBXPvDTny7FcpOA-hFsz9BX5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220064

USB driver defines macro @USB_CTRL_SET_TIMEOUT for sending control message
timeout and @USB_CTRL_GET_TIMEOUT for receiving, but usb_control_msg()
uses wrong macro @USB_CTRL_SET_TIMEOUT as argument to receive control
message, fixed by using @USB_CTRL_GET_TIMEOUT to receive message.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/btusb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8bede0a33566..5e9f7b65abbc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2956,7 +2956,7 @@ static int btusb_mtk_uhw_reg_read(struct btusb_data *data, u32 reg, u32 *val)
 	err = usb_control_msg(data->udev, pipe, 0x01,
 			      0xDE,
 			      reg >> 16, reg & 0xffff,
-			      buf, 4, USB_CTRL_SET_TIMEOUT);
+			      buf, 4, USB_CTRL_GET_TIMEOUT);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to read uhw reg(%d)", err);
 		goto err_free_buf;
@@ -2984,7 +2984,7 @@ static int btusb_mtk_reg_read(struct btusb_data *data, u32 reg, u32 *val)
 	err = usb_control_msg(data->udev, pipe, 0x63,
 			      USB_TYPE_VENDOR | USB_DIR_IN,
 			      reg >> 16, reg & 0xffff,
-			      buf, size, USB_CTRL_SET_TIMEOUT);
+			      buf, size, USB_CTRL_GET_TIMEOUT);
 	if (err < 0)
 		goto err_free_buf;
 
@@ -3699,7 +3699,7 @@ static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
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

