Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] android: Update haltest tool entry in README
Date: Thu,  5 Dec 2013 11:37:11 +0100
Message-Id: <1386239837-4102-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update informations about 'adapter' interface being renamed to 'bluetooth' and
init being called on haltest startup by default.

---
 android/README | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/android/README b/android/README
index 6c2c53f..68c3e9f 100644
--- a/android/README
+++ b/android/README
@@ -82,9 +82,12 @@ Testing tool
 ============
 
 BT HAL test tools located in android/haltest is provided for HAL level testing
-of both Android daemon and HAL library. Start it and type 'adapter init' in
-prompt to initialize HAL library. On Android required bluetoothd service will
-be started automatically. On Linux it is required to start android/bluetoothd
-manually before init command timeout. To deinitialize HAL library and stop
-daemon type 'adapter cleanup'. Type 'help' for more information. Tab completion
-is also supported.
+of both Android daemon and HAL library. Start it with '-n' parameter and type
+'bluetooth init' in prompt to initialize HAL library. Running without parameter
+will make haltest try to initialize all services after start. On Android
+required bluetoothd service will be started automatically. On Linux it is
+required to start android/bluetoothd manually before init command timeout or
+use provided android/system-emulator, which takes care of launching daemon
+automatically on HAL library initialization. To deinitialize HAL library and
+stop daemon type 'bluetooth cleanup'. Type 'help' for more information. Tab
+completion is also supported.
-- 
1.8.5

