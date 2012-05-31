Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/5] Bluetooth: Refactor ACL connection into its own function
Date: Wed, 30 May 2012 21:20:17 -0300
Message-Id: <1338423620-32578-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1338423620-32578-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1338423620-32578-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_connect() function was starting to get too complicated to be
quickly understood. We can separated the creation of a new ACL
connection into its own function.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_conn.c |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a7bfc27..ac12cbd 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -492,18 +492,10 @@ static struct hci_conn *add_le_conn(struct hci_dev *hdev, bdaddr_t *dst,
 	return le;
 }
 
-/* Create SCO, ACL or LE connection.
- * Device _must_ be locked */
-struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
-			     __u8 dst_type, __u8 sec_level, __u8 auth_type)
+static struct hci_conn *add_acl_conn(struct hci_dev *hdev, bdaddr_t *dst,
+						u8 sec_level, u8 auth_type)
 {
 	struct hci_conn *acl;
-	struct hci_conn *sco;
-
-	BT_DBG("%s dst %s", hdev->name, batostr(dst));
-
-	if (type == LE_LINK)
-		return add_le_conn(hdev, dst, dst_type, sec_level, auth_type);
 
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
@@ -521,6 +513,26 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		hci_acl_connect(acl);
 	}
 
+	return acl;
+}
+
+/* Create SCO, ACL or LE connection.
+ * Device _must_ be locked */
+struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
+			     __u8 dst_type, __u8 sec_level, __u8 auth_type)
+{
+	struct hci_conn *acl;
+	struct hci_conn *sco;
+
+	BT_DBG("%s dst %s", hdev->name, batostr(dst));
+
+	if (type == LE_LINK)
+		return add_le_conn(hdev, dst, dst_type, sec_level, auth_type);
+
+	acl = add_acl_conn(hdev, dst, sec_level, auth_type);
+	if (IS_ERR(acl))
+		return acl;
+
 	if (type == ACL_LINK)
 		return acl;
 
-- 
1.7.10.3

