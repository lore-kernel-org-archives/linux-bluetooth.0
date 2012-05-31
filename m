Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/5] Bluetooth: Refactor LE connection into its own function
Date: Wed, 30 May 2012 21:20:16 -0300
Message-Id: <1338423620-32578-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The code that handles LE connection is already quite separated from
the rest of the connection procedure, so we can easily put it into
its own.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---

Because of the moving around, these patches aren't as easy to follow as one would
expect.


 net/bluetooth/hci_conn.c |   44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1458667b..a7bfc27 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -469,6 +469,29 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 }
 EXPORT_SYMBOL(hci_get_route);

+static struct hci_conn *add_le_conn(struct hci_dev *hdev, bdaddr_t *dst,
+				    u8 dst_type, u8 sec_level, u8 auth_type)
+{
+	struct hci_conn *le;
+
+	le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
+	if (!le) {
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
@@ -476,28 +499,11 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
-	struct hci_conn *le;

 	BT_DBG("%s dst %s", hdev->name, batostr(dst));

-	if (type == LE_LINK) {
-		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
-		if (!le) {
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
+		return add_le_conn(hdev, dst, dst_type, sec_level, auth_type);

 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
--
1.7.10.3

