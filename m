Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] Fix crash when HDP first reliable channel is nil
Date: Fri, 16 Mar 2012 19:53:09 -0300
Message-Id: <1331938389-4856-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Congruent to health_channel_destroy(), the "/" path is returned by MainChannel
property of HealthDevice when the first reliable channel is nil.

An empty path provokes the following error:

process xxxs: arguments to dbus_message_iter_append_basic() were incorrect,
assertion "_dbus_check_is_valid_path (*string_p)" failed in file
../../dbus/dbus-message.c line 2539.  This is normally a bug in some
application using the D-Bus library.
---
 health/hdp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 812352f..eba438a 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -2077,7 +2077,7 @@ static DBusMessage *device_get_properties(DBusConnection *conn,
 	if (device->fr != NULL)
 		path = g_strdup(device->fr->path);
 	else
-		path = g_strdup("");
+		path = g_strdup("/");
 	dict_append_entry(&dict, "MainChannel", DBUS_TYPE_OBJECT_PATH, &path);
 	g_free(path);
 	dbus_message_iter_close_container(&iter, &dict);
-- 
1.7.5.4

