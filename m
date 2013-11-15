Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/hal: Merge bluetooth and sock register/unregister
Date: Fri, 15 Nov 2013 12:13:53 +0200
Message-Id: <1384510435-17497-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Bluetooth and Socket HAL are registered and unregistered at the
same time.
---
 android/main.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/android/main.c b/android/main.c
index a4f5e84..f72004c 100644
--- a/android/main.c
+++ b/android/main.c
@@ -87,10 +87,11 @@ static void service_register(void *buf, uint16_t len)
 		if (!bt_bluetooth_register(sk))
 			goto failed;
 
-		break;
-	case HAL_SERVICE_ID_SOCK:
-		if (!bt_socket_register(sk, &adapter_bdaddr))
+		if (!bt_socket_register(sk, &adapter_bdaddr)) {
+			bt_bluetooth_unregister();
 			goto failed;
+		}
+		services[HAL_SERVICE_ID_SOCK] = true;
 
 		break;
 	case HAL_SERVICE_ID_HIDHOST:
@@ -135,8 +136,6 @@ static void service_unregister(void *buf, uint16_t len)
 	switch (m->service_id) {
 	case HAL_SERVICE_ID_BLUETOOTH:
 		bt_bluetooth_unregister();
-		break;
-	case HAL_SERVICE_ID_SOCK:
 		bt_socket_unregister();
 		break;
 	case HAL_SERVICE_ID_HIDHOST:
-- 
1.7.10.4

