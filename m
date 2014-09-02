Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/5] android/bluetooth: Improve sending bond state notification
Date: Tue,  2 Sep 2014 15:55:01 +0200
Message-Id: <1409666103-14663-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409666103-14663-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409666103-14663-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes sure that any bond state changes of remote device is
corretly distributed to Android framework.
---
 android/bluetooth.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 94ddf75..390a3a2 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -884,13 +884,14 @@ static void update_bond_state(struct device *dev, uint8_t status,
 		return;
 
 	/*
-	 * For incoming just works bonding we will switch here from
-	 * non bonded to bonded directly. This is something Android
-	 * will not handle in their bond state machine. To make Android
-	 * handle it corretly we need to send BONDING state before BOND
+	 * When internal bond state changes from bond to non-bond or other way,
+	 * BfA needs to send bonding state to Android in the middle. Otherwise
+	 * Android will not handle it correctly
 	 */
-	if (old_bond == HAL_BOND_STATE_NONE &&
-				new_bond == HAL_BOND_STATE_BONDED)
+	if ((old_bond == HAL_BOND_STATE_NONE &&
+				new_bond == HAL_BOND_STATE_BONDED) ||
+				(old_bond == HAL_BOND_STATE_BONDED &&
+				new_bond == HAL_BOND_STATE_NONE))
 		send_bond_state_change(dev, HAL_STATUS_SUCCESS,
 						HAL_BOND_STATE_BONDING);
 
-- 
1.8.4

