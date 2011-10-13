Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 6/9] Get all characteristics in thermometer service
Date: Thu, 13 Oct 2011 17:29:19 +0200
Message-Id: <1318519762-17475-7-git-send-email-sancane@gmail.com>
In-Reply-To: <1318519762-17475-6-git-send-email-sancane@gmail.com>
References: <1318519762-17475-1-git-send-email-sancane@gmail.com>
 <1318519762-17475-2-git-send-email-sancane@gmail.com>
 <1318519762-17475-3-git-send-email-sancane@gmail.com>
 <1318519762-17475-4-git-send-email-sancane@gmail.com>
 <1318519762-17475-5-git-send-email-sancane@gmail.com>
 <1318519762-17475-6-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |  110 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 110 insertions(+), 0 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 1e2caf5..41b9d72 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -31,10 +31,15 @@
 #include "gattrib.h"
 #include "attio.h"
 #include "att.h"
+#include "gatt.h"
 #include "thermometer.h"
 
 #define THERMOMETER_INTERFACE "org.bluez.Thermometer"
 
+#define TEMPERATURE_TYPE_UUID		"00002a1d-0000-1000-8000-00805f9b34fb"
+#define INTERMEDIATE_TEMPERATURE_UUID	"00002a1e-0000-1000-8000-00805f9b34fb"
+#define MEASUREMENT_INTERVAL_UUID	"00002a21-0000-1000-8000-00805f9b34fb"
+
 struct thermometer {
 	DBusConnection		*conn;		/* The connection to the bus */
 	struct btd_device	*dev;		/* Device reference */
@@ -42,10 +47,31 @@ struct thermometer {
 	struct att_range	*svc_range;	/* Thermometer range */
 	guint			attioid;	/* Att watcher id */
 	guint			attindid;	/* Att incications id */
+	GSList			*chars;		/* Characteristics */
+};
+
+struct characteristic {
+	struct att_char		attr;	/* Characteristic */
+	GSList			*desc;	/* Descriptors */
+	struct thermometer	*t;	/* Thermometer where the char belongs */
+};
+
+struct descriptor {
+	struct characteristic	*ch;
+	uint16_t		handle;
+	bt_uuid_t		uuid;
 };
 
 static GSList *thermometers = NULL;
 
+static void destroy_char(gpointer user_data)
+{
+	struct characteristic *c = user_data;
+
+	g_slist_free_full(c->desc, g_free);
+	g_free(c);
+}
+
 static void destroy_thermometer(gpointer user_data)
 {
 	struct thermometer *t = user_data;
@@ -59,6 +85,9 @@ static void destroy_thermometer(gpointer user_data)
 	if (t->attrib != NULL)
 		g_attrib_unref(t->attrib);
 
+	if (t->chars != NULL)
+		g_slist_free_full(t->chars, destroy_char);
+
 	dbus_connection_unref(t->conn);
 	btd_device_unref(t->dev);
 	g_free(t->svc_range);
@@ -76,6 +105,85 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	/* TODO */
+}
+
+static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	/* TODO */
+}
+
+static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	/* TODO */
+}
+
+static void process_thermometer_char(struct characteristic *ch)
+{
+	GAttribResultFunc func;
+
+	if (g_strcmp0(ch->attr.uuid, INTERMEDIATE_TEMPERATURE_UUID) == 0) {
+		/* TODO: Change intermediate property and emit signal */
+		return;
+	} else if (g_strcmp0(ch->attr.uuid, TEMPERATURE_TYPE_UUID) == 0)
+		func = read_temp_type_cb;
+	else if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0)
+		func = read_interval_cb;
+	else
+		return;
+
+	gatt_read_char(ch->t->attrib, ch->attr.value_handle, 0, func, ch);
+}
+
+static void configure_thermometer_cb(GSList *characteristics, guint8 status,
+							gpointer user_data)
+{
+	struct thermometer *t = user_data;
+	GSList *l;
+
+	if (status != 0) {
+		error("Discover thermometer characteristics: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	for (l = characteristics; l; l = l->next) {
+		struct att_char *c = l->data;
+		struct characteristic *ch;
+		uint16_t start, end;
+
+		ch = g_new0(struct characteristic, 1);
+		ch->attr.handle = c->handle;
+		ch->attr.properties = c->properties;
+		ch->attr.value_handle = c->value_handle;
+		memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
+		ch->t = t;
+
+		t->chars = g_slist_append(t->chars, ch);
+
+		process_thermometer_char(ch);
+
+		start = c->value_handle + 1;
+
+		if (l->next != NULL) {
+			struct att_char *c = l->next->data;
+			if (start == c->handle)
+				continue;
+			end = c->handle - 1;
+		} else if (c->value_handle != t->svc_range->end)
+			end = t->svc_range->end;
+		else
+			continue;
+
+		gatt_find_info(t->attrib, start, end, discover_desc_cb, ch);
+	}
+}
+
 static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -153,6 +261,8 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 
 	t->attindid = g_attrib_register(t->attrib, ATT_OP_HANDLE_IND,
 							ind_handler, t, NULL);
+	gatt_discover_char(t->attrib, t->svc_range->start, t->svc_range->end,
+					NULL, configure_thermometer_cb, t);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
-- 
1.7.6.1

