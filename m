Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 3/5] Bluetooth: Remove HCI-owner field
Date: Thu, 29 Dec 2011 16:40:40 +0100
Message-Id: <1325173242-12264-4-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325173242-12264-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325173242-12264-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

After unregistering an hci_dev object a bluetooth driver does not have any
callbacks in the hci_dev structure left over. Therefore, there is no need to
keep a reference to the module.

Previously, we needed this to protect the hci-destruct callback. However, this
callback is no longer available so we do not need this owner field, anymore.
Drivers now call hci_unregister_dev() and they are done with the object.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/bfusb.c        |    2 --
 drivers/bluetooth/bluecard_cs.c  |    2 --
 drivers/bluetooth/bpa10x.c       |    2 --
 drivers/bluetooth/bt3c_cs.c      |    2 --
 drivers/bluetooth/btmrvl_main.c  |    1 -
 drivers/bluetooth/btsdio.c       |    2 --
 drivers/bluetooth/btuart_cs.c    |    2 --
 drivers/bluetooth/btusb.c        |    2 --
 drivers/bluetooth/btwilink.c     |    1 -
 drivers/bluetooth/dtl1_cs.c      |    2 --
 drivers/bluetooth/hci_ldisc.c    |    2 --
 drivers/bluetooth/hci_vhci.c     |    2 --
 include/net/bluetooth/hci_core.h |   13 ++-----------
 net/bluetooth/hci_core.c         |    3 +--
 14 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 857a951..e97f42a 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -705,8 +705,6 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	hdev->send     = bfusb_send_frame;
 	hdev->ioctl    = bfusb_ioctl;
 
-	hdev->owner = THIS_MODULE;
-
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
 		hci_free_dev(hdev);
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 5cb325a..6b1261f 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -738,8 +738,6 @@ static int bluecard_open(bluecard_info_t *info)
 	hdev->send     = bluecard_hci_send_frame;
 	hdev->ioctl    = bluecard_hci_ioctl;
 
-	hdev->owner = THIS_MODULE;
-
 	id = inb(iobase + 0x30);
 
 	if ((id & 0x0f) == 0x02)
diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 92c2424..229bdc9 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -470,8 +470,6 @@ static int bpa10x_probe(struct usb_interface *intf, const struct usb_device_id *
 	hdev->flush    = bpa10x_flush;
 	hdev->send     = bpa10x_send_frame;
 
-	hdev->owner = THIS_MODULE;
-
 	set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);
 
 	err = hci_register_dev(hdev);
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index e74334d..0e304cb 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -584,8 +584,6 @@ static int bt3c_open(bt3c_info_t *info)
 	hdev->send     = bt3c_hci_send_frame;
 	hdev->ioctl    = bt3c_hci_ioctl;
 
-	hdev->owner = THIS_MODULE;
-
 	/* Load firmware */
 	err = request_firmware(&firmware, "BT3CPCC.bin", &info->p_dev->dev);
 	if (err < 0) {
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index d62fc0d..d69c095 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -552,7 +552,6 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 	hdev->flush = btmrvl_flush;
 	hdev->send = btmrvl_send_frame;
 	hdev->ioctl = btmrvl_ioctl;
-	hdev->owner = THIS_MODULE;
 
 	btmrvl_send_module_cfg_cmd(priv, MODULE_BRINGUP_REQ);
 
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index d38945c..2d6e4ed 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -337,8 +337,6 @@ static int btsdio_probe(struct sdio_func *func,
 	hdev->flush    = btsdio_flush;
 	hdev->send     = btsdio_send_frame;
 
-	hdev->owner = THIS_MODULE;
-
 	err = hci_register_dev(hdev);
 	if (err < 0) {
 		hci_free_dev(hdev);
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 84e02f1..80ad2b9 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -502,8 +502,6 @@ static int btuart_open(btuart_info_t *info)
 	hdev->send     = btuart_hci_send_frame;
 	hdev->ioctl    = btuart_hci_ioctl;
 
-	hdev->owner = THIS_MODULE;
-
 	spin_lock_irqsave(&(info->lock), flags);
 
 	/* Reset UART */
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 85bb17d..246944e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1000,8 +1000,6 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->send     = btusb_send_frame;
 	hdev->notify   = btusb_notify;
 
-	hdev->owner = THIS_MODULE;
-
 	/* Interface numbers are hardcoded in the specification */
 	data->isoc = usb_ifnum_to_if(data->udev, 1);
 
diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index da9cf6a..b81b32e 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -317,7 +317,6 @@ static int bt_ti_probe(struct platform_device *pdev)
 	hdev->close = ti_st_close;
 	hdev->flush = NULL;
 	hdev->send = ti_st_send_frame;
-	hdev->owner = THIS_MODULE;
 
 	err = hci_register_dev(hdev);
 	if (err < 0) {
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 9cdce11..fb50b0d 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -487,8 +487,6 @@ static int dtl1_open(dtl1_info_t *info)
 	hdev->send     = dtl1_hci_send_frame;
 	hdev->ioctl    = dtl1_hci_ioctl;
 
-	hdev->owner = THIS_MODULE;
-
 	spin_lock_irqsave(&(info->lock), flags);
 
 	/* Reset UART */
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index d88dcff..2542b3f 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -391,8 +391,6 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	hdev->send  = hci_uart_send_frame;
 	hdev->parent = hu->tty->dev;
 
-	hdev->owner = THIS_MODULE;
-
 	if (!reset)
 		set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);
 
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 6ef00b7..89b5ac5 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -244,8 +244,6 @@ static int vhci_open(struct inode *inode, struct file *file)
 	hdev->flush    = vhci_flush;
 	hdev->send     = vhci_send_frame;
 
-	hdev->owner = THIS_MODULE;
-
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
 		kfree(data);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 720d81d..13f7c06 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -246,8 +246,6 @@ struct hci_dev {
 
 	struct rfkill		*rfkill;
 
-	struct module		*owner;
-
 	unsigned long		dev_flags;
 
 	int (*open)(struct hci_dev *hdev);
@@ -574,11 +572,7 @@ static inline void __hci_dev_put(struct hci_dev *d)
  * hci_dev_put and hci_dev_hold are macros to avoid dragging all the
  * overhead of all the modular infrastructure into this header.
  */
-#define hci_dev_put(d)		\
-do {				\
-	__hci_dev_put(d);	\
-	module_put(d->owner);	\
-} while (0)
+#define hci_dev_put(d) __hci_dev_put(d)
 
 static inline struct hci_dev *__hci_dev_hold(struct hci_dev *d)
 {
@@ -586,10 +580,7 @@ static inline struct hci_dev *__hci_dev_hold(struct hci_dev *d)
 	return d;
 }
 
-#define hci_dev_hold(d)						\
-({								\
-	try_module_get(d->owner) ? __hci_dev_hold(d) : NULL;	\
-})
+#define hci_dev_hold(d) __hci_dev_hold(d)
 
 #define hci_dev_lock(d)		mutex_lock(&d->lock)
 #define hci_dev_unlock(d)	mutex_unlock(&d->lock)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fb08b01..0c7e2b2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1451,8 +1451,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	struct list_head *head = &hci_dev_list, *p;
 	int i, id, error;
 
-	BT_DBG("%p name %s bus %d owner %p", hdev, hdev->name,
-						hdev->bus, hdev->owner);
+	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
 	if (!hdev->open || !hdev->close)
 		return -EINVAL;
-- 
1.7.8.1
