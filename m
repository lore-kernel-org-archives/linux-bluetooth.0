Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 3/5] hog: Add Suspend/Resume callbacks
Date: Fri, 17 Aug 2012 18:08:21 -0300
Message-Id: <1345237703-15342-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345237703-15342-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345237703-15342-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch declares the Suspend, and Resume callbacks that needs to
called when the system is entering or leaving suspend state.
---
 profiles/input/hog_manager.c |   10 +++++++++-
 profiles/input/upower.c      |   21 ++++++++++++++++++---
 profiles/input/upower.h      |    6 +++++-
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/profiles/input/hog_manager.c b/profiles/input/hog_manager.c
index 5a5ac62..f32405d 100644
--- a/profiles/input/hog_manager.c
+++ b/profiles/input/hog_manager.c
@@ -41,6 +41,14 @@
 static gboolean upower_supported = FALSE;
 static DBusConnection *connection = NULL;
 
+static void suspend_event_cb(void)
+{
+}
+
+static void resume_event_cb(void)
+{
+}
+
 static int hog_device_probe(struct btd_device *device, GSList *uuids)
 {
 	const char *path = device_get_path(device);
@@ -74,7 +82,7 @@ static int hog_manager_init(void)
 	if (connection == NULL)
 		return -EIO;
 
-	err = upower_init(connection);
+	err = upower_init(connection, suspend_event_cb, resume_event_cb);
 	if (err < 0) {
 		dbus_connection_unref(connection);
 		connection = NULL;
diff --git a/profiles/input/upower.c b/profiles/input/upower.c
index 18a4730..27b4753 100644
--- a/profiles/input/upower.c
+++ b/profiles/input/upower.c
@@ -39,12 +39,16 @@
 static DBusConnection *connection = NULL;
 static guint suspending_watch = 0;
 static guint resuming_watch = 0;
+static suspend_event suspend_callback = NULL;
+static resume_event resume_callback = NULL;
 
 static gboolean suspending_cb(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
 	DBG("UPOWER: Suspending ...");
 
+	suspend_callback();
+
 	return TRUE;
 }
 
@@ -53,22 +57,33 @@ static gboolean resuming_cb(DBusConnection *conn, DBusMessage *msg,
 {
 	DBG("UPOWER: Resuming ...");
 
+	resume_callback();
+
 	return TRUE;
 }
 
-int upower_init(DBusConnection *conn)
+int upower_init(DBusConnection *conn, suspend_event suspend_cb,
+					resume_event resume_cb)
 {
 	connection = dbus_connection_ref(conn);
 
-	suspending_watch = g_dbus_add_signal_watch(connection, UPOWER_BUS_NAME,
+	if (suspend_cb) {
+		suspending_watch = g_dbus_add_signal_watch(connection,
+						UPOWER_BUS_NAME,
 						UPOWER_PATH, UPOWER_INTERFACE,
 						"Sleeping", suspending_cb,
 						NULL, NULL);
+		suspend_callback = suspend_cb;
+	}
 
-	resuming_watch = g_dbus_add_signal_watch(connection, UPOWER_BUS_NAME,
+	if (resume_cb) {
+		resuming_watch = g_dbus_add_signal_watch(connection,
+						UPOWER_BUS_NAME,
 						UPOWER_PATH, UPOWER_INTERFACE,
 						"Resuming", resuming_cb,
 						NULL, NULL);
+		resume_callback = resume_cb;
+	}
 
 	return 0;
 }
diff --git a/profiles/input/upower.h b/profiles/input/upower.h
index 90976ab..0ccad43 100644
--- a/profiles/input/upower.h
+++ b/profiles/input/upower.h
@@ -21,5 +21,9 @@
  *
  */
 
-int upower_init(DBusConnection *conn);
+typedef void (*suspend_event) (void);
+typedef void (*resume_event) (void);
+
+int upower_init(DBusConnection *conn, suspend_event suspend_cb,
+					resume_event resume_cb);
 void upower_exit(void);
-- 
1.7.8.6

