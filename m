Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/7] Bluetooth: Make hci_le_create_connection non-static
Date: Fri,  1 Feb 2013 21:44:33 -0300
Message-Id: <1359765878-31409-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1359765878-31409-1-git-send-email-andre.guedes@openbossa.org>
References: <1359765878-31409-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make hci_le_create_connection helper non-static so it can be called
from outside hci_conn.c.

The helper will be used to create a LE connection once the target
device is in-range.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_conn.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 90cf75a..00923ef 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -577,6 +577,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
 void hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
+void hci_le_create_connection(struct hci_conn *conn);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
 int hci_conn_del(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 25bfce0..bb9a88d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -31,7 +31,7 @@
 #include <net/bluetooth/a2mp.h>
 #include <net/bluetooth/smp.h>
 
-static void hci_le_create_connection(struct hci_conn *conn)
+void hci_le_create_connection(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_create_conn cp;
-- 
1.8.1.1

