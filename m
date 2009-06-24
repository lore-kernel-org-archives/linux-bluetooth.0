Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Less errors from the cups backend
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-eGord0x594wYaEjbkPbc"
Date: Wed, 24 Jun 2009 18:03:46 +0100
Message-Id: <1245863027.26486.17241.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-eGord0x594wYaEjbkPbc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Avoids filling up /var/log/messages, as seen in:
https://bugzilla.redhat.com/show_bug.cgi?id=507572

Cheers

--=-eGord0x594wYaEjbkPbc
Content-Disposition: attachment; filename="0001-Less-errors-from-the-cups-backend.patch"
Content-Type: text/x-patch; name="0001-Less-errors-from-the-cups-backend.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From c260d9aa469347bc11c6b61944bf130deb6a2e04 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 24 Jun 2009 18:01:27 +0100
Subject: [PATCH] Less errors from the cups backend

Don't error out when either D-Bus isn't available,
bluetoothd isn't running, or there's no adapters.
---
 cups/main.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/cups/main.c b/cups/main.c
index 6dcc622..2fbfe7e 100644
--- a/cups/main.c
+++ b/cups/main.c
@@ -536,15 +536,15 @@ static gboolean list_printers(void)
 
 	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
 	if (conn == NULL)
-		return FALSE;
+		return TRUE;
 
 	dbus_error_init(&error);
 	hcid_exists = dbus_bus_name_has_owner(conn, "org.bluez", &error);
 	if (&error != NULL && dbus_error_is_set(&error))
-		return FALSE;
+		return TRUE;
 
 	if (!hcid_exists)
-		return FALSE;
+		return TRUE;
 
 	/* Get the default adapter */
 	message = dbus_message_new_method_call("org.bluez", "/",
@@ -562,7 +562,8 @@ static gboolean list_printers(void)
 
 	if (&error != NULL && dbus_error_is_set(&error)) {
 		dbus_connection_unref(conn);
-		return FALSE;
+		/* No adapter */
+		return TRUE;
 	}
 
 	dbus_message_iter_init(reply, &reply_iter);
-- 
1.6.2.2


--=-eGord0x594wYaEjbkPbc--

