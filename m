Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E683153BE3;
	Tue,  2 Jul 2024 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719919867; cv=none; b=i1VWEOrwjNwKDNT5kLYgeIozYDvgsZBHy1Jt36Td+VmHenbuWD3ZfWUUszX1WEhN+AyYtGL6ZyA8mfuiVhzqqiy45nl29aDjEwlG+mJ5LLdbmbz2TUG3wcfgJHdva9cWwQNmHMTynU0Nl2kwxSDJJYFqhgEVucOclvmGj1+0P7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719919867; c=relaxed/simple;
	bh=mI8WVt2DqI/sz2+PREeadj4tvE2MNC7xsrgf5xQxOMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfbmgneuUCcVf5GRRPYnDCYZH5bh1Aa4bXSzTRyQP2YxWyTptiItP+u+I6veUZ1SWuUkDEKPTlw9Xh89u67l4Z58uwgPUhLCZMtOlDcEv1bR5IQh+vzWvZbN5YR1F9F/L0hDlDf1ebvHr5YCBUukCDuRf0SLhsEwlwB0TCkN0kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=H5QCDL1I; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="H5QCDL1I"
X-UUID: 8c0ca5aa386611ef99dc3f8fac2c3230-20240702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=n+Ag5EzoWILjb0eLw8pOv73ep6jpF3dpZ7C1Otz44us=;
	b=H5QCDL1IuYnZUTlpEu4SlppCT4bVkQoCnjQukHvxhmY/AaQhFzWObMZbVl3Oi5wQf1h45rYjTBCZmcGOSdmJI58eXufd+oZWPfzRX3D5rBYE2K2wEdcLEgZeEWRju58V9lCbSfRA4z3u+UeVUIxZdLQNjQrnIbQHHYJqUg1PTe4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:d9cdda1b-f834-44f6-b3b5-d854816e69ca,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:9dbadcd4-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8c0ca5aa386611ef99dc3f8fac2c3230-20240702
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 539436895; Tue, 02 Jul 2024 19:30:55 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Jul 2024 19:30:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 Jul 2024 19:30:54 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v6 5/8] Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c
Date: Tue, 2 Jul 2024 19:30:48 +0800
Message-ID: <20240702113051.24372-6-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240702113051.24372-1-chris.lu@mediatek.com>
References: <20240702113051.24372-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Move btusb_mtk_hci_wmt_sync from btusb.c to btmtk.c which holds
vendor specific stuff and would make btusb.c clean.

Add usb.h header to btmtksdio.c/btmtkuart.c for usb related element
defined in btmtk.h

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c     | 265 +++++++++++++++++++++++++++++++
 drivers/bluetooth/btmtk.h     |  31 ++++
 drivers/bluetooth/btmtksdio.c |   1 +
 drivers/bluetooth/btmtkuart.c |   1 +
 drivers/bluetooth/btusb.c     | 290 +---------------------------------
 5 files changed, 305 insertions(+), 283 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 6489e4a63fb6..3443a0837a86 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -4,6 +4,7 @@
  */
 #include <linux/module.h>
 #include <linux/firmware.h>
+#include <linux/usb.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -431,6 +432,270 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(btmtk_process_coredump);
 
+static void btmtk_usb_wmt_recv(struct urb *urb)
+{
+	struct hci_dev *hdev = urb->context;
+	struct btmtk_data *data = hci_get_priv(hdev);
+	struct sk_buff *skb;
+	int err;
+
+	if (urb->status == 0 && urb->actual_length > 0) {
+		hdev->stat.byte_rx += urb->actual_length;
+
+		/* WMT event shouldn't be fragmented and the size should be
+		 * less than HCI_WMT_MAX_EVENT_SIZE.
+		 */
+		skb = bt_skb_alloc(HCI_WMT_MAX_EVENT_SIZE, GFP_ATOMIC);
+		if (!skb) {
+			hdev->stat.err_rx++;
+			kfree(urb->setup_packet);
+			return;
+		}
+
+		hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
+		skb_put_data(skb, urb->transfer_buffer, urb->actual_length);
+
+		/* When someone waits for the WMT event, the skb is being cloned
+		 * and being processed the events from there then.
+		 */
+		if (test_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags)) {
+			data->evt_skb = skb_clone(skb, GFP_ATOMIC);
+			if (!data->evt_skb) {
+				kfree_skb(skb);
+				kfree(urb->setup_packet);
+				return;
+			}
+		}
+
+		err = hci_recv_frame(hdev, skb);
+		if (err < 0) {
+			kfree_skb(data->evt_skb);
+			data->evt_skb = NULL;
+			kfree(urb->setup_packet);
+			return;
+		}
+
+		if (test_and_clear_bit(BTMTK_TX_WAIT_VND_EVT,
+				       &data->flags)) {
+			/* Barrier to sync with other CPUs */
+			smp_mb__after_atomic();
+			wake_up_bit(&data->flags,
+				    BTMTK_TX_WAIT_VND_EVT);
+		}
+		kfree(urb->setup_packet);
+		return;
+	} else if (urb->status == -ENOENT) {
+		/* Avoid suspend failed when usb_kill_urb */
+		return;
+	}
+
+	usb_mark_last_busy(data->udev);
+
+	/* The URB complete handler is still called with urb->actual_length = 0
+	 * when the event is not available, so we should keep re-submitting
+	 * URB until WMT event returns, Also, It's necessary to wait some time
+	 * between the two consecutive control URBs to relax the target device
+	 * to generate the event. Otherwise, the WMT event cannot return from
+	 * the device successfully.
+	 */
+	udelay(500);
+
+	usb_anchor_urb(urb, data->ctrl_anchor);
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err < 0) {
+		kfree(urb->setup_packet);
+		/* -EPERM: urb is being killed;
+		 * -ENODEV: device got disconnected
+		 */
+		if (err != -EPERM && err != -ENODEV)
+			bt_dev_err(hdev, "urb %p failed to resubmit (%d)",
+				   urb, -err);
+		usb_unanchor_urb(urb);
+	}
+}
+
+static int btmtk_usb_submit_wmt_recv_urb(struct hci_dev *hdev)
+{
+	struct btmtk_data *data = hci_get_priv(hdev);
+	struct usb_ctrlrequest *dr;
+	unsigned char *buf;
+	int err, size = 64;
+	unsigned int pipe;
+	struct urb *urb;
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return -ENOMEM;
+
+	dr = kmalloc(sizeof(*dr), GFP_KERNEL);
+	if (!dr) {
+		usb_free_urb(urb);
+		return -ENOMEM;
+	}
+
+	dr->bRequestType = USB_TYPE_VENDOR | USB_DIR_IN;
+	dr->bRequest     = 1;
+	dr->wIndex       = cpu_to_le16(0);
+	dr->wValue       = cpu_to_le16(48);
+	dr->wLength      = cpu_to_le16(size);
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf) {
+		kfree(dr);
+		usb_free_urb(urb);
+		return -ENOMEM;
+	}
+
+	pipe = usb_rcvctrlpipe(data->udev, 0);
+
+	usb_fill_control_urb(urb, data->udev, pipe, (void *)dr,
+			     buf, size, btmtk_usb_wmt_recv, hdev);
+
+	urb->transfer_flags |= URB_FREE_BUFFER;
+
+	usb_anchor_urb(urb, data->ctrl_anchor);
+	err = usb_submit_urb(urb, GFP_KERNEL);
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
+int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
+			   struct btmtk_hci_wmt_params *wmt_params)
+{
+	struct btmtk_data *data = hci_get_priv(hdev);
+	struct btmtk_hci_wmt_evt_funcc *wmt_evt_funcc;
+	u32 hlen, status = BTMTK_WMT_INVALID;
+	struct btmtk_hci_wmt_evt *wmt_evt;
+	struct btmtk_hci_wmt_cmd *wc;
+	struct btmtk_wmt_hdr *hdr;
+	int err;
+
+	/* Send the WMT command and wait until the WMT event returns */
+	hlen = sizeof(*hdr) + wmt_params->dlen;
+	if (hlen > 255)
+		return -EINVAL;
+
+	wc = kzalloc(hlen, GFP_KERNEL);
+	if (!wc)
+		return -ENOMEM;
+
+	hdr = &wc->hdr;
+	hdr->dir = 1;
+	hdr->op = wmt_params->op;
+	hdr->dlen = cpu_to_le16(wmt_params->dlen + 1);
+	hdr->flag = wmt_params->flag;
+	memcpy(wc->data, wmt_params->data, wmt_params->dlen);
+
+	set_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
+
+	/* WMT cmd/event doesn't follow up the generic HCI cmd/event handling,
+	 * it needs constantly polling control pipe until the host received the
+	 * WMT event, thus, we should require to specifically acquire PM counter
+	 * on the USB to prevent the interface from entering auto suspended
+	 * while WMT cmd/event in progress.
+	 */
+	err = usb_autopm_get_interface(data->intf);
+	if (err < 0)
+		goto err_free_wc;
+
+	err = __hci_cmd_send(hdev, 0xfc6f, hlen, wc);
+
+	if (err < 0) {
+		clear_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
+		usb_autopm_put_interface(data->intf);
+		goto err_free_wc;
+	}
+
+	/* Submit control IN URB on demand to process the WMT event */
+	err = btmtk_usb_submit_wmt_recv_urb(hdev);
+
+	usb_autopm_put_interface(data->intf);
+
+	if (err < 0)
+		goto err_free_wc;
+
+	/* The vendor specific WMT commands are all answered by a vendor
+	 * specific event and will have the Command Status or Command
+	 * Complete as with usual HCI command flow control.
+	 *
+	 * After sending the command, wait for BTUSB_TX_WAIT_VND_EVT
+	 * state to be cleared. The driver specific event receive routine
+	 * will clear that state and with that indicate completion of the
+	 * WMT command.
+	 */
+	err = wait_on_bit_timeout(&data->flags, BTMTK_TX_WAIT_VND_EVT,
+				  TASK_INTERRUPTIBLE, HCI_INIT_TIMEOUT);
+	if (err == -EINTR) {
+		bt_dev_err(hdev, "Execution of wmt command interrupted");
+		clear_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
+		goto err_free_wc;
+	}
+
+	if (err) {
+		bt_dev_err(hdev, "Execution of wmt command timed out");
+		clear_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
+		err = -ETIMEDOUT;
+		goto err_free_wc;
+	}
+
+	if (data->evt_skb == NULL)
+		goto err_free_wc;
+
+	/* Parse and handle the return WMT event */
+	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
+	if (wmt_evt->whdr.op != hdr->op) {
+		bt_dev_err(hdev, "Wrong op received %d expected %d",
+			   wmt_evt->whdr.op, hdr->op);
+		err = -EIO;
+		goto err_free_skb;
+	}
+
+	switch (wmt_evt->whdr.op) {
+	case BTMTK_WMT_SEMAPHORE:
+		if (wmt_evt->whdr.flag == 2)
+			status = BTMTK_WMT_PATCH_UNDONE;
+		else
+			status = BTMTK_WMT_PATCH_DONE;
+		break;
+	case BTMTK_WMT_FUNC_CTRL:
+		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
+		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
+			status = BTMTK_WMT_ON_DONE;
+		else if (be16_to_cpu(wmt_evt_funcc->status) == 0x420)
+			status = BTMTK_WMT_ON_PROGRESS;
+		else
+			status = BTMTK_WMT_ON_UNDONE;
+		break;
+	case BTMTK_WMT_PATCH_DWNLD:
+		if (wmt_evt->whdr.flag == 2)
+			status = BTMTK_WMT_PATCH_DONE;
+		else if (wmt_evt->whdr.flag == 1)
+			status = BTMTK_WMT_PATCH_PROGRESS;
+		else
+			status = BTMTK_WMT_PATCH_UNDONE;
+		break;
+	}
+
+	if (wmt_params->status)
+		*wmt_params->status = status;
+
+err_free_skb:
+	kfree_skb(data->evt_skb);
+	data->evt_skb = NULL;
+err_free_wc:
+	kfree(wc);
+	return err;
+}
+EXPORT_SYMBOL_GPL(btmtk_usb_hci_wmt_sync);
+
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
 MODULE_DESCRIPTION("Bluetooth support for MediaTek devices ver " VERSION);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index dde6fbdeb2b3..3055b9728ae2 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -28,6 +28,18 @@
 #define MTK_COREDUMP_END_LEN		(sizeof(MTK_COREDUMP_END))
 #define MTK_COREDUMP_NUM		255
 
+/* UHW CR mapping */
+#define MTK_BT_MISC		0x70002510
+#define MTK_BT_SUBSYS_RST	0x70002610
+#define MTK_UDMA_INT_STA_BT	0x74000024
+#define MTK_UDMA_INT_STA_BT1	0x74000308
+#define MTK_BT_WDT_STATUS	0x740003A0
+#define MTK_EP_RST_OPT		0x74011890
+#define MTK_EP_RST_IN_OUT_OPT	0x00010001
+#define MTK_BT_RST_DONE		0x00000100
+#define MTK_BT_RESET_REG_CONNV3	0x70028610
+#define MTK_BT_READ_DEV_ID	0x70010200
+
 enum {
 	BTMTK_WMT_PATCH_DWNLD = 0x1,
 	BTMTK_WMT_TEST = 0x2,
@@ -126,6 +138,10 @@ struct btmtk_hci_wmt_params {
 	u32 *status;
 };
 
+enum {
+	BTMTK_TX_WAIT_VND_EVT,
+};
+
 typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
 
 struct btmtk_coredump_info {
@@ -136,9 +152,15 @@ struct btmtk_coredump_info {
 };
 
 struct btmtk_data {
+	unsigned long flags;
 	u32 dev_id;
 	btmtk_reset_sync_func_t reset_sync;
 	struct btmtk_coredump_info cd_info;
+
+	struct usb_device *udev;
+	struct usb_interface *intf;
+	struct usb_anchor *ctrl_anchor;
+	struct sk_buff *evt_skb;
 };
 
 typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
@@ -163,6 +185,9 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb);
 
 void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 			   u32 fw_flavor);
+
+int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
+			   struct btmtk_hci_wmt_params *wmt_params);
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
@@ -202,4 +227,10 @@ static void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id,
 				  u32 fw_ver, u32 fw_flavor)
 {
 }
+
+static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
+				  struct btmtk_hci_wmt_params *wmt_params)
+{
+	return -EOPNOTSUPP;
+}
 #endif
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index b4e560a17aa6..39d6898497a4 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/skbuff.h>
+#include <linux/usb.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdio_ids.h>
diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index e6bc4a73c9fc..aa87c3e78871 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -22,6 +22,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
+#include <linux/usb.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4ec18b58dc68..660e528fdd94 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2641,282 +2641,6 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 	return hci_recv_frame(hdev, skb);
 }
 
-/* UHW CR mapping */
-#define MTK_BT_MISC		0x70002510
-#define MTK_BT_SUBSYS_RST	0x70002610
-#define MTK_UDMA_INT_STA_BT	0x74000024
-#define MTK_UDMA_INT_STA_BT1	0x74000308
-#define MTK_BT_WDT_STATUS	0x740003A0
-#define MTK_EP_RST_OPT		0x74011890
-#define MTK_EP_RST_IN_OUT_OPT	0x00010001
-#define MTK_BT_RST_DONE		0x00000100
-#define MTK_BT_RESET_REG_CONNV3	0x70028610
-#define MTK_BT_READ_DEV_ID	0x70010200
-
-
-static void btusb_mtk_wmt_recv(struct urb *urb)
-{
-	struct hci_dev *hdev = urb->context;
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct sk_buff *skb;
-	int err;
-
-	if (urb->status == 0 && urb->actual_length > 0) {
-		hdev->stat.byte_rx += urb->actual_length;
-
-		/* WMT event shouldn't be fragmented and the size should be
-		 * less than HCI_WMT_MAX_EVENT_SIZE.
-		 */
-		skb = bt_skb_alloc(HCI_WMT_MAX_EVENT_SIZE, GFP_ATOMIC);
-		if (!skb) {
-			hdev->stat.err_rx++;
-			kfree(urb->setup_packet);
-			return;
-		}
-
-		hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
-		skb_put_data(skb, urb->transfer_buffer, urb->actual_length);
-
-		/* When someone waits for the WMT event, the skb is being cloned
-		 * and being processed the events from there then.
-		 */
-		if (test_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags)) {
-			data->evt_skb = skb_clone(skb, GFP_ATOMIC);
-			if (!data->evt_skb) {
-				kfree_skb(skb);
-				kfree(urb->setup_packet);
-				return;
-			}
-		}
-
-		err = hci_recv_frame(hdev, skb);
-		if (err < 0) {
-			kfree_skb(data->evt_skb);
-			data->evt_skb = NULL;
-			kfree(urb->setup_packet);
-			return;
-		}
-
-		if (test_and_clear_bit(BTUSB_TX_WAIT_VND_EVT,
-				       &data->flags)) {
-			/* Barrier to sync with other CPUs */
-			smp_mb__after_atomic();
-			wake_up_bit(&data->flags,
-				    BTUSB_TX_WAIT_VND_EVT);
-		}
-		kfree(urb->setup_packet);
-		return;
-	} else if (urb->status == -ENOENT) {
-		/* Avoid suspend failed when usb_kill_urb */
-		return;
-	}
-
-	usb_mark_last_busy(data->udev);
-
-	/* The URB complete handler is still called with urb->actual_length = 0
-	 * when the event is not available, so we should keep re-submitting
-	 * URB until WMT event returns, Also, It's necessary to wait some time
-	 * between the two consecutive control URBs to relax the target device
-	 * to generate the event. Otherwise, the WMT event cannot return from
-	 * the device successfully.
-	 */
-	udelay(500);
-
-	usb_anchor_urb(urb, &data->ctrl_anchor);
-	err = usb_submit_urb(urb, GFP_ATOMIC);
-	if (err < 0) {
-		kfree(urb->setup_packet);
-		/* -EPERM: urb is being killed;
-		 * -ENODEV: device got disconnected
-		 */
-		if (err != -EPERM && err != -ENODEV)
-			bt_dev_err(hdev, "urb %p failed to resubmit (%d)",
-				   urb, -err);
-		usb_unanchor_urb(urb);
-	}
-}
-
-static int btusb_mtk_submit_wmt_recv_urb(struct hci_dev *hdev)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct usb_ctrlrequest *dr;
-	unsigned char *buf;
-	int err, size = 64;
-	unsigned int pipe;
-	struct urb *urb;
-
-	urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!urb)
-		return -ENOMEM;
-
-	dr = kmalloc(sizeof(*dr), GFP_KERNEL);
-	if (!dr) {
-		usb_free_urb(urb);
-		return -ENOMEM;
-	}
-
-	dr->bRequestType = USB_TYPE_VENDOR | USB_DIR_IN;
-	dr->bRequest     = 1;
-	dr->wIndex       = cpu_to_le16(0);
-	dr->wValue       = cpu_to_le16(48);
-	dr->wLength      = cpu_to_le16(size);
-
-	buf = kmalloc(size, GFP_KERNEL);
-	if (!buf) {
-		kfree(dr);
-		usb_free_urb(urb);
-		return -ENOMEM;
-	}
-
-	pipe = usb_rcvctrlpipe(data->udev, 0);
-
-	usb_fill_control_urb(urb, data->udev, pipe, (void *)dr,
-			     buf, size, btusb_mtk_wmt_recv, hdev);
-
-	urb->transfer_flags |= URB_FREE_BUFFER;
-
-	usb_anchor_urb(urb, &data->ctrl_anchor);
-	err = usb_submit_urb(urb, GFP_KERNEL);
-	if (err < 0) {
-		if (err != -EPERM && err != -ENODEV)
-			bt_dev_err(hdev, "urb %p submission failed (%d)",
-				   urb, -err);
-		usb_unanchor_urb(urb);
-	}
-
-	usb_free_urb(urb);
-
-	return err;
-}
-
-static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
-				  struct btmtk_hci_wmt_params *wmt_params)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct btmtk_hci_wmt_evt_funcc *wmt_evt_funcc;
-	u32 hlen, status = BTMTK_WMT_INVALID;
-	struct btmtk_hci_wmt_evt *wmt_evt;
-	struct btmtk_hci_wmt_cmd *wc;
-	struct btmtk_wmt_hdr *hdr;
-	int err;
-
-	/* Send the WMT command and wait until the WMT event returns */
-	hlen = sizeof(*hdr) + wmt_params->dlen;
-	if (hlen > 255)
-		return -EINVAL;
-
-	wc = kzalloc(hlen, GFP_KERNEL);
-	if (!wc)
-		return -ENOMEM;
-
-	hdr = &wc->hdr;
-	hdr->dir = 1;
-	hdr->op = wmt_params->op;
-	hdr->dlen = cpu_to_le16(wmt_params->dlen + 1);
-	hdr->flag = wmt_params->flag;
-	memcpy(wc->data, wmt_params->data, wmt_params->dlen);
-
-	set_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
-
-	/* WMT cmd/event doesn't follow up the generic HCI cmd/event handling,
-	 * it needs constantly polling control pipe until the host received the
-	 * WMT event, thus, we should require to specifically acquire PM counter
-	 * on the USB to prevent the interface from entering auto suspended
-	 * while WMT cmd/event in progress.
-	 */
-	err = usb_autopm_get_interface(data->intf);
-	if (err < 0)
-		goto err_free_wc;
-
-	err = __hci_cmd_send(hdev, 0xfc6f, hlen, wc);
-
-	if (err < 0) {
-		clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
-		usb_autopm_put_interface(data->intf);
-		goto err_free_wc;
-	}
-
-	/* Submit control IN URB on demand to process the WMT event */
-	err = btusb_mtk_submit_wmt_recv_urb(hdev);
-
-	usb_autopm_put_interface(data->intf);
-
-	if (err < 0)
-		goto err_free_wc;
-
-	/* The vendor specific WMT commands are all answered by a vendor
-	 * specific event and will have the Command Status or Command
-	 * Complete as with usual HCI command flow control.
-	 *
-	 * After sending the command, wait for BTUSB_TX_WAIT_VND_EVT
-	 * state to be cleared. The driver specific event receive routine
-	 * will clear that state and with that indicate completion of the
-	 * WMT command.
-	 */
-	err = wait_on_bit_timeout(&data->flags, BTUSB_TX_WAIT_VND_EVT,
-				  TASK_INTERRUPTIBLE, HCI_INIT_TIMEOUT);
-	if (err == -EINTR) {
-		bt_dev_err(hdev, "Execution of wmt command interrupted");
-		clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
-		goto err_free_wc;
-	}
-
-	if (err) {
-		bt_dev_err(hdev, "Execution of wmt command timed out");
-		clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
-		err = -ETIMEDOUT;
-		goto err_free_wc;
-	}
-
-	if (data->evt_skb == NULL)
-		goto err_free_wc;
-
-	/* Parse and handle the return WMT event */
-	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
-	if (wmt_evt->whdr.op != hdr->op) {
-		bt_dev_err(hdev, "Wrong op received %d expected %d",
-			   wmt_evt->whdr.op, hdr->op);
-		err = -EIO;
-		goto err_free_skb;
-	}
-
-	switch (wmt_evt->whdr.op) {
-	case BTMTK_WMT_SEMAPHORE:
-		if (wmt_evt->whdr.flag == 2)
-			status = BTMTK_WMT_PATCH_UNDONE;
-		else
-			status = BTMTK_WMT_PATCH_DONE;
-		break;
-	case BTMTK_WMT_FUNC_CTRL:
-		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
-		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
-			status = BTMTK_WMT_ON_DONE;
-		else if (be16_to_cpu(wmt_evt_funcc->status) == 0x420)
-			status = BTMTK_WMT_ON_PROGRESS;
-		else
-			status = BTMTK_WMT_ON_UNDONE;
-		break;
-	case BTMTK_WMT_PATCH_DWNLD:
-		if (wmt_evt->whdr.flag == 2)
-			status = BTMTK_WMT_PATCH_DONE;
-		else if (wmt_evt->whdr.flag == 1)
-			status = BTMTK_WMT_PATCH_PROGRESS;
-		else
-			status = BTMTK_WMT_PATCH_UNDONE;
-		break;
-	}
-
-	if (wmt_params->status)
-		*wmt_params->status = status;
-
-err_free_skb:
-	kfree_skb(data->evt_skb);
-	data->evt_skb = NULL;
-err_free_wc:
-	kfree(wc);
-	return err;
-}
-
 static int btusb_mtk_func_query(struct hci_dev *hdev)
 {
 	struct btmtk_hci_wmt_params wmt_params;
@@ -2930,7 +2654,7 @@ static int btusb_mtk_func_query(struct hci_dev *hdev)
 	wmt_params.data = &param;
 	wmt_params.status = &status;
 
-	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
+	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to query function status (%d)", err);
 		return err;
@@ -3251,7 +2975,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 				      fw_version, fw_flavor);
 
 		err = btmtk_setup_firmware_79xx(hdev, fw_bin_name,
-						btusb_mtk_hci_wmt_sync);
+						btmtk_usb_hci_wmt_sync);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
 			clear_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
@@ -3271,7 +2995,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 		wmt_params.data = &param;
 		wmt_params.status = NULL;
 
-		err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
+		err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
 			return err;
@@ -3293,7 +3017,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	wmt_params.data = NULL;
 	wmt_params.status = &status;
 
-	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
+	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to query firmware status (%d)", err);
 		return err;
@@ -3306,7 +3030,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 
 	/* Setup a firmware which the device definitely requires */
 	err = btmtk_setup_firmware(hdev, fwname,
-				   btusb_mtk_hci_wmt_sync);
+				   btmtk_usb_hci_wmt_sync);
 	if (err < 0)
 		return err;
 
@@ -3335,7 +3059,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	wmt_params.data = &param;
 	wmt_params.status = NULL;
 
-	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
+	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
 		return err;
@@ -3381,7 +3105,7 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
 	wmt_params.data = &param;
 	wmt_params.status = NULL;
 
-	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
+	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
 		return err;
-- 
2.18.0

