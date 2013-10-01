Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Refactor hci_connect_le
Date: Tue,  1 Oct 2013 20:03:54 -0300
Message-Id: <1380668636-30654-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
References: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch organizes hci_connect_le() logic and adds extra comments
to improve code's readability.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 54 ++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b89522f..d2409dc 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -531,34 +531,44 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	if (test_bit(HCI_LE_PERIPHERAL, &hdev->flags))
 		return ERR_PTR(-ENOTSUPP);
 
+	/* If already exists a hci_conn object for the following connection
+	 * attempt, we simply update pending_sec_level and auth_type fields
+	 * and return the object found.
+	 */
 	le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
-	if (!le) {
-		le = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
-		if (le)
-			return ERR_PTR(-EBUSY);
-
-		le = hci_conn_add(hdev, LE_LINK, dst);
-		if (!le)
-			return ERR_PTR(-ENOMEM);
-
-		le->dst_type = bdaddr_to_le(dst_type);
-		le->state = BT_CONNECT;
-		le->out = true;
-		le->link_mode |= HCI_LM_MASTER;
-		le->sec_level = BT_SECURITY_LOW;
-
-		err = hci_initiate_le_connection(hdev, &le->dst, le->dst_type);
-		if (err) {
-			hci_conn_del(le);
-			return ERR_PTR(err);
-		}
+	if (le) {
+		le->pending_sec_level = sec_level;
+		le->auth_type = auth_type;
+		goto out;
 	}
 
-	le->pending_sec_level = sec_level;
+	/* Since the controller supports only one LE connection attempt at the
+	 * time, we return busy if there is any connection attempt running.
+	 */
+	le = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+	if (le)
+		return ERR_PTR(-EBUSY);
+
+	le = hci_conn_add(hdev, LE_LINK, dst);
+	if (!le)
+		return ERR_PTR(-ENOMEM);
+
+	le->dst_type = bdaddr_to_le(dst_type);
+	le->state = BT_CONNECT;
+	le->out = true;
+	le->link_mode |= HCI_LM_MASTER;
+	le->sec_level = BT_SECURITY_LOW;
+	le->pending_sec_level = BT_SECURITY_LOW;
 	le->auth_type = auth_type;
 
-	hci_conn_hold(le);
+	err = hci_initiate_le_connection(hdev, &le->dst, le->dst_type);
+	if (err) {
+		hci_conn_del(le);
+		return ERR_PTR(err);
+	}
 
+out:
+	hci_conn_hold(le);
 	return le;
 }
 
-- 
1.8.4

