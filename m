Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/10] Bluetooth: Make hci_le_conn_update return the store hint
Date: Wed,  2 Jul 2014 17:37:31 +0300
Message-Id: <1404311854-12233-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
References: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The caller of hci_le_conn_update is directly interested in knowing what
the best value is for the store_hint parameter of the corresponding
mgmt event. Since hci_le_conn_update knows whether there were stored
parameters that were updated or not we can have it return an initial
store_hint value to the caller.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 4 ++--
 net/bluetooth/hci_conn.c         | 9 +++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f4a2f50f30b5..32c8e51f6b26 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1368,8 +1368,8 @@ struct hci_sec_filter {
 #define hci_req_lock(d)		mutex_lock(&d->req_lock)
 #define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
 
-void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
-					u16 latency, u16 to_multiplier);
+u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
+		      u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 							__u8 ltk[16]);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d00aaf976efc..0d579d036833 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -213,8 +213,8 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	return true;
 }
 
-void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
-			u16 latency, u16 to_multiplier)
+u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
+		      u16 to_multiplier)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_conn_params *params;
@@ -242,6 +242,11 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 	cp.max_ce_len		= cpu_to_le16(0x0000);
 
 	hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
+
+	if (params)
+		return 0x01;
+
+	return 0x00;
 }
 
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
-- 
1.9.3

