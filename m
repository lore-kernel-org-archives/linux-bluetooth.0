Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/5] Bluetooth: Refactor SCO connection into its own function
Date: Wed, 30 May 2012 21:20:18 -0300
Message-Id: <1338423620-32578-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1338423620-32578-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1338423620-32578-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We can do the same that we did for the other link types, for SCO
connections. The only thing that's worth noting is that as SCO
links need an ACL link, this functions uses the function that adds
an ACL link.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_conn.c |   33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ac12cbd..320cc5d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -516,29 +516,19 @@ static struct hci_conn *add_acl_conn(struct hci_dev *hdev, bdaddr_t *dst,
 	return acl;
 }
 
-/* Create SCO, ACL or LE connection.
- * Device _must_ be locked */
-struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
-			     __u8 dst_type, __u8 sec_level, __u8 auth_type)
+static struct hci_conn *add_sco_conn(struct hci_dev *hdev, bdaddr_t *dst,
+				     u8 sec_level, u8 auth_type)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
 
-	BT_DBG("%s dst %s", hdev->name, batostr(dst));
-
-	if (type == LE_LINK)
-		return add_le_conn(hdev, dst, dst_type, sec_level, auth_type);
-
 	acl = add_acl_conn(hdev, dst, sec_level, auth_type);
 	if (IS_ERR(acl))
 		return acl;
 
-	if (type == ACL_LINK)
-		return acl;
-
-	sco = hci_conn_hash_lookup_ba(hdev, type, dst);
+	sco = hci_conn_hash_lookup_ba(hdev, SCO_LINK, dst);
 	if (!sco) {
-		sco = hci_conn_add(hdev, type, dst);
+		sco = hci_conn_add(hdev, SCO_LINK, dst);
 		if (!sco) {
 			hci_conn_put(acl);
 			return ERR_PTR(-ENOMEM);
@@ -567,6 +557,21 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	return sco;
 }
 
+/* Create SCO, ACL or LE connection. */
+struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
+			     __u8 dst_type, __u8 sec_level, __u8 auth_type)
+{
+	BT_DBG("%s dst %s", hdev->name, batostr(dst));
+
+	if (type == LE_LINK)
+		return add_le_conn(hdev, dst, dst_type, sec_level, auth_type);
+
+	if (type == ACL_LINK)
+		return add_acl_conn(hdev, dst, sec_level, auth_type);
+
+	return add_sco_conn(hdev, dst, sec_level, auth_type);
+}
+
 /* Check link security requirement */
 int hci_conn_check_link_mode(struct hci_conn *conn)
 {
-- 
1.7.10.3

