Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 1/4] Bluetooth: Remove obsolete hci-destruct callback
Date: Fri, 28 Oct 2011 15:00:01 +0200
Message-Id: <1319806804-12230-2-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1319806804-12230-1-git-send-email-dh.herrmann@googlemail.com>
References: <1319806804-12230-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The destruct-callback is used by *all* drivers to remove their platform
data only. However, all drivers call hci_unregister_dev() before this
callback is executed. Therefore, there is no reason to keep platform
data alive after the driver was unregistered.

Some drivers already depend on this behaviour, since they erroneously
already free the data after calling hci_free_dev(). This patch makes all
drivers behave that way and removes the callback entirely.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/bfusb.c        |   11 +----------
 drivers/bluetooth/bluecard_cs.c  |    6 ------
 drivers/bluetooth/bpa10x.c       |   15 +++------------
 drivers/bluetooth/bt3c_cs.c      |    6 ------
 drivers/bluetooth/btmrvl_main.c  |    5 -----
 drivers/bluetooth/btsdio.c       |   11 +----------
 drivers/bluetooth/btuart_cs.c    |    6 ------
 drivers/bluetooth/btusb.c        |   11 +----------
 drivers/bluetooth/btwilink.c     |    9 ---------
 drivers/bluetooth/dtl1_cs.c      |    6 ------
 drivers/bluetooth/hci_ldisc.c    |   11 +----------
 drivers/bluetooth/hci_vhci.c     |    7 +------
 include/net/bluetooth/hci_core.h |    4 +---
 net/bluetooth/hci_core.c         |    2 +-
 14 files changed, 10 insertions(+), 100 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 005919a..876d081 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -544,15 +544,6 @@ static int bfusb_send_frame(struct sk_buff *skb)
 	return 0;
 }
 
-static void bfusb_destruct(struct hci_dev *hdev)
-{
-	struct bfusb_data *data = hdev->driver_data;
-
-	BT_DBG("hdev %p bfusb %p", hdev, data);
-
-	kfree(data);
-}
-
 static int bfusb_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned long arg)
 {
 	return -ENOIOCTLCMD;
@@ -711,7 +702,6 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	hdev->close    = bfusb_close;
 	hdev->flush    = bfusb_flush;
 	hdev->send     = bfusb_send_frame;
-	hdev->destruct = bfusb_destruct;
 	hdev->ioctl    = bfusb_ioctl;
 
 	hdev->owner = THIS_MODULE;
@@ -754,6 +744,7 @@ static void bfusb_disconnect(struct usb_interface *intf)
 		BT_ERR("Can't unregister HCI device %s", hdev->name);
 
 	hci_free_dev(hdev);
+	kfree(data);
 }
 
 static struct usb_driver bfusb_driver = {
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index aed1904..c395937 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -691,11 +691,6 @@ static int bluecard_hci_send_frame(struct sk_buff *skb)
 }
 
 
-static void bluecard_hci_destruct(struct hci_dev *hdev)
-{
-}
-
-
 static int bluecard_hci_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned long arg)
 {
 	return -ENOIOCTLCMD;
@@ -741,7 +736,6 @@ static int bluecard_open(bluecard_info_t *info)
 	hdev->close    = bluecard_hci_close;
 	hdev->flush    = bluecard_hci_flush;
 	hdev->send     = bluecard_hci_send_frame;
-	hdev->destruct = bluecard_hci_destruct;
 	hdev->ioctl    = bluecard_hci_ioctl;
 
 	hdev->owner = THIS_MODULE;
diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 751b338..92c2424 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -432,17 +432,6 @@ static int bpa10x_send_frame(struct sk_buff *skb)
 	return 0;
 }
 
-static void bpa10x_destruct(struct hci_dev *hdev)
-{
-	struct bpa10x_data *data = hdev->driver_data;
-
-	BT_DBG("%s", hdev->name);
-
-	kfree_skb(data->rx_skb[0]);
-	kfree_skb(data->rx_skb[1]);
-	kfree(data);
-}
-
 static int bpa10x_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct bpa10x_data *data;
@@ -480,7 +469,6 @@ static int bpa10x_probe(struct usb_interface *intf, const struct usb_device_id *
 	hdev->close    = bpa10x_close;
 	hdev->flush    = bpa10x_flush;
 	hdev->send     = bpa10x_send_frame;
-	hdev->destruct = bpa10x_destruct;
 
 	hdev->owner = THIS_MODULE;
 
@@ -512,6 +500,9 @@ static void bpa10x_disconnect(struct usb_interface *intf)
 	hci_unregister_dev(data->hdev);
 
 	hci_free_dev(data->hdev);
+	kfree_skb(data->rx_skb[0]);
+	kfree_skb(data->rx_skb[1]);
+	kfree(data);
 }
 
 static struct usb_driver bpa10x_driver = {
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 4fc0194..8c031a1 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -456,11 +456,6 @@ static int bt3c_hci_send_frame(struct sk_buff *skb)
 }
 
 
-static void bt3c_hci_destruct(struct hci_dev *hdev)
-{
-}
-
-
 static int bt3c_hci_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned long arg)
 {
 	return -ENOIOCTLCMD;
@@ -587,7 +582,6 @@ static int bt3c_open(bt3c_info_t *info)
 	hdev->close    = bt3c_hci_close;
 	hdev->flush    = bt3c_hci_flush;
 	hdev->send     = bt3c_hci_send_frame;
-	hdev->destruct = bt3c_hci_destruct;
 	hdev->ioctl    = bt3c_hci_ioctl;
 
 	hdev->owner = THIS_MODULE;
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 548d1d9..efb8d34 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -385,10 +385,6 @@ static int btmrvl_ioctl(struct hci_dev *hdev,
 	return -ENOIOCTLCMD;
 }
 
-static void btmrvl_destruct(struct hci_dev *hdev)
-{
-}
-
 static int btmrvl_send_frame(struct sk_buff *skb)
 {
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
@@ -553,7 +549,6 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 	hdev->close = btmrvl_close;
 	hdev->flush = btmrvl_flush;
 	hdev->send = btmrvl_send_frame;
-	hdev->destruct = btmrvl_destruct;
 	hdev->ioctl = btmrvl_ioctl;
 	hdev->owner = THIS_MODULE;
 
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 792e32d..d38945c 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -289,15 +289,6 @@ static int btsdio_send_frame(struct sk_buff *skb)
 	return 0;
 }
 
-static void btsdio_destruct(struct hci_dev *hdev)
-{
-	struct btsdio_data *data = hdev->driver_data;
-
-	BT_DBG("%s", hdev->name);
-
-	kfree(data);
-}
-
 static int btsdio_probe(struct sdio_func *func,
 				const struct sdio_device_id *id)
 {
@@ -345,7 +336,6 @@ static int btsdio_probe(struct sdio_func *func,
 	hdev->close    = btsdio_close;
 	hdev->flush    = btsdio_flush;
 	hdev->send     = btsdio_send_frame;
-	hdev->destruct = btsdio_destruct;
 
 	hdev->owner = THIS_MODULE;
 
@@ -378,6 +368,7 @@ static void btsdio_remove(struct sdio_func *func)
 	hci_unregister_dev(hdev);
 
 	hci_free_dev(hdev);
+	kfree(data);
 }
 
 static struct sdio_driver btsdio_driver = {
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 526b618..fed50c7 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -459,11 +459,6 @@ static int btuart_hci_send_frame(struct sk_buff *skb)
 }
 
 
-static void btuart_hci_destruct(struct hci_dev *hdev)
-{
-}
-
-
 static int btuart_hci_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned long arg)
 {
 	return -ENOIOCTLCMD;
@@ -505,7 +500,6 @@ static int btuart_open(btuart_info_t *info)
 	hdev->close    = btuart_hci_close;
 	hdev->flush    = btuart_hci_flush;
 	hdev->send     = btuart_hci_send_frame;
-	hdev->destruct = btuart_hci_destruct;
 	hdev->ioctl    = btuart_hci_ioctl;
 
 	hdev->owner = THIS_MODULE;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9cbac6b..7f50838 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -778,15 +778,6 @@ done:
 	return err;
 }
 
-static void btusb_destruct(struct hci_dev *hdev)
-{
-	struct btusb_data *data = hdev->driver_data;
-
-	BT_DBG("%s", hdev->name);
-
-	kfree(data);
-}
-
 static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 {
 	struct btusb_data *data = hdev->driver_data;
@@ -999,7 +990,6 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->close    = btusb_close;
 	hdev->flush    = btusb_flush;
 	hdev->send     = btusb_send_frame;
-	hdev->destruct = btusb_destruct;
 	hdev->notify   = btusb_notify;
 
 	hdev->owner = THIS_MODULE;
@@ -1103,6 +1093,7 @@ static void btusb_disconnect(struct usb_interface *intf)
 	__hci_dev_put(hdev);
 
 	hci_free_dev(hdev);
+	kfree(data);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 04d353f..22a1f01 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -290,14 +290,6 @@ static int ti_st_send_frame(struct sk_buff *skb)
 	return 0;
 }
 
-static void ti_st_destruct(struct hci_dev *hdev)
-{
-	BT_DBG("%s", hdev->name);
-	/* do nothing here, since platform remove
-	 * would free the hdev->driver_data
-	 */
-}
-
 static int bt_ti_probe(struct platform_device *pdev)
 {
 	static struct ti_st *hst;
@@ -324,7 +316,6 @@ static int bt_ti_probe(struct platform_device *pdev)
 	hdev->close = ti_st_close;
 	hdev->flush = NULL;
 	hdev->send = ti_st_send_frame;
-	hdev->destruct = ti_st_destruct;
 	hdev->owner = THIS_MODULE;
 
 	err = hci_register_dev(hdev);
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 5e4c2de..002e891 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -442,11 +442,6 @@ static int dtl1_hci_send_frame(struct sk_buff *skb)
 }
 
 
-static void dtl1_hci_destruct(struct hci_dev *hdev)
-{
-}
-
-
 static int dtl1_hci_ioctl(struct hci_dev *hdev, unsigned int cmd,  unsigned long arg)
 {
 	return -ENOIOCTLCMD;
@@ -490,7 +485,6 @@ static int dtl1_open(dtl1_info_t *info)
 	hdev->close    = dtl1_hci_close;
 	hdev->flush    = dtl1_hci_flush;
 	hdev->send     = dtl1_hci_send_frame;
-	hdev->destruct = dtl1_hci_destruct;
 	hdev->ioctl    = dtl1_hci_ioctl;
 
 	hdev->owner = THIS_MODULE;
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 48ad2a7..d88dcff 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -231,15 +231,6 @@ static int hci_uart_send_frame(struct sk_buff *skb)
 	return 0;
 }
 
-static void hci_uart_destruct(struct hci_dev *hdev)
-{
-	if (!hdev)
-		return;
-
-	BT_DBG("%s", hdev->name);
-	kfree(hdev->driver_data);
-}
-
 /* ------ LDISC part ------ */
 /* hci_uart_tty_open
  * 
@@ -316,6 +307,7 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 				hci_free_dev(hdev);
 			}
 		}
+		kfree(hu);
 	}
 }
 
@@ -397,7 +389,6 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	hdev->close = hci_uart_close;
 	hdev->flush = hci_uart_flush;
 	hdev->send  = hci_uart_send_frame;
-	hdev->destruct = hci_uart_destruct;
 	hdev->parent = hu->tty->dev;
 
 	hdev->owner = THIS_MODULE;
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 67c180c..ba77d00 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -101,11 +101,6 @@ static int vhci_send_frame(struct sk_buff *skb)
 	return 0;
 }
 
-static void vhci_destruct(struct hci_dev *hdev)
-{
-	kfree(hdev->driver_data);
-}
-
 static inline ssize_t vhci_get_user(struct vhci_data *data,
 					const char __user *buf, size_t count)
 {
@@ -243,7 +238,6 @@ static int vhci_open(struct inode *inode, struct file *file)
 	hdev->close    = vhci_close_dev;
 	hdev->flush    = vhci_flush;
 	hdev->send     = vhci_send_frame;
-	hdev->destruct = vhci_destruct;
 
 	hdev->owner = THIS_MODULE;
 
@@ -269,6 +263,7 @@ static int vhci_release(struct inode *inode, struct file *file)
 	}
 
 	hci_free_dev(hdev);
+	kfree(data);
 
 	file->private_data = NULL;
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9ef26fa..13a62ad 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -232,7 +232,6 @@ struct hci_dev {
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
 	int (*send)(struct sk_buff *skb);
-	void (*destruct)(struct hci_dev *hdev);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
 };
@@ -494,8 +493,7 @@ static inline void hci_conn_put(struct hci_conn *conn)
 /* ----- HCI Devices ----- */
 static inline void __hci_dev_put(struct hci_dev *d)
 {
-	if (atomic_dec_and_test(&d->refcnt))
-		d->destruct(d);
+	atomic_dec(&d->refcnt);
 }
 
 static inline void hci_dev_put(struct hci_dev *d)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f0e0f8e..daa948f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1449,7 +1449,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	BT_DBG("%p name %s bus %d owner %p", hdev, hdev->name,
 						hdev->bus, hdev->owner);
 
-	if (!hdev->open || !hdev->close || !hdev->destruct)
+	if (!hdev->open || !hdev->close)
 		return -EINVAL;
 
 	write_lock_bh(&hci_dev_list_lock);
-- 
1.7.7.1
