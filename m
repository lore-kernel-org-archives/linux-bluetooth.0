Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH v3 09/10] battery: Add support for notifications
Date: Thu, 20 Sep 2012 11:27:42 +0300
Message-ID: <1348129663-1701-10-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1348129663-1701-1-git-send-email-chen.ganir@ti.com>
References: <1348129663-1701-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add support for emitting PropertyChanged when a battery level
characteristic notification is sent from the peer device.
---
 profiles/battery/battery.c |   98 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index d681e2d..fce7724 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -43,6 +43,7 @@ struct battery {
 	GAttrib			*attrib;	/* GATT connection */
 	guint			attioid;	/* Att watcher id */
 	struct att_range	*svc_range;	/* Battery range */
+	guint                   attnotid;       /* Att notifications id */
 	GSList			*chars;		/* Characteristics */
 };
 
@@ -56,6 +57,7 @@ struct characteristic {
 	uint8_t			ns;		/* Battery Namespace */
 	uint16_t		description;	/* Battery description */
 	uint8_t			level;		/* Battery level */
+	gboolean		canNotify;	/* Char can notify flag */
 };
 
 struct descriptor {
@@ -86,6 +88,14 @@ static void char_free(gpointer user_data)
 	g_free(c);
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
@@ -96,8 +106,14 @@ static void battery_free(gpointer user_data)
 	if (batt->attioid > 0)
 		btd_device_remove_attio_callback(batt->dev, batt->attioid);
 
-	if (batt->attrib != NULL)
+	if (batt->attrib != NULL) {
+		if (batt->attnotid) {
+			g_attrib_unregister(batt->attrib, batt->attnotid);
+			batt->attnotid = 0;
+		}
+
 		g_attrib_unref(batt->attrib);
+	}
 
 	btd_device_unref(batt->dev);
 	g_free(batt->svc_range);
@@ -140,6 +156,18 @@ static void process_batteryservice_char(struct characteristic *ch)
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
 static gint device_battery_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct characteristic *ch = a;
@@ -176,6 +204,19 @@ static void batterylevel_refresh_cb(struct btd_battery *batt)
 		process_batteryservice_char(ch);
 }
 
+static void enable_battery_notification(struct characteristic *ch,
+								uint16_t handle)
+{
+	uint8_t atval[2];
+	uint16_t val;
+
+	val = GATT_CLIENT_CHARAC_CFG_NOTIF_BIT;
+
+	att_put_u16(val, atval);
+	gatt_write_char(ch->batt->attrib, handle, atval, 2,
+				batterylevel_enable_notify_cb, ch);
+}
+
 static void batterylevel_presentation_format_desc_cb(guint8 status,
 						const guint8 *pdu, guint16 len,
 						gpointer user_data)
@@ -211,6 +252,14 @@ static void process_batterylevel_desc(struct descriptor *desc)
 	char uuidstr[MAX_LEN_UUID_STR];
 	bt_uuid_t btuuid;
 
+	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
+
+	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0 && g_strcmp0(ch->attr.uuid,
+						BATTERY_LEVEL_UUID) == 0) {
+		enable_battery_notification(ch, desc->handle);
+		return;
+	}
+
 	bt_uuid16_create(&btuuid, GATT_CHARAC_FMT_UUID);
 
 	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0) {
@@ -317,12 +366,54 @@ static void configure_battery_cb(GSList *characteristics, guint8 status,
 	}
 }
 
+static void proc_batterylevel(struct characteristic *c, const uint8_t *pdu,
+						uint16_t len, gboolean final)
+{
+	if (!pdu) {
+		error("Battery level notification: Invalid pdu length");
+		return;
+	}
+
+	c->level = pdu[1];
+
+	btd_device_set_battery_opt(c->devbatt, BATTERY_OPT_LEVEL, c->level,
+							BATTERY_OPT_INVALID);
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
@@ -331,7 +422,8 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 		GSList *l;
 		for (l = batt->chars; l; l = l->next) {
 			struct characteristic *c = l->data;
-			process_batteryservice_char(c);
+			if (!c->canNotify)
+				process_batteryservice_char(c);
 		}
 	}
 }
@@ -340,6 +432,8 @@ static void attio_disconnected_cb(gpointer user_data)
 {
 	struct battery *batt = user_data;
 
+	g_attrib_unregister(batt->attrib, batt->attnotid);
+	batt->attnotid = 0;
 	g_attrib_unref(batt->attrib);
 	batt->attrib = NULL;
 }
-- 
1.7.9.5

