Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/6] Proximity Monitor: Write Alert Level to Reporter
Date: Wed, 27 Jul 2011 18:53:01 -0300
Message-Id: <1311803586-5405-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1311803586-5405-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1311803586-5405-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Lizardo <anderson.lizardo@openbossa.org>

When the Proximity Monitor connects to the Reporter, it shall write its
current Alert Level (usually defined by the user) into the Alert Level
characteristic on the Monitor. So once the link is lost, the Monitor
will alert with the appropriate level.

Note: Register connection callback to write alert level to the Reporter.
---
 proximity/monitor.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 8465f92..f7995aa 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -35,19 +35,28 @@
 #include <sys/stat.h>
 
 #include <bluetooth/bluetooth.h>
+#include <bluetooth/uuid.h>
 
 #include "dbus-common.h"
 #include "adapter.h"
 #include "device.h"
 #include "error.h"
 #include "log.h"
+#include "att.h"
+#include "gattrib.h"
+#include "gatt.h"
+#include "attio.h"
 #include "monitor.h"
 #include "textfile.h"
 
 #define PROXIMITY_INTERFACE "org.bluez.Proximity"
 
+#define LINK_LOSS_UUID "00001803-0000-1000-8000-00805f9b34fb"
+#define ALERT_LEVEL_CHR_UUID 0x2A06
+
 struct monitor {
 	struct btd_device *device;
+	GAttrib *attrib;
 	char *linklosslevel;		/* Link Loss Alert Level */
 };
 
@@ -90,6 +99,86 @@ static char *read_proximity_config(bdaddr_t *sba, bdaddr_t *dba,
 	return textfile_caseget(filename, key);
 }
 
+static void char_discovered_cb(GSList *characteristics, guint8 status,
+							gpointer user_data)
+{
+	struct monitor *monitor = user_data;
+	struct att_char *chr;
+	uint8_t value;
+
+	if (status) {
+		error("Discover Link Loss handle: %s", att_ecode2str(status));
+		return;
+	}
+
+	if (strcmp(monitor->linklosslevel, "none") == 0)
+		value = 0x00;
+	else if (strcmp(monitor->linklosslevel, "mild") == 0)
+		value = 0x01;
+	else if (strcmp(monitor->linklosslevel, "high") == 0)
+		value = 0x02;
+
+	DBG("Setting alert level \"%s\" on Reporter", monitor->linklosslevel);
+
+	/* Assume there is a single Alert Level characteristic */
+	chr = characteristics->data;
+
+	gatt_write_cmd(monitor->attrib, chr->value_handle, &value, 1, NULL, NULL);
+}
+
+static int write_alert_level(struct monitor *monitor)
+{
+	GSList *l, *primaries;
+	uint16_t start = 0, end = 0;
+	bt_uuid_t uuid;
+
+	primaries = btd_device_get_primaries(monitor->device);
+	if (primaries == NULL) {
+		DBG("No primary services found");
+		return -1;
+	}
+
+	for (l = primaries; l; l = l->next) {
+		struct att_primary *primary = l->data;
+
+		if (strcmp(primary->uuid, LINK_LOSS_UUID) == 0) {
+			start = primary->start;
+			end = primary->end;
+			break;
+		}
+	}
+
+	if (!start) {
+		DBG("Link Loss service not found");
+		return -1;
+	}
+
+	DBG("Link Loss service found at range 0x%04x-0x%04x", start, end);
+
+	bt_uuid16_create(&uuid, ALERT_LEVEL_CHR_UUID);
+
+	/* FIXME: use cache (requires service changed support) ? */
+	gatt_discover_char(monitor->attrib, start, end, &uuid, char_discovered_cb,
+								monitor);
+
+	return 0;
+}
+
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct monitor *monitor = user_data;
+
+	monitor->attrib = attrib;
+	write_alert_level(monitor);
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct monitor *monitor = user_data;
+
+	monitor->attrib = NULL;
+}
+
 static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 						const char *level, void *data)
 {
@@ -229,6 +318,9 @@ int monitor_register(DBusConnection *conn, struct btd_device *device)
 
 	DBG("Registered interface %s on path %s", PROXIMITY_INTERFACE, path);
 
+	btd_device_add_attio_callback(device, attio_connected_cb,
+					attio_disconnected_cb, monitor);
+
 	return 0;
 }
 
-- 
1.7.6

