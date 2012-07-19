Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove missing code
Date: Thu, 19 Jul 2012 11:46:13 -0300
Message-Id: <1342709173-4967-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the struct adv_entry since it is not used anymore.
This struct should have been removed in commit 479453d (Bluetooth:
Remove advertising cache).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 475b8c0..41b2664 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -115,12 +115,6 @@ struct oob_data {
 	u8 randomizer[16];
 };
 
-struct adv_entry {
-	struct list_head list;
-	bdaddr_t bdaddr;
-	u8 bdaddr_type;
-};
-
 struct le_scan_params {
 	u8 type;
 	u16 interval;
-- 
1.7.11.2

