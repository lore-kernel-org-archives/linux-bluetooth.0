Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH v2] Omit MainChannel when HDP first reliable channel is nil
Date: Tue, 27 Mar 2012 10:03:25 -0300
Message-Id: <1332853405-16495-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Do not add MainChannel to property list when HDP first reliable channel
does not exist. Upon channel destruction, ChannelDeleted signal is already
emitted.

This also fixes a crash where MainChannel was filled with invalid path ""
when first reliable channel did not exist.
---
 health/hdp.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 812352f..455240c 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -723,14 +723,8 @@ static void health_channel_destroy(void *data)
 					DBUS_TYPE_INVALID);
 
 	if (hdp_chan == dev->fr) {
-		char *empty_path;
-
 		hdp_channel_unref(dev->fr);
 		dev->fr = NULL;
-		empty_path = "/";
-		emit_property_changed(dev->conn, device_get_path(dev->dev),
-					HEALTH_DEVICE, "MainChannel",
-					DBUS_TYPE_OBJECT_PATH, &empty_path);
 	}
 
 end:
@@ -2061,7 +2055,6 @@ static DBusMessage *device_get_properties(DBusConnection *conn,
 	struct hdp_device *device = user_data;
 	DBusMessageIter iter, dict;
 	DBusMessage *reply;
-	char *path;
 
 	reply = dbus_message_new_method_return(msg);
 	if (reply == NULL)
@@ -2075,11 +2068,9 @@ static DBusMessage *device_get_properties(DBusConnection *conn,
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
 	if (device->fr != NULL)
-		path = g_strdup(device->fr->path);
-	else
-		path = g_strdup("");
-	dict_append_entry(&dict, "MainChannel", DBUS_TYPE_OBJECT_PATH, &path);
-	g_free(path);
+		dict_append_entry(&dict, "MainChannel", DBUS_TYPE_OBJECT_PATH,
+							&device->fr->path);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
-- 
1.7.5.4

