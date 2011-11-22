Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 6/6] Use system types instead of GLIB ones.
Date: Tue, 22 Nov 2011 15:49:48 +0100
Message-Id: <1321973388-16300-7-git-send-email-sancane@gmail.com>
In-Reply-To: <1321973388-16300-6-git-send-email-sancane@gmail.com>
References: <1321973388-16300-1-git-send-email-sancane@gmail.com>
 <1321973388-16300-2-git-send-email-sancane@gmail.com>
 <1321973388-16300-3-git-send-email-sancane@gmail.com>
 <1321973388-16300-4-git-send-email-sancane@gmail.com>
 <1321973388-16300-5-git-send-email-sancane@gmail.com>
 <1321973388-16300-6-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   78 ++++++++++++++++++++++----------------------
 1 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index e37254c..97a8ea0 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -66,10 +66,10 @@ struct thermometer {
 	GSList			*fwatchers;     /* Final measurements */
 	GSList			*iwatchers;     /* Intermediate measurements */
 	gboolean		intermediate;
-	guint8			type;
-	guint16			interval;
-	guint16			max;
-	guint16			min;
+	uint8_t			type;
+	uint16_t		interval;
+	uint16_t		max;
+	uint16_t		min;
 	gboolean		has_type;
 	gboolean		has_interval;
 };
@@ -89,23 +89,23 @@ struct descriptor {
 struct watcher {
 	struct thermometer	*t;
 	guint			id;
-	gchar			*srv;
-	gchar			*path;
+	char			*srv;
+	char			*path;
 };
 
 struct measurement {
-	gint16		exp;
-	gint32		mant;
-	guint64		time;
+	int16_t		exp;
+	int32_t		mant;
+	uint64_t	time;
 	gboolean	suptime;
-	gchar		*unit;
-	gchar		*type;
-	gchar		*value;
+	char		*unit;
+	char		*type;
+	char		*value;
 };
 
 struct tmp_interval_data {
 	struct thermometer	*thermometer;
-	guint16			interval;
+	uint16_t		interval;
 };
 
 static GSList *thermometers = NULL;
@@ -207,7 +207,7 @@ static gint cmp_watcher(gconstpointer a, gconstpointer b)
 static gint cmp_char_uuid(gconstpointer a, gconstpointer b)
 {
 	const struct characteristic *ch = a;
-	const gchar *uuid = b;
+	const char *uuid = b;
 
 	return g_strcmp0(ch->attr.uuid, uuid);
 }
@@ -229,7 +229,7 @@ static gint cmp_descriptor(gconstpointer a, gconstpointer b)
 }
 
 static struct characteristic *get_characteristic(struct thermometer *t,
-							const gchar *uuid)
+							const char *uuid)
 {
 	GSList *l;
 
@@ -252,7 +252,7 @@ static struct descriptor *get_descriptor(struct characteristic *ch,
 	return l->data;
 }
 
-static void change_property(struct thermometer *t, const gchar *name,
+static void change_property(struct thermometer *t, const char *name,
 							gpointer value) {
 	if (g_strcmp0(name, "Intermediate") == 0) {
 		gboolean *intermediate = value;
@@ -388,7 +388,7 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 {
 	struct characteristic *ch = user_data;
 	struct att_data_list *list;
-	guint8 format;
+	uint8_t format;
 	int i;
 
 	if (status != 0) {
@@ -593,11 +593,11 @@ done:
 }
 
 static DBusMessage *write_attr_interval(struct thermometer *t, DBusMessage *msg,
-								guint16 value)
+								uint16_t value)
 {
 	struct tmp_interval_data *data;
 	struct characteristic *ch;
-	guint8 atval[2];
+	uint8_t atval[2];
 
 	if (t->attrib == NULL)
 		return btd_error_not_connected(msg);
@@ -627,7 +627,7 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 	const char *property;
 	DBusMessageIter iter;
 	DBusMessageIter sub;
-	guint16 value;
+	uint16_t value;
 
 	if (!dbus_message_iter_init(msg, &iter))
 		return btd_error_invalid_args(msg);
@@ -659,7 +659,7 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 static void measurement_cb(guint8 status, const guint8 *pdu,
 						guint16 len, gpointer user_data)
 {
-	gchar *msg = user_data;
+	char *msg = user_data;
 
 	if (status != 0)
 		error("%s failed", msg);
@@ -673,7 +673,7 @@ static void enable_final_measurement(struct thermometer *t)
 	struct descriptor *desc;
 	bt_uuid_t btuuid;
 	uint8_t atval[2];
-	gchar *msg;
+	char *msg;
 
 	if (t->attrib == NULL)
 		return;
@@ -703,7 +703,7 @@ static void enable_intermediate_measurement(struct thermometer *t)
 	struct descriptor *desc;
 	bt_uuid_t btuuid;
 	uint8_t atval[2];
-	gchar *msg;
+	char *msg;
 
 	if (t->attrib == NULL)
 		return;
@@ -733,7 +733,7 @@ static void disable_final_measurement(struct thermometer *t)
 	struct descriptor *desc;
 	bt_uuid_t btuuid;
 	uint8_t atval[2];
-	gchar *msg;
+	char *msg;
 
 	if (t->attrib == NULL)
 		return;
@@ -763,7 +763,7 @@ static void disable_intermediate_measurement(struct thermometer *t)
 	struct descriptor *desc;
 	bt_uuid_t btuuid;
 	uint8_t atval[2];
-	gchar *msg;
+	char *msg;
 
 	if (t->attrib == NULL)
 		return;
@@ -814,8 +814,8 @@ static void watcher_exit(DBusConnection *conn, void *user_data)
 		disable_final_measurement(t);
 }
 
-static struct watcher *find_watcher(GSList *list, const gchar *sender,
-							const gchar *path)
+static struct watcher *find_watcher(GSList *list, const char *sender,
+							const char *path)
 {
 	struct watcher *match;
 	GSList *l;
@@ -836,10 +836,10 @@ static struct watcher *find_watcher(GSList *list, const gchar *sender,
 static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
-	const gchar *sender = dbus_message_get_sender(msg);
+	const char *sender = dbus_message_get_sender(msg);
 	struct thermometer *t = data;
 	struct watcher *watcher;
-	gchar *path;
+	char *path;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 							DBUS_TYPE_INVALID))
@@ -869,10 +869,10 @@ static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
 static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
-	const gchar *sender = dbus_message_get_sender(msg);
+	const char *sender = dbus_message_get_sender(msg);
 	struct thermometer *t = data;
 	struct watcher *watcher;
-	gchar *path;
+	char *path;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 							DBUS_TYPE_INVALID))
@@ -898,10 +898,10 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 static DBusMessage *enable_intermediate(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
-	const gchar *sender = dbus_message_get_sender(msg);
+	const char *sender = dbus_message_get_sender(msg);
 	struct thermometer *t = data;
 	struct watcher *watcher;
-	gchar *path;
+	char *path;
 
 	if (!t->intermediate)
 		return btd_error_not_supported(msg);
@@ -930,10 +930,10 @@ static DBusMessage *enable_intermediate(DBusConnection *conn, DBusMessage *msg,
 static DBusMessage *disable_intermediate(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
-	const gchar *sender = dbus_message_get_sender(msg);
+	const char *sender = dbus_message_get_sender(msg);
 	struct thermometer *t = data;
 	struct watcher *watcher;
-	gchar *path;
+	char *path;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 							DBUS_TYPE_INVALID))
@@ -1020,7 +1020,7 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 						uint16_t len, gboolean final)
 {
 	struct measurement m;
-	const gchar *type;
+	const char *type;
 	uint8_t flags;
 	uint32_t raw;
 
@@ -1042,7 +1042,7 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 
 	raw = att_get_u32(&pdu[4]);
 	m.mant = raw & 0x00FFFFFF;
-	m.exp = ((gint32) raw) >> 24;
+	m.exp = ((int32_t) raw) >> 24;
 
 	if (m.mant & 0x00800000) {
 		/* convert to C2 negative value */
@@ -1067,7 +1067,7 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 		ts.tm_isdst = -1;
 
 		time = mktime(&ts);
-		m.time = (guint64) time;
+		m.time = (uint64_t) time;
 		m.suptime = TRUE;
 	} else
 		m.suptime = FALSE;
@@ -1105,7 +1105,7 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 static void proc_measurement_interval(struct thermometer *t, const uint8_t *pdu,
 								uint16_t len)
 {
-	guint16 interval;
+	uint16_t interval;
 
 	if (len < 5) {
 		DBG("Measurement interval value is not provided");
-- 
1.7.7.4

