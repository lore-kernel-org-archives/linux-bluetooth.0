Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 6/6] Bluetooth: Add support for max_tx_power in Get Conn Info
Date: Fri,  9 May 2014 21:35:33 +0200
Message-Id: <1399664133-2892-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399664133-2892-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399664133-2892-1-git-send-email-andrzej.kaczmarek@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for max_tx_power in Get Connection Information
request. Value is read only once for given connection and then always
returned in response as parameter.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/mgmt.h     |  1 +
 net/bluetooth/hci_conn.c         |  1 +
 net/bluetooth/hci_event.c        | 18 +++++++++++++++++-
 net/bluetooth/mgmt.c             |  8 ++++++++
 5 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6353617..665752c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -380,6 +380,7 @@ struct hci_conn {
 	__u16		le_conn_max_interval;
 	__s8		rssi;
 	__s8		tx_power;
+	__s8		max_tx_power;
 	unsigned long	flags;
 
 	unsigned long	conn_info_timestamp;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 34faa2e..33d016b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -420,6 +420,7 @@ struct mgmt_cp_get_conn_info {
 struct mgmt_rp_get_conn_info {
 	struct mgmt_addr_info addr;
 	__s8	rssi;
+	__s8	max_tx_power;
 	__u32	flags;
 	__le16	eir_len;
 	__u8	eir[0];
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 74b368b..a987e7d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -408,6 +408,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	conn->remote_auth = 0xff;
 	conn->key_type = 0xff;
 	conn->tx_power = HCI_TX_POWER_INVALID;
+	conn->max_tx_power = HCI_TX_POWER_INVALID;
 
 	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 63cc9bc..af4276d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1283,9 +1283,25 @@ static void hci_cc_read_tx_power_level(struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
-	if (conn && sent->type == 0x00)
+	if (!conn)
+		goto unlock;
+
+	switch (sent->type) {
+	case 0x00:
 		conn->tx_power = rp->tx_power_level;
+		break;
+
+	case 0x01:
+		conn->max_tx_power = rp->tx_power_level;
+		break;
+
+	default:
+		BT_ERR("Used reserved Read_Transmit_Power_Level param %d",
+		       sent->type);
+		break;
+	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cac2edf..fa918f7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4600,6 +4600,7 @@ static void get_conn_info_complete(struct pending_cmd *cmd, void *data)
 	}
 
 	rp->rssi = conn->rssi;
+	rp->max_tx_power = conn->max_tx_power;
 
 	if (cp->data_type & MGMT_CONN_INFO_DATA_TX_POWER) {
 		eir_len = eir_append_data(rp->eir, 0, EIR_TX_POWER,
@@ -4767,6 +4768,13 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 				    sizeof(req_txp_cp), &req_txp_cp);
 		}
 
+		if (conn->max_tx_power == HCI_TX_POWER_INVALID) {
+			req_txp_cp.handle = cpu_to_le16(conn->handle);
+			req_txp_cp.type = 0x01;
+			hci_req_add(&req, HCI_OP_READ_TX_POWER_LEVEL,
+				    sizeof(req_txp_cp), &req_txp_cp);
+		}
+
 		req_rssi_cp.handle = cpu_to_le16(conn->handle);
 		hci_req_add(&req, HCI_OP_READ_RSSI, sizeof(req_rssi_cp),
 			    &req_rssi_cp);
-- 
1.9.2
