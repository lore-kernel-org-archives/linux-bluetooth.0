Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/8] Bluetooth: Store TX power level for connection
Date: Thu, 8 May 2014 15:32:09 +0200
Message-ID: <1399555935-702-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to store local TX power level for connection
when reply for HCI_Read_Transmit_Power_Level is received.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 include/net/bluetooth/hci.h      | 13 +++++++++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         |  1 +
 net/bluetooth/hci_event.c        | 29 +++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ad2ecc9..0056835 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1054,6 +1054,19 @@ struct hci_cp_write_page_scan_activity {
 	__le16   window;
 } __packed;
 
+#define HCI_OP_READ_TX_POWER_LEVEL	0x0c2d
+	#define TX_POWER_TYPE_CURRENT	0x00
+	#define TX_POWER_TYPE_MAXIMUM	0x01
+struct hci_cp_read_tx_power_level {
+	__le16   handle;
+	__u8     type;
+} __packed;
+struct hci_rp_read_tx_power_level {
+	__u8     status;
+	__le16   handle;
+	__s8     tx_power_level;
+} __packed;
+
 #define HCI_OP_READ_PAGE_SCAN_TYPE	0x0c46
 struct hci_rp_read_page_scan_type {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0318d52..211bad6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -375,6 +375,7 @@ struct hci_conn {
 	__u16		le_conn_min_interval;
 	__u16		le_conn_max_interval;
 	__s8		rssi;
+	__s8		tx_power;
 	unsigned long	flags;
 
 	__u8		remote_cap;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 55a1743..74b368b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -407,6 +407,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	conn->io_capability = hdev->io_capability;
 	conn->remote_auth = 0xff;
 	conn->key_type = 0xff;
+	conn->tx_power = HCI_TX_POWER_INVALID;
 
 	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2bb0053..0e67c8e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1264,6 +1264,31 @@ static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_read_tx_power_level(struct hci_dev *hdev,
+				       struct sk_buff *skb)
+{
+	struct hci_cp_read_tx_power_level *sent;
+	struct hci_rp_read_tx_power_level *rp = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_READ_TX_POWER_LEVEL);
+	if (!sent)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
+	if (conn && sent->type == TX_POWER_TYPE_CURRENT)
+		conn->tx_power = rp->tx_power_level;
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
@@ -2660,6 +2685,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_read_rssi(hdev, skb);
 		break;
 
+	case HCI_OP_READ_TX_POWER_LEVEL:
+		hci_cc_read_tx_power_level(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 		break;
-- 
1.9.2

