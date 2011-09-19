Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 1/4] Attrib server integration for outgoing connections
Date: Mon, 19 Sep 2011 10:19:59 -0300
Message-Id: <1316438402-9982-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

We need support for attaching a client connection to the attribute
server because the server that we are connected may want to do
something similar to a reverse service discovery, and we need to be
able to receive indications and notifications.
---
 plugins/gatt-example.c |    3 ++-
 src/adapter.c          |    3 ++-
 src/attrib-server.c    |   41 +++++++++++++++++++++++++++--------------
 src/attrib-server.h    |    1 +
 src/device.c           |   10 ++++++++--
 5 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index f86e76d..7436488 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -32,8 +32,9 @@
 #include "plugin.h"
 #include "hcid.h"
 #include "log.h"
-#include "attrib-server.h"
+#include "gattrib.h"
 #include "att.h"
+#include "attrib-server.h"
 
 /* FIXME: Not defined by SIG? UUID128? */
 #define OPCODES_SUPPORTED_UUID          0xA001
diff --git a/src/adapter.c b/src/adapter.c
index 628db60..af8c273 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -55,8 +55,9 @@
 #include "glib-helper.h"
 #include "agent.h"
 #include "storage.h"
-#include "attrib-server.h"
+#include "gattrib.h"
 #include "att.h"
+#include "attrib-server.h"
 #include "eir.h"
 
 /* Flags Descriptions */
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5c86085..6c40681 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -780,7 +780,6 @@ static void channel_disconnect(void *user_data)
 {
 	struct gatt_channel *channel = user_data;
 
-	g_attrib_unref(channel->attrib);
 	clients = g_slist_remove(clients, channel);
 
 	g_slist_free(channel->notify);
@@ -914,16 +913,14 @@ done:
 							NULL, NULL, NULL);
 }
 
-static void connect_event(GIOChannel *io, GError *err, void *user_data)
+int attrib_channel_attach(GAttrib *attrib, gboolean out)
 {
 	struct gatt_channel *channel;
-	uint16_t cid;
+	GIOChannel *io;
 	GError *gerr = NULL;
+	uint16_t cid;
 
-	if (err) {
-		error("%s", err->message);
-		return;
-	}
+	io = g_attrib_get_channel(attrib);
 
 	channel = g_new0(struct gatt_channel, 1);
 
@@ -937,8 +934,7 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 		error("bt_io_get: %s", gerr->message);
 		g_error_free(gerr);
 		g_free(channel);
-		g_io_channel_shutdown(io, TRUE, NULL);
-		return;
+		return -EIO;
 	}
 
 	if (channel->mtu > ATT_MAX_MTU)
@@ -949,16 +945,33 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 	else
 		channel->le = TRUE;
 
-	channel->attrib = g_attrib_new(io);
-	g_io_channel_unref(io);
 
+	channel->attrib = g_attrib_ref(attrib);
 	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_EVENTS,
-				channel_handler, channel, NULL);
+					channel_handler, channel, NULL);
 
-	g_attrib_set_disconnect_function(channel->attrib, channel_disconnect,
-								channel);
+	if (out == FALSE)
+		g_attrib_set_disconnect_function(channel->attrib,
+						channel_disconnect, channel);
 
 	clients = g_slist_append(clients, channel);
+
+	return 0;
+}
+
+static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
+{
+	GAttrib *attrib;
+
+	if (gerr) {
+		error("%s", gerr->message);
+		return;
+	}
+
+	attrib = g_attrib_new(io);
+	attrib_channel_attach(attrib, FALSE);
+	g_io_channel_unref(io);
+	g_attrib_unref(attrib);
 }
 
 static void confirm_event(GIOChannel *io, void *user_data)
diff --git a/src/attrib-server.h b/src/attrib-server.h
index cde6eff..a72347c 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -31,3 +31,4 @@ int attrib_db_del(uint16_t handle);
 int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len);
 uint32_t attrib_create_sdp(uint16_t handle, const char *name);
 void attrib_free_sdp(uint32_t sdp_handle);
+int attrib_channel_attach(GAttrib *attrib, gboolean out);
diff --git a/src/device.c b/src/device.c
index 3be328d..41e8c35 100644
--- a/src/device.c
+++ b/src/device.c
@@ -60,6 +60,7 @@
 #include "sdp-xml.h"
 #include "storage.h"
 #include "btio.h"
+#include "attrib-server.h"
 #include "attrib/client.h"
 
 #define DISCONNECT_TIMER	2
@@ -1682,6 +1683,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct btd_device *device = user_data;
 	struct browse_req *req = device->browse;
+	GAttrib *attrib;
 
 	if (gerr) {
 		DBusMessage *reply;
@@ -1704,11 +1706,15 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		device->attioid = 0;
 	}
 
+	attrib = g_attrib_new(io);
+	if (attrib_channel_attach(attrib, TRUE) < 0)
+		error("Attribute server attach failure!");
+
 	if (req) {
-		req->attrib = g_attrib_new(io);
+		req->attrib = attrib;
 		gatt_discover_primary(req->attrib, NULL, primary_cb, req);
 	} else if (device->attios) {
-		device->attrib = g_attrib_new(io);
+		device->attrib = attrib;
 		g_attrib_set_disconnect_function(device->attrib,
 						attrib_disconnected, device);
 		g_slist_foreach(device->attios, attio_connected,
-- 
1.7.6.1

