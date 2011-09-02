Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 3/8] MAP Tracker: Add support for DBus connection
Date: Fri,  2 Sep 2011 10:57:55 +0200
Message-Id: <1314953880-4663-3-git-send-email-bulislaw@linux.com>
In-Reply-To: <1314953880-4663-1-git-send-email-bulislaw@linux.com>
References: <1314953880-4663-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/messages-tracker.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index 218a016..efcd007 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -28,7 +28,9 @@
 #include <errno.h>
 #include <glib.h>
 #include <string.h>
+#include <gdbus.h>
 
+#include "log.h"
 #include "messages.h"
 
 struct message_folder {
@@ -49,6 +51,7 @@ struct session {
 };
 
 static struct message_folder *folder_tree = NULL;
+static DBusConnection *session_connection = NULL;
 
 static struct message_folder *get_folder(const char *folder)
 {
@@ -148,8 +151,37 @@ static void create_folder_tree()
 	parent->subfolders = g_slist_append(parent->subfolders, child);
 }
 
+static DBusConnection *dbus_get_connection(DBusBusType type)
+{
+	DBusError err;
+	DBusConnection *tmp;
+
+	dbus_error_init(&err);
+
+	tmp = dbus_bus_get(type, &err);
+
+	if (dbus_error_is_set(&err))
+		error("Connection Error (%s)", err.message);
+
+	if (!tmp)
+		error("Error when getting on bus");
+
+	dbus_error_free(&err);
+
+	return tmp;
+}
+
 int messages_init(void)
 {
+	DBusError err;
+	dbus_error_init(&err);
+
+	if (session_connection == NULL)
+		session_connection = dbus_get_connection(DBUS_BUS_SESSION);
+
+	if (!session_connection)
+		return -1;
+
 	create_folder_tree();
 
 	return 0;
-- 
1.7.4.1

