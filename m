Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 1/5] Bluetooth: Refactor LE connection into its own function
Date: Thu, 31 May 2012 22:57:52 -0300
Message-Id: <1338515876-7547-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1338515876-7547-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1338515876-7547-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The code that handles LE connection is already quite separated from
the rest of the connection procedure, so we can easily put it into
its own.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_conn.c |   53 +++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2fcced3..31afef7 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -469,6 +469,33 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 }
 EXPORT_SYMBOL(hci_get_route);
 
+static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
+				    u8 dst_type, u8 sec_level, u8 auth_type)
+{
+	struct hci_conn *le;
+
+	le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
+	if (!le) {
+		le = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+		if (le)
+			return ERR_PTR(-EBUSY);
+
+		le = hci_conn_add(hdev, LE_LINK, dst);
+		if (!le)
+			return ERR_PTR(-ENOMEM);
+
+		le->dst_type = bdaddr_to_le(dst_type);
+		hci_le_connect(le);
+	}
+
+	le->pending_sec_level = sec_level;
+	le->auth_type = auth_type;
+
+	hci_conn_hold(le);
+
+	return le;
+}
+
 /* Create SCO, ACL or LE connection.
  * Device _must_ be locked */
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
@@ -476,33 +503,11 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
-	struct hci_conn *le;
 
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));
 
-	if (type == LE_LINK) {
-		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
-		if (!le) {
-			le = hci_conn_hash_lookup_state(hdev, LE_LINK,
-							BT_CONNECT);
-			if (le)
-				return ERR_PTR(-EBUSY);
-
-			le = hci_conn_add(hdev, LE_LINK, dst);
-			if (!le)
-				return ERR_PTR(-ENOMEM);
-
-			le->dst_type = bdaddr_to_le(dst_type);
-			hci_le_connect(le);
-		}
-
-		le->pending_sec_level = sec_level;
-		le->auth_type = auth_type;
-
-		hci_conn_hold(le);
-
-		return le;
-	}
+	if (type == LE_LINK)
+		return hci_connect_le(hdev, dst, dst_type, sec_level, auth_type);
 
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
-- 
1.7.10.3

