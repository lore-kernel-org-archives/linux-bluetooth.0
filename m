Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6 v2] Make use of g_slist_free_full on audio plugin
Date: Wed, 29 Jun 2011 20:05:14 +0300
Message-Id: <1309367114-5286-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
Fix stream->callbacks being free twice instead of freing stream->caps

 audio/a2dp.c             |   16 +++++-----------
 audio/avdtp.c            |   13 ++++---------
 audio/headset.c          |    8 ++++----
 audio/media.c            |    5 ++---
 audio/telephony-maemo6.c |   17 +++++++++--------
 audio/telephony-ofono.c  |   24 ++++++++++++++++--------
 audio/unix.c             |   19 +++++++------------
 7 files changed, 47 insertions(+), 55 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 03a18ab..01a378c 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -163,10 +163,8 @@ static void setup_free(struct a2dp_setup *s)
 	setups = g_slist_remove(setups, s);
 	if (s->session)
 		avdtp_unref(s->session);
-	g_slist_foreach(s->cb, (GFunc) g_free, NULL);
-	g_slist_free(s->cb);
-	g_slist_foreach(s->caps, (GFunc) g_free, NULL);
-	g_slist_free(s->caps);
+	g_slist_free_full(s->cb, g_free);
+	g_slist_free_full(s->caps, g_free);
 	g_free(s);
 }
 
@@ -1601,11 +1599,8 @@ void a2dp_unregister(const bdaddr_t *src)
 	if (!server)
 		return;
 
-	g_slist_foreach(server->sinks, (GFunc) a2dp_remove_sep, NULL);
-	g_slist_free(server->sinks);
-
-	g_slist_foreach(server->sources, (GFunc) a2dp_remove_sep, NULL);
-	g_slist_free(server->sources);
+	g_slist_free_full(server->sinks, (GDestroyNotify) a2dp_remove_sep);
+	g_slist_free_full(server->sources, (GDestroyNotify) a2dp_remove_sep);
 
 	avdtp_exit(src);
 
@@ -2126,8 +2121,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 
 	/* Copy given caps if they are different than current caps */
 	if (setup->caps != caps) {
-		g_slist_foreach(setup->caps, (GFunc) g_free, NULL);
-		g_slist_free(setup->caps);
+		g_slist_free_full(setup->caps, g_free);
 		setup->caps = g_slist_copy(caps);
 	}
 
diff --git a/audio/avdtp.c b/audio/avdtp.c
index fd388a8..48e4de5 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -800,11 +800,8 @@ static void stream_free(struct avdtp_stream *stream)
 	if (stream->io_id)
 		g_source_remove(stream->io_id);
 
-	g_slist_foreach(stream->callbacks, (GFunc) g_free, NULL);
-	g_slist_free(stream->callbacks);
-
-	g_slist_foreach(stream->caps, (GFunc) g_free, NULL);
-	g_slist_free(stream->caps);
+	g_slist_free_full(stream->callbacks, g_free);
+	g_slist_free_full(stream->caps, g_free);
 
 	g_free(stream);
 }
@@ -1239,8 +1236,7 @@ void avdtp_unref(struct avdtp *session)
 	if (session->req)
 		pending_req_free(session->req);
 
-	g_slist_foreach(session->seps, (GFunc) g_free, NULL);
-	g_slist_free(session->seps);
+	g_slist_free_full(session->seps, g_free);
 
 	g_free(session->buf);
 
@@ -2869,8 +2865,7 @@ static gboolean avdtp_get_capabilities_resp(struct avdtp *session,
 					sep->type, sep->media_type);
 
 	if (sep->caps) {
-		g_slist_foreach(sep->caps, (GFunc) g_free, NULL);
-		g_slist_free(sep->caps);
+		g_slist_free_full(sep->caps, g_free);
 		sep->caps = NULL;
 		sep->codec = NULL;
 		sep->delay_reporting = FALSE;
diff --git a/audio/headset.c b/audio/headset.c
index ed913b9..20b3a89 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -457,8 +457,7 @@ static void pending_connect_finalize(struct audio_device *dev)
 
 	g_slist_foreach(p->callbacks, (GFunc) pending_connect_complete, dev);
 
-	g_slist_foreach(p->callbacks, (GFunc) g_free, NULL);
-	g_slist_free(p->callbacks);
+	g_slist_free_full(p->callbacks, g_free);
 
 	if (p->io) {
 		g_io_channel_shutdown(p->io, TRUE, NULL);
@@ -2176,6 +2175,8 @@ static DBusMessage *hs_register_agent(DBusConnection *conn,
 
 	hs->agent = agent;
 
+	DBG("Agent %s%s registered", name, path);
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -2322,8 +2323,7 @@ static void headset_free(struct audio_device *dev)
 
 	headset_close_rfcomm(dev);
 
-	g_slist_foreach(hs->nrec_cbs, (GFunc) g_free, NULL);
-	g_slist_free(hs->nrec_cbs);
+	g_slist_free_full(hs->nrec_cbs, g_free);
 
 	agent_free(hs->agent);
 	g_free(hs);
diff --git a/audio/media.c b/audio/media.c
index bbb77cf..a58e96f 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -408,9 +408,8 @@ static void path_free(void *data)
 {
 	struct media_adapter *adapter = data;
 
-	g_slist_foreach(adapter->endpoints, (GFunc) media_endpoint_release,
-									NULL);
-	g_slist_free(adapter->endpoints);
+	g_slist_free_full(adapter->endpoints,
+				(GDestroyNotify) media_endpoint_release);
 
 	dbus_connection_unref(adapter->conn);
 
diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index cad4475..14d1ead 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -448,8 +448,10 @@ void telephony_device_connected(void *telephony_device)
 	}
 }
 
-static void pending_req_finalize(struct pending_req *req)
+static void pending_req_finalize(void *data)
 {
+	struct pending_req *req = data;
+
 	if (!dbus_pending_call_get_completed(req->call))
 		dbus_pending_call_cancel(req->call);
 
@@ -1486,8 +1488,10 @@ static void handle_hal_property_modified(DBusMessage *msg)
 	}
 }
 
-static void csd_call_free(struct csd_call *call)
+static void csd_call_free(void *data)
 {
+	struct csd_call *call = data;
+
 	if (!call)
 		return;
 
@@ -1975,16 +1979,13 @@ void telephony_exit(void)
 	g_slist_free(active_calls);
 	active_calls = NULL;
 
-	g_slist_foreach(calls, (GFunc) csd_call_free, NULL);
-	g_slist_free(calls);
+	g_slist_free_full(calls, csd_call_free);
 	calls = NULL;
 
-	g_slist_foreach(pending, (GFunc) pending_req_finalize, NULL);
-	g_slist_free(pending);
+	g_slist_free_full(pending, pending_req_finalize);
 	pending = NULL;
 
-	g_slist_foreach(watches, (GFunc) remove_watch, NULL);
-	g_slist_free(watches);
+	g_slist_free_full(pending, remove_watch);
 	watches = NULL;
 
 	dbus_connection_unref(connection);
diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 20dc907..e72734c 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -638,8 +638,10 @@ static gboolean iter_get_basic_args(DBusMessageIter *iter,
 	return type == DBUS_TYPE_INVALID ? TRUE : FALSE;
 }
 
-static void call_free(struct voice_call *vc)
+static void call_free(void *data)
 {
+	struct voice_call *vc = data;
+
 	DBG("%s", vc->obj_path);
 
 	if (vc->status == CALL_STATUS_ACTIVE)
@@ -1024,8 +1026,7 @@ static void modem_removed(const char *path)
 
 	DBG("%s", path);
 
-	g_slist_foreach(calls, (GFunc) call_free, NULL);
-	g_slist_free(calls);
+	g_slist_free_full(calls, call_free);
 	calls = NULL;
 
 	g_free(net.operator_name);
@@ -1601,6 +1602,16 @@ static void remove_watch(gpointer data)
 	g_dbus_remove_watch(connection, GPOINTER_TO_UINT(data));
 }
 
+static void pending_free(void *data)
+{
+	DBusPendingCall *call = data;
+
+	if (!dbus_pending_call_get_completed(call))
+		dbus_pending_call_cancel(call);
+
+	dbus_pending_call_unref(call);
+}
+
 void telephony_exit(void)
 {
 	DBG("");
@@ -1611,13 +1622,10 @@ void telephony_exit(void)
 	if (modem_obj_path)
 		modem_removed(modem_obj_path);
 
-	g_slist_foreach(watches, (GFunc) remove_watch, NULL);
-	g_slist_free(watches);
+	g_slist_free_full(watches, remove_watch);
 	watches = NULL;
 
-	g_slist_foreach(pending, (GFunc) dbus_pending_call_cancel, NULL);
-	g_slist_foreach(pending, (GFunc) dbus_pending_call_unref, NULL);
-	g_slist_free(pending);
+	g_slist_free_full(pending, pending_free);
 	pending = NULL;
 
 	dbus_connection_unref(connection);
diff --git a/audio/unix.c b/audio/unix.c
index b29f5f5..8ce50b0 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -97,8 +97,10 @@ static GSList *clients = NULL;
 
 static int unix_sock = -1;
 
-static void client_free(struct unix_client *client)
+static void client_free(void *data)
 {
+	struct unix_client *client = data;
+
 	DBG("client_free(%p)", client);
 
 	if (client->cancel && client->dev && client->req_id > 0)
@@ -107,10 +109,7 @@ static void client_free(struct unix_client *client)
 	if (client->sock >= 0)
 		close(client->sock);
 
-	if (client->caps) {
-		g_slist_foreach(client->caps, (GFunc) g_free, NULL);
-		g_slist_free(client->caps);
-	}
+	g_slist_free_full(client->caps, g_free);
 
 	g_free(client->interface);
 	g_free(client);
@@ -1493,11 +1492,8 @@ static int handle_a2dp_transport(struct unix_client *client,
 			!g_str_equal(client->interface, AUDIO_SOURCE_INTERFACE))
 		return -EIO;
 
-	if (client->caps) {
-		g_slist_foreach(client->caps, (GFunc) g_free, NULL);
-		g_slist_free(client->caps);
-		client->caps = NULL;
-	}
+	g_slist_free_full(client->caps, g_free);
+	client->caps = NULL;
 
 	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
 						NULL, 0);
@@ -1907,8 +1903,7 @@ int unix_init(void)
 
 void unix_exit(void)
 {
-	g_slist_foreach(clients, (GFunc) client_free, NULL);
-	g_slist_free(clients);
+	g_slist_free_full(clients, client_free);
 	if (unix_sock >= 0) {
 		close(unix_sock);
 		unix_sock = -1;
-- 
1.7.5.4

