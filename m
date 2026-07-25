Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7A384CD4
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969703; cv=none; b=fpeVGz7/rNscjxwLC0dDEv+65jkqleANnZDMc4fGFG/d3oxfjW+237I1BlNdbC1iWRW/DshEwf5tDRvIsfb5r2T3WZ17c3DFBSNExHUgZ+yFB5oWFLtA8lw1oMGeuZVm+Rrzga6vWkej818hdos+SJGL9f4a1fKdtA09FgHC2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969703; c=relaxed/simple;
	bh=T2gkb1q0LsvN9QrCBQ3tzgRr0MXwkHND9wA538J4JHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uHZF6qD5uofIqbDYOAG+0ntQs66K/uSQYfw6iwywodMtkfL0R9V10RlVFGdqvJC98RwtvY0t+we8muUOdXpbZTWFJC0cKTVxTmx9RKCYBp9QUZoSZYQAI0nas5HwZAaqhIStBianJQmPd3XEISnE/SiFIgYmoMpHVeS0KErLEWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XAsrps5z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ili6gPX3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XAsrps5z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ili6gPX3"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P4l7mc2103546
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lE9ktquNB1V6A5e4uQkned/c1aIWDrRI2+mNorznd+A=; b=XAsrps5zM2DMq7KH
	CIZVHliUXgKIgR7viVxpzRX+TdQWilQ0fQofd8NqO+4cMoQmkqqb6I/Q1ZCTuVTq
	qYi8R4Ql2nT0kZVn/juknFqC3JQ6rdO33IGda4iNvw+YWS5Zz8jqU4RksrrP6iMD
	tWzDo8tRY/FndNX6FZPOfkM3lX4rY8T1TF5upp2U8HuX6HVGhgSgt0BoJKOlWOlR
	ATy5Uw4vJD/oR9xsLrN4vgDMl//ssr66XqJE04hG0CxcukY/8MJu67pVBEswHasX
	bsSo9CZI5aTE0B9i8T94/leQ8p4mzXIv07gPK7Ms0rUFtE6coyuMj0/DrUTIefYm
	FkFEeg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmjufrucu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cae7a8b9easo2096995ad.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784969697; x=1785574497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lE9ktquNB1V6A5e4uQkned/c1aIWDrRI2+mNorznd+A=;
        b=ili6gPX3M8Mr0HLXD7GL2Xff3Pw8ah3RODTkPYGWfCVTPQs/Gcr1ZgoIOQXcpsFB9i
         oZs2IzRoRh+ftvQ51kSGWnhRohzv6PKZwxl7QpwnPVpaRMNT6scqtMWgfRhKSO8QF9Gf
         nPJXcUdt24gHy5cE0AqLDLJMDi2vzemUsZ4lVwYTkSyZ8hjTDPgRmO7huXi8KRnspDY4
         x9MANdhI/QGfOugkDWDr6IDSWlM/s4IYpFhMXqJtU3UXzSNz2nowjMcvwMpomSXoHljt
         dk14dkPYsr+lZftDNWN1HiM6aiuOJNmaUzD32J8vqCQCvEv3iRMOG7F1VwGTw0mtEMht
         5SZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969697; x=1785574497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lE9ktquNB1V6A5e4uQkned/c1aIWDrRI2+mNorznd+A=;
        b=KNbF9R1WBtGVRjDk44wU95r6Wh4MuoHW5XE3/ug+3PjzCYwJa5F3pHT1Z1HvidF8J1
         fRjX60myPyRXSf2nmzBMI2qyqNL2ahVIuwJECAZoUgw676pSZ3QyWyBMAXbw9rFt9t9w
         1sUh9IiWP5lPbrTE6ObGiJ3QOMUXkj/BdVByrclpIBIBYyOJMEKFpUHQz2vPz6wggLNl
         yRk/eoKllTm4i+xPo1M0Vw16auOPCUscYUdGsCQr7buzl8+pAhtsSfXQO53EiZXoM0Dg
         uHxWjP852tDoCCyAshRgC5ruKWPwGZ10sIWeKJ7yxuvJ+GpAszMKeZF0ik0ht+uIh6/H
         /wNg==
X-Forwarded-Encrypted: i=1; AHgh+Rpq8G1TFf1NMbD3POQ6fHb6+H3Cae9AOgmmCGe+NU/nl8jIPOgWxowT0GslRayvkmGJoddVEb0vXk+spXEDoLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXHhtt+UbdIlv0vixosMWv0mvbd+9Ct1YPop8GmppQwVkJ0mGP
	NN1ff6pVWDKjuGzN8d2GnXsv2aXGZHbkYJmPrmDsfqrZ+Dhy5tRYpPraXUBbDEH/fyxF29Naqss
	xD5tmzke9BVnVjQV+C5IqCV5trH/lPluTyJf+CByrZ0P+yZ0alw05j6DUazSXlvQcbrrsgEE=
X-Gm-Gg: AR+sD113YpJmlXlkfH47bA0de3UwKfAj8rHzGXzVEvJQoVwfMc75ad1rfW0i0usFy65
	DePWlMcB7FhiJrWgZCL4YZMHzhBLRdN4Dc/iP/ArOUvTO0yQcNIVjnmQ8X2wP8l/E/lBI1blP4S
	vATfoi1XLVIiaagSSRuLWXjdpUGoSWGJO3eGwWa0VAhhP8QFCKObD3AHN2SHNyzb283vhFgx3sB
	TY3I0f9r/L/k4aCeYPbalvDeaE8AEH1oNZcGVi8nrBU4jUjMfbZEkD/oK/A5XgsSvoCzb60U+rQ
	pvUgIDwWoIKCeZYDSyn/B1958z939gpY98/KNxwRXJBxU1a0TP3GgEM933H/g5xOGhbzpEYgXmR
	nRlzMJ0Mu0S9DJWL9NUbDK0yPSacDHcgaRmSwW4TujykpLow=
X-Received: by 2002:a17:903:944:b0:2ce:aea4:5e80 with SMTP id d9443c01a7336-2cfde8a53e0mr12053395ad.6.1784969697325;
        Sat, 25 Jul 2026 01:54:57 -0700 (PDT)
X-Received: by 2002:a17:903:944:b0:2ce:aea4:5e80 with SMTP id d9443c01a7336-2cfde8a53e0mr12053175ad.6.1784969696914;
        Sat, 25 Jul 2026 01:54:56 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm7823000eec.10.2026.07.25.01.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:54:56 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 25 Jul 2026 01:54:43 -0700
Subject: [PATCH 05/11] Bluetooth: btusb: Add a simple static
 btusb_prepare_reset()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-generic_fix-v1-5-305aec261a19@oss.qualcomm.com>
References: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com>
In-Reply-To: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Manish Mandlik <mmandlik@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: UyiE45LC00ANtrU0zx01QkHB0dnAKHXL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfX2aH++Ls5bn14
 ienzCYU8kS6A63pBwLz3pJwiD7uNkJM+VHSiNBO1PEHHdi8f/3buKfhmwMZn/7MXKThTunIarsc
 WWeByfF2aodq4AWrL4xNqQpI6ZvAMTs=
X-Proofpoint-GUID: UyiE45LC00ANtrU0zx01QkHB0dnAKHXL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfX+mXhwNxcxgPE
 tlFP7+b7lKOOkeuEUjLMoLsCMgFpMGrVMfPO7bJ52oPPvlY1Oevxab5MvgMAq4l1kWeJZi/A12k
 dIHpAqN9/ZkQUlHfXJJiPz4DqBVY4ck/cYjqwgOe9pgqFaYRJVo9AqrAaD/CulymZCBzsaC8G6Q
 G6J8WKsv72+/MxZsUWWM+y44cOV4zyVZrb1bdZWb+s+cUK+5jvv5eVU8jYuvzU9ByjAV9NpFcA2
 AaqiT9xNm177z+r9c3l3mmOy63/4W8rVKV1lCVYuOmS6QCIjam2yyD4gfA7FieOPyG4HPkE6pzL
 tGjkhU7el/h9UvAGJJHebpg34ZQx3+F/vnayoe7b+W4EKnBudSDBQPHpM8aY3g7DUrOw1EWvtX1
 35bHDgcYS7eqW6OkYwbCSagt4T+vjFWOuz0P+HVYt3ZyHzfwYN30h0r2R+5uSn6yXlx6WcaA8iJ
 4NxBUg8yuXDRQMOcDHA==
X-Authority-Analysis: v=2.4 cv=F5ZnsKhN c=1 sm=1 tr=0 ts=6a6479e1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6PToxbElcrdsU22FfsIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250083

Add btusb_prepare_reset() to do cleanup before a reset, and
apply it to btusb_mtk_reset() as well.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Previous version:
https://lore.kernel.org/all/20260713-btusb_prep_qcc2072-v2-5-bbcb651285f2@oss.qualcomm.com

Changes since previous version:
- Improve commit title and message.
---
 drivers/bluetooth/btusb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2ea1d6bbea39..90336dec59a2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2069,16 +2069,24 @@ static void btusb_stop_traffic(struct btusb_data *data)
 {
 	usb_kill_anchored_urbs(&data->intr_anchor);
 	usb_kill_anchored_urbs(&data->bulk_anchor);
 	usb_kill_anchored_urbs(&data->isoc_anchor);
 	usb_kill_anchored_urbs(&data->diag_anchor);
 	usb_kill_anchored_urbs(&data->ctrl_anchor);
 }
 
+static void btusb_prepare_reset(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	btusb_stop_traffic(data);
+	usb_kill_anchored_urbs(&data->tx_anchor);
+}
+
 static int btusb_close(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	int err;
 
 	BT_DBG("%s", hdev->name);
 
 	cancel_delayed_work(&data->rx_work);
@@ -2913,18 +2921,17 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 
 	err = usb_autopm_get_interface(data->intf);
 	if (err < 0)
 		return err;
 
 	/* Release MediaTek ISO data interface */
 	btusb_mtk_release_iso_intf(hdev);
 
-	btusb_stop_traffic(data);
-	usb_kill_anchored_urbs(&data->tx_anchor);
+	btusb_prepare_reset(hdev);
 
 	/* Toggle the hard reset line. The MediaTek device is going to
 	 * yank itself off the USB and then replug. The cleanup is handled
 	 * correctly on the way out (standard USB disconnect), and the new
 	 * device is detected cleanly and bound to the driver again like
 	 * it should be.
 	 */
 	if (data->reset_gpio) {

-- 
2.34.1

