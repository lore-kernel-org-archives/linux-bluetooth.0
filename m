Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android: Add WBS mode to handsfree HAL
Date: Mon, 17 Mar 2014 13:40:21 +0100
Message-Id: <1395060022-478-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds additional modes for Handsfree HAL:
  0x00 = Headset Profile only mode (default)
  0x01 = Handsfree Profile (narrowband speech)
  0x02 = Handsfree Profile (narrowband and wideband speech)

Currently wideband mode requires chip to assume that eSCO transparent
data is mSBC.
---
 android/hal-ipc-api.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index e4a4e9c..5613e85 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -756,7 +756,9 @@ Bluetooth Handsfree HAL (ID 5)
 
 Android HAL name: "handsfree" (BT_PROFILE_HANDSFREE_ID)
 
-	Service modes:               0x01 = Headset Profile only mode
+	Service modes: 0x00 = Headset Profile only mode (default)
+	               0x01 = Handsfree Profile (narrowband speech)
+	               0x02 = Handsfree Profile (narrowband and wideband speech)
 
 Commands and responses:
 
-- 
1.8.5.3

