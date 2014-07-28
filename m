Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/5] Bluetooth: Fix updating whitelist state for existing connections
Date: Mon, 28 Jul 2014 15:10:14 +0300
Message-Id: <1406549416-9229-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1406549416-9229-1-git-send-email-johan.hedberg@gmail.com>
References: <1406549416-9229-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If Add/Remove device is called while we have an existing connection we
should update the corresponding flag for that connection instead of
modifying hdev->whitelist. This patch adds the necessary code to the
respective mgmt command handlers along with a helper function to update
the whitelist flag for any existing connection.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3824975c3486..4f56855c1fbb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5223,6 +5223,26 @@ unlock:
 	return err;
 }
 
+static bool set_conn_whitelist(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			       bool set)
+{
+	struct hci_conn *conn;
+
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
+	if (!conn)
+		return false;
+
+	if (conn->state != BT_CONNECTED && conn->state != BT_CONFIG)
+		return false;
+
+	if (set)
+		set_bit(HCI_CONN_WHITELIST, &conn->flags);
+	else
+		clear_bit(HCI_CONN_WHITELIST, &conn->flags);
+
+	return true;
+}
+
 /* Helper for Add/Remove Device commands */
 static void update_page_scan(struct hci_dev *hdev, u8 scan)
 {
@@ -5289,10 +5309,16 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
-		update_scan = list_empty(&hdev->whitelist);
+		if (set_conn_whitelist(hdev, &cp->addr.bdaddr, true)) {
+			update_scan = false;
+			err = 0;
+		} else {
+			update_scan = list_empty(&hdev->whitelist);
+			err = hci_bdaddr_list_add(&hdev->whitelist,
+						  &cp->addr.bdaddr,
+						  cp->addr.type);
+		}
 
-		err = hci_bdaddr_list_add(&hdev->whitelist, &cp->addr.bdaddr,
-					  cp->addr.type);
 		if (err)
 			goto unlock;
 
@@ -5372,6 +5398,11 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			err = hci_bdaddr_list_del(&hdev->whitelist,
 						  &cp->addr.bdaddr,
 						  cp->addr.type);
+
+			if (err && set_conn_whitelist(hdev, &cp->addr.bdaddr,
+						      false))
+				err = 0;
+
 			if (err) {
 				err = cmd_complete(sk, hdev->id,
 						   MGMT_OP_REMOVE_DEVICE,
-- 
1.9.3

