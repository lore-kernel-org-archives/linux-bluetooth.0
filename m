Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 1/3] Bluetooth: Fix hci core device initialization
Date: Sat,  8 Oct 2011 14:58:47 +0200
Message-Id: <1318078729-4158-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We must not call device_del() if we didn't use device_add(). See module.c for
comments on that. Therefore, we need to call device_initialize() when allocating
the hci device and later device_add() instead of device_register().

This also fixes a bug when hci_register_dev() failed and we call hci_free_dev()
without a valid core device. hci_free_dev() segfaults while calling put_device()
on invalid memory.

We already do this with hci_conn connections (hci_conn_init_sysfs()) so they do
not need to be fixed.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |    1 +
 net/bluetooth/hci_sysfs.c        |   18 ++++++++++++------
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5b92442..81741ac 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -597,6 +597,7 @@ int hci_recv_frame(struct sk_buff *skb);
 int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count);
 int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count);
 
+void hci_init_sysfs(struct hci_dev *hdev);
 int hci_register_sysfs(struct hci_dev *hdev);
 void hci_unregister_sysfs(struct hci_dev *hdev);
 void hci_conn_init_sysfs(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b84458d..d2445cb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -912,6 +912,7 @@ struct hci_dev *hci_alloc_dev(void)
 	if (!hdev)
 		return NULL;
 
+	hci_init_sysfs(hdev);
 	skb_queue_head_init(&hdev->driver_init);
 
 	return hdev;
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 22f1a6c..a7d5de3 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -542,6 +542,17 @@ static int auto_accept_delay_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
 					auto_accept_delay_set, "%llu\n");
 
+void hci_init_sysfs(struct hci_dev *hdev)
+{
+	struct device *dev = &hdev->dev;
+
+	dev->type = &bt_host;
+	dev->class = bt_class;
+
+	dev_set_drvdata(dev, hdev);
+	device_initialize(dev);
+}
+
 int hci_register_sysfs(struct hci_dev *hdev)
 {
 	struct device *dev = &hdev->dev;
@@ -549,15 +560,10 @@ int hci_register_sysfs(struct hci_dev *hdev)
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
-	dev->type = &bt_host;
-	dev->class = bt_class;
 	dev->parent = hdev->parent;
-
 	dev_set_name(dev, "%s", hdev->name);
 
-	dev_set_drvdata(dev, hdev);
-
-	err = device_register(dev);
+	err = device_add(dev);
 	if (err < 0)
 		return err;
 
-- 
1.7.7
