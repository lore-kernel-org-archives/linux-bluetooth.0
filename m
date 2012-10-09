Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 04/15] thermometer: Include remote device information in MeasurementReceived
Date: Tue, 9 Oct 2012 13:19:47 +0200
Message-ID: <1349781598-22580-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1349781598-22580-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1349781598-22580-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since watchers are now registered per-adapter it's necessary to include
remote device information in MeasurementReceived callback.

This patch adds parameter to MeasurementReceived method which is an
object path to remote device object.
---
 profiles/thermometer/thermometer.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index c2d0529..64029b2 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -101,13 +101,14 @@ struct watcher {
 };
 
 struct measurement {
-	int16_t		exp;
-	int32_t		mant;
-	uint64_t	time;
-	gboolean	suptime;
-	char		*unit;
-	char		*type;
-	char		*value;
+	struct thermometer	*t;
+	int16_t			exp;
+	int32_t			mant;
+	uint64_t		time;
+	gboolean		suptime;
+	char			*unit;
+	char			*type;
+	char			*value;
 };
 
 struct tmp_interval_data {
@@ -1027,6 +1028,7 @@ static void update_watcher(gpointer data, gpointer user_data)
 {
 	struct watcher *w = data;
 	struct measurement *m = user_data;
+	const gchar *path = device_get_path(m->t->dev);
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	DBusMessage *msg;
@@ -1039,6 +1041,8 @@ static void update_watcher(gpointer data, gpointer user_data)
 
 	dbus_message_iter_init_append(msg, &iter);
 
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH , &path);
+
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
 			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
@@ -1064,6 +1068,8 @@ static void recv_measurement(struct thermometer *t, struct measurement *m)
 {
 	GSList *wlist;
 
+	m->t = t;
+
 	if (g_strcmp0(m->value, "Intermediate") == 0)
 		wlist = t->tadapter->iwatchers;
 	else
-- 
1.7.11.3

