Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v3 6/7] Bluetooth: Simplify a the connection type handling
Date: Fri, 27 Jul 2012 19:32:59 -0300
Message-Id: <1343428380-32705-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1343428380-32705-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1343428380-32705-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that we have separate ways of doing connections for each link type,
we can do better than an "if" statement to handle each link type.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_conn.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index de7df88..2e7b776 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -568,13 +568,16 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 {
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));
 
-	if (type == LE_LINK)
+	switch (type) {
+	case LE_LINK:
 		return hci_connect_le(hdev, dst, dst_type, sec_level, auth_type);
-
-	if (type == ACL_LINK)
+	case ACL_LINK:
 		return hci_connect_acl(hdev, dst, sec_level, auth_type);
+	case SCO_LINK:
+		return hci_connect_sco(hdev, dst, sec_level, auth_type);
+	}
 
-	return hci_connect_sco(hdev, dst, sec_level, auth_type);
+	return ERR_PTR(-EINVAL);
 }
 
 /* Check link security requirement */
-- 
1.7.10.4

