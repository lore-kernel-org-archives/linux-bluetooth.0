Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 05/18] core: gatt: Fix malformed error name in client API
Date: Fri, 20 Feb 2015 17:56:50 -0800
Message-Id: <1424483824-27374-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1424483824-27374-1-git-send-email-armansito@chromium.org>
References: <1424483824-27374-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed error name from 'org.bluez.Error' to 'org.bluez.Error.Failed'.
---
 src/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 9811bd8..0364e23 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -292,7 +292,7 @@ static DBusMessage *create_gatt_dbus_error(DBusMessage *msg, uint8_t att_ecode)
 	case 0:
 		return btd_error_failed(msg, "Operation failed");
 	default:
-		return g_dbus_create_error(msg, ERROR_INTERFACE,
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
 				"Operation failed with ATT error: 0x%02x",
 				att_ecode);
 	}
-- 
2.2.0.rc0.207.ga3a616c

