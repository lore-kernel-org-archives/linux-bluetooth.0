Return-Path: <a.s.protopopov@gmail.com>
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH] Bluetooth: hci_intel: Fix a wrong comparison
Date: Wed, 10 Feb 2016 12:22:54 -0500
Message-Id: <1455124974-27428-1-git-send-email-a.s.protopopov@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

A return value of the intel_wait_booting() function compared with
a constant ETIMEDOUT instead of -ETIMEDOUT.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 drivers/bluetooth/hci_intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 3d63ea3..91d6051 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -488,7 +488,7 @@ static int intel_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	clear_bit(STATE_BOOTING, &intel->flags);
 
 	/* In case of timeout, try to continue anyway */
-	if (err && err != ETIMEDOUT)
+	if (err && err != -ETIMEDOUT)
 		return err;
 
 	bt_dev_info(hdev, "Change controller speed to %d", speed);
@@ -581,7 +581,7 @@ static int intel_setup(struct hci_uart *hu)
 	clear_bit(STATE_BOOTING, &intel->flags);
 
 	/* In case of timeout, try to continue anyway */
-	if (err && err != ETIMEDOUT)
+	if (err && err != -ETIMEDOUT)
 		return err;
 
 	set_bit(STATE_BOOTLOADER, &intel->flags);
-- 
2.6.5
