Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: Add LE Set Scan Parameter Command
Date: Fri, 11 Nov 2011 19:50:20 -0300
Message-Id: <1321051824-5216-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 70321a1..bd3cecd 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -768,6 +768,15 @@ struct hci_rp_le_read_buffer_size {
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
1.7.7.1

