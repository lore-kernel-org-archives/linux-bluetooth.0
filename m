Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 22/22] Bluetooth: Remove work_add and work_del from hci_sysfs
Date: Sat, 17 Dec 2011 19:29:42 -0200
Message-Id: <1324157382-1815-23-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-22-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-9-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-10-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-11-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-13-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-14-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-15-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-16-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-17-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-18-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-19-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-20-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-21-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-22-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

As we run in process context now we don't need worqueue to add e del from
sysfs.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/hci_core.h |    3 --
 net/bluetooth/hci_sysfs.c        |   71 ++++++++++++++-----------------------
 2 files changed, 27 insertions(+), 47 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 662877a..d10d2ba 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -300,9 +300,6 @@ struct hci_conn {
 	struct timer_list idle_timer;
 	struct timer_list auto_accept_timer;
 
-	struct work_struct work_add;
-	struct work_struct work_del;
-
 	struct device	dev;
 	atomic_t	devref;
 
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index c3c1ec8..db6af70 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -88,11 +88,35 @@ static struct device_type bt_link = {
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
+{
+	struct hci_dev *hdev = conn->hdev;
+
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
 {
-	struct hci_conn *conn = container_of(work, struct hci_conn, work_add);
 	struct hci_dev *hdev = conn->hdev;
 
+	BT_DBG("conn %p", conn);
+
 	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
 
 	dev_set_drvdata(&conn->dev, conn);
@@ -105,19 +129,8 @@ static void add_conn(struct work_struct *work)
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
 
 	if (!device_is_registered(&conn->dev))
@@ -139,36 +152,6 @@ static void del_conn(struct work_struct *work)
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
1.7.6.4

