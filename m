Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org
Subject: [PATCH] Move debug() to DBG()
Date: Fri, 21 May 2010 12:54:54 -0300
Message-Id: <1274457294-16232-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Use the new dynamic debug feature
---
 audio/a2dp.c             |  112 +++++++++++++++++++++++-----------------------
 audio/avdtp.c            |   98 ++++++++++++++++++++--------------------
 audio/control.c          |   36 +++++++-------
 audio/device.c           |    4 +-
 audio/gateway.c          |   14 +++---
 audio/headset.c          |   62 +++++++++++++-------------
 audio/main.c             |    6 +-
 audio/manager.c          |   46 +++++++++---------
 audio/sink.c             |   22 +++++-----
 audio/source.c           |   22 +++++-----
 audio/telephony-dummy.c  |   36 +++++++-------
 audio/telephony-maemo5.c |   64 +++++++++++++-------------
 audio/telephony-maemo6.c |   66 +++++++++++++-------------
 audio/telephony-ofono.c  |   74 +++++++++++++++---------------
 audio/telephony.h        |    4 +-
 audio/unix.c             |   30 ++++++------
 input/device.c           |    6 +-
 input/manager.c          |    2 +-
 input/server.c           |    2 +-
 network/common.c         |    4 +-
 network/connection.c     |    4 +-
 network/manager.c        |   18 ++++----
 network/server.c         |    8 ++--
 plugins/echo.c           |    4 +-
 plugins/hal.c            |    4 +-
 plugins/hciops.c         |    4 +-
 plugins/netlink.c        |    2 +-
 plugins/pnat.c           |   14 +++---
 plugins/service.c        |   16 +++---
 serial/port.c            |    8 ++--
 serial/proxy.c           |   16 +++---
 src/adapter.c            |   38 ++++++++--------
 src/agent.c              |   12 +++---
 src/dbus-hci.c           |   32 +++++++-------
 src/device.c             |   38 ++++++++--------
 src/main.c               |   36 +++++++-------
 src/plugin.c             |    8 ++--
 src/rfkill.c             |    4 +-
 src/sdpd-service.c       |    6 +-
 src/security.c           |    6 +-
 40 files changed, 494 insertions(+), 494 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 78957f7..6221c14 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -112,14 +112,14 @@ static struct a2dp_setup *setup_ref(struct a2dp_setup *setup)
 {
 	setup->ref++;
 
-	debug("setup_ref(%p): ref=%d", setup, setup->ref);
+	DBG("setup_ref(%p): ref=%d", setup, setup->ref);
 
 	return setup;
 }
 
 static void setup_free(struct a2dp_setup *s)
 {
-	debug("setup_free(%p)", s);
+	DBG("setup_free(%p)", s);
 	setups = g_slist_remove(setups, s);
 	if (s->session)
 		avdtp_unref(s->session);
@@ -132,7 +132,7 @@ static void setup_unref(struct a2dp_setup *setup)
 {
 	setup->ref--;
 
-	debug("setup_unref(%p): ref=%d", setup, setup->ref);
+	DBG("setup_unref(%p): ref=%d", setup, setup->ref);
 
 	if (setup->ref <= 0)
 		setup_free(setup);
@@ -290,9 +290,9 @@ static gboolean sbc_setconf_ind(struct avdtp *session,
 	struct audio_device *dev;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Set_Configuration_Ind", sep);
+		DBG("Sink %p: Set_Configuration_Ind", sep);
 	else
-		debug("Source %p: Set_Configuration_Ind", sep);
+		DBG("Source %p: Set_Configuration_Ind", sep);
 
 	dev = a2dp_get_dev(session);
 	if (!dev) {
@@ -353,9 +353,9 @@ static gboolean sbc_getcap_ind(struct avdtp *session, struct avdtp_local_sep *se
 	struct sbc_codec_cap sbc_cap;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Get_Capability_Ind", sep);
+		DBG("Sink %p: Get_Capability_Ind", sep);
 	else
-		debug("Source %p: Get_Capability_Ind", sep);
+		DBG("Source %p: Get_Capability_Ind", sep);
 
 	*caps = NULL;
 
@@ -417,9 +417,9 @@ static gboolean mpeg_setconf_ind(struct avdtp *session,
 	struct audio_device *dev;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Set_Configuration_Ind", sep);
+		DBG("Sink %p: Set_Configuration_Ind", sep);
 	else
-		debug("Source %p: Set_Configuration_Ind", sep);
+		DBG("Source %p: Set_Configuration_Ind", sep);
 
 	dev = a2dp_get_dev(session);
 	if (!dev) {
@@ -458,9 +458,9 @@ static gboolean mpeg_getcap_ind(struct avdtp *session,
 	struct mpeg_codec_cap mpeg_cap;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Get_Capability_Ind", sep);
+		DBG("Sink %p: Get_Capability_Ind", sep);
 	else
-		debug("Source %p: Get_Capability_Ind", sep);
+		DBG("Source %p: Get_Capability_Ind", sep);
 
 	*caps = NULL;
 
@@ -515,9 +515,9 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	int ret;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Set_Configuration_Cfm", sep);
+		DBG("Sink %p: Set_Configuration_Cfm", sep);
 	else
-		debug("Source %p: Set_Configuration_Cfm", sep);
+		DBG("Source %p: Set_Configuration_Cfm", sep);
 
 	setup = find_setup_by_session(session);
 
@@ -557,9 +557,9 @@ static gboolean getconf_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_sep *a2dp_sep = user_data;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Get_Configuration_Ind", sep);
+		DBG("Sink %p: Get_Configuration_Ind", sep);
 	else
-		debug("Source %p: Get_Configuration_Ind", sep);
+		DBG("Source %p: Get_Configuration_Ind", sep);
 	return TRUE;
 }
 
@@ -570,9 +570,9 @@ static void getconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_sep *a2dp_sep = user_data;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Set_Configuration_Cfm", sep);
+		DBG("Sink %p: Set_Configuration_Cfm", sep);
 	else
-		debug("Source %p: Set_Configuration_Cfm", sep);
+		DBG("Source %p: Set_Configuration_Cfm", sep);
 }
 
 static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
@@ -582,9 +582,9 @@ static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_sep *a2dp_sep = user_data;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Open_Ind", sep);
+		DBG("Sink %p: Open_Ind", sep);
 	else
-		debug("Source %p: Open_Ind", sep);
+		DBG("Source %p: Open_Ind", sep);
 	return TRUE;
 }
 
@@ -596,9 +596,9 @@ static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_setup *setup;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Open_Cfm", sep);
+		DBG("Sink %p: Open_Cfm", sep);
 	else
-		debug("Source %p: Open_Cfm", sep);
+		DBG("Source %p: Open_Cfm", sep);
 
 	setup = find_setup_by_session(session);
 	if (!setup)
@@ -636,9 +636,9 @@ static gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_setup *setup;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Start_Ind", sep);
+		DBG("Sink %p: Start_Ind", sep);
 	else
-		debug("Source %p: Start_Ind", sep);
+		DBG("Source %p: Start_Ind", sep);
 
 	setup = find_setup_by_session(session);
 	if (setup)
@@ -662,9 +662,9 @@ static void start_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_setup *setup;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Start_Cfm", sep);
+		DBG("Sink %p: Start_Cfm", sep);
 	else
-		debug("Source %p: Start_Cfm", sep);
+		DBG("Source %p: Start_Cfm", sep);
 
 	setup = find_setup_by_session(session);
 	if (!setup)
@@ -685,9 +685,9 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_sep *a2dp_sep = user_data;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Suspend_Ind", sep);
+		DBG("Sink %p: Suspend_Ind", sep);
 	else
-		debug("Source %p: Suspend_Ind", sep);
+		DBG("Source %p: Suspend_Ind", sep);
 
 	if (a2dp_sep->suspend_timer) {
 		g_source_remove(a2dp_sep->suspend_timer);
@@ -708,9 +708,9 @@ static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	gboolean start;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Suspend_Cfm", sep);
+		DBG("Sink %p: Suspend_Cfm", sep);
 	else
-		debug("Source %p: Suspend_Cfm", sep);
+		DBG("Source %p: Suspend_Cfm", sep);
 
 	a2dp_sep->suspending = FALSE;
 
@@ -751,9 +751,9 @@ static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_sep *a2dp_sep = user_data;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Close_Ind", sep);
+		DBG("Sink %p: Close_Ind", sep);
 	else
-		debug("Source %p: Close_Ind", sep);
+		DBG("Source %p: Close_Ind", sep);
 
 	return TRUE;
 }
@@ -816,9 +816,9 @@ static void close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_setup *setup;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Close_Cfm", sep);
+		DBG("Sink %p: Close_Cfm", sep);
 	else
-		debug("Source %p: Close_Cfm", sep);
+		DBG("Source %p: Close_Cfm", sep);
 
 	setup = find_setup_by_session(session);
 	if (!setup)
@@ -842,9 +842,9 @@ static gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_sep *a2dp_sep = user_data;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Abort_Ind", sep);
+		DBG("Sink %p: Abort_Ind", sep);
 	else
-		debug("Source %p: Abort_Ind", sep);
+		DBG("Source %p: Abort_Ind", sep);
 
 	a2dp_sep->stream = NULL;
 
@@ -859,9 +859,9 @@ static void abort_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_setup *setup;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: Abort_Cfm", sep);
+		DBG("Sink %p: Abort_Cfm", sep);
 	else
-		debug("Source %p: Abort_Cfm", sep);
+		DBG("Source %p: Abort_Cfm", sep);
 
 	setup = find_setup_by_session(session);
 	if (!setup)
@@ -876,9 +876,9 @@ static gboolean reconf_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_sep *a2dp_sep = user_data;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: ReConfigure_Ind", sep);
+		DBG("Sink %p: ReConfigure_Ind", sep);
 	else
-		debug("Source %p: ReConfigure_Ind", sep);
+		DBG("Source %p: ReConfigure_Ind", sep);
 	return TRUE;
 }
 
@@ -891,9 +891,9 @@ static gboolean delayreport_ind(struct avdtp *session,
 	struct audio_device *dev = a2dp_get_dev(session);
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: DelayReport_Ind", sep);
+		DBG("Sink %p: DelayReport_Ind", sep);
 	else
-		debug("Source %p: DelayReport_Ind", sep);
+		DBG("Source %p: DelayReport_Ind", sep);
 
 	unix_delay_report(dev, rseid, delay);
 
@@ -908,9 +908,9 @@ static void reconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_setup *setup;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: ReConfigure_Cfm", sep);
+		DBG("Sink %p: ReConfigure_Cfm", sep);
 	else
-		debug("Source %p: ReConfigure_Cfm", sep);
+		DBG("Source %p: ReConfigure_Cfm", sep);
 
 	setup = find_setup_by_session(session);
 	if (!setup)
@@ -931,9 +931,9 @@ static void delay_report_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct a2dp_sep *a2dp_sep = user_data;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		debug("Sink %p: DelayReport_Cfm", sep);
+		DBG("Sink %p: DelayReport_Cfm", sep);
 	else
-		debug("Source %p: DelayReport_Cfm", sep);
+		DBG("Source %p: DelayReport_Cfm", sep);
 }
 
 static struct avdtp_sep_cfm cfm = {
@@ -1129,7 +1129,7 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 	str = g_key_file_get_string(config, "General", "Enable", &err);
 
 	if (err) {
-		debug("audio.conf: %s", err->message);
+		DBG("audio.conf: %s", err->message);
 		g_clear_error(&err);
 	} else {
 		if (strstr(str, "Sink"))
@@ -1142,7 +1142,7 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 	str = g_key_file_get_string(config, "General", "Disable", &err);
 
 	if (err) {
-		debug("audio.conf: %s", err->message);
+		DBG("audio.conf: %s", err->message);
 		g_clear_error(&err);
 	} else {
 		if (strstr(str, "Sink"))
@@ -1154,7 +1154,7 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 
 	str = g_key_file_get_string(config, "A2DP", "SBCSources", &err);
 	if (err) {
-		debug("audio.conf: %s", err->message);
+		DBG("audio.conf: %s", err->message);
 		g_clear_error(&err);
 	} else {
 		sbc_srcs = atoi(str);
@@ -1163,7 +1163,7 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 
 	str = g_key_file_get_string(config, "A2DP", "MPEG12Sources", &err);
 	if (err) {
-		debug("audio.conf: %s", err->message);
+		DBG("audio.conf: %s", err->message);
 		g_clear_error(&err);
 	} else {
 		mpeg12_srcs = atoi(str);
@@ -1172,7 +1172,7 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 
 	str = g_key_file_get_string(config, "A2DP", "SBCSinks", &err);
 	if (err) {
-		debug("audio.conf: %s", err->message);
+		DBG("audio.conf: %s", err->message);
 		g_clear_error(&err);
 	} else {
 		sbc_sinks = atoi(str);
@@ -1181,7 +1181,7 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 
 	str = g_key_file_get_string(config, "A2DP", "MPEG12Sinks", &err);
 	if (err) {
-		debug("audio.conf: %s", err->message);
+		DBG("audio.conf: %s", err->message);
 		g_clear_error(&err);
 	} else {
 		mpeg12_sinks = atoi(str);
@@ -1354,7 +1354,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 	if (sep->codec != codec_cap->media_codec_type)
 		return 0;
 
-	debug("a2dp_config: selected SEP %p", sep->sep);
+	DBG("a2dp_config: selected SEP %p", sep->sep);
 
 	cb_data = g_new0(struct a2dp_setup_cb, 1);
 	cb_data->config_cb = cb;
@@ -1419,7 +1419,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 	case AVDTP_STATE_OPEN:
 	case AVDTP_STATE_STREAMING:
 		if (avdtp_stream_has_capabilities(setup->stream, caps)) {
-			debug("Configuration match: resuming");
+			DBG("Configuration match: resuming");
 			g_idle_add((GSourceFunc) finalize_config, setup);
 		} else if (!setup->reconfigure) {
 			setup->reconfigure = TRUE;
@@ -1558,7 +1558,7 @@ gboolean a2dp_cancel(struct audio_device *dev, unsigned int id)
 	struct a2dp_setup *setup;
 	GSList *l;
 
-	debug("a2dp_cancel()");
+	DBG("a2dp_cancel()");
 
 	setup = find_setup_by_dev(dev);
 	if (!setup)
@@ -1592,7 +1592,7 @@ gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session)
 	if (sep->locked)
 		return FALSE;
 
-	debug("SEP %p locked", sep->sep);
+	DBG("SEP %p locked", sep->sep);
 	sep->locked = TRUE;
 
 	return TRUE;
@@ -1606,7 +1606,7 @@ gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session)
 
 	sep->locked = FALSE;
 
-	debug("SEP %p unlocked", sep->sep);
+	DBG("SEP %p unlocked", sep->sep);
 
 	if (!sep->stream || state == AVDTP_STATE_IDLE)
 		return TRUE;
diff --git a/audio/avdtp.c b/audio/avdtp.c
index b28a71d..540bdf3 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -541,7 +541,7 @@ static gboolean avdtp_send(struct avdtp *session, uint8_t transaction,
 	cont_fragments = (len - (session->omtu - sizeof(start))) /
 					(session->omtu - sizeof(cont)) + 1;
 
-	debug("avdtp_send: %zu bytes split into %d fragments", len,
+	DBG("avdtp_send: %zu bytes split into %d fragments", len,
 							cont_fragments + 1);
 
 	/* Send the start packet */
@@ -559,7 +559,7 @@ static gboolean avdtp_send(struct avdtp *session, uint8_t transaction,
 	if (!try_send(sock, session->buf, session->omtu))
 		return FALSE;
 
-	debug("avdtp_send: first packet with %zu bytes sent",
+	DBG("avdtp_send: first packet with %zu bytes sent",
 						session->omtu - sizeof(start));
 
 	sent = session->omtu - sizeof(start);
@@ -572,12 +572,12 @@ static gboolean avdtp_send(struct avdtp *session, uint8_t transaction,
 		if (left + sizeof(cont) > session->omtu) {
 			cont.packet_type = AVDTP_PKT_TYPE_CONTINUE;
 			to_copy = session->omtu - sizeof(cont);
-			debug("avdtp_send: sending continue with %d bytes",
+			DBG("avdtp_send: sending continue with %d bytes",
 								to_copy);
 		} else {
 			cont.packet_type = AVDTP_PKT_TYPE_END;
 			to_copy = left;
-			debug("avdtp_send: sending end with %d bytes",
+			DBG("avdtp_send: sending end with %d bytes",
 								to_copy);
 		}
 
@@ -625,7 +625,7 @@ static gboolean stream_close_timeout(gpointer user_data)
 {
 	struct avdtp_stream *stream = user_data;
 
-	debug("Timed out waiting for peer to close the transport channel");
+	DBG("Timed out waiting for peer to close the transport channel");
 
 	stream->timer = 0;
 
@@ -638,7 +638,7 @@ static gboolean stream_open_timeout(gpointer user_data)
 {
 	struct avdtp_stream *stream = user_data;
 
-	debug("Timed out waiting for peer to open the transport channel");
+	DBG("Timed out waiting for peer to open the transport channel");
 
 	stream->timer = 0;
 
@@ -908,7 +908,7 @@ static void handle_unanswered_req(struct avdtp *session,
 
 	if (session->req->signal_id == AVDTP_ABORT) {
 		/* Avoid freeing the Abort request here */
-		debug("handle_unanswered_req: Abort req, returning");
+		DBG("handle_unanswered_req: Abort req, returning");
 		session->req->stream = NULL;
 		return;
 	}
@@ -977,11 +977,11 @@ static void avdtp_sep_set_state(struct avdtp *session,
 
 	if (sep->state == state) {
 		avdtp_error_init(&err, AVDTP_ERROR_ERRNO, EIO);
-		debug("stream state change failed: %s", avdtp_strerror(&err));
+		DBG("stream state change failed: %s", avdtp_strerror(&err));
 		err_ptr = &err;
 	} else {
 		err_ptr = NULL;
-		debug("stream state changed: %s -> %s",
+		DBG("stream state changed: %s -> %s",
 				avdtp_statestr(sep->state),
 				avdtp_statestr(state));
 	}
@@ -1069,7 +1069,7 @@ static void connection_lost(struct avdtp *session, int err)
 	struct audio_device *dev;
 
 	ba2str(&session->dst, address);
-	debug("Disconnected from %s", address);
+	DBG("Disconnected from %s", address);
 
 	dev = manager_get_device(&session->server->src, &session->dst, FALSE);
 
@@ -1119,7 +1119,7 @@ void avdtp_unref(struct avdtp *session)
 
 	session->ref--;
 
-	debug("avdtp_unref(%p): ref=%d", session, session->ref);
+	DBG("avdtp_unref(%p): ref=%d", session, session->ref);
 
 	if (session->ref == 1) {
 		if (session->state == AVDTP_SESSION_STATE_CONNECTING &&
@@ -1146,7 +1146,7 @@ void avdtp_unref(struct avdtp *session)
 
 	server = session->server;
 
-	debug("avdtp_unref(%p): freeing session and removing from list",
+	DBG("avdtp_unref(%p): freeing session and removing from list",
 			session);
 
 	if (session->dc_timer)
@@ -1168,7 +1168,7 @@ void avdtp_unref(struct avdtp *session)
 struct avdtp *avdtp_ref(struct avdtp *session)
 {
 	session->ref++;
-	debug("avdtp_ref(%p): ref=%d", session, session->ref);
+	DBG("avdtp_ref(%p): ref=%d", session, session->ref);
 	if (session->dc_timer)
 		remove_disconnect_timer(session);
 	return session;
@@ -1803,47 +1803,47 @@ static gboolean avdtp_parse_cmd(struct avdtp *session, uint8_t transaction,
 {
 	switch (signal_id) {
 	case AVDTP_DISCOVER:
-		debug("Received DISCOVER_CMD");
+		DBG("Received DISCOVER_CMD");
 		return avdtp_discover_cmd(session, transaction, buf, size);
 	case AVDTP_GET_CAPABILITIES:
-		debug("Received  GET_CAPABILITIES_CMD");
+		DBG("Received  GET_CAPABILITIES_CMD");
 		return avdtp_getcap_cmd(session, transaction, buf, size,
 									FALSE);
 	case AVDTP_GET_ALL_CAPABILITIES:
-		debug("Received  GET_ALL_CAPABILITIES_CMD");
+		DBG("Received  GET_ALL_CAPABILITIES_CMD");
 		return avdtp_getcap_cmd(session, transaction, buf, size, TRUE);
 	case AVDTP_SET_CONFIGURATION:
-		debug("Received SET_CONFIGURATION_CMD");
+		DBG("Received SET_CONFIGURATION_CMD");
 		return avdtp_setconf_cmd(session, transaction, buf, size);
 	case AVDTP_GET_CONFIGURATION:
-		debug("Received GET_CONFIGURATION_CMD");
+		DBG("Received GET_CONFIGURATION_CMD");
 		return avdtp_getconf_cmd(session, transaction, buf, size);
 	case AVDTP_RECONFIGURE:
-		debug("Received RECONFIGURE_CMD");
+		DBG("Received RECONFIGURE_CMD");
 		return avdtp_reconf_cmd(session, transaction, buf, size);
 	case AVDTP_OPEN:
-		debug("Received OPEN_CMD");
+		DBG("Received OPEN_CMD");
 		return avdtp_open_cmd(session, transaction, buf, size);
 	case AVDTP_START:
-		debug("Received START_CMD");
+		DBG("Received START_CMD");
 		return avdtp_start_cmd(session, transaction, buf, size);
 	case AVDTP_CLOSE:
-		debug("Received CLOSE_CMD");
+		DBG("Received CLOSE_CMD");
 		return avdtp_close_cmd(session, transaction, buf, size);
 	case AVDTP_SUSPEND:
-		debug("Received SUSPEND_CMD");
+		DBG("Received SUSPEND_CMD");
 		return avdtp_suspend_cmd(session, transaction, buf, size);
 	case AVDTP_ABORT:
-		debug("Received ABORT_CMD");
+		DBG("Received ABORT_CMD");
 		return avdtp_abort_cmd(session, transaction, buf, size);
 	case AVDTP_SECURITY_CONTROL:
-		debug("Received SECURITY_CONTROL_CMD");
+		DBG("Received SECURITY_CONTROL_CMD");
 		return avdtp_secctl_cmd(session, transaction, buf, size);
 	case AVDTP_DELAY_REPORT:
-		debug("Received DELAY_REPORT_CMD");
+		DBG("Received DELAY_REPORT_CMD");
 		return avdtp_delayreport_cmd(session, transaction, buf, size);
 	default:
-		debug("Received unknown request id %u", signal_id);
+		DBG("Received unknown request id %u", signal_id);
 		return avdtp_unknown_cmd(session, transaction, signal_id);
 	}
 }
@@ -1963,7 +1963,7 @@ static enum avdtp_parse_result avdtp_parse_data(struct avdtp *session,
 
 	if (session->in.no_of_packets > 1) {
 		session->in.no_of_packets--;
-		debug("Received AVDTP fragment. %d to go",
+		DBG("Received AVDTP fragment. %d to go",
 						session->in.no_of_packets);
 		return PARSE_FRAGMENT;
 	}
@@ -1980,7 +1980,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 	struct avdtp_common_header *header;
 	gsize size;
 
-	debug("session_cb");
+	DBG("session_cb");
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
@@ -2218,12 +2218,12 @@ static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	}
 
 	ba2str(&session->dst, address);
-	debug("AVDTP: connected %s channel to %s",
+	DBG("AVDTP: connected %s channel to %s",
 			session->pending_open ? "transport" : "signaling",
 			address);
 
 	if (session->state == AVDTP_SESSION_STATE_CONNECTING) {
-		debug("AVDTP imtu=%u, omtu=%u", session->imtu, session->omtu);
+		DBG("AVDTP imtu=%u, omtu=%u", session->imtu, session->omtu);
 
 		session->buf = g_malloc0(session->imtu);
 		avdtp_set_state(session, AVDTP_SESSION_STATE_CONNECTED);
@@ -2318,7 +2318,7 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 		goto drop;
 	}
 
-	debug("AVDTP: incoming connect from %s", address);
+	DBG("AVDTP: incoming connect from %s", address);
 
 	session = avdtp_get_internal(&src, &dst);
 	if (!session)
@@ -2331,7 +2331,7 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 	 * Abort the device's channel in favor of our own.
 	 */
 	if (session->state == AVDTP_SESSION_STATE_CONNECTING) {
-		debug("avdtp_confirm_cb: connect already in progress"
+		DBG("avdtp_confirm_cb: connect already in progress"
 						" (XCASE connect:connect)");
 		goto drop;
 	}
@@ -2609,7 +2609,7 @@ static gboolean avdtp_discover_resp(struct avdtp *session,
 		struct seid_req req;
 		int ret;
 
-		debug("seid %d type %d media %d in use %d",
+		DBG("seid %d type %d media %d in use %d",
 				resp->seps[i].seid, resp->seps[i].type,
 				resp->seps[i].media_type, resp->seps[i].inuse);
 
@@ -2665,7 +2665,7 @@ static gboolean avdtp_get_capabilities_resp(struct avdtp *session,
 
 	sep = find_remote_sep(session->seps, seid);
 
-	debug("seid %d type %d media %d", sep->seid,
+	DBG("seid %d type %d media %d", sep->seid,
 					sep->type, sep->media_type);
 
 	if (sep->caps) {
@@ -2809,12 +2809,12 @@ static gboolean avdtp_parse_resp(struct avdtp *session,
 
 	switch (signal_id) {
 	case AVDTP_DISCOVER:
-		debug("DISCOVER request succeeded");
+		DBG("DISCOVER request succeeded");
 		return avdtp_discover_resp(session, buf, size);
 	case AVDTP_GET_ALL_CAPABILITIES:
 		get_all = "ALL_";
 	case AVDTP_GET_CAPABILITIES:
-		debug("GET_%sCAPABILITIES request succeeded", get_all);
+		DBG("GET_%sCAPABILITIES request succeeded", get_all);
 		if (!avdtp_get_capabilities_resp(session, buf, size))
 			return FALSE;
 		if (!(next && (next->signal_id == AVDTP_GET_CAPABILITIES ||
@@ -2826,35 +2826,35 @@ static gboolean avdtp_parse_resp(struct avdtp *session,
 	/* The remaining commands require an existing stream so bail out
 	 * here if the stream got unexpectedly disconnected */
 	if (!stream) {
-		debug("AVDTP: stream was closed while waiting for reply");
+		DBG("AVDTP: stream was closed while waiting for reply");
 		return TRUE;
 	}
 
 	switch (signal_id) {
 	case AVDTP_SET_CONFIGURATION:
-		debug("SET_CONFIGURATION request succeeded");
+		DBG("SET_CONFIGURATION request succeeded");
 		return avdtp_set_configuration_resp(session, stream,
 								buf, size);
 	case AVDTP_RECONFIGURE:
-		debug("RECONFIGURE request succeeded");
+		DBG("RECONFIGURE request succeeded");
 		return avdtp_reconfigure_resp(session, stream, buf, size);
 	case AVDTP_OPEN:
-		debug("OPEN request succeeded");
+		DBG("OPEN request succeeded");
 		return avdtp_open_resp(session, stream, buf, size);
 	case AVDTP_SUSPEND:
-		debug("SUSPEND request succeeded");
+		DBG("SUSPEND request succeeded");
 		return avdtp_suspend_resp(session, stream, buf, size);
 	case AVDTP_START:
-		debug("START request succeeded");
+		DBG("START request succeeded");
 		return avdtp_start_resp(session, stream, buf, size);
 	case AVDTP_CLOSE:
-		debug("CLOSE request succeeded");
+		DBG("CLOSE request succeeded");
 		return avdtp_close_resp(session, stream, buf, size);
 	case AVDTP_ABORT:
-		debug("ABORT request succeeded");
+		DBG("ABORT request succeeded");
 		return avdtp_abort_resp(session, stream, buf, size);
 	case AVDTP_DELAY_REPORT:
-		debug("DELAY_REPORT request succeeded");
+		DBG("DELAY_REPORT request succeeded");
 		return avdtp_delay_report_resp(session, stream, buf, size);
 	}
 
@@ -3347,7 +3347,7 @@ int avdtp_set_configuration(struct avdtp *session,
 	if (!(lsep && rsep))
 		return -EINVAL;
 
-	debug("avdtp_set_configuration(%p): int_seid=%u, acp_seid=%u",
+	DBG("avdtp_set_configuration(%p): int_seid=%u, acp_seid=%u",
 			session, lsep->info.seid, rsep->seid);
 
 	new_stream = g_new0(struct avdtp_stream, 1);
@@ -3606,7 +3606,7 @@ struct avdtp_local_sep *avdtp_register_sep(const bdaddr_t *src, uint8_t type,
 	sep->server = server;
 	sep->delay_reporting = TRUE;
 
-	debug("SEP %p registered: type:%d codec:%d seid:%d", sep,
+	DBG("SEP %p registered: type:%d codec:%d seid:%d", sep,
 			sep->info.type, sep->codec, sep->info.seid);
 	server->seps = g_slist_append(server->seps, sep);
 
@@ -3722,7 +3722,7 @@ int avdtp_init(const bdaddr_t *src, GKeyFile *config, uint16_t *version)
 	tmp = g_key_file_get_boolean(config, "General",
 			"Master", &err);
 	if (err) {
-		debug("audio.conf: %s", err->message);
+		DBG("audio.conf: %s", err->message);
 		g_clear_error(&err);
 	} else
 		master = tmp;
diff --git a/audio/control.c b/audio/control.c
index 1b53c8f..c8aba53 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -374,17 +374,17 @@ static void handle_panel_passthrough(struct control *control,
 		if ((operands[0] & 0x7F) != key_map[i].avrcp)
 			continue;
 
-		debug("AVRCP: %s %s", key_map[i].name, status);
+		DBG("AVRCP: %s %s", key_map[i].name, status);
 
 		key_quirks = control->key_quirks[key_map[i].avrcp];
 
 		if (key_quirks & QUIRK_NO_RELEASE) {
 			if (!pressed) {
-				debug("AVRCP: Ignoring release");
+				DBG("AVRCP: Ignoring release");
 				break;
 			}
 
-			debug("AVRCP: treating key press as press + release");
+			DBG("AVRCP: treating key press as press + release");
 			send_key(control->uinput, key_map[i].uinput, 1);
 			send_key(control->uinput, key_map[i].uinput, 0);
 			break;
@@ -395,7 +395,7 @@ static void handle_panel_passthrough(struct control *control,
 	}
 
 	if (key_map[i].name == NULL)
-		debug("AVRCP: unknown button 0x%02X %s",
+		DBG("AVRCP: unknown button 0x%02X %s",
 						operands[0] & 0x7F, status);
 }
 
@@ -425,7 +425,7 @@ static void avctp_disconnected(struct audio_device *dev)
 		char address[18];
 
 		ba2str(&dev->dst, address);
-		debug("AVRCP: closing uinput for %s", address);
+		DBG("AVRCP: closing uinput for %s", address);
 
 		ioctl(control->uinput, UI_DEV_DESTROY);
 		close(control->uinput);
@@ -442,7 +442,7 @@ static void avctp_set_state(struct control *control, avctp_state_t new_state)
 
 	switch (new_state) {
 	case AVCTP_STATE_DISCONNECTED:
-		debug("AVCTP Disconnected");
+		DBG("AVCTP Disconnected");
 
 		avctp_disconnected(control->dev);
 
@@ -462,10 +462,10 @@ static void avctp_set_state(struct control *control, avctp_state_t new_state)
 
 		break;
 	case AVCTP_STATE_CONNECTING:
-		debug("AVCTP Connecting");
+		DBG("AVCTP Connecting");
 		break;
 	case AVCTP_STATE_CONNECTED:
-		debug("AVCTP Connected");
+		DBG("AVCTP Connected");
 		value = TRUE;
 		g_dbus_emit_signal(control->dev->conn, control->dev->path,
 				AUDIO_CONTROL_INTERFACE, "Connected",
@@ -505,7 +505,7 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
 	if (ret <= 0)
 		goto failed;
 
-	debug("Got %d bytes of data for AVCTP session %p", ret, control);
+	DBG("Got %d bytes of data for AVCTP session %p", ret, control);
 
 	if ((unsigned int) ret < sizeof(struct avctp_header)) {
 		error("Too small AVCTP packet");
@@ -516,7 +516,7 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
 
 	avctp = (struct avctp_header *) buf;
 
-	debug("AVCTP transaction %u, packet type %u, C/R %u, IPID %u, "
+	DBG("AVCTP transaction %u, packet type %u, C/R %u, IPID %u, "
 			"PID 0x%04X",
 			avctp->transaction, avctp->packet_type,
 			avctp->cr, avctp->ipid, ntohs(avctp->pid));
@@ -534,7 +534,7 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
 	operands = buf + sizeof(struct avctp_header) + sizeof(struct avrcp_header);
 	operand_count = ret;
 
-	debug("AVRCP %s 0x%01X, subunit_type 0x%02X, subunit_id 0x%01X, "
+	DBG("AVRCP %s 0x%01X, subunit_type 0x%02X, subunit_id 0x%01X, "
 			"opcode 0x%02X, %d operands",
 			avctp->cr ? "response" : "command",
 			avrcp->code, avrcp->subunit_type, avrcp->subunit_id,
@@ -568,7 +568,7 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
 			operands[0] = 0x07;
 		if (operand_count >= 2)
 			operands[1] = SUBUNIT_PANEL << 3;
-		debug("reply to %s", avrcp->opcode == OP_UNITINFO ?
+		DBG("reply to %s", avrcp->opcode == OP_UNITINFO ?
 				"OP_UNITINFO" : "OP_SUBUNITINFO");
 	} else {
 		avctp->cr = AVCTP_RESPONSE;
@@ -579,7 +579,7 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
 	return TRUE;
 
 failed:
-	debug("AVCTP session %p got disconnected", control);
+	DBG("AVCTP session %p got disconnected", control);
 	avctp_set_state(control, AVCTP_STATE_DISCONNECTED);
 	return FALSE;
 }
@@ -660,7 +660,7 @@ static void init_uinput(struct control *control)
 	if (control->uinput < 0)
 		error("AVRCP: failed to init uinput for %s", address);
 	else
-		debug("AVRCP: uinput initialized for %s", address);
+		DBG("AVRCP: uinput initialized for %s", address);
 }
 
 static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
@@ -687,7 +687,7 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 		return;
 	}
 
-	debug("AVCTP: connected to %s", address);
+	DBG("AVCTP: connected to %s", address);
 
 	if (!control->io)
 		control->io = g_io_channel_ref(chan);
@@ -851,7 +851,7 @@ int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 		tmp = g_key_file_get_boolean(config, "General",
 							"Master", &err);
 		if (err) {
-			debug("audio.conf: %s", err->message);
+			DBG("audio.conf: %s", err->message);
 			g_error_free(err);
 		} else
 			master = tmp;
@@ -1112,7 +1112,7 @@ static void path_unregister(void *data)
 	struct audio_device *dev = data;
 	struct control *control = dev->control;
 
-	debug("Unregistered interface %s on path %s",
+	DBG("Unregistered interface %s on path %s",
 		AUDIO_CONTROL_INTERFACE, dev->path);
 
 	if (control->state != AVCTP_STATE_DISCONNECTED)
@@ -1146,7 +1146,7 @@ struct control *control_init(struct audio_device *dev, uint16_t uuid16)
 					dev, path_unregister))
 		return NULL;
 
-	debug("Registered interface %s on path %s",
+	DBG("Registered interface %s on path %s",
 		AUDIO_CONTROL_INTERFACE, dev->path);
 
 	control = g_new0(struct control, 1);
diff --git a/audio/device.c b/audio/device.c
index 2beeb04..b59be6a 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -157,7 +157,7 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
 		priv->authorized = FALSE;
 
 	if (dev->priv->state == new_state) {
-		debug("state change attempted from %s to %s",
+		DBG("state change attempted from %s to %s",
 							state_str, state_str);
 		return;
 	}
@@ -605,7 +605,7 @@ struct audio_device *audio_device_register(DBusConnection *conn,
 		return NULL;
 	}
 
-	debug("Registered interface %s on path %s", AUDIO_INTERFACE,
+	DBG("Registered interface %s on path %s", AUDIO_INTERFACE,
 								dev->path);
 
 	if (sink_callback_id == 0)
diff --git a/audio/gateway.c b/audio/gateway.c
index 57e2977..dfe7145 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -158,7 +158,7 @@ static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
 		return FALSE;
 
 	if (cond & (G_IO_ERR | G_IO_HUP)) {
-		debug("sco connection is released");
+		DBG("sco connection is released");
 		g_io_channel_shutdown(gw->sco, TRUE, NULL);
 		g_io_channel_unref(gw->sco);
 		gw->sco = NULL;
@@ -174,7 +174,7 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	struct audio_device *dev = (struct audio_device *) user_data;
 	struct gateway *gw = dev->gateway;
 
-	debug("at the begin of sco_connect_cb() in gateway.c");
+	DBG("at the begin of sco_connect_cb() in gateway.c");
 
 	gw->sco = g_io_channel_ref(chan);
 
@@ -198,18 +198,18 @@ static void newconnection_reply(DBusPendingCall *call, void *data)
 	DBusError derr;
 
 	if (!dev->gateway->rfcomm) {
-		debug("RFCOMM disconnected from server before agent reply");
+		DBG("RFCOMM disconnected from server before agent reply");
 		goto done;
 	}
 
 	dbus_error_init(&derr);
 	if (!dbus_set_error_from_message(&derr, reply)) {
-		debug("Agent reply: file descriptor passed successfuly");
+		DBG("Agent reply: file descriptor passed successfuly");
 		change_state(dev, GATEWAY_STATE_CONNECTED);
 		goto done;
 	}
 
-	debug("Agent reply: %s", derr.message);
+	DBG("Agent reply: %s", derr.message);
 
 	dbus_error_free(&derr);
 	gateway_close(dev);
@@ -432,7 +432,7 @@ static DBusMessage *ag_disconnect(DBusConnection *conn, DBusMessage *msg,
 
 	gateway_close(device);
 	ba2str(&device->dst, gw_addr);
-	debug("Disconnected from %s, %s", gw_addr, device->path);
+	DBG("Disconnected from %s, %s", gw_addr, device->path);
 
 	return reply;
 }
@@ -442,7 +442,7 @@ static void agent_exited(DBusConnection *conn, void *data)
 	struct gateway *gateway = data;
 	struct hf_agent *agent = gateway->agent;
 
-	debug("Agent %s exited", agent->name);
+	DBG("Agent %s exited", agent->name);
 
 	agent_free(agent);
 	gateway->agent = NULL;
diff --git a/audio/headset.c b/audio/headset.c
index 9ce813b..9a5d767 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -212,7 +212,7 @@ static void print_ag_features(uint32_t features)
 	char *str;
 
 	if (features == 0) {
-		debug("HFP AG features: (none)");
+		DBG("HFP AG features: (none)");
 		return;
 	}
 
@@ -239,7 +239,7 @@ static void print_ag_features(uint32_t features)
 
 	str = g_string_free(gstr, FALSE);
 
-	debug("%s", str);
+	DBG("%s", str);
 
 	g_free(str);
 }
@@ -250,7 +250,7 @@ static void print_hf_features(uint32_t features)
 	char *str;
 
 	if (features == 0) {
-		debug("HFP HF features: (none)");
+		DBG("HFP HF features: (none)");
 		return;
 	}
 
@@ -273,7 +273,7 @@ static void print_hf_features(uint32_t features)
 
 	str = g_string_free(gstr, FALSE);
 
-	debug("%s", str);
+	DBG("%s", str);
 
 	g_free(str);
 }
@@ -591,11 +591,11 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		return;
 	}
 
-	debug("SCO socket opened for headset %s", dev->path);
+	DBG("SCO socket opened for headset %s", dev->path);
 
 	sk = g_io_channel_unix_get_fd(chan);
 
-	debug("SCO fd=%d", sk);
+	DBG("SCO fd=%d", sk);
 
 	if (p) {
 		p->io = NULL;
@@ -670,7 +670,7 @@ static void hfp_slc_complete(struct audio_device *dev)
 	struct headset *hs = dev->headset;
 	struct pending_connect *p = hs->pending;
 
-	debug("HFP Service Level Connection established");
+	DBG("HFP Service Level Connection established");
 
 	headset_set_state(dev, HEADSET_STATE_CONNECTED);
 
@@ -754,7 +754,7 @@ static int event_reporting(struct audio_device *dev, const char *buf)
 	g_strfreev(tokens);
 	tokens = NULL;
 
-	debug("Event reporting (CMER): mode=%d, ind=%d",
+	DBG("Event reporting (CMER): mode=%d, ind=%d",
 			ag.er_mode, ag.er_ind);
 
 	switch (ag.er_ind) {
@@ -938,7 +938,7 @@ static int dial_number(struct audio_device *device, const char *buf)
 	buf_len = strlen(buf);
 
 	if (buf[buf_len - 1] != ';') {
-		debug("Rejecting non-voice call dial request");
+		DBG("Rejecting non-voice call dial request");
 		return -EINVAL;
 	}
 
@@ -1054,10 +1054,10 @@ static int extended_errors(struct audio_device *device, const char *buf)
 
 	if (buf[8] == '1') {
 		slc->cme_enabled = TRUE;
-		debug("CME errors enabled for headset %p", hs);
+		DBG("CME errors enabled for headset %p", hs);
 	} else {
 		slc->cme_enabled = FALSE;
-		debug("CME errors disabled for headset %p", hs);
+		DBG("CME errors disabled for headset %p", hs);
 	}
 
 	return headset_send(hs, "\r\nOK\r\n");
@@ -1073,10 +1073,10 @@ static int call_waiting_notify(struct audio_device *device, const char *buf)
 
 	if (buf[8] == '1') {
 		slc->cwa_enabled = TRUE;
-		debug("Call waiting notification enabled for headset %p", hs);
+		DBG("Call waiting notification enabled for headset %p", hs);
 	} else {
 		slc->cwa_enabled = FALSE;
-		debug("Call waiting notification disabled for headset %p", hs);
+		DBG("Call waiting notification disabled for headset %p", hs);
 	}
 
 	return headset_send(hs, "\r\nOK\r\n");
@@ -1203,7 +1203,7 @@ static int handle_event(struct audio_device *device, const char *buf)
 {
 	struct event *ev;
 
-	debug("Received %s", buf);
+	DBG("Received %s", buf);
 
 	for (ev = event_callbacks; ev->cmd; ev++) {
 		if (!strncmp(buf, ev->cmd, strlen(ev->cmd)))
@@ -1247,7 +1247,7 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
 	slc = hs->slc;
 
 	if (cond & (G_IO_ERR | G_IO_HUP)) {
-		debug("ERR or HUP on RFCOMM socket");
+		DBG("ERR or HUP on RFCOMM socket");
 		goto failed;
 	}
 
@@ -1359,7 +1359,7 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	g_io_add_watch(chan, G_IO_IN | G_IO_ERR | G_IO_HUP| G_IO_NVAL,
 			(GIOFunc) rfcomm_io_cb, dev);
 
-	debug("%s: Connected to %s", dev->path, hs_address);
+	DBG("%s: Connected to %s", dev->path, hs_address);
 
 	hs->slc = g_new0(struct headset_slc, 1);
 	hs->slc->nrec = TRUE;
@@ -1421,10 +1421,10 @@ static int headset_set_channel(struct headset *headset,
 
 	if (svc == HANDSFREE_SVCLASS_ID) {
 		headset->hfp_handle = record->handle;
-		debug("Discovered Handsfree service on channel %d", ch);
+		DBG("Discovered Handsfree service on channel %d", ch);
 	} else {
 		headset->hsp_handle = record->handle;
-		debug("Discovered Headset service on channel %d", ch);
+		DBG("Discovered Headset service on channel %d", ch);
 	}
 
 	return 0;
@@ -1570,7 +1570,7 @@ static int rfcomm_connect(struct audio_device *dev, headset_stream_cb_t cb,
 
 	ba2str(&dev->dst, address);
 
-	debug("%s: Connecting to %s channel %d", dev->path, address,
+	DBG("%s: Connecting to %s channel %d", dev->path, address,
 		hs->rfcomm_ch);
 
 	hs->tmp_rfcomm = bt_io_connect(BT_IO_RFCOMM, headset_connect_cb, dev,
@@ -1740,7 +1740,7 @@ static DBusMessage *hs_ring(DBusConnection *conn, DBusMessage *msg,
 		return NULL;
 
 	if (ag.ring_timer) {
-		debug("IndicateCall received when already indicating");
+		DBG("IndicateCall received when already indicating");
 		goto done;
 	}
 
@@ -1780,7 +1780,7 @@ static DBusMessage *hs_cancel_call(DBusConnection *conn,
 		g_source_remove(ag.ring_timer);
 		ag.ring_timer = 0;
 	} else
-		debug("Got CancelCall method call but no call is active");
+		DBG("Got CancelCall method call but no call is active");
 
 	return reply;
 }
@@ -2133,7 +2133,7 @@ void headset_update(struct audio_device *dev, uint16_t svc,
 		break;
 
 	default:
-		debug("Invalid record passed to headset_update");
+		DBG("Invalid record passed to headset_update");
 		return;
 	}
 }
@@ -2182,11 +2182,11 @@ static void path_unregister(void *data)
 	struct headset *hs = dev->headset;
 
 	if (hs->state > HEADSET_STATE_DISCONNECTED) {
-		debug("Headset unregistered while device was connected!");
+		DBG("Headset unregistered while device was connected!");
 		headset_shutdown(dev);
 	}
 
-	debug("Unregistered interface %s on path %s",
+	DBG("Unregistered interface %s on path %s",
 		AUDIO_HEADSET_INTERFACE, dev->path);
 
 	headset_free(dev);
@@ -2222,7 +2222,7 @@ struct headset *headset_init(struct audio_device *dev, uint16_t svc,
 		break;
 
 	default:
-		debug("Invalid record passed to headset_init");
+		DBG("Invalid record passed to headset_init");
 		g_free(hs);
 		return NULL;
 	}
@@ -2236,7 +2236,7 @@ register_iface:
 		return NULL;
 	}
 
-	debug("Registered interface %s on path %s",
+	DBG("Registered interface %s on path %s",
 		AUDIO_HEADSET_INTERFACE, dev->path);
 
 	return hs;
@@ -2254,7 +2254,7 @@ uint32_t headset_config_init(GKeyFile *config)
 	str = g_key_file_get_string(config, "General", "SCORouting",
 					&err);
 	if (err) {
-		debug("audio.conf: %s", err->message);
+		DBG("audio.conf: %s", err->message);
 		g_clear_error(&err);
 	} else {
 		if (strcmp(str, "PCM") == 0)
@@ -2582,7 +2582,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 
 	hs->state = state;
 
-	debug("State changed %s: %s -> %s", dev->path, str_state[old_state],
+	DBG("State changed %s: %s -> %s", dev->path, str_state[old_state],
 		str_state[state]);
 
 	for (l = headset_callbacks; l != NULL; l = l->next) {
@@ -2713,7 +2713,7 @@ int telephony_event_ind(int index)
 		return -ENODEV;
 
 	if (!ag.er_ind) {
-		debug("telephony_report_event called but events are disabled");
+		DBG("telephony_report_event called but events are disabled");
 		return -EINVAL;
 	}
 
@@ -2756,7 +2756,7 @@ int telephony_incoming_call_ind(const char *number, int type)
 	slc = hs->slc;
 
 	if (ag.ring_timer) {
-		debug("telephony_incoming_call_ind: already calling");
+		DBG("telephony_incoming_call_ind: already calling");
 		return -EBUSY;
 	}
 
@@ -2815,7 +2815,7 @@ int telephony_ready_ind(uint32_t features,
 	ag.rh = rh;
 	ag.chld = g_strdup(chld);
 
-	debug("Telephony plugin initialized");
+	DBG("Telephony plugin initialized");
 
 	print_ag_features(ag.features);
 
diff --git a/audio/main.c b/audio/main.c
index 60b1f15..9d316ec 100644
--- a/audio/main.c
+++ b/audio/main.c
@@ -102,7 +102,7 @@ static void sco_server_cb(GIOChannel *chan, GError *err, gpointer data)
 
 	if (device->headset) {
 		if (headset_get_state(device) < HEADSET_STATE_CONNECTED) {
-			debug("Refusing SCO from non-connected headset");
+			DBG("Refusing SCO from non-connected headset");
 			goto drop;
 		}
 
@@ -118,7 +118,7 @@ static void sco_server_cb(GIOChannel *chan, GError *err, gpointer data)
 		headset_set_state(device, HEADSET_STATE_PLAYING);
 	} else if (device->gateway) {
 		if (!gateway_is_connected(device)) {
-			debug("Refusing SCO from non-connected AG");
+			DBG("Refusing SCO from non-connected AG");
 			goto drop;
 		}
 
@@ -130,7 +130,7 @@ static void sco_server_cb(GIOChannel *chan, GError *err, gpointer data)
 	sk = g_io_channel_unix_get_fd(chan);
 	fcntl(sk, F_SETFL, 0);
 
-	debug("Accepted SCO connection from %s", addr);
+	DBG("Accepted SCO connection from %s", addr);
 
 	return;
 
diff --git a/audio/manager.c b/audio/manager.c
index a4b873c..32b7d03 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -171,14 +171,14 @@ static void handle_uuid(const char *uuidstr, struct audio_device *device)
 	uuid16 = uuid.value.uuid16;
 
 	if (!server_is_enabled(&device->src, uuid16)) {
-		debug("audio handle_uuid: server not enabled for %s (0x%04x)",
+		DBG("audio handle_uuid: server not enabled for %s (0x%04x)",
 				uuidstr, uuid16);
 		return;
 	}
 
 	switch (uuid16) {
 	case HEADSET_SVCLASS_ID:
-		debug("Found Headset record");
+		DBG("Found Headset record");
 		if (device->headset)
 			headset_update(device, uuid16, uuidstr);
 		else
@@ -186,10 +186,10 @@ static void handle_uuid(const char *uuidstr, struct audio_device *device)
 							uuidstr);
 		break;
 	case HEADSET_AGW_SVCLASS_ID:
-		debug("Found Headset AG record");
+		DBG("Found Headset AG record");
 		break;
 	case HANDSFREE_SVCLASS_ID:
-		debug("Found Handsfree record");
+		DBG("Found Handsfree record");
 		if (device->headset)
 			headset_update(device, uuid16, uuidstr);
 		else
@@ -197,23 +197,23 @@ static void handle_uuid(const char *uuidstr, struct audio_device *device)
 							uuidstr);
 		break;
 	case HANDSFREE_AGW_SVCLASS_ID:
-		debug("Found Handsfree AG record");
+		DBG("Found Handsfree AG record");
 		if (enabled.gateway && (device->gateway == NULL))
 			device->gateway = gateway_init(device);
 		break;
 	case AUDIO_SINK_SVCLASS_ID:
-		debug("Found Audio Sink");
+		DBG("Found Audio Sink");
 		if (device->sink == NULL)
 			device->sink = sink_init(device);
 		break;
 	case AUDIO_SOURCE_SVCLASS_ID:
-		debug("Found Audio Source");
+		DBG("Found Audio Source");
 		if (device->source == NULL)
 			device->source = source_init(device);
 		break;
 	case AV_REMOTE_SVCLASS_ID:
 	case AV_REMOTE_TARGET_SVCLASS_ID:
-		debug("Found AV %s", uuid16 == AV_REMOTE_SVCLASS_ID ?
+		DBG("Found AV %s", uuid16 == AV_REMOTE_SVCLASS_ID ?
 							"Remote" : "Target");
 		if (device->control)
 			control_update(device, uuid16);
@@ -223,7 +223,7 @@ static void handle_uuid(const char *uuidstr, struct audio_device *device)
 			avrcp_connect(device);
 		break;
 	default:
-		debug("Unrecognized UUID: 0x%04X", uuid16);
+		DBG("Unrecognized UUID: 0x%04X", uuid16);
 		break;
 	}
 }
@@ -437,7 +437,7 @@ static gboolean hs_preauth_cb(GIOChannel *chan, GIOCondition cond,
 {
 	struct audio_device *device = user_data;
 
-	debug("Headset disconnected during authorization");
+	DBG("Headset disconnected during authorization");
 
 	audio_device_cancel_authorization(device, headset_auth_cb, device);
 
@@ -484,7 +484,7 @@ static void ag_confirm(GIOChannel *chan, gpointer data)
 		goto drop;
 
 	if (!manager_allow_headset_connection(device)) {
-		debug("Refusing headset: too many existing connections");
+		DBG("Refusing headset: too many existing connections");
 		goto drop;
 	}
 
@@ -495,7 +495,7 @@ static void ag_confirm(GIOChannel *chan, gpointer data)
 	}
 
 	if (headset_get_state(device) > HEADSET_STATE_DISCONNECTED) {
-		debug("Refusing new connection since one already exists");
+		DBG("Refusing new connection since one already exists");
 		goto drop;
 	}
 
@@ -511,7 +511,7 @@ static void ag_confirm(GIOChannel *chan, gpointer data)
 	perr = audio_device_request_authorization(device, server_uuid,
 						headset_auth_cb, device);
 	if (perr < 0) {
-		debug("Authorization denied: %s", strerror(-perr));
+		DBG("Authorization denied: %s", strerror(-perr));
 		headset_set_state(device, HEADSET_STATE_DISCONNECTED);
 		return;
 	}
@@ -538,7 +538,7 @@ static void gateway_auth_cb(DBusError *derr, void *user_data)
 		char ag_address[18];
 
 		ba2str(&device->dst, ag_address);
-		debug("Accepted AG connection from %s for %s",
+		DBG("Accepted AG connection from %s for %s",
 			ag_address, device->path);
 
 		gateway_start_service(device);
@@ -582,7 +582,7 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 	}
 
 	if (gateway_is_connected(device)) {
-		debug("Refusing new connection since one already exists");
+		DBG("Refusing new connection since one already exists");
 		goto drop;
 	}
 
@@ -594,7 +594,7 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 	perr = audio_device_request_authorization(device, server_uuid,
 						gateway_auth_cb, device);
 	if (perr < 0) {
-		debug("Authorization denied!");
+		DBG("Authorization denied!");
 		goto drop;
 	}
 
@@ -622,7 +622,7 @@ static int headset_server_init(struct audio_adapter *adapter)
 		tmp = g_key_file_get_boolean(config, "General", "Master",
 						&err);
 		if (err) {
-			debug("audio.conf: %s", err->message);
+			DBG("audio.conf: %s", err->message);
 			g_clear_error(&err);
 		} else
 			master = tmp;
@@ -720,7 +720,7 @@ static int gateway_server_init(struct audio_adapter *adapter)
 		tmp = g_key_file_get_boolean(config, "General", "Master",
 						&err);
 		if (err) {
-			debug("audio.conf: %s", err->message);
+			DBG("audio.conf: %s", err->message);
 			g_clear_error(&err);
 		} else
 			master = tmp;
@@ -771,7 +771,7 @@ static int audio_probe(struct btd_device *device, GSList *uuids)
 
 	audio_dev = manager_get_device(&src, &dst, TRUE);
 	if (!audio_dev) {
-		debug("audio_probe: unable to get a device object");
+		DBG("audio_probe: unable to get a device object");
 		return -1;
 	}
 
@@ -801,7 +801,7 @@ static struct audio_adapter *audio_adapter_ref(struct audio_adapter *adp)
 {
 	adp->ref++;
 
-	debug("audio_adapter_ref(%p): ref=%d", adp, adp->ref);
+	DBG("audio_adapter_ref(%p): ref=%d", adp, adp->ref);
 
 	return adp;
 }
@@ -810,7 +810,7 @@ static void audio_adapter_unref(struct audio_adapter *adp)
 {
 	adp->ref--;
 
-	debug("audio_adapter_unref(%p): ref=%d", adp, adp->ref);
+	DBG("audio_adapter_unref(%p): ref=%d", adp, adp->ref);
 
 	if (adp->ref > 0)
 		return;
@@ -1095,7 +1095,7 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 
 	b = g_key_file_get_boolean(config, "General", "AutoConnect", &err);
 	if (err) {
-		debug("audio.conf: %s", err->message);
+		DBG("audio.conf: %s", err->message);
 		g_clear_error(&err);
 	} else
 		auto_connect = b;
@@ -1111,7 +1111,7 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 	i = g_key_file_get_integer(config, "Headset", "MaxConnected",
 					&err);
 	if (err) {
-		debug("audio.conf: %s", err->message);
+		DBG("audio.conf: %s", err->message);
 		g_clear_error(&err);
 	} else
 		max_connected_headsets = i;
diff --git a/audio/sink.c b/audio/sink.c
index e589b14..f4dce28 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -176,7 +176,7 @@ static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
 	struct audio_device *device = user_data;
 	struct sink *sink = device->sink;
 
-	debug("Sink: disconnect %s", device->path);
+	DBG("Sink: disconnect %s", device->path);
 
 	avdtp_close(sink->session, sink->stream, TRUE);
 }
@@ -282,14 +282,14 @@ static gboolean stream_setup_retry(gpointer user_data)
 	sink->retry_id = 0;
 
 	if (sink->stream_state >= AVDTP_STATE_OPEN) {
-		debug("Stream successfully created, after XCASE connect:connect");
+		DBG("Stream successfully created, after XCASE connect:connect");
 		if (pending->msg) {
 			DBusMessage *reply;
 			reply = dbus_message_new_method_return(pending->msg);
 			g_dbus_send_message(pending->conn, reply);
 		}
 	} else {
-		debug("Stream setup failed, after XCASE connect:connect");
+		DBG("Stream setup failed, after XCASE connect:connect");
 		if (pending->msg)
 			error_failed(pending->conn, pending->msg, "Stream setup failed");
 	}
@@ -312,7 +312,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 	pending->id = 0;
 
 	if (stream) {
-		debug("Stream successfully created");
+		DBG("Stream successfully created");
 
 		if (pending->msg) {
 			DBusMessage *reply;
@@ -330,7 +330,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 	sink->session = NULL;
 	if (avdtp_error_type(err) == AVDTP_ERROR_ERRNO
 			&& avdtp_error_posix_errno(err) != EHOSTDOWN) {
-		debug("connect:connect XCASE detected");
+		DBG("connect:connect XCASE detected");
 		sink->retry_id = g_timeout_add_seconds(STREAM_SETUP_RETRY_TIMER,
 							stream_setup_retry,
 							sink);
@@ -339,7 +339,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 			error_failed(pending->conn, pending->msg, "Stream setup failed");
 		sink->connect = NULL;
 		pending_request_free(sink->dev, pending);
-		debug("Stream setup failed : %s", avdtp_strerror(err));
+		DBG("Stream setup failed : %s", avdtp_strerror(err));
 	}
 }
 
@@ -503,7 +503,7 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 		sink->session = NULL;
 		if (avdtp_error_type(err) == AVDTP_ERROR_ERRNO
 				&& avdtp_error_posix_errno(err) != EHOSTDOWN) {
-			debug("connect:connect XCASE detected");
+			DBG("connect:connect XCASE detected");
 			sink->retry_id =
 				g_timeout_add_seconds(STREAM_SETUP_RETRY_TIMER,
 							stream_setup_retry,
@@ -513,7 +513,7 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 		return;
 	}
 
-	debug("Discovery complete");
+	DBG("Discovery complete");
 
 	if (avdtp_get_seps(session, AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
 				A2DP_CODEC_SBC, &lsep, &rsep) < 0) {
@@ -603,7 +603,7 @@ static DBusMessage *sink_connect(DBusConnection *conn,
 	pending->conn = dbus_connection_ref(conn);
 	pending->msg = dbus_message_ref(msg);
 
-	debug("stream creation in progress");
+	DBG("stream creation in progress");
 
 	return NULL;
 }
@@ -759,7 +759,7 @@ static void path_unregister(void *data)
 {
 	struct audio_device *dev = data;
 
-	debug("Unregistered interface %s on path %s",
+	DBG("Unregistered interface %s on path %s",
 		AUDIO_SINK_INTERFACE, dev->path);
 
 	sink_free(dev);
@@ -781,7 +781,7 @@ struct sink *sink_init(struct audio_device *dev)
 					dev, path_unregister))
 		return NULL;
 
-	debug("Registered interface %s on path %s",
+	DBG("Registered interface %s on path %s",
 		AUDIO_SINK_INTERFACE, dev->path);
 
 	if (avdtp_callback_id == 0)
diff --git a/audio/source.c b/audio/source.c
index 633ed54..35d8136 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -169,7 +169,7 @@ static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
 	struct audio_device *device = user_data;
 	struct source *source = device->source;
 
-	debug("Source: disconnect %s", device->path);
+	DBG("Source: disconnect %s", device->path);
 
 	avdtp_close(source->session, source->stream, TRUE);
 }
@@ -249,14 +249,14 @@ static gboolean stream_setup_retry(gpointer user_data)
 	source->retry_id = 0;
 
 	if (source->stream_state >= AVDTP_STATE_OPEN) {
-		debug("Stream successfully created, after XCASE connect:connect");
+		DBG("Stream successfully created, after XCASE connect:connect");
 		if (pending->msg) {
 			DBusMessage *reply;
 			reply = dbus_message_new_method_return(pending->msg);
 			g_dbus_send_message(pending->conn, reply);
 		}
 	} else {
-		debug("Stream setup failed, after XCASE connect:connect");
+		DBG("Stream setup failed, after XCASE connect:connect");
 		if (pending->msg)
 			error_failed(pending->conn, pending->msg, "Stream setup failed");
 	}
@@ -279,7 +279,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 	pending->id = 0;
 
 	if (stream) {
-		debug("Stream successfully created");
+		DBG("Stream successfully created");
 
 		if (pending->msg) {
 			DBusMessage *reply;
@@ -297,7 +297,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 	source->session = NULL;
 	if (avdtp_error_type(err) == AVDTP_ERROR_ERRNO
 			&& avdtp_error_posix_errno(err) != EHOSTDOWN) {
-		debug("connect:connect XCASE detected");
+		DBG("connect:connect XCASE detected");
 		source->retry_id = g_timeout_add_seconds(STREAM_SETUP_RETRY_TIMER,
 							stream_setup_retry,
 							source);
@@ -306,7 +306,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 			error_failed(pending->conn, pending->msg, "Stream setup failed");
 		source->connect = NULL;
 		pending_request_free(source->dev, pending);
-		debug("Stream setup failed : %s", avdtp_strerror(err));
+		DBG("Stream setup failed : %s", avdtp_strerror(err));
 	}
 }
 
@@ -464,7 +464,7 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 		source->session = NULL;
 		if (avdtp_error_type(err) == AVDTP_ERROR_ERRNO
 				&& avdtp_error_posix_errno(err) != EHOSTDOWN) {
-			debug("connect:connect XCASE detected");
+			DBG("connect:connect XCASE detected");
 			source->retry_id =
 				g_timeout_add_seconds(STREAM_SETUP_RETRY_TIMER,
 							stream_setup_retry,
@@ -474,7 +474,7 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 		return;
 	}
 
-	debug("Discovery complete");
+	DBG("Discovery complete");
 
 	if (avdtp_get_seps(session, AVDTP_SEP_TYPE_SOURCE, AVDTP_MEDIA_TYPE_AUDIO,
 				A2DP_CODEC_SBC, &lsep, &rsep) < 0) {
@@ -565,7 +565,7 @@ static DBusMessage *source_connect(DBusConnection *conn,
 	pending->conn = dbus_connection_ref(conn);
 	pending->msg = dbus_message_ref(msg);
 
-	debug("stream creation in progress");
+	DBG("stream creation in progress");
 
 	return NULL;
 }
@@ -685,7 +685,7 @@ static void path_unregister(void *data)
 {
 	struct audio_device *dev = data;
 
-	debug("Unregistered interface %s on path %s",
+	DBG("Unregistered interface %s on path %s",
 		AUDIO_SOURCE_INTERFACE, dev->path);
 
 	source_free(dev);
@@ -707,7 +707,7 @@ struct source *source_init(struct audio_device *dev)
 					dev, path_unregister))
 		return NULL;
 
-	debug("Registered interface %s on path %s",
+	DBG("Registered interface %s on path %s",
 		AUDIO_SOURCE_INTERFACE, dev->path);
 
 	if (avdtp_callback_id == 0)
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index 85a6ef3..06cb798 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -77,12 +77,12 @@ static inline DBusMessage *invalid_args(DBusMessage *msg)
 
 void telephony_device_connected(void *telephony_device)
 {
-	debug("telephony-dummy: device %p connected", telephony_device);
+	DBG("telephony-dummy: device %p connected", telephony_device);
 }
 
 void telephony_device_disconnected(void *telephony_device)
 {
-	debug("telephony-dummy: device %p disconnected", telephony_device);
+	DBG("telephony-dummy: device %p disconnected", telephony_device);
 	events_enabled = FALSE;
 }
 
@@ -147,7 +147,7 @@ void telephony_dial_number_req(void *telephony_device, const char *number)
 	g_free(active_call_number);
 	active_call_number = g_strdup(number);
 
-	debug("telephony-dummy: dial request to %s", active_call_number);
+	DBG("telephony-dummy: dial request to %s", active_call_number);
 
 	telephony_dial_number_rsp(telephony_device, CME_ERROR_NONE);
 
@@ -163,13 +163,13 @@ void telephony_dial_number_req(void *telephony_device, const char *number)
 
 void telephony_transmit_dtmf_req(void *telephony_device, char tone)
 {
-	debug("telephony-dummy: transmit dtmf: %c", tone);
+	DBG("telephony-dummy: transmit dtmf: %c", tone);
 	telephony_transmit_dtmf_rsp(telephony_device, CME_ERROR_NONE);
 }
 
 void telephony_subscriber_number_req(void *telephony_device)
 {
-	debug("telephony-dummy: subscriber number request");
+	DBG("telephony-dummy: subscriber number request");
 	if (subscriber_number)
 		telephony_subscriber_number_ind(subscriber_number,
 						NUMBER_TYPE_TELEPHONY,
@@ -179,7 +179,7 @@ void telephony_subscriber_number_req(void *telephony_device)
 
 void telephony_list_current_calls_req(void *telephony_device)
 {
-	debug("telephony-dummy: list current calls request");
+	DBG("telephony-dummy: list current calls request");
 	if (active_call_number)
 		telephony_list_current_call_ind(1, active_call_dir,
 						active_call_status,
@@ -198,13 +198,13 @@ void telephony_operator_selection_req(void *telephony_device)
 
 void telephony_call_hold_req(void *telephony_device, const char *cmd)
 {
-	debug("telephony-dymmy: got call hold request %s", cmd);
+	DBG("telephony-dymmy: got call hold request %s", cmd);
 	telephony_call_hold_rsp(telephony_device, CME_ERROR_NONE);
 }
 
 void telephony_nr_and_ec_req(void *telephony_device, gboolean enable)
 {
-	debug("telephony-dummy: got %s NR and EC request",
+	DBG("telephony-dummy: got %s NR and EC request",
 			enable ? "enable" : "disable");
 
 	telephony_nr_and_ec_rsp(telephony_device, CME_ERROR_NONE);
@@ -212,7 +212,7 @@ void telephony_nr_and_ec_req(void *telephony_device, gboolean enable)
 
 void telephony_voice_dial_req(void *telephony_device, gboolean enable)
 {
-	debug("telephony-dummy: got %s voice dial request",
+	DBG("telephony-dummy: got %s voice dial request",
 			enable ? "enable" : "disable");
 
 	g_dbus_emit_signal(connection, TELEPHONY_DUMMY_PATH,
@@ -224,7 +224,7 @@ void telephony_voice_dial_req(void *telephony_device, gboolean enable)
 
 void telephony_key_press_req(void *telephony_device, const char *keys)
 {
-	debug("telephony-dummy: got key press request for %s", keys);
+	DBG("telephony-dummy: got key press request for %s", keys);
 	telephony_key_press_rsp(telephony_device, CME_ERROR_NONE);
 }
 
@@ -238,7 +238,7 @@ static DBusMessage *outgoing_call(DBusConnection *conn, DBusMessage *msg,
 						DBUS_TYPE_INVALID))
 		return invalid_args(msg);
 
-	debug("telephony-dummy: outgoing call to %s", number);
+	DBG("telephony-dummy: outgoing call to %s", number);
 
 	g_free(active_call_number);
 	active_call_number = g_strdup(number);
@@ -263,7 +263,7 @@ static DBusMessage *incoming_call(DBusConnection *conn, DBusMessage *msg,
 						DBUS_TYPE_INVALID))
 		return invalid_args(msg);
 
-	debug("telephony-dummy: incoming call to %s", number);
+	DBG("telephony-dummy: incoming call to %s", number);
 
 	g_free(active_call_number);
 	active_call_number = g_strdup(number);
@@ -282,7 +282,7 @@ static DBusMessage *incoming_call(DBusConnection *conn, DBusMessage *msg,
 static DBusMessage *cancel_call(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
-	debug("telephony-dummy: cancel call");
+	DBG("telephony-dummy: cancel call");
 
 	g_free(active_call_number);
 	active_call_number = NULL;
@@ -314,7 +314,7 @@ static DBusMessage *signal_strength(DBusConnection *conn, DBusMessage *msg,
 
 	telephony_update_indicator(dummy_indicators, "signal", strength);
 
-	debug("telephony-dummy: signal strength set to %u", strength);
+	DBG("telephony-dummy: signal strength set to %u", strength);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -333,7 +333,7 @@ static DBusMessage *battery_level(DBusConnection *conn, DBusMessage *msg,
 
 	telephony_update_indicator(dummy_indicators, "battchg", level);
 
-	debug("telephony-dummy: battery level set to %u", level);
+	DBG("telephony-dummy: battery level set to %u", level);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -352,7 +352,7 @@ static DBusMessage *roaming_status(DBusConnection *conn, DBusMessage *msg,
 
 	telephony_update_indicator(dummy_indicators, "roam", val);
 
-	debug("telephony-dummy: roaming status set to %d", val);
+	DBG("telephony-dummy: roaming status set to %d", val);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -371,7 +371,7 @@ static DBusMessage *registration_status(DBusConnection *conn, DBusMessage *msg,
 
 	telephony_update_indicator(dummy_indicators, "service", val);
 
-	debug("telephony-dummy: registration status set to %d", val);
+	DBG("telephony-dummy: registration status set to %d", val);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -389,7 +389,7 @@ static DBusMessage *set_subscriber_number(DBusConnection *conn,
 	g_free(subscriber_number);
 	subscriber_number = g_strdup(number);
 
-	debug("telephony-dummy: subscriber number set to %s", number);
+	DBG("telephony-dummy: subscriber number set to %s", number);
 
 	return dbus_message_new_method_return(msg);
 }
diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index e6aa0e4..4d0134c 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -318,7 +318,7 @@ static int release_conference(void)
 {
 	DBusMessage *msg;
 
-	debug("telephony-maemo: releasing conference call");
+	DBG("telephony-maemo: releasing conference call");
 
 	msg = dbus_message_new_method_call(CSD_CALL_BUS_NAME,
 						CSD_CALL_CONFERENCE_PATH,
@@ -488,7 +488,7 @@ void telephony_device_connected(void *telephony_device)
 {
 	struct csd_call *coming;
 
-	debug("telephony-maemo: device %p connected", telephony_device);
+	DBG("telephony-maemo: device %p connected", telephony_device);
 
 	coming = find_call_with_status(CSD_CALL_STATUS_MT_ALERTING);
 	if (coming) {
@@ -503,7 +503,7 @@ void telephony_device_connected(void *telephony_device)
 
 void telephony_device_disconnected(void *telephony_device)
 {
-	debug("telephony-maemo: device %p disconnected", telephony_device);
+	DBG("telephony-maemo: device %p disconnected", telephony_device);
 	events_enabled = FALSE;
 }
 
@@ -525,7 +525,7 @@ void telephony_response_and_hold_req(void *telephony_device, int rh)
 
 void telephony_last_dialed_number_req(void *telephony_device)
 {
-	debug("telephony-maemo: last dialed number request");
+	DBG("telephony-maemo: last dialed number request");
 
 	if (last_dialed_number)
 		telephony_dial_number_req(telephony_device,
@@ -646,7 +646,7 @@ void telephony_dial_number_req(void *telephony_device, const char *number)
 	uint32_t flags = callerid;
 	int ret;
 
-	debug("telephony-maemo: dial request to %s", number);
+	DBG("telephony-maemo: dial request to %s", number);
 
 	if (strncmp(number, "*31#", 4) == 0) {
 		number += 4;
@@ -686,7 +686,7 @@ void telephony_transmit_dtmf_req(void *telephony_device, char tone)
 	int ret;
 	char buf[2] = { tone, '\0' }, *buf_ptr = buf;
 
-	debug("telephony-maemo: transmit dtmf: %s", buf);
+	DBG("telephony-maemo: transmit dtmf: %s", buf);
 
 	ret = send_method_call(CSD_CALL_BUS_NAME, CSD_CALL_PATH,
 				CSD_CALL_INTERFACE, "SendDTMF",
@@ -704,7 +704,7 @@ void telephony_transmit_dtmf_req(void *telephony_device, char tone)
 
 void telephony_subscriber_number_req(void *telephony_device)
 {
-	debug("telephony-maemo: subscriber number request");
+	DBG("telephony-maemo: subscriber number request");
 	if (msisdn)
 		telephony_subscriber_number_ind(msisdn,
 						number_type(msisdn),
@@ -755,7 +755,7 @@ void telephony_list_current_calls_req(void *telephony_device)
 	GSList *l;
 	int i;
 
-	debug("telephony-maemo: list current calls request");
+	DBG("telephony-maemo: list current calls request");
 
 	for (l = calls, i = 1; l != NULL; l = l->next, i++) {
 		struct csd_call *call = l->data;
@@ -806,7 +806,7 @@ void telephony_call_hold_req(void *telephony_device, const char *cmd)
 	struct csd_call *call;
 	int err = 0;
 
-	debug("telephony-maemo: got call hold request %s", cmd);
+	DBG("telephony-maemo: got call hold request %s", cmd);
 
 	if (strlen(cmd) > 1)
 		idx = &cmd[1];
@@ -867,7 +867,7 @@ void telephony_call_hold_req(void *telephony_device, const char *cmd)
 		err = call_transfer();
 		break;
 	default:
-		debug("Unknown call hold request");
+		DBG("Unknown call hold request");
 		break;
 	}
 
@@ -880,7 +880,7 @@ void telephony_call_hold_req(void *telephony_device, const char *cmd)
 
 void telephony_nr_and_ec_req(void *telephony_device, gboolean enable)
 {
-	debug("telephony-maemo: got %s NR and EC request",
+	DBG("telephony-maemo: got %s NR and EC request",
 			enable ? "enable" : "disable");
 	telephony_nr_and_ec_rsp(telephony_device, CME_ERROR_NONE);
 }
@@ -890,7 +890,7 @@ void telephony_key_press_req(void *telephony_device, const char *keys)
 	struct csd_call *active, *waiting;
 	int err;
 
-	debug("telephony-maemo: got key press request for %s", keys);
+	DBG("telephony-maemo: got key press request for %s", keys);
 
 	waiting = find_call_with_status(CSD_CALL_STATUS_COMING);
 	if (!waiting)
@@ -916,7 +916,7 @@ void telephony_key_press_req(void *telephony_device, const char *keys)
 
 void telephony_voice_dial_req(void *telephony_device, gboolean enable)
 {
-	debug("telephony-maemo: got %s voice dial request",
+	DBG("telephony-maemo: got %s voice dial request",
 			enable ? "enable" : "disable");
 
 	telephony_voice_dial_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
@@ -942,7 +942,7 @@ static void handle_incoming_call(DBusMessage *msg)
 		return;
 	}
 
-	debug("Incoming call to %s from number %s", call_path, number);
+	DBG("Incoming call to %s from number %s", call_path, number);
 
 	g_free(call->number);
 	call->number = g_strdup(number);
@@ -978,7 +978,7 @@ static void handle_outgoing_call(DBusMessage *msg)
 		return;
 	}
 
-	debug("Outgoing call from %s to number %s", call_path, number);
+	DBG("Outgoing call from %s to number %s", call_path, number);
 
 	g_free(call->number);
 	call->number = g_strdup(number);
@@ -1002,7 +1002,7 @@ static gboolean create_timeout(gpointer user_data)
 
 static void handle_create_requested(DBusMessage *msg)
 {
-	debug("Call.CreateRequested()");
+	DBG("Call.CreateRequested()");
 
 	if (create_request_timer)
 		g_source_remove(create_request_timer);
@@ -1040,11 +1040,11 @@ static void handle_call_status(DBusMessage *msg, const char *call_path)
 		return;
 	}
 
-	debug("Call %s changed from %s to %s", call_path,
+	DBG("Call %s changed from %s to %s", call_path,
 		call_status_str[call->status], call_status_str[status]);
 
 	if (call->status == (int) status) {
-		debug("Ignoring CSD Call state change to existing state");
+		DBG("Ignoring CSD Call state change to existing state");
 		return;
 	}
 
@@ -1182,7 +1182,7 @@ static void handle_conference(DBusMessage *msg, gboolean joined)
 		return;
 	}
 
-	debug("Call %s %s the conference", path, joined ? "joined" : "left");
+	DBG("Call %s %s the conference", path, joined ? "joined" : "left");
 
 	call->conference = joined;
 }
@@ -1227,7 +1227,7 @@ static void get_operator_name_reply(DBusPendingCall *pending_call,
 	g_free(net.operator_name);
 	net.operator_name = g_strdup(name);
 
-	debug("telephony-maemo: operator name updated: %s", name);
+	DBG("telephony-maemo: operator name updated: %s", name);
 
 done:
 	dbus_message_unref(reply);
@@ -1335,7 +1335,7 @@ static void update_signal_strength(uint8_t signals_bar)
 	int signal;
 
 	if (signals_bar > 100) {
-		debug("signals_bar greater than expected: %u", signals_bar);
+		DBG("signals_bar greater than expected: %u", signals_bar);
 		signals_bar = 100;
 	}
 
@@ -1349,7 +1349,7 @@ static void update_signal_strength(uint8_t signals_bar)
 
 	net.signals_bar = signals_bar;
 
-	debug("Signal strength updated: %u/100, %d/5", signals_bar, signal);
+	DBG("Signal strength updated: %u/100, %d/5", signals_bar, signal);
 }
 
 static void handle_signal_strength_change(DBusMessage *msg)
@@ -1425,13 +1425,13 @@ static void hal_battery_level_reply(DBusPendingCall *call, void *user_data)
 	*value = (int) level;
 
 	if (value == &battchg_last)
-		debug("telephony-maemo: battery.charge_level.last_full is %d",
+		DBG("telephony-maemo: battery.charge_level.last_full is %d",
 				*value);
 	else if (value == &battchg_design)
-		debug("telephony-maemo: battery.charge_level.design is %d",
+		DBG("telephony-maemo: battery.charge_level.design is %d",
 				*value);
 	else
-		debug("telephony-maemo: battery.charge_level.current is %d",
+		DBG("telephony-maemo: battery.charge_level.current is %d",
 				*value);
 
 	if ((battchg_design > 0 || battchg_last > 0) && battchg_cur >= 0) {
@@ -1559,7 +1559,7 @@ static void parse_call_list(DBusMessageIter *iter)
 			call->object_path = g_strdup(object_path);
 			call->status = (int) status;
 			calls = g_slist_append(calls, call);
-			debug("telephony-maemo: new csd call instance at %s",
+			DBG("telephony-maemo: new csd call instance at %s",
 								object_path);
 		}
 
@@ -1762,7 +1762,7 @@ static void hal_find_device_reply(DBusPendingCall *call, void *user_data)
 
 	dbus_message_iter_get_basic(&sub, &path);
 
-	debug("telephony-maemo: found battery device at %s", path);
+	DBG("telephony-maemo: found battery device at %s", path);
 
 	snprintf(match_string, sizeof(match_string),
 			"type='signal',"
@@ -1820,11 +1820,11 @@ static void phonebook_read_reply(DBusPendingCall *call, void *user_data)
 	if (number_type == &msisdn) {
 		g_free(msisdn);
 		msisdn = g_strdup(number);
-		debug("Got MSISDN %s (%s)", number, name);
+		DBG("Got MSISDN %s (%s)", number, name);
 	} else {
 		g_free(vmbx);
 		vmbx = g_strdup(number);
-		debug("Got voice mailbox number %s (%s)", number, name);
+		DBG("Got voice mailbox number %s (%s)", number, name);
 	}
 
 done:
@@ -1957,7 +1957,7 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
 			g_str_equal(callerid_setting, "none")) {
 		save_callerid_to_file(callerid_setting);
 		callerid = get_callflag(callerid_setting);
-		debug("telephony-maemo setting callerid flag: %s",
+		DBG("telephony-maemo setting callerid flag: %s",
 							callerid_setting);
 		return dbus_message_new_method_return(msg);
 	}
@@ -1983,7 +1983,7 @@ static void handle_modem_state(DBusMessage *msg)
 		return;
 	}
 
-	debug("SSC modem state: %s", state);
+	DBG("SSC modem state: %s", state);
 
 	if (calls != NULL || get_calls_active)
 		return;
@@ -2088,7 +2088,7 @@ int telephony_init(void)
 			TELEPHONY_MAEMO_INTERFACE, TELEPHONY_MAEMO_PATH);
 	}
 
-	debug("telephony-maemo registering %s interface on path %s",
+	DBG("telephony-maemo registering %s interface on path %s",
 			TELEPHONY_MAEMO_INTERFACE, TELEPHONY_MAEMO_PATH);
 
 	telephony_ready_ind(features, maemo_indicators, response_and_hold,
diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 3fc2015..41950be 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -274,7 +274,7 @@ static int release_conference(void)
 {
 	DBusMessage *msg;
 
-	debug("telephony-maemo6: releasing conference call");
+	DBG("telephony-maemo6: releasing conference call");
 
 	msg = dbus_message_new_method_call(CSD_CALL_BUS_NAME,
 						CSD_CALL_CONFERENCE_PATH,
@@ -444,7 +444,7 @@ void telephony_device_connected(void *telephony_device)
 {
 	struct csd_call *coming;
 
-	debug("telephony-maemo6: device %p connected", telephony_device);
+	DBG("telephony-maemo6: device %p connected", telephony_device);
 
 	coming = find_call_with_status(CSD_CALL_STATUS_MT_ALERTING);
 	if (coming) {
@@ -459,7 +459,7 @@ void telephony_device_connected(void *telephony_device)
 
 void telephony_device_disconnected(void *telephony_device)
 {
-	debug("telephony-maemo6: device %p disconnected", telephony_device);
+	DBG("telephony-maemo6: device %p disconnected", telephony_device);
 	events_enabled = FALSE;
 }
 
@@ -481,7 +481,7 @@ void telephony_response_and_hold_req(void *telephony_device, int rh)
 
 void telephony_last_dialed_number_req(void *telephony_device)
 {
-	debug("telephony-maemo6: last dialed number request");
+	DBG("telephony-maemo6: last dialed number request");
 
 	if (last_dialed_number)
 		telephony_dial_number_req(telephony_device,
@@ -602,7 +602,7 @@ void telephony_dial_number_req(void *telephony_device, const char *number)
 	uint32_t flags = callerid;
 	int ret;
 
-	debug("telephony-maemo6: dial request to %s", number);
+	DBG("telephony-maemo6: dial request to %s", number);
 
 	if (strncmp(number, "*31#", 4) == 0) {
 		number += 4;
@@ -642,7 +642,7 @@ void telephony_transmit_dtmf_req(void *telephony_device, char tone)
 	int ret;
 	char buf[2] = { tone, '\0' }, *buf_ptr = buf;
 
-	debug("telephony-maemo6: transmit dtmf: %s", buf);
+	DBG("telephony-maemo6: transmit dtmf: %s", buf);
 
 	ret = send_method_call(CSD_CALL_BUS_NAME, CSD_CALL_PATH,
 				CSD_CALL_INTERFACE, "SendDTMF",
@@ -660,7 +660,7 @@ void telephony_transmit_dtmf_req(void *telephony_device, char tone)
 
 void telephony_subscriber_number_req(void *telephony_device)
 {
-	debug("telephony-maemo6: subscriber number request");
+	DBG("telephony-maemo6: subscriber number request");
 	if (msisdn)
 		telephony_subscriber_number_ind(msisdn,
 						number_type(msisdn),
@@ -711,7 +711,7 @@ void telephony_list_current_calls_req(void *telephony_device)
 	GSList *l;
 	int i;
 
-	debug("telephony-maemo6: list current calls request");
+	DBG("telephony-maemo6: list current calls request");
 
 	for (l = calls, i = 1; l != NULL; l = l->next, i++) {
 		struct csd_call *call = l->data;
@@ -762,7 +762,7 @@ void telephony_call_hold_req(void *telephony_device, const char *cmd)
 	struct csd_call *call;
 	int err = 0;
 
-	debug("telephony-maemo6: got call hold request %s", cmd);
+	DBG("telephony-maemo6: got call hold request %s", cmd);
 
 	if (strlen(cmd) > 1)
 		idx = &cmd[1];
@@ -823,7 +823,7 @@ void telephony_call_hold_req(void *telephony_device, const char *cmd)
 		err = call_transfer();
 		break;
 	default:
-		debug("Unknown call hold request");
+		DBG("Unknown call hold request");
 		break;
 	}
 
@@ -836,7 +836,7 @@ void telephony_call_hold_req(void *telephony_device, const char *cmd)
 
 void telephony_nr_and_ec_req(void *telephony_device, gboolean enable)
 {
-	debug("telephony-maemo6: got %s NR and EC request",
+	DBG("telephony-maemo6: got %s NR and EC request",
 			enable ? "enable" : "disable");
 	telephony_nr_and_ec_rsp(telephony_device, CME_ERROR_NONE);
 }
@@ -846,7 +846,7 @@ void telephony_key_press_req(void *telephony_device, const char *keys)
 	struct csd_call *active, *waiting;
 	int err;
 
-	debug("telephony-maemo6: got key press request for %s", keys);
+	DBG("telephony-maemo6: got key press request for %s", keys);
 
 	waiting = find_call_with_status(CSD_CALL_STATUS_COMING);
 	if (!waiting)
@@ -872,7 +872,7 @@ void telephony_key_press_req(void *telephony_device, const char *keys)
 
 void telephony_voice_dial_req(void *telephony_device, gboolean enable)
 {
-	debug("telephony-maemo6: got %s voice dial request",
+	DBG("telephony-maemo6: got %s voice dial request",
 			enable ? "enable" : "disable");
 
 	telephony_voice_dial_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
@@ -898,7 +898,7 @@ static void handle_incoming_call(DBusMessage *msg)
 		return;
 	}
 
-	debug("Incoming call to %s from number %s", call_path, number);
+	DBG("Incoming call to %s from number %s", call_path, number);
 
 	g_free(call->number);
 	call->number = g_strdup(number);
@@ -934,7 +934,7 @@ static void handle_outgoing_call(DBusMessage *msg)
 		return;
 	}
 
-	debug("Outgoing call from %s to number %s", call_path, number);
+	DBG("Outgoing call from %s to number %s", call_path, number);
 
 	g_free(call->number);
 	call->number = g_strdup(number);
@@ -958,7 +958,7 @@ static gboolean create_timeout(gpointer user_data)
 
 static void handle_create_requested(DBusMessage *msg)
 {
-	debug("Call.CreateRequested()");
+	DBG("Call.CreateRequested()");
 
 	if (create_request_timer)
 		g_source_remove(create_request_timer);
@@ -996,11 +996,11 @@ static void handle_call_status(DBusMessage *msg, const char *call_path)
 		return;
 	}
 
-	debug("Call %s changed from %s to %s", call_path,
+	DBG("Call %s changed from %s to %s", call_path,
 		call_status_str[call->status], call_status_str[status]);
 
 	if (call->status == (int) status) {
-		debug("Ignoring CSD Call state change to existing state");
+		DBG("Ignoring CSD Call state change to existing state");
 		return;
 	}
 
@@ -1138,7 +1138,7 @@ static void handle_conference(DBusMessage *msg, gboolean joined)
 		return;
 	}
 
-	debug("Call %s %s the conference", path, joined ? "joined" : "left");
+	DBG("Call %s %s the conference", path, joined ? "joined" : "left");
 
 	call->conference = joined;
 }
@@ -1210,7 +1210,7 @@ static void update_registration_status(const char *status)
 
 	net.status = new_status;
 
-	debug("telephony-maemo6: registration status changed: %s", status);
+	DBG("telephony-maemo6: registration status changed: %s", status);
 }
 
 static void handle_registration_changed(DBusMessage *msg)
@@ -1234,7 +1234,7 @@ static void update_signal_strength(int32_t signals_bar)
 	if (signals_bar < 0)
 		signals_bar = 0;
 	else if (signals_bar > 100) {
-		debug("signals_bar greater than expected: %u", signals_bar);
+		DBG("signals_bar greater than expected: %u", signals_bar);
 		signals_bar = 100;
 	}
 
@@ -1248,7 +1248,7 @@ static void update_signal_strength(int32_t signals_bar)
 
 	net.signals_bar = signals_bar;
 
-	debug("telephony-maemo6: signal strength updated: %u/100, %d/5", signals_bar, signal);
+	DBG("telephony-maemo6: signal strength updated: %u/100, %d/5", signals_bar, signal);
 }
 
 static void handle_signal_strength_changed(DBusMessage *msg)
@@ -1318,13 +1318,13 @@ static void hal_battery_level_reply(DBusPendingCall *call, void *user_data)
 	*value = (int) level;
 
 	if (value == &battchg_last)
-		debug("telephony-maemo6: battery.charge_level.last_full is %d",
+		DBG("telephony-maemo6: battery.charge_level.last_full is %d",
 				*value);
 	else if (value == &battchg_design)
-		debug("telephony-maemo6: battery.charge_level.design is %d",
+		DBG("telephony-maemo6: battery.charge_level.design is %d",
 				*value);
 	else
-		debug("telephony-maemo6: battery.charge_level.current is %d",
+		DBG("telephony-maemo6: battery.charge_level.current is %d",
 				*value);
 
 	if ((battchg_design > 0 || battchg_last > 0) && battchg_cur >= 0) {
@@ -1452,7 +1452,7 @@ static void parse_call_list(DBusMessageIter *iter)
 			call->object_path = g_strdup(object_path);
 			call->status = (int) status;
 			calls = g_slist_append(calls, call);
-			debug("telephony-maemo6: new csd call instance at %s",
+			DBG("telephony-maemo6: new csd call instance at %s",
 								object_path);
 		}
 
@@ -1484,7 +1484,7 @@ static void update_operator_name(const char *name)
 	g_free(net.operator_name);
 	net.operator_name = g_strdup(name);
 
-	debug("telephony-maemo6: operator name updated: %s", name);
+	DBG("telephony-maemo6: operator name updated: %s", name);
 }
 
 static void get_property_reply(DBusPendingCall *call, void *user_data)
@@ -1634,7 +1634,7 @@ static void hal_find_device_reply(DBusPendingCall *call, void *user_data)
 
 	dbus_message_iter_get_basic(&sub, &path);
 
-	debug("telephony-maemo6: found battery device at %s", path);
+	DBG("telephony-maemo6: found battery device at %s", path);
 
 	snprintf(match_string, sizeof(match_string),
 			"type='signal',"
@@ -1689,11 +1689,11 @@ static void phonebook_read_reply(DBusPendingCall *call, void *user_data)
 	if (number_type == &msisdn) {
 		g_free(msisdn);
 		msisdn = g_strdup(number);
-		debug("Got MSISDN %s (%s)", number, name);
+		DBG("Got MSISDN %s (%s)", number, name);
 	} else {
 		g_free(vmbx);
 		vmbx = g_strdup(number);
-		debug("Got voice mailbox number %s (%s)", number, name);
+		DBG("Got voice mailbox number %s (%s)", number, name);
 	}
 
 done:
@@ -1818,7 +1818,7 @@ static DBusMessage *set_callerid(DBusConnection *conn, DBusMessage *msg,
 			g_str_equal(callerid_setting, "none")) {
 		save_callerid_to_file(callerid_setting);
 		callerid = get_callflag(callerid_setting);
-		debug("telephony-maemo6 setting callerid flag: %s",
+		DBG("telephony-maemo6 setting callerid flag: %s",
 							callerid_setting);
 		return dbus_message_new_method_return(msg);
 	}
@@ -1844,7 +1844,7 @@ static void handle_modem_state(DBusMessage *msg)
 		return;
 	}
 
-	debug("SSC modem state: %s", state);
+	DBG("SSC modem state: %s", state);
 
 	if (calls != NULL || get_calls_active)
 		return;
@@ -1959,7 +1959,7 @@ int telephony_init(void)
 			TELEPHONY_MAEMO_INTERFACE, TELEPHONY_MAEMO_PATH);
 	}
 
-	debug("telephony-maemo6 registering %s interface on path %s",
+	DBG("telephony-maemo6 registering %s interface on path %s",
 			TELEPHONY_MAEMO_INTERFACE, TELEPHONY_MAEMO_PATH);
 
 	telephony_ready_ind(features, maemo_indicators, response_and_hold,
diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 20d002c..e710ce8 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -138,12 +138,12 @@ static struct voice_call *find_vc_with_status(int status)
 
 void telephony_device_connected(void *telephony_device)
 {
-	debug("telephony-ofono: device %p connected", telephony_device);
+	DBG("telephony-ofono: device %p connected", telephony_device);
 }
 
 void telephony_device_disconnected(void *telephony_device)
 {
-	debug("telephony-ofono: device %p disconnected", telephony_device);
+	DBG("telephony-ofono: device %p disconnected", telephony_device);
 	events_enabled = FALSE;
 }
 
@@ -165,7 +165,7 @@ void telephony_response_and_hold_req(void *telephony_device, int rh)
 
 void telephony_last_dialed_number_req(void *telephony_device)
 {
-	debug("telephony-ofono: last dialed number request");
+	DBG("telephony-ofono: last dialed number request");
 
 	if (last_dialed_number)
 		telephony_dial_number_req(telephony_device, last_dialed_number);
@@ -279,7 +279,7 @@ void telephony_dial_number_req(void *telephony_device, const char *number)
 	const char *clir;
 	int ret;
 
-	debug("telephony-ofono: dial request to %s", number);
+	DBG("telephony-ofono: dial request to %s", number);
 
 	if (!modem_obj_path) {
 		telephony_dial_number_rsp(telephony_device,
@@ -315,7 +315,7 @@ void telephony_transmit_dtmf_req(void *telephony_device, char tone)
 	char *tone_string;
 	int ret;
 
-	debug("telephony-ofono: transmit dtmf: %c", tone);
+	DBG("telephony-ofono: transmit dtmf: %c", tone);
 
 	if (!modem_obj_path) {
 		telephony_transmit_dtmf_rsp(telephony_device,
@@ -340,7 +340,7 @@ void telephony_transmit_dtmf_req(void *telephony_device, char tone)
 
 void telephony_subscriber_number_req(void *telephony_device)
 {
-	debug("telephony-ofono: subscriber number request");
+	DBG("telephony-ofono: subscriber number request");
 
 	if (subscriber_number)
 		telephony_subscriber_number_ind(subscriber_number,
@@ -354,7 +354,7 @@ void telephony_list_current_calls_req(void *telephony_device)
 	GSList *l;
 	int i;
 
-	debug("telephony-ofono: list current calls request");
+	DBG("telephony-ofono: list current calls request");
 
 	for (l = calls, i = 1; l != NULL; l = l->next, i++) {
 		struct voice_call *vc = l->data;
@@ -372,7 +372,7 @@ void telephony_list_current_calls_req(void *telephony_device)
 
 void telephony_operator_selection_req(void *telephony_device)
 {
-	debug("telephony-ofono: operator selection request");
+	DBG("telephony-ofono: operator selection request");
 
 	telephony_operator_selection_ind(OPERATOR_MODE_AUTO,
 				net.operator_name ? net.operator_name : "");
@@ -381,13 +381,13 @@ void telephony_operator_selection_req(void *telephony_device)
 
 void telephony_call_hold_req(void *telephony_device, const char *cmd)
 {
-	debug("telephony-ofono: got call hold request %s", cmd);
+	DBG("telephony-ofono: got call hold request %s", cmd);
 	telephony_call_hold_rsp(telephony_device, CME_ERROR_NONE);
 }
 
 void telephony_nr_and_ec_req(void *telephony_device, gboolean enable)
 {
-	debug("telephony-ofono: got %s NR and EC request",
+	DBG("telephony-ofono: got %s NR and EC request",
 			enable ? "enable" : "disable");
 
 	telephony_nr_and_ec_rsp(telephony_device, CME_ERROR_NONE);
@@ -395,13 +395,13 @@ void telephony_nr_and_ec_req(void *telephony_device, gboolean enable)
 
 void telephony_key_press_req(void *telephony_device, const char *keys)
 {
-	debug("telephony-ofono: got key press request for %s", keys);
+	DBG("telephony-ofono: got key press request for %s", keys);
 	telephony_key_press_rsp(telephony_device, CME_ERROR_NONE);
 }
 
 void telephony_voice_dial_req(void *telephony_device, gboolean enable)
 {
-	debug("telephony-ofono: got %s voice dial request",
+	DBG("telephony-ofono: got %s voice dial request",
 			enable ? "enable" : "disable");
 
 	telephony_voice_dial_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
@@ -442,7 +442,7 @@ static void handle_registration_property(const char *property, DBusMessageIter s
 
 	if (g_str_equal(property, "Status")) {
 		dbus_message_iter_get_basic(&sub, &status);
-		debug("Status is %s", status);
+		DBG("Status is %s", status);
 		if (g_str_equal(status, "registered")) {
 			net.status = NETWORK_REG_STATUS_HOME;
 			telephony_update_indicator(ofono_indicators,
@@ -464,12 +464,12 @@ static void handle_registration_property(const char *property, DBusMessageIter s
 		}
 	} else if (g_str_equal(property, "Operator")) {
 		dbus_message_iter_get_basic(&sub, &operator);
-		debug("Operator is %s", operator);
+		DBG("Operator is %s", operator);
 		g_free(net.operator_name);
 		net.operator_name = g_strdup(operator);
 	} else if (g_str_equal(property, "SignalStrength")) {
 		dbus_message_iter_get_basic(&sub, &signals_bar);
-		debug("SignalStrength is %d", signals_bar);
+		DBG("SignalStrength is %d", signals_bar);
 		net.signals_bar = signals_bar;
 		telephony_update_indicator(ofono_indicators, "signal",
 						(signals_bar + 20) / 21);
@@ -560,7 +560,7 @@ static void list_modem_reply(DBusPendingCall *call, void *user_data)
 	char *property, *modem_obj_path_local;
 	int ret;
 
-	debug("list_modem_reply is called\n");
+	DBG("list_modem_reply is called\n");
 	reply = dbus_pending_call_steal_reply(call);
 
 	dbus_error_init(&err);
@@ -598,7 +598,7 @@ static void list_modem_reply(DBusPendingCall *call, void *user_data)
 
 		dbus_message_iter_get_basic(&sub, &modem_obj_path_local);
 		modem_obj_path = g_strdup(modem_obj_path_local);
-		debug("modem_obj_path is %p, %s\n", modem_obj_path,
+		DBG("modem_obj_path is %p, %s\n", modem_obj_path,
 						modem_obj_path);
 		dbus_message_iter_next(&sub);
 	}
@@ -624,7 +624,7 @@ static gboolean handle_registration_property_changed(DBusConnection *conn,
 		return TRUE;
 	}
 	dbus_message_iter_get_basic(&iter, &property);
-	debug("in handle_registration_property_changed(),"
+	DBG("in handle_registration_property_changed(),"
 					" the property is %s", property);
 
 	dbus_message_iter_next(&iter);
@@ -643,7 +643,7 @@ static void vc_getproperties_reply(DBusPendingCall *call, void *user_data)
 	const char *path = user_data;
 	struct voice_call *vc;
 
-	debug("in vc_getproperties_reply");
+	DBG("in vc_getproperties_reply");
 
 	reply = dbus_pending_call_steal_reply(call);
 	dbus_error_init(&err);
@@ -694,11 +694,11 @@ static void vc_getproperties_reply(DBusPendingCall *call, void *user_data)
 		dbus_message_iter_recurse(&iter_property, &sub);
 		if (g_str_equal(property, "LineIdentification")) {
 			dbus_message_iter_get_basic(&sub, &cli);
-			debug("in vc_getproperties_reply(), cli is %s", cli);
+			DBG("in vc_getproperties_reply(), cli is %s", cli);
 			vc->number = g_strdup(cli);
 		} else if (g_str_equal(property, "State")) {
 			dbus_message_iter_get_basic(&sub, &state);
-			debug("in vc_getproperties_reply(),"
+			DBG("in vc_getproperties_reply(),"
 					" state is %s", state);
 			if (g_str_equal(state, "incoming"))
 				vc->status = CALL_STATUS_INCOMING;
@@ -738,7 +738,7 @@ static void vc_getproperties_reply(DBusPendingCall *call, void *user_data)
 					EV_CALLSETUP_ALERTING);
 		break;
 	case CALL_STATUS_WAITING:
-		debug("in CALL_STATUS_WAITING: case");
+		DBG("in CALL_STATUS_WAITING: case");
 		vc->originating = FALSE;
 		telephony_update_indicator(ofono_indicators, "callsetup",
 					EV_CALLSETUP_INCOMING);
@@ -768,7 +768,7 @@ static gboolean handle_vc_property_changed(DBusConnection *conn,
 	DBusMessageIter iter, sub;
 	const char *property, *state;
 
-	debug("in handle_vc_property_changed, obj_path is %s", obj_path);
+	DBG("in handle_vc_property_changed, obj_path is %s", obj_path);
 
 	dbus_message_iter_init(msg, &iter);
 
@@ -778,13 +778,13 @@ static gboolean handle_vc_property_changed(DBusConnection *conn,
 	}
 
 	dbus_message_iter_get_basic(&iter, &property);
-	debug("in handle_vc_property_changed(), the property is %s", property);
+	DBG("in handle_vc_property_changed(), the property is %s", property);
 
 	dbus_message_iter_next(&iter);
 	dbus_message_iter_recurse(&iter, &sub);
 	if (g_str_equal(property, "State")) {
 		dbus_message_iter_get_basic(&sub, &state);
-		debug("in handle_vc_property_changed(), State is %s", state);
+		DBG("in handle_vc_property_changed(), State is %s", state);
 		if (g_str_equal(state, "disconnected")) {
 			printf("in disconnected case\n");
 			if (vc->status == CALL_STATUS_ACTIVE)
@@ -806,12 +806,12 @@ static gboolean handle_vc_property_changed(DBusConnection *conn,
 			if (vc->status == CALL_STATUS_INCOMING)
 				telephony_calling_stopped_ind();
 			vc->status = CALL_STATUS_ACTIVE;
-			debug("vc status is CALL_STATUS_ACTIVE");
+			DBG("vc status is CALL_STATUS_ACTIVE");
 		} else if (g_str_equal(state, "alerting")) {
 			telephony_update_indicator(ofono_indicators,
 					"callsetup", EV_CALLSETUP_ALERTING);
 			vc->status = CALL_STATUS_ALERTING;
-			debug("vc status is CALL_STATUS_ALERTING");
+			DBG("vc status is CALL_STATUS_ALERTING");
 		} else if (g_str_equal(state, "incoming")) {
 			/* state change from waiting to incoming */
 			telephony_update_indicator(ofono_indicators,
@@ -819,7 +819,7 @@ static gboolean handle_vc_property_changed(DBusConnection *conn,
 			telephony_incoming_call_ind(vc->number,
 						NUMBER_TYPE_TELEPHONY);
 			vc->status = CALL_STATUS_INCOMING;
-			debug("vc status is CALL_STATUS_INCOMING");
+			DBG("vc status is CALL_STATUS_INCOMING");
 		}
 	}
 
@@ -833,7 +833,7 @@ static gboolean handle_vcmanager_property_changed(DBusConnection *conn,
 	const char *property, *vc_obj_path = NULL;
 	struct voice_call *vc, *vc_new = NULL;
 
-	debug("in handle_vcmanager_property_changed");
+	DBG("in handle_vcmanager_property_changed");
 
 	dbus_message_iter_init(msg, &iter);
 
@@ -844,7 +844,7 @@ static gboolean handle_vcmanager_property_changed(DBusConnection *conn,
 	}
 
 	dbus_message_iter_get_basic(&iter, &property);
-	debug("in handle_vcmanager_property_changed(),"
+	DBG("in handle_vcmanager_property_changed(),"
 				" the property is %s", property);
 
 	dbus_message_iter_next(&iter);
@@ -859,7 +859,7 @@ static gboolean handle_vcmanager_property_changed(DBusConnection *conn,
 		dbus_message_iter_get_basic(&array, &vc_obj_path);
 		vc = find_vc(vc_obj_path);
 		if (vc) {
-			debug("in handle_vcmanager_property_changed,"
+			DBG("in handle_vcmanager_property_changed,"
 					" found an existing vc");
 		} else {
 			vc_new = g_new0(struct voice_call, 1);
@@ -916,13 +916,13 @@ static void hal_battery_level_reply(DBusPendingCall *call, void *user_data)
 	*value = (int) level;
 
 	if (value == &battchg_last)
-		debug("telephony-ofono: battery.charge_level.last_full"
+		DBG("telephony-ofono: battery.charge_level.last_full"
 					" is %d", *value);
 	else if (value == &battchg_design)
-		debug("telephony-ofono: battery.charge_level.design"
+		DBG("telephony-ofono: battery.charge_level.design"
 					" is %d", *value);
 	else
-		debug("telephony-ofono: battery.charge_level.current"
+		DBG("telephony-ofono: battery.charge_level.current"
 					" is %d", *value);
 
 	if ((battchg_design > 0 || battchg_last > 0) && battchg_cur >= 0) {
@@ -1014,7 +1014,7 @@ static void hal_find_device_reply(DBusPendingCall *call, void *user_data)
 	int type;
 	const char *path;
 
-	debug("begin of hal_find_device_reply()");
+	DBG("begin of hal_find_device_reply()");
 	reply = dbus_pending_call_steal_reply(call);
 
 	dbus_error_init(&err);
@@ -1044,7 +1044,7 @@ static void hal_find_device_reply(DBusPendingCall *call, void *user_data)
 
 	dbus_message_iter_get_basic(&sub, &path);
 
-	debug("telephony-ofono: found battery device at %s", path);
+	DBG("telephony-ofono: found battery device at %s", path);
 
 	device_watch = g_dbus_add_signal_watch(connection, NULL, path,
 					"org.freedesktop.Hal.Device",
@@ -1094,7 +1094,7 @@ int telephony_init(void)
 	if (ret < 0)
 		return ret;
 
-	debug("telephony_init() successfully");
+	DBG("telephony_init() successfully");
 
 	return ret;
 }
diff --git a/audio/telephony.h b/audio/telephony.h
index 0bc4769..5343e8c 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -207,10 +207,10 @@ static inline int telephony_update_indicator(struct indicator *indicators,
 	if (!ind)
 		return -ENOENT;
 
-	debug("Telephony indicator \"%s\" %d->%d", desc, ind->val, new_val);
+	DBG("Telephony indicator \"%s\" %d->%d", desc, ind->val, new_val);
 
 	if (ind->ignore_redundant && ind->val == new_val) {
-		debug("Ignoring no-change indication");
+		DBG("Ignoring no-change indication");
 		return 0;
 	}
 
diff --git a/audio/unix.c b/audio/unix.c
index d44e77a..42c0d80 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -97,7 +97,7 @@ static int unix_sock = -1;
 
 static void client_free(struct unix_client *client)
 {
-	debug("client_free(%p)", client);
+	DBG("client_free(%p)", client);
 
 	if (client->cancel && client->dev && client->req_id > 0)
 		client->cancel(client->dev, client->req_id);
@@ -147,7 +147,7 @@ static void unix_ipc_sendmsg(struct unix_client *client,
 	const char *type = bt_audio_strtype(msg->type);
 	const char *name = bt_audio_strname(msg->name);
 
-	debug("Audio API: %s -> %s", type, name);
+	DBG("Audio API: %s -> %s", type, name);
 
 	if (send(client->sock, msg, msg->length, 0) < 0)
 		error("Error %s(%d)", strerror(errno), errno);
@@ -168,7 +168,7 @@ static void unix_ipc_error(struct unix_client *client, uint8_t name, int err)
 
 	rsp->posix_errno = err;
 
-	debug("sending error %s(%d)", strerror(err), err);
+	DBG("sending error %s(%d)", strerror(err), err);
 	unix_ipc_sendmsg(client, &rsp->h);
 }
 
@@ -448,7 +448,7 @@ failed:
 
 static void print_mpeg12(struct mpeg_codec_cap *mpeg)
 {
-	debug("Media Codec: MPEG12"
+	DBG("Media Codec: MPEG12"
 		" Channel Modes: %s%s%s%s"
 		" Frequencies: %s%s%s%s%s%s"
 		" Layers: %s%s%s"
@@ -473,7 +473,7 @@ static void print_mpeg12(struct mpeg_codec_cap *mpeg)
 
 static void print_sbc(struct sbc_codec_cap *sbc)
 {
-	debug("Media Codec: SBC"
+	DBG("Media Codec: SBC"
 		" Channel Modes: %s%s%s%s"
 		" Frequencies: %s%s%s%s"
 		" Subbands: %s%s"
@@ -593,7 +593,7 @@ static int a2dp_append_codec(struct bt_get_capabilities_rsp *rsp,
 	codec->lock = lock;
 	rsp->h.length += codec->length;
 
-	debug("Append %s seid %d - length %d - total %d",
+	DBG("Append %s seid %d - length %d - total %d",
 		configured ? "configured" : "", seid, codec->length,
 		rsp->h.length);
 
@@ -611,7 +611,7 @@ static void a2dp_discovery_complete(struct avdtp *session, GSList *seps,
 	GSList *l;
 
 	if (!g_slist_find(clients, client)) {
-		debug("Client disconnected during discovery");
+		DBG("Client disconnected during discovery");
 		return;
 	}
 
@@ -1361,7 +1361,7 @@ static int handle_sco_open(struct unix_client *client, struct bt_open_req *req)
 		!g_str_equal(client->interface, AUDIO_GATEWAY_INTERFACE))
 		return -EIO;
 
-	debug("open sco - object=%s source=%s destination=%s lock=%s%s",
+	DBG("open sco - object=%s source=%s destination=%s lock=%s%s",
 			strcmp(req->object, "") ? req->object : "ANY",
 			strcmp(req->source, "") ? req->source : "ANY",
 			strcmp(req->destination, "") ? req->destination : "ANY",
@@ -1380,7 +1380,7 @@ static int handle_a2dp_open(struct unix_client *client, struct bt_open_req *req)
 			!g_str_equal(client->interface, AUDIO_SOURCE_INTERFACE))
 		return -EIO;
 
-	debug("open a2dp - object=%s source=%s destination=%s lock=%s%s",
+	DBG("open a2dp - object=%s source=%s destination=%s lock=%s%s",
 			strcmp(req->object, "") ? req->object : "ANY",
 			strcmp(req->source, "") ? req->source : "ANY",
 			strcmp(req->destination, "") ? req->destination : "ANY",
@@ -1688,7 +1688,7 @@ static gboolean client_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 		return FALSE;
 
 	if (cond & (G_IO_HUP | G_IO_ERR)) {
-		debug("Unix client disconnected (fd=%d)", client->sock);
+		DBG("Unix client disconnected (fd=%d)", client->sock);
 
 		goto failed;
 	}
@@ -1704,7 +1704,7 @@ static gboolean client_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 	type = bt_audio_strtype(msghdr->type);
 	name = bt_audio_strname(msghdr->name);
 
-	debug("Audio API: %s <- %s", type, name);
+	DBG("Audio API: %s <- %s", type, name);
 
 	if (msghdr->length != len) {
 		error("Invalid message: length mismatch");
@@ -1785,7 +1785,7 @@ static gboolean server_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 		return TRUE;
 	}
 
-	debug("Accepted new client connection on unix socket (fd=%d)", cli_sk);
+	DBG("Accepted new client connection on unix socket (fd=%d)", cli_sk);
 	set_nonblocking(cli_sk);
 
 	client = g_new0(struct unix_client, 1);
@@ -1804,7 +1804,7 @@ void unix_device_removed(struct audio_device *dev)
 {
 	GSList *l;
 
-	debug("unix_device_removed(%p)", dev);
+	DBG("unix_device_removed(%p)", dev);
 
 	l = clients;
 	while (l) {
@@ -1825,7 +1825,7 @@ void unix_delay_report(struct audio_device *dev, uint8_t seid, uint16_t delay)
 	GSList *l;
 	struct bt_delay_report_ind ind;
 
-	debug("unix_delay_report(%p): %u.%ums", dev, delay / 10, delay % 10);
+	DBG("unix_delay_report(%p): %u.%ums", dev, delay / 10, delay % 10);
 
 	memset(&ind, 0, sizeof(ind));
 	ind.h.type = BT_INDICATION;
@@ -1882,7 +1882,7 @@ int unix_init(void)
 							server_cb, NULL);
 	g_io_channel_unref(io);
 
-	debug("Unix socket created: %d", sk);
+	DBG("Unix socket created: %d", sk);
 
 	return 0;
 }
diff --git a/input/device.c b/input/device.c
index 9b18d28..8daf8b2 100644
--- a/input/device.c
+++ b/input/device.c
@@ -298,7 +298,7 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 		goto failed;
 	}
 
-	debug("Received: %s", buf);
+	DBG("Received: %s", buf);
 
 	if (g_io_channel_write(chan, ok, 6, &bwritten) != G_IO_ERROR_NONE) {
 		error("IO Channel write error");
@@ -1004,7 +1004,7 @@ static void device_unregister(void *data)
 {
 	struct input_device *idev = data;
 
-	debug("Unregistered interface %s on path %s", INPUT_DEVICE_INTERFACE,
+	DBG("Unregistered interface %s on path %s", INPUT_DEVICE_INTERFACE,
 								idev->path);
 
 	devices = g_slist_remove(devices, idev);
@@ -1091,7 +1091,7 @@ static struct input_device *input_device_new(DBusConnection *conn,
 		return NULL;
 	}
 
-	debug("Registered interface %s on path %s",
+	DBG("Registered interface %s on path %s",
 			INPUT_DEVICE_INTERFACE, idev->path);
 
 	return idev;
diff --git a/input/manager.c b/input/manager.c
index 1dd2308..a98a080 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -179,7 +179,7 @@ int input_manager_init(DBusConnection *conn, GKeyFile *config)
 		idle_timeout = g_key_file_get_integer(config, "General",
 						"IdleTimeout", &err);
 		if (err) {
-			debug("input.conf: %s", err->message);
+			DBG("input.conf: %s", err->message);
 			g_error_free(err);
 		}
 	}
diff --git a/input/server.c b/input/server.c
index 12a4d31..d98018b 100644
--- a/input/server.c
+++ b/input/server.c
@@ -82,7 +82,7 @@ static void connect_event_cb(GIOChannel *chan, GError *err, gpointer data)
 		return;
 	}
 
-	debug("Incoming connection on PSM %d", psm);
+	DBG("Incoming connection on PSM %d", psm);
 
 	ret = input_device_set_channel(&src, &dst, psm, chan);
 	if (ret == 0)
diff --git a/network/common.c b/network/common.c
index 722794d..f5e0ee8 100644
--- a/network/common.c
+++ b/network/common.c
@@ -79,9 +79,9 @@ static gint find_devname(gconstpointer a, gconstpointer b)
 static void script_exited(GPid pid, gint status, gpointer data)
 {
 	if (WIFEXITED(status))
-		debug("%d exited with status %d", pid, WEXITSTATUS(status));
+		DBG("%d exited with status %d", pid, WEXITSTATUS(status));
 	else
-		debug("%d was killed by signal %d", pid, WTERMSIG(status));
+		DBG("%d was killed by signal %d", pid, WTERMSIG(status));
 
 	g_spawn_close_pid(pid);
 }
diff --git a/network/connection.c b/network/connection.c
index ce6d831..01178d7 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -539,7 +539,7 @@ static void path_unregister(void *data)
 {
 	struct network_peer *peer = data;
 
-	debug("Unregistered interface %s on path %s",
+	DBG("Unregistered interface %s on path %s",
 		NETWORK_PEER_INTERFACE, peer->path);
 
 	peers = g_slist_remove(peers, peer);
@@ -603,7 +603,7 @@ static struct network_peer *create_peer(struct btd_device *device,
 		return NULL;
 	}
 
-	debug("Registered interface %s on path %s",
+	DBG("Registered interface %s on path %s",
 		NETWORK_PEER_INTERFACE, path);
 
 	return peer;
diff --git a/network/manager.c b/network/manager.c
index 8216f6f..80a5ded 100644
--- a/network/manager.c
+++ b/network/manager.c
@@ -102,7 +102,7 @@ static void read_config(const char *file)
 	disabled = g_key_file_get_string_list(keyfile, "General",
 						"Disable", NULL, &err);
 	if (err) {
-		debug("%s: %s", file, err->message);
+		DBG("%s: %s", file, err->message);
 		g_clear_error(&err);
 	} else {
 		int i;
@@ -118,7 +118,7 @@ static void read_config(const char *file)
 	conf.security = !g_key_file_get_boolean(keyfile, "General",
 						"DisableSecurity", &err);
 	if (err) {
-		debug("%s: %s", file, err->message);
+		DBG("%s: %s", file, err->message);
 		g_clear_error(&err);
 	}
 
@@ -126,21 +126,21 @@ static void read_config(const char *file)
 	conf.panu_script = g_key_file_get_string(keyfile, "PANU Role",
 						"Script", &err);
 	if (err) {
-		debug("%s: %s", file, err->message);
+		DBG("%s: %s", file, err->message);
 		g_clear_error(&err);
 	}
 
 	conf.gn_script = g_key_file_get_string(keyfile, "GN Role",
 						"Script", &err);
 	if (err) {
-		debug("%s: %s", file, err->message);
+		DBG("%s: %s", file, err->message);
 		g_clear_error(&err);
 	}
 
 	conf.nap_script = g_key_file_get_string(keyfile, "NAP Role",
 						"Script", &err);
 	if (err) {
-		debug("%s: %s", file, err->message);
+		DBG("%s: %s", file, err->message);
 		g_clear_error(&err);
 	}
 #endif
@@ -148,21 +148,21 @@ static void read_config(const char *file)
 	conf.iface_prefix = g_key_file_get_string(keyfile, "PANU Role",
 						"Interface", &err);
 	if (err) {
-		debug("%s: %s", file, err->message);
+		DBG("%s: %s", file, err->message);
 		g_clear_error(&err);
 	}
 
 	conf.gn_iface = g_key_file_get_string(keyfile, "GN Role",
 						"Interface", &err);
 	if (err) {
-		debug("%s: %s", file, err->message);
+		DBG("%s: %s", file, err->message);
 		g_clear_error(&err);
 	}
 
 	conf.nap_iface = g_key_file_get_string(keyfile, "NAP Role",
 						"Interface", &err);
 	if (err) {
-		debug("%s: %s", file, err->message);
+		DBG("%s: %s", file, err->message);
 		g_clear_error(&err);
 	}
 
@@ -177,7 +177,7 @@ done:
 	if (!conf.nap_iface)
 		conf.nap_iface = g_strdup(NAP_IFACE);
 
-	debug("Config options: InterfacePrefix=%s, PANU_Script=%s, "
+	DBG("Config options: InterfacePrefix=%s, PANU_Script=%s, "
 		"GN_Script=%s, NAP_Script=%s, GN_Interface=%s, "
 		"NAP_Interface=%s, Security=%s",
 		conf.iface_prefix, conf.panu_script, conf.gn_script,
diff --git a/network/server.c b/network/server.c
index a4a807f..a82d4ff 100644
--- a/network/server.c
+++ b/network/server.c
@@ -500,7 +500,7 @@ static void confirm_event(GIOChannel *chan, gpointer user_data)
 		goto drop;
 	}
 
-	debug("BNEP: incoming connect from %s", address);
+	DBG("BNEP: incoming connect from %s", address);
 
 	if (na->setup) {
 		error("Refusing connect from %s: setup in progress", address);
@@ -564,7 +564,7 @@ static uint32_t register_server_record(struct network_server *ns)
 		return 0;
 	}
 
-	debug("register_server_record: got record id 0x%x", record->handle);
+	DBG("register_server_record: got record id 0x%x", record->handle);
 
 	return record->handle;
 }
@@ -786,7 +786,7 @@ static void path_unregister(void *data)
 	struct network_server *ns = data;
 	struct network_adapter *na = ns->na;
 
-	debug("Unregistered interface %s on path %s",
+	DBG("Unregistered interface %s on path %s",
 		ns->iface, adapter_get_path(na->adapter));
 
 	na->servers = g_slist_remove(na->servers, ns);
@@ -893,7 +893,7 @@ int server_register(struct btd_adapter *adapter, uint16_t id)
 	ns->enable = TRUE;
 	na->servers = g_slist_append(na->servers, ns);
 
-	debug("Registered interface %s on path %s", ns->iface, path);
+	DBG("Registered interface %s on path %s", ns->iface, path);
 
 	return 0;
 }
diff --git a/plugins/echo.c b/plugins/echo.c
index 4108f92..23f6e49 100644
--- a/plugins/echo.c
+++ b/plugins/echo.c
@@ -151,14 +151,14 @@ static struct btd_adapter_driver echo_server = {
 
 static int echo_init(void)
 {
-	debug("Setup echo plugin");
+	DBG("Setup echo plugin");
 
 	return btd_register_adapter_driver(&echo_server);
 }
 
 static void echo_exit(void)
 {
-	debug("Cleanup echo plugin");
+	DBG("Cleanup echo plugin");
 
 	btd_unregister_adapter_driver(&echo_server);
 }
diff --git a/plugins/hal.c b/plugins/hal.c
index db11a38..f6121c5 100644
--- a/plugins/hal.c
+++ b/plugins/hal.c
@@ -59,7 +59,7 @@ static void formfactor_reply(DBusPendingCall *call, void *user_data)
 		return;
 	}
 
-	debug("Computer is classified as %s", formfactor);
+	DBG("Computer is classified as %s", formfactor);
 
 	if (formfactor != NULL) {
 		if (g_str_equal(formfactor, "laptop") == TRUE)
@@ -75,7 +75,7 @@ static void formfactor_reply(DBusPendingCall *call, void *user_data)
 	dbus_message_unref(reply);
 
 	/* Computer major class */
-	debug("Setting 0x%06x for major/minor device class", (1 << 8) | minor);
+	DBG("Setting 0x%06x for major/minor device class", (1 << 8) | minor);
 
 	btd_adapter_set_class(adapter, 0x01, minor);
 }
diff --git a/plugins/hciops.c b/plugins/hciops.c
index a9f38f3..da2e3d0 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -63,7 +63,7 @@ static gboolean child_exit(GIOChannel *io, GIOCondition cond, void *user_data)
 	if (waitpid(child_pid, &status, 0) != child_pid)
 		error("waitpid(%d) failed", child_pid);
 	else
-		debug("child %d exited", child_pid);
+		DBG("child %d exited", child_pid);
 
 	return TRUE;
 }
@@ -131,7 +131,7 @@ static void init_device(int index)
 			error("Fork failed. Can't init device hci%d: %s (%d)",
 					index, strerror(err), err);
 		default:
-			debug("child %d forked", pid);
+			DBG("child %d forked", pid);
 			return;
 	}
 
diff --git a/plugins/netlink.c b/plugins/netlink.c
index e57e46f..081ffa2 100644
--- a/plugins/netlink.c
+++ b/plugins/netlink.c
@@ -53,7 +53,7 @@ static gboolean channel_callback(GIOChannel *chan,
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
 		return FALSE;
 
-	debug("Message available on netlink channel");
+	DBG("Message available on netlink channel");
 
 	err = nl_recvmsgs_default(handle);
 
diff --git a/plugins/pnat.c b/plugins/pnat.c
index 7ec4345..f9136a4 100644
--- a/plugins/pnat.c
+++ b/plugins/pnat.c
@@ -143,7 +143,7 @@ static gboolean client_event(GIOChannel *chan,
 
 	ba2str(&client->bda, addr);
 
-	debug("Disconnected DUN from %s (%s)", addr, client->tty_name);
+	DBG("Disconnected DUN from %s (%s)", addr, client->tty_name);
 
 	client->io_watch = 0;
 	disconnect(server);
@@ -157,10 +157,10 @@ static void pnatd_exit(GPid pid, gint status, gpointer user_data)
 	struct dun_client *client = &server->client;
 
         if (WIFEXITED(status))
-                debug("pnatd (%d) exited with status %d", pid,
+                DBG("pnatd (%d) exited with status %d", pid,
 							WEXITSTATUS(status));
         else
-                debug("pnatd (%d) was killed by signal %d", pid,
+                DBG("pnatd (%d) was killed by signal %d", pid,
 							WTERMSIG(status));
 
 	client->pnatd_watch = 0;
@@ -183,7 +183,7 @@ static gboolean start_pnatd(struct dun_server *server)
 		return FALSE;
 	}
 
-	debug("pnatd started for %s with pid %d", client->tty_name, pid);
+	DBG("pnatd started for %s with pid %d", client->tty_name, pid);
 
 	client->pnatd_pid = pid;
 	client->pnatd_watch = g_child_watch_add(pid, pnatd_exit, server);
@@ -210,7 +210,7 @@ static gboolean tty_try_open(gpointer user_data)
 		return TRUE;
 	}
 
-	debug("%s created for DUN", client->tty_name);
+	DBG("%s created for DUN", client->tty_name);
 
 	client->tty_open = TRUE;
 	client->tty_timer = 0;
@@ -505,14 +505,14 @@ static struct btd_adapter_driver pnat_server = {
 
 static int pnat_init(void)
 {
-	debug("Setup Phonet AT (DUN) plugin");
+	DBG("Setup Phonet AT (DUN) plugin");
 
 	return btd_register_adapter_driver(&pnat_server);
 }
 
 static void pnat_exit(void)
 {
-	debug("Cleanup Phonet AT (DUN) plugin");
+	DBG("Cleanup Phonet AT (DUN) plugin");
 
 	btd_unregister_adapter_driver(&pnat_server);
 }
diff --git a/plugins/service.c b/plugins/service.c
index e5d03b3..96280bd 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -107,7 +107,7 @@ static void element_start(GMarkupParseContext *context,
 				break;
 			}
 		}
-		debug("New attribute 0x%04x", ctx_data->attr_id);
+		DBG("New attribute 0x%04x", ctx_data->attr_id);
 		return;
 	}
 
@@ -174,13 +174,13 @@ static void element_end(GMarkupParseContext *context,
 			int ret = sdp_attr_add(ctx_data->record, ctx_data->attr_id,
 							ctx_data->stack_head->data);
 			if (ret == -1)
-				debug("Trouble adding attribute\n");
+				DBG("Trouble adding attribute\n");
 
 			ctx_data->stack_head->data = NULL;
 			sdp_xml_data_free(ctx_data->stack_head);
 			ctx_data->stack_head = NULL;
 		} else {
-			debug("No data for attribute 0x%04x\n", ctx_data->attr_id);
+			DBG("No data for attribute 0x%04x\n", ctx_data->attr_id);
 		}
 		return;
 	}
@@ -321,7 +321,7 @@ static void exit_callback(DBusConnection *conn, void *user_data)
 	struct service_adapter *serv_adapter = user_record->serv_adapter;
 	struct pending_auth *auth;
 
-	debug("remove record");
+	DBG("remove record");
 
 	serv_adapter->records = g_slist_remove(serv_adapter->records,
 						user_record);
@@ -409,7 +409,7 @@ static int add_xml_record(DBusConnection *conn, const char *sender,
 	serv_adapter->records = g_slist_append(serv_adapter->records,
 								user_record);
 
-	debug("listener_id %d", user_record->listener_id);
+	DBG("listener_id %d", user_record->listener_id);
 
 	*handle = user_record->handle;
 
@@ -493,13 +493,13 @@ static int remove_record(DBusConnection *conn, const char *sender,
 {
 	struct record_data *user_record;
 
-	debug("remove record 0x%x", handle);
+	DBG("remove record 0x%x", handle);
 
 	user_record = find_record(serv_adapter, handle, sender);
 	if (!user_record)
 		return -1;
 
-	debug("listner_id %d", user_record->listener_id);
+	DBG("listner_id %d", user_record->listener_id);
 
 	g_dbus_remove_watch(conn, user_record->listener_id);
 
@@ -789,7 +789,7 @@ static int register_interface(const char *path, struct btd_adapter *adapter)
 		return -EIO;
 	}
 
-	debug("Registered interface %s on path %s", SERVICE_INTERFACE, path);
+	DBG("Registered interface %s on path %s", SERVICE_INTERFACE, path);
 
 	if (serv_adapter->adapter == NULL)
 		serv_adapter_any = serv_adapter;
diff --git a/serial/port.c b/serial/port.c
index 0f30e3f..48a60b4 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -155,7 +155,7 @@ static int port_release(struct serial_port *port)
 		return 0;
 	}
 
-	debug("Serial port %s released", port->dev);
+	DBG("Serial port %s released", port->dev);
 
 	rfcomm_ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_RFCOMM);
 	if (rfcomm_ctl < 0)
@@ -223,7 +223,7 @@ static void path_unregister(void *data)
 {
 	struct serial_device *device = data;
 
-	debug("Unregistered interface %s on path %s", SERIAL_PORT_INTERFACE,
+	DBG("Unregistered interface %s on path %s", SERIAL_PORT_INTERFACE,
 		device->path);
 
 	devices = g_slist_remove(devices, device);
@@ -358,7 +358,7 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
 
 	port->dev = g_strdup_printf("/dev/rfcomm%d", port->id);
 
-	debug("Serial port %s created", port->dev);
+	DBG("Serial port %s created", port->dev);
 
 	g_io_channel_shutdown(chan, TRUE, NULL);
 
@@ -592,7 +592,7 @@ static struct serial_device *create_serial_device(DBusConnection *conn,
 		return NULL;
 	}
 
-	debug("Registered interface %s on path %s",
+	DBG("Registered interface %s on path %s",
 		SERIAL_PORT_INTERFACE, path);
 
 	return device;
diff --git a/serial/proxy.c b/serial/proxy.c
index 731f157..6577fe2 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -487,7 +487,7 @@ static void confirm_event_cb(GIOChannel *chan, gpointer user_data)
 		goto drop;
 	}
 
-	debug("Serial Proxy: incoming connect from %s", address);
+	DBG("Serial Proxy: incoming connect from %s", address);
 
 	prx->rfcomm = g_io_channel_ref(chan);
 
@@ -533,7 +533,7 @@ static int enable_proxy(struct serial_proxy *prx)
 		goto failed;
 	}
 
-	debug("Allocated channel %d", prx->channel);
+	DBG("Allocated channel %d", prx->channel);
 
 	g_io_channel_set_close_on_unref(prx->io, TRUE);
 
@@ -788,7 +788,7 @@ static void proxy_path_unregister(gpointer data)
 	struct serial_proxy *prx = data;
 	int sk;
 
-	debug("Unregistered proxy: %s", prx->address);
+	DBG("Unregistered proxy: %s", prx->address);
 
 	if (prx->type != TTY_PROXY)
 		goto done;
@@ -823,7 +823,7 @@ static int register_proxy_object(struct serial_proxy *prx)
 	prx->path = g_strdup(path);
 	adapter->proxies = g_slist_append(adapter->proxies, prx);
 
-	debug("Registered proxy: %s", path);
+	DBG("Registered proxy: %s", path);
 
 	return 0;
 }
@@ -1219,7 +1219,7 @@ static void serial_proxy_init(struct serial_adapter *adapter)
 		uuid_str = g_key_file_get_string(config, group_str, "UUID",
 									&gerr);
 		if (gerr) {
-			debug("%s: %s", file, gerr->message);
+			DBG("%s: %s", file, gerr->message);
 			g_error_free(gerr);
 			g_key_file_free(config);
 			g_strfreev(group_list);
@@ -1229,7 +1229,7 @@ static void serial_proxy_init(struct serial_adapter *adapter)
 		address = g_key_file_get_string(config, group_str, "Address",
 									&gerr);
 		if (gerr) {
-			debug("%s: %s", file, gerr->message);
+			DBG("%s: %s", file, gerr->message);
 			g_error_free(gerr);
 			g_key_file_free(config);
 			g_free(uuid_str);
@@ -1241,7 +1241,7 @@ static void serial_proxy_init(struct serial_adapter *adapter)
 		if (err == -EINVAL)
 			error("Invalid address.");
 		else if (err == -EALREADY)
-			debug("Proxy already exists.");
+			DBG("Proxy already exists.");
 		else if (err < 0)
 			error("Proxy creation failed (%s)", strerror(-err));
 		else {
@@ -1285,7 +1285,7 @@ int proxy_register(DBusConnection *conn, struct btd_adapter *btd_adapter)
 
 	adapters = g_slist_append(adapters, adapter);
 
-	debug("Registered interface %s on path %s",
+	DBG("Registered interface %s on path %s",
 		SERIAL_MANAGER_INTERFACE, path);
 
 	serial_proxy_init(adapter);
diff --git a/src/adapter.c b/src/adapter.c
index c0bc1ad..8935f04 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -220,7 +220,7 @@ static int adapter_set_service_classes(struct btd_adapter *adapter, uint8_t valu
 			adapter->cache_enable || adapter->pending_cod)
 		return 0;
 
-	debug("Changing service classes to 0x%06x", adapter->wanted_cod);
+	DBG("Changing service classes to 0x%06x", adapter->wanted_cod);
 
 	err = adapter_ops->set_class(adapter->dev_id, adapter->wanted_cod);
 	if (err < 0)
@@ -246,7 +246,7 @@ int btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
 			adapter->cache_enable || adapter->pending_cod)
 		return 0;
 
-	debug("Changing Major/Minor class to 0x%06x", adapter->wanted_cod);
+	DBG("Changing Major/Minor class to 0x%06x", adapter->wanted_cod);
 
 	err = adapter_ops->set_class(adapter->dev_id, adapter->wanted_cod);
 	if (err < 0)
@@ -616,7 +616,7 @@ static void session_remove(struct session_req *req)
 		if (mode == adapter->mode)
 			return;
 
-		debug("Switching to '%s' mode", mode2str(mode));
+		DBG("Switching to '%s' mode", mode2str(mode));
 
 		set_mode(adapter, mode);
 	} else {
@@ -626,7 +626,7 @@ static void session_remove(struct session_req *req)
 		if (adapter->disc_sessions)
 			return;
 
-		debug("Stopping discovery");
+		DBG("Stopping discovery");
 
 		pending_remote_name_cancel(adapter);
 
@@ -646,7 +646,7 @@ static void session_remove(struct session_req *req)
 
 static void session_free(struct session_req *req)
 {
-	debug("%s session %p with %s deactivated",
+	DBG("%s session %p with %s deactivated",
 		req->mode ? "Mode" : "Discovery", req, req->owner);
 
 	if (req->id)
@@ -675,7 +675,7 @@ static struct session_req *session_ref(struct session_req *req)
 {
 	req->refcount++;
 
-	debug("session_ref(%p): ref=%d", req, req->refcount);
+	DBG("session_ref(%p): ref=%d", req, req->refcount);
 
 	return req;
 }
@@ -684,7 +684,7 @@ static void session_unref(struct session_req *req)
 {
 	req->refcount--;
 
-	debug("session_unref(%p): ref=%d", req, req->refcount);
+	DBG("session_unref(%p): ref=%d", req, req->refcount);
 
 	if (req->refcount)
 		return;
@@ -894,7 +894,7 @@ void adapter_update_tx_power(bdaddr_t *bdaddr, uint8_t status, void *ptr)
 
 	adapter->tx_power = *((int8_t *) ptr);
 
-	debug("inquiry respone tx power level is %d", adapter->tx_power);
+	DBG("inquiry respone tx power level is %d", adapter->tx_power);
 
 	update_ext_inquiry_response(adapter);
 }
@@ -1116,7 +1116,7 @@ struct btd_device *adapter_create_device(DBusConnection *conn,
 	struct btd_device *device;
 	const char *path;
 
-	debug("adapter_create_device(%s)", address);
+	DBG("adapter_create_device(%s)", address);
 
 	device = device_create(conn, adapter, address);
 	if (!device)
@@ -1177,7 +1177,7 @@ struct btd_device *adapter_get_device(DBusConnection *conn,
 {
 	struct btd_device *device;
 
-	debug("adapter_get_device(%s)", address);
+	DBG("adapter_get_device(%s)", address);
 
 	if (!adapter)
 		return NULL;
@@ -1593,7 +1593,7 @@ static DBusMessage *create_device(DBusConnection *conn,
 				ERROR_INTERFACE ".AlreadyExists",
 				"Device already exists");
 
-	debug("create_device(%s)", address);
+	DBG("create_device(%s)", address);
 
 	device = adapter_create_device(conn, adapter, address);
 	if (!device)
@@ -1772,7 +1772,7 @@ static DBusMessage *register_agent(DBusConnection *conn,
 
 	adapter->agent = agent;
 
-	debug("Agent registered for hci%d at %s:%s", adapter->dev_id, name,
+	DBG("Agent registered for hci%d at %s:%s", adapter->dev_id, name,
 			path);
 
 	return dbus_message_new_method_return(msg);
@@ -2288,7 +2288,7 @@ int adapter_start(struct btd_adapter *adapter)
 	if (!bacmp(&di.bdaddr, BDADDR_ANY)) {
 		int err;
 
-		debug("Adapter %s without an address", adapter->path);
+		DBG("Adapter %s without an address", adapter->path);
 
 		err = adapter_read_bdaddr(adapter->dev_id, &di.bdaddr);
 		if (err < 0)
@@ -2366,7 +2366,7 @@ setup:
 	adapter_setup(adapter, mode);
 
 	if (!adapter->initialized && adapter->already_up) {
-		debug("Stopping Inquiry at adapter startup");
+		DBG("Stopping Inquiry at adapter startup");
 		adapter_ops->stop_discovery(adapter->dev_id);
 	}
 
@@ -2504,7 +2504,7 @@ static void adapter_free(gpointer user_data)
 	agent_free(adapter->agent);
 	adapter->agent = NULL;
 
-	debug("adapter_free(%p)", adapter);
+	DBG("adapter_free(%p)", adapter);
 
 	if (adapter->auth_idle_id)
 		g_source_remove(adapter->auth_idle_id);
@@ -2517,7 +2517,7 @@ struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter)
 {
 	adapter->ref++;
 
-	debug("btd_adapter_ref(%p): ref=%d", adapter, adapter->ref);
+	DBG("btd_adapter_ref(%p): ref=%d", adapter, adapter->ref);
 
 	return adapter;
 }
@@ -2528,7 +2528,7 @@ void btd_adapter_unref(struct btd_adapter *adapter)
 
 	adapter->ref--;
 
-	debug("btd_adapter_unref(%p): ref=%d", adapter, adapter->ref);
+	DBG("btd_adapter_unref(%p): ref=%d", adapter, adapter->ref);
 
 	if (adapter->ref > 0)
 		return;
@@ -2581,7 +2581,7 @@ void adapter_remove(struct btd_adapter *adapter)
 {
 	GSList *l;
 
-	debug("Removing adapter %s", adapter->path);
+	DBG("Removing adapter %s", adapter->path);
 
 	for (l = adapter->devices; l; l = l->next)
 		device_remove(l->data, FALSE);
@@ -2959,7 +2959,7 @@ void adapter_remove_connection(struct btd_adapter *adapter,
 	if (device_is_temporary(device)) {
 		const char *path = device_get_path(device);
 
-		debug("Removing temporary device %s", path);
+		DBG("Removing temporary device %s", path);
 		adapter_remove_device(connection, adapter, device, TRUE);
 	}
 }
diff --git a/src/agent.c b/src/agent.c
index 09a6d58..c7fdbd4 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -89,7 +89,7 @@ static void agent_release(struct agent *agent)
 {
 	DBusMessage *message;
 
-	debug("Releasing agent %s, %s", agent->name, agent->path);
+	DBG("Releasing agent %s, %s", agent->name, agent->path);
 
 	if (agent->request)
 		agent_cancel(agent);
@@ -137,7 +137,7 @@ static void agent_exited(DBusConnection *conn, void *user_data)
 {
 	struct agent *agent = user_data;
 
-	debug("Agent exited without calling Unregister");
+	DBG("Agent exited without calling Unregister");
 
 	agent->exited = TRUE;
 
@@ -349,7 +349,7 @@ int agent_authorize(struct agent *agent,
 
 	agent->request = req;
 
-	debug("authorize request was sent for %s", path);
+	DBG("authorize request was sent for %s", path);
 
 	return 0;
 }
@@ -512,7 +512,7 @@ int agent_confirm_mode_change(struct agent *agent, const char *new_mode,
 	if (agent->request)
 		return -EBUSY;
 
-	debug("Calling Agent.ConfirmModeChange: name=%s, path=%s, mode=%s",
+	DBG("Calling Agent.ConfirmModeChange: name=%s, path=%s, mode=%s",
 			agent->name, agent->path, new_mode);
 
 	req = agent_request_new(agent, AGENT_REQUEST_CONFIRM_MODE,
@@ -617,7 +617,7 @@ int agent_request_passkey(struct agent *agent, struct btd_device *device,
 	if (agent->request)
 		return -EBUSY;
 
-	debug("Calling Agent.RequestPasskey: name=%s, path=%s",
+	DBG("Calling Agent.RequestPasskey: name=%s, path=%s",
 			agent->name, agent->path);
 
 	req = agent_request_new(agent, AGENT_REQUEST_PASSKEY, cb,
@@ -676,7 +676,7 @@ int agent_request_confirmation(struct agent *agent, struct btd_device *device,
 	if (agent->request)
 		return -EBUSY;
 
-	debug("Calling Agent.RequestConfirmation: name=%s, path=%s, passkey=%06u",
+	DBG("Calling Agent.RequestConfirmation: name=%s, path=%s, passkey=%06u",
 			agent->name, agent->path, passkey);
 
 	req = agent_request_new(agent, AGENT_REQUEST_CONFIRMATION, cb,
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 155a190..b4e91d3 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -299,7 +299,7 @@ static int get_auth_requirements(bdaddr_t *local, bdaddr_t *remote,
 
 	err = ioctl(dd, HCIGETAUTHINFO, (unsigned long) &req);
 	if (err < 0) {
-		debug("HCIGETAUTHINFO failed: %s (%d)",
+		DBG("HCIGETAUTHINFO failed: %s (%d)",
 					strerror(errno), errno);
 		hci_close_dev(dd);
 		return err;
@@ -342,13 +342,13 @@ int hcid_dbus_user_confirm(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey)
 		return 0;
 	}
 
-	debug("confirm authentication requirement is 0x%02x", type);
+	DBG("confirm authentication requirement is 0x%02x", type);
 
 	remcap = device_get_cap(device);
 	remauth = device_get_auth(device);
 
-	debug("remote IO capabilities are 0x%02x", remcap);
-	debug("remote authentication requirement is 0x%02x", remauth);
+	DBG("remote IO capabilities are 0x%02x", remcap);
+	DBG("remote authentication requirement is 0x%02x", remauth);
 
 	/* If no side requires MITM protection; auto-accept */
 	if (!(remauth & 0x01) &&
@@ -369,7 +369,7 @@ int hcid_dbus_user_confirm(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey)
 
 		hci_close_dev(dd);
 
-		debug("auto accept of confirmation");
+		DBG("auto accept of confirmation");
 
 		return device_request_authentication(device,
 						AUTH_TYPE_AUTO, 0, NULL);
@@ -409,7 +409,7 @@ void hcid_dbus_bonding_process_complete(bdaddr_t *local, bdaddr_t *peer,
 	struct btd_adapter *adapter;
 	struct btd_device *device;
 
-	debug("hcid_dbus_bonding_process_complete: status=%02x", status);
+	DBG("hcid_dbus_bonding_process_complete: status=%02x", status);
 
 	if (!get_adapter_and_device(local, peer, &adapter, &device, TRUE))
 		return;
@@ -418,7 +418,7 @@ void hcid_dbus_bonding_process_complete(bdaddr_t *local, bdaddr_t *peer,
 		/* This means that there was no pending PIN or SSP token
 		 * request from the controller, i.e. this is not a new
 		 * pairing */
-		debug("hcid_dbus_bonding_process_complete: no pending auth request");
+		DBG("hcid_dbus_bonding_process_complete: no pending auth request");
 		return;
 	}
 
@@ -433,7 +433,7 @@ void hcid_dbus_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
 	struct btd_adapter *adapter;
 	struct btd_device *device;
 
-	debug("hcid_dbus_simple_pairing_complete: status=%02x", status);
+	DBG("hcid_dbus_simple_pairing_complete: status=%02x", status);
 
 	if (!get_adapter_and_device(local, peer, &adapter, &device, TRUE))
 		return;
@@ -674,7 +674,7 @@ int hcid_dbus_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 	remote_auth = device_get_auth(device);
 	bonding = device_is_bonding(device, NULL);
 
-	debug("local auth 0x%02x and remote auth 0x%02x",
+	DBG("local auth 0x%02x and remote auth 0x%02x",
 					local_auth, remote_auth);
 
 	/* Only store the link key if one of the following is true:
@@ -692,7 +692,7 @@ int hcid_dbus_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 				(remote_auth == 0x02 || remote_auth == 0x03)) {
 		int err;
 
-		debug("storing link key of type 0x%02x", key_type);
+		DBG("storing link key of type 0x%02x", key_type);
 
 		err = write_link_key(local, peer, key, new_key_type,
 								pin_length);
@@ -766,7 +766,7 @@ void hcid_dbus_disconn_complete(bdaddr_t *local, uint8_t status,
 
 	device = adapter_find_connection(adapter, handle);
 	if (!device) {
-		debug("No matching connection found for handle %u", handle);
+		DBG("No matching connection found for handle %u", handle);
 		return;
 	}
 
@@ -886,7 +886,7 @@ int hcid_dbus_get_io_cap(bdaddr_t *local, bdaddr_t *remote,
 	if (get_auth_requirements(local, remote, auth) < 0)
 		return -1;
 
-	debug("initial authentication requirement is 0x%02x", *auth);
+	DBG("initial authentication requirement is 0x%02x", *auth);
 
 	if (*auth == 0xff)
 		*auth = device_get_auth(device);
@@ -896,7 +896,7 @@ int hcid_dbus_get_io_cap(bdaddr_t *local, bdaddr_t *remote,
 	if (!adapter_is_pairable(adapter) &&
 				!device_is_bonding(device, NULL)) {
 		if (device_get_auth(device) < 0x02) {
-			debug("Allowing no bonding in non-bondable mode");
+			DBG("Allowing no bonding in non-bondable mode");
 			/* No input, no output */
 			*cap = 0x03;
 			/* Kernel defaults to general bonding and so
@@ -916,13 +916,13 @@ int hcid_dbus_get_io_cap(bdaddr_t *local, bdaddr_t *remote,
 	if (!agent) {
 		/* This is the non bondable mode case */
 		if (device_get_auth(device) > 0x01) {
-			debug("Bonding request, but no agent present");
+			DBG("Bonding request, but no agent present");
 			return -1;
 		}
 
 		/* No agent available, and no bonding case */
 		if (*auth == 0x00 || *auth == 0x04) {
-			debug("Allowing no bonding without agent");
+			DBG("Allowing no bonding without agent");
 			/* No input, no output */
 			*cap = 0x03;
 			/* If kernel defaults to general bonding, set it
@@ -966,7 +966,7 @@ int hcid_dbus_get_io_cap(bdaddr_t *local, bdaddr_t *remote,
 	*cap = agent_get_io_capability(agent);
 
 done:
-	debug("final authentication requirement is 0x%02x", *auth);
+	DBG("final authentication requirement is 0x%02x", *auth);
 
 	return 0;
 }
diff --git a/src/device.c b/src/device.c
index e9ada93..407611a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -248,7 +248,7 @@ static void device_free(gpointer user_data)
 	if (device->discov_timer)
 		g_source_remove(device->discov_timer);
 
-	debug("device_free(%p)", device);
+	DBG("device_free(%p)", device);
 
 	g_free(device->authr);
 	g_free(device->path);
@@ -640,7 +640,7 @@ static void discover_services_req_exit(DBusConnection *conn, void *user_data)
 {
 	struct browse_req *req = user_data;
 
-	debug("DiscoverServices requestor exited");
+	DBG("DiscoverServices requestor exited");
 
 	browse_request_cancel(req);
 }
@@ -1018,7 +1018,7 @@ struct btd_device *device_create(DBusConnection *conn,
 	g_strdelimit(device->path, ":", '_');
 	g_free(address_up);
 
-	debug("Creating device %s", device->path);
+	DBG("Creating device %s", device->path);
 
 	if (g_dbus_register_interface(conn, device->path, DEVICE_INTERFACE,
 				device_methods, device_signals, NULL,
@@ -1120,7 +1120,7 @@ static void device_remove_stored(struct btd_device *device)
 void device_remove(struct btd_device *device, gboolean remove_stored)
 {
 
-	debug("Removing device %s", device->path);
+	DBG("Removing device %s", device->path);
 
 	if (device->bonding)
 		device_cancel_bonding(device, HCI_OE_USER_ENDED_CONNECTION);
@@ -1232,11 +1232,11 @@ void device_probe_drivers(struct btd_device *device, GSList *profiles)
 	int err;
 
 	if (device->blocked) {
-		debug("Skipping drivers for blocked device %s", device->path);
+		DBG("Skipping drivers for blocked device %s", device->path);
 		goto add_uuids;
 	}
 
-	debug("Probe drivers for %s", device->path);
+	DBG("Probe drivers for %s", device->path);
 
 	for (list = device_drivers; list; list = list->next) {
 		struct btd_device_driver *driver = list->data;
@@ -1298,7 +1298,7 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
 
 	records = read_records(&src, &device->bdaddr);
 
-	debug("Remove drivers for %s", device->path);
+	DBG("Remove drivers for %s", device->path);
 
 	for (list = device->drivers; list; list = next) {
 		struct btd_driver_data *driver_data = list->data;
@@ -1312,7 +1312,7 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
 						(GCompareFunc) strcasecmp))
 				continue;
 
-			debug("UUID %s was removed from device %s",
+			DBG("UUID %s was removed from device %s",
 							*uuid, dstaddr);
 
 			driver->remove(device);
@@ -1395,7 +1395,7 @@ static void update_services(struct browse_req *req, sdp_list_t *recs)
 
 		/* Check for empty service classes list */
 		if (svcclass == NULL) {
-			debug("Skipping record with no service classes");
+			DBG("Skipping record with no service classes");
 			continue;
 		}
 
@@ -1510,7 +1510,7 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 	}
 
 	if (!req->profiles_added && !req->profiles_removed) {
-		debug("%s: No service update", device->path);
+		DBG("%s: No service update", device->path);
 		goto send_reply;
 	}
 
@@ -1877,7 +1877,7 @@ static struct bonding_req *bonding_request_new(DBusConnection *conn,
 	const char *name = dbus_message_get_sender(msg);
 	struct agent *agent;
 
-	debug("%s: requesting bonding", device->path);
+	DBG("%s: requesting bonding", device->path);
 
 	if (!agent_path)
 		goto proceed;
@@ -1893,7 +1893,7 @@ static struct bonding_req *bonding_request_new(DBusConnection *conn,
 
 	device->agent = agent;
 
-	debug("Temporary agent registered for %s at %s:%s",
+	DBG("Temporary agent registered for %s at %s:%s",
 			device->path, name, agent_path);
 
 proceed:
@@ -2016,7 +2016,7 @@ static void create_bond_req_exit(DBusConnection *conn, void *user_data)
 {
 	struct btd_device *device = user_data;
 
-	debug("%s: requestor exited before bonding was completed", device->path);
+	DBG("%s: requestor exited before bonding was completed", device->path);
 
 	if (device->authr)
 		device_cancel_authentication(device, FALSE);
@@ -2148,7 +2148,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
 			/* If we are not initiators and there is no currently
 			 * active discovery or discovery timer, set discovery
 			 * timer */
-			debug("setting timer for reverse service discovery");
+			DBG("setting timer for reverse service discovery");
 			device->discov_timer = g_timeout_add_seconds(
 							DISCOVERY_TIMER,
 							start_discovery,
@@ -2208,7 +2208,7 @@ void device_cancel_bonding(struct btd_device *device, uint8_t status)
 	if (!bonding)
 		return;
 
-	debug("%s: canceling bonding request", device->path);
+	DBG("%s: canceling bonding request", device->path);
 
 	if (device->authr)
 		device_cancel_authentication(device, FALSE);
@@ -2274,7 +2274,7 @@ int device_request_authentication(struct btd_device *device, auth_type_t type,
 	struct agent *agent;
 	int ret;
 
-	debug("%s: requesting agent authentication", device->path);
+	DBG("%s: requesting agent authentication", device->path);
 
 	agent = device->agent;
 
@@ -2367,7 +2367,7 @@ void device_cancel_authentication(struct btd_device *device, gboolean aborted)
 	if (!auth)
 		return;
 
-	debug("%s: canceling authentication request", device->path);
+	DBG("%s: canceling authentication request", device->path);
 
 	if (auth->agent)
 		agent_cancel(auth->agent);
@@ -2453,7 +2453,7 @@ struct btd_device *btd_device_ref(struct btd_device *device)
 {
 	device->ref++;
 
-	debug("btd_device_ref(%p): ref=%d", device, device->ref);
+	DBG("btd_device_ref(%p): ref=%d", device, device->ref);
 
 	return device;
 }
@@ -2465,7 +2465,7 @@ void btd_device_unref(struct btd_device *device)
 
 	device->ref--;
 
-	debug("btd_device_unref(%p): ref=%d", device, device->ref);
+	DBG("btd_device_unref(%p): ref=%d", device, device->ref);
 
 	if (device->ref > 0)
 		return;
diff --git a/src/main.c b/src/main.c
index 014c381..3118a34 100644
--- a/src/main.c
+++ b/src/main.c
@@ -93,15 +93,15 @@ static void parse_config(GKeyFile *config)
 	if (!config)
 		return;
 
-	debug("parsing main.conf");
+	DBG("parsing main.conf");
 
 	val = g_key_file_get_integer(config, "General",
 						"DiscoverableTimeout", &err);
 	if (err) {
-		debug("%s", err->message);
+		DBG("%s", err->message);
 		g_clear_error(&err);
 	} else {
-		debug("discovto=%d", val);
+		DBG("discovto=%d", val);
 		main_opts.discovto = val;
 		main_opts.flags |= 1 << HCID_SET_DISCOVTO;
 	}
@@ -109,29 +109,29 @@ static void parse_config(GKeyFile *config)
 	val = g_key_file_get_integer(config, "General",
 						"PairableTimeout", &err);
 	if (err) {
-		debug("%s", err->message);
+		DBG("%s", err->message);
 		g_clear_error(&err);
 	} else {
-		debug("pairto=%d", val);
+		DBG("pairto=%d", val);
 		main_opts.pairto = val;
 	}
 
 	val = g_key_file_get_integer(config, "General", "PageTimeout", &err);
 	if (err) {
-		debug("%s", err->message);
+		DBG("%s", err->message);
 		g_clear_error(&err);
 	} else {
-		debug("pageto=%d", val);
+		DBG("pageto=%d", val);
 		main_opts.pageto = val;
 		main_opts.flags |= 1 << HCID_SET_PAGETO;
 	}
 
 	str = g_key_file_get_string(config, "General", "Name", &err);
 	if (err) {
-		debug("%s", err->message);
+		DBG("%s", err->message);
 		g_clear_error(&err);
 	} else {
-		debug("name=%s", str);
+		DBG("name=%s", str);
 		g_free(main_opts.name);
 		main_opts.name = g_strdup(str);
 		main_opts.flags |= 1 << HCID_SET_NAME;
@@ -140,10 +140,10 @@ static void parse_config(GKeyFile *config)
 
 	str = g_key_file_get_string(config, "General", "Class", &err);
 	if (err) {
-		debug("%s", err->message);
+		DBG("%s", err->message);
 		g_clear_error(&err);
 	} else {
-		debug("class=%s", str);
+		DBG("class=%s", str);
 		main_opts.class = strtol(str, NULL, 16);
 		main_opts.flags |= 1 << HCID_SET_CLASS;
 		g_free(str);
@@ -152,17 +152,17 @@ static void parse_config(GKeyFile *config)
 	val = g_key_file_get_integer(config, "General",
 					"DiscoverSchedulerInterval", &err);
 	if (err) {
-		debug("%s", err->message);
+		DBG("%s", err->message);
 		g_clear_error(&err);
 	} else {
-		debug("discov_interval=%d", val);
+		DBG("discov_interval=%d", val);
 		main_opts.discov_interval = val;
 	}
 
 	boolean = g_key_file_get_boolean(config, "General",
 						"InitiallyPowered", &err);
 	if (err) {
-		debug("%s", err->message);
+		DBG("%s", err->message);
 		g_clear_error(&err);
 	} else if (boolean == FALSE)
 		main_opts.mode = MODE_OFF;
@@ -170,17 +170,17 @@ static void parse_config(GKeyFile *config)
 	boolean = g_key_file_get_boolean(config, "General",
 						"RememberPowered", &err);
 	if (err) {
-		debug("%s", err->message);
+		DBG("%s", err->message);
 		g_clear_error(&err);
 	} else
 		main_opts.remember_powered = boolean;
 
 	str = g_key_file_get_string(config, "General", "DeviceID", &err);
 	if (err) {
-		debug("%s", err->message);
+		DBG("%s", err->message);
 		g_clear_error(&err);
 	} else {
-		debug("deviceid=%s", str);
+		DBG("deviceid=%s", str);
 		strncpy(main_opts.deviceid, str,
 					sizeof(main_opts.deviceid) - 1);
 		g_free(str);
@@ -189,7 +189,7 @@ static void parse_config(GKeyFile *config)
 	boolean = g_key_file_get_boolean(config, "General",
 						"ReverseServiceDiscovery", &err);
 	if (err) {
-		debug("%s", err->message);
+		DBG("%s", err->message);
 		g_clear_error(&err);
 	} else
 		main_opts.reverse_sdp = boolean;
diff --git a/src/plugin.c b/src/plugin.c
index 28b9cce..a63ce8e 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -67,7 +67,7 @@ static gboolean add_plugin(void *handle, struct bluetooth_plugin_desc *desc)
 		return FALSE;
 	}
 
-	debug("Loading %s plugin", desc->name);
+	DBG("Loading %s plugin", desc->name);
 
 	plugin = g_try_new0(struct bluetooth_plugin, 1);
 	if (plugin == NULL)
@@ -130,7 +130,7 @@ gboolean plugin_init(GKeyFile *config)
 	else
 		disabled = NULL;
 
-	debug("Loading builtin plugins");
+	DBG("Loading builtin plugins");
 
 	for (i = 0; __bluetooth_builtin[i]; i++) {
 		if (is_disabled(__bluetooth_builtin[i]->name, disabled))
@@ -144,7 +144,7 @@ gboolean plugin_init(GKeyFile *config)
 		goto start;
 	}
 
-	debug("Loading plugins %s", PLUGINDIR);
+	DBG("Loading plugins %s", PLUGINDIR);
 
 	dir = g_dir_open(PLUGINDIR, 0, NULL);
 	if (!dir) {
@@ -210,7 +210,7 @@ void plugin_cleanup(void)
 {
 	GSList *list;
 
-	debug("Cleanup plugins");
+	DBG("Cleanup plugins");
 
 	for (list = plugins; list; list = list->next) {
 		struct bluetooth_plugin *plugin = list->data;
diff --git a/src/rfkill.c b/src/rfkill.c
index 0888776..7810846 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -90,7 +90,7 @@ static gboolean rfkill_event(GIOChannel *chan,
 	if (len != sizeof(struct rfkill_event))
 		return TRUE;
 
-	debug("RFKILL event idx %u type %u op %u soft %u hard %u",
+	DBG("RFKILL event idx %u type %u op %u soft %u hard %u",
 					event->idx, event->type, event->op,
 						event->soft, event->hard);
 
@@ -131,7 +131,7 @@ static gboolean rfkill_event(GIOChannel *chan,
 	if (!adapter)
 		return TRUE;
 
-	debug("RFKILL unblock for hci%d", id);
+	DBG("RFKILL unblock for hci%d", id);
 
 	btd_adapter_restore_powered(adapter);
 
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index 98260d0..cdbb4f4 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -415,7 +415,7 @@ int add_record_to_server(const bdaddr_t *src, sdp_record_t *rec)
 			return -1;
 	}
 
-	debug("Adding record with handle 0x%05x", rec->handle);
+	DBG("Adding record with handle 0x%05x", rec->handle);
 
 	sdp_record_add(src, rec);
 
@@ -435,7 +435,7 @@ int add_record_to_server(const bdaddr_t *src, sdp_record_t *rec)
 			continue;
 
 		sdp_uuid2strn((uuid_t *) pattern->data, uuid, sizeof(uuid));
-		debug("Record pattern UUID %s", uuid);
+		DBG("Record pattern UUID %s", uuid);
 	}
 
 	update_db_timestamp();
@@ -448,7 +448,7 @@ int remove_record_from_server(uint32_t handle)
 {
 	sdp_record_t *rec;
 
-	debug("Removing record with handle 0x%05x", handle);
+	DBG("Removing record with handle 0x%05x", handle);
 
 	rec = sdp_record_find(handle);
 	if (!rec)
diff --git a/src/security.c b/src/security.c
index 43b9365..1d0da45 100644
--- a/src/security.c
+++ b/src/security.c
@@ -314,12 +314,12 @@ static void link_key_request(int dev, bdaddr_t *sba, bdaddr_t *dba)
 	err = ioctl(dev, HCIGETAUTHINFO, (unsigned long) &req);
 	if (err < 0) {
 		if (errno != EINVAL)
-			debug("HCIGETAUTHINFO failed %s (%d)",
+			DBG("HCIGETAUTHINFO failed %s (%d)",
 						strerror(errno), errno);
 		req.type = 0x00;
 	}
 
-	debug("kernel auth requirements = 0x%02x", req.type);
+	DBG("kernel auth requirements = 0x%02x", req.type);
 
 	err = read_link_key(sba, dba, key, &type);
 	if (err < 0) {
@@ -331,7 +331,7 @@ static void link_key_request(int dev, bdaddr_t *sba, bdaddr_t *dba)
 		memcpy(lr.link_key, key, 16);
 		bacpy(&lr.bdaddr, dba);
 
-		debug("stored link key type = 0x%02x", type);
+		DBG("stored link key type = 0x%02x", type);
 
 		/* Don't use debug link keys (0x03) and also don't use
 		 * unauthenticated combination keys if MITM is required */
-- 
1.7.1
