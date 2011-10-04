Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 3/4] Add attrib server channel detach
Date: Tue,  4 Oct 2011 14:50:28 -0300
Message-Id: <1317750628-22563-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <CAKT1EBeusTPfkxJ59otvV29dpBUHqYt1U5afUEPYr50vEk+xkw@mail.gmail.com>
References: <CAKT1EBeusTPfkxJ59otvV29dpBUHqYt1U5afUEPYr50vEk+xkw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BlueZ will act as GAP central role, so for outgoing connections the
central is responsible for disconnecting the link. This patch adds
a function allowing the central to detach from the local attribute
server(removing the last GAttrib reference).
---
 src/attrib-server.c |   34 +++++++++++++++++++++++++++++++---
 src/attrib-server.h |    3 ++-
 src/device.c        |   11 ++++++++++-
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5c46e6d..5a50ade 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -792,6 +792,7 @@ static void channel_disconnect(void *user_data)
 	g_slist_free(channel->notify);
 	g_slist_free(channel->indicate);
 	g_slist_free_full(channel->configs, attrib_free);
+	g_attrib_unref(channel->attrib);
 
 	g_free(channel);
 }
@@ -920,7 +921,7 @@ done:
 							NULL, NULL, NULL);
 }
 
-int attrib_channel_attach(GAttrib *attrib, gboolean out)
+guint attrib_channel_attach(GAttrib *attrib, gboolean out)
 {
 	struct gatt_channel *channel;
 	GIOChannel *io;
@@ -941,7 +942,7 @@ int attrib_channel_attach(GAttrib *attrib, gboolean out)
 		error("bt_io_get: %s", gerr->message);
 		g_error_free(gerr);
 		g_free(channel);
-		return -EIO;
+		return 0;
 	}
 
 	if (channel->mtu > ATT_MAX_MTU)
@@ -963,7 +964,34 @@ int attrib_channel_attach(GAttrib *attrib, gboolean out)
 
 	clients = g_slist_append(clients, channel);
 
-	return 0;
+	return channel->id;
+}
+
+static gint channel_id_cmp(gconstpointer data, gconstpointer user_data)
+{
+	const struct gatt_channel *channel = data;
+	guint id = GPOINTER_TO_UINT(user_data);
+
+	return channel->id - id;
+}
+
+gboolean attrib_channel_detach(guint id)
+{
+	struct gatt_channel *channel;
+	GSList *l;
+
+	l = g_slist_find_custom(clients, GUINT_TO_POINTER(id),
+						channel_id_cmp);
+	if (!l)
+		return FALSE;
+
+	channel = l->data;
+
+	g_attrib_unregister(channel->attrib, channel->id);
+
+	channel_disconnect(channel);
+
+	return TRUE;
 }
 
 static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
diff --git a/src/attrib-server.h b/src/attrib-server.h
index a72347c..943096c 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -31,4 +31,5 @@ int attrib_db_del(uint16_t handle);
 int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len);
 uint32_t attrib_create_sdp(uint16_t handle, const char *name);
 void attrib_free_sdp(uint32_t sdp_handle);
-int attrib_channel_attach(GAttrib *attrib, gboolean out);
+guint attrib_channel_attach(GAttrib *attrib, gboolean out);
+gboolean attrib_channel_detach(guint id);
diff --git a/src/device.c b/src/device.c
index c19e294..45c4a6a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -142,6 +142,7 @@ struct btd_device {
 	GAttrib		*attrib;
 	GSList		*attios;
 	GSList		*attios_offline;
+	guint		attachid;		/* Attrib server attach */
 	guint		attioid;
 
 	gboolean	connected;
@@ -1712,6 +1713,7 @@ static void attrib_disconnected(gpointer user_data)
 							att_auto_connect,
 							device);
 
+	attrib_channel_detach(device->attachid);
 	g_attrib_unref(device->attrib);
 	device->attrib = NULL;
 }
@@ -1749,6 +1751,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	device_probe_drivers(device, uuids);
 
 	if (device->attios == NULL && device->attios_offline == NULL) {
+		attrib_channel_detach(device->attachid);
 		g_attrib_unref(device->attrib);
 		device->attrib = NULL;
 	} else
@@ -1796,7 +1799,8 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	}
 
 	attrib = g_attrib_new(io);
-	if (attrib_channel_attach(attrib, TRUE) < 0)
+	device->attachid = attrib_channel_attach(attrib, TRUE);
+	if (device->attachid == 0)
 		error("Attribute server attach failure!");
 
 	if (req) {
@@ -2809,6 +2813,11 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 		device->attioid = 0;
 	}
 
+	if (device->attachid) {
+		attrib_channel_detach(device->attachid);
+		device->attachid = 0;
+	}
+
 	if (device->attrib) {
 		g_attrib_unref(device->attrib);
 		device->attrib = NULL;
-- 
1.7.7

