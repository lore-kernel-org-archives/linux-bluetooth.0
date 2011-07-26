Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 3/5] Add load/store functions for Alert Level
Date: Tue, 26 Jul 2011 13:53:14 -0300
Message-Id: <1311699196-16472-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1311699196-16472-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1311699196-16472-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

The Alert Level Characteristic must be persistent across connections.
New functions to load/store the alert level value were created.
---
 proximity/monitor.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 7ec1b4c..3b2a96e 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -26,14 +26,22 @@
 #include <config.h>
 #endif
 
-#include <stdint.h>
+#include <errno.h>
+#include <fcntl.h>
 #include <gdbus.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+
+#include <bluetooth/bluetooth.h>
 
 #include "dbus-common.h"
 #include "error.h"
 #include "log.h"
 
 #include "monitor.h"
+#include "textfile.h"
 
 #define PROXIMITY_INTERFACE "org.bluez.Proximity"
 #define PROXIMITY_PATH "/org/bluez/proximity"
@@ -42,10 +50,50 @@ struct monitor {
 	char *linklosslevel;		/* Link Loss Alert Level */
 };
 
+static inline int create_filename(char *buf, size_t size,
+				const bdaddr_t *bdaddr, const char *name)
+{
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+
+	return create_name(buf, size, STORAGEDIR, addr, name);
+}
+
+static int write_proximity_config(bdaddr_t *sba, bdaddr_t *dba,
+					const char *alert, const char *level)
+{
+	char filename[PATH_MAX + 1], addr[18], key[38];
+
+	create_filename(filename, PATH_MAX, sba, "proximity");
+
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	ba2str(dba, addr);
+
+	snprintf(key, sizeof(key), "%17s#%s", addr, alert);
+
+	return textfile_put(filename, key, level);
+}
+
+static char *read_proximity_config(bdaddr_t *sba, bdaddr_t *dba,
+							const char *alert)
+{
+	char filename[PATH_MAX + 1], addr[18], key[38];
+
+	create_filename(filename, PATH_MAX, sba, "proximity");
+
+	ba2str(dba, addr);
+	snprintf(key, sizeof(key), "%17s#%s", addr, alert);
+
+	return textfile_caseget(filename, key);
+}
+
 static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 						const char *level, void *data)
 {
 	struct monitor *monitor = data;
+	bdaddr_t sba, dba;
 
 	if (!g_str_equal("none", level) && !g_str_equal("mild", level) &&
 			!g_str_equal("high", level))
@@ -57,6 +105,11 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 	g_free(monitor->linklosslevel);
 	monitor->linklosslevel = g_strdup(level);
 
+	/* FIXME: using hardcoded values */
+	bacpy(&sba, BDADDR_ANY);
+	bacpy(&dba, BDADDR_ALL);
+	write_proximity_config(&sba, &dba, "LinkLossAlertLevel", level);
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -143,9 +196,19 @@ static void monitor_destroy(gpointer user_data)
 int monitor_register(DBusConnection *conn)
 {
 	struct monitor *monitor;
+	bdaddr_t sba, dba;
+	char *level;
 	int ret = -1;
 
+	/* FIXME: using hardcoded values */
+	bacpy(&sba, BDADDR_ANY);
+	bacpy(&dba, BDADDR_ALL);
+
+	level = read_proximity_config(&sba, &dba, "LinkLossAlertLevel");
+
 	monitor = g_new0(struct monitor, 1);
+	monitor->linklosslevel = (level ? : g_strdup("none"));
+
 	if (g_dbus_register_interface(conn, PROXIMITY_PATH,
 				PROXIMITY_INTERFACE,
 				monitor_methods, monitor_signals,
-- 
1.7.6

