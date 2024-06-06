Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A813D2A2;
	Thu,  6 Jun 2024 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674224; cv=none; b=t74s+6h2JG3LlgXp3a/XT6gItdW1K5W2eneQeo41rZAFQ52tmqC0iV6YQWMhlQIPiOgL7x387zV2kJ7H2s4/UMYJKsIBNp8CoxTbsxnlXEo4kyZz/xh6yzdJwboIlBQ+GkAdPezvKBDDTQlDvQpO1txApii0RYMzxpTQZT71+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674224; c=relaxed/simple;
	bh=nnP54I1u2jNifdmqWIjZqISueeNHl2/+n4/T43E4HyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axFMLT1HfAEOQzNpFaUAdIyBSkI9He5zjZC/hOAjyPdAm5SHP6KW0DKk+dcekVaIpYrSjkFGF/V4c82K3jUKR77l3Xw0m/QBWVFqg3sYhwEPmn3LKuYB3eUX5gtiklLiWbWvEcgt2ZcK6vhcDJlBJOFPErvOz1RzflL8NB5iu4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mi5xqxfG; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mi5xqxfG"
X-UUID: fd1a4fd023f911efa22eafcdcd04c131-20240606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kF+4t7j+SXN126kjmYcGQcA2wDDzslPmIdPUKhYMC5k=;
	b=mi5xqxfGR/YUC5YSLeVwi7oZcWcVnDC9vV6VKbj1FtxDiNbDWKqXphRuAQAy/a3GrDqOo54/hHvtOgUEO9CZQ8RHx4lh/qTyROV1zkt17kNNAtVqkFkb6hy1+LGTTubOksNY7pR2qV8rRRt11J1tTIkxuZPYm73ITqYZv3keU8Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:2082564a-4137-4dfd-b25f-74fe48215ca1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:13fd4a88-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: fd1a4fd023f911efa22eafcdcd04c131-20240606
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 871867411; Thu, 06 Jun 2024 19:43:27 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jun 2024 19:43:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jun 2024 19:43:25 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v4 4/4] Bluetooth: btusb: mediatek: add ISO data transmission functions
Date: Thu, 6 Jun 2024 19:43:21 +0800
Message-ID: <20240606114321.30515-5-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240606114321.30515-1-chris.lu@mediatek.com>
References: <20240606114321.30515-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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
 drivers/bluetooth/btmtk.c |  94 ++++++++++++++
 drivers/bluetooth/btmtk.h |  38 ++++++
 drivers/bluetooth/btusb.c | 267 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 399 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index a27c251bf56e..07d27724d915 100644
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
@@ -431,6 +434,97 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
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
+			__le16 dlen = hci_iso_hdr(skb)->dlen;
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

