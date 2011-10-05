Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 12/15] Bluetooth: Add LE Set Scan Parameter Command
Date: Wed,  5 Oct 2011 20:20:44 -0300
Message-Id: <1317856847-28167-13-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
References: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1e11e7f..11537b8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -739,6 +739,15 @@ struct hci_rp_le_read_buffer_size {
 	__u8     le_max_pkt;
 } __packed;
 
+#define HCI_OP_LE_SET_SCAN_PARAM	0x200b
+struct hci_cp_le_set_scan_param {
+	__u8    type;
+	__le16  interval;
+	__le16  window;
+	__u8    own_address_type;
+	__u8    filter_policy;
+} __packed;
+
 #define HCI_OP_LE_SET_SCAN_ENABLE	0x200c
 struct hci_cp_le_set_scan_enable {
 	__u8     enable;
-- 
1.7.5.2

