Return-Path: <cyrus@holtmann.org>
From: Jaikumar Ganesh <jaikumar@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaikumar Ganesh <jaikumar@google.com>
Subject: [PATCH] Fix property type of Main Channel of Health plugin
Date: Fri, 29 Apr 2011 14:01:03 -0700
Message-Id: <1304110863-26528-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The property type must be DBUS_TYPE_OBJECT_PATH instead
of DBUS_TYPE_STRING. This is in sync with the documentation
and with the other places of usage such as the property change
signal.
---
 health/hdp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 6f2c89d..d53ea80 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -2058,7 +2058,7 @@ static DBusMessage *device_get_properties(DBusConnection *conn,
 		path = g_strdup(device->fr->path);
 	else
 		path = g_strdup("");
-	dict_append_entry(&dict, "MainChannel", DBUS_TYPE_STRING, &path);
+	dict_append_entry(&dict, "MainChannel", DBUS_TYPE_OBJECT_PATH, &path);
 	g_free(path);
 	dbus_message_iter_close_container(&iter, &dict);
 
-- 
1.7.3.1

