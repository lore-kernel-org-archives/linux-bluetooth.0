Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 13/15] Bluetooth: Add thread-safe version of helpers
Date: Tue, 29 Oct 2013 10:25:58 -0300
Message-Id: <1383053160-10175-14-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the thread-safe version of helper functions to add
and remove pending auto connections. These helpers will be used in
next patches to implementing the Mgmt add/remove connection
parameters commands.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_core.c         | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 379bb36..2659123 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -779,8 +779,12 @@ bool hci_has_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
 			       u8 addr_type);
 int __hci_add_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
 				u8 addr_type);
+int hci_add_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
+			      u8 addr_type);
 void __hci_remove_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
 				    u8 addr_type);
+void hci_remove_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
+				  u8 addr_type);
 
 bool hci_is_scan_and_conn_supported(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 63a56f5..5d7fd3d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3029,6 +3029,18 @@ int __hci_add_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
 	return 0;
 }
 
+int hci_add_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
+			      u8 addr_type)
+{
+	int err;
+
+	hci_dev_lock(hdev);
+	err = __hci_add_pending_auto_conn(hdev, addr, addr_type);
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 /* This function requires the caller holds hdev->lock */
 void __hci_remove_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
 				    u8 addr_type)
@@ -3051,6 +3063,14 @@ void __hci_remove_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
 	}
 }
 
+void hci_remove_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
+				  u8 addr_type)
+{
+	hci_dev_lock(hdev);
+	__hci_remove_pending_auto_conn(hdev, addr, addr_type);
+	hci_dev_unlock(hdev);
+}
+
 /* This function requires the caller holds hdev->lock */
 static void __clear_pending_auto_conn(struct hci_dev *hdev)
 {
-- 
1.8.4

