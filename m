Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/10] Bluetooth: Move hci_amp_capable() function into L2CAP core
Date: Sat,  5 Oct 2013 11:47:48 -0700
Message-Id: <1380998869-64411-9-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_amp_capable() function has only a single user inside the L2CAP
core. Instead of exporting the function, place it next to its user.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 16 ----------------
 net/bluetooth/l2cap_core.c       | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 86e2dbe..0791544 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -797,22 +797,6 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_host_le_capable(dev)   (!!((dev)->features[1][0] & LMP_HOST_LE))
 #define lmp_host_le_br_capable(dev) (!!((dev)->features[1][0] & LMP_HOST_LE_BREDR))
 
-/* returns true if at least one AMP active */
-static inline bool hci_amp_capable(void)
-{
-	struct hci_dev *hdev;
-	bool ret = false;
-
-	read_lock(&hci_dev_list_lock);
-	list_for_each_entry(hdev, &hci_dev_list, list)
-		if (hdev->amp_type != AMP_TYPE_BREDR &&
-		    test_bit(HCI_UP, &hdev->flags))
-			ret = true;
-	read_unlock(&hci_dev_list_lock);
-
-	return ret;
-}
-
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b0208e2..2efdb17 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1012,6 +1012,22 @@ static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
 	return !test_bit(CONF_CONNECT_PEND, &chan->conf_state);
 }
 
+/* returns true if at least one AMP active */
+static inline bool hci_amp_capable(void)
+{
+	struct hci_dev *hdev;
+	bool ret = false;
+
+	read_lock(&hci_dev_list_lock);
+	list_for_each_entry(hdev, &hci_dev_list, list)
+		if (hdev->amp_type != AMP_TYPE_BREDR &&
+		    test_bit(HCI_UP, &hdev->flags))
+			ret = true;
+	read_unlock(&hci_dev_list_lock);
+
+	return ret;
+}
+
 static bool __amp_capable(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
-- 
1.8.3.1

