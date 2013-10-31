Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] android/daemon: Fix not reporting scan mode to Java
Date: Thu, 31 Oct 2013 14:42:35 +0200
Message-Id: <1383223355-4628-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

After set_adapter_property() higher layer expects callback to be returned
even if property is not changes. Otherwise Java timeouts and reset Bluetooth
enetring to the loop.
...
BluetoothAdapterState( 2850): Timeout will setting scan mode..
  Continuing with disable...
...
---
 android/adapter.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 892e6bb..3622a72 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -631,21 +631,21 @@ static uint8_t set_scan_mode(void *buf, uint16_t len)
 	switch (*mode) {
 	case HAL_ADAPTER_SCAN_MODE_NONE:
 		if (!cur_conn && !cur_disc)
-			return HAL_STATUS_DONE;
+			goto done;
 
 		conn = false;
 		disc = false;
 		break;
 	case HAL_ADAPTER_SCAN_MODE_CONN:
 		if (cur_conn && !cur_disc)
-			return HAL_STATUS_DONE;
+			goto done;
 
 		conn = true;
 		disc = false;
 		break;
 	case HAL_ADAPTER_SCAN_MODE_CONN_DISC:
 		if (cur_conn && cur_disc)
-			return HAL_STATUS_DONE;
+			goto done;
 
 		conn = true;
 		disc = true;
@@ -665,6 +665,12 @@ static uint8_t set_scan_mode(void *buf, uint16_t len)
 	}
 
 	return HAL_STATUS_SUCCESS;
+
+done:
+	/* Android expects property changed callback */
+	scan_mode_changed();
+
+	return HAL_STATUS_DONE;
 }
 
 static uint8_t set_property(void *buf, uint16_t len)
-- 
1.7.10.4

