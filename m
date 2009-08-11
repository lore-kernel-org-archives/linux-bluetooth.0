Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHes] CUPS fixes
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1250028123.30166.26.camel@localhost.localdomain>
References: <1249990049.2022.19.camel@localhost.localdomain>
	 <1250028123.30166.26.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-JU5Ub2bOSQOQf7YTbD9o"
Date: Tue, 11 Aug 2009 23:29:41 +0100
Message-Id: <1250029781.2022.29.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-JU5Ub2bOSQOQf7YTbD9o
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2009-08-11 at 15:02 -0700, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > The CUPS backend would be aborting when scanning for a printer that's
> > not in bluetoothd known devices. Fixes both bugs I found in my testing.
> 
> can we at least try to keep the coding style. I don't really know what
> is so hard about it.

Thanks for all the love.

Updated patches attached.

--=-JU5Ub2bOSQOQf7YTbD9o
Content-Disposition: attachment; filename="0001-Don-t-abort-cups-backend-on-property-change.patch"
Content-Type: text/x-patch; name="0001-Don-t-abort-cups-backend-on-property-change.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From ca7080b84cae508564e67fc793be926ef2074efe Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 11 Aug 2009 23:26:43 +0100
Subject: [PATCH 1/2] Don't abort cups backend on property change

Make sure the cups backend doesn't abort when trying to
access a property that's not Discovering.
---
 cups/main.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/cups/main.c b/cups/main.c
index fda3339..96a2e56 100644
--- a/cups/main.c
+++ b/cups/main.c
@@ -506,6 +506,8 @@ static DBusHandlerResult filter_func(DBusConnection *connection, DBusMessage *me
 
 		dbus_message_iter_init(message, &iter);
 		dbus_message_iter_get_basic(&iter, &name);
+		if (name == NULL || strcmp(name, "Discovering") != 0)
+			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 		dbus_message_iter_next(&iter);
 		dbus_message_iter_recurse(&iter, &value_iter);
 		dbus_message_iter_get_basic(&value_iter, &discovering);
-- 
1.6.2.5


--=-JU5Ub2bOSQOQf7YTbD9o
Content-Disposition: attachment; filename="0002-Actually-read-the-CreateDevice-reply.patch"
Content-Type: text/x-patch; name="0002-Actually-read-the-CreateDevice-reply.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 5fff32b4eacb959c009495a5384bf245b1b3a285 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 11 Aug 2009 23:27:56 +0100
Subject: [PATCH 2/2] Actually read the CreateDevice reply

Fixes aborts when the printer isn't a known device.
---
 cups/main.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/cups/main.c b/cups/main.c
index 96a2e56..da757b0 100644
--- a/cups/main.c
+++ b/cups/main.c
@@ -371,9 +371,10 @@ static void remote_device_found(const char *adapter, const char *bdaddr, const c
 
 		if (!reply)
 			return;
-	} else {
-		if (dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH, &object_path, DBUS_TYPE_INVALID) == FALSE)
-			return;
+	}
+	if (dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH, &object_path,
+				  DBUS_TYPE_INVALID) == FALSE) {
+		return;
 	}
 
 	id = device_get_ieee1284_id(adapter, object_path);
-- 
1.6.2.5


--=-JU5Ub2bOSQOQf7YTbD9o--
