Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v4 09/10] Battery: Add support for notifications
Date: Thu, 16 Aug 2012 12:35:02 +0300
Message-ID: <1345109702-5698-10-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1345109702-5698-1-git-send-email-chen.ganir@ti.com>
References: <1345109702-5698-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add support for emitting PropertyChanged when a battery level
characteristic notification is sent from the peer device.
---
 profiles/battery/battery.c |  112 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 2 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 108813c..3d3fb6b 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -50,6 +50,7 @@ struct battery {
 	GAttrib			*attrib;	/* GATT connection */
 	guint			attioid;	/* Att watcher id */
 	struct att_range	*svc_range;	/* Battery range */
+	guint                   attnotid;       /* Att notifications id */
 	GSList			*chars;		/* Characteristics */
 };
 
@@ -63,6 +64,7 @@ struct characteristic {
 	uint8_t			ns;		/* Battery Namespace */
 	uint16_t		description;	/* Battery description */
 	uint8_t        level;
+	gboolean		canNotify;
 };
 
 struct descriptor {
@@ -104,6 +106,14 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static gint cmp_char_val_handle(gconstpointer a, gconstpointer b)
+{
+	const struct characteristic *ch = a;
+	const uint16_t *handle = b;
+
+	return ch->attr.value_handle - *handle;
+}
+
 static void battery_free(gpointer user_data)
 {
 	struct battery *batt = user_data;
@@ -117,6 +127,10 @@ static void battery_free(gpointer user_data)
 	if (batt->attrib != NULL)
 		g_attrib_unref(batt->attrib);
 
+	if (batt->attrib != NULL) {
+		g_attrib_unregister(batt->attrib, batt->attnotid);
+		g_attrib_unref(batt->attrib);
+	}
 
 	dbus_connection_unref(batt->conn);
 	btd_device_unref(batt->dev);
@@ -158,6 +172,18 @@ static void process_batteryservice_char(struct characteristic *ch)
 	}
 }
 
+static void batterylevel_enable_notify_cb(guint8 status, const guint8 *pdu,
+						guint16 len, gpointer user_data)
+{
+	struct characteristic *ch = (struct characteristic *)user_data;
+
+	if (status != 0) {
+		error("Could not enable batt level notification.");
+		ch->canNotify = FALSE;
+		process_batteryservice_char(ch);
+	}
+}
+
 static void batterylevel_presentation_format_desc_cb(guint8 status,
 						const guint8 *pdu, guint16 len,
 						gpointer user_data)
@@ -194,6 +220,21 @@ static void process_batterylevel_desc(struct descriptor *desc)
 	char uuidstr[MAX_LEN_UUID_STR];
 	bt_uuid_t btuuid;
 
+	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
+
+	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0 && g_strcmp0(ch->attr.uuid,
+						BATTERY_LEVEL_UUID) == 0) {
+		uint8_t atval[2];
+		uint16_t val;
+
+		val = GATT_CLIENT_CHARAC_CFG_NOTIF_BIT;
+
+		att_put_u16(val, atval);
+		gatt_write_char(ch->batt->attrib, desc->handle, atval, 2,
+					batterylevel_enable_notify_cb, ch);
+		return;
+	}
+
 	bt_uuid16_create(&btuuid, GATT_CHARAC_FMT_UUID);
 
 	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0) {
@@ -238,6 +279,13 @@ static GDBusMethodTable battery_methods[] = {
 				get_properties) },
 	{ }
 };
+static GDBusSignalTable battery_signals[] = {
+	{ GDBUS_SIGNAL("PropertyChanged",
+		GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
+};
+
+
 static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
@@ -284,7 +332,7 @@ update_char:
 
 	if (!g_dbus_register_interface(ch->batt->conn, ch->path,
 				BATTERY_INTERFACE,
-				battery_methods, NULL, NULL,
+				battery_methods, battery_signals, NULL,
 				ch, NULL)) {
 		error("D-Bus register interface %s failed",
 		      BATTERY_INTERFACE);
@@ -293,6 +341,12 @@ update_char:
 	process_batteryservice_char(ch);
 	}
 }
+static void emit_battery_level_changed(struct characteristic *c)
+{
+	emit_property_changed(c->batt->conn, c->path, BATTERY_INTERFACE,
+					"Level", DBUS_TYPE_BYTE, &c->level);
+}
+
 static void configure_battery_cb(GSList *characteristics, guint8 status,
 
 							gpointer user_data)
@@ -340,12 +394,63 @@ static void configure_battery_cb(GSList *characteristics, guint8 status,
 	}
 }
 
+static void proc_batterylevel(struct characteristic *c, const uint8_t *pdu,
+						uint16_t len, gboolean final)
+{
+	uint8_t new_batt_level = 0;
+	gboolean changed = FALSE;
+
+	if (!pdu) {
+		error("Battery level notification: Invalid pdu length");
+		goto done;
+	}
+
+	new_batt_level = pdu[1];
+
+	if (new_batt_level != c->level)
+		changed = TRUE;
+
+	c->level = new_batt_level;
+
+done:
+	if (changed)
+		emit_battery_level_changed(c);
+}
+
+static void notif_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
+{
+	struct battery *batt = user_data;
+	struct characteristic *ch;
+	uint16_t handle;
+	GSList *l;
+
+	if (len < 3) {
+		error("notif_handler: Bad pdu received");
+		return;
+	}
+
+	handle = att_get_u16(&pdu[1]);
+	l = g_slist_find_custom(batt->chars, &handle, cmp_char_val_handle);
+	if (l == NULL) {
+		error("notif_handler: Unexpected handle 0x%04x", handle);
+		return;
+	}
+
+	ch = l->data;
+	if (g_strcmp0(ch->attr.uuid, BATTERY_LEVEL_UUID) == 0) {
+		proc_batterylevel(ch, pdu, len, FALSE);
+	}
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct battery *batt = user_data;
 
 	batt->attrib = g_attrib_ref(attrib);
 
+	batt->attnotid = g_attrib_register(batt->attrib, ATT_OP_HANDLE_NOTIFY,
+						notif_handler, batt, NULL);
+
 	if (batt->chars == NULL) {
 		gatt_discover_char(batt->attrib, batt->svc_range->start,
 					batt->svc_range->end, NULL,
@@ -354,7 +459,8 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 		GSList *l;
 		for (l = batt->chars; l; l = l->next) {
 			struct characteristic *c = l->data;
-			process_batteryservice_char(c);
+			if (!c->canNotify)
+				process_batteryservice_char(c);
 		}
 	}
 }
@@ -363,6 +469,8 @@ static void attio_disconnected_cb(gpointer user_data)
 {
 	struct battery *batt = user_data;
 
+	g_attrib_unregister(batt->attrib, batt->attnotid);
+	batt->attnotid = 0;
 	g_attrib_unref(batt->attrib);
 	batt->attrib = NULL;
 }
-- 
1.7.9.5

