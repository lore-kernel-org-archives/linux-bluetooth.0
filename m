Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 2/6] core: Remove useless memset and make icon optional
Date: Sat,  6 Oct 2012 04:10:44 -0300
Message-Id: <1349507448-9595-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1349507448-9595-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1349507448-9595-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

name is not being really used anywhere, so remove it together with the
memset from Device.GetProperties().

icon is optional, so check if it's not NULL before adding it to the list
of device properties.
---

I'm about to remove this function entirely on the next patch, but I preferred
doing like this to facilitate the review, which is mostly copy and paste from
the current code.

 src/device.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/device.c b/src/device.c
index 656f109..3658eeb 100644
--- a/src/device.c
+++ b/src/device.c
@@ -318,7 +318,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
-	char name[MAX_NAME_LENGTH + 1], dstaddr[18];
+	char dstaddr[18];
 	char **str;
 	const char *ptr, *icon = NULL;
 	dbus_bool_t boolean;
@@ -345,9 +345,6 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	dict_append_entry(&dict, "Address", DBUS_TYPE_STRING, &ptr);
 
 	/* Name */
-	ptr = NULL;
-	memset(name, 0, sizeof(name));
-
 	ptr = device->name;
 	dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &ptr);
 
@@ -375,7 +372,8 @@ static DBusMessage *get_properties(DBusConnection *conn,
 		dict_append_entry(&dict, "Appearance", DBUS_TYPE_UINT16, &app);
 	}
 
-	dict_append_entry(&dict, "Icon", DBUS_TYPE_STRING, &icon);
+	if (icon != NULL)
+		dict_append_entry(&dict, "Icon", DBUS_TYPE_STRING, &icon);
 
 	/* Vendor */
 	if (device->vendor)
-- 
1.7.12.2

