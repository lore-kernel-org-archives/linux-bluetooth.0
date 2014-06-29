Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Store latency and supervision timeout in connection params
Date: Sun, 29 Jun 2014 16:43:26 +0200
Message-Id: <1404053007-35603-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the slave updates the connection parameters, store also the
connection latency and supervision timeout information in the
internal list of connection parameters for known devices.

Having these values available allowes the auto-connection
procedure to use the correct values from the beginning without
having to request an update on every connection establishment.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         | 16 ++++++++++++++--
 net/bluetooth/hci_core.c         |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0906990dedd8..182044824495 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -439,6 +439,8 @@ struct hci_conn_params {
 
 	u16 conn_min_interval;
 	u16 conn_max_interval;
+	u16 conn_latency;
+	u16 supervision_timeout;
 
 	enum {
 		HCI_AUTO_CONN_DISABLED,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 25ee27ddc882..adb413d77637 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -216,11 +216,23 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 			u16 latency, u16 to_multiplier)
 {
-	struct hci_cp_le_conn_update cp;
 	struct hci_dev *hdev = conn->hdev;
+	struct hci_conn_params *params;
+	struct hci_cp_le_conn_update cp;
 
-	memset(&cp, 0, sizeof(cp));
+	hci_dev_lock(hdev);
+
+	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
+	if (params) {
+		params->conn_min_interval = min;
+		params->conn_max_interval = max;
+		params->conn_latency = latency;
+		params->supervision_timeout = to_multiplier;
+	}
 
+	hci_dev_unlock(hdev);
+
+	memset(&cp, 0, sizeof(cp));
 	cp.handle		= cpu_to_le16(conn->handle);
 	cp.conn_interval_min	= cpu_to_le16(min);
 	cp.conn_interval_max	= cpu_to_le16(max);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b2b7f6ed3c89..8d972023196b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3439,6 +3439,8 @@ int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 update:
 	params->conn_min_interval = conn_min_interval;
 	params->conn_max_interval = conn_max_interval;
+	params->conn_latency = 0x0000;
+	params->supervision_timeout = 0x002a;
 	params->auto_connect = auto_connect;
 
 	switch (auto_connect) {
-- 
1.9.3

