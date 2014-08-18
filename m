Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] Bluetooth: Update hci_disconnect() to return an error value
Date: Mon, 18 Aug 2014 20:33:32 +0300
Message-Id: <1408383214-16366-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
References: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We'll soon use hci_disconnect() from places that are interested to know
whether the hci_send_cmd() really succeeded or not. This patch updates
hci_disconnect() to pass on any error returned from hci_send_cmd().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/hci_conn.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dbe73642c54c..2b6e04d37593 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -703,7 +703,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 	return NULL;
 }
 
-void hci_disconnect(struct hci_conn *conn, __u8 reason);
+int hci_disconnect(struct hci_conn *conn, __u8 reason);
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5157a0990732..dd2df20b0f7d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -122,7 +122,7 @@ static void hci_reject_sco(struct hci_conn *conn)
 	hci_send_cmd(conn->hdev, HCI_OP_REJECT_SYNC_CONN_REQ, sizeof(cp), &cp);
 }
 
-void hci_disconnect(struct hci_conn *conn, __u8 reason)
+int hci_disconnect(struct hci_conn *conn, __u8 reason)
 {
 	struct hci_cp_disconnect cp;
 
@@ -132,7 +132,7 @@ void hci_disconnect(struct hci_conn *conn, __u8 reason)
 
 	cp.handle = cpu_to_le16(conn->handle);
 	cp.reason = reason;
-	hci_send_cmd(conn->hdev, HCI_OP_DISCONNECT, sizeof(cp), &cp);
+	return hci_send_cmd(conn->hdev, HCI_OP_DISCONNECT, sizeof(cp), &cp);
 }
 
 static void hci_amp_disconn(struct hci_conn *conn)
-- 
1.9.3

