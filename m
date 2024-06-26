Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F24D11B;
	Wed, 26 Jun 2024 02:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719370442; cv=none; b=XhhOFYR3ONfOUECM2O38kztf3Runs0EOb83q0dKhQbih5qDZyMbYWdw6f/4iY+4cimH1t5Lx62X2L/gaQVfZzYuODZiqV+3GPydDuqpZVpSfrFT5nvYOpOAnYUp5mPDBHCsQ7P+n2/fz5WZjYq5hYv1nBQ9BDcix41FuVOxofSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719370442; c=relaxed/simple;
	bh=evwwLG2vP9eTernjT7C4E1iveked16qoj1YWnSnRCgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2yZVR9ThQ0HUvVJimk3ZcaxlJh/u/DPxJQcCGnC5lkEk3waUOxC//WDE53vqAhT2FQ5jrMs4EL+xVx4CvdS+5rgo26Mw+he/hc2568mv542yt9bQwoAPxm2EYhDohFPOqOOHhLn8c5A1VkxGctsH1xWyiCVFYUE9hiSclIW740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=S0rzMRDQ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="S0rzMRDQ"
X-UUID: 534a9096336711ef8da6557f11777fc4-20240626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PlrzJp+cDS2cLlS3mIxrmFt8502yABtWxjy1VZJf7fY=;
	b=S0rzMRDQtf5hvKJz12nA4zFk2jBliZchdx9X/MNeH2nrCQI1ORG90UvBvVBZHgJOhLhJe+2W/EQnLGhH7iU5M59lRjFUXkJEMJfcLVWRVgUvwzgmp0psaDxBNjols75lIp4W1NNbaiVSM6Go2h4EelrkRRpsr6sJeWAzwMgSivY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:41cee597-f106-480c-9208-8ece1d2f71a7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:38b18985-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 534a9096336711ef8da6557f11777fc4-20240626
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1278562250; Wed, 26 Jun 2024 10:53:54 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jun 2024 10:53:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jun 2024 10:53:52 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v5 8/8] Bluetooth: btusb: mediatek: add ISO data transmission functions
Date: Wed, 26 Jun 2024 10:53:29 +0800
Message-ID: <20240626025329.26424-9-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240626025329.26424-1-chris.lu@mediatek.com>
References: <20240626025329.26424-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.718600-8.000000
X-TMASE-MatchedRID: LMzYNsnd4lDAtVbQuS2v5WwjJ4TFeU1uu2rcU2ygxCBZps+y1VXzqcHt
	HEmxq9+YOj0+fVFxstCxk+gL2IBXj83AmdtMjGJVA9lly13c/gHNXgP7liZ5IhS11FlOYRohdW0
	3UdhBXLv3oQGhei/chytSlUVgK4eKvH9OmaDmUGO3D7EeeyZCM+3+iQEtoSj4qU5NA9X5mfGrdy
	22UOhsDIl6yNMAqJNt8Yy1e/Sx7zdPXYdz0WFWNYDTBcxjSxJQKFFZAe4nyZ52jD/JuqpOknRL+
	tsX9l0a1oLo4HOOidttZ6Ypmt3T5fVzvr+7W3SQKNfRqDeFqBh+iqFlMGARDxBVEcLcHoVgir86
	7mveGGxq6HpHXhkoxfvCJ/6gUJzY6biOAxfBSkaM6MEoNtf0ZaRagyMV8rdehZnXayFLN+Ki6Ei
	xPwQMWbQKLhvag+W1ajeIoEvnxOagWp4YlsKPVbdQIb8hCnY+U+A7YkpDJ1i8NrbzjPvzJ0vBUY
	aaBg9+b88byMZrSKdZunmaUH8mENOYsB74R7ecbT3mGmWPpNdWOQQSa4vbHZsoi2XrUn/Jn6KdM
	rRsL14qtq5d3cxkNTcfT1oanpR8UIbZQmzshpySPk/Tv7oRprr+WKKBNTYSEW1OA7BWL5vAvpLE
	+mvX8g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.718600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C87D164FD94C51BC9DD1AD18D5539BE5DAA7A77E40F7AC23AFDC8D0D7567DDFB2000:8

This patch implements functions for ISO data send and receive in btusb
driver for MediaTek's controller.

MediaTek defines a specific interrupt endpoint for ISO data transmissin
because the characteristics of interrupt endpoint are similar to the
application of ISO data which can support guaranteed transmissin
bandwidth, enough maximum data length and error checking mechanism.

Driver sets up ISO interface and endpoints in btusb_mtk_setup and clears
the setup in btusb_mtk_shutdown. These flow can't move to btmtk.c due to
btusb_driver is only defined in btusb.c when claiming/relaesing interface.
ISO packet anchor stops when driver suspending and resubmit interrupt urb
for ISO data when driver resuming.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 303 ++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmtk.h |  36 +++++
 drivers/bluetooth/btusb.c |  68 +++++++++
 3 files changed, 407 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 57a14668a42b..b349dfce2dcf 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -21,6 +21,9 @@
 #define MTK_SEC_MAP_COMMON_SIZE	12
 #define MTK_SEC_MAP_NEED_SEND_SIZE	52
 
+/* It is for mt79xx iso data transmission setting */
+#define MTK_ISO_THRESHOLD	264
+
 struct btmtk_patch_header {
 	u8 datetime[16];
 	u8 platform[4];
@@ -962,6 +965,300 @@ int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(btmtk_usb_recv_acl);
 
+static int btmtk_isopkt_pad(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	if (skb->len > MTK_ISO_THRESHOLD)
+		return -EINVAL;
+
+	if (skb_pad(skb, MTK_ISO_THRESHOLD - skb->len))
+		return -ENOMEM;
+
+	__skb_put(skb, MTK_ISO_THRESHOLD - skb->len);
+
+	return 0;
+}
+
+static int __set_mtk_intr_interface(struct hci_dev *hdev)
+{
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+	struct usb_interface *intf = btmtk_data->isopkt_intf;
+	int i, err;
+
+	if (!btmtk_data->isopkt_intf)
+		return -ENODEV;
+
+	err = usb_set_interface(btmtk_data->udev, MTK_ISO_IFNUM, 1);
+	if (err < 0) {
+		bt_dev_err(hdev, "setting interface failed (%d)", -err);
+		return err;
+	}
+
+	btmtk_data->isopkt_tx_ep = NULL;
+	btmtk_data->isopkt_rx_ep = NULL;
+
+	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
+		struct usb_endpoint_descriptor *ep_desc;
+
+		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
+
+		if (!btmtk_data->isopkt_tx_ep &&
+		    usb_endpoint_is_int_out(ep_desc)) {
+			btmtk_data->isopkt_tx_ep = ep_desc;
+			continue;
+		}
+
+		if (!btmtk_data->isopkt_rx_ep &&
+		    usb_endpoint_is_int_in(ep_desc)) {
+			btmtk_data->isopkt_rx_ep = ep_desc;
+			continue;
+		}
+	}
+
+	if (!btmtk_data->isopkt_tx_ep ||
+	    !btmtk_data->isopkt_rx_ep) {
+		bt_dev_err(hdev, "invalid interrupt descriptors");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_buff *skb,
+			       usb_complete_t tx_complete)
+{
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+	struct urb *urb;
+	unsigned int pipe;
+
+	if (!btmtk_data->isopkt_tx_ep)
+		return ERR_PTR(-ENODEV);
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return ERR_PTR(-ENOMEM);
+
+	if (btmtk_isopkt_pad(hdev, skb))
+		return ERR_PTR(-EINVAL);
+
+	pipe = usb_sndintpipe(btmtk_data->udev,
+			      btmtk_data->isopkt_tx_ep->bEndpointAddress);
+
+	usb_fill_int_urb(urb, btmtk_data->udev, pipe,
+			 skb->data, skb->len, tx_complete,
+			 skb, btmtk_data->isopkt_tx_ep->bInterval);
+
+	skb->dev = (void *)hdev;
+
+	return urb;
+}
+EXPORT_SYMBOL_GPL(alloc_mtk_intr_urb);
+
+static int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count)
+{
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+	struct sk_buff *skb;
+	unsigned long flags;
+	int err = 0;
+
+	spin_lock_irqsave(&btmtk_data->isorxlock, flags);
+	skb = btmtk_data->isopkt_skb;
+
+	while (count) {
+		int len;
+
+		if (!skb) {
+			skb = bt_skb_alloc(HCI_MAX_ISO_SIZE, GFP_ATOMIC);
+			if (!skb) {
+				err = -ENOMEM;
+				break;
+			}
+
+			hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
+			hci_skb_expect(skb) = HCI_ISO_HDR_SIZE;
+		}
+
+		len = min_t(uint, hci_skb_expect(skb), count);
+		skb_put_data(skb, buffer, len);
+
+		count -= len;
+		buffer += len;
+		hci_skb_expect(skb) -= len;
+
+		if (skb->len == HCI_ISO_HDR_SIZE) {
+			__le16 dlen = ((struct hci_iso_hdr *)skb->data)->dlen;
+
+			/* Complete ISO header */
+			hci_skb_expect(skb) = __le16_to_cpu(dlen);
+
+			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
+				kfree_skb(skb);
+				skb = NULL;
+
+				err = -EILSEQ;
+				break;
+			}
+		}
+
+		if (!hci_skb_expect(skb)) {
+			/* Complete frame */
+			hci_recv_frame(hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	btmtk_data->isopkt_skb = skb;
+	spin_unlock_irqrestore(&btmtk_data->isorxlock, flags);
+
+	return err;
+}
+
+static void btmtk_intr_complete(struct urb *urb)
+{
+	struct hci_dev *hdev = urb->context;
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+	int err;
+
+	BT_DBG("%s urb %p status %d count %d", hdev->name, urb, urb->status,
+	       urb->actual_length);
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return;
+
+	if (hdev->suspended)
+		return;
+
+	if (urb->status == 0) {
+		hdev->stat.byte_rx += urb->actual_length;
+
+		if (btmtk_recv_isopkt(hdev, urb->transfer_buffer,
+				      urb->actual_length) < 0) {
+			bt_dev_err(hdev, "corrupted iso packet");
+			hdev->stat.err_rx++;
+		}
+	} else if (urb->status == -ENOENT) {
+		/* Avoid suspend failed when usb_kill_urb */
+		return;
+	}
+
+	usb_mark_last_busy(btmtk_data->udev);
+	usb_anchor_urb(urb, &btmtk_data->isopkt_anchor);
+
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err < 0) {
+		/* -EPERM: urb is being killed;
+		 * -ENODEV: device got disconnected
+		 */
+		if (err != -EPERM && err != -ENODEV)
+			bt_dev_err(hdev, "urb %p failed to resubmit (%d)",
+				   urb, -err);
+		if (err != -EPERM)
+			hci_cmd_sync_cancel(hdev, -err);
+		usb_unanchor_urb(urb);
+	}
+}
+
+static int btmtk_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
+{
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+	unsigned char *buf;
+	unsigned int pipe;
+	struct urb *urb;
+	int err, size;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!btmtk_data->isopkt_rx_ep)
+		return -ENODEV;
+
+	urb = usb_alloc_urb(0, mem_flags);
+	if (!urb)
+		return -ENOMEM;
+	size = le16_to_cpu(btmtk_data->isopkt_rx_ep->wMaxPacketSize);
+
+	buf = kmalloc(size, mem_flags);
+	if (!buf) {
+		usb_free_urb(urb);
+		return -ENOMEM;
+	}
+
+	pipe = usb_rcvintpipe(btmtk_data->udev,
+			      btmtk_data->isopkt_rx_ep->bEndpointAddress);
+
+	usb_fill_int_urb(urb, btmtk_data->udev, pipe, buf, size,
+			 btmtk_intr_complete, hdev,
+			 btmtk_data->isopkt_rx_ep->bInterval);
+
+	urb->transfer_flags |= URB_FREE_BUFFER;
+
+	usb_mark_last_busy(btmtk_data->udev);
+	usb_anchor_urb(urb, &btmtk_data->isopkt_anchor);
+
+	err = usb_submit_urb(urb, mem_flags);
+	if (err < 0) {
+		if (err != -EPERM && err != -ENODEV)
+			bt_dev_err(hdev, "urb %p submission failed (%d)",
+				   urb, -err);
+		usb_unanchor_urb(urb);
+	}
+
+	usb_free_urb(urb);
+
+	return err;
+}
+
+static int btmtk_usb_isointf_init(struct hci_dev *hdev)
+{
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+	u8 iso_param[2] = { 0x08, 0x01 };
+	struct sk_buff *skb;
+	int err;
+
+	init_usb_anchor(&btmtk_data->isopkt_anchor);
+	spin_lock_init(&btmtk_data->isorxlock);
+
+	__set_mtk_intr_interface(hdev);
+
+	err = btmtk_submit_intr_urb(hdev, GFP_KERNEL);
+	if (err < 0) {
+		btmtk_usb_isopkt_stop(hdev);
+		bt_dev_err(hdev, "ISO intf not support (%d)", err);
+		return err;
+	}
+
+	skb = __hci_cmd_sync(hdev, 0xfd98, sizeof(iso_param), iso_param,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Failed to apply iso setting (%ld)", PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
+int btmtk_usb_isopkt_start(struct hci_dev *hdev)
+{
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+
+	if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags)) {
+		if (btmtk_submit_intr_urb(hdev, GFP_NOIO) < 0)
+			clear_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btmtk_usb_isopkt_start);
+
+int btmtk_usb_isopkt_stop(struct hci_dev *hdev)
+{
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+
+	usb_kill_anchored_urbs(&btmtk_data->isopkt_anchor);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btmtk_usb_isopkt_stop);
+
 int btmtk_usb_setup(struct hci_dev *hdev)
 {
 	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
@@ -1063,6 +1360,12 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		hci_set_msft_opcode(hdev, 0xFD30);
 		hci_set_aosp_capable(hdev);
 
+		/* Set up ISO interface after protocol enabled */
+		if (test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags)) {
+			if (!btmtk_usb_isointf_init(hdev))
+				set_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags);
+		}
+
 		goto done;
 	default:
 		bt_dev_err(hdev, "Unsupported hardware variant (%08x)",
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index b12629e2d67f..25a898219469 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -42,6 +42,9 @@
 #define MTK_BT_RESET_REG_CONNV3	0x70028610
 #define MTK_BT_READ_DEV_ID	0x70010200
 
+/* MediaTek ISO Interface */
+#define MTK_ISO_IFNUM		2
+
 enum {
 	BTMTK_WMT_PATCH_DWNLD = 0x1,
 	BTMTK_WMT_TEST = 0x2,
@@ -144,6 +147,8 @@ enum {
 	BTMTK_TX_WAIT_VND_EVT,
 	BTMTK_FIRMWARE_LOADED,
 	BTMTK_HW_RESET_ACTIVE,
+	BTMTK_ISOPKT_OVER_INTR,
+	BTMTK_ISOPKT_RUNNING,
 };
 
 typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
@@ -166,6 +171,14 @@ struct btmtk_data {
 	struct usb_interface *intf;
 	struct usb_anchor *ctrl_anchor;
 	struct sk_buff *evt_skb;
+	struct usb_endpoint_descriptor *isopkt_tx_ep;
+	struct usb_endpoint_descriptor *isopkt_rx_ep;
+	struct usb_interface *isopkt_intf;
+	struct usb_anchor isopkt_anchor;
+	struct sk_buff *isopkt_skb;
+
+	/* spinlock for ISO data transmission */
+	spinlock_t isorxlock;
 };
 
 typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
@@ -195,6 +208,13 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id);
 
 int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb);
 
+struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_buff *skb,
+			       usb_complete_t tx_complete);
+
+int btmtk_usb_isopkt_start(struct hci_dev *hdev);
+
+int btmtk_usb_isopkt_stop(struct hci_dev *hdev);
+
 int btmtk_usb_setup(struct hci_dev *hdev);
 
 int btmtk_usb_shutdown(struct hci_dev *hdev);
@@ -248,6 +268,22 @@ static int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EOPNOTSUPP;
 }
 
+static struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_buff *skb,
+				      usb_complete_t tx_complete)
+{
+	return PTR_ERR(-EOPNOTSUPP);
+}
+
+static int btmtk_usb_isopkt_start(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+
+static int btmtk_usb_isopkt_stop(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+
 static int btmtk_usb_setup(struct hci_dev *hdev)
 {
 	return -EOPNOTSUPP;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5de50c835964..590602dce3f8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2641,6 +2641,40 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 	return hci_recv_frame(hdev, skb);
 }
 
+static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
+{
+	struct btmtk_data *btmtk_data = hci_get_priv(data->hdev);
+	int err;
+
+	err = usb_driver_claim_interface(&btusb_driver,
+					 btmtk_data->isopkt_intf, data);
+	if (err < 0) {
+		btmtk_data->isopkt_intf = NULL;
+		bt_dev_err(data->hdev, "Failed to claim iso interface");
+		return;
+	}
+
+	set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
+}
+
+static void btusb_mtk_release_iso_intf(struct btusb_data *data)
+{
+	struct btmtk_data *btmtk_data = hci_get_priv(data->hdev);
+
+	if (btmtk_data->isopkt_intf) {
+		btmtk_usb_isopkt_stop(data->hdev);
+		clear_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags);
+
+		dev_kfree_skb_irq(btmtk_data->isopkt_skb);
+		btmtk_data->isopkt_skb = NULL;
+		usb_set_intfdata(btmtk_data->isopkt_intf, NULL);
+		usb_driver_release_interface(&btusb_driver,
+					     btmtk_data->isopkt_intf);
+	}
+
+	clear_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
+}
+
 static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2657,6 +2691,9 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	if (err < 0)
 		return err;
 
+	if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
+		btusb_mtk_release_iso_intf(data);
+
 	btusb_stop_traffic(data);
 	usb_kill_anchored_urbs(&data->tx_anchor);
 
@@ -2668,6 +2705,23 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	return err;
 }
 
+static int btusb_send_frame_mtk(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct urb *urb;
+
+	BT_DBG("%s", hdev->name);
+
+	if (hci_skb_pkt_type(skb) == HCI_ISODATA_PKT) {
+		urb = alloc_mtk_intr_urb(hdev, skb, btusb_tx_complete);
+		if (IS_ERR(urb))
+			return PTR_ERR(urb);
+
+		return submit_or_queue_tx_urb(hdev, urb);
+	} else {
+		return btusb_send_frame(hdev, skb);
+	}
+}
+
 static int btusb_mtk_setup(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2682,11 +2736,22 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	btmtk_data->ctrl_anchor = &data->ctrl_anchor;
 	btmtk_data->reset_sync = btusb_mtk_reset;
 
+	/* Claim ISO data interface and endpoint */
+	btmtk_data->isopkt_intf = usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM);
+	if (btmtk_data->isopkt_intf)
+		btusb_mtk_claim_iso_intf(data);
+
 	return btmtk_usb_setup(hdev);
 }
 
 static int btusb_mtk_shutdown(struct hci_dev *hdev)
 {
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+
+	if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
+		btusb_mtk_release_iso_intf(data);
+
 	return btmtk_usb_shutdown(hdev);
 }
 
@@ -3793,9 +3858,12 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->manufacturer = 70;
 		hdev->cmd_timeout = btmtk_reset_sync;
 		hdev->set_bdaddr = btmtk_set_bdaddr;
+		hdev->send = btusb_send_frame_mtk;
 		set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 		data->recv_acl = btmtk_usb_recv_acl;
+		data->suspend = btmtk_usb_isopkt_stop;
+		data->resume = btmtk_usb_isopkt_start;
 	}
 
 	if (id->driver_info & BTUSB_SWAVE) {
-- 
2.18.0

