Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Bluetooth: Remove redundant hdev->parent field
Date: Fri,  9 Mar 2012 15:53:42 +0100
Message-Id: <1331304822-426-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We initialize the "struct device" in hci_alloc_dev() for a long time now
so we can access hdev->dev.parent directly. Hence, we can drop the
temporary field hdev->parent which is used in no other place than
hci_add_sysfs().

SET_HCIDEV_DEV() is never called after registering a device by the drivers
so we do not overwrite internal device-state. Furthermore, hdev->dev is
initialized to 0 by kzalloc() inside hci_alloc_dev() so the default
behavior with dev.parent = NULL is kept.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/hci_ldisc.c    |    2 +-
 include/net/bluetooth/hci_core.h |    3 +--
 net/bluetooth/hci_sysfs.c        |    1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index fd5adb4..2f57b05 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -388,7 +388,7 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	hdev->close = hci_uart_close;
 	hdev->flush = hci_uart_flush;
 	hdev->send  = hci_uart_send_frame;
-	hdev->parent = hu->tty->dev;
+	SET_HCIDEV_DEV(hdev, hu->tty->dev);
 
 	if (test_bit(HCI_UART_RAW_DEVICE, &hu->hdev_flags))
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index daefaac..edf2fd7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -263,7 +263,6 @@ struct hci_dev {
 
 	struct dentry		*debugfs;
 
-	struct device		*parent;
 	struct device		dev;
 
 	struct rfkill		*rfkill;
@@ -708,7 +707,7 @@ void hci_conn_init_sysfs(struct hci_conn *conn);
 void hci_conn_add_sysfs(struct hci_conn *conn);
 void hci_conn_del_sysfs(struct hci_conn *conn);
 
-#define SET_HCIDEV_DEV(hdev, pdev) ((hdev)->parent = (pdev))
+#define SET_HCIDEV_DEV(hdev, pdev) ((hdev)->dev.parent = (pdev))
 
 /* ----- LMP capabilities ----- */
 #define lmp_rswitch_capable(dev)   ((dev)->features[0] & LMP_RSWITCH)
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index bc15429..60b93d8 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -533,7 +533,6 @@ int hci_add_sysfs(struct hci_dev *hdev)
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
-	dev->parent = hdev->parent;
 	dev_set_name(dev, "%s", hdev->name);
 
 	err = device_add(dev);
-- 
1.7.9.3
