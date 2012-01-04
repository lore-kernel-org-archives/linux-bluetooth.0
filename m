Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 1/3] Bluetooth: Make hci_conn_auth/encrypt public functions
Date: Wed,  4 Jan 2012 16:06:22 +0100
Message-Id: <1325689584-15121-2-git-send-email-wagi@monom.org>
In-Reply-To: <1325689584-15121-1-git-send-email-wagi@monom.org>
References: <1325689584-15121-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_conn.c         |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ea9231f..301b86b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -527,6 +527,8 @@ void hci_chan_list_flush(struct hci_conn *conn);
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 						__u8 sec_level, __u8 auth_type);
 int hci_conn_check_link_mode(struct hci_conn *conn);
+int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
+void hci_conn_encrypt(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
 int hci_conn_change_link_key(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 07bc69e..da49b9c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -616,7 +616,7 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 EXPORT_SYMBOL(hci_conn_check_link_mode);
 
 /* Authenticate remote device */
-static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
+int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 {
 	BT_DBG("conn %p", conn);
 
@@ -650,7 +650,7 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 }
 
 /* Encrypt the the link */
-static void hci_conn_encrypt(struct hci_conn *conn)
+void hci_conn_encrypt(struct hci_conn *conn)
 {
 	BT_DBG("conn %p", conn);
 
-- 
1.7.8.2.302.g17b4

