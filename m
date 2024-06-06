Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4108814D717;
	Thu,  6 Jun 2024 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665839; cv=none; b=G8of39mXv8vSgYDWZjASsPgTuFMoxyrQs07b9DohyTFakP5tNoe5rbuAOHN3zWZlP6gDJFi8WrjjQGrIKNHU73dtmvbgd/V1H6uUZvUL6pfw9sBbJsHsm0+qkiRL3lKhMpJQsKXj8reni6Gz2+9CzHscBDB6FFbvQRDw9w/BVGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665839; c=relaxed/simple;
	bh=F+1q4LGx1KAJnoBApS/8IPwjnfHkXjq6zWp2uUpz+rU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AALA3Qr56If/MxhoAJih502SvIqgMmHgcaxtTxeIJ1ILQwfLz26zhEDEO1RJIkZ9Uf8bdz9yTA/+gwMzUc+IP0GVxcnQH76pRzY26jZol/cpu+v/hlZB/YYd3WDZ8onXiMUajGqjAeaih0ZHJ6ExJgc8uc7i4INO7f5A8SmX+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Zjtx2NGP; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Zjtx2NGP"
X-UUID: 7b52f6cc23e611efa54bbfbb386b949c-20240606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Fqk59cYkv/hMT/U1uV4aodYn7N+zMrEBTZRXOWp0fMg=;
	b=Zjtx2NGP97QAYRnth4l2iLxaIoJuzIkmnAZoiiQfkAuAzb1hQt7vj4oo8EOdXiGJmYq8ouCywv5159hXlq7ESO5ekJifTR/mrgoAQ9HXuppNW/qWsHpM6Go4PnsCflffR5ViQ7e0n+8tGAZkBuAyWozPPnbCLYo+EmoMlPyVRlQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:742e5c29-1aea-45e4-8b99-70f729254e28,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:23d8c984-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7b52f6cc23e611efa54bbfbb386b949c-20240606
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1710585673; Thu, 06 Jun 2024 17:23:49 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jun 2024 17:23:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jun 2024 17:23:47 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v3 4/4] Bluetooth: btusb: mediatek: add ISO data transmission functions
Date: Thu, 6 Jun 2024 17:23:40 +0800
Message-ID: <20240606092340.27675-5-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240606092340.27675-1-chris.lu@mediatek.com>
References: <20240606092340.27675-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.544900-8.000000
X-TMASE-MatchedRID: YCIazlj2MA3AtVbQuS2v5WwjJ4TFeU1uu2rcU2ygxCClVdpxhSGfIsCS
	2AMm1nQCXj+G1I2Cld9P2Tu3bTLAnKcgTP4t5UFTH5YQyOg71ZZMkOX0UoduuYeUNQK7Qj5cqjK
	1cw/inhPSA0y76vJRsuBbPERAXsERw4mZjhdFeRUjRwcsjqWGAjUl+OWKYzGzsVZedvn61v8wl0
	rFHzZKzs3wEcvZF5yA0ux40LnYo505XMoR34RFyqKa0xB73sAArHCvytg5b47wPxOpNhiWmSk9z
	7Gi8qI0me5pl6SF3CLb5B4XjNR/64rFHTmMFhb3kDpLRKO9xhRKgIbix5+XxAqiCYa6w8tv30oD
	EEVA5TDlHbjF1ioigvaIgZUXBHUYYn7rEKvI3Xe5x7uAXGEprQrefVId6fzVpLLiPixJzXW7SBO
	wG7Q1A0GG3XmeW0uqy9zCpgoSH0GXvKeHmOteH8T5AdDCAWlxndls9F9zmi2en0qBdy7fjIQmEN
	BkUZwTiIYIUEIsrqeJzha01Kx7HBac+UrRjxx+ydRP56yRRA+7nrAU9KQxUTrvAe6TNwLl2o/f8
	Umlfm+M7x0Xa35WQ2o3iKBL58Tm2trlAc3N/XOzLD5kmcW6ZGPy9vwGSQFk/RM/+SKR6qdNN8Pd
	7x12LOLzNWBegCW2wgn7iDBesS15zdAzex5xZmaGx1cdm3wpBIofqaa1YtJ6qgReD66RQv42fks
	hkIn2fuoD3V8hWamUTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.544900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	FA80C2C9FA73E9A831B4B33EFE5AA198A40068E6FB7E6F4FCFB283AC11EC4C322000:8

This patch implements functions for ISO data send and receive in btusb
driver for MediaTek's controller.

MediaTek defines a specific interrupt endpoint for ISO data transmissin
because the characteristics of interrupt endpoint are similar to the
application of ISO data which can support guaranteed transmissin
bandwidth, enough maximum data length and error checking mechanism.

Driver sets up ISO interface and endpoints in btusb_mtk_setup and clears
the setup in btusb_mtk_shutdown. ISO packet anchor stops when driver
suspend and resubmit iso urb in driver resume.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtk.c |  92 +++++++++++++
 drivers/bluetooth/btmtk.h |  38 ++++++
 drivers/bluetooth/btusb.c | 267 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 397 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index a27c251bf56e..5cb23c912f45 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -19,6 +19,9 @@
 #define MTK_SEC_MAP_COMMON_SIZE	12
 #define MTK_SEC_MAP_NEED_SEND_SIZE	52
 
+/* It is for mt79xx iso data transmission setting */
+#define MTK_ISO_THRESHOLD	264
+
 struct btmtk_patch_header {
 	u8 datetime[16];
 	u8 platform[4];
@@ -431,6 +434,95 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(btmtk_process_coredump);
 
+int btmtk_isointf_setup(struct hci_dev *hdev)
+{
+	u8 iso_param[2] = { 0x08, 0x01 };
+	struct sk_buff *skb;
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
+EXPORT_SYMBOL_GPL(btmtk_isointf_setup);
+
+int btmtk_isopkt_pad(struct hci_dev *hdev, struct sk_buff *skb)
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
+EXPORT_SYMBOL_GPL(btmtk_isopkt_pad);
+
+int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count)
+{
+	struct btmediatek_data *btmtk_data = hci_get_priv(hdev);
+	struct sk_buff *skb;
+	unsigned long flags;
+	int err = 0;
+
+	spin_lock_irqsave(&btmtk_data->isopkt_info.isorxlock, flags);
+	skb = btmtk_data->isopkt_info.isopkt_skb;
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
+			/* Complete ISO header */
+			hci_skb_expect(skb) = hci_iso_hdr(skb)->dlen;
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
+	btmtk_data->isopkt_info.isopkt_skb = skb;
+	spin_unlock_irqrestore(&btmtk_data->isopkt_info.isorxlock, flags);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(btmtk_recv_isopkt);
+
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
 MODULE_DESCRIPTION("Bluetooth support for MediaTek devices ver " VERSION);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 6a0697a22b16..cb9dc4ccc266 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: ISC */
 /* Copyright (C) 2021 MediaTek Inc. */
 
+#include <linux/usb.h>
+
 #define FIRMWARE_MT7622		"mediatek/mt7622pr2h.bin"
 #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
 #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
@@ -129,6 +131,9 @@ struct btmtk_hci_wmt_params {
 typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
 
 enum {
+	BTMTK_ISOPKT_OVER_INTR,
+	BTMTK_ISOPKT_RUNNING,
+
 	__BTMTK_NUM_FLAGS,
 };
 
@@ -139,12 +144,24 @@ struct btmtk_coredump_info {
 	int state;
 };
 
+struct btmtk_isopkt_info {
+	struct usb_endpoint_descriptor *isopkt_tx_ep;
+	struct usb_endpoint_descriptor *isopkt_rx_ep;
+	struct usb_interface *isopkt_intf;
+	struct usb_anchor isopkt_anchor;
+	struct sk_buff *isopkt_skb;
+
+	/* spinlock for ISO data transmission */
+	spinlock_t isorxlock;
+};
+
 struct btmediatek_data {
 	DECLARE_BITMAP(flags, __BTMTK_NUM_FLAGS);
 
 	u32 dev_id;
 	btmtk_reset_sync_func_t reset_sync;
 	struct btmtk_coredump_info cd_info;
+	struct btmtk_isopkt_info isopkt_info;
 };
 
 #define btmtk_set_flag(hdev, nr)						\
@@ -186,6 +203,12 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb);
 
 void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 			   u32 fw_flavor);
+
+int btmtk_isointf_setup(struct hci_dev *hdev);
+
+int btmtk_isopkt_pad(struct hci_dev *hdev, struct sk_buff *skb);
+
+int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count);
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
@@ -225,4 +248,19 @@ static void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id,
 				  u32 fw_ver, u32 fw_flavor)
 {
 }
+
+static int btmtk_isointf_setup(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+
+static int btmtk_isopkt_pad(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count)
+{
+	return -EOPNOTSUPP;
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 83765c0c14b4..e297dcb6a8e2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2653,6 +2653,8 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 #define MTK_BT_RESET_REG_CONNV3	0x70028610
 #define MTK_BT_READ_DEV_ID	0x70010200
 
+/* MediaTek ISO Interface */
+#define MTK_ISO_IFNUM		2
 
 static void btusb_mtk_wmt_recv(struct urb *urb)
 {
@@ -3129,6 +3131,239 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	return err;
 }
 
+static void btusb_mtk_intr_complete(struct urb *urb)
+{
+	struct hci_dev *hdev = urb->context;
+	struct btmediatek_data *btmtk_data = hci_get_priv(hdev);
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	int err;
+
+	BT_DBG("%s urb %p status %d count %d", hdev->name, urb, urb->status,
+	       urb->actual_length);
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
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
+	if (!btmtk_test_flag(hdev, BTMTK_ISOPKT_RUNNING))
+		return;
+
+	usb_mark_last_busy(data->udev);
+	usb_anchor_urb(urb, &btmtk_data->isopkt_info.isopkt_anchor);
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
+static int btusb_mtk_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
+{
+	struct btmediatek_data *btmtk_data = hci_get_priv(hdev);
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	unsigned char *buf;
+	unsigned int pipe;
+	struct urb *urb;
+	int err, size;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!btmtk_data->isopkt_info.isopkt_rx_ep)
+		return -ENODEV;
+
+	urb = usb_alloc_urb(0, mem_flags);
+	if (!urb)
+		return -ENOMEM;
+	size = le16_to_cpu(btmtk_data->isopkt_info.isopkt_rx_ep->wMaxPacketSize);
+
+	buf = kmalloc(size, mem_flags);
+	if (!buf) {
+		usb_free_urb(urb);
+		return -ENOMEM;
+	}
+
+	pipe = usb_rcvintpipe(data->udev,
+			      btmtk_data->isopkt_info.isopkt_rx_ep->bEndpointAddress);
+
+	usb_fill_int_urb(urb, data->udev, pipe, buf, size,
+			 btusb_mtk_intr_complete, hdev,
+			 btmtk_data->isopkt_info.isopkt_rx_ep->bInterval);
+
+	urb->transfer_flags |= URB_FREE_BUFFER;
+
+	usb_mark_last_busy(data->udev);
+	usb_anchor_urb(urb, &btmtk_data->isopkt_info.isopkt_anchor);
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
+static inline int __set_mtk_intr_interface(struct hci_dev *hdev, unsigned int ifnum)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct btmediatek_data *btmtk_data = hci_get_priv(hdev);
+	struct usb_interface *intf = btmtk_data->isopkt_info.isopkt_intf;
+	int i, err;
+
+	if (!btmtk_data->isopkt_info.isopkt_intf)
+		return -ENODEV;
+
+	err = usb_set_interface(data->udev, ifnum, 1);
+	if (err < 0) {
+		bt_dev_err(hdev, "setting interface failed (%d)", -err);
+		return err;
+	}
+
+	btmtk_data->isopkt_info.isopkt_tx_ep = NULL;
+	btmtk_data->isopkt_info.isopkt_rx_ep = NULL;
+
+	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
+		struct usb_endpoint_descriptor *ep_desc;
+
+		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
+
+		if (!btmtk_data->isopkt_info.isopkt_tx_ep &&
+		    usb_endpoint_is_int_out(ep_desc)) {
+			btmtk_data->isopkt_info.isopkt_tx_ep = ep_desc;
+			continue;
+		}
+
+		if (!btmtk_data->isopkt_info.isopkt_rx_ep &&
+		    usb_endpoint_is_int_in(ep_desc)) {
+			btmtk_data->isopkt_info.isopkt_rx_ep = ep_desc;
+			continue;
+		}
+	}
+
+	if (!btmtk_data->isopkt_info.isopkt_tx_ep ||
+	    !btmtk_data->isopkt_info.isopkt_rx_ep) {
+		bt_dev_err(hdev, "invalid interrupt descriptors");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int btusb_mtk_isopkt_stop(struct hci_dev *hdev)
+{
+	struct btmediatek_data *btmtk_data = hci_get_priv(hdev);
+
+	usb_kill_anchored_urbs(&btmtk_data->isopkt_info.isopkt_anchor);
+
+	return 0;
+}
+
+static int btusb_mtk_isopkt_start(struct hci_dev *hdev)
+{
+	if (btmtk_test_flag(hdev, BTMTK_ISOPKT_RUNNING)) {
+		if (btusb_mtk_submit_intr_urb(hdev, GFP_NOIO) < 0)
+			btmtk_clear_flag(hdev, BTMTK_ISOPKT_RUNNING);
+	}
+
+	return 0;
+}
+
+static int btusb_mtk_claim_iso_intf(struct btusb_data *data, struct usb_interface *intf)
+{
+	struct btmediatek_data *btmtk_data = hci_get_priv(data->hdev);
+	int err;
+
+	err = usb_driver_claim_interface(&btusb_driver, intf, data);
+	if (err < 0)
+		return err;
+
+	init_usb_anchor(&btmtk_data->isopkt_info.isopkt_anchor);
+	spin_lock_init(&btmtk_data->isopkt_info.isorxlock);
+
+	__set_mtk_intr_interface(data->hdev, MTK_ISO_IFNUM);
+
+	err = btusb_mtk_submit_intr_urb(data->hdev, GFP_KERNEL);
+	if (err < 0) {
+		btusb_mtk_isopkt_stop(data->hdev);
+		bt_dev_err(data->hdev, "ISO intf not support (%d)", err);
+		return err;
+	}
+
+	btmtk_set_flag(data->hdev, BTMTK_ISOPKT_OVER_INTR);
+
+	return 0;
+}
+
+static struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct btmediatek_data *btmtk_data = hci_get_priv(hdev);
+	unsigned int pipe;
+	struct urb *urb;
+
+	if (!btmtk_data->isopkt_info.isopkt_tx_ep)
+		return ERR_PTR(-ENODEV);
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return ERR_PTR(-ENOMEM);
+
+	if (btmtk_isopkt_pad(hdev, skb))
+		return ERR_PTR(-EINVAL);
+
+	pipe = usb_sndintpipe(data->udev,
+			      btmtk_data->isopkt_info.isopkt_tx_ep->bEndpointAddress);
+
+	usb_fill_int_urb(urb, data->udev, pipe,
+			 skb->data, skb->len, btusb_tx_complete,
+			 skb, btmtk_data->isopkt_info.isopkt_tx_ep->bInterval);
+
+	skb->dev = (void *)hdev;
+
+	return urb;
+}
+
+static int btusb_send_frame_mtk(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct urb *urb;
+
+	BT_DBG("%s", hdev->name);
+
+	if (hci_skb_pkt_type(skb) == HCI_ISODATA_PKT) {
+		urb = alloc_mtk_intr_urb(hdev, skb);
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
@@ -3213,6 +3448,12 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 		/* It's Device EndPoint Reset Option Register */
 		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
 
+		/* Claim ISO data interface and endpoint */
+		mediatek->isopkt_info.isopkt_intf = usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM);
+		err = btusb_mtk_claim_iso_intf(data, mediatek->isopkt_info.isopkt_intf);
+		if (err < 0)
+			mediatek->isopkt_info.isopkt_intf = NULL;
+
 		/* Enable Bluetooth protocol */
 		param = 1;
 		wmt_params.op = BTMTK_WMT_FUNC_CTRL;
@@ -3229,6 +3470,13 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 
 		hci_set_msft_opcode(hdev, 0xFD30);
 		hci_set_aosp_capable(hdev);
+
+		/* Set up ISO interface after protocol enabled */
+		if (btmtk_test_flag(hdev, BTMTK_ISOPKT_OVER_INTR)) {
+			btmtk_isointf_setup(hdev);
+			btmtk_set_flag(data->hdev, BTMTK_ISOPKT_RUNNING);
+		}
+
 		goto done;
 	default:
 		bt_dev_err(hdev, "Unsupported hardware variant (%08x)",
@@ -3321,6 +3569,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 static int btusb_mtk_shutdown(struct hci_dev *hdev)
 {
 	struct btmtk_hci_wmt_params wmt_params;
+	struct btmediatek_data *btmtk_data = hci_get_priv(hdev);
 	u8 param = 0;
 	int err;
 
@@ -3337,6 +3586,21 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
 		return err;
 	}
 
+	if (btmtk_test_flag(hdev, BTMTK_ISOPKT_RUNNING)) {
+		btusb_mtk_isopkt_stop(hdev);
+		btmtk_clear_flag(hdev, BTMTK_ISOPKT_RUNNING);
+
+		if (btmtk_data->isopkt_info.isopkt_intf) {
+			usb_set_intfdata(btmtk_data->isopkt_info.isopkt_intf, NULL);
+			usb_driver_release_interface(&btusb_driver,
+						     btmtk_data->isopkt_info.isopkt_intf);
+			dev_kfree_skb_irq(btmtk_data->isopkt_info.isopkt_skb);
+			btmtk_data->isopkt_info.isopkt_skb = NULL;
+
+			btmtk_clear_flag(hdev, BTMTK_ISOPKT_OVER_INTR);
+		}
+	}
+
 	return 0;
 }
 
@@ -4475,9 +4739,12 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->manufacturer = 70;
 		hdev->cmd_timeout = btmtk_reset_sync;
 		hdev->set_bdaddr = btmtk_set_bdaddr;
+		hdev->send = btusb_send_frame_mtk;
 		set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 		data->recv_acl = btusb_recv_acl_mtk;
+		data->dev_suspend = btusb_mtk_isopkt_stop;
+		data->dev_resume = btusb_mtk_isopkt_start;
 	}
 
 	if (id->driver_info & BTUSB_SWAVE) {
-- 
2.18.0

