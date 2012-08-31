Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] thermometer: Fix indentation
Date: Fri, 31 Aug 2012 10:51:24 +0200
Message-ID: <1346403084-9587-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/thermometer/manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/thermometer/manager.c b/profiles/thermometer/manager.c
index 3d5452b..21cb5fe 100644
--- a/profiles/thermometer/manager.c
+++ b/profiles/thermometer/manager.c
@@ -77,7 +77,7 @@ int thermometer_manager_init(DBusConnection *conn)
 
 	ret = btd_register_device_driver(&thermometer_device_driver);
 	if (ret < 0)
-                return ret;
+		return ret;
 
 	connection = dbus_connection_ref(conn);
 	return 0;
-- 
1.7.11.3

