Return-Path: <cyrus@holtmann.org>
From: Paulo Borges <paulo.borges@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 8/9] battery: Add support for notifications
Date: Mon,  7 Jan 2013 16:41:03 -0300
Message-Id: <1357587664-16818-9-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1357587664-16818-1-git-send-email-paulo.borges@openbossa.org>
References: <1357587664-16818-1-git-send-email-paulo.borges@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add support for emitting PropertyChanged when a battery level
characteristic notification is sent from the peer device.
---
 profiles/battery/battery.c |   79 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 186bb1c..2ef4f6b 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -54,6 +54,8 @@ struct characteristic {
 	uint8_t			ns;		/* Battery Namespace */
 	uint16_t		description;	/* Battery description */
 	uint8_t			level;		/* Battery level */
+	gboolean		can_notify;	/* Char can notify flag */
+	guint			notifyid;
 };
 
 struct descriptor {
@@ -79,6 +81,9 @@ static void char_free(gpointer user_data)
 {
 	struct characteristic *c = user_data;
 
+	if (c->notifyid && c->batt->attrib != NULL)
+		g_attrib_unregister(c->batt->attrib, c->notifyid);
+
 	g_slist_free_full(c->desc, g_free);
 
 	btd_device_remove_battery(c->devbatt);
@@ -140,6 +145,44 @@ static void process_batteryservice_char(struct characteristic *ch)
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
+	struct characteristic *ch = user_data;
+
+	proc_batterylevel(ch, pdu, len, FALSE);
+}
+
+static void batterylevel_enable_notify_cb(guint8 status, const guint8 *pdu,
+						guint16 len, gpointer user_data)
+{
+	struct characteristic *ch = user_data;
+	struct battery *batt = ch->batt;
+
+	if (status != 0) {
+		error("Could not enable batt level notification.");
+		ch->can_notify = FALSE;
+		process_batteryservice_char(ch);
+	}
+
+	ch->notifyid = g_attrib_register(batt->attrib,
+				ATT_OP_HANDLE_NOTIFY, ch->attr.value_handle,
+				notif_handler, ch, NULL);
+}
+
 static gint device_battery_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct characteristic *ch = a;
@@ -176,6 +219,21 @@ static void batterylevel_refresh_cb(struct btd_battery *batt)
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
+	ch->can_notify = TRUE;
+
+	att_put_u16(val, atval);
+	gatt_write_char(ch->batt->attrib, handle, atval, 2,
+				batterylevel_enable_notify_cb, ch);
+}
+
 static void batterylevel_presentation_format_desc_cb(guint8 status,
 						const guint8 *pdu, guint16 len,
 						gpointer user_data)
@@ -211,6 +269,14 @@ static void process_batterylevel_desc(struct descriptor *desc)
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
@@ -330,7 +396,8 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 		GSList *l;
 		for (l = batt->chars; l; l = l->next) {
 			struct characteristic *c = l->data;
-			process_batteryservice_char(c);
+			if (!c->can_notify)
+				process_batteryservice_char(c);
 		}
 	}
 }
@@ -338,6 +405,16 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 static void attio_disconnected_cb(gpointer user_data)
 {
 	struct battery *batt = user_data;
+	GSList *l;
+
+	for (l = batt->chars; l; l = l->next) {
+		struct characteristic *c = l->data;
+
+		if (c->notifyid) {
+			g_attrib_unregister(batt->attrib, c->notifyid);
+			c->notifyid = 0;
+		}
+	}
 
 	g_attrib_unref(batt->attrib);
 	batt->attrib = NULL;
-- 
1.7.9.5

