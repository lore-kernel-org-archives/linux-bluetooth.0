Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Bluetooth: Fix establishing ESCO links
Date: Fri, 17 Aug 2012 21:37:59 -0300
Message-Id: <1345250279-32158-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commit 4cd2d98340b4f03d5532c30fdaeb451b035429cb "Bluetooth: Simplify
the connection type handling" broke the creation of ESCO links.

This patch adds a type parameter to hci_connect_sco() so it creates
the connection of the right kind.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 98670b1..3e65c02 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -521,8 +521,8 @@ static struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 	return acl;
 }
 
-static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, bdaddr_t *dst,
-				     u8 sec_level, u8 auth_type)
+static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
+				bdaddr_t *dst, u8 sec_level, u8 auth_type)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
@@ -531,9 +531,9 @@ static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, bdaddr_t *dst,
 	if (IS_ERR(acl))
 		return acl;
 
-	sco = hci_conn_hash_lookup_ba(hdev, SCO_LINK, dst);
+	sco = hci_conn_hash_lookup_ba(hdev, type, dst);
 	if (!sco) {
-		sco = hci_conn_add(hdev, SCO_LINK, dst);
+		sco = hci_conn_add(hdev, type, dst);
 		if (!sco) {
 			hci_conn_put(acl);
 			return ERR_PTR(-ENOMEM);
@@ -574,7 +574,8 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	case ACL_LINK:
 		return hci_connect_acl(hdev, dst, sec_level, auth_type);
 	case SCO_LINK:
-		return hci_connect_sco(hdev, dst, sec_level, auth_type);
+	case ESCO_LINK:
+		return hci_connect_sco(hdev, type, dst, sec_level, auth_type);
 	}
 
 	return ERR_PTR(-EINVAL);
-- 
1.7.11.4

