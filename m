Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@gmail.com>
Subject: [PATCH 4/4] android/gatt: Fix autoconnect
Date: Thu, 30 Apr 2015 13:26:18 +0200
Message-Id: <1430393178-29983-4-git-send-email-mariusz.skamra@gmail.com>
In-Reply-To: <1430393178-29983-1-git-send-email-mariusz.skamra@gmail.com>
References: <1430393178-29983-1-git-send-email-mariusz.skamra@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes autoconnect issue, however there is also race hazard in
Android Gatt framework. If app uses autoconnect while connecting,
direct flag is set to false. Then bt_gatt_add_autoconnect should be called
to add this app's id to autoconnect_apps queue.
---
 android/gatt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/gatt.c b/android/gatt.c
index 4da959f..72a27ab 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1972,6 +1972,7 @@ static bool trigger_connection(struct app_connection *conn, bool direct)
 		if (direct)
 			return connect_le(conn->device) == 0;
 
+		bt_gatt_add_autoconnect(conn->app->id, &conn->device->bdaddr);
 		return auto_connect_le(conn->device);
 	case DEVICE_CONNECTED:
 		notify_app_connect_status(conn, GATT_SUCCESS);
-- 
1.9.1

