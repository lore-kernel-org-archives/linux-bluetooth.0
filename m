Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Move struct hci_pinfo into net/bluetooth/hci_sock.c
Date: Fri, 11 Jul 2014 05:41:00 +0200
Message-Id: <1405050060-43569-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There exists no external user of struct hci_pinfo and hci_pi and thus
move it into the one place that is actually using it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 11 -----------
 net/bluetooth/hci_sock.c         | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e1930749fac7..fffd0da2e0fc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1349,17 +1349,6 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void mgmt_reenable_advertising(struct hci_dev *hdev);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 
-/* HCI info for socket */
-#define hci_pi(sk) ((struct hci_pinfo *) sk)
-
-struct hci_pinfo {
-	struct bt_sock    bt;
-	struct hci_dev    *hdev;
-	struct hci_filter filter;
-	__u32             cmsg_mask;
-	unsigned short   channel;
-};
-
 /* ----- HCI requests ----- */
 #define HCI_REQ_DONE	  0
 #define HCI_REQ_PEND	  1
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 0753fa4970c0..115f149362ba 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -35,6 +35,17 @@ static atomic_t monitor_promisc = ATOMIC_INIT(0);
 
 /* ----- HCI socket interface ----- */
 
+/* Socket info */
+#define hci_pi(sk) ((struct hci_pinfo *) sk)
+
+struct hci_pinfo {
+	struct bt_sock    bt;
+	struct hci_dev    *hdev;
+	struct hci_filter filter;
+	__u32             cmsg_mask;
+	unsigned short    channel;
+};
+
 static inline int hci_test_bit(int nr, void *addr)
 {
 	return *((__u32 *) addr + (nr >> 5)) & ((__u32) 1 << (nr & 31));
-- 
1.9.3

