Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/6] thermometer.c: Implement SetProperty D-Bus method
Date: Fri,  9 Dec 2011 19:18:59 +0100
Message-Id: <1323454744-14589-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1323454744-14589-1-git-send-email-sancane@gmail.com>
References: <1323454744-14589-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |  118 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 99 insertions(+), 19 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index db33cdb..2a0fb0f 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -103,6 +103,11 @@ struct measurement {
 	gchar		*value;
 };
 
+struct tmp_interval_data {
+	struct thermometer	*thermometer;
+	guint16			interval;
+};
+
 static GSList *thermometers = NULL;
 
 const char *temp_type[] = {
@@ -223,6 +228,30 @@ static gint cmp_descriptor(gconstpointer a, gconstpointer b)
 	return bt_uuid_cmp(&desc->uuid, uuid);
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
 static void change_property(struct thermometer *t, const gchar *name,
 							gpointer value) {
 	if (g_strcmp0(name, "Intermediate") == 0) {
@@ -531,36 +560,87 @@ static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 	return reply;
 }
 
-static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
-								void *data)
+static void write_interval_cb (guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
 {
-	/* TODO: */
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".ThermometerError",
-						"Function not implemented.");
+	struct tmp_interval_data *data = user_data;
+
+	if (status != 0) {
+		error("Interval Write Request failed %s",
+							att_ecode2str(status));
+		goto done;
+	}
+
+	if (!dec_write_resp(pdu, len)) {
+		error("Interval Write Request: protocol error");
+		goto done;
+	}
+
+	change_property(data->thermometer, "Interval", &data->interval);
+
+done:
+	g_free(user_data);
 }
 
-static struct characteristic *get_characteristic(struct thermometer *t,
-							const gchar *uuid)
+static DBusMessage *write_attr_interval(struct thermometer *t, DBusMessage *msg,
+								guint16 value)
 {
-	GSList *l;
+	struct tmp_interval_data *data;
+	struct characteristic *ch;
+	guint8 atval[2];
 
-	l = g_slist_find_custom(t->chars, uuid, cmp_char_uuid);
-	if (l == NULL)
-		return NULL;
+	ch = get_characteristic(t, MEASUREMENT_INTERVAL_UUID);
+	if (ch == NULL)
+		return btd_error_not_available(msg);
 
-	return l->data;
+	if (value < t->min || value > t->max)
+		return btd_error_invalid_args(msg);
+
+	att_put_u16(value, &atval[0]);
+
+	data = g_new0(struct tmp_interval_data, 1);
+	data->thermometer = t;
+	data->interval = value;
+	gatt_write_char(t->attrib, ch->attr.value_handle, atval, 2,
+						write_interval_cb, data);
+
+	return dbus_message_new_method_return(msg);
 }
 
-static struct descriptor *get_descriptor(struct characteristic *ch,
-							const bt_uuid_t *uuid)
+static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
+								void *data)
 {
-	GSList *l;
+	struct thermometer *t = data;
+	const char *property;
+	DBusMessageIter iter;
+	DBusMessageIter sub;
+	guint16 value;
 
-	l = g_slist_find_custom(ch->desc, uuid, cmp_descriptor);
-	if (l == NULL)
-		return NULL;
+	if (!dbus_message_iter_init(msg, &iter))
+		return btd_error_invalid_args(msg);
 
-	return l->data;
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	if (g_strcmp0("Interval", property) != 0)
+		return btd_error_invalid_args(msg);
+
+	if (!t->has_interval)
+		return btd_error_not_available(msg);
+
+	dbus_message_iter_next(&iter);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &sub);
+
+	if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT16)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&sub, &value);
+
+	return write_attr_interval(t, msg, value);
 }
 
 static void measurement_cb(guint8 status, const guint8 *pdu,
-- 
1.7.8

