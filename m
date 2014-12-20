Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Create debugfs directory for each connection handle
Date: Sat, 20 Dec 2014 17:13:41 +0100
Message-Id: <1419092021-32209-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For every internal representation of a Bluetooth connection which is
identified by hci_conn, create a debugfs directory with the handle
number as directory name.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         |  3 +++
 net/bluetooth/hci_debugfs.c      | 12 ++++++++++++
 net/bluetooth/hci_debugfs.h      |  1 +
 net/bluetooth/hci_event.c        |  5 +++++
 5 files changed, 22 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f20f6bd668bd..3e7e5110f298 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -440,6 +440,7 @@ struct hci_conn {
 	struct delayed_work le_conn_timeout;
 
 	struct device	dev;
+	struct dentry	*debugfs;
 
 	struct hci_dev	*hdev;
 	void		*l2cap_data;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4405fb352c70..75240aaca101 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -25,6 +25,7 @@
 /* Bluetooth HCI connection handling. */
 
 #include <linux/export.h>
+#include <linux/debugfs.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -547,6 +548,8 @@ int hci_conn_del(struct hci_conn *conn)
 
 	hci_conn_del_sysfs(conn);
 
+	debugfs_remove_recursive(conn->debugfs);
+
 	if (test_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags))
 		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
 
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index a7a0db03b0b8..ee33ce88d3d8 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -1062,3 +1062,15 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
 	debugfs_create_u16("discov_interleaved_timeout", 0644, hdev->debugfs,
 			   &hdev->discov_interleaved_timeout);
 }
+
+void hci_debugfs_create_conn(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+	char name[6];
+
+	if (IS_ERR_OR_NULL(hdev->debugfs))
+		return;
+
+	snprintf(name, sizeof(name), "%u", conn->handle);
+	conn->debugfs = debugfs_create_dir(name, hdev->debugfs);
+}
diff --git a/net/bluetooth/hci_debugfs.h b/net/bluetooth/hci_debugfs.h
index f191100b50c5..fb68efe083c5 100644
--- a/net/bluetooth/hci_debugfs.h
+++ b/net/bluetooth/hci_debugfs.h
@@ -23,3 +23,4 @@
 void hci_debugfs_create_common(struct hci_dev *hdev);
 void hci_debugfs_create_bredr(struct hci_dev *hdev);
 void hci_debugfs_create_le(struct hci_dev *hdev);
+void hci_debugfs_create_conn(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a3055e90a5bb..eed44c643c0c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -31,6 +31,7 @@
 #include <net/bluetooth/mgmt.h>
 
 #include "hci_request.h"
+#include "hci_debugfs.h"
 #include "a2mp.h"
 #include "amp.h"
 #include "smp.h"
@@ -2162,6 +2163,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		} else
 			conn->state = BT_CONNECTED;
 
+		hci_debugfs_create_conn(conn);
 		hci_conn_add_sysfs(conn);
 
 		if (test_bit(HCI_AUTH, &hdev->flags))
@@ -3638,6 +3640,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		conn->handle = __le16_to_cpu(ev->handle);
 		conn->state  = BT_CONNECTED;
 
+		hci_debugfs_create_conn(conn);
 		hci_conn_add_sysfs(conn);
 		break;
 
@@ -4178,6 +4181,7 @@ static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 	hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
 	hci_conn_drop(hcon);
 
+	hci_debugfs_create_conn(hcon);
 	hci_conn_add_sysfs(hcon);
 
 	amp_physical_cfm(bredr_hcon, hcon);
@@ -4384,6 +4388,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	conn->le_conn_latency = le16_to_cpu(ev->latency);
 	conn->le_supv_timeout = le16_to_cpu(ev->supervision_timeout);
 
+	hci_debugfs_create_conn(conn);
 	hci_conn_add_sysfs(conn);
 
 	hci_proto_connect_cfm(conn, ev->status);
-- 
2.1.0

