Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use controller workqueue to create sysfs entries for links
Date: Sun,  8 Aug 2010 23:07:31 -0400
Message-Id: <1281323251-31010-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |    3 --
 net/bluetooth/hci_sysfs.c        |   73 +++++++++++++++-----------------------
 2 files changed, 29 insertions(+), 47 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 005f9ce..cd039c9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -190,9 +190,6 @@ struct hci_conn {
 	struct timer_list disc_timer;
 	struct timer_list idle_timer;
 
-	struct work_struct work_add;
-	struct work_struct work_del;
-
 	struct device	dev;
 	atomic_t	devref;
 
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 95a8038..78c9614 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -87,11 +87,35 @@ static struct device_type bt_link = {
 	.release = bt_link_release,
 };
 
-static void add_conn(struct work_struct *work)
+/*
+ * The rfcomm tty device will possibly retain even when conn
+ * is down, and sysfs doesn't support move zombie device,
+ * so we should move the device before conn device is destroyed.
+ */
+static int __match_tty(struct device *dev, void *data)
+{
+	return !strncmp(dev_name(dev), "rfcomm", 6);
+}
+
+void hci_conn_init_sysfs(struct hci_conn *conn)
 {
-	struct hci_conn *conn = container_of(work, struct hci_conn, work_add);
 	struct hci_dev *hdev = conn->hdev;
 
+	BT_DBG("conn %p", conn);
+
+	conn->dev.type = &bt_link;
+	conn->dev.class = bt_class;
+	conn->dev.parent = &hdev->dev;
+
+	device_initialize(&conn->dev);
+}
+
+void hci_conn_add_sysfs(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+
+	BT_DBG("conn %p", conn);
+
 	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
 
 	dev_set_drvdata(&conn->dev, conn);
@@ -104,21 +128,12 @@ static void add_conn(struct work_struct *work)
 	hci_dev_hold(hdev);
 }
 
-/*
- * The rfcomm tty device will possibly retain even when conn
- * is down, and sysfs doesn't support move zombie device,
- * so we should move the device before conn device is destroyed.
- */
-static int __match_tty(struct device *dev, void *data)
-{
-	return !strncmp(dev_name(dev), "rfcomm", 6);
-}
-
-static void del_conn(struct work_struct *work)
+void hci_conn_del_sysfs(struct hci_conn *conn)
 {
-	struct hci_conn *conn = container_of(work, struct hci_conn, work_del);
 	struct hci_dev *hdev = conn->hdev;
 
+	BT_DBG("conn %p", conn);
+
 	if (!device_is_registered(&conn->dev))
 		return;
 
@@ -138,36 +153,6 @@ static void del_conn(struct work_struct *work)
 	hci_dev_put(hdev);
 }
 
-void hci_conn_init_sysfs(struct hci_conn *conn)
-{
-	struct hci_dev *hdev = conn->hdev;
-
-	BT_DBG("conn %p", conn);
-
-	conn->dev.type = &bt_link;
-	conn->dev.class = bt_class;
-	conn->dev.parent = &hdev->dev;
-
-	device_initialize(&conn->dev);
-
-	INIT_WORK(&conn->work_add, add_conn);
-	INIT_WORK(&conn->work_del, del_conn);
-}
-
-void hci_conn_add_sysfs(struct hci_conn *conn)
-{
-	BT_DBG("conn %p", conn);
-
-	queue_work(conn->hdev->workqueue, &conn->work_add);
-}
-
-void hci_conn_del_sysfs(struct hci_conn *conn)
-{
-	BT_DBG("conn %p", conn);
-
-	queue_work(conn->hdev->workqueue, &conn->work_del);
-}
-
 static inline char *host_bustostr(int bus)
 {
 	switch (bus) {
-- 
1.6.6.1

