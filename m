Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/2] Add handling of pending D-Bus calls in maemo6
Date: Fri, 25 Mar 2011 18:44:08 +0200
Message-Id: <1301071449-22230-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1301071449-22230-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1301071449-22230-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handling of pending D-Bus calls to csd back-end is added maemo6
telephony driver.
---
 audio/telephony-maemo6.c |   65 +++++++++++++++++++++++++++++++++++++++------
 1 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 55f6a30..9650cba 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -134,6 +134,11 @@ static struct {
 	.signal_bars = 0,
 };
 
+struct pending_req {
+	DBusPendingCall *call;
+	void *user_data;
+};
+
 static int get_property(const char *iface, const char *prop);
 
 static DBusConnection *connection = NULL;
@@ -443,10 +448,31 @@ void telephony_device_connected(void *telephony_device)
 	}
 }
 
+static void pending_req_finalize(struct pending_req *req)
+{
+	if (!dbus_pending_call_get_completed(req->call))
+		dbus_pending_call_cancel(req->call);
+
+	dbus_pending_call_unref(req->call);
+	g_free(req);
+}
+
+static void remove_pending_by_data(gpointer data, gpointer user_data)
+{
+	struct pending_req *req = data;
+
+	if (req->user_data == user_data) {
+		pending = g_slist_remove(pending, req);
+		pending_req_finalize(req);
+	}
+}
+
 void telephony_device_disconnected(void *telephony_device)
 {
 	DBG("telephony-maemo6: device %p disconnected", telephony_device);
 	events_enabled = FALSE;
+
+	g_slist_foreach(pending, remove_pending_by_data, telephony_device);
 }
 
 void telephony_event_reporting_req(void *telephony_device, int ind)
@@ -529,6 +555,7 @@ static int send_method_call(const char *dest, const char *path,
 	DBusMessage *msg;
 	DBusPendingCall *call;
 	va_list args;
+	struct pending_req *req;
 
 	msg = dbus_message_new_method_call(dest, path, interface, method);
 	if (!msg) {
@@ -558,12 +585,39 @@ static int send_method_call(const char *dest, const char *path,
 	}
 
 	dbus_pending_call_set_notify(call, cb, user_data, NULL);
-	pending = g_slist_prepend(pending, call);
+
+	req = g_new0(struct pending_req, 1);
+	req->call = call;
+	req->user_data = user_data;
+
+	pending = g_slist_prepend(pending, req);
 	dbus_message_unref(msg);
 
 	return 0;
 }
 
+static struct pending_req *find_request(const DBusPendingCall *call)
+{
+	GSList *l;
+
+	for (l = pending; l; l = l->next) {
+		struct pending_req *req = l->data;
+
+		if (req->call == call)
+			return req;
+	}
+
+	return NULL;
+}
+
+static void remove_pending(DBusPendingCall *call)
+{
+	struct pending_req *req = find_request(call);
+
+	pending = g_slist_remove(pending, req);
+	pending_req_finalize(req);
+}
+
 void telephony_last_dialed_number_req(void *telephony_device)
 {
 	int ret;
@@ -1295,12 +1349,6 @@ static gboolean iter_get_basic_args(DBusMessageIter *iter,
 	return type == DBUS_TYPE_INVALID ? TRUE : FALSE;
 }
 
-static void remove_pending(DBusPendingCall *call)
-{
-	pending = g_slist_remove(pending, call);
-	dbus_pending_call_unref(call);
-}
-
 static void hal_battery_level_reply(DBusPendingCall *call, void *user_data)
 {
 	DBusError err;
@@ -1910,8 +1958,7 @@ void telephony_exit(void)
 	g_slist_free(calls);
 	calls = NULL;
 
-	g_slist_foreach(pending, (GFunc) dbus_pending_call_cancel, NULL);
-	g_slist_foreach(pending, (GFunc) dbus_pending_call_unref, NULL);
+	g_slist_foreach(pending, (GFunc) pending_req_finalize, NULL);
 	g_slist_free(pending);
 	pending = NULL;
 
-- 
1.7.1

