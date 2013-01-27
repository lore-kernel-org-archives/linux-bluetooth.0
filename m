Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3 v3] AVCTP: Add destroy callback to avctp_register_browsing_pdu_handler
Date: Sun, 27 Jan 2013 17:52:16 -0600
Message-Id: <1359330736-9190-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359330736-9190-1-git-send-email-luiz.dentz@gmail.com>
References: <1359330736-9190-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a destroy callback which is called when the PDU handler is
destroyed.
---
 profiles/audio/avctp.c | 44 +++++++++++++++++++++++++++++++++++++-------
 profiles/audio/avctp.h |  3 ++-
 profiles/audio/avrcp.c | 21 ++++++++++++---------
 3 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 6cac718..41e2f46 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -168,6 +168,7 @@ struct avctp_channel {
 	GQueue *queue;
 	GSList *processed;
 	guint process_id;
+	GDestroyNotify destroy;
 };
 
 struct key_pressed {
@@ -206,6 +207,7 @@ struct avctp_browsing_pdu_handler {
 	avctp_browsing_pdu_cb cb;
 	void *user_data;
 	unsigned int id;
+	GDestroyNotify destroy;
 };
 
 static struct {
@@ -406,6 +408,9 @@ static void avctp_channel_destroy(struct avctp_channel *chan)
 	if (chan->process_id > 0)
 		g_source_remove(chan->process_id);
 
+	if (chan->destroy)
+		chan->destroy(chan);
+
 	g_free(chan->buffer);
 	g_queue_foreach(chan->queue, pending_destroy, NULL);
 	g_queue_free(chan->queue);
@@ -985,7 +990,8 @@ static void init_uinput(struct avctp *session)
 }
 
 static struct avctp_channel *avctp_channel_create(struct avctp *session,
-							GIOChannel *io)
+							GIOChannel *io,
+							GDestroyNotify destroy)
 {
 	struct avctp_channel *chan;
 
@@ -993,10 +999,30 @@ static struct avctp_channel *avctp_channel_create(struct avctp *session,
 	chan->session = session;
 	chan->io = g_io_channel_ref(io);
 	chan->queue = g_queue_new();
+	chan->destroy = destroy;
 
 	return chan;
 }
 
+static void handler_free(void *data)
+{
+	struct avctp_browsing_pdu_handler *handler = data;
+
+	if (handler->destroy)
+		handler->destroy(handler->user_data);
+
+	g_free(data);
+}
+
+static void avctp_destroy_browsing(void *data)
+{
+	struct avctp_channel *chan = data;
+
+	g_slist_free_full(chan->handlers, handler_free);
+
+	chan->handlers = NULL;
+}
+
 static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 							gpointer data)
 {
@@ -1026,7 +1052,8 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 	DBG("AVCTP Browsing: connected to %s", address);
 
 	if (session->browsing == NULL)
-		session->browsing = avctp_channel_create(session, chan);
+		session->browsing = avctp_channel_create(session, chan,
+						avctp_destroy_browsing);
 
 	session->browsing->imtu = imtu;
 	session->browsing->omtu = omtu;
@@ -1075,7 +1102,7 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	DBG("AVCTP: connected to %s", address);
 
 	if (session->control == NULL)
-		session->control = avctp_channel_create(session, chan);
+		session->control = avctp_channel_create(session, chan, NULL);
 
 	session->control->imtu = imtu;
 	session->control->omtu = omtu;
@@ -1189,7 +1216,7 @@ static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
 	}
 
 	avctp_set_state(session, AVCTP_STATE_CONNECTING);
-	session->control = avctp_channel_create(session, chan);
+	session->control = avctp_channel_create(session, chan, NULL);
 
 	src = adapter_get_address(device_get_adapter(dev->btd_dev));
 	dst = device_get_address(dev->btd_dev);
@@ -1666,7 +1693,8 @@ unsigned int avctp_register_pdu_handler(struct avctp *session, uint8_t opcode,
 
 unsigned int avctp_register_browsing_pdu_handler(struct avctp *session,
 						avctp_browsing_pdu_cb cb,
-						void *user_data)
+						void *user_data,
+						GDestroyNotify destroy)
 {
 	struct avctp_channel *browsing = session->browsing;
 	struct avctp_browsing_pdu_handler *handler;
@@ -1682,6 +1710,7 @@ unsigned int avctp_register_browsing_pdu_handler(struct avctp *session,
 	handler->cb = cb;
 	handler->user_data = user_data;
 	handler->id = ++id;
+	handler->destroy = destroy;
 
 	browsing->handlers = g_slist_append(browsing->handlers, handler);
 
@@ -1787,7 +1816,7 @@ struct avctp *avctp_connect(struct audio_device *device)
 		return NULL;
 	}
 
-	session->control = avctp_channel_create(session, io);
+	session->control = avctp_channel_create(session, io, NULL);
 	g_io_channel_unref(io);
 
 	return session;
@@ -1821,7 +1850,8 @@ int avctp_connect_browsing(struct avctp *session)
 		return -EIO;
 	}
 
-	session->browsing = avctp_channel_create(session, io);
+	session->browsing = avctp_channel_create(session, io,
+						avctp_destroy_browsing);
 	g_io_channel_unref(io);
 
 	return 0;
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index 6cbda92..411b093 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -110,7 +110,8 @@ gboolean avctp_unregister_pdu_handler(unsigned int id);
 
 unsigned int avctp_register_browsing_pdu_handler(struct avctp *session,
 						avctp_browsing_pdu_cb cb,
-						void *user_data);
+						void *user_data,
+						GDestroyNotify destroy);
 gboolean avctp_unregister_browsing_pdu_handler(unsigned int id);
 
 int avctp_send_passthrough(struct avctp *session, uint8_t op);
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 6b61664..f83c3db 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2165,12 +2165,20 @@ static struct avrcp *find_session(GSList *list, struct audio_device *dev)
 	return NULL;
 }
 
+static void destroy_browsing(void *data)
+{
+	struct avrcp *session = data;
+
+	session->browsing_id = 0;
+}
+
 static void session_tg_init_browsing(struct avrcp *session)
 {
 	session->browsing_id = avctp_register_browsing_pdu_handler(
 							session->conn,
 							handle_browsing_pdu,
-							session);
+							session,
+							destroy_browsing);
 }
 
 static void session_tg_init_control(struct avrcp *session)
@@ -2210,7 +2218,8 @@ static void session_ct_init_browsing(struct avrcp *session)
 	session->browsing_id = avctp_register_browsing_pdu_handler(
 							session->conn,
 							handle_browsing_pdu,
-							session);
+							session,
+							destroy_browsing);
 }
 
 static void session_ct_init_control(struct avrcp *session)
@@ -2378,15 +2387,9 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 
 		break;
 	case AVCTP_STATE_CONNECTED:
-		if (session == NULL)
+		if (session == NULL || session->control_id > 0)
 			break;
 
-		if (session->browsing_id > 0)
-			session->browsing_id = 0;
-
-		if (session->control_id > 0)
-			return;
-
 		session->init_control(session);
 
 		if (session->version >= 0x0104 &&
-- 
1.8.1

