Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/12] cups: Remove dead code
Date: Fri,  4 Jul 2014 16:44:00 +0300
Message-Id: <1404481441-734-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/cups/main.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/profiles/cups/main.c b/profiles/cups/main.c
index 2079812..11ce72f 100644
--- a/profiles/cups/main.c
+++ b/profiles/cups/main.c
@@ -332,13 +332,11 @@ static gboolean device_is_printer(const char *adapter, const char *device_path,
 static void remote_device_found(const char *adapter, const char *bdaddr,
 							const char *name)
 {
-	DBusMessage *message, *reply, *adapter_reply;
+	DBusMessage *message, *reply;
 	DBusMessageIter iter;
 	char *object_path = NULL;
 	char *id;
 
-	adapter_reply = NULL;
-
 	assert(adapter != NULL);
 
 	message = dbus_message_new_method_call("org.bluez", adapter,
@@ -347,9 +345,6 @@ static void remote_device_found(const char *adapter, const char *bdaddr,
 	dbus_message_iter_init_append(message, &iter);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
 
-	if (adapter_reply != NULL)
-		dbus_message_unref(adapter_reply);
-
 	reply = dbus_connection_send_with_reply_and_block(conn,
 							message, -1, NULL);
 
-- 
1.9.1

