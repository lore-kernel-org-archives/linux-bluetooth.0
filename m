Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Store current LE connection parameters in hci_conn struct
Date: Mon, 23 Jun 2014 11:40:04 +0200
Message-Id: <1403516405-2184-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The LE connection parameters are needed later on to be able to decide
if it is required to trigger connection update procedures. So when the
connection has been established successfully, store the current used
parameters in hci_conn struct.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 3 +++
 net/bluetooth/hci_event.c        | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c81de0d366df..cd73a82cc713 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -381,6 +381,9 @@ struct hci_conn {
 	__u16		setting;
 	__u16		le_conn_min_interval;
 	__u16		le_conn_max_interval;
+	__u16		le_conn_interval;
+	__u16		le_conn_latency;
+	__u16		le_supv_timeout;
 	__s8		rssi;
 	__s8		tx_power;
 	__s8		max_tx_power;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e5b430113cfb..3d4741d789d3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4056,6 +4056,10 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	conn->handle = __le16_to_cpu(ev->handle);
 	conn->state = BT_CONNECTED;
 
+	conn->le_conn_interval = le16_to_cpu(ev->interval);
+	conn->le_conn_latency = le16_to_cpu(ev->latency);
+	conn->le_supv_timeout = le16_to_cpu(ev->supervision_timeout);
+
 	hci_conn_add_sysfs(conn);
 
 	hci_proto_connect_cfm(conn, ev->status);
-- 
1.9.3

