Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH RFC BlueZ 04/16] Phone Alert: implement org.bluez.PhoneAlert interface
Date: Mon, 26 Sep 2011 15:13:30 -0400
Message-Id: <1317064422-1654-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 alert/server.c |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/alert/server.c b/alert/server.c
index 1135ca0..66a5e42 100644
--- a/alert/server.c
+++ b/alert/server.c
@@ -27,9 +27,12 @@
 #endif
 
 #include <glib.h>
+#include <gdbus.h>
+#include <errno.h>
 #include <bluetooth/uuid.h>
 
 #include "att.h"
+#include "error.h"
 #include "gattrib.h"
 #include "attrib-server.h"
 #include "gatt-service.h"
@@ -41,6 +44,18 @@
 #define RINGER_CP_CHR_UUID		0x2A40
 #define RINGER_SETTING_CHR_UUID		0x2A41
 
+#define ALERT_INTERFACE "org.bluez.PhoneAlert"
+#define ALERT_PATH "/test/phonealert"
+
+struct agent {
+	char *name;
+	char *path;
+	guint listener_id;
+};
+
+static DBusConnection *connection = NULL;
+static struct agent agent;
+
 static uint8_t control_point_write(struct attribute *a, gpointer user_data)
 {
 	DBG("a = %p", a);
@@ -73,8 +88,66 @@ static void register_phone_alert_service(void)
 			GATT_OPT_INVALID);
 }
 
+static void agent_exited(DBusConnection *conn, void *user_data)
+{
+	DBG("Agent exiting ...");
+
+	g_free(agent.path);
+	g_free(agent.name);
+
+	agent.path = NULL;
+	agent.name = NULL;
+}
+
+static DBusMessage *register_agent(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	const char *path, *name;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID))
+		return NULL;
+
+	if (agent.name != NULL)
+		return btd_error_already_exists(msg);
+
+	name = dbus_message_get_sender(msg);
+
+	DBG("Registering agent: path = %s, name = %s", path, name);
+
+	agent.path = strdup(path);
+	agent.name = strdup(name);
+
+	agent.listener_id = g_dbus_add_disconnect_watch(connection, name,
+							agent_exited, NULL,
+									NULL);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable alert_methods[] = {
+	{ "RegisterAgent",	"o",	"",	register_agent },
+	{ }
+};
+
 int alert_server_init(void)
 {
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return -EIO;
+
+	if (!g_dbus_register_interface(connection, ALERT_PATH, ALERT_INTERFACE,
+				alert_methods, NULL, NULL,
+				NULL, NULL) == TRUE) {
+		error("D-Bus failed to register %s interface", ALERT_INTERFACE);
+		dbus_connection_unref(connection);
+		connection = NULL;
+
+		return -1;
+	}
+
+	DBG("Registered interface %s on path %s", ALERT_INTERFACE, ALERT_PATH);
+
 	register_phone_alert_service();
 
 	return 0;
@@ -82,4 +155,6 @@ int alert_server_init(void)
 
 void alert_server_exit(void)
 {
+	dbus_connection_unref(connection);
+	connection = NULL;
 }
-- 
1.7.0.4

