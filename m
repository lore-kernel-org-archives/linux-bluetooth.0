Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 03/15] thermometer: Store Measurement Interval value handle in struct
Date: Fri, 9 Nov 2012 09:55:45 +0100
Message-ID: <1352451357-22097-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds Measurement Interval value handle directly into
thermometer struct. This way there's no need to traverse list
looking for value.

get_characteristic() function and related helpers are now unused
so can be removed.
---
 profiles/thermometer/thermometer.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index d836462..d65fc0d 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -83,6 +83,7 @@ struct thermometer {
 
 	uint16_t			measurement_ccc_handle;
 	uint16_t			intermediate_ccc_handle;
+	uint16_t			interval_val_handle;
 };
 
 struct characteristic {
@@ -240,14 +241,6 @@ static gint cmp_watcher(gconstpointer a, gconstpointer b)
 	return g_strcmp0(watcher->path, match->path);
 }
 
-static gint cmp_char_uuid(gconstpointer a, gconstpointer b)
-{
-	const struct characteristic *ch = a;
-	const char *uuid = b;
-
-	return g_strcmp0(ch->attr.uuid, uuid);
-}
-
 static gint cmp_char_val_handle(gconstpointer a, gconstpointer b)
 {
 	const struct characteristic *ch = a;
@@ -267,18 +260,6 @@ find_thermometer_adapter(struct btd_adapter *adapter)
 	return l->data;
 }
 
-static struct characteristic *get_characteristic(struct thermometer *t,
-							const char *uuid)
-{
-	GSList *l;
-
-	l = g_slist_find_custom(t->chars, uuid, cmp_char_uuid);
-	if (l == NULL)
-		return NULL;
-
-	return l->data;
-}
-
 static void change_property(struct thermometer *t, const char *name,
 							gpointer value) {
 	if (g_strcmp0(name, "Intermediate") == 0) {
@@ -541,6 +522,8 @@ static void process_thermometer_char(struct characteristic *ch)
 		gatt_read_char(ch->t->attrib, ch->attr.value_handle,
 							read_temp_type_cb, ch);
 	} else if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0) {
+		ch->t->interval_val_handle = ch->attr.value_handle;
+
 		gatt_read_char(ch->t->attrib, ch->attr.value_handle,
 							read_interval_cb, ch);
 	}
@@ -651,14 +634,12 @@ static DBusMessage *write_attr_interval(struct thermometer *t, DBusMessage *msg,
 								uint16_t value)
 {
 	struct tmp_interval_data *data;
-	struct characteristic *ch;
 	uint8_t atval[2];
 
 	if (t->attrib == NULL)
 		return btd_error_not_connected(msg);
 
-	ch = get_characteristic(t, MEASUREMENT_INTERVAL_UUID);
-	if (ch == NULL)
+	if (t->interval_val_handle == 0)
 		return btd_error_not_available(msg);
 
 	if (value < t->min || value > t->max)
@@ -669,7 +650,7 @@ static DBusMessage *write_attr_interval(struct thermometer *t, DBusMessage *msg,
 	data = g_new0(struct tmp_interval_data, 1);
 	data->thermometer = t;
 	data->interval = value;
-	gatt_write_char(t->attrib, ch->attr.value_handle, atval, 2,
+	gatt_write_char(t->attrib, t->interval_val_handle, atval, 2,
 						write_interval_cb, data);
 
 	return dbus_message_new_method_return(msg);
-- 
1.8.0

