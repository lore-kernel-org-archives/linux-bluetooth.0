Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v3 1/7] Bluetooth: Remove some functions from being exported
Date: Fri, 27 Jul 2012 19:32:54 -0300
Message-Id: <1343428380-32705-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1343428380-32705-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1343428380-32705-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some connection related functions are only used inside hci_conn.c
so no need to have them exported.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 --
 net/bluetooth/hci_conn.c         |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 41d9439..7267daf 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -551,9 +551,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 	return NULL;
 }
 
-void hci_acl_connect(struct hci_conn *conn);
 void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
-void hci_add_sco(struct hci_conn *conn, __u16 handle);
 void hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5ad7da2..724eea9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -59,7 +59,7 @@ static void hci_le_connect_cancel(struct hci_conn *conn)
 	hci_send_cmd(conn->hdev, HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);
 }
 
-void hci_acl_connect(struct hci_conn *conn)
+static void hci_acl_connect(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct inquiry_entry *ie;
@@ -129,7 +129,7 @@ void hci_acl_disconn(struct hci_conn *conn, __u8 reason)
 	hci_send_cmd(conn->hdev, HCI_OP_DISCONNECT, sizeof(cp), &cp);
 }
 
-void hci_add_sco(struct hci_conn *conn, __u16 handle)
+static void hci_add_sco(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_add_sco cp;
-- 
1.7.10.4

