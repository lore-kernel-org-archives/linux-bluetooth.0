Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [RFCv2 3/4] Bluetooth: Use ERR_PTR to return error from hci_connect
Date: Thu, 17 Feb 2011 10:39:55 -0300
Message-Id: <4d5d2589.8f7edc0a.5af6.27dd@mx.google.com>
In-Reply-To: <n>
References: <n>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ville Tervo <ville.tervo@nokia.com>

Use ERR_PRT mechanism to return error from hci_connect. This patch also
includes a change to return error if LE link exists already to remote host.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/hci_conn.c   |   12 +++++++-----
 net/bluetooth/l2cap_core.c |   10 ++++------
 net/bluetooth/sco.c        |    6 +++---
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ee7dcdd..e06b856 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -305,7 +305,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 
 	conn = kzalloc(sizeof(struct hci_conn), GFP_ATOMIC);
 	if (!conn)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	bacpy(&conn->dst, dst);
 	conn->hdev  = hdev;
@@ -459,8 +459,10 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
 		if (!le)
 			le = hci_conn_add(hdev, LE_LINK, dst);
-		if (!le)
-			return NULL;
+		else
+			return ERR_PTR(-EBUSY);
+		if (IS_ERR(le))
+			return le;
 		if (le->state == BT_OPEN)
 			hci_le_connect(le);
 
@@ -472,8 +474,8 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
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
index 7f30c53..f85be1a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -869,7 +869,7 @@ int l2cap_do_connect(struct sock *sk)
 	struct hci_conn *hcon;
 	struct hci_dev *hdev;
 	__u8 auth_type;
-	int err;
+	int err = 0;
 
 	BT_DBG("%s -> %s psm 0x%2.2x", batostr(src), batostr(dst),
 							l2cap_pi(sk)->psm);
@@ -880,8 +880,6 @@ int l2cap_do_connect(struct sock *sk)
 
 	hci_dev_lock_bh(hdev);
 
-	err = -ENOMEM;
-
 	auth_type = l2cap_get_auth_type(sk);
 
 	if (l2cap_pi(sk)->dcid == L2CAP_CID_LE_DATA)
@@ -891,8 +889,10 @@ int l2cap_do_connect(struct sock *sk)
 		hcon = hci_connect(hdev, ACL_LINK, dst,
 					l2cap_pi(sk)->sec_level, auth_type);
 
-	if (!hcon)
+	if (IS_ERR(hcon)) {
+		err = PTR_ERR(hcon);
 		goto done;
+	}
 
 	conn = l2cap_conn_add(hcon, 0);
 	if (!conn) {
@@ -900,8 +900,6 @@ int l2cap_do_connect(struct sock *sk)
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

