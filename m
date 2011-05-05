Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <padovan@profusion.mobi>, <linux-bluetooth@vger.kernel.org>
CC: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v1] Bluetooth: Double check sec req for pre 2.1 device
Date: Thu, 5 May 2011 16:16:17 +0200
Message-ID: <1304604978-17895-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1304604978-17895-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1304604978-17895-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of pre v2.1 devices authentication request will return
success immediately if the link key already exists without any
authentication process.

That means, it's not possible to re-authenticate the link if you
already have combination key and for instance want to re-authenticate
to get the high security (use 16 digit pin).

Therefore, it's necessary to check security requirements on auth
complete event to prevent not enough secure connection.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 include/net/bluetooth/hci_core.h |    4 +++-
 net/bluetooth/hci_conn.c         |   17 +++++++++++++++++
 net/bluetooth/rfcomm/core.c      |    2 +-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 14cc324..1b35c27 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -420,8 +420,10 @@ int hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
 
-struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8 sec_level, __u8 auth_type);
+struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
+					__u8 sec_level, __u8 auth_type);
 int hci_conn_check_link_mode(struct hci_conn *conn);
+int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
 int hci_conn_change_link_key(struct hci_conn *conn);
 int hci_conn_switch_role(struct hci_conn *conn, __u8 role);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7f5ad8a..3163330 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -623,6 +623,23 @@ encrypt:
 }
 EXPORT_SYMBOL(hci_conn_security);
 
+/* Check secure link requirement */
+int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level)
+{
+	BT_DBG("conn %p", conn);
+
+	if (sec_level != BT_SECURITY_HIGH)
+		return 1; /* Accept if non-secure is required */
+
+	if (conn->key_type == HCI_LK_AUTH_COMBINATION ||
+			(conn->key_type == HCI_LK_COMBINATION &&
+			conn->pin_length == 16))
+		return 1;
+
+	return 0; /* Reject not secure link */
+}
+EXPORT_SYMBOL(hci_conn_check_secure);
+
 /* Change link key */
 int hci_conn_change_link_key(struct hci_conn *conn)
 {
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 121a5c1..5759bb7 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2096,7 +2096,7 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 		if (!test_and_clear_bit(RFCOMM_AUTH_PENDING, &d->flags))
 			continue;
 
-		if (!status)
+		if (!status && hci_conn_check_secure(conn, d->sec_level))
 			set_bit(RFCOMM_AUTH_ACCEPT, &d->flags);
 		else
 			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
-- 
1.7.1

