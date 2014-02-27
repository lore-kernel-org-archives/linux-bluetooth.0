Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Add hci_copy_identity_address convenience function
Date: Thu, 27 Feb 2014 14:05:41 +0200
Message-Id: <1393502743-9995-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393502743-9995-1-git-send-email-johan.hedberg@gmail.com>
References: <1393502743-9995-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The number of places needing the local Identity Address are starting to
grow so it's better to have a single place for the logic of determining
it. This patch adds a convenience function for getting the Identity
Address and updates the two current places needing this to use it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 35 +++++++++++++++++++++++++----------
 net/bluetooth/hci_event.c        | 17 +----------------
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 853376df4f99..093d05eeb3fa 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1292,6 +1292,8 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 
 int hci_update_random_address(struct hci_request *req, bool require_privacy,
 			      u8 *own_addr_type);
+void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			       u8 *bdaddr_type);
 
 #define SCO_AIRMODE_MASK       0x0003
 #define SCO_AIRMODE_CVSD       0x0000
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bbd085d32d78..7113d4cc085f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -582,21 +582,14 @@ DEFINE_SIMPLE_ATTRIBUTE(sniff_max_interval_fops, sniff_max_interval_get,
 static int identity_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
-	bdaddr_t *addr;
+	bdaddr_t addr;
 	u8 addr_type;
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags) ||
-	    !bacmp(&hdev->bdaddr, BDADDR_ANY)) {
-		addr = &hdev->static_addr;
-		addr_type = ADDR_LE_DEV_RANDOM;
-	} else {
-		addr = &hdev->bdaddr;
-		addr_type = ADDR_LE_DEV_PUBLIC;
-	}
+	hci_copy_identity_address(hdev, &addr, &addr_type);
 
-	seq_printf(f, "%pMR (type %u) %*phN %pMR\n", addr, addr_type,
+	seq_printf(f, "%pMR (type %u) %*phN %pMR\n", &addr, addr_type,
 		   16, hdev->irk, &hdev->rpa);
 
 	hci_dev_unlock(hdev);
@@ -3636,6 +3629,28 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 	return 0;
 }
 
+/* Copy the Identity Address of the controller.
+ *
+ * If the controller has a public BD_ADDR, then by default use that one.
+ * If this is a LE only controller without a public address, default to
+ * the static random address.
+ *
+ * For debugging purposes it is possible to force controllers with a
+ * public address to use the static random address instead.
+ */
+void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			       u8 *bdaddr_type)
+{
+	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags) ||
+	    !bacmp(&hdev->bdaddr, BDADDR_ANY)) {
+		bacpy(bdaddr, &hdev->static_addr);
+		*bdaddr_type = ADDR_LE_DEV_RANDOM;
+	} else {
+		bacpy(bdaddr, &hdev->bdaddr);
+		*bdaddr_type = ADDR_LE_DEV_PUBLIC;
+	}
+}
+
 /* Alloc HCI device */
 struct hci_dev *hci_alloc_dev(void)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f26e91f72930..162235633bf5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3665,23 +3665,8 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	/* Ensure that the hci_conn contains the identity address type
 	 * regardless of which address the connection was made with.
-	 *
-	 * If the controller has a public BD_ADDR, then by default
-	 * use that one. If this is a LE only controller without
-	 * a public address, default to the static random address.
-	 *
-	 * For debugging purposes it is possible to force
-	 * controllers with a public address to use the static
-	 * random address instead.
 	 */
-	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags) ||
-	    !bacmp(&hdev->bdaddr, BDADDR_ANY)) {
-		bacpy(&conn->src, &hdev->static_addr);
-		conn->src_type = ADDR_LE_DEV_RANDOM;
-	} else {
-		bacpy(&conn->src, &hdev->bdaddr);
-		conn->src_type = ADDR_LE_DEV_PUBLIC;
-	}
+	hci_copy_identity_address(hdev, &conn->src, &conn->src_type);
 
 	/* Lookup the identity address from the stored connection
 	 * address and address type.
-- 
1.8.5.3

