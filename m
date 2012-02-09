Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [RESEND PATCH 2/4] Bluetooth: Remove hci_dev->driver_data
Date: Thu,  9 Feb 2012 21:58:32 +0100
Message-Id: <1328821115-12514-3-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1328821115-12514-1-git-send-email-dh.herrmann@googlemail.com>
References: <1328821115-12514-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The linux device model provides dev_set/get_drvdata so we can use this
to save private driver data.
This also removes several unnecessary casts.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
Acked in: Message-ID: <1327960655.1955.179.camel@aeonflux>

 drivers/bluetooth/bfusb.c          |   10 +++++-----
 drivers/bluetooth/bluecard_cs.c    |   12 ++++++------
 drivers/bluetooth/bpa10x.c         |   18 +++++++++---------
 drivers/bluetooth/bt3c_cs.c        |    6 +++---
 drivers/bluetooth/btmrvl_debugfs.c |   26 ++++++++++++--------------
 drivers/bluetooth/btmrvl_main.c    |   11 ++++++-----
 drivers/bluetooth/btsdio.c         |   10 +++++-----
 drivers/bluetooth/btuart_cs.c      |    6 +++---
 drivers/bluetooth/btusb.c          |   28 ++++++++++++++--------------
 drivers/bluetooth/btwilink.c       |    8 ++++----
 drivers/bluetooth/dtl1_cs.c        |    6 +++---
 drivers/bluetooth/hci_ldisc.c      |    6 +++---
 drivers/bluetooth/hci_vhci.c       |    8 ++++----
 include/net/bluetooth/hci_core.h   |   11 ++++++++++-
 14 files changed, 87 insertions(+), 79 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index c7d6ff0..b8ac1c5 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -411,7 +411,7 @@ unlock:
 
 static int bfusb_open(struct hci_dev *hdev)
 {
-	struct bfusb_data *data = hdev->driver_data;
+	struct bfusb_data *data = hci_get_drvdata(hdev);
 	unsigned long flags;
 	int i, err;
 
@@ -437,7 +437,7 @@ static int bfusb_open(struct hci_dev *hdev)
 
 static int bfusb_flush(struct hci_dev *hdev)
 {
-	struct bfusb_data *data = hdev->driver_data;
+	struct bfusb_data *data = hci_get_drvdata(hdev);
 
 	BT_DBG("hdev %p bfusb %p", hdev, data);
 
@@ -448,7 +448,7 @@ static int bfusb_flush(struct hci_dev *hdev)
 
 static int bfusb_close(struct hci_dev *hdev)
 {
-	struct bfusb_data *data = hdev->driver_data;
+	struct bfusb_data *data = hci_get_drvdata(hdev);
 	unsigned long flags;
 
 	BT_DBG("hdev %p bfusb %p", hdev, data);
@@ -483,7 +483,7 @@ static int bfusb_send_frame(struct sk_buff *skb)
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return -EBUSY;
 
-	data = hdev->driver_data;
+	data = hci_get_drvdata(hdev);
 
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
@@ -696,7 +696,7 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	data->hdev = hdev;
 
 	hdev->bus = HCI_USB;
-	hdev->driver_data = data;
+	hci_set_drvdata(hdev, data);
 	SET_HCIDEV_DEV(hdev, &intf->dev);
 
 	hdev->open     = bfusb_open;
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 6b1261f..1fcd923 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -561,7 +561,7 @@ static irqreturn_t bluecard_interrupt(int irq, void *dev_inst)
 
 static int bluecard_hci_set_baud_rate(struct hci_dev *hdev, int baud)
 {
-	bluecard_info_t *info = (bluecard_info_t *)(hdev->driver_data);
+	bluecard_info_t *info = hci_get_drvdata(hdev);
 	struct sk_buff *skb;
 
 	/* Ericsson baud rate command */
@@ -609,7 +609,7 @@ static int bluecard_hci_set_baud_rate(struct hci_dev *hdev, int baud)
 
 static int bluecard_hci_flush(struct hci_dev *hdev)
 {
-	bluecard_info_t *info = (bluecard_info_t *)(hdev->driver_data);
+	bluecard_info_t *info = hci_get_drvdata(hdev);
 
 	/* Drop TX queue */
 	skb_queue_purge(&(info->txq));
@@ -620,7 +620,7 @@ static int bluecard_hci_flush(struct hci_dev *hdev)
 
 static int bluecard_hci_open(struct hci_dev *hdev)
 {
-	bluecard_info_t *info = (bluecard_info_t *)(hdev->driver_data);
+	bluecard_info_t *info = hci_get_drvdata(hdev);
 	unsigned int iobase = info->p_dev->resource[0]->start;
 
 	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
@@ -640,7 +640,7 @@ static int bluecard_hci_open(struct hci_dev *hdev)
 
 static int bluecard_hci_close(struct hci_dev *hdev)
 {
-	bluecard_info_t *info = (bluecard_info_t *)(hdev->driver_data);
+	bluecard_info_t *info = hci_get_drvdata(hdev);
 	unsigned int iobase = info->p_dev->resource[0]->start;
 
 	if (!test_and_clear_bit(HCI_RUNNING, &(hdev->flags)))
@@ -667,7 +667,7 @@ static int bluecard_hci_send_frame(struct sk_buff *skb)
 		return -ENODEV;
 	}
 
-	info = (bluecard_info_t *)(hdev->driver_data);
+	info = hci_get_drvdata(hdev);
 
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
@@ -729,7 +729,7 @@ static int bluecard_open(bluecard_info_t *info)
 	info->hdev = hdev;
 
 	hdev->bus = HCI_PCCARD;
-	hdev->driver_data = info;
+	hci_set_drvdata(hdev, info);
 	SET_HCIDEV_DEV(hdev, &info->p_dev->dev);
 
 	hdev->open     = bluecard_hci_open;
diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 9d63514..d894340 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -66,7 +66,7 @@ struct hci_vendor_hdr {
 
 static int bpa10x_recv(struct hci_dev *hdev, int queue, void *buf, int count)
 {
-	struct bpa10x_data *data = hdev->driver_data;
+	struct bpa10x_data *data = hci_get_drvdata(hdev);
 
 	BT_DBG("%s queue %d buffer %p count %d", hdev->name,
 							queue, buf, count);
@@ -189,7 +189,7 @@ done:
 static void bpa10x_rx_complete(struct urb *urb)
 {
 	struct hci_dev *hdev = urb->context;
-	struct bpa10x_data *data = hdev->driver_data;
+	struct bpa10x_data *data = hci_get_drvdata(hdev);
 	int err;
 
 	BT_DBG("%s urb %p status %d count %d", hdev->name,
@@ -219,7 +219,7 @@ static void bpa10x_rx_complete(struct urb *urb)
 
 static inline int bpa10x_submit_intr_urb(struct hci_dev *hdev)
 {
-	struct bpa10x_data *data = hdev->driver_data;
+	struct bpa10x_data *data = hci_get_drvdata(hdev);
 	struct urb *urb;
 	unsigned char *buf;
 	unsigned int pipe;
@@ -260,7 +260,7 @@ static inline int bpa10x_submit_intr_urb(struct hci_dev *hdev)
 
 static inline int bpa10x_submit_bulk_urb(struct hci_dev *hdev)
 {
-	struct bpa10x_data *data = hdev->driver_data;
+	struct bpa10x_data *data = hci_get_drvdata(hdev);
 	struct urb *urb;
 	unsigned char *buf;
 	unsigned int pipe;
@@ -301,7 +301,7 @@ static inline int bpa10x_submit_bulk_urb(struct hci_dev *hdev)
 
 static int bpa10x_open(struct hci_dev *hdev)
 {
-	struct bpa10x_data *data = hdev->driver_data;
+	struct bpa10x_data *data = hci_get_drvdata(hdev);
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -329,7 +329,7 @@ error:
 
 static int bpa10x_close(struct hci_dev *hdev)
 {
-	struct bpa10x_data *data = hdev->driver_data;
+	struct bpa10x_data *data = hci_get_drvdata(hdev);
 
 	BT_DBG("%s", hdev->name);
 
@@ -343,7 +343,7 @@ static int bpa10x_close(struct hci_dev *hdev)
 
 static int bpa10x_flush(struct hci_dev *hdev)
 {
-	struct bpa10x_data *data = hdev->driver_data;
+	struct bpa10x_data *data = hci_get_drvdata(hdev);
 
 	BT_DBG("%s", hdev->name);
 
@@ -355,7 +355,7 @@ static int bpa10x_flush(struct hci_dev *hdev)
 static int bpa10x_send_frame(struct sk_buff *skb)
 {
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
-	struct bpa10x_data *data = hdev->driver_data;
+	struct bpa10x_data *data = hci_get_drvdata(hdev);
 	struct usb_ctrlrequest *dr;
 	struct urb *urb;
 	unsigned int pipe;
@@ -459,7 +459,7 @@ static int bpa10x_probe(struct usb_interface *intf, const struct usb_device_id *
 	}
 
 	hdev->bus = HCI_USB;
-	hdev->driver_data = data;
+	hci_set_drvdata(hdev, data);
 
 	data->hdev = hdev;
 
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 0e304cb..9c09d6f 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -389,7 +389,7 @@ static irqreturn_t bt3c_interrupt(int irq, void *dev_inst)
 
 static int bt3c_hci_flush(struct hci_dev *hdev)
 {
-	bt3c_info_t *info = (bt3c_info_t *)(hdev->driver_data);
+	bt3c_info_t *info = hci_get_drvdata(hdev);
 
 	/* Drop TX queue */
 	skb_queue_purge(&(info->txq));
@@ -428,7 +428,7 @@ static int bt3c_hci_send_frame(struct sk_buff *skb)
 		return -ENODEV;
 	}
 
-	info = (bt3c_info_t *) (hdev->driver_data);
+	info = hci_get_drvdata(hdev);
 
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
@@ -575,7 +575,7 @@ static int bt3c_open(bt3c_info_t *info)
 	info->hdev = hdev;
 
 	hdev->bus = HCI_PCCARD;
-	hdev->driver_data = info;
+	hci_set_drvdata(hdev, info);
 	SET_HCIDEV_DEV(hdev, &info->p_dev->dev);
 
 	hdev->open     = bt3c_hci_open;
diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index 8ecf4c6..60fe333 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -384,7 +384,7 @@ static const struct file_operations btmrvl_txdnldready_fops = {
 
 void btmrvl_debugfs_init(struct hci_dev *hdev)
 {
-	struct btmrvl_private *priv = hdev->driver_data;
+	struct btmrvl_private *priv = hci_get_drvdata(hdev);
 	struct btmrvl_debugfs_data *dbg;
 
 	if (!hdev->debugfs)
@@ -401,36 +401,34 @@ void btmrvl_debugfs_init(struct hci_dev *hdev)
 	dbg->config_dir = debugfs_create_dir("config", hdev->debugfs);
 
 	dbg->psmode = debugfs_create_file("psmode", 0644, dbg->config_dir,
-				hdev->driver_data, &btmrvl_psmode_fops);
+				priv, &btmrvl_psmode_fops);
 	dbg->pscmd = debugfs_create_file("pscmd", 0644, dbg->config_dir,
-				hdev->driver_data, &btmrvl_pscmd_fops);
+				priv, &btmrvl_pscmd_fops);
 	dbg->gpiogap = debugfs_create_file("gpiogap", 0644, dbg->config_dir,
-				hdev->driver_data, &btmrvl_gpiogap_fops);
+				priv, &btmrvl_gpiogap_fops);
 	dbg->hsmode =  debugfs_create_file("hsmode", 0644, dbg->config_dir,
-				hdev->driver_data, &btmrvl_hsmode_fops);
+				priv, &btmrvl_hsmode_fops);
 	dbg->hscmd = debugfs_create_file("hscmd", 0644, dbg->config_dir,
-				hdev->driver_data, &btmrvl_hscmd_fops);
+				priv, &btmrvl_hscmd_fops);
 	dbg->hscfgcmd = debugfs_create_file("hscfgcmd", 0644, dbg->config_dir,
-				hdev->driver_data, &btmrvl_hscfgcmd_fops);
+				priv, &btmrvl_hscfgcmd_fops);
 
 	dbg->status_dir = debugfs_create_dir("status", hdev->debugfs);
 	dbg->curpsmode = debugfs_create_file("curpsmode", 0444,
-						dbg->status_dir,
-						hdev->driver_data,
-						&btmrvl_curpsmode_fops);
+				dbg->status_dir, priv, &btmrvl_curpsmode_fops);
 	dbg->psstate = debugfs_create_file("psstate", 0444, dbg->status_dir,
-				hdev->driver_data, &btmrvl_psstate_fops);
+				priv, &btmrvl_psstate_fops);
 	dbg->hsstate = debugfs_create_file("hsstate", 0444, dbg->status_dir,
-				hdev->driver_data, &btmrvl_hsstate_fops);
+				priv, &btmrvl_hsstate_fops);
 	dbg->txdnldready = debugfs_create_file("txdnldready", 0444,
 						dbg->status_dir,
-						hdev->driver_data,
+						priv,
 						&btmrvl_txdnldready_fops);
 }
 
 void btmrvl_debugfs_remove(struct hci_dev *hdev)
 {
-	struct btmrvl_private *priv = hdev->driver_data;
+	struct btmrvl_private *priv = hci_get_drvdata(hdev);
 	struct btmrvl_debugfs_data *dbg = priv->debugfs_data;
 
 	if (!dbg)
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 66b58fd..d1209ad 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -394,12 +394,13 @@ static int btmrvl_send_frame(struct sk_buff *skb)
 
 	BT_DBG("type=%d, len=%d", skb->pkt_type, skb->len);
 
-	if (!hdev || !hdev->driver_data) {
+	if (!hdev) {
 		BT_ERR("Frame for unknown HCI device");
 		return -ENODEV;
 	}
 
-	priv = (struct btmrvl_private *) hdev->driver_data;
+	priv = hci_get_drvdata(hdev);
+
 	if (!test_bit(HCI_RUNNING, &hdev->flags)) {
 		BT_ERR("Failed testing HCI_RUNING, flags=%lx", hdev->flags);
 		print_hex_dump_bytes("data: ", DUMP_PREFIX_OFFSET,
@@ -430,7 +431,7 @@ static int btmrvl_send_frame(struct sk_buff *skb)
 
 static int btmrvl_flush(struct hci_dev *hdev)
 {
-	struct btmrvl_private *priv = hdev->driver_data;
+	struct btmrvl_private *priv = hci_get_drvdata(hdev);
 
 	skb_queue_purge(&priv->adapter->tx_queue);
 
@@ -439,7 +440,7 @@ static int btmrvl_flush(struct hci_dev *hdev)
 
 static int btmrvl_close(struct hci_dev *hdev)
 {
-	struct btmrvl_private *priv = hdev->driver_data;
+	struct btmrvl_private *priv = hci_get_drvdata(hdev);
 
 	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
@@ -542,7 +543,7 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 	}
 
 	priv->btmrvl_dev.hcidev = hdev;
-	hdev->driver_data = priv;
+	hci_set_drvdata(hdev, priv);
 
 	hdev->bus = HCI_SDIO;
 	hdev->open = btmrvl_open;
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 2d6e4ed..e10ea03 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -189,7 +189,7 @@ static void btsdio_interrupt(struct sdio_func *func)
 
 static int btsdio_open(struct hci_dev *hdev)
 {
-	struct btsdio_data *data = hdev->driver_data;
+	struct btsdio_data *data = hci_get_drvdata(hdev);
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -225,7 +225,7 @@ release:
 
 static int btsdio_close(struct hci_dev *hdev)
 {
-	struct btsdio_data *data = hdev->driver_data;
+	struct btsdio_data *data = hci_get_drvdata(hdev);
 
 	BT_DBG("%s", hdev->name);
 
@@ -246,7 +246,7 @@ static int btsdio_close(struct hci_dev *hdev)
 
 static int btsdio_flush(struct hci_dev *hdev)
 {
-	struct btsdio_data *data = hdev->driver_data;
+	struct btsdio_data *data = hci_get_drvdata(hdev);
 
 	BT_DBG("%s", hdev->name);
 
@@ -258,7 +258,7 @@ static int btsdio_flush(struct hci_dev *hdev)
 static int btsdio_send_frame(struct sk_buff *skb)
 {
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
-	struct btsdio_data *data = hdev->driver_data;
+	struct btsdio_data *data = hci_get_drvdata(hdev);
 
 	BT_DBG("%s", hdev->name);
 
@@ -321,7 +321,7 @@ static int btsdio_probe(struct sdio_func *func,
 	}
 
 	hdev->bus = HCI_SDIO;
-	hdev->driver_data = data;
+	hci_set_drvdata(hdev, data);
 
 	if (id->class == SDIO_CLASS_BT_AMP)
 		hdev->dev_type = HCI_AMP;
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 80ad2b9..194224d 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -397,7 +397,7 @@ static void btuart_change_speed(btuart_info_t *info, unsigned int speed)
 
 static int btuart_hci_flush(struct hci_dev *hdev)
 {
-	btuart_info_t *info = (btuart_info_t *)(hdev->driver_data);
+	btuart_info_t *info = hci_get_drvdata(hdev);
 
 	/* Drop TX queue */
 	skb_queue_purge(&(info->txq));
@@ -435,7 +435,7 @@ static int btuart_hci_send_frame(struct sk_buff *skb)
 		return -ENODEV;
 	}
 
-	info = (btuart_info_t *)(hdev->driver_data);
+	info = hci_get_drvdata(hdev);
 
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
@@ -493,7 +493,7 @@ static int btuart_open(btuart_info_t *info)
 	info->hdev = hdev;
 
 	hdev->bus = HCI_PCCARD;
-	hdev->driver_data = info;
+	hci_set_drvdata(hdev, info);
 	SET_HCIDEV_DEV(hdev, &info->p_dev->dev);
 
 	hdev->open     = btuart_hci_open;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 12cb2f1..066d5ec 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -243,7 +243,7 @@ static int inc_tx(struct btusb_data *data)
 static void btusb_intr_complete(struct urb *urb)
 {
 	struct hci_dev *hdev = urb->context;
-	struct btusb_data *data = hdev->driver_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
 	int err;
 
 	BT_DBG("%s urb %p status %d count %d", hdev->name,
@@ -282,7 +282,7 @@ static void btusb_intr_complete(struct urb *urb)
 
 static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 {
-	struct btusb_data *data = hdev->driver_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct urb *urb;
 	unsigned char *buf;
 	unsigned int pipe;
@@ -331,7 +331,7 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 static void btusb_bulk_complete(struct urb *urb)
 {
 	struct hci_dev *hdev = urb->context;
-	struct btusb_data *data = hdev->driver_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
 	int err;
 
 	BT_DBG("%s urb %p status %d count %d", hdev->name,
@@ -370,7 +370,7 @@ static void btusb_bulk_complete(struct urb *urb)
 
 static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags)
 {
-	struct btusb_data *data = hdev->driver_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct urb *urb;
 	unsigned char *buf;
 	unsigned int pipe;
@@ -417,7 +417,7 @@ static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags)
 static void btusb_isoc_complete(struct urb *urb)
 {
 	struct hci_dev *hdev = urb->context;
-	struct btusb_data *data = hdev->driver_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
 	int i, err;
 
 	BT_DBG("%s urb %p status %d count %d", hdev->name,
@@ -484,7 +484,7 @@ static inline void __fill_isoc_descriptor(struct urb *urb, int len, int mtu)
 
 static int btusb_submit_isoc_urb(struct hci_dev *hdev, gfp_t mem_flags)
 {
-	struct btusb_data *data = hdev->driver_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct urb *urb;
 	unsigned char *buf;
 	unsigned int pipe;
@@ -537,7 +537,7 @@ static void btusb_tx_complete(struct urb *urb)
 {
 	struct sk_buff *skb = urb->context;
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
-	struct btusb_data *data = hdev->driver_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
 
 	BT_DBG("%s urb %p status %d count %d", hdev->name,
 					urb, urb->status, urb->actual_length);
@@ -584,7 +584,7 @@ done:
 
 static int btusb_open(struct hci_dev *hdev)
 {
-	struct btusb_data *data = hdev->driver_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -634,7 +634,7 @@ static void btusb_stop_traffic(struct btusb_data *data)
 
 static int btusb_close(struct hci_dev *hdev)
 {
-	struct btusb_data *data = hdev->driver_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -664,7 +664,7 @@ failed:
 
 static int btusb_flush(struct hci_dev *hdev)
 {
-	struct btusb_data *data = hdev->driver_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
 
 	BT_DBG("%s", hdev->name);
 
@@ -676,7 +676,7 @@ static int btusb_flush(struct hci_dev *hdev)
 static int btusb_send_frame(struct sk_buff *skb)
 {
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
-	struct btusb_data *data = hdev->driver_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct usb_ctrlrequest *dr;
 	struct urb *urb;
 	unsigned int pipe;
@@ -786,7 +786,7 @@ done:
 
 static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 {
-	struct btusb_data *data = hdev->driver_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
 
 	BT_DBG("%s evt %d", hdev->name, evt);
 
@@ -798,7 +798,7 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 
 static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
 {
-	struct btusb_data *data = hdev->driver_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct usb_interface *intf = data->isoc;
 	struct usb_endpoint_descriptor *ep_desc;
 	int i, err;
@@ -986,7 +986,7 @@ static int btusb_probe(struct usb_interface *intf,
 	}
 
 	hdev->bus = HCI_USB;
-	hdev->driver_data = data;
+	hci_set_drvdata(hdev, data);
 
 	data->hdev = hdev;
 
diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index b81b32e..8869469 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -161,7 +161,7 @@ static int ti_st_open(struct hci_dev *hdev)
 		return -EBUSY;
 
 	/* provide contexts for callbacks from ST */
-	hst = hdev->driver_data;
+	hst = hci_get_drvdata(hdev);
 
 	for (i = 0; i < MAX_BT_CHNL_IDS; i++) {
 		ti_st_proto[i].priv_data = hst;
@@ -236,7 +236,7 @@ done:
 static int ti_st_close(struct hci_dev *hdev)
 {
 	int err, i;
-	struct ti_st *hst = hdev->driver_data;
+	struct ti_st *hst = hci_get_drvdata(hdev);
 
 	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
@@ -264,7 +264,7 @@ static int ti_st_send_frame(struct sk_buff *skb)
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return -EBUSY;
 
-	hst = hdev->driver_data;
+	hst = hci_get_drvdata(hdev);
 
 	/* Prepend skb with frame type */
 	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
@@ -312,7 +312,7 @@ static int bt_ti_probe(struct platform_device *pdev)
 
 	hst->hdev = hdev;
 	hdev->bus = HCI_UART;
-	hdev->driver_data = hst;
+	hci_set_drvdata(hdev, hst);
 	hdev->open = ti_st_open;
 	hdev->close = ti_st_close;
 	hdev->flush = NULL;
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 295cf1b..049c059 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -364,7 +364,7 @@ static int dtl1_hci_open(struct hci_dev *hdev)
 
 static int dtl1_hci_flush(struct hci_dev *hdev)
 {
-	dtl1_info_t *info = (dtl1_info_t *)(hdev->driver_data);
+	dtl1_info_t *info = hci_get_drvdata(hdev);
 
 	/* Drop TX queue */
 	skb_queue_purge(&(info->txq));
@@ -396,7 +396,7 @@ static int dtl1_hci_send_frame(struct sk_buff *skb)
 		return -ENODEV;
 	}
 
-	info = (dtl1_info_t *)(hdev->driver_data);
+	info = hci_get_drvdata(hdev);
 
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
@@ -475,7 +475,7 @@ static int dtl1_open(dtl1_info_t *info)
 	info->hdev = hdev;
 
 	hdev->bus = HCI_PCCARD;
-	hdev->driver_data = info;
+	hci_set_drvdata(hdev, info);
 	SET_HCIDEV_DEV(hdev, &info->p_dev->dev);
 
 	hdev->open     = dtl1_hci_open;
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 459ff0b..01c23df 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -174,7 +174,7 @@ static int hci_uart_open(struct hci_dev *hdev)
 /* Reset device */
 static int hci_uart_flush(struct hci_dev *hdev)
 {
-	struct hci_uart *hu  = (struct hci_uart *) hdev->driver_data;
+	struct hci_uart *hu  = hci_get_drvdata(hdev);
 	struct tty_struct *tty = hu->tty;
 
 	BT_DBG("hdev %p tty %p", hdev, tty);
@@ -220,7 +220,7 @@ static int hci_uart_send_frame(struct sk_buff *skb)
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return -EBUSY;
 
-	hu = (struct hci_uart *) hdev->driver_data;
+	hu = hci_get_drvdata(hdev);
 
 	BT_DBG("%s: type %d len %d", hdev->name, bt_cb(skb)->pkt_type, skb->len);
 
@@ -384,7 +384,7 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	hu->hdev = hdev;
 
 	hdev->bus = HCI_UART;
-	hdev->driver_data = hu;
+	hci_set_drvdata(hdev, hu);
 
 	hdev->open  = hci_uart_open;
 	hdev->close = hci_uart_close;
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 5f305c1..158bfe5 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -61,7 +61,7 @@ static int vhci_open_dev(struct hci_dev *hdev)
 
 static int vhci_close_dev(struct hci_dev *hdev)
 {
-	struct vhci_data *data = hdev->driver_data;
+	struct vhci_data *data = hci_get_drvdata(hdev);
 
 	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
@@ -73,7 +73,7 @@ static int vhci_close_dev(struct hci_dev *hdev)
 
 static int vhci_flush(struct hci_dev *hdev)
 {
-	struct vhci_data *data = hdev->driver_data;
+	struct vhci_data *data = hci_get_drvdata(hdev);
 
 	skb_queue_purge(&data->readq);
 
@@ -93,7 +93,7 @@ static int vhci_send_frame(struct sk_buff *skb)
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return -EBUSY;
 
-	data = hdev->driver_data;
+	data = hci_get_drvdata(hdev);
 
 	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
 	skb_queue_tail(&data->readq, skb);
@@ -234,7 +234,7 @@ static int vhci_open(struct inode *inode, struct file *file)
 	data->hdev = hdev;
 
 	hdev->bus = HCI_VIRTUAL;
-	hdev->driver_data = data;
+	hci_set_drvdata(hdev, data);
 
 	if (amp)
 		hdev->dev_type = HCI_AMP;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 221d772..4559189 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -254,7 +254,6 @@ struct hci_dev {
 
 	struct sk_buff_head	driver_init;
 
-	void			*driver_data;
 	void			*core_data;
 
 	atomic_t		promisc;
@@ -625,6 +624,16 @@ static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
 
 #define to_hci_dev(d) container_of(d, struct hci_dev, dev)
 
+static inline void *hci_get_drvdata(struct hci_dev *hdev)
+{
+	return dev_get_drvdata(&hdev->dev);
+}
+
+static inline void hci_set_drvdata(struct hci_dev *hdev, void *data)
+{
+	dev_set_drvdata(&hdev->dev, data);
+}
+
 struct hci_dev *hci_dev_get(int index);
 struct hci_dev *hci_get_route(bdaddr_t *src, bdaddr_t *dst);
 
-- 
1.7.9
