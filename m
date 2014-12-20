Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add structures for LE Data Length Extension feature
Date: Sat, 20 Dec 2014 16:28:38 +0100
Message-Id: <1419089320-14498-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the structures for HCI commands and events of the
LE Data Length Extension feature from Bluetooth 4.2 specification.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 40129b3838b2..f39926ee06f7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -343,6 +343,7 @@ enum {
 #define HCI_LE_ENCRYPTION		0x01
 #define HCI_LE_CONN_PARAM_REQ_PROC	0x02
 #define HCI_LE_PING			0x10
+#define HCI_LE_DATA_LEN_EXT		0x20
 #define HCI_LE_EXT_SCAN_POLICY		0x80
 
 /* Connection modes */
@@ -1371,6 +1372,39 @@ struct hci_cp_le_conn_param_req_neg_reply {
 	__u8	reason;
 } __packed;
 
+#define HCI_OP_LE_SET_DATA_LEN		0x2022
+struct hci_cp_le_set_data_len {
+	__le16	handle;
+	__le16	tx_len;
+	__le16	tx_time;
+} __packed;
+struct hci_rp_le_set_data_len {
+	__u8	status;
+	__le16	handle;
+} __packed;
+
+#define HCI_OP_LE_READ_DEF_DATA_LEN	0x2023
+struct hci_rp_le_read_def_data_len {
+	__u8	status;
+	__le16	tx_len;
+	__le16	tx_time;
+} __packed;
+
+#define HCI_OP_LE_WRITE_DEF_DATA_LEN	0x2024
+struct hci_cp_le_write_def_data_len {
+	__le16	tx_len;
+	__le16	tx_time;
+} __packed;
+
+#define HCI_OP_LE_READ_MAX_DATA_LEN	0x202f
+struct hci_rp_le_read_max_data_len {
+	__u8	status;
+	__le16	tx_len;
+	__le16	tx_time;
+	__le16	rx_len;
+	__le16	rx_time;
+} __packed;
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
@@ -1796,6 +1830,15 @@ struct hci_ev_le_remote_conn_param_req {
 	__le16 timeout;
 } __packed;
 
+#define HCI_EV_LE_DATA_LEN_CHANGE	0x07
+struct hci_ev_le_data_len_change {
+	__le16	handle;
+	__le16	tx_len;
+	__le16	tx_time;
+	__le16	rx_len;
+	__le16	rx_time;
+} __packed;
+
 #define HCI_EV_LE_DIRECT_ADV_REPORT	0x0B
 struct hci_ev_le_direct_adv_info {
 	__u8	 evt_type;
-- 
2.1.0

