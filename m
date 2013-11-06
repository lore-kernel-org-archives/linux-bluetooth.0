Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] android: Change name for get_disc_timeout
Date: Wed, 6 Nov 2013 16:08:49 +0100
Message-ID: <1383750530-18815-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change name to get_discoverable_timeout. Previous name could be
confusing with disconnection timeout.
---
 android/adapter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index cf5edcd..1d462c8 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -1284,7 +1284,7 @@ static bool get_devices(void)
 	return false;
 }
 
-static bool get_disc_timeout(void)
+static bool get_discoverable_timeout(void)
 {
 	DBG("Not implemented");
 
@@ -1316,7 +1316,7 @@ static bool get_property(void *buf, uint16_t len)
 	case HAL_PROP_ADAPTER_BONDED_DEVICES:
 		return get_devices();
 	case HAL_PROP_ADAPTER_DISC_TIMEOUT:
-		return get_disc_timeout();
+		return get_discoverable_timeout();
 	default:
 		return false;
 	}
@@ -1332,7 +1332,7 @@ static void get_properties(void)
 	get_service();
 	get_scan_mode();
 	get_devices();
-	get_disc_timeout();
+	get_discoverable_timeout();
 }
 
 static bool start_discovery(void)
-- 
1.8.4

