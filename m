Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 2/3] Bluetooth: Rename sysfs un/register to add/del
Date: Sat,  8 Oct 2011 14:58:48 +0200
Message-Id: <1318078729-4158-2-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1318078729-4158-1-git-send-email-dh.herrmann@googlemail.com>
References: <1318078729-4158-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

As we introduced hci_init_sysfs() we should also rename hci_register_sysfs() and
hci_unregister_sysfs() to hci_add_sysfs() and hci_del_sysfs() like we do with
hci_conn_add/del_sysfs(). It looks more consistent now.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 include/net/bluetooth/hci_core.h |    4 ++--
 net/bluetooth/hci_core.c         |    4 ++--
 net/bluetooth/hci_sysfs.c        |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 81741ac..2d03b0b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -598,8 +598,8 @@ int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count);
 int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count);
 
 void hci_init_sysfs(struct hci_dev *hdev);
-int hci_register_sysfs(struct hci_dev *hdev);
-void hci_unregister_sysfs(struct hci_dev *hdev);
+int hci_add_sysfs(struct hci_dev *hdev);
+void hci_del_sysfs(struct hci_dev *hdev);
 void hci_conn_init_sysfs(struct hci_conn *conn);
 void hci_conn_add_sysfs(struct hci_conn *conn);
 void hci_conn_del_sysfs(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d2445cb..4975578 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1506,7 +1506,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (!hdev->workqueue)
 		goto nomem;
 
-	hci_register_sysfs(hdev);
+	hci_add_sysfs(hdev);
 
 	hdev->rfkill = rfkill_alloc(hdev->name, &hdev->dev,
 				RFKILL_TYPE_BLUETOOTH, &hci_rfkill_ops, hdev);
@@ -1561,7 +1561,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 		rfkill_destroy(hdev->rfkill);
 	}
 
-	hci_unregister_sysfs(hdev);
+	hci_del_sysfs(hdev);
 
 	hci_del_off_timer(hdev);
 	del_timer(&hdev->adv_timer);
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index a7d5de3..1f9f876 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -553,7 +553,7 @@ void hci_init_sysfs(struct hci_dev *hdev)
 	device_initialize(dev);
 }
 
-int hci_register_sysfs(struct hci_dev *hdev)
+int hci_add_sysfs(struct hci_dev *hdev)
 {
 	struct device *dev = &hdev->dev;
 	int err;
@@ -587,7 +587,7 @@ int hci_register_sysfs(struct hci_dev *hdev)
 	return 0;
 }
 
-void hci_unregister_sysfs(struct hci_dev *hdev)
+void hci_del_sysfs(struct hci_dev *hdev)
 {
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
-- 
1.7.7
