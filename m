Return-Path: <cyrus@holtmann.org>
Message-ID: <4A3211A3.2040203@suse.de>
Date: Fri, 12 Jun 2009 10:28:19 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add udev mode to bluetoothd
References: <1244741895.11069.1319.camel@cookie.hadess.net> <1244742638.27363.51.camel@violet> <4A320683.7000103@suse.de>
In-Reply-To: <4A320683.7000103@suse.de>
Content-Type: multipart/mixed;
 boundary="------------030504010100050006060502"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030504010100050006060502
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Stefan Seyfried wrote:

> I had patches for waiting for the bus long time ago and can dig them out if
> wanted.

Actually I quickly dug them out and adapted them to the current code.

I arbitrarily chose to stop waiting after 5 minutes. This timeout is certainly
 a topic that might need to be discussed.

Best regards,

	Stefan
-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)

--------------030504010100050006060502
Content-Type: text/x-patch;
 name="0001-Wait-for-system-bus-to-appear.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Wait-for-system-bus-to-appear.patch"

>From 8b41af8ac12e2cf0824af4f65e0ef47ffac3dcb8 Mon Sep 17 00:00:00 2001
From: Stefan Seyfried <seife@tuxbox-git.slipkontur.de>
Date: Fri, 12 Jun 2009 10:22:29 +0200
Subject: [PATCH] Wait for system bus to appear

If the system bus is not there when starting bluetoothd,
wait up to five minutes for it to appear and retry the
connection every five seconds.
---
 src/dbus-common.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/src/dbus-common.c b/src/dbus-common.c
index d06d8e5..dc648be 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -162,21 +162,32 @@ void hcid_dbus_exit(void)
 	dbus_connection_unref(conn);
 }
 
+#define MAX_DBUS_RETRY		60
 int hcid_dbus_init(void)
 {
 	DBusConnection *conn;
 	DBusError err;
+	int retry = 0;
 
-	dbus_error_init(&err);
+	do {
+		dbus_error_init(&err);
+		conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, BLUEZ_NAME, &err);
+		if (conn)
+			break;
 
-	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, BLUEZ_NAME, &err);
-	if (!conn) {
 		if (error != NULL && dbus_error_is_set(&err)) {
 			dbus_error_free(&err);
-			return -EIO;
+			if (retry >= MAX_DBUS_RETRY)
+				return -EIO;
+			if (!retry)
+				info("Can't connect to system bus, will retry "
+					"%i times.", MAX_DBUS_RETRY);
+			sleep(5);
+			retry++;
+			continue;
 		}
 		return -EALREADY;
-	}
+	} while (1);
 
 	if (g_dbus_set_disconnect_function(conn, disconnect_callback,
 							NULL, NULL) == FALSE) {
-- 
1.6.3.2


--------------030504010100050006060502--
