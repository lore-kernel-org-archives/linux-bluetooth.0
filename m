Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/5] android/bluetooth: Fix status in "fake" bonding notification
Date: Tue,  2 Sep 2014 15:55:00 +0200
Message-Id: <1409666103-14663-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409666103-14663-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409666103-14663-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When sending "fake" bonding" we should use SUCCESS status
---
 android/bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 7c3c198..94ddf75 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -891,7 +891,7 @@ static void update_bond_state(struct device *dev, uint8_t status,
 	 */
 	if (old_bond == HAL_BOND_STATE_NONE &&
 				new_bond == HAL_BOND_STATE_BONDED)
-		send_bond_state_change(dev, status,
+		send_bond_state_change(dev, HAL_STATUS_SUCCESS,
 						HAL_BOND_STATE_BONDING);
 
 	send_bond_state_change(dev, status, new_bond);
-- 
1.8.4

