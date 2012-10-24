Return-Path: <cyrus@holtmann.org>
From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>,
	Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [RFC 1/9] Bluetooth: Add HCI command to set advertising parameters
Date: Wed, 24 Oct 2012 12:58:07 -0300
Message-Id: <1351094295-10418-2-git-send-email-aloisio.almeida@openbossa.org>
In-Reply-To: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
References: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Add command to set advertising parameters before enable it.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 include/net/bluetooth/hci.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 348f4bf..c539314 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -938,6 +938,20 @@ struct hci_rp_le_read_adv_tx_power {
 	__s8	tx_power;
 } __packed;
 
+#define ADV_USE_ALL_CHANNELS		0x07
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
 #define HCI_OP_LE_SET_SCAN_PARAM	0x200b
 struct hci_cp_le_set_scan_param {
 	__u8    type;
-- 
1.7.10.4

