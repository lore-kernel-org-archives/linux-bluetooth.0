Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v5 1/8] attrib: Add mtu argument to g_attrib_new
Date: Fri, 31 Oct 2014 11:14:52 -0700
Message-Id: <1414779299-18197-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1414779299-18197-1-git-send-email-jamuraa@chromium.org>
References: <1414779299-18197-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of using the default MTU, use one passed
in by the user, and detect it from the channel when
it is created.
---
 attrib/gattrib.c     |  9 +++------
 attrib/gattrib.h     |  2 +-
 attrib/gatttool.c    | 17 ++++++++++++++++-
 attrib/interactive.c | 17 ++++++++++++++++-
 src/device.c         | 11 ++++++++++-
 5 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index ba2f6cc..a6511a2 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -473,10 +473,9 @@ done:
 	return TRUE;
 }
 
-GAttrib *g_attrib_new(GIOChannel *io)
+GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu)
 {
 	struct _GAttrib *attrib;
-	uint16_t att_mtu;
 
 	g_io_channel_set_encoding(io, NULL, NULL);
 	g_io_channel_set_buffered(io, FALSE);
@@ -485,10 +484,8 @@ GAttrib *g_attrib_new(GIOChannel *io)
 	if (attrib == NULL)
 		return NULL;
 
-	att_mtu = ATT_DEFAULT_LE_MTU;
-
-	attrib->buf = g_malloc0(att_mtu);
-	attrib->buflen = att_mtu;
+	attrib->buf = g_malloc0(mtu);
+	attrib->buflen = mtu;
 
 	attrib->io = g_io_channel_ref(io);
 	attrib->requests = g_queue_new();
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 18df2ad..99b8b37 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -42,7 +42,7 @@ typedef void (*GAttribDebugFunc)(const char *str, gpointer user_data);
 typedef void (*GAttribNotifyFunc)(const guint8 *pdu, guint16 len,
 							gpointer user_data);
 
-GAttrib *g_attrib_new(GIOChannel *io);
+GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu);
 GAttrib *g_attrib_ref(GAttrib *attrib);
 void g_attrib_unref(GAttrib *attrib);
 
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index db5da62..8f92d62 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -123,6 +123,9 @@ static gboolean listen_start(gpointer user_data)
 static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	GAttrib *attrib;
+	uint16_t mtu;
+	uint16_t cid;
+	GError *gerr = NULL;
 
 	if (err) {
 		g_printerr("%s\n", err->message);
@@ -130,7 +133,19 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 		g_main_loop_quit(event_loop);
 	}
 
-	attrib = g_attrib_new(io);
+	bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &mtu,
+				BT_IO_OPT_CID, &cid, BT_IO_OPT_INVALID);
+
+	if (gerr) {
+		g_printerr("Can't detect MTU, using default: %s", gerr->message);
+		g_error_free(gerr);
+		mtu = ATT_DEFAULT_LE_MTU;
+	}
+
+	if (cid == ATT_CID)
+		mtu = ATT_DEFAULT_LE_MTU;
+
+	attrib = g_attrib_new(io, mtu);
 
 	if (opt_listen)
 		g_idle_add(listen_start, attrib);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 08f39f7..7911ba5 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -150,13 +150,28 @@ static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 
 static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
+	uint16_t mtu;
+	uint16_t cid;
+
 	if (err) {
 		set_state(STATE_DISCONNECTED);
 		error("%s\n", err->message);
 		return;
 	}
 
-	attrib = g_attrib_new(iochannel);
+	bt_io_get(io, &err, BT_IO_OPT_IMTU, &mtu,
+				BT_IO_OPT_CID, &cid, BT_IO_OPT_INVALID);
+
+	if (err) {
+		g_printerr("Can't detect MTU, using default: %s", err->message);
+		g_error_free(err);
+		mtu = ATT_DEFAULT_LE_MTU;
+	}
+
+	if (cid == ATT_CID)
+		mtu = ATT_DEFAULT_LE_MTU;
+
+	attrib = g_attrib_new(iochannel, mtu);
 	g_attrib_register(attrib, ATT_OP_HANDLE_NOTIFY, GATTRIB_ALL_HANDLES,
 						events_handler, attrib, NULL);
 	g_attrib_register(attrib, ATT_OP_HANDLE_IND, GATTRIB_ALL_HANDLES,
diff --git a/src/device.c b/src/device.c
index db6c4f8..6e1f8ea 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3628,11 +3628,17 @@ bool device_attach_attrib(struct btd_device *dev, GIOChannel *io)
 	GError *gerr = NULL;
 	GAttrib *attrib;
 	BtIOSecLevel sec_level;
+	uint16_t mtu;
+	uint16_t cid;
 
 	bt_io_get(io, &gerr, BT_IO_OPT_SEC_LEVEL, &sec_level,
+						BT_IO_OPT_IMTU, &mtu,
+						BT_IO_OPT_CID, &cid,
 						BT_IO_OPT_INVALID);
+
 	if (gerr) {
 		error("bt_io_get: %s", gerr->message);
+		mtu = ATT_DEFAULT_LE_MTU;
 		g_error_free(gerr);
 		return false;
 	}
@@ -3650,7 +3656,10 @@ bool device_attach_attrib(struct btd_device *dev, GIOChannel *io)
 		}
 	}
 
-	attrib = g_attrib_new(io);
+	if (cid == ATT_CID)
+		mtu = ATT_DEFAULT_LE_MTU;
+
+	attrib = g_attrib_new(io, mtu);
 	if (!attrib) {
 		error("Unable to create new GAttrib instance");
 		return false;
-- 
2.1.0.rc2.206.gedb03e5

