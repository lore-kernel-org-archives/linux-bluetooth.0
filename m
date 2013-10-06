Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add HCI structure for LE advertising parameters command
Date: Sun,  6 Oct 2013 02:34:38 -0700
Message-Id: <1381052078-59755-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add the basic HCI structure for building the LE advertising parameters
command.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 9f8d1c1..9b0e3f9 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1046,6 +1046,18 @@ struct hci_rp_le_read_local_features {
 
 #define HCI_OP_LE_SET_RANDOM_ADDR	0x2005
 
+#define HCI_OP_LE_SET_ADV_PARAM		0x2006
+struct hci_cp_le_set_adv_param {
+	__le16   min_interval;
+	__le16   max_interval;
+	__u8     type;
+	__u8     own_address_type;
+	__u8     direct_addr_type;
+	bdaddr_t direct_addr;
+	__u8     channel_map;
+	__u8     filter_policy;
+} __packed;
+
 #define HCI_OP_LE_READ_ADV_TX_POWER	0x2007
 struct hci_rp_le_read_adv_tx_power {
 	__u8	status;
-- 
1.8.3.1

