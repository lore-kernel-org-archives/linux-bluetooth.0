Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>,
	Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [PATCH 01/12] Bluetooth: Add HCI command to set advertising parameters
Date: Fri, 14 Dec 2012 14:51:27 -0400
Message-Id: <1355511098-10190-2-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add command to set advertising parameters before enable it.

Signed-off-by: Jefferson Delfes <jefferson.delfes@openbossa.org>
Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 include/net/bluetooth/hci.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 45eee08..e89311d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -959,6 +959,20 @@ struct hci_cp_le_set_adv_data {
 
 #define HCI_OP_LE_SET_ADV_ENABLE	0x200a
 
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
1.8.0.2

