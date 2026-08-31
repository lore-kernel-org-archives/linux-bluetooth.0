Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32543164D8
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788152651; cv=none; b=sQDFgJIjfHuD8p+kiicC27lAYPk2o+bOZPUSvSisDEV6bleyeurOXu6445P8KWRKQBhufxagqDv9DitTKKLsHmNFAESnEs51QreBgI2Kr/0Ocyc767Hok64pYpAgnqIMH80I8foy8jnE/si+DPJnug9WygCV3rO+cV330trEyGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788152651; c=relaxed/simple;
	bh=hk5q5yfj+3CPDigdHZN7M00PoR/wM3UngY2XD3eFsMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ac3in6Ww2AtkioLTBQtIn+1GPPrCbewPD18gwVIzo6/F6JtpbNvaN1ZpXI98Ayk1fbH6sIGaHYBexpALSGcz4XwGMFPeR/rd+9v95cz2zYvhSOKRd+J0e2Ba3QLKJjz+rAxXseIEBgkYUQ3EpzLT2CFK4q0LGJDNHxuK1FSCHIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mJ80pIuf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YNkBKudD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mJ80pIuf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YNkBKudD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52xQ52018332
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EevgHx2iszFuWOerb/OAKLPO/Caest+ArOwuaL8Y/vI=; b=mJ80pIuf3EneOkN9
	0XSPWzxQ8ffC3mgzXLufVkdLo35MenwgSPX/md97jc/pKOCVYTnH/ClCZaUHKdKZ
	yCVlAaGXROmiYIIqlnBieUcRzV+Uw5zYnxW3e/wpnr0MhRgWluEl44oFb2AmXKrK
	DNo3fkO7w8tXXm0pyj3x+iYsQnLNDVXaKTcQ0MU/46iutYWz1wlYYnR55ejylJRA
	Q+1kLRpYOHEwuaJTtq1UbQbKcnGX4Pt1GxmEcw3lNpnNnKDi//w1xKvsO04jIbaO
	YcjGT/V5XlSMLzHjKJS0oQhHheKezR3Orx89Mq/4aELtT6IoaZNy6rzABe8Ot+qa
	rsxfkQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqt6mjdb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:04:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1de1af19dso49998a12.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 22:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788152648; x=1788757448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EevgHx2iszFuWOerb/OAKLPO/Caest+ArOwuaL8Y/vI=;
        b=YNkBKudDQFUdCVb2O9G+HBhlkH7jzEoJ/mJAZiBRApLE86uyl9hrrpUhsVbE0ouQPc
         70ZOPPuNMrQ2P5Rxt1dj6YbXvlwDc7hPsQcH37VhEyq+EmT4LuMT8bXvA9aSK8PLwWl4
         RiJucfPyipodpIsct38QBfW+GgjmVnBkwhEbJPljdOGfSuhjpXAO8Pyl2zcQ5hSK/dqM
         63BAk8avEEDDFFY7u2bbI5JFYe5koWf01o3eW3H03x1TpuLrMNsAHenNt57oCnpak5TU
         zWvpaqRyRabrbwWoUi0BXDiE4jltlodzi9ImAZpjsAq92STsnUi498vI2kOX8TJsE5Dm
         2DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788152648; x=1788757448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EevgHx2iszFuWOerb/OAKLPO/Caest+ArOwuaL8Y/vI=;
        b=Zn4jdcSUQHpXcZGmRguupt9Zo+zQT6UTCzBFm0+Pb7GgMhDJ7rcQFmOTPXirlRfDTp
         rJ5XuxkS9i1V0+qM4oGo/3H7lAZ/bfrAlILTVXpqsSgBdWcAoQSmDm+Ur8bB1Yb1HxUE
         22M/Gu2R5JwRWuYJSKJ1z8gyRQFABKWhIDBdYR2ofWVOjXI45rr3EeR2lkuMOdnFWtcc
         8XXT1YuPdt+lgsu9Y0kmAT9yaXATb4t7eFyFDvb7vlIUr5zvTDFodWzZTvkHHcTCMjPh
         9FchoMy8cZJkUMM3G3vRrb9Z+xplOPS1+dc32mIW5tjgQJAomF7ef6rPKLXryPpzXSay
         N+pA==
X-Forwarded-Encrypted: i=1; AKwUvBx4ug7qirdpbzqcX54MNF05RtLNBE/koc9rbdpEL0Xqyl12Hq3Wd3Cy1l6cZbVaezelio4Bvp5T8a6egeSSZpY=@vger.kernel.org
X-Gm-Message-State: AFuF++nlqYsllZqB1d1etY7ItB2Z3N9apms2f2M0Oy3Apd/hDw2493aM
	vVdEyzCOp5f16pCbfJMYsBj9wVZEUveTMx6K42iNWWBnENQPmw+NFxgs6e1ftJg639vdU7dhfaK
	7nhOf++u16r2fBOBJkmBJ2ylhA6FkuMUJMYnV1eCLh8lgBH6RAn7EX4aMqOfdVNx5ZwtCBg4=
X-Gm-Gg: AYBFou1L+q+4RoEU4o3E4ii3krWPpLIT/jyWor+IbZS3s4Maiq0Xifz1qshgFIVT/xn
	nI23hbHQgemsLs4wQRZjzra6Awo6yuK/JPuzbFagJKnN2v+APHLesyfKPkMIKszS5K9gv5HxQXi
	y5NvugMPG+6sa7KES4liELgZs6kKcxkJjYDUMdWpHM4rH2sbFi+RjXySM+xlK6yDG2KXG/Gi7op
	iRkTUpa5pAFBF+h0JtLaL+LCWQ/lzd7WhYT5km0xS2z8LWSgocWSpod9wIYqb7P0j3MN2SiP9DW
	IkfLhUGk27SvpX7BbBdoXLWcIWGHtWr0xBZdqHE4FIrOD+L8PTyjuk7jtIUHpL5w7XkHfi+9F28
	TNg4zYbhSR1+3MfJX/Wykxj5j8XT2CytOdP2JYOdg6dkf4mU=
X-Received: by 2002:a17:90b:558e:b0:390:3936:8760 with SMTP id 98e67ed59e1d1-398ba71d770mr9616281a91.0.1788152647741;
        Sun, 30 Aug 2026 22:04:07 -0700 (PDT)
X-Received: by 2002:a17:90b:558e:b0:390:3936:8760 with SMTP id 98e67ed59e1d1-398ba71d770mr9616240a91.0.1788152647281;
        Sun, 30 Aug 2026 22:04:07 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0df264csm43017912c88.14.2026.08.30.22.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:04:06 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 30 Aug 2026 22:03:50 -0700
Subject: [PATCH v2 1/4] Bluetooth: btusb: Add recv_intr() hook to
 btusb_data
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-btusb_qcc2072-v2-1-5c0e0c9dd98b@oss.qualcomm.com>
References: <20260830-btusb_qcc2072-v2-0-5c0e0c9dd98b@oss.qualcomm.com>
In-Reply-To: <20260830-btusb_qcc2072-v2-0-5c0e0c9dd98b@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: Og0H6V8FA2AON32Ro6nXlL_jhyECpQ_F
X-Proofpoint-GUID: Og0H6V8FA2AON32Ro6nXlL_jhyECpQ_F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0MSBTYWx0ZWRfX7n+RGXfS274i
 3k356knxQW46muPjEfQDVzoBmGhgSztiCjJV4Jv81uyWvBxTMl8+07j90/de4UaIaspRxeohYzj
 tHyDeOCfg8NUhytHT8u0mwBLYVcmKa9NxxLt81vPlRY6zWSw78vA3vJd4x57oG85sWk5Dxk5p+G
 hoTYXkgt6MxD7moiiBtdbbq6t9b0I4Wyjhhjkika2fHowGEBwc6SHKJkamf4hPhmnHus/fwMiY9
 zSBhXTxd2wfvVjm3Y0RzkhH6V1+05wbQOpAKBSkFBEtgNKkvDrkOO2zpOqILrZiTm70rdK2gpce
 Z9VhxwgWI74rAu4hpAoMElvfTqBLm07+IQkPX1MqnzAuC4LmYZhei54yAhHS6LZxTuzhCSsYacq
 kyGKmPDrsZs5FZmpCD9sUi9pXYUGyIBjBoQDQoQMRJU+gLDQxMXv5JQ/6GA7rzXszSnJAuR3LbU
 1wGuWcwzduX6iYauHUw==
X-Authority-Analysis: v=2.4 cv=S8/pBosP c=1 sm=1 tr=0 ts=6a950b48 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=z8uIRxzjlBKXrQItdqYA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0MSBTYWx0ZWRfX1FbZjlux9cum
 /+NpSYZfOERJT+8P6OveO6Qc1UTCbGnrZufJh7p+jdS/sqSZLoILMduOd/3T657sKgE6TRsGg6F
 XVX90jRjs+fI7bAvY5vTeLg2B6rGD1s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310041

To allow a vendor driver to assemble and handle its non-BT frames
from the interrupt endpoint.

Used by Qualcomm QCC2072 support.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Previous version:
https://lore.kernel.org/all/20260713-btusb_prep_qcc2072-v2-3-bbcb651285f2@oss.qualcomm.com

Changes since previous version:
- Improve the commit title and message
---
 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 84614e60d142..79dc6b15c5f5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1034,16 +1034,17 @@ struct btusb_data {
 	unsigned int air_mode;
 	bool usb_alt6_packet_flow;
 	int isoc_altsetting;
 	int suspend_count;
 	const struct usb_device_id *match_id;
 
 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*recv_intr)(struct btusb_data *data, void *buffer, int count);
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
 
 	int (*setup_on_usb)(struct hci_dev *hdev);
 
 	int (*suspend)(struct hci_dev *hdev);
 	int (*resume)(struct hci_dev *hdev);
 	int (*disconnect)(struct hci_dev *hdev);
 
@@ -1508,17 +1509,17 @@ static void btusb_intr_complete(struct urb *urb)
 	       urb->actual_length);
 
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return;
 
 	if (urb->status == 0) {
 		hdev->stat.byte_rx += urb->actual_length;
 
-		if (btusb_recv_intr(data, urb->transfer_buffer,
+		if (data->recv_intr(data, urb->transfer_buffer,
 				    urb->actual_length) < 0) {
 			bt_dev_err(hdev, "corrupted event packet");
 			hdev->stat.err_rx++;
 		}
 	} else if (urb->status == -ENOENT) {
 		/* Avoid suspend failed when usb_kill_urb */
 		return;
 	}
@@ -2723,17 +2724,17 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 {
 	struct hci_dev *hdev = data->hdev;
 
 	/* When the device is in bootloader mode, then it can send
 	 * events via the bulk endpoint. These events are treated the
 	 * same way as the ones received from the interrupt endpoint.
 	 */
 	if (btintel_test_flag(hdev, INTEL_BOOTLOADER))
-		return btusb_recv_intr(data, buffer, count);
+		return data->recv_intr(data, buffer, count);
 
 	return btusb_recv_bulk(data, buffer, count);
 }
 
 static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct urb *urb;
 
@@ -4175,16 +4176,17 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->intr_anchor);
 	init_usb_anchor(&data->bulk_anchor);
 	init_usb_anchor(&data->isoc_anchor);
 	init_usb_anchor(&data->diag_anchor);
 	init_usb_anchor(&data->ctrl_anchor);
 	spin_lock_init(&data->rxlock);
 
 	data->recv_event = hci_recv_frame;
+	data->recv_intr = btusb_recv_intr;
 	data->recv_bulk = btusb_recv_bulk;
 
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
 		/* Allocate extra space for Intel device */
 		priv_size += sizeof(struct btintel_data);
 
 		/* Override the rx handlers */
 		data->recv_event = btintel_recv_event;

-- 
2.34.1

