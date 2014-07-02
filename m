Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] Bluetooth: Make hci_le_conn_update return any updated parameters
Date: Wed,  2 Jul 2014 16:35:58 +0300
Message-Id: <1404308161-15100-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404308161-15100-1-git-send-email-johan.hedberg@gmail.com>
References: <1404308161-15100-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

By returning the updated parameters (if there were any) makes it
possible for the calling function to do extra decisions, such as setting
the store_hint on a subsequent mgmt event.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 5 +++--
 net/bluetooth/hci_conn.c         | 7 +++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f4a2f50f30b5..3a8d0e2b1406 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1368,8 +1368,9 @@ struct hci_sec_filter {
 #define hci_req_lock(d)		mutex_lock(&d->req_lock)
 #define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
 
-void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
-					u16 latency, u16 to_multiplier);
+struct hci_conn_params *hci_le_conn_update(struct hci_conn *conn, u16 min,
+					   u16 max, u16 latency,
+					   u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 							__u8 ltk[16]);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d00aaf976efc..ab5f70e7980e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -213,8 +213,9 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	return true;
 }
 
-void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
-			u16 latency, u16 to_multiplier)
+struct hci_conn_params *hci_le_conn_update(struct hci_conn *conn, u16 min,
+					   u16 max, u16 latency,
+					   u16 to_multiplier)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_conn_params *params;
@@ -242,6 +243,8 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 	cp.max_ce_len		= cpu_to_le16(0x0000);
 
 	hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
+
+	return params;
 }
 
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
-- 
1.9.3

