Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 2/4] cups: Fix D-Bus reply memory leaks
Date: Tue, 06 Dec 2011 20:29:16 +0530
Message-id: <1323183558-26574-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1323183558-26574-1-git-send-email-s.syam@samsung.com>
References: <1323183558-26574-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 cups/main.c |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/cups/main.c b/cups/main.c
index 7f3f4b0..a884c6e 100644
--- a/cups/main.c
+++ b/cups/main.c
@@ -348,10 +348,15 @@ static void remote_device_found(const char *adapter, const char *bdaddr,
 
 		dbus_message_unref(message);
 
+		if (!adapter_reply)
+			return;
+
 		if (dbus_message_get_args(adapter_reply, NULL,
 					DBUS_TYPE_OBJECT_PATH, &adapter,
-					DBUS_TYPE_INVALID) == FALSE)
+					DBUS_TYPE_INVALID) == FALSE) {
+			dbus_message_unref(adapter_reply);
 			return;
+		}
 	}
 
 	message = dbus_message_new_method_call("org.bluez", adapter,
@@ -386,12 +391,16 @@ static void remote_device_found(const char *adapter, const char *bdaddr,
 
 	if (dbus_message_get_args(reply, NULL,
 					DBUS_TYPE_OBJECT_PATH, &object_path,
-					DBUS_TYPE_INVALID) == FALSE)
+					DBUS_TYPE_INVALID) == FALSE) {
+		dbus_message_unref(reply);
 		return;
+	}
 
 	id = device_get_ieee1284_id(adapter, object_path);
 	add_device_to_list(name, bdaddr, id);
 	g_free(id);
+
+	dbus_message_unref(reply);
 }
 
 static void discovery_completed(void)
@@ -642,10 +651,15 @@ static gboolean print_ieee1284(const char *bdaddr)
 
 	dbus_message_unref(message);
 
+	if (!adapter_reply)
+		return FALSE;
+
 	if (dbus_message_get_args(adapter_reply, NULL,
 			DBUS_TYPE_OBJECT_PATH, &adapter,
-			DBUS_TYPE_INVALID) == FALSE)
+			DBUS_TYPE_INVALID) == FALSE) {
+		dbus_message_unref(adapter_reply);
 		return FALSE;
+	}
 
 	message = dbus_message_new_method_call("org.bluez", adapter,
 			"org.bluez.Adapter",
@@ -680,15 +694,21 @@ static gboolean print_ieee1284(const char *bdaddr)
 
 	if (dbus_message_get_args(reply, NULL,
 					DBUS_TYPE_OBJECT_PATH, &object_path,
-					DBUS_TYPE_INVALID) == FALSE)
+					DBUS_TYPE_INVALID) == FALSE) {
+		dbus_message_unref(reply);
 		return FALSE;
+	}
 
 	id = device_get_ieee1284_id(adapter, object_path);
-	if (id == NULL)
+	if (id == NULL) {
+		dbus_message_unref(reply);
 		return FALSE;
+	}
 	printf("%s", id);
 	g_free(id);
 
+	dbus_message_unref(reply);
+
 	return TRUE;
 }
 
-- 
1.7.4.1

