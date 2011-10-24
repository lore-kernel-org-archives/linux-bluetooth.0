Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 5/8] Enable final measurement indications when first watcher is enabled
Date: Mon, 24 Oct 2011 19:04:05 +0200
Message-Id: <1319475848-4171-6-git-send-email-sancane@gmail.com>
In-Reply-To: <1319475848-4171-5-git-send-email-sancane@gmail.com>
References: <1319475848-4171-1-git-send-email-sancane@gmail.com>
 <1319475848-4171-2-git-send-email-sancane@gmail.com>
 <1319475848-4171-3-git-send-email-sancane@gmail.com>
 <1319475848-4171-4-git-send-email-sancane@gmail.com>
 <1319475848-4171-5-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   76 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 75 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 6ff5da3..acb7747 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -150,6 +150,22 @@ static gint cmp_watcher(gconstpointer a, gconstpointer b)
 	return g_strcmp0(watcher->path, match->path);
 }
 
+static gint cmp_char_uuid(gconstpointer a, gconstpointer b)
+{
+	const struct characteristic *ch = a;
+	const gchar *uuid = b;
+
+	return g_strcmp0(ch->attr.uuid, uuid);
+}
+
+static gint cmp_descriptor(gconstpointer a, gconstpointer b)
+{
+	const struct descriptor *desc = a;
+	const bt_uuid_t *uuid = b;
+
+	return bt_uuid_cmp(&desc->uuid, uuid);
+}
+
 static void change_property(struct thermometer *t, const gchar *name,
 							gpointer value) {
 	if (g_strcmp0(name, "Intermediate") == 0) {
@@ -446,9 +462,67 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 						"Function not implemented.");
 }
 
+static struct characteristic *get_characteristic(struct thermometer *t,
+							const gchar *uuid)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(t->chars, uuid, cmp_char_uuid);
+	if (l == NULL)
+		return NULL;
+
+	return l->data;
+}
+
+static struct descriptor *get_descriptor(struct characteristic *ch,
+							const bt_uuid_t *uuid)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(ch->desc, uuid, cmp_descriptor);
+	if (l == NULL)
+		return NULL;
+
+	return l->data;
+}
+
+static void final_measurement_cb(guint8 status, const guint8 *pdu,
+						guint16 len, gpointer user_data)
+{
+	gchar *msg = user_data;
+
+	if (status != 0)
+		error("%s failed", msg);
+
+	g_free(msg);
+}
+
 static void enable_final_measurement(struct thermometer *t)
 {
-	/* TODO: enable final measurements */
+	struct characteristic *ch;
+	struct descriptor *desc;
+	bt_uuid_t btuuid;
+	uint8_t atval[2];
+	gchar *msg;
+
+	ch = get_characteristic(t, TEMPERATURE_MEASUREMENT_UUID);
+	if (ch == NULL) {
+		DBG("Temperature measurement characteristic not found");
+		return;
+	}
+
+	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	desc = get_descriptor(ch, &btuuid);
+	if (desc == NULL) {
+		DBG("Client characteristic configuration descriptor not found");
+		return;
+	}
+
+	atval[0] = 0x02;
+	atval[1] = 0x00;
+	msg = g_strdup("Enable final measurement");
+	gatt_write_char(t->attrib, desc->handle, atval, 2,
+						final_measurement_cb, msg);
 }
 
 static void disable_final_measurement(struct thermometer *t)
-- 
1.7.6.1

