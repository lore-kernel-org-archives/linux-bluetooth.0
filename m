Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC 1/5] Bluetooth: Add new commands HCI for LE and BR/EDR
Date: Fri, 10 Aug 2012 17:01:43 -0400
Message-Id: <1344632507-21381-2-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1344632507-21381-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1344632507-21381-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add some commands to control Advertising data.

Signed-off-by: Jefferson Delfes <jefferson.delfes@openbossa.org>
---
 include/net/bluetooth/hci.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 23cf413..e4d4717 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -326,6 +326,8 @@ enum {
 #define EIR_SSP_HASH_C		0x0E /* Simple Pairing Hash C */
 #define EIR_SSP_RAND_R		0x0F /* Simple Pairing Randomizer R */
 #define EIR_DEVICE_ID		0x10 /* device ID */
+#define EIR_SERVICE_DATA	0x16 /* Service Data */
+#define EIR_MANUFACTURER_DATA	0xFF /* Manufacturer Specific Data */
 
 /* -----  HCI Commands ---- */
 #define HCI_OP_NOP			0x0000
@@ -891,6 +893,32 @@ struct hci_rp_le_read_buffer_size {
 	__u8     le_max_pkt;
 } __packed;
 
+#define ADV_USE_ALL_CHANNELS	0x07
+
+#define HCI_OP_LE_SET_ADV_PARAMS	0x2006
+struct hci_cp_le_set_adv_params {
+	__le16   interval_min;
+	__le16   interval_max;
+	__u8     type;
+	__u8     own_address_type;
+	__u8     direct_address_type;
+	__u8     direct_address[6];
+	__u8     channel_map;
+	__u8     filter_policy;
+} __packed;
+
+#define HCI_MAX_ADV_LENGTH		31
+
+#define HCI_OP_LE_SET_ADV_DATA		0x2008
+struct hci_cp_le_set_adv_data {
+	__u8     data_len;
+	__u8     data[HCI_MAX_ADV_LENGTH];
+} __packed;
+
+#define HCI_OP_LE_SET_ADV_ENABLE	0x200a
+	#define ADVERTISING_DISABLE	0x00
+	#define ADVERTISING_ENABLE	0x01
+
 #define HCI_OP_LE_SET_SCAN_PARAM	0x200b
 struct hci_cp_le_set_scan_param {
 	__u8    type;
-- 
1.7.11.4

