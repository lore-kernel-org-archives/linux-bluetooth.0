Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A65161319;
	Wed, 29 May 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964203; cv=none; b=uGDiiIoVqbhpnliFbMq+3dPV3CUjeq0BNFzv/HmhMBv3ngFJL1mO97niexKxiIcS8SGIH0bV9YGrJSw3RlPJh1PG9hTRIq2QKNdwM7pqAc2wib+83pNkkdxSMaW8BOhHNx591GRg4muky0YkGV/75mT+b8Ubg+jQF8t/weySwfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964203; c=relaxed/simple;
	bh=gH9EK+q4kWXaJaibqke/QL6Ra5oGcjIEBB1zbTutTxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbKCDRWdnu2xL5Mqzozif8mFKe6sGnLdDA3pYIKHR2qz89IxUvlPd0+BBMvH+O0rmEsz9LuS5ftqcHUoYEQyhKuOdFq9EQvjlRyRP5dEkFOBytAq4KT2DJYlLrylZtf6v14tykvkgBokZzUewjS2012k75pHIZAoPAA2dlV6nc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ORoxy8WO; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ORoxy8WO"
X-UUID: dc1620781d8411efbfff99f2466cf0b4-20240529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cUjqqZWgYcm0JMsKrxF595ggYREOR+zmYsWORLbIiPw=;
	b=ORoxy8WOY103PHQ3FRd9wMOGA2kQBGvmCqlNhm9JkcE3eUXAVoJ2Da5jMHVXtVJmIFNOWQnBcGRCJduzva7zXByXLKqjtc3rJZEowvuYoGXciiPzodYFXLunezdjNrwPtvRMJEaHRimMqGM/jclVPxNceUw52ZJ9MglgT/Y9/xI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:731b435a-df9c-4b29-9052-4fcb4ccc017b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:cc487384-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: dc1620781d8411efbfff99f2466cf0b4-20240529
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 578140357; Wed, 29 May 2024 14:29:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 May 2024 14:29:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 May 2024 14:29:51 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 3/3] Bluetooth: btusb: mediatek: add MediaTek ISO data transmission function
Date: Wed, 29 May 2024 14:29:46 +0800
Message-ID: <20240529062946.5655-4-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240529062946.5655-1-chris.lu@mediatek.com>
References: <20240529062946.5655-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.684000-8.000000
X-TMASE-MatchedRID: QoOQ2bHHh/ZLbaTfilVXfUj2sPWKvtn0C0wUYPNpDFrfc2Xd6VJ+ysHZ
	AvQpPtWOP0eqZNSe+sTVL7DIQyVd77BAQLqGlKivhK8o4aoss8qscK/K2DlvjkatGP19otUEu0m
	nSBAOWhtvmRbOsYwtgeBbPERAXsERw4mZjhdFeRUjRwcsjqWGAjUl+OWKYzGzuWYx8s2K6Rprat
	Uv6FBuri//o4fkI44zK/6miJhKjUA9f7b5lYZt2ZA6S0SjvcYUVjkEEmuL2x3RLEyE6G4DREtHo
	jrK13E45uM0IzjxHHoPAyzCoGRLXWVnjx+sD6KylyI0nNqpRfWt4laWdJbsDMRi+FlXlWiFmCCL
	XIa/Op3qkjVwvSn6JpGNJqzkd7Ibe9nZ9spQitZAKD7bjg/G2uDkiVuoRhM7grAXgr/AjP1HuLm
	esIvhFfWyLqHM/Er8ikEsZJYv7N1HU2fChZKMzRafLXbshfogzSnbR3NwN1wAIXlMppp3X4QmEN
	BkUZwTgbtWX1w9y/EEfT5dV+IOpeF/B1jEjV+6rDFtme53Kvul9VzHf0qr7iD8g3n+3IBxkbhMU
	rEolyKgVtUBJhi863jxHjRjVBslZ28ZQS4q9JxoMLOoNHsM9onsgRUxNfnHV9eB8vnmKe9t31nT
	PUZUNsYrZSfVDPPngDLqnrRlXrZ8nn9tnqel2MprJP8FBOIa+lNXfMqhO/FpCDGrCSexp5hrPdU
	qtd6EUCSa6tkjoLjzlXUW/uS1WnLmS0d6/cLQhTtU0fe9ArkreK8Xw53DzaGfVwPFj+aPE1GeEH
	xFMW90BNB20+SxH7f8mJY57oZddJaBDYald1mHO0tVYDV4T0MMprcbiest
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.684000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E3A0CDDD247D37EF12E50C13C84E26EAE041DF2BF08C878A69685C6FBB01F47D2000:8

This patch implement function for ISO data send and receive in btusb
driver for MediaTek Controller.

MediaTek define a specific interrupt endpoint for ISO data
transmission because the characteristics of interrupt are
similar to the application of ISO data which can ensure bandwidth,
has enough data length and support error check.

Driver setup ISO interface in btusb_mtk_setup after download patch and
submit interrtupt urb to handle ISO data send and receive.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtk.c |  35 +++++
 drivers/bluetooth/btmtk.h |  23 +++
 drivers/bluetooth/btusb.c | 295 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 352 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index a27c251bf56e..f0aecd319911 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -4,6 +4,7 @@
  */
 #include <linux/module.h>
 #include <linux/firmware.h>
+#include <linux/usb.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -19,6 +20,9 @@
 #define MTK_SEC_MAP_COMMON_SIZE	12
 #define MTK_SEC_MAP_NEED_SEND_SIZE	52
 
+/* It is for mt79xx iso data transmission setting */
+#define MTK_ISO_THRESHOLD	264
+
 struct btmtk_patch_header {
 	u8 datetime[16];
 	u8 platform[4];
@@ -431,6 +435,37 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
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
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
 MODULE_DESCRIPTION("Bluetooth support for MediaTek devices ver " VERSION);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 6a0697a22b16..afc914e921dd 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -129,6 +129,8 @@ struct btmtk_hci_wmt_params {
 typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
 
 enum {
+	BTMTK_ISOPKT_OVER_INTR,
+
 	__BTMTK_NUM_FLAGS,
 };
 
@@ -139,12 +141,19 @@ struct btmtk_coredump_info {
 	int state;
 };
 
+struct btmtk_isopkt_info {
+	struct usb_interface *isopkt_intf;
+	struct usb_endpoint_descriptor *isopkt_tx_ep;
+	struct usb_endpoint_descriptor *isopkt_rx_ep;
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
@@ -186,6 +195,10 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb);
 
 void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 			   u32 fw_flavor);
+
+int btmtk_isointf_setup(struct hci_dev *hdev);
+
+int btmtk_isopkt_pad(struct hci_dev *hdev, struct sk_buff *skb);
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
@@ -225,4 +238,14 @@ static void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id,
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
+	return -EOPNOTSUPP;
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 79aefdb3324d..592be71a7c45 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -831,6 +831,7 @@ struct qca_dump_info {
 #define BTUSB_USE_ALT3_FOR_WBS	15
 #define BTUSB_ALT6_CONTINUOUS_TX	16
 #define BTUSB_HW_SSR_ACTIVE	17
+#define BTUSB_ISOPKT_RUNNING	18
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -860,11 +861,13 @@ struct btusb_data {
 	struct usb_anchor isoc_anchor;
 	struct usb_anchor diag_anchor;
 	struct usb_anchor ctrl_anchor;
+	struct usb_anchor isopkt_anchor;
 	spinlock_t rxlock;
 
 	struct sk_buff *evt_skb;
 	struct sk_buff *acl_skb;
 	struct sk_buff *sco_skb;
+	struct sk_buff *isopkt_skb;
 
 	struct usb_endpoint_descriptor *intr_ep;
 	struct usb_endpoint_descriptor *bulk_tx_ep;
@@ -1099,6 +1102,9 @@ static inline void btusb_free_frags(struct btusb_data *data)
 	dev_kfree_skb_irq(data->sco_skb);
 	data->sco_skb = NULL;
 
+	dev_kfree_skb_irq(data->isopkt_skb);
+	data->isopkt_skb = NULL;
+
 	spin_unlock_irqrestore(&data->rxlock, flags);
 }
 
@@ -1327,6 +1333,64 @@ static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
 	return err;
 }
 
+static int btusb_recv_isopkt(struct btusb_data *data, void *buffer, int count)
+{
+	struct sk_buff *skb;
+	unsigned long flags;
+	int err = 0;
+
+	spin_lock_irqsave(&data->rxlock, flags);
+	skb = data->isopkt_skb;
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
+			hci_recv_frame(data->hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	data->isopkt_skb = skb;
+	spin_unlock_irqrestore(&data->rxlock, flags);
+
+	return err;
+}
+
 static void btusb_intr_complete(struct urb *urb)
 {
 	struct hci_dev *hdev = urb->context;
@@ -1784,6 +1848,101 @@ static int btusb_submit_diag_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	return err;
 }
 
+static void btusb_mtk_intr_complete(struct urb *urb)
+{
+	struct hci_dev *hdev = urb->context;
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
+		if (btusb_recv_isopkt(data, urb->transfer_buffer,
+				      urb->actual_length) < 0) {
+			bt_dev_err(hdev, "corrupted iso packet");
+			hdev->stat.err_rx++;
+		}
+	} else if (urb->status == -ENOENT) {
+		/* Avoid suspend failed when usb_kill_urb */
+		return;
+	}
+
+	if (!test_bit(BTUSB_ISOPKT_RUNNING, &data->flags))
+		return;
+
+	usb_mark_last_busy(data->udev);
+	usb_anchor_urb(urb, &data->isopkt_anchor);
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
+	usb_anchor_urb(urb, &data->isopkt_anchor);
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
 static void btusb_tx_complete(struct urb *urb)
 {
 	struct sk_buff *skb = urb->context;
@@ -1898,6 +2057,7 @@ static void btusb_stop_traffic(struct btusb_data *data)
 	usb_kill_anchored_urbs(&data->isoc_anchor);
 	usb_kill_anchored_urbs(&data->diag_anchor);
 	usb_kill_anchored_urbs(&data->ctrl_anchor);
+	usb_kill_anchored_urbs(&data->isopkt_anchor);
 }
 
 static int btusb_close(struct hci_dev *hdev)
@@ -1917,6 +2077,7 @@ static int btusb_close(struct hci_dev *hdev)
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
 	clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
+	clear_bit(BTUSB_ISOPKT_RUNNING, &data->flags);
 
 	btusb_stop_traffic(data);
 	btusb_free_frags(data);
@@ -2043,6 +2204,81 @@ static struct urb *alloc_isoc_urb(struct hci_dev *hdev, struct sk_buff *skb)
 	return urb;
 }
 
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
+static struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct btmediatek_data *btmtk_data = hci_get_priv(hdev);
+	struct urb *urb;
+	unsigned int pipe;
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
 static int submit_tx_urb(struct hci_dev *hdev, struct urb *urb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2122,7 +2358,10 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		return submit_tx_urb(hdev, urb);
 
 	case HCI_ISODATA_PKT:
-		urb = alloc_bulk_urb(hdev, skb);
+		if (btmtk_test_flag(hdev, BTMTK_ISOPKT_OVER_INTR))
+			urb = alloc_mtk_intr_urb(hdev, skb);
+		else
+			urb = alloc_bulk_urb(hdev, skb);
 		if (IS_ERR(urb))
 			return PTR_ERR(urb);
 
@@ -2650,6 +2889,8 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 #define MTK_BT_RESET_REG_CONNV3	0x70028610
 #define MTK_BT_READ_DEV_ID	0x70010200
 
+/* MediaTek ISO interface number */
+#define MTK_ISO_IFNUM		2
 
 static void btusb_mtk_wmt_recv(struct urb *urb)
 {
@@ -3126,6 +3367,28 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	return err;
 }
 
+static int btusb_mtk_claim_iso_intf(struct btusb_data *data, struct usb_interface *intf)
+{
+	int err;
+
+	err = usb_driver_claim_interface(&btusb_driver, intf, data);
+	if (err < 0)
+		return err;
+
+	__set_mtk_intr_interface(data->hdev, MTK_ISO_IFNUM);
+
+	err = btusb_mtk_submit_intr_urb(data->hdev, GFP_KERNEL);
+	if (err < 0) {
+		usb_kill_anchored_urbs(&data->isopkt_anchor);
+		bt_dev_err(data->hdev, "ISO intf not support (%d)", err);
+		return err;
+	}
+
+	btmtk_set_flag(data->hdev, BTMTK_ISOPKT_OVER_INTR);
+
+	return 0;
+}
+
 static int btusb_mtk_setup(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -3210,6 +3473,12 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 		/* It's Device EndPoint Reset Option Register */
 		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
 
+		/* Claim USB interface and EndPoint for ISO data */
+		mediatek->isopkt_info.isopkt_intf = usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM);
+		err = btusb_mtk_claim_iso_intf(data, mediatek->isopkt_info.isopkt_intf);
+		if (err < 0)
+			mediatek->isopkt_info.isopkt_intf = NULL;
+
 		/* Enable Bluetooth protocol */
 		param = 1;
 		wmt_params.op = BTMTK_WMT_FUNC_CTRL;
@@ -3226,6 +3495,13 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 
 		hci_set_msft_opcode(hdev, 0xFD30);
 		hci_set_aosp_capable(hdev);
+
+		/* Setup ISO interface after protocol enabled */
+		if (btmtk_test_flag(hdev, BTMTK_ISOPKT_OVER_INTR)) {
+			btmtk_isointf_setup(hdev);
+			set_bit(BTUSB_ISOPKT_RUNNING, &data->flags);
+		}
+
 		goto done;
 	default:
 		bt_dev_err(hdev, "Unsupported hardware variant (%08x)",
@@ -4347,6 +4623,7 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->isoc_anchor);
 	init_usb_anchor(&data->diag_anchor);
 	init_usb_anchor(&data->ctrl_anchor);
+	init_usb_anchor(&data->isopkt_anchor);
 	spin_lock_init(&data->rxlock);
 
 	priv_size = 0;
@@ -4663,6 +4940,17 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (data->diag)
 		usb_set_intfdata(data->diag, NULL);
 
+	if (btmtk_test_flag(hdev, BTMTK_ISOPKT_OVER_INTR)) {
+		struct btmediatek_data *btmtk_data = hci_get_priv(hdev);
+
+		if (btmtk_data->isopkt_info.isopkt_intf) {
+			usb_set_intfdata(btmtk_data->isopkt_info.isopkt_intf, NULL);
+			usb_driver_release_interface(&btusb_driver,
+						     btmtk_data->isopkt_info.isopkt_intf);
+		}
+		btmtk_clear_flag(hdev, BTMTK_ISOPKT_OVER_INTR);
+	}
+
 	hci_unregister_dev(hdev);
 
 	if (intf == data->intf) {
@@ -4818,6 +5106,11 @@ static int btusb_resume(struct usb_interface *intf)
 			btusb_submit_isoc_urb(hdev, GFP_NOIO);
 	}
 
+	if (test_bit(BTUSB_ISOPKT_RUNNING, &data->flags)) {
+		if (btusb_mtk_submit_intr_urb(hdev, GFP_NOIO) < 0)
+			clear_bit(BTUSB_ISOPKT_RUNNING, &data->flags);
+	}
+
 	spin_lock_irq(&data->txlock);
 	play_deferred(data);
 	clear_bit(BTUSB_SUSPENDING, &data->flags);
-- 
2.18.0

