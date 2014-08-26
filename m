Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/5] android/bluetooth: Fix incoming just works bonding
Date: Tue, 26 Aug 2014 22:41:48 +0200
Message-Id: <1409085712-12402-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch Android framework will be notified about bonded device
which initiated bonding and used just works association model.
---
 android/bluetooth.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 984ecba..96f6101 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -889,8 +889,20 @@ static void update_device_state(struct device *dev, uint8_t addr_type,
 
 	new_bond = device_bond_state(dev);
 
-	if (old_bond != new_bond)
+	if (old_bond != new_bond) {
+		/*
+		 * For incoming just works bonding we will switch here from
+		 * non bonded to bonded directly. This is something Android
+		 * will not handle in their bond state machine. To make Android
+		 * handle it corretly we need to send BONDING state before BOND
+		 */
+		if (old_bond == HAL_BOND_STATE_NONE &&
+					new_bond == HAL_BOND_STATE_BONDED)
+			send_bond_state_change(dev, status,
+							HAL_BOND_STATE_BONDING);
+
 		send_bond_state_change(dev, status, new_bond);
+	}
 }
 
 static void send_device_property(struct device *dev, uint8_t type,
-- 
1.8.4

