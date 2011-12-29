Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 2/5] Bluetooth: Correctly acquire module reference
Date: Thu, 29 Dec 2011 16:40:39 +0100
Message-Id: <1325173242-12264-3-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325173242-12264-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325173242-12264-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

When creating hci_dev objects we may end up with dangling devices that some
other subsystem has a ref-count of. If the bluetooth module is unloaded while
there are still hci_dev objects around, we might end up with calling invalid
callbacks on hci_dev destruction.

This patch correctly takes a module reference for every hci_dev object so when
destroying the object we can be sure that the bluetooth module is still
available.

This is the normal procedure of all bus systems as the device core does not
provide owner-tracking.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_core.c         |    6 +++++-
 net/bluetooth/hci_sysfs.c        |    8 +++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ab97ad3..720d81d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -654,7 +654,7 @@ int hci_recv_frame(struct sk_buff *skb);
 int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count);
 int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count);
 
-void hci_init_sysfs(struct hci_dev *hdev);
+int hci_init_sysfs(struct hci_dev *hdev);
 int hci_add_sysfs(struct hci_dev *hdev);
 void hci_del_sysfs(struct hci_dev *hdev);
 void hci_conn_init_sysfs(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6fdd6e5..fb08b01 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -940,7 +940,11 @@ struct hci_dev *hci_alloc_dev(void)
 	if (!hdev)
 		return NULL;
 
-	hci_init_sysfs(hdev);
+	if (hci_init_sysfs(hdev)) {
+		kfree(hdev);
+		return NULL;
+	}
+
 	skb_queue_head_init(&hdev->driver_init);
 
 	return hdev;
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 5210956..67f75e9 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -372,6 +372,7 @@ static void bt_host_release(struct device *dev)
 {
 	void *data = dev_get_drvdata(dev);
 	kfree(data);
+	module_put(THIS_MODULE);
 }
 
 static struct device_type bt_host = {
@@ -516,15 +517,20 @@ static int auto_accept_delay_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
 					auto_accept_delay_set, "%llu\n");
 
-void hci_init_sysfs(struct hci_dev *hdev)
+int hci_init_sysfs(struct hci_dev *hdev)
 {
 	struct device *dev = &hdev->dev;
 
+	if (!try_module_get(THIS_MODULE))
+		return -EIO;
+
 	dev->type = &bt_host;
 	dev->class = bt_class;
 
 	dev_set_drvdata(dev, hdev);
 	device_initialize(dev);
+
+	return 0;
 }
 
 int hci_add_sysfs(struct hci_dev *hdev)
-- 
1.7.8.1
