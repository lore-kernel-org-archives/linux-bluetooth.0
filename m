Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 1/5] gattrib: Add support for listening for events for specific handles
Date: Wed, 10 Oct 2012 20:55:53 -0300
Message-Id: <1349913357-25547-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We want only the profile that implements a service to be notified of
changes on that service. Before this patch, all the registered event
notifiers are being called.
---
Hi,

I am re-sending this series because, if it makes sense, it would be awesome
if it gets the "UPF treatment".

Cheers,


 attrib/client.c                    |  4 ++--
 attrib/gattrib.c                   | 33 ++++++++++++++++++++++++++++-----
 attrib/gattrib.h                   |  7 ++++---
 attrib/gatttool.c                  |  8 ++++----
 attrib/interactive.c               |  8 ++++----
 profiles/gatt/gas.c                |  1 +
 profiles/heartrate/heartrate.c     |  2 +-
 profiles/input/hog_device.c        |  5 +++--
 profiles/scanparam/scan.c          |  4 ++--
 profiles/thermometer/thermometer.c |  2 ++
 src/attrib-server.c                |  2 +-
 11 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 8b29cbb..cda5bc0 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -393,9 +393,9 @@ static void attio_connected(GAttrib *attrib, gpointer user_data)
 	gatt->attrib = g_attrib_ref(attrib);
 
 	g_attrib_register(gatt->attrib, ATT_OP_HANDLE_NOTIFY,
-					events_handler, gatt, NULL);
+			GATTRIB_ALL_HANDLES, events_handler, gatt, NULL);
 	g_attrib_register(gatt->attrib, ATT_OP_HANDLE_IND,
-					events_handler, gatt, NULL);
+			GATTRIB_ALL_HANDLES, events_handler, gatt, NULL);
 
 	g_slist_foreach(gatt->offline_chars, offline_char_write, attrib);
 
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 0806101..309e58f 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -70,6 +70,7 @@ struct command {
 struct event {
 	guint id;
 	guint8 expected;
+	guint16 handle;
 	GAttribNotifyFunc func;
 	gpointer user_data;
 	GDestroyNotify notify;
@@ -357,6 +358,30 @@ static void wake_up_sender(struct _GAttrib *attrib)
 				can_write_data, attrib, destroy_sender);
 }
 
+static gboolean match_event(struct event *evt, const uint8_t *pdu, gsize len)
+{
+	guint16 handle;
+
+	if (evt->expected == GATTRIB_ALL_EVENTS)
+		return TRUE;
+
+	if (is_response(pdu[0]) == FALSE && evt->expected == GATTRIB_ALL_REQS)
+		return TRUE;
+
+	if (evt->expected == pdu[0] && evt->handle == GATTRIB_ALL_HANDLES)
+		return TRUE;
+
+	if (len < 3)
+		return FALSE;
+
+	handle = att_get_u16(&pdu[1]);
+
+	if (evt->expected == pdu[0] && evt->handle == handle)
+		return TRUE;
+
+	return FALSE;
+}
+
 static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 {
 	struct _GAttrib *attrib = data;
@@ -387,10 +412,7 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	for (l = attrib->events; l; l = l->next) {
 		struct event *evt = l->data;
 
-		if (evt->expected == buf[0] ||
-				evt->expected == GATTRIB_ALL_EVENTS ||
-				(is_response(buf[0]) == FALSE &&
-						evt->expected == GATTRIB_ALL_REQS))
+		if (match_event(evt, buf, len))
 			evt->func(buf, len, evt->user_data);
 	}
 
@@ -645,7 +667,7 @@ gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
 	return TRUE;
 }
 
-guint g_attrib_register(GAttrib *attrib, guint8 opcode,
+guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify)
 {
@@ -657,6 +679,7 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode,
 		return 0;
 
 	event->expected = opcode;
+	event->handle = handle;
 	event->func = func;
 	event->user_data = user_data;
 	event->notify = notify;
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index bca966f..3fe92c7 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -30,6 +30,7 @@ extern "C" {
 
 #define GATTRIB_ALL_EVENTS 0xFF
 #define GATTRIB_ALL_REQS 0xFE
+#define GATTRIB_ALL_HANDLES 0x0000
 
 struct _GAttrib;
 typedef struct _GAttrib GAttrib;
@@ -60,9 +61,9 @@ gboolean g_attrib_cancel_all(GAttrib *attrib);
 gboolean g_attrib_set_debug(GAttrib *attrib,
 		GAttribDebugFunc func, gpointer user_data);
 
-guint g_attrib_register(GAttrib *attrib, guint8 opcode,
-		GAttribNotifyFunc func, gpointer user_data,
-					GDestroyNotify notify);
+guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
+				GAttribNotifyFunc func, gpointer user_data,
+				GDestroyNotify notify);
 
 gboolean g_attrib_is_encrypted(GAttrib *attrib);
 
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 252064d..2fe95c0 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -111,10 +111,10 @@ static gboolean listen_start(gpointer user_data)
 {
 	GAttrib *attrib = user_data;
 
-	g_attrib_register(attrib, ATT_OP_HANDLE_NOTIFY, events_handler,
-							attrib, NULL);
-	g_attrib_register(attrib, ATT_OP_HANDLE_IND, events_handler,
-							attrib, NULL);
+	g_attrib_register(attrib, ATT_OP_HANDLE_NOTIFY, GATTRIB_ALL_HANDLES,
+						events_handler, attrib, NULL);
+	g_attrib_register(attrib, ATT_OP_HANDLE_IND, GATTRIB_ALL_HANDLES,
+						events_handler, attrib, NULL);
 
 	return FALSE;
 }
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 716e675..6030fb7 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -147,10 +147,10 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	}
 
 	attrib = g_attrib_new(iochannel);
-	g_attrib_register(attrib, ATT_OP_HANDLE_NOTIFY, events_handler,
-							attrib, NULL);
-	g_attrib_register(attrib, ATT_OP_HANDLE_IND, events_handler,
-							attrib, NULL);
+	g_attrib_register(attrib, ATT_OP_HANDLE_NOTIFY, GATTRIB_ALL_HANDLES,
+						events_handler, attrib, NULL);
+	g_attrib_register(attrib, ATT_OP_HANDLE_IND, GATTRIB_ALL_HANDLES,
+						events_handler, attrib, NULL);
 	set_state(STATE_CONNECTED);
 }
 
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index f873121..bb626e7 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -334,6 +334,7 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	}
 
 	gas->changed_ind = g_attrib_register(gas->attrib, ATT_OP_HANDLE_IND,
+						GATTRIB_ALL_HANDLES,
 						indication_cb, gas, NULL);
 
 	if (device_get_appearance(gas->device, &app) < 0) {
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 94d4b8d..d9d6c03 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -544,7 +544,7 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	hr->attrib = g_attrib_ref(attrib);
 
 	hr->attionotid = g_attrib_register(hr->attrib, ATT_OP_HANDLE_NOTIFY,
-						notify_handler, hr, NULL);
+				GATTRIB_ALL_HANDLES, notify_handler, hr, NULL);
 
 	gatt_discover_char(hr->attrib, hr->svc_range->start, hr->svc_range->end,
 						NULL, discover_char_cb, hr);
diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index a8cc568..52ebd95 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -612,8 +612,9 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	hogdev->attrib = g_attrib_ref(attrib);
 
 	hogdev->report_cb_id = g_attrib_register(hogdev->attrib,
-					ATT_OP_HANDLE_NOTIFY, report_value_cb,
-					hogdev, NULL);
+					ATT_OP_HANDLE_NOTIFY,
+					GATTRIB_ALL_HANDLES,
+					report_value_cb, hogdev, NULL);
 
 	if (hogdev->reports == NULL) {
 		gatt_discover_char(hogdev->attrib, prim->range.start,
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index e523df5..bbf646c 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -115,8 +115,8 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu,
 	DBG("Scan Refresh: notification enabled");
 
 	scan->refresh_cb_id = g_attrib_register(scan->attrib,
-					ATT_OP_HANDLE_NOTIFY, refresh_value_cb,
-					user_data, NULL);
+				ATT_OP_HANDLE_NOTIFY, GATTRIB_ALL_HANDLES,
+				refresh_value_cb, user_data, NULL);
 }
 
 static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 4a79f99..4d1df1d 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -1191,8 +1191,10 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	t->attrib = g_attrib_ref(attrib);
 
 	t->attindid = g_attrib_register(t->attrib, ATT_OP_HANDLE_IND,
+							GATTRIB_ALL_HANDLES,
 							ind_handler, t, NULL);
 	t->attnotid = g_attrib_register(t->attrib, ATT_OP_HANDLE_NOTIFY,
+							GATTRIB_ALL_HANDLES,
 							notif_handler, t, NULL);
 	gatt_discover_char(t->attrib, t->svc_range->start, t->svc_range->end,
 					NULL, configure_thermometer_cb, t);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 7117fbe..ea27b13 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1096,7 +1096,7 @@ guint attrib_channel_attach(GAttrib *attrib)
 
 	channel->attrib = g_attrib_ref(attrib);
 	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_REQS,
-					channel_handler, channel, NULL);
+			GATTRIB_ALL_HANDLES, channel_handler, channel, NULL);
 
 	channel->cleanup_id = g_io_add_watch(io, G_IO_HUP, channel_watch_cb,
 								channel);
-- 
1.7.12.3

