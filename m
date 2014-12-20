Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Store default and maximum LE data length settings
Date: Sat, 20 Dec 2014 16:28:40 +0100
Message-Id: <1419089320-14498-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the controller supports the LE Data Length Extension feature, the
default and maximum data length are read and now stored.

For backwards compatibility all values are initialized to the data
length values from Bluetooth 4.1 and earlier specifications.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  6 ++++
 net/bluetooth/hci_core.c         |  6 ++++
 net/bluetooth/hci_event.c        | 61 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 79724c87ab00..f20f6bd668bd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -220,6 +220,12 @@ struct hci_dev {
 	__u16		le_conn_max_interval;
 	__u16		le_conn_latency;
 	__u16		le_supv_timeout;
+	__u16		le_def_tx_len;
+	__u16		le_def_tx_time;
+	__u16		le_max_tx_len;
+	__u16		le_max_tx_time;
+	__u16		le_max_rx_len;
+	__u16		le_max_rx_time;
 	__u16		discov_interleaved_timeout;
 	__u16		conn_info_min_age;
 	__u16		conn_info_max_age;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 01e35ef6d201..47f0311d1006 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2896,6 +2896,12 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_conn_max_interval = 0x0038;
 	hdev->le_conn_latency = 0x0000;
 	hdev->le_supv_timeout = 0x002a;
+	hdev->le_def_tx_len = 0x001b;
+	hdev->le_def_tx_time = 0x0148;
+	hdev->le_max_tx_len = 0x001b;
+	hdev->le_max_tx_time = 0x0148;
+	hdev->le_max_rx_len = 0x001b;
+	hdev->le_max_rx_time = 0x0148;
 
 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
 	hdev->discov_interleaved_timeout = DISCOV_INTERLEAVED_TIMEOUT;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a412eb1e1f61..a3055e90a5bb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1280,6 +1280,55 @@ static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
 	memcpy(hdev->le_states, rp->le_states, 8);
 }
 
+static void hci_cc_le_read_def_data_len(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	struct hci_rp_le_read_def_data_len *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hdev->le_def_tx_len = le16_to_cpu(rp->tx_len);
+	hdev->le_def_tx_time = le16_to_cpu(rp->tx_time);
+}
+
+static void hci_cc_le_write_def_data_len(struct hci_dev *hdev,
+					 struct sk_buff *skb)
+{
+	struct hci_cp_le_write_def_data_len *sent;
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_WRITE_DEF_DATA_LEN);
+	if (!sent)
+		return;
+
+	hdev->le_def_tx_len = le16_to_cpu(sent->tx_len);
+	hdev->le_def_tx_time = le16_to_cpu(sent->tx_time);
+}
+
+static void hci_cc_le_read_max_data_len(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	struct hci_rp_le_read_max_data_len *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hdev->le_max_tx_len = le16_to_cpu(rp->tx_len);
+	hdev->le_max_tx_time = le16_to_cpu(rp->tx_time);
+	hdev->le_max_rx_len = le16_to_cpu(rp->rx_len);
+	hdev->le_max_rx_time = le16_to_cpu(rp->rx_time);
+}
+
 static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
@@ -2847,6 +2896,18 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_le_read_supported_states(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_DEF_DATA_LEN:
+		hci_cc_le_read_def_data_len(hdev, skb);
+		break;
+
+	case HCI_OP_LE_WRITE_DEF_DATA_LEN:
+		hci_cc_le_write_def_data_len(hdev, skb);
+		break;
+
+	case HCI_OP_LE_READ_MAX_DATA_LEN:
+		hci_cc_le_read_max_data_len(hdev, skb);
+		break;
+
 	case HCI_OP_WRITE_LE_HOST_SUPPORTED:
 		hci_cc_write_le_host_supported(hdev, skb);
 		break;
-- 
2.1.0

