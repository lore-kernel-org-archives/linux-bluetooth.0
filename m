Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 4/5] Bluetooth: Simplify a the connection type handling
Date: Thu, 31 May 2012 22:57:55 -0300
Message-Id: <1338515876-7547-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1338515876-7547-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1338515876-7547-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that we have separate ways of doing connections for each link type,
we can do better than an "if" statement to handle each link type.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_conn.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e4fc946..70979fc 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -567,13 +567,16 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
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
1.7.10.3

