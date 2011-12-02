Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH RFC BlueZ 5/5] Add testing API to dummy Time Server provider
Date: Fri,  2 Dec 2011 14:34:10 -0400
Message-Id: <1322850850-18019-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new TimeUpdated() is useful to test Current Time Characteristic
value notifications.
---
 time/provider-dummy.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/time/provider-dummy.c b/time/provider-dummy.c
index ba0744f..ab90f7b 100644
--- a/time/provider-dummy.c
+++ b/time/provider-dummy.c
@@ -23,20 +23,59 @@
  */
 
 #include <stdint.h>
+#include <glib.h>
+#include <dbus/dbus.h>
+#include <gdbus.h>
 
 #include "server.h"
 #include "log.h"
 
+#define TIME_DUMMY_IFACE "org.bluez.TimeProviderTest"
+#define TIME_DUMMY_PATH "/org/bluez/test"
+
+static DBusConnection *connection = NULL;
+
+static DBusMessage *time_updated(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	DBG("");
+
+	current_time_updated();
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable dummy_methods[] = {
+	{ "TimeUpdated",	"",	"",	time_updated	},
+};
+
 int time_provider_init(void)
 {
 	DBG("");
 
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+
+	if (g_dbus_register_interface(connection, TIME_DUMMY_PATH,
+					TIME_DUMMY_IFACE, dummy_methods, NULL,
+					NULL, NULL, NULL) == FALSE) {
+		error("time-dummy interface %s init failed on path %s",
+					TIME_DUMMY_IFACE, TIME_DUMMY_PATH);
+		dbus_connection_unref(connection);
+
+		return -1;
+	}
+
 	return 0;
 }
 
 void time_provider_exit(void)
 {
 	DBG("");
+
+	g_dbus_unregister_interface(connection, TIME_DUMMY_PATH,
+							TIME_DUMMY_IFACE);
+	dbus_connection_unref(connection);
+	connection = NULL;
 }
 
 void time_provider_status(uint8_t *state, uint8_t *result)
-- 
1.7.0.4

