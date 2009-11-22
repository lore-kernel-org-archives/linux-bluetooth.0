Return-Path: <cyrus@holtmann.org>
From: Aleksandar Radovanovic <biblbroks@sezampro.rs>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix struct hci_conn memory leak
Date: Sun, 22 Nov 2009 16:38:48 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200911221638.48432.biblbroks@sezampro.rs>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix struct hci_conn being leaked on unsuccessful HCI connection attempts

Signed-off-by: Aleksandar Radovanovic <biblbroks@sezampro.rs>

---

 hci_conn.c  |    2 +-
 hci_event.c |    2 --
 hci_sysfs.c |    4 +++-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff -Naur linux-2.6.31.6.orig/net/bluetooth/hci_conn.c linux-2.6.31.6/net/bluetooth/hci_conn.c
--- linux-2.6.31.6.orig/net/bluetooth/hci_conn.c	2009-11-10 00:32:31.000000000 +0000
+++ linux-2.6.31.6/net/bluetooth/hci_conn.c	2009-11-19 13:33:50.000000000 +0000
@@ -246,7 +246,7 @@
 	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_CONN_ADD);
 
-	atomic_set(&conn->devref, 0);
+	atomic_set(&conn->devref, 1);
 
 	hci_conn_init_sysfs(conn);
 
diff -Naur linux-2.6.31.6.orig/net/bluetooth/hci_event.c linux-2.6.31.6/net/bluetooth/hci_event.c
--- linux-2.6.31.6.orig/net/bluetooth/hci_event.c	2009-11-10 00:32:31.000000000 +0000
+++ linux-2.6.31.6/net/bluetooth/hci_event.c	2009-11-19 13:33:49.000000000 +0000
@@ -887,7 +887,6 @@
 		} else
 			conn->state = BT_CONNECTED;
 
-		hci_conn_hold_device(conn);
 		hci_conn_add_sysfs(conn);
 
 		if (test_bit(HCI_AUTH, &hdev->flags))
@@ -1694,7 +1693,6 @@
 		conn->handle = __le16_to_cpu(ev->handle);
 		conn->state  = BT_CONNECTED;
 
-		hci_conn_hold_device(conn);
 		hci_conn_add_sysfs(conn);
 		break;
 
diff -Naur linux-2.6.31.6.orig/net/bluetooth/hci_sysfs.c linux-2.6.31.6/net/bluetooth/hci_sysfs.c
--- linux-2.6.31.6.orig/net/bluetooth/hci_sysfs.c	2009-11-10 00:32:31.000000000 +0000
+++ linux-2.6.31.6/net/bluetooth/hci_sysfs.c	2009-11-19 14:03:47.000000000 +0000
@@ -115,8 +115,10 @@
 	struct hci_conn *conn = container_of(work, struct hci_conn, work_del);
 	struct hci_dev *hdev = conn->hdev;
 
-	if (!device_is_registered(&conn->dev))
+	if (!device_is_registered(&conn->dev)) {
+		put_device(&conn->dev);
 		return;
+	}
 
 	while (1) {
 		struct device *dev;

