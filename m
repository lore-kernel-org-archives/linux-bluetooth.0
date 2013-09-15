Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/8] Bluetooth: Remove unused event mask struct
Date: Sun, 15 Sep 2013 21:16:34 +0300
Message-Id: <1379269001-6313-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1379269001-6313-1-git-send-email-johan.hedberg@gmail.com>
References: <1379269001-6313-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The struct for HCI_Set_Event_Mask is never used. Instead a local 8-byte
array is used for sending this command. Therefore, remove the
unnecessary struct definition.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 57aa408..7ede266 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -695,9 +695,6 @@ struct hci_cp_sniff_subrate {
 } __packed;
 
 #define HCI_OP_SET_EVENT_MASK		0x0c01
-struct hci_cp_set_event_mask {
-	__u8     mask[8];
-} __packed;
 
 #define HCI_OP_RESET			0x0c03
 
-- 
1.8.4.rc3

