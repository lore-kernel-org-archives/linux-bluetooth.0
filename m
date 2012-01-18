Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 14/15] Bluetooth: Rename hdev->flags to hdev->compat_flags
Date: Wed, 18 Jan 2012 20:51:56 +0200
Message-Id: <1326912717-6347-15-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

These flags mostly exist for legacy reasons and no new flags should be
added to this set, so compat_flags is a better name.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/bfusb.c        |   12 +++---
 drivers/bluetooth/bpa10x.c       |   12 +++---
 drivers/bluetooth/btmrvl_main.c  |    9 +++--
 drivers/bluetooth/btusb.c        |   20 +++++-----
 drivers/bluetooth/hci_ldisc.c    |    6 ++--
 drivers/bluetooth/hci_vhci.c     |    6 ++--
 include/net/bluetooth/hci.h      |    7 +---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_conn.c         |    7 ++--
 net/bluetooth/hci_core.c         |   71 +++++++++++++++++++------------------
 net/bluetooth/hci_event.c        |   43 ++++++++++++-----------
 net/bluetooth/hci_sock.c         |    8 ++--
 net/bluetooth/mgmt.c             |   38 ++++++++++----------
 13 files changed, 121 insertions(+), 120 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index e97f42a..8f77290 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -191,7 +191,7 @@ static void bfusb_tx_complete(struct urb *urb)
 
 	atomic_dec(&data->pending_tx);
 
-	if (!test_bit(HCI_RUNNING, &data->hdev->flags))
+	if (!test_bit(HCI_RUNNING, &data->hdev->compat_flags))
 		return;
 
 	if (!urb->status)
@@ -352,7 +352,7 @@ static void bfusb_rx_complete(struct urb *urb)
 
 	read_lock(&data->lock);
 
-	if (!test_bit(HCI_RUNNING, &data->hdev->flags))
+	if (!test_bit(HCI_RUNNING, &data->hdev->compat_flags))
 		goto unlock;
 
 	if (urb->status || !count)
@@ -417,7 +417,7 @@ static int bfusb_open(struct hci_dev *hdev)
 
 	BT_DBG("hdev %p bfusb %p", hdev, data);
 
-	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
+	if (test_and_set_bit(HCI_RUNNING, &hdev->compat_flags))
 		return 0;
 
 	write_lock_irqsave(&data->lock, flags);
@@ -427,7 +427,7 @@ static int bfusb_open(struct hci_dev *hdev)
 		for (i = 1; i < BFUSB_MAX_BULK_RX; i++)
 			bfusb_rx_submit(data, NULL);
 	} else {
-		clear_bit(HCI_RUNNING, &hdev->flags);
+		clear_bit(HCI_RUNNING, &hdev->compat_flags);
 	}
 
 	write_unlock_irqrestore(&data->lock, flags);
@@ -453,7 +453,7 @@ static int bfusb_close(struct hci_dev *hdev)
 
 	BT_DBG("hdev %p bfusb %p", hdev, data);
 
-	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_and_clear_bit(HCI_RUNNING, &hdev->compat_flags))
 		return 0;
 
 	write_lock_irqsave(&data->lock, flags);
@@ -480,7 +480,7 @@ static int bfusb_send_frame(struct sk_buff *skb)
 		return -ENODEV;
 	}
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_bit(HCI_RUNNING, &hdev->compat_flags))
 		return -EBUSY;
 
 	data = hdev->driver_data;
diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 229bdc9..b82b594 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -172,7 +172,7 @@ static void bpa10x_tx_complete(struct urb *urb)
 	BT_DBG("%s urb %p status %d count %d", hdev->name,
 					urb, urb->status, urb->actual_length);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_bit(HCI_RUNNING, &hdev->compat_flags))
 		goto done;
 
 	if (!urb->status)
@@ -195,7 +195,7 @@ static void bpa10x_rx_complete(struct urb *urb)
 	BT_DBG("%s urb %p status %d count %d", hdev->name,
 					urb, urb->status, urb->actual_length);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_bit(HCI_RUNNING, &hdev->compat_flags))
 		return;
 
 	if (urb->status == 0) {
@@ -306,7 +306,7 @@ static int bpa10x_open(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
+	if (test_and_set_bit(HCI_RUNNING, &hdev->compat_flags))
 		return 0;
 
 	err = bpa10x_submit_intr_urb(hdev);
@@ -322,7 +322,7 @@ static int bpa10x_open(struct hci_dev *hdev)
 error:
 	usb_kill_anchored_urbs(&data->rx_anchor);
 
-	clear_bit(HCI_RUNNING, &hdev->flags);
+	clear_bit(HCI_RUNNING, &hdev->compat_flags);
 
 	return err;
 }
@@ -333,7 +333,7 @@ static int bpa10x_close(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_and_clear_bit(HCI_RUNNING, &hdev->compat_flags))
 		return 0;
 
 	usb_kill_anchored_urbs(&data->rx_anchor);
@@ -363,7 +363,7 @@ static int bpa10x_send_frame(struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_bit(HCI_RUNNING, &hdev->compat_flags))
 		return -EBUSY;
 
 	urb = usb_alloc_urb(0, GFP_ATOMIC);
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index d69c095..2292b4d 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -400,8 +400,9 @@ static int btmrvl_send_frame(struct sk_buff *skb)
 	}
 
 	priv = (struct btmrvl_private *) hdev->driver_data;
-	if (!test_bit(HCI_RUNNING, &hdev->flags)) {
-		BT_ERR("Failed testing HCI_RUNING, flags=%lx", hdev->flags);
+	if (!test_bit(HCI_RUNNING, &hdev->compat_flags)) {
+		BT_ERR("Failed testing HCI_RUNING, flags=%lx",
+							hdev->compat_flags);
 		print_hex_dump_bytes("data: ", DUMP_PREFIX_OFFSET,
 							skb->data, skb->len);
 		return -EBUSY;
@@ -441,7 +442,7 @@ static int btmrvl_close(struct hci_dev *hdev)
 {
 	struct btmrvl_private *priv = hdev->driver_data;
 
-	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_and_clear_bit(HCI_RUNNING, &hdev->compat_flags))
 		return 0;
 
 	skb_queue_purge(&priv->adapter->tx_queue);
@@ -451,7 +452,7 @@ static int btmrvl_close(struct hci_dev *hdev)
 
 static int btmrvl_open(struct hci_dev *hdev)
 {
-	set_bit(HCI_RUNNING, &hdev->flags);
+	set_bit(HCI_RUNNING, &hdev->compat_flags);
 
 	return 0;
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 559b475..26e7ab9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -248,7 +248,7 @@ static void btusb_intr_complete(struct urb *urb)
 	BT_DBG("%s urb %p status %d count %d", hdev->name,
 					urb, urb->status, urb->actual_length);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_bit(HCI_RUNNING, &hdev->compat_flags))
 		return;
 
 	if (urb->status == 0) {
@@ -336,7 +336,7 @@ static void btusb_bulk_complete(struct urb *urb)
 	BT_DBG("%s urb %p status %d count %d", hdev->name,
 					urb, urb->status, urb->actual_length);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_bit(HCI_RUNNING, &hdev->compat_flags))
 		return;
 
 	if (urb->status == 0) {
@@ -422,7 +422,7 @@ static void btusb_isoc_complete(struct urb *urb)
 	BT_DBG("%s urb %p status %d count %d", hdev->name,
 					urb, urb->status, urb->actual_length);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_bit(HCI_RUNNING, &hdev->compat_flags))
 		return;
 
 	if (urb->status == 0) {
@@ -541,7 +541,7 @@ static void btusb_tx_complete(struct urb *urb)
 	BT_DBG("%s urb %p status %d count %d", hdev->name,
 					urb, urb->status, urb->actual_length);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_bit(HCI_RUNNING, &hdev->compat_flags))
 		goto done;
 
 	if (!urb->status)
@@ -567,7 +567,7 @@ static void btusb_isoc_tx_complete(struct urb *urb)
 	BT_DBG("%s urb %p status %d count %d", hdev->name,
 					urb, urb->status, urb->actual_length);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_bit(HCI_RUNNING, &hdev->compat_flags))
 		goto done;
 
 	if (!urb->status)
@@ -594,7 +594,7 @@ static int btusb_open(struct hci_dev *hdev)
 
 	data->intf->needs_remote_wakeup = 1;
 
-	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
+	if (test_and_set_bit(HCI_RUNNING, &hdev->compat_flags))
 		goto done;
 
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
@@ -619,7 +619,7 @@ done:
 
 failed:
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
-	clear_bit(HCI_RUNNING, &hdev->flags);
+	clear_bit(HCI_RUNNING, &hdev->compat_flags);
 	usb_autopm_put_interface(data->intf);
 	return err;
 }
@@ -638,7 +638,7 @@ static int btusb_close(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_and_clear_bit(HCI_RUNNING, &hdev->compat_flags))
 		return 0;
 
 	cancel_work_sync(&data->work);
@@ -683,7 +683,7 @@ static int btusb_send_frame(struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_bit(HCI_RUNNING, &hdev->compat_flags))
 		return -EBUSY;
 
 	switch (bt_cb(skb)->pkt_type) {
@@ -1153,7 +1153,7 @@ static int btusb_resume(struct usb_interface *intf)
 	if (--data->suspend_count)
 		return 0;
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_bit(HCI_RUNNING, &hdev->compat_flags))
 		goto done;
 
 	if (test_bit(BTUSB_INTR_RUNNING, &data->flags)) {
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 459ff0b..9087366 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -166,7 +166,7 @@ static int hci_uart_open(struct hci_dev *hdev)
 
 	/* Nothing to do for UART driver */
 
-	set_bit(HCI_RUNNING, &hdev->flags);
+	set_bit(HCI_RUNNING, &hdev->compat_flags);
 
 	return 0;
 }
@@ -198,7 +198,7 @@ static int hci_uart_close(struct hci_dev *hdev)
 {
 	BT_DBG("hdev %p", hdev);
 
-	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_and_clear_bit(HCI_RUNNING, &hdev->compat_flags))
 		return 0;
 
 	hci_uart_flush(hdev);
@@ -217,7 +217,7 @@ static int hci_uart_send_frame(struct sk_buff *skb)
 		return -ENODEV;
 	}
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_bit(HCI_RUNNING, &hdev->compat_flags))
 		return -EBUSY;
 
 	hu = (struct hci_uart *) hdev->driver_data;
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 5f305c1..912716b 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -54,7 +54,7 @@ struct vhci_data {
 
 static int vhci_open_dev(struct hci_dev *hdev)
 {
-	set_bit(HCI_RUNNING, &hdev->flags);
+	set_bit(HCI_RUNNING, &hdev->compat_flags);
 
 	return 0;
 }
@@ -63,7 +63,7 @@ static int vhci_close_dev(struct hci_dev *hdev)
 {
 	struct vhci_data *data = hdev->driver_data;
 
-	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_and_clear_bit(HCI_RUNNING, &hdev->compat_flags))
 		return 0;
 
 	skb_queue_purge(&data->readq);
@@ -90,7 +90,7 @@ static int vhci_send_frame(struct sk_buff *skb)
 		return -ENODEV;
 	}
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
+	if (!test_bit(HCI_RUNNING, &hdev->compat_flags))
 		return -EBUSY;
 
 	data = hdev->driver_data;
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index cb9097a..8797c3f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -63,7 +63,7 @@ enum {
 	HCI_QUIRK_FIXUP_BUFFER_SIZE
 };
 
-/* HCI device flags */
+/* hdev->compat_flags */
 enum {
 	HCI_UP,
 	HCI_INIT,
@@ -80,10 +80,7 @@ enum {
 	HCI_RESET,
 };
 
-/*
- * BR/EDR and/or LE controller flags: the flags defined here should represent
- * states from the controller.
- */
+/* hdev->dev_flags */
 enum {
 	HCI_SETUP,
 	HCI_AUTO_OFF,
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ab1a626..c972406 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -131,7 +131,7 @@ struct hci_dev {
 	struct mutex	lock;
 
 	char		name[8];
-	unsigned long	flags;
+	unsigned long	compat_flags;
 	__u16		id;
 	__u8		bus;
 	__u8		dev_type;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4fb7b4f..450511b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -320,7 +320,7 @@ static void hci_conn_enter_sniff_mode(struct hci_conn *conn)
 
 	BT_DBG("conn %p mode %d", conn, conn->mode);
 
-	if (test_bit(HCI_RAW, &hdev->flags))
+	if (test_bit(HCI_RAW, &hdev->compat_flags))
 		return;
 
 	if (!lmp_sniff_capable(hdev) || !lmp_sniff_capable(conn))
@@ -491,7 +491,8 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 	read_lock(&hci_dev_list_lock);
 
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (!test_bit(HCI_UP, &d->flags) || test_bit(HCI_RAW, &d->flags))
+		if (!test_bit(HCI_UP, &d->compat_flags) ||
+					test_bit(HCI_RAW, &d->compat_flags))
 			continue;
 
 		/* Simple routing:
@@ -771,7 +772,7 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 
 	BT_DBG("conn %p mode %d", conn, conn->mode);
 
-	if (test_bit(HCI_RAW, &hdev->flags))
+	if (test_bit(HCI_RAW, &hdev->compat_flags))
 		return;
 
 	if (conn->mode != HCI_CM_SNIFF)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a7b7200..ff01f0a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -98,7 +98,8 @@ void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result)
 	/* If this is the init phase check if the completed command matches
 	 * the last init command, and if not just return.
 	 */
-	if (test_bit(HCI_INIT, &hdev->flags) && hdev->init_last_cmd != cmd)
+	if (test_bit(HCI_INIT, &hdev->compat_flags) &&
+						hdev->init_last_cmd != cmd)
 		return;
 
 	if (hdev->req_status == HCI_REQ_PEND) {
@@ -167,7 +168,7 @@ static inline int hci_request(struct hci_dev *hdev, void (*req)(struct hci_dev *
 {
 	int ret;
 
-	if (!test_bit(HCI_UP, &hdev->flags))
+	if (!test_bit(HCI_UP, &hdev->compat_flags))
 		return -ENETDOWN;
 
 	/* Serialize all requests */
@@ -183,7 +184,7 @@ static void hci_reset_req(struct hci_dev *hdev, unsigned long opt)
 	BT_DBG("%s %ld", hdev->name, opt);
 
 	/* Reset device */
-	set_bit(HCI_RESET, &hdev->flags);
+	set_bit(HCI_RESET, &hdev->compat_flags);
 	hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
 }
 
@@ -199,7 +200,7 @@ static void bredr_init(struct hci_dev *hdev)
 
 	/* Reset */
 	if (!test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
-		set_bit(HCI_RESET, &hdev->flags);
+		set_bit(HCI_RESET, &hdev->compat_flags);
 		hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
 	}
 
@@ -561,7 +562,7 @@ static void hci_inq_req(struct hci_dev *hdev, unsigned long opt)
 
 	BT_DBG("%s", hdev->name);
 
-	if (test_bit(HCI_INQUIRY, &hdev->flags))
+	if (test_bit(HCI_INQUIRY, &hdev->compat_flags))
 		return;
 
 	/* Start Inquiry */
@@ -657,27 +658,27 @@ int hci_dev_open(__u16 dev)
 		goto done;
 	}
 
-	if (test_bit(HCI_UP, &hdev->flags)) {
+	if (test_bit(HCI_UP, &hdev->compat_flags)) {
 		ret = -EALREADY;
 		goto done;
 	}
 
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
-		set_bit(HCI_RAW, &hdev->flags);
+		set_bit(HCI_RAW, &hdev->compat_flags);
 
 	/* Treat all non BR/EDR controllers as raw devices if
 	   enable_hs is not set */
 	if (hdev->dev_type != HCI_BREDR && !enable_hs)
-		set_bit(HCI_RAW, &hdev->flags);
+		set_bit(HCI_RAW, &hdev->compat_flags);
 
 	if (hdev->open(hdev)) {
 		ret = -EIO;
 		goto done;
 	}
 
-	if (!test_bit(HCI_RAW, &hdev->flags)) {
+	if (!test_bit(HCI_RAW, &hdev->compat_flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
-		set_bit(HCI_INIT, &hdev->flags);
+		set_bit(HCI_INIT, &hdev->compat_flags);
 		hdev->init_last_cmd = 0;
 
 		ret = __hci_request(hdev, hci_init_req, 0,
@@ -687,12 +688,12 @@ int hci_dev_open(__u16 dev)
 			ret = __hci_request(hdev, hci_le_init_req, 0,
 					msecs_to_jiffies(HCI_INIT_TIMEOUT));
 
-		clear_bit(HCI_INIT, &hdev->flags);
+		clear_bit(HCI_INIT, &hdev->compat_flags);
 	}
 
 	if (!ret) {
 		hci_dev_hold(hdev);
-		set_bit(HCI_UP, &hdev->flags);
+		set_bit(HCI_UP, &hdev->compat_flags);
 		hci_notify(hdev, HCI_DEV_UP);
 		if (!test_bit(HCI_SETUP, &hdev->dev_flags)) {
 			hci_dev_lock(hdev);
@@ -717,7 +718,7 @@ int hci_dev_open(__u16 dev)
 		}
 
 		hdev->close(hdev);
-		hdev->flags = 0;
+		hdev->compat_flags = 0;
 	}
 
 done:
@@ -733,7 +734,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	hci_req_cancel(hdev, ENODEV);
 	hci_req_lock(hdev);
 
-	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
+	if (!test_and_clear_bit(HCI_UP, &hdev->compat_flags)) {
 		del_timer_sync(&hdev->cmd_timer);
 		hci_req_unlock(hdev);
 		return 0;
@@ -767,11 +768,11 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	/* Reset device */
 	skb_queue_purge(&hdev->cmd_q);
 	atomic_set(&hdev->cmd_cnt, 1);
-	if (!test_bit(HCI_RAW, &hdev->flags)) {
-		set_bit(HCI_INIT, &hdev->flags);
+	if (!test_bit(HCI_RAW, &hdev->compat_flags)) {
+		set_bit(HCI_INIT, &hdev->compat_flags);
 		__hci_request(hdev, hci_reset_req, 0,
 					msecs_to_jiffies(HCI_INIT_TIMEOUT));
-		clear_bit(HCI_INIT, &hdev->flags);
+		clear_bit(HCI_INIT, &hdev->compat_flags);
 	}
 
 	/* flush cmd  work */
@@ -798,7 +799,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	hci_dev_unlock(hdev);
 
 	/* Clear flags */
-	hdev->flags = 0;
+	hdev->compat_flags = 0;
 
 	hci_req_unlock(hdev);
 
@@ -830,7 +831,7 @@ int hci_dev_reset(__u16 dev)
 
 	hci_req_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags))
+	if (!test_bit(HCI_UP, &hdev->compat_flags))
 		goto done;
 
 	/* Drop queues */
@@ -848,7 +849,7 @@ int hci_dev_reset(__u16 dev)
 	atomic_set(&hdev->cmd_cnt, 1);
 	hdev->acl_cnt = 0; hdev->sco_cnt = 0; hdev->le_cnt = 0;
 
-	if (!test_bit(HCI_RAW, &hdev->flags))
+	if (!test_bit(HCI_RAW, &hdev->compat_flags))
 		ret = __hci_request(hdev, hci_reset_req, 0,
 					msecs_to_jiffies(HCI_INIT_TIMEOUT));
 
@@ -899,7 +900,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 			break;
 		}
 
-		if (!test_bit(HCI_AUTH, &hdev->flags)) {
+		if (!test_bit(HCI_AUTH, &hdev->compat_flags)) {
 			/* Auth must be enabled first */
 			err = hci_request(hdev, hci_auth_req, dr.dev_opt,
 					msecs_to_jiffies(HCI_INIT_TIMEOUT));
@@ -980,7 +981,7 @@ int hci_get_dev_list(void __user *arg)
 			set_bit(HCI_PAIRABLE, &hdev->dev_flags);
 
 		(dr + n)->dev_id  = hdev->id;
-		(dr + n)->dev_opt = hdev->flags;
+		(dr + n)->dev_opt = hdev->compat_flags;
 
 		if (++n >= dev_num)
 			break;
@@ -1018,7 +1019,7 @@ int hci_get_dev_info(void __user *arg)
 	strcpy(di.name, hdev->name);
 	di.bdaddr   = hdev->bdaddr;
 	di.type     = (hdev->bus & 0x0f) | (hdev->dev_type << 4);
-	di.flags    = hdev->flags;
+	di.flags    = hdev->compat_flags;
 	di.pkt_type = hdev->pkt_type;
 	di.acl_mtu  = hdev->acl_mtu;
 	di.acl_pkts = hdev->acl_pkts;
@@ -1599,7 +1600,7 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	mutex_init(&hdev->lock);
 
-	hdev->flags = 0;
+	hdev->compat_flags = 0;
 	hdev->dev_flags = 0;
 	hdev->pkt_type  = (HCI_DM1 | HCI_DH1 | HCI_HV1);
 	hdev->esco_type = (ESCO_HV1);
@@ -1711,7 +1712,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	for (i = 0; i < NUM_REASSEMBLY; i++)
 		kfree_skb(hdev->reassembly[i]);
 
-	if (!test_bit(HCI_INIT, &hdev->flags) &&
+	if (!test_bit(HCI_INIT, &hdev->compat_flags) &&
 				!test_bit(HCI_SETUP, &hdev->dev_flags)) {
 		hci_dev_lock(hdev);
 		mgmt_index_removed(hdev);
@@ -1767,8 +1768,8 @@ EXPORT_SYMBOL(hci_resume_dev);
 int hci_recv_frame(struct sk_buff *skb)
 {
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
-	if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
-				&& !test_bit(HCI_INIT, &hdev->flags))) {
+	if (!hdev || (!test_bit(HCI_UP, &hdev->compat_flags)
+				&& !test_bit(HCI_INIT, &hdev->compat_flags))) {
 		kfree_skb(skb);
 		return -ENXIO;
 	}
@@ -2027,7 +2028,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
 	skb->dev = (void *) hdev;
 
-	if (test_bit(HCI_INIT, &hdev->flags))
+	if (test_bit(HCI_INIT, &hdev->compat_flags))
 		hdev->init_last_cmd = opcode;
 
 	skb_queue_tail(&hdev->cmd_q, skb);
@@ -2372,7 +2373,7 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 	if (!hci_conn_num(hdev, ACL_LINK))
 		return;
 
-	if (!test_bit(HCI_RAW, &hdev->flags)) {
+	if (!test_bit(HCI_RAW, &hdev->compat_flags)) {
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
 		if (!hdev->acl_cnt && time_after(jiffies, hdev->acl_last_tx +
@@ -2469,7 +2470,7 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 	if (!hci_conn_num(hdev, LE_LINK))
 		return;
 
-	if (!test_bit(HCI_RAW, &hdev->flags)) {
+	if (!test_bit(HCI_RAW, &hdev->compat_flags)) {
 		/* LE tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
 		if (!hdev->le_cnt && hdev->le_pkts &&
@@ -2613,12 +2614,12 @@ static void hci_rx_work(struct work_struct *work)
 			hci_send_to_sock(hdev, skb, NULL);
 		}
 
-		if (test_bit(HCI_RAW, &hdev->flags)) {
+		if (test_bit(HCI_RAW, &hdev->compat_flags)) {
 			kfree_skb(skb);
 			continue;
 		}
 
-		if (test_bit(HCI_INIT, &hdev->flags)) {
+		if (test_bit(HCI_INIT, &hdev->compat_flags)) {
 			/* Don't process data packets in this states. */
 			switch (bt_cb(skb)->pkt_type) {
 			case HCI_ACLDATA_PKT:
@@ -2671,7 +2672,7 @@ static void hci_cmd_work(struct work_struct *work)
 		if (hdev->sent_cmd) {
 			atomic_dec(&hdev->cmd_cnt);
 			hci_send_frame(skb);
-			if (test_bit(HCI_RESET, &hdev->flags))
+			if (test_bit(HCI_RESET, &hdev->compat_flags))
 				del_timer(&hdev->cmd_timer);
 			else
 				mod_timer(&hdev->cmd_timer,
@@ -2691,7 +2692,7 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length)
 
 	BT_DBG("%s", hdev->name);
 
-	if (test_bit(HCI_INQUIRY, &hdev->flags))
+	if (test_bit(HCI_INQUIRY, &hdev->compat_flags))
 		return -EINPROGRESS;
 
 	inquiry_cache_flush(hdev);
@@ -2707,7 +2708,7 @@ int hci_cancel_inquiry(struct hci_dev *hdev)
 {
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_INQUIRY, &hdev->flags))
+	if (!test_bit(HCI_INQUIRY, &hdev->compat_flags))
 		return -EPERM;
 
 	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d469b99..6817c52 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -62,7 +62,7 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	clear_bit(HCI_INQUIRY, &hdev->flags);
+	clear_bit(HCI_INQUIRY, &hdev->compat_flags);
 
 	hci_dev_lock(hdev);
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
@@ -191,7 +191,7 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	clear_bit(HCI_RESET, &hdev->flags);
+	clear_bit(HCI_RESET, &hdev->compat_flags);
 
 	hci_req_complete(hdev, HCI_OP_RESET, status);
 
@@ -248,9 +248,9 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
 		__u8 param = *((__u8 *) sent);
 
 		if (param == AUTH_ENABLED)
-			set_bit(HCI_AUTH, &hdev->flags);
+			set_bit(HCI_AUTH, &hdev->compat_flags);
 		else
-			clear_bit(HCI_AUTH, &hdev->flags);
+			clear_bit(HCI_AUTH, &hdev->compat_flags);
 	}
 
 	hci_req_complete(hdev, HCI_OP_WRITE_AUTH_ENABLE, status);
@@ -271,9 +271,9 @@ static void hci_cc_write_encrypt_mode(struct hci_dev *hdev, struct sk_buff *skb)
 		__u8 param = *((__u8 *) sent);
 
 		if (param)
-			set_bit(HCI_ENCRYPT, &hdev->flags);
+			set_bit(HCI_ENCRYPT, &hdev->compat_flags);
 		else
-			clear_bit(HCI_ENCRYPT, &hdev->flags);
+			clear_bit(HCI_ENCRYPT, &hdev->compat_flags);
 	}
 
 	hci_req_complete(hdev, HCI_OP_WRITE_ENCRYPT_MODE, status);
@@ -301,11 +301,11 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 		goto done;
 	}
 
-	old_pscan = test_and_clear_bit(HCI_PSCAN, &hdev->flags);
-	old_iscan = test_and_clear_bit(HCI_ISCAN, &hdev->flags);
+	old_pscan = test_and_clear_bit(HCI_PSCAN, &hdev->compat_flags);
+	old_iscan = test_and_clear_bit(HCI_ISCAN, &hdev->compat_flags);
 
 	if (param & SCAN_INQUIRY) {
-		set_bit(HCI_ISCAN, &hdev->flags);
+		set_bit(HCI_ISCAN, &hdev->compat_flags);
 		if (!old_iscan)
 			mgmt_discoverable(hdev, 1);
 		if (hdev->discov_timeout > 0) {
@@ -317,7 +317,7 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 		mgmt_discoverable(hdev, 0);
 
 	if (param & SCAN_PAGE) {
-		set_bit(HCI_PSCAN, &hdev->flags);
+		set_bit(HCI_PSCAN, &hdev->compat_flags);
 		if (!old_pscan)
 			mgmt_connectable(hdev, 1);
 	} else if (old_pscan)
@@ -430,9 +430,9 @@ static void hci_cc_read_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 
 	if (rp->mode)
-		set_bit(HCI_SSP_ENABLED, &hdev->flags);
+		set_bit(HCI_SSP_ENABLED, &hdev->compat_flags);
 	else
-		clear_bit(HCI_SSP_ENABLED, &hdev->flags);
+		clear_bit(HCI_SSP_ENABLED, &hdev->compat_flags);
 }
 
 static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
@@ -450,9 +450,9 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 
 	if (*(u8 *) sent)
-		set_bit(HCI_SSP_ENABLED, &hdev->flags);
+		set_bit(HCI_SSP_ENABLED, &hdev->compat_flags);
 	else
-		clear_bit(HCI_SSP_ENABLED, &hdev->flags);
+		clear_bit(HCI_SSP_ENABLED, &hdev->compat_flags);
 }
 
 static u8 hci_get_inquiry_mode(struct hci_dev *hdev)
@@ -613,7 +613,7 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 					hdev->manufacturer,
 					hdev->hci_ver, hdev->hci_rev);
 
-	if (test_bit(HCI_INIT, &hdev->flags))
+	if (test_bit(HCI_INIT, &hdev->compat_flags))
 		hci_setup(hdev);
 }
 
@@ -646,7 +646,8 @@ static void hci_cc_read_local_commands(struct hci_dev *hdev, struct sk_buff *skb
 
 	memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
 
-	if (test_bit(HCI_INIT, &hdev->flags) && (hdev->commands[5] & 0x10))
+	if (test_bit(HCI_INIT, &hdev->compat_flags) &&
+						(hdev->commands[5] & 0x10))
 		hci_setup_link_policy(hdev);
 
 done:
@@ -1123,7 +1124,7 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 		return;
 	}
 
-	set_bit(HCI_INQUIRY, &hdev->flags);
+	set_bit(HCI_INQUIRY, &hdev->compat_flags);
 
 	hci_dev_lock(hdev);
 	hci_discovery_set_state(hdev, DISCOVERY_INQUIRY);
@@ -1582,7 +1583,7 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	hci_conn_check_pending(hdev);
 
-	if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
+	if (!test_and_clear_bit(HCI_INQUIRY, &hdev->compat_flags))
 		return;
 
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
@@ -1678,10 +1679,10 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 		hci_conn_hold_device(conn);
 		hci_conn_add_sysfs(conn);
 
-		if (test_bit(HCI_AUTH, &hdev->flags))
+		if (test_bit(HCI_AUTH, &hdev->compat_flags))
 			conn->link_mode |= HCI_LM_AUTH;
 
-		if (test_bit(HCI_ENCRYPT, &hdev->flags))
+		if (test_bit(HCI_ENCRYPT, &hdev->compat_flags))
 			conn->link_mode |= HCI_LM_ENCRYPT;
 
 		/* Get remote features */
@@ -2346,7 +2347,7 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (ev->opcode != HCI_OP_NOP)
 		del_timer(&hdev->cmd_timer);
 
-	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
+	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->compat_flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
 		if (!skb_queue_empty(&hdev->cmd_q))
 			queue_work(hdev->workqueue, &hdev->cmd_work);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 896a72f..98001e6 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -231,9 +231,9 @@ static inline int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd, unsign
 			return -EPERM;
 
 		if (arg)
-			set_bit(HCI_RAW, &hdev->flags);
+			set_bit(HCI_RAW, &hdev->compat_flags);
 		else
-			clear_bit(HCI_RAW, &hdev->flags);
+			clear_bit(HCI_RAW, &hdev->compat_flags);
 
 		return 0;
 
@@ -506,7 +506,7 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 		goto done;
 	}
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!test_bit(HCI_UP, &hdev->compat_flags)) {
 		err = -ENETDOWN;
 		goto done;
 	}
@@ -536,7 +536,7 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 			goto drop;
 		}
 
-		if (test_bit(HCI_RAW, &hdev->flags) || (ogf == 0x3f)) {
+		if (test_bit(HCI_RAW, &hdev->compat_flags) || (ogf == 0x3f)) {
 			skb_queue_tail(&hdev->raw_q, skb);
 			queue_work(hdev->workqueue, &hdev->tx_work);
 		} else {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8d5f8b9..de07f7c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -274,15 +274,15 @@ static u32 get_current_settings(struct hci_dev *hdev)
 {
 	u32 settings = 0;
 
-	if (test_bit(HCI_UP, &hdev->flags))
+	if (test_bit(HCI_UP, &hdev->compat_flags))
 		settings |= MGMT_SETTING_POWERED;
 	else
 		return settings;
 
-	if (test_bit(HCI_PSCAN, &hdev->flags))
+	if (test_bit(HCI_PSCAN, &hdev->compat_flags))
 		settings |= MGMT_SETTING_CONNECTABLE;
 
-	if (test_bit(HCI_ISCAN, &hdev->flags))
+	if (test_bit(HCI_ISCAN, &hdev->compat_flags))
 		settings |= MGMT_SETTING_DISCOVERABLE;
 
 	if (test_bit(HCI_PAIRABLE, &hdev->dev_flags))
@@ -294,10 +294,10 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (hdev->host_features[0] & LMP_HOST_LE)
 		settings |= MGMT_SETTING_LE;
 
-	if (test_bit(HCI_AUTH, &hdev->flags))
+	if (test_bit(HCI_AUTH, &hdev->compat_flags))
 		settings |= MGMT_SETTING_LINK_SECURITY;
 
-	if (test_bit(HCI_SSP_ENABLED, &hdev->flags))
+	if (test_bit(HCI_SSP_ENABLED, &hdev->compat_flags))
 		settings |= MGMT_SETTING_SSP;
 
 	return settings;
@@ -416,7 +416,7 @@ static int update_eir(struct hci_dev *hdev)
 	if (!(hdev->features[6] & LMP_EXT_INQ))
 		return 0;
 
-	if (!test_bit(HCI_SSP_ENABLED, &hdev->flags))
+	if (!test_bit(HCI_SSP_ENABLED, &hdev->compat_flags))
 		return 0;
 
 	if (test_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
@@ -633,7 +633,7 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	up = test_bit(HCI_UP, &hdev->flags);
+	up = test_bit(HCI_UP, &hdev->compat_flags);
 	if ((cp->val && up) || (!cp->val && !up)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_POWERED, hdev);
 		goto failed;
@@ -688,7 +688,7 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!test_bit(HCI_UP, &hdev->compat_flags)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
@@ -701,8 +701,8 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 		goto failed;
 	}
 
-	if (cp->val == test_bit(HCI_ISCAN, &hdev->flags) &&
-					test_bit(HCI_PSCAN, &hdev->flags)) {
+	if (cp->val == test_bit(HCI_ISCAN, &hdev->compat_flags) &&
+				test_bit(HCI_PSCAN, &hdev->compat_flags)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_DISCOVERABLE, hdev);
 		goto failed;
 	}
@@ -758,7 +758,7 @@ static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!test_bit(HCI_UP, &hdev->compat_flags)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
@@ -771,7 +771,7 @@ static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
 		goto failed;
 	}
 
-	if (cp->val == test_bit(HCI_PSCAN, &hdev->flags)) {
+	if (cp->val == test_bit(HCI_PSCAN, &hdev->compat_flags)) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_CONNECTABLE, hdev);
 		goto failed;
 	}
@@ -1119,7 +1119,7 @@ static int remove_keys(struct sock *sk, u16 index, unsigned char *data,
 		goto unlock;
 	}
 
-	if (!test_bit(HCI_UP, &hdev->flags) || !cp->disconnect) {
+	if (!test_bit(HCI_UP, &hdev->compat_flags) || !cp->disconnect) {
 		err = cmd_complete(sk, index, MGMT_OP_REMOVE_KEYS, &rp,
 								sizeof(rp));
 		goto unlock;
@@ -1178,7 +1178,7 @@ static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!test_bit(HCI_UP, &hdev->compat_flags)) {
 		err = cmd_status(sk, index, MGMT_OP_DISCONNECT,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
@@ -1340,7 +1340,7 @@ static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!test_bit(HCI_UP, &hdev->compat_flags)) {
 		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
@@ -1409,7 +1409,7 @@ static int pin_code_neg_reply(struct sock *sk, u16 index, unsigned char *data,
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!test_bit(HCI_UP, &hdev->compat_flags)) {
 		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
@@ -1609,7 +1609,7 @@ static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!test_bit(HCI_UP, &hdev->compat_flags)) {
 		err = cmd_status(sk, index, mgmt_op, MGMT_STATUS_NOT_POWERED);
 		goto done;
 	}
@@ -1789,7 +1789,7 @@ static int read_local_oob_data(struct sock *sk, u16 index)
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!test_bit(HCI_UP, &hdev->compat_flags)) {
 		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
 						MGMT_STATUS_NOT_POWERED);
 		goto unlock;
@@ -1914,7 +1914,7 @@ static int start_discovery(struct sock *sk, u16 index,
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!test_bit(HCI_UP, &hdev->compat_flags)) {
 		err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
-- 
1.7.8.3

