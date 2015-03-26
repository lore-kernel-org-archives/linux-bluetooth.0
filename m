Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix minor typo in comment for static address setting
Date: Wed, 25 Mar 2015 18:32:13 -0700
Message-Id: <1427333533-31103-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 38b03bd14723..f95937c47b9e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -693,7 +693,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	 * the second is to indicate if it is actually set.
 	 *
 	 * This means if the static address is not configured, this flag
-	 * will never bet set. If the address is configured, then if the
+	 * will never be set. If the address is configured, then if the
 	 * address is actually used decides if the flag is set or not.
 	 *
 	 * For single mode LE only controllers and dual-mode controllers
-- 
2.1.0

