Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 1/3] Bluetooth: Move hci_alloc/free_dev close to hci_register/unregister_dev
Date: Sun, 22 Apr 2012 14:39:57 +0200
Message-Id: <1335098400-24571-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

alloc() and register() (and free() and unregister()) are closely related
so move them more closely together. This will also allow to move
functionality from register() to alloc() without needing
forward-declarations.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 net/bluetooth/hci_core.c |   52 +++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2b98c33..1b9362c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1093,32 +1093,6 @@ static const struct rfkill_ops hci_rfkill_ops = {
 	.set_block = hci_rfkill_set_block,
 };
 
-/* Alloc HCI device */
-struct hci_dev *hci_alloc_dev(void)
-{
-	struct hci_dev *hdev;
-
-	hdev = kzalloc(sizeof(struct hci_dev), GFP_KERNEL);
-	if (!hdev)
-		return NULL;
-
-	hci_init_sysfs(hdev);
-	skb_queue_head_init(&hdev->driver_init);
-
-	return hdev;
-}
-EXPORT_SYMBOL(hci_alloc_dev);
-
-/* Free HCI device */
-void hci_free_dev(struct hci_dev *hdev)
-{
-	skb_queue_purge(&hdev->driver_init);
-
-	/* will free via device release */
-	put_device(&hdev->dev);
-}
-EXPORT_SYMBOL(hci_free_dev);
-
 static void hci_power_on(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, power_on);
@@ -1736,6 +1710,32 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
 	return 0;
 }
 
+/* Alloc HCI device */
+struct hci_dev *hci_alloc_dev(void)
+{
+	struct hci_dev *hdev;
+
+	hdev = kzalloc(sizeof(struct hci_dev), GFP_KERNEL);
+	if (!hdev)
+		return NULL;
+
+	hci_init_sysfs(hdev);
+	skb_queue_head_init(&hdev->driver_init);
+
+	return hdev;
+}
+EXPORT_SYMBOL(hci_alloc_dev);
+
+/* Free HCI device */
+void hci_free_dev(struct hci_dev *hdev)
+{
+	skb_queue_purge(&hdev->driver_init);
+
+	/* will free via device release */
+	put_device(&hdev->dev);
+}
+EXPORT_SYMBOL(hci_free_dev);
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
-- 
1.7.10
