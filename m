Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<joakim.xj.ceder@stericsson.com>, <johan.hedberg@gmail.com>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH] Bluetooth: BT_SECURITY_HIGH requires 16 digit pin code
Date: Fri, 27 Aug 2010 13:44:20 +0200
Message-ID: <1282909460-19337-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The security level BT_SECURITY_HIGH expects secure connection
and a minimum 16 digit pin code used for bonding. It's requitred by the
Sim Access Profile.

Patch on behalf of ST-Ericsson SA.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 include/net/bluetooth/hci.h      |   17 +++++++
 include/net/bluetooth/hci_core.h |    4 ++
 net/bluetooth/hci_conn.c         |   97 +++++++++++++++++++++++++++++++-------
 net/bluetooth/hci_event.c        |    4 ++
 net/bluetooth/hci_sock.c         |    3 +
 net/bluetooth/rfcomm/core.c      |   10 ++++-
 6 files changed, 116 insertions(+), 19 deletions(-)
 mode change 100644 => 100755 include/net/bluetooth/hci.h
 mode change 100644 => 100755 include/net/bluetooth/hci_core.h
 mode change 100644 => 100755 net/bluetooth/hci_conn.c
 mode change 100644 => 100755 net/bluetooth/hci_event.c
 mode change 100644 => 100755 net/bluetooth/rfcomm/core.c

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
old mode 100644
new mode 100755
index bcbdd6d..34a6fbf
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -99,6 +99,7 @@ enum {
 #define HCISETLINKMODE	_IOW('H', 226, int)
 #define HCISETACLMTU	_IOW('H', 227, int)
 #define HCISETSCOMTU	_IOW('H', 228, int)
+#define HCISETCONNINFO	_IOW('H', 229, int)
 
 #define HCIBLOCKADDR	_IOW('H', 230, int)
 #define HCIUNBLOCKADDR	_IOW('H', 231, int)
@@ -224,6 +225,15 @@ enum {
 #define HCI_AT_GENERAL_BONDING		0x04
 #define HCI_AT_GENERAL_BONDING_MITM	0x05
 
+/* Link Key types */
+#define HCI_LK_COMBINATION			0x00
+#define HCI_LK_LOCAL_UNIT			0x01
+#define HCI_LK_REMOTE_UNIT			0x02
+#define HCI_LK_DEBUG_COMBINATION 		0x03
+#define HCI_LK_UNAUTHENTICATED_COMBINATION 	0x04
+#define HCI_LK_AUTHENTICATED_COMBINATION 	0x05
+#define HCI_LK_CHANGEED_COMBINATION_KEY 	0x06
+
 /* -----  HCI Commands ---- */
 #define HCI_OP_INQUIRY			0x0401
 struct hci_cp_inquiry {
@@ -1022,9 +1032,16 @@ struct hci_conn_info_req {
 	struct   hci_conn_info conn_info[0];
 };
 
+struct hci_set_conn_info_req {
+	bdaddr_t bdaddr;
+	__u8     pin_len;
+	__u8	 key_type;
+};
+
 struct hci_auth_info_req {
 	bdaddr_t bdaddr;
 	__u8     type;
+	__u8     level;
 };
 
 struct hci_inquiry_req {
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
old mode 100644
new mode 100755
index 4568b93..9eb2da3
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -183,6 +183,8 @@ struct hci_conn {
 	__u32		 link_mode;
 	__u8             auth_type;
 	__u8             sec_level;
+	__u8             key_type;
+	__u8             pin_len;
 	__u8             power_save;
 	__u16            disc_timeout;
 	unsigned long	 pend;
@@ -430,6 +432,8 @@ int hci_get_dev_info(void __user *arg);
 int hci_get_conn_list(void __user *arg);
 int hci_get_conn_info(struct hci_dev *hdev, void __user *arg);
 int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
+int hci_set_conn_info(struct hci_dev *hdev, void __user *arg);
+
 int hci_inquiry(void __user *arg);
 
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
old mode 100644
new mode 100755
index 0b1e460..ed7a007
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -233,6 +233,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	conn->mode  = HCI_CM_ACTIVE;
 	conn->state = BT_OPEN;
 	conn->auth_type = HCI_AT_GENERAL_BONDING;
+	conn->key_type = 0xff;
+	conn->pin_len = 0;
 
 	conn->power_save = 1;
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
@@ -433,15 +435,11 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 EXPORT_SYMBOL(hci_conn_check_link_mode);
 
 /* Authenticate remote device */
-static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
+static void hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 {
 	BT_DBG("conn %p", conn);
 
-	if (sec_level > conn->sec_level)
-		conn->sec_level = sec_level;
-	else if (conn->link_mode & HCI_LM_AUTH)
-		return 1;
-
+	conn->sec_level = sec_level;
 	conn->auth_type = auth_type;
 
 	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->pend)) {
@@ -450,8 +448,20 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 		hci_send_cmd(conn->hdev, HCI_OP_AUTH_REQUESTED,
 							sizeof(cp), &cp);
 	}
+}
 
-	return 0;
+/* Encrypt the the link */
+static void hci_conn_encrypt(struct hci_conn *conn)
+{
+	BT_DBG("conn %p", conn);
+
+	if (!test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend)) {
+		struct hci_cp_set_conn_encrypt cp;
+		cp.handle  = cpu_to_le16(conn->handle);
+		cp.encrypt = 1;
+		hci_send_cmd(conn->hdev, HCI_OP_SET_CONN_ENCRYPT,
+							sizeof(cp), &cp);
+	}
 }
 
 /* Enable security */
@@ -459,28 +469,54 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 {
 	BT_DBG("conn %p", conn);
 
+	/* For sdp we do not need the link key. */
 	if (sec_level == BT_SECURITY_SDP)
 		return 1;
 
+	/* For non 2.1 devices and low security level we do not need the
+	   link key. */
 	if (sec_level == BT_SECURITY_LOW &&
 				(!conn->ssp_mode || !conn->hdev->ssp_mode))
 		return 1;
 
-	if (conn->link_mode & HCI_LM_ENCRYPT)
-		return hci_conn_auth(conn, sec_level, auth_type);
-
+	/* For other security levels we need link key. */
+	if (!(conn->link_mode & HCI_LM_AUTH))
+		goto do_auth;
+
+	/* An authenticated combination key has sufficient security for any
+	   security level. */
+	if (conn->key_type == HCI_LK_AUTHENTICATED_COMBINATION)
+		goto do_encrypt;
+
+	/* An unauthenticated combination key has sufficient security for
+	   security level 1 and 2. */
+	if (conn->key_type == HCI_LK_UNAUTHENTICATED_COMBINATION 
+			&& (sec_level == BT_SECURITY_MEDIUM
+				|| sec_level == BT_SECURITY_LOW))
+		goto do_encrypt;
+
+	/* A combination key has always sufficient security for the security
+	   levels 1 or 2. High security level requires that the combination key
+	   was generated using the maximum PIN code length (16).
+	   For pre 2.1 units. */
+	if ((conn->key_type == HCI_LK_COMBINATION))
+		if ((sec_level != BT_SECURITY_HIGH) || (conn->pin_len >= 16))
+			goto do_encrypt;
+
+do_auth:
 	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend))
 		return 0;
 
-	if (hci_conn_auth(conn, sec_level, auth_type)) {
-		struct hci_cp_set_conn_encrypt cp;
-		cp.handle  = cpu_to_le16(conn->handle);
-		cp.encrypt = 1;
-		hci_send_cmd(conn->hdev, HCI_OP_SET_CONN_ENCRYPT,
-							sizeof(cp), &cp);
-	}
-
+	hci_conn_auth(conn, sec_level, auth_type);
 	return 0;
+
+do_encrypt:
+	if (conn->link_mode & HCI_LM_ENCRYPT)
+		return 1;  /* sufficient link key */
+	else{
+		hci_conn_encrypt(conn);
+		return 0; /* auth pending */
+	}
 }
 EXPORT_SYMBOL(hci_conn_security);
 
@@ -713,6 +749,30 @@ int hci_get_conn_info(struct hci_dev *hdev, void __user *arg)
 	return copy_to_user(ptr, &ci, sizeof(ci)) ? -EFAULT : 0;
 }
 
+int hci_set_conn_info(struct hci_dev *hdev, void __user *arg)
+{
+	struct hci_set_conn_info_req req;
+	struct hci_conn *conn;
+
+	if (copy_from_user(&req, arg, sizeof(req))) {
+		BT_DBG("copy from user failed");
+		return -EFAULT;
+	}
+
+	hci_dev_lock_bh(hdev);
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &req.bdaddr);
+	if (conn) {
+		conn->pin_len = req.pin_len;
+		conn->key_type = req.key_type;
+	}
+	hci_dev_unlock_bh(hdev);
+
+	if (!conn)
+		return -ENOENT;
+
+	return 0;
+}
+
 int hci_get_auth_info(struct hci_dev *hdev, void __user *arg)
 {
 	struct hci_auth_info_req req;
@@ -725,6 +785,7 @@ int hci_get_auth_info(struct hci_dev *hdev, void __user *arg)
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &req.bdaddr);
 	if (conn)
 		req.type = conn->auth_type;
+		req.level = conn->sec_level;
 	hci_dev_unlock_bh(hdev);
 
 	if (!conn)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
old mode 100644
new mode 100755
index bfef5ba..6d6b04c
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1521,6 +1521,10 @@ static inline void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (conn) {
 		hci_conn_hold(conn);
+		/* For Changed Combination Link Key the only link key has
+		 * been changed, not link key type. */
+		if (conn->key_type != HCI_LK_CHANGEED_COMBINATION_KEY)
+			conn->key_type = ev->key_type;
 		conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 		hci_conn_put(conn);
 	}
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 83acd16..502a7b0 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -269,6 +269,9 @@ static inline int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd, unsign
 	case HCIGETCONNINFO:
 		return hci_get_conn_info(hdev, (void __user *) arg);
 
+	case HCISETCONNINFO:
+		return hci_set_conn_info(hdev, (void __user *) arg);
+
 	case HCIGETAUTHINFO:
 		return hci_get_auth_info(hdev, (void __user *) arg);
 
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
old mode 100644
new mode 100755
index 7dca91b..2e248d5
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2086,7 +2086,15 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 			continue;
 
 		if (!status)
-			set_bit(RFCOMM_AUTH_ACCEPT, &d->flags);
+			if (d->sec_level != BT_SECURITY_HIGH)
+				set_bit(RFCOMM_AUTH_ACCEPT, &d->flags);
+			else
+				if ((conn->key_type == HCI_LK_AUTHENTICATED_COMBINATION)
+					|| (conn->key_type == HCI_LK_COMBINATION
+						&& conn->pin_len >= 16))
+					set_bit(RFCOMM_AUTH_ACCEPT, &d->flags);
+				else
+					set_bit(RFCOMM_AUTH_REJECT, &d->flags);
 		else
 			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
 	}
-- 
1.7.0.4

