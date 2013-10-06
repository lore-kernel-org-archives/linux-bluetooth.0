Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add constants for LE advertising types
Date: Sun,  6 Oct 2013 03:03:46 -0700
Message-Id: <1381053826-10075-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add constants for ADV_IND, ADV_DIRECT_IND, ADV_SCAN_IND and
ADV_NONCONN_IND advertising types.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 9b0e3f9..3616ea7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1046,6 +1046,11 @@ struct hci_rp_le_read_local_features {
 
 #define HCI_OP_LE_SET_RANDOM_ADDR	0x2005
 
+#define LE_ADV_IND			0x00
+#define LE_ADV_DIRECT_IND		0x01
+#define LE_ADV_SCAN_IND			0x02
+#define LE_ADV_NONCONN_IND		0x03
+
 #define HCI_OP_LE_SET_ADV_PARAM		0x2006
 struct hci_cp_le_set_adv_param {
 	__le16   min_interval;
-- 
1.8.3.1

