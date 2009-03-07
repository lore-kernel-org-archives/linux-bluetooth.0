Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Erik=20Andr=C3=A9n?= <erik.andren@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Erik=20Andr=C3=A9n?= <erik.andren@gmail.com>
Subject: [PATCH 2/2] Defer btaddconn and btdelconn workqueues until a device has actually connected
Date: Sat,  7 Mar 2009 23:10:29 +0100
Message-Id: <1236463829-19977-2-git-send-email-erik.andren@gmail.com>
In-Reply-To: <1236463829-19977-1-git-send-email-erik.andren@gmail.com>
References: <1>
 <1236463829-19977-1-git-send-email-erik.andren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Many distros always load the bluetooth module, even if no actual bluetooth device exists. This causes two workqueues: btaddconn and btdelconn to be
spawned at init time, clogging up the process list without performing any actual work.
This patch defers the workqueue creation until the first hci device has connected. Also, tear down the workqueues when the last device disconnects.

Signed-off-by: Erik Andrén <erik.andren@gmail.com>
---
 include/net/bluetooth/hci_core.h |    4 +-
 net/bluetooth/hci_core.c         |   11 ++++++---
 net/bluetooth/hci_sysfs.c        |   44 +++++++++++++++++++++----------------
 3 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 01f9316..b3bc9fa 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -453,8 +453,8 @@ static inline int hci_recv_frame(struct sk_buff *skb)
 
 int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count);
 
-int hci_register_sysfs(struct hci_dev *hdev);
-void hci_unregister_sysfs(struct hci_dev *hdev);
+int hci_register_sysfs(struct hci_dev *hdev, bool e);
+void hci_unregister_sysfs(struct hci_dev *hdev, bool e);
 void hci_conn_add_sysfs(struct hci_conn *conn);
 void hci_conn_del_sysfs(struct hci_conn *conn);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9c98f6e..c21753f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -843,6 +843,7 @@ int hci_register_dev(struct hci_dev *hdev)
 {
 	struct list_head *head = &hci_dev_list, *p;
 	int i, err, id = 0;
+	bool empty;
 
 	BT_DBG("%p name %s type %d owner %p", hdev, hdev->name, hdev->type, hdev->owner);
 
@@ -859,6 +860,8 @@ int hci_register_dev(struct hci_dev *hdev)
 		id++;
 	}
 
+	empty = list_empty(&hci_dev_list);
+
 	sprintf(hdev->name, "hci%d", id);
 	hdev->id = id;
 	list_add(&hdev->list, head);
@@ -896,10 +899,9 @@ int hci_register_dev(struct hci_dev *hdev)
 	memset(&hdev->stat, 0, sizeof(struct hci_dev_stats));
 
 	atomic_set(&hdev->promisc, 0);
-
 	write_unlock_bh(&hci_dev_list_lock);
 
-	err = hci_register_sysfs(hdev);
+	err = hci_register_sysfs(hdev, empty);
 	if (err < 0)
 		return err;
 
@@ -913,13 +915,14 @@ EXPORT_SYMBOL(hci_register_dev);
 int hci_unregister_dev(struct hci_dev *hdev)
 {
 	int i;
+	bool empty;
 
 	BT_DBG("%p name %s type %d", hdev, hdev->name, hdev->type);
 
 	write_lock_bh(&hci_dev_list_lock);
 	list_del(&hdev->list);
+	empty = list_empty(&hci_dev_list);
 	write_unlock_bh(&hci_dev_list_lock);
-
 	hci_dev_do_close(hdev);
 
 	for (i = 0; i < 3; i++)
@@ -927,7 +930,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_notify(hdev, HCI_DEV_UNREG);
 
-	hci_unregister_sysfs(hdev);
+	hci_unregister_sysfs(hdev, empty);
 
 	__hci_dev_put(hdev);
 
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 1a1f916..c7a48d9 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -404,7 +404,7 @@ static struct device_type bt_host = {
 	.release = bt_host_release,
 };
 
-int hci_register_sysfs(struct hci_dev *hdev)
+int hci_register_sysfs(struct hci_dev *hdev, bool e)
 {
 	struct device *dev = &hdev->dev;
 	int err;
@@ -423,42 +423,48 @@ int hci_register_sysfs(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
+	/* Check if the hci device list only contains a single, new, entry.
+	   If so, setup the workqueues */
+	if (e) {
+		btaddconn = create_singlethread_workqueue("btaddconn");
+		if (!btaddconn) {
+			device_del(&hdev->dev);
+			return -ENOMEM;
+		}
+
+		btdelconn = create_singlethread_workqueue("btdelconn");
+		if (!btdelconn) {
+			device_del(&hdev->dev);
+			destroy_workqueue(btaddconn);
+			return -ENOMEM;
+		}
+	}
 	return 0;
 }
 
-void hci_unregister_sysfs(struct hci_dev *hdev)
+void hci_unregister_sysfs(struct hci_dev *hdev, bool e)
 {
 	BT_DBG("%p name %s type %d", hdev, hdev->name, hdev->type);
 
+	/* Check if there's any hci entries left. If not then its safe
+	   to tear down the workqueues */
+	if (e) {
+		destroy_workqueue(btaddconn);
+		destroy_workqueue(btdelconn);
+	}
 	device_del(&hdev->dev);
 }
 
 int __init bt_sysfs_init(void)
 {
-	btaddconn = create_singlethread_workqueue("btaddconn");
-	if (!btaddconn)
-		return -ENOMEM;
-
-	btdelconn = create_singlethread_workqueue("btdelconn");
-	if (!btdelconn) {
-		destroy_workqueue(btaddconn);
-		return -ENOMEM;
-	}
-
 	bt_class = class_create(THIS_MODULE, "bluetooth");
-	if (IS_ERR(bt_class)) {
-		destroy_workqueue(btdelconn);
-		destroy_workqueue(btaddconn);
+	if (IS_ERR(bt_class))
 		return PTR_ERR(bt_class);
-	}
 
 	return 0;
 }
 
 void bt_sysfs_cleanup(void)
 {
-	destroy_workqueue(btaddconn);
-	destroy_workqueue(btdelconn);
-
 	class_destroy(bt_class);
 }
-- 
1.5.6.3

