Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: Remove unused h4->rx_state and h4->rx_count field
Date: Sat,  4 Apr 2015 20:29:27 -0700
Message-Id: <1428204567-4467-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The fields h4->rx_state and h4->rx_count are not used at all and with
that they can be just removed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_h4.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 3ea8f0886ed1..0d9ba07d2730 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -49,8 +49,6 @@
 #define VERSION "1.2"
 
 struct h4_struct {
-	unsigned long rx_state;
-	unsigned long rx_count;
 	struct sk_buff_head txq;
 };
 
-- 
2.1.0

