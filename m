Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use macro instead of hard-coded value
Date: Wed, 25 Jun 2014 16:44:45 -0300
Message-Id: <1403725485-29556-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces the hard-coded value in hci_bdaddr_is_rpa() helper
by the corresponding macro ADDR_LE_DEV_RANDOM.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0b0597d..dda7f00 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1155,7 +1155,7 @@ static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
 
 static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
 {
-	if (addr_type != 0x01)
+	if (addr_type != ADDR_LE_DEV_RANDOM)
 		return false;
 
 	if ((bdaddr->b[5] & 0xc0) == 0x40)
-- 
1.9.1

