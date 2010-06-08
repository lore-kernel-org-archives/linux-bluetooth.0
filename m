Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 4/8] Add Debug property to Manager interface
Date: Tue,  8 Jun 2010 04:11:50 -0300
Message-Id: <1275981114-18019-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275981114-18019-3-git-send-email-gustavo@padovan.org>
References: <1275981114-18019-1-git-send-email-gustavo@padovan.org>
 <1275981114-18019-2-git-send-email-gustavo@padovan.org>
 <1275981114-18019-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/log.c     |    5 +++++
 src/log.h     |    1 +
 src/manager.c |    4 ++++
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/log.c b/src/log.c
index 1bc0a42..4043ee3 100644
--- a/src/log.c
+++ b/src/log.c
@@ -97,6 +97,11 @@ void __btd_toggle_debug()
 	debug_enabled = !debug_enabled;
 }
 
+int __btd_debug_enabled()
+{
+	return debug_enabled;
+}
+
 void __btd_log_init(const char *debug, int detach)
 {
 	int option = LOG_NDELAY | LOG_PID;
diff --git a/src/log.h b/src/log.h
index 0afd739..5d1db48 100644
--- a/src/log.h
+++ b/src/log.h
@@ -28,6 +28,7 @@ void debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
 void __btd_log_init(const char *debug, int detach);
 void __btd_log_cleanup(void);
 void __btd_toggle_debug();
+int __btd_debug_enabled();
 
 extern int debug_enabled;
 
diff --git a/src/manager.c b/src/manager.c
index cbbca1e..eab7e80 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -183,6 +183,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	DBusMessageIter dict;
 	GSList *list;
 	char **array;
+	gboolean debug_value;
 	int i;
 
 	reply = dbus_message_new_method_return(msg);
@@ -208,6 +209,9 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	dict_append_array(&dict, "Adapters", DBUS_TYPE_OBJECT_PATH, &array, i);
 	g_free(array);
 
+	debug_value = __btd_debug_enabled();
+	dict_append_entry(&dict, "Debug", DBUS_TYPE_BOOLEAN, &debug_value);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
-- 
1.7.1

