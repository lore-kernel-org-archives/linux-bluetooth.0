Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/2] Bluetooth: Fix setting Universal/Local bit
Date: Tue,  7 Jan 2014 09:07:47 -0300
Message-Id: <1389096468-2917-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the Bluetooth Low Energy Address type checking when
setting Universal/Local bit for the 6loWPAN network device or for the
peer device connection.

ADDR_LE_DEV_PUBLIC or ADDR_LE_DEV_RANDOM are the values allowed for
"src_type" and "dst_type" in the hci_conn struct. The Bluetooth link
type can be obtainned reading the "type" field in the same struct.

Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
---
 net/bluetooth/6lowpan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 5f0b11d..ab4e771 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -623,7 +623,7 @@ static void set_addr(u8 *eui, u8 *addr, u8 addr_type)
 	eui[0] ^= 2;
 
 	/* Universal/local bit set, RFC 4291 */
-	if (addr_type == BDADDR_LE_PUBLIC)
+	if (addr_type == ADDR_LE_DEV_PUBLIC)
 		eui[0] |= 1;
 	else
 		eui[0] &= ~1;
-- 
1.8.3.1

