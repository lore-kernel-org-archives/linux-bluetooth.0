Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH 2/2] Bluetooth: Use ERR_PTR as return error from hci_connect
Date: Mon, 21 Feb 2011 15:09:24 -0300
Message-Id: <4d62aa7a.47f3d80a.5ea1.ffffd992@mx.google.com>
In-Reply-To: <y>
References: <y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ville Tervo <ville.tervo@nokia.com>

Use ERR_PRT mechanism to return error from hci_connect.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 net/bluetooth/hci_conn.c   |    8 ++++----
 net/bluetooth/l2cap_core.c |   10 ++++------
 net/bluetooth/sco.c        |    6 +++---
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d401775..06af539 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -430,10 +430,10 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 	if (type == LE_LINK) {
 		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
 		if (le)
-			return NULL;
+			return ERR_PTR(-EBUSY);
 		le = hci_conn_add(hdev, LE_LINK, dst);
 		if (!le)
-			return NULL;
+			return ERR_PTR(-ENOMEM);
 		if (le->state == BT_OPEN)
 			hci_le_connect(le);
 
@@ -445,8 +445,8 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
 		acl = hci_conn_add(hdev, ACL_LINK, dst);
-		if (!acl)
-			return NULL;
+		if (IS_ERR(acl))
+			return acl;
 	}
 
 	hci_conn_hold(acl);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index efcef0d..e76e9e5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -841,7 +841,7 @@ int l2cap_do_connect(struct sock *sk)
 	struct hci_conn *hcon;
 	struct hci_dev *hdev;
 	__u8 auth_type;
-	int err;
+	int err = 0;
 
 	BT_DBG("%s -> %s psm 0x%2.2x", batostr(src), batostr(dst),
 							l2cap_pi(sk)->psm);
@@ -852,8 +852,6 @@ int l2cap_do_connect(struct sock *sk)
 
 	hci_dev_lock_bh(hdev);
 
-	err = -ENOMEM;
-
 	auth_type = l2cap_get_auth_type(sk);
 
 	if (l2cap_pi(sk)->dcid == L2CAP_CID_LE_DATA)
@@ -863,8 +861,10 @@ int l2cap_do_connect(struct sock *sk)
 		hcon = hci_connect(hdev, ACL_LINK, dst,
 					l2cap_pi(sk)->sec_level, auth_type);
 
-	if (!hcon)
+	if (IS_ERR(hcon)) {
+		err = PTR_ERR(hcon);
 		goto done;
+	}
 
 	conn = l2cap_conn_add(hcon, 0);
 	if (!conn) {
@@ -872,8 +872,6 @@ int l2cap_do_connect(struct sock *sk)
 		goto done;
 	}
 
-	err = 0;
-
 	/* Update source addr of the socket */
 	bacpy(src, conn->src);
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c9348dd..26f2f04 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -190,16 +190,16 @@ static int sco_connect(struct sock *sk)
 
 	hci_dev_lock_bh(hdev);
 
-	err = -ENOMEM;
-
 	if (lmp_esco_capable(hdev) && !disable_esco)
 		type = ESCO_LINK;
 	else
 		type = SCO_LINK;
 
 	hcon = hci_connect(hdev, type, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING);
-	if (!hcon)
+	if (IS_ERR(hcon)) {
+		err = PTR_ERR(hcon);
 		goto done;
+	}
 
 	conn = sco_conn_add(hcon, 0);
 	if (!conn) {
-- 
1.7.1

