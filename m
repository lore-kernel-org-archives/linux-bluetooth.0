Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFC 5/5] Bluetooth: hci_connect() should return status code
Date: Mon, 14 Feb 2011 19:00:00 -0300
Message-Id: <4d59a608.859ddc0a.46cb.5150@mx.google.com>
In-Reply-To: <n>
References: <n>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Guedes <andre.guedes@openbossa.org>

This patch changes the hci_connect() prototype and related code.
hci_connect() returns a status code instead of a struct hci_conn *.
A new parameter (struct hci_conn **conn) was added in order to
return the pointer to the struct hci_conn.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    3 ++-
 net/bluetooth/hci_conn.c         |   36 ++++++++++++++++++++++--------------
 net/bluetooth/l2cap_core.c       |    9 ++++-----
 net/bluetooth/sco.c              |    8 ++++----
 4 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5992148..1394aeb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -419,7 +419,8 @@ int hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
 
-struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8 sec_level, __u8 auth_type);
+int hci_connect(struct hci_conn **conn, struct hci_dev *hdev, int type,
+		bdaddr_t *dst, __u8 sec_level, __u8 auth_type);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
 int hci_conn_change_link_key(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2c91f4e..27c430f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -448,7 +448,8 @@ EXPORT_SYMBOL(hci_get_route);
 
 /* Create SCO, ACL or LE connection.
  * Device _must_ be locked */
-struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8 sec_level, __u8 auth_type)
+int hci_connect(struct hci_conn **conn, struct hci_dev *hdev, int type,
+		bdaddr_t *dst, __u8 sec_level, __u8 auth_type)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
@@ -456,30 +457,33 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));
 
+	if (!conn)
+		return -EINVAL;
+
 	if (type == LE_LINK) {
 		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
 		if (!le)
 			le = hci_conn_add(hdev, LE_LINK, dst);
 		if (!le)
-			return NULL;
+			return -ENOMEM;
 		if (le->state == BT_OPEN) {
 			struct adv_entry *entry = hci_find_adv_entry(hdev, dst);
-			if (entry)
-				hci_le_connect(le, entry->bdaddr_type);
-			else
-				hci_le_connect(le, ADDR_DEV_PUBLIC);
+			if (!entry)
+				return -EHOSTUNREACH;
+
+			hci_le_connect(le, entry->bdaddr_type);
 		}
 
 		hci_conn_hold(le);
-
-		return le;
+		*conn = le;
+		return 0;
 	}
 
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
 		acl = hci_conn_add(hdev, ACL_LINK, dst);
 		if (!acl)
-			return NULL;
+			return -ENOMEM;
 	}
 
 	hci_conn_hold(acl);
@@ -491,15 +495,17 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		hci_acl_connect(acl);
 	}
 
-	if (type == ACL_LINK)
-		return acl;
+	if (type == ACL_LINK) {
+		*conn = acl;
+		return 0;
+	}
 
 	sco = hci_conn_hash_lookup_ba(hdev, type, dst);
 	if (!sco) {
 		sco = hci_conn_add(hdev, type, dst);
 		if (!sco) {
 			hci_conn_put(acl);
-			return NULL;
+			return -ENOMEM;
 		}
 	}
 
@@ -516,13 +522,15 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		if (test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->pend)) {
 			/* defer SCO setup until mode change completed */
 			set_bit(HCI_CONN_SCO_SETUP_PEND, &acl->pend);
-			return sco;
+			*conn = sco;
+			return 0;
 		}
 
 		hci_sco_setup(acl, 0x00);
 	}
 
-	return sco;
+	*conn = sco;
+	return 0;
 }
 EXPORT_SYMBOL(hci_connect);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0ca54d8..e87e625 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -882,20 +882,19 @@ int l2cap_do_connect(struct sock *sk)
 
 	hci_dev_lock_bh(hdev);
 
-	err = -ENOMEM;
-
 	auth_type = l2cap_get_auth_type(sk);
 
 	if (l2cap_pi(sk)->dcid == L2CAP_CID_LE_DATA)
-		hcon = hci_connect(hdev, LE_LINK, dst,
+		err = hci_connect(&hcon, hdev, LE_LINK, dst,
 					l2cap_pi(sk)->sec_level, auth_type);
 	else
-		hcon = hci_connect(hdev, ACL_LINK, dst,
+		err = hci_connect(&hcon, hdev, ACL_LINK, dst,
 					l2cap_pi(sk)->sec_level, auth_type);
 
-	if (!hcon)
+	if (err)
 		goto done;
 
+	err = -ENOMEM;
 	conn = l2cap_conn_add(hcon, 0);
 	if (!conn) {
 		hci_conn_put(hcon);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 960c6d1..3725922 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -192,17 +192,17 @@ static int sco_connect(struct sock *sk)
 
 	hci_dev_lock_bh(hdev);
 
-	err = -ENOMEM;
-
 	if (lmp_esco_capable(hdev) && !disable_esco)
 		type = ESCO_LINK;
 	else
 		type = SCO_LINK;
 
-	hcon = hci_connect(hdev, type, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING);
-	if (!hcon)
+	err = hci_connect(&hcon, hdev, type, dst, BT_SECURITY_LOW,
+							HCI_AT_NO_BONDING);
+	if (err)
 		goto done;
 
+	err = -ENOMEM;
 	conn = sco_conn_add(hcon, 0);
 	if (!conn) {
 		hci_conn_put(hcon);
-- 
1.7.1

