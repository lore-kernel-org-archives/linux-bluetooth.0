Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 2/2] Add missing format specifiers in src/error.c
Date: Sat, 27 Dec 2014 00:31:24 +0100
Message-Id: <1419636684-7158-2-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1419636684-7158-1-git-send-email-mariusz.skamra@tieto.com>
References: <1419636684-7158-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/error.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/error.c b/src/error.c
index a80c1ab..ae227b6 100644
--- a/src/error.c
+++ b/src/error.c
@@ -40,7 +40,7 @@ DBusMessage *btd_error_invalid_args(DBusMessage *msg)
 DBusMessage *btd_error_invalid_args_str(DBusMessage *msg, const char *str)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
-									str);
+					"%s", str);
 }
 
 DBusMessage *btd_error_busy(DBusMessage *msg)
@@ -99,7 +99,8 @@ DBusMessage *btd_error_not_authorized(DBusMessage *msg)
 
 DBusMessage *btd_error_not_permitted(DBusMessage *msg, const char *str)
 {
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotPermitted", str);
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotPermitted",
+					"%s", str);
 }
 
 DBusMessage *btd_error_no_such_adapter(DBusMessage *msg)
-- 
1.9.1

