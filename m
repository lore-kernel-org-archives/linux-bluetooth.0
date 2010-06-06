Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Get IEEE1284 for a single printer
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-hPSSxYDqqBeYjI+iFwS3"
Date: Sun, 06 Jun 2010 19:42:24 +0100
Message-ID: <1275849744.7994.38.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-hPSSxYDqqBeYjI+iFwS3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Heya,

Discussed printer setup integration with Tim Waugh, and we came to the
idea that the current framework for USB printers could be reused for
Bluetooth ones.

The differences would be:
- add code to fetch a single printer's IEEE1284 device ID to the
Bluetooth cups backend (the attached patch)
- add special handling in udev-configure-printer for Bluetooth printers
(we get the IEEE1284 device ID from the cups backend helper)
https://fedorahosted.org/system-config-printer/ticket/207
- Add plugin to bluetoothd to call udev-configure-printer when printers
are paired, or unpaired (not written yet)

Let me know what you think. The patch below could still be useful for
debugging (in the worst case).

Cheers

--=-hPSSxYDqqBeYjI+iFwS3
Content-Disposition: attachment; filename="0001-cups-Add-ability-to-print-IEEE1284-device-ID.patch"
Content-Type: text/x-patch; name="0001-cups-Add-ability-to-print-IEEE1284-device-ID.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From da8e0589d687cb3f24eab46259d179fd830cd088 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sun, 6 Jun 2010 15:48:26 +0100
Subject: [PATCH] (cups) Add ability to print IEEE1284 device ID

Add ability to print IEEE1284 device ID for Bluetooth
printers to allow auto-configuration once paired.
---
 cups/main.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/cups/main.c b/cups/main.c
index 9659a11..00933b6 100644
--- a/cups/main.c
+++ b/cups/main.c
@@ -605,6 +605,75 @@ static gboolean list_printers(void)
 	return TRUE;
 }
 
+static gboolean print_ieee1284(const char *bdaddr)
+{
+	DBusMessage *message, *reply, *adapter_reply;
+	DBusMessageIter iter;
+	char *object_path = NULL;
+	char *adapter;
+	char *id;
+
+	adapter_reply = NULL;
+
+	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
+	if (conn == NULL)
+		return FALSE;
+
+	message = dbus_message_new_method_call("org.bluez", "/",
+					       "org.bluez.Manager",
+					       "DefaultAdapter");
+
+	adapter_reply = dbus_connection_send_with_reply_and_block(conn,
+								  message, -1, NULL);
+
+	dbus_message_unref(message);
+
+	if (dbus_message_get_args(adapter_reply, NULL, DBUS_TYPE_OBJECT_PATH, &adapter, DBUS_TYPE_INVALID) == FALSE)
+		return FALSE;
+
+	message = dbus_message_new_method_call("org.bluez", adapter,
+					       "org.bluez.Adapter",
+					       "FindDevice");
+	dbus_message_iter_init_append(message, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
+
+	if (adapter_reply != NULL)
+		dbus_message_unref(adapter_reply);
+
+	reply = dbus_connection_send_with_reply_and_block(conn,
+							message, -1, NULL);
+
+	dbus_message_unref(message);
+
+	if (!reply) {
+		message = dbus_message_new_method_call("org.bluez", adapter,
+						       "org.bluez.Adapter",
+						       "CreateDevice");
+		dbus_message_iter_init_append(message, &iter);
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
+
+		reply = dbus_connection_send_with_reply_and_block(conn,
+								  message, -1, NULL);
+
+		dbus_message_unref(message);
+
+		if (!reply)
+			return FALSE;
+	}
+	if (dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH, &object_path,
+				  DBUS_TYPE_INVALID) == FALSE) {
+		return FALSE;
+	}
+
+	id = device_get_ieee1284_id(adapter, object_path);
+	if (id == NULL)
+		return FALSE;
+	printf("%s", id);
+	g_free(id);
+
+	return TRUE;
+}
+
 /*
  *  Usage: printer-uri job-id user title copies options [file]
  *
@@ -642,10 +711,19 @@ int main(int argc, char *argv[])
 			return CUPS_BACKEND_OK;
 		else
 			return CUPS_BACKEND_FAILED;
+	} else if (argc == 3 && strcmp(argv[1], "--get-deviceid") == 0) {
+		if (bachk(argv[2]) < 0) {
+			fprintf(stderr, "Invalid Bluetooth address '%s'\n", argv[2]);
+			return CUPS_BACKEND_FAILED;
+		}
+		if (print_ieee1284(argv[2]) == FALSE)
+			return CUPS_BACKEND_FAILED;
+		return CUPS_BACKEND_OK;
 	}
 
 	if (argc < 6 || argc > 7) {
 		fprintf(stderr, "Usage: bluetooth job-id user title copies options [file]\n");
+		fprintf(stderr, "       bluetooth --get-deviceid [bdaddr]\n");
 		return CUPS_BACKEND_FAILED;
 	}
 
-- 
1.7.0.1


--=-hPSSxYDqqBeYjI+iFwS3--

