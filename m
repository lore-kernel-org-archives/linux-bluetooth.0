Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 01/15] cups: Remove unnecessary code
Date: Thu, 29 Nov 2012 13:47:22 +0100
Message-Id: <1354193256-30610-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The adapter is always known so the code to handle the NULL case is not
needed.
---
 profiles/cups/main.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/profiles/cups/main.c b/profiles/cups/main.c
index 5aa927f..977c057 100644
--- a/profiles/cups/main.c
+++ b/profiles/cups/main.c
@@ -31,6 +31,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <assert.h>
 #include <signal.h>
 #include <sys/socket.h>
 #include <glib.h>
@@ -338,26 +339,7 @@ static void remote_device_found(const char *adapter, const char *bdaddr,
 
 	adapter_reply = NULL;
 
-	if (adapter == NULL) {
-		message = dbus_message_new_method_call("org.bluez", "/",
-							"org.bluez.Manager",
-							"DefaultAdapter");
-
-		adapter_reply = dbus_connection_send_with_reply_and_block(conn,
-							message, -1, NULL);
-
-		dbus_message_unref(message);
-
-		if (!adapter_reply)
-			return;
-
-		if (dbus_message_get_args(adapter_reply, NULL,
-					DBUS_TYPE_OBJECT_PATH, &adapter,
-					DBUS_TYPE_INVALID) == FALSE) {
-			dbus_message_unref(adapter_reply);
-			return;
-		}
-	}
+	assert(adapter != NULL);
 
 	message = dbus_message_new_method_call("org.bluez", adapter,
 							"org.bluez.Adapter",
-- 
1.7.11.7

