Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D609AC433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E5A6507B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbhCPO07 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbhCPO0m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 10:26:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDCEC061756
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 07:26:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id 392CA1F44BE4
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH Bluez v3 4/4] profiles: Replace calls to g_timeout_add_seconds by timeout_add_seconds
Date:   Tue, 16 Mar 2021 15:26:27 +0100
Message-Id: <20210316142627.23692-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210316142627.23692-1-frederic.danis@collabora.com>
References: <20210316142627.23692-1-frederic.danis@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 profiles/audio/a2dp.c   | 17 ++++++------
 profiles/audio/avctp.c  | 44 +++++++++++++++--------------
 profiles/audio/avdtp.c  | 61 ++++++++++++++++++++---------------------
 profiles/audio/avrcp.c  | 13 +++++----
 profiles/health/hdp.c   | 16 +++++------
 profiles/health/mcap.c  | 21 +++++++-------
 profiles/input/device.c | 33 ++++++++++++----------
 profiles/network/bnep.c | 12 ++++----
 profiles/sap/server.c   | 13 +++++----
 9 files changed, 120 insertions(+), 110 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 98cae97b9..d31ed845c 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -41,6 +41,7 @@
 #include "src/log.h"
 #include "src/sdpd.h"
 #include "src/shared/queue.h"
+#include "src/shared/timeout.h"
 #include "src/shared/util.h"
 
 #include "btio/btio.h"
@@ -69,7 +70,7 @@ struct a2dp_sep {
 	struct avdtp_local_sep *lsep;
 	struct avdtp *session;
 	struct avdtp_stream *stream;
-	guint suspend_timer;
+	unsigned int suspend_timer;
 	gboolean delay_reporting;
 	gboolean locked;
 	gboolean suspending;
@@ -480,7 +481,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		return;
 
 	if (sep->suspend_timer) {
-		g_source_remove(sep->suspend_timer);
+		timeout_remove(sep->suspend_timer);
 		sep->suspend_timer = 0;
 	}
 
@@ -970,7 +971,7 @@ static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	return;
 }
 
-static gboolean suspend_timeout(struct a2dp_sep *sep)
+static bool suspend_timeout(struct a2dp_sep *sep)
 {
 	if (avdtp_suspend(sep->session, sep->stream) == 0)
 		sep->suspending = TRUE;
@@ -997,9 +998,9 @@ static gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	if (!a2dp_sep->locked) {
 		a2dp_sep->session = avdtp_ref(session);
-		a2dp_sep->suspend_timer = g_timeout_add_seconds(SUSPEND_TIMEOUT,
-						(GSourceFunc) suspend_timeout,
-						a2dp_sep);
+		a2dp_sep->suspend_timer = timeout_add_seconds(SUSPEND_TIMEOUT,
+					(timeout_func_t) suspend_timeout,
+					a2dp_sep, NULL);
 	}
 
 	if (!a2dp_sep->starting)
@@ -1055,7 +1056,7 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 		DBG("Source %p: Suspend_Ind", sep);
 
 	if (a2dp_sep->suspend_timer) {
-		g_source_remove(a2dp_sep->suspend_timer);
+		timeout_remove(a2dp_sep->suspend_timer);
 		a2dp_sep->suspend_timer = 0;
 		avdtp_unref(a2dp_sep->session);
 		a2dp_sep->session = NULL;
@@ -2995,7 +2996,7 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 		break;
 	case AVDTP_STATE_STREAMING:
 		if (!sep->suspending && sep->suspend_timer) {
-			g_source_remove(sep->suspend_timer);
+			timeout_remove(sep->suspend_timer);
 			sep->suspend_timer = 0;
 			avdtp_unref(sep->session);
 			sep->session = NULL;
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index c959b4f49..50de33618 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -39,6 +39,7 @@
 #include "src/log.h"
 #include "src/error.h"
 #include "src/uinput.h"
+#include "src/shared/timeout.h"
 
 #include "avctp.h"
 #include "avrcp.h"
@@ -148,7 +149,7 @@ typedef int (*avctp_process_cb) (void *data);
 struct avctp_pending_req {
 	struct avctp_queue *queue;
 	uint8_t transaction;
-	guint timeout;
+	unsigned int timeout;
 	bool retry;
 	int err;
 	avctp_process_cb process;
@@ -179,7 +180,7 @@ struct avctp_channel {
 
 struct key_pressed {
 	uint16_t op;
-	guint timer;
+	unsigned int timer;
 	bool hold;
 };
 
@@ -320,7 +321,7 @@ static void send_key(int fd, uint16_t key, int pressed)
 	send_event(fd, EV_SYN, SYN_REPORT, 0);
 }
 
-static gboolean auto_release(gpointer user_data)
+static bool auto_release(gpointer user_data)
 {
 	struct avctp *session = user_data;
 
@@ -350,14 +351,15 @@ static void handle_press(struct avctp *session, uint16_t op)
 	send_key(session->uinput, op, 1);
 
 done:
-	session->key.timer = g_timeout_add_seconds(AVC_PRESS_TIMEOUT,
-							auto_release, session);
+	session->key.timer = timeout_add_seconds(AVC_PRESS_TIMEOUT,
+							auto_release, session,
+							NULL);
 }
 
 static void handle_release(struct avctp *session, uint16_t op)
 {
 	if (session->key.timer > 0) {
-		g_source_remove(session->key.timer);
+		timeout_remove(session->key.timer);
 		session->key.timer = 0;
 	}
 
@@ -507,7 +509,7 @@ static void pending_destroy(gpointer data, gpointer user_data)
 		req->destroy(req->data);
 
 	if (req->timeout > 0)
-		g_source_remove(req->timeout);
+		timeout_remove(req->timeout);
 
 	g_free(req);
 }
@@ -565,7 +567,7 @@ static void avctp_disconnected(struct avctp *session)
 	}
 
 	if (session->key.timer > 0)
-		g_source_remove(session->key.timer);
+		timeout_remove(session->key.timer);
 
 	if (session->uinput >= 0) {
 		char address[18];
@@ -778,7 +780,7 @@ done:
 	g_free(req);
 }
 
-static gboolean req_timeout(gpointer user_data)
+static bool req_timeout(gpointer user_data)
 {
 	struct avctp_queue *queue = user_data;
 	struct avctp_pending_req *p = queue->p;
@@ -816,8 +818,8 @@ static int process_passthrough(void *data)
 	if (ret < 0)
 		return ret;
 
-	p->timeout = g_timeout_add_seconds(AVC_PRESS_TIMEOUT, req_timeout,
-								p->queue);
+	p->timeout = timeout_add_seconds(AVC_PRESS_TIMEOUT, req_timeout,
+								p->queue, NULL);
 
 	return 0;
 }
@@ -836,8 +838,8 @@ static int process_control(void *data)
 
 	p->retry = !p->retry;
 
-	p->timeout = g_timeout_add_seconds(CONTROL_TIMEOUT, req_timeout,
-								p->queue);
+	p->timeout = timeout_add_seconds(CONTROL_TIMEOUT, req_timeout,
+								p->queue, NULL);
 
 	return 0;
 }
@@ -853,8 +855,8 @@ static int process_browsing(void *data)
 	if (ret < 0)
 		return ret;
 
-	p->timeout = g_timeout_add_seconds(BROWSING_TIMEOUT, req_timeout,
-								p->queue);
+	p->timeout = timeout_add_seconds(BROWSING_TIMEOUT, req_timeout,
+								p->queue, NULL);
 
 	return 0;
 }
@@ -912,7 +914,7 @@ static void control_response(struct avctp_channel *control,
 		control->processed = g_slist_prepend(control->processed, p);
 
 		if (p->timeout > 0) {
-			g_source_remove(p->timeout);
+			timeout_remove(p->timeout);
 			p->timeout = 0;
 		}
 
@@ -964,7 +966,7 @@ static void browsing_response(struct avctp_channel *browsing,
 		browsing->processed = g_slist_prepend(browsing->processed, p);
 
 		if (p->timeout > 0) {
-			g_source_remove(p->timeout);
+			timeout_remove(p->timeout);
 			p->timeout = 0;
 		}
 
@@ -1833,7 +1835,7 @@ static int avctp_passthrough_release(struct avctp *session, uint8_t op)
 				NULL, NULL);
 }
 
-static gboolean repeat_timeout(gpointer user_data)
+static bool repeat_timeout(gpointer user_data)
 {
 	struct avctp *session = user_data;
 
@@ -1847,7 +1849,7 @@ static int release_pressed(struct avctp *session)
 	int ret = avctp_passthrough_release(session, session->key.op);
 
 	if (session->key.timer > 0)
-		g_source_remove(session->key.timer);
+		timeout_remove(session->key.timer);
 
 	session->key.timer = 0;
 	session->key.op = AVC_INVALID;
@@ -1862,9 +1864,9 @@ static bool hold_pressed(struct avctp *session, uint8_t op)
 		return FALSE;
 
 	if (session->key.timer == 0)
-		session->key.timer = g_timeout_add_seconds(AVC_HOLD_TIMEOUT,
+		session->key.timer = timeout_add_seconds(AVC_HOLD_TIMEOUT,
 							repeat_timeout,
-							session);
+							session, NULL);
 
 	return TRUE;
 }
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 1d5871c62..623fe30d3 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -31,6 +31,7 @@
 #include "btio/btio.h"
 #include "src/btd.h"
 #include "src/log.h"
+#include "src/shared/timeout.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/adapter.h"
@@ -298,7 +299,7 @@ struct pending_req {
 	void *data;
 	size_t data_size;
 	struct avdtp_stream *stream; /* Set if the request targeted a stream */
-	guint timeout;
+	unsigned int timeout;
 	gboolean collided;
 };
 
@@ -357,12 +358,12 @@ struct avdtp_stream {
 	GSList *callbacks;
 	struct avdtp_service_capability *codec;
 	guint io_id;		/* Transport GSource ID */
-	guint timer;		/* Waiting for other side to close or open
+	unsigned int timer;	/* Waiting for other side to close or open
 				 * the transport channel */
 	gboolean open_acp;	/* If we are in ACT role for Open */
 	gboolean close_int;	/* If we are in INT role for Close */
 	gboolean abort_int;	/* If we are in INT role for Abort */
-	guint start_timer;	/* Wait START command timer */
+	unsigned int start_timer;	/* Wait START command timer */
 	gboolean delay_reporting;
 	uint16_t delay;		/* AVDTP 1.3 Delay Reporting feature */
 	gboolean starting;	/* only valid while sep state == OPEN */
@@ -404,7 +405,7 @@ struct avdtp {
 	struct discover_callback *discover;
 	struct pending_req *req;
 
-	guint dc_timer;
+	unsigned int dc_timer;
 	int dc_timeout;
 
 	/* Attempt stream setup instead of disconnecting */
@@ -568,7 +569,7 @@ static void pending_req_free(void *data)
 	struct pending_req *req = data;
 
 	if (req->timeout)
-		g_source_remove(req->timeout);
+		timeout_remove(req->timeout);
 	g_free(req->data);
 	g_free(req);
 }
@@ -590,7 +591,7 @@ static void close_stream(struct avdtp_stream *stream)
 	stream->io = NULL;
 }
 
-static gboolean stream_close_timeout(gpointer user_data)
+static bool stream_close_timeout(gpointer user_data)
 {
 	struct avdtp_stream *stream = user_data;
 
@@ -603,7 +604,7 @@ static gboolean stream_close_timeout(gpointer user_data)
 	return FALSE;
 }
 
-static gboolean stream_open_timeout(gpointer user_data)
+static bool stream_open_timeout(gpointer user_data)
 {
 	struct avdtp_stream *stream = user_data;
 
@@ -624,12 +625,12 @@ static gboolean stream_open_timeout(gpointer user_data)
 }
 
 static void stream_set_timer(struct avdtp_stream *stream, guint timeout,
-							GSourceFunc func)
+							timeout_func_t func)
 {
 	if (stream->timer)
-		g_source_remove(stream->timer);
+		timeout_remove(stream->timer);
 
-	stream->timer = g_timeout_add_seconds(timeout, func, stream);
+	stream->timer = timeout_add_seconds(timeout, func, stream, NULL);
 }
 
 static void stream_set_pending_open(struct avdtp_stream *stream, GIOChannel *io)
@@ -729,7 +730,7 @@ static void stream_free(void *data)
 		rsep->stream = NULL;
 
 	if (stream->timer)
-		g_source_remove(stream->timer);
+		timeout_remove(stream->timer);
 
 	if (stream->io)
 		close_stream(stream);
@@ -809,7 +810,7 @@ static void handle_transport_connect(struct avdtp *session, GIOChannel *io,
 	session->pending_open = NULL;
 
 	if (stream->timer) {
-		g_source_remove(stream->timer);
+		timeout_remove(stream->timer);
 		stream->timer = 0;
 	}
 
@@ -1001,7 +1002,7 @@ static void avdtp_sep_set_state(struct avdtp *session,
 		break;
 	case AVDTP_STATE_STREAMING:
 		if (stream->start_timer) {
-			g_source_remove(stream->start_timer);
+			timeout_remove(stream->start_timer);
 			stream->start_timer = 0;
 		}
 		stream->open_acp = FALSE;
@@ -1009,13 +1010,13 @@ static void avdtp_sep_set_state(struct avdtp *session,
 	case AVDTP_STATE_CLOSING:
 	case AVDTP_STATE_ABORTING:
 		if (stream->start_timer) {
-			g_source_remove(stream->start_timer);
+			timeout_remove(stream->start_timer);
 			stream->start_timer = 0;
 		}
 		break;
 	case AVDTP_STATE_IDLE:
 		if (stream->start_timer) {
-			g_source_remove(stream->start_timer);
+			timeout_remove(stream->start_timer);
 			stream->start_timer = 0;
 		}
 		if (session->pending_open == stream)
@@ -1107,7 +1108,7 @@ static void remove_disconnect_timer(struct avdtp *session)
 	if (!session->dc_timer)
 		return;
 
-	g_source_remove(session->dc_timer);
+	timeout_remove(session->dc_timer);
 	session->dc_timer = 0;
 	session->stream_setup = FALSE;
 
@@ -1165,7 +1166,7 @@ static void connection_lost(struct avdtp *session, int err)
 	avdtp_unref(session);
 }
 
-static gboolean disconnect_timeout(gpointer user_data)
+static bool disconnect_timeout(gpointer user_data)
 {
 	struct avdtp *session = user_data;
 	struct btd_service *service;
@@ -1204,12 +1205,9 @@ static void set_disconnect_timer(struct avdtp *session)
 
 	DBG("timeout %d", session->dc_timeout);
 
-	if (!session->dc_timeout)
-		session->dc_timer = g_idle_add(disconnect_timeout, session);
-	else
-		session->dc_timer = g_timeout_add_seconds(session->dc_timeout,
-							disconnect_timeout,
-							session);
+	session->dc_timer = timeout_add_seconds(session->dc_timeout,
+						disconnect_timeout,
+						session, NULL);
 }
 
 void avdtp_unref(struct avdtp *session)
@@ -1865,9 +1863,9 @@ static gboolean avdtp_close_cmd(struct avdtp *session, uint8_t transaction,
 						AVDTP_CLOSE, NULL, 0))
 		return FALSE;
 
-	stream->timer = g_timeout_add_seconds(REQ_TIMEOUT,
+	stream->timer = timeout_add_seconds(REQ_TIMEOUT,
 					stream_close_timeout,
-					stream);
+					stream, NULL);
 
 	return TRUE;
 
@@ -2263,7 +2261,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 		return TRUE;
 	}
 
-	g_source_remove(session->req->timeout);
+	timeout_remove(session->req->timeout);
 	session->req->timeout = 0;
 
 	switch (header->message_type) {
@@ -2608,7 +2606,7 @@ done:
 	return err;
 }
 
-static gboolean request_timeout(gpointer user_data)
+static bool request_timeout(gpointer user_data)
 {
 	struct avdtp *session = user_data;
 
@@ -2669,7 +2667,8 @@ static int send_req(struct avdtp *session, gboolean priority,
 		timeout = REQ_TIMEOUT;
 	}
 
-	req->timeout = g_timeout_add_seconds(timeout, request_timeout, session);
+	req->timeout = timeout_add_seconds(timeout, request_timeout,
+						session, NULL);
 	return 0;
 
 failed:
@@ -3567,7 +3566,7 @@ int avdtp_open(struct avdtp *session, struct avdtp_stream *stream)
 							&req, sizeof(req));
 }
 
-static gboolean start_timeout(gpointer user_data)
+static bool start_timeout(gpointer user_data)
 {
 	struct avdtp_stream *stream = user_data;
 	struct avdtp *session = stream->session;
@@ -3602,9 +3601,9 @@ int avdtp_start(struct avdtp *session, struct avdtp_stream *stream)
 		if (stream->start_timer)
 			return 0;
 
-		stream->start_timer = g_timeout_add_seconds(START_TIMEOUT,
+		stream->start_timer = timeout_add_seconds(START_TIMEOUT,
 								start_timeout,
-								stream);
+								stream, NULL);
 		return 0;
 	}
 
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index c093deac8..05dd791de 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -46,6 +46,7 @@
 #include "src/error.h"
 #include "src/sdpd.h"
 #include "src/dbus-common.h"
+#include "src/shared/timeout.h"
 #include "src/shared/util.h"
 
 #include "avctp.h"
@@ -3942,7 +3943,7 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
 
 	/* Connect browsing if pending */
 	if (session->browsing_timer > 0) {
-		g_source_remove(session->browsing_timer);
+		timeout_remove(session->browsing_timer);
 		session->browsing_timer = 0;
 		avctp_connect_browsing(session->conn);
 	}
@@ -4037,7 +4038,7 @@ static void destroy_browsing(void *data)
 static void session_init_browsing(struct avrcp *session)
 {
 	if (session->browsing_timer > 0) {
-		g_source_remove(session->browsing_timer);
+		timeout_remove(session->browsing_timer);
 		session->browsing_timer = 0;
 	}
 
@@ -4072,7 +4073,7 @@ static struct avrcp_data *data_init(struct avrcp *session, const char *uuid)
 	return data;
 }
 
-static gboolean connect_browsing(gpointer user_data)
+static bool connect_browsing(gpointer user_data)
 {
 	struct avrcp *session = user_data;
 
@@ -4096,9 +4097,9 @@ static void avrcp_connect_browsing(struct avrcp *session)
 	if (session->browsing_timer > 0)
 		return;
 
-	session->browsing_timer = g_timeout_add_seconds(AVRCP_BROWSING_TIMEOUT,
+	session->browsing_timer = timeout_add_seconds(AVRCP_BROWSING_TIMEOUT,
 							connect_browsing,
-							session);
+							session, NULL);
 }
 
 static void target_init(struct avrcp *session)
@@ -4261,7 +4262,7 @@ static void session_destroy(struct avrcp *session, int err)
 	}
 
 	if (session->browsing_timer > 0)
-		g_source_remove(session->browsing_timer);
+		timeout_remove(session->browsing_timer);
 
 	if (session->controller != NULL)
 		controller_destroy(session);
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 9f906932d..6bc41946f 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -31,6 +31,7 @@
 #include "src/adapter.h"
 #include "src/device.h"
 #include "src/sdpd.h"
+#include "src/shared/timeout.h"
 #include "btio/btio.h"
 
 #include "hdp_types.h"
@@ -70,7 +71,7 @@ struct hdp_tmp_dc_data {
 struct hdp_echo_data {
 	gboolean		echo_done;	/* Is a echo was already done */
 	gpointer		buf;		/* echo packet sent */
-	guint			tid;		/* echo timeout */
+	unsigned int		tid;		/* echo timeout */
 };
 
 static struct hdp_channel *hdp_channel_ref(struct hdp_channel *chan)
@@ -683,7 +684,7 @@ static void free_echo_data(struct hdp_echo_data *edata)
 		return;
 
 	if (edata->tid > 0)
-		g_source_remove(edata->tid);
+		timeout_remove(edata->tid);
 
 	if (edata->buf != NULL)
 		g_free(edata->buf);
@@ -1524,7 +1525,7 @@ end:
 	reply = g_dbus_create_reply(hdp_conn->msg, DBUS_TYPE_BOOLEAN, &value,
 							DBUS_TYPE_INVALID);
 	g_dbus_send_message(btd_get_dbus_connection(), reply);
-	g_source_remove(edata->tid);
+	timeout_remove(edata->tid);
 	edata->tid = 0;
 	g_free(edata->buf);
 	edata->buf = NULL;
@@ -1538,7 +1539,7 @@ end:
 	return FALSE;
 }
 
-static gboolean echo_timeout(gpointer data)
+static bool echo_timeout(gpointer data)
 {
 	struct hdp_channel *chan = data;
 	GIOChannel *io;
@@ -1606,10 +1607,9 @@ static void hdp_echo_connect_cb(struct mcap_mdl *mdl, GError *err,
 	g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL | G_IO_IN,
 			check_echo, hdp_tmp_dc_data_ref(hdp_conn));
 
-	edata->tid = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT,
-					ECHO_TIMEOUT, echo_timeout,
-					hdp_channel_ref(hdp_conn->hdp_chann),
-					(GDestroyNotify) hdp_channel_unref);
+	edata->tid = timeout_add_seconds(ECHO_TIMEOUT, echo_timeout,
+				hdp_channel_ref(hdp_conn->hdp_chann),
+				(timeout_destroy_func_t) hdp_channel_unref);
 
 	g_io_channel_unref(io);
 }
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index 32365fd50..be13af37a 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -26,6 +26,7 @@
 #include "bluetooth/l2cap.h"
 #include "btio/btio.h"
 #include "src/log.h"
+#include "src/shared/timeout.h"
 
 #include "mcap.h"
 
@@ -43,7 +44,7 @@
 
 #define RELEASE_TIMER(__mcl) do {		\
 	if (__mcl->tid) {			\
-		g_source_remove(__mcl->tid);	\
+		timeout_remove(__mcl->tid);	\
 		__mcl->tid = 0;			\
 	}					\
 } while(0)
@@ -483,7 +484,7 @@ static int compare_mdl(gconstpointer a, gconstpointer b)
 		return 1;
 }
 
-static gboolean wait_response_timer(gpointer data)
+static bool wait_response_timer(gpointer data)
 {
 	struct mcap_mcl *mcl = data;
 
@@ -549,8 +550,8 @@ gboolean mcap_create_mdl(struct mcap_mcl *mcl,
 
 	mcl->mdls = g_slist_insert_sorted(mcl->mdls, mcap_mdl_ref(mdl),
 								compare_mdl);
-	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
-									mcl);
+	mcl->tid = timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
+					mcl, NULL);
 	return TRUE;
 }
 
@@ -587,8 +588,8 @@ gboolean mcap_reconnect_mdl(struct mcap_mdl *mdl,
 	mcl->state = MCL_ACTIVE;
 	mcl->priv_data = con;
 
-	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
-									mcl);
+	mcl->tid = timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
+					mcl, NULL);
 	return TRUE;
 }
 
@@ -607,8 +608,8 @@ static gboolean send_delete_req(struct mcap_mcl *mcl,
 
 	mcl->priv_data = con;
 
-	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
-									mcl);
+	mcl->tid = timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
+					mcl, NULL);
 	return TRUE;
 }
 
@@ -718,8 +719,8 @@ gboolean mcap_mdl_abort(struct mcap_mdl *mdl, mcap_mdl_notify_cb abort_cb,
 	con->user_data = user_data;
 
 	mcl->priv_data = con;
-	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
-									mcl);
+	mcl->tid = timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
+					mcl, NULL);
 	return TRUE;
 }
 
diff --git a/profiles/input/device.c b/profiles/input/device.c
index 326a3bcb9..50ae51855 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -39,6 +39,7 @@
 #include "src/dbus-common.h"
 #include "src/error.h"
 #include "src/sdp-client.h"
+#include "src/shared/timeout.h"
 #include "src/shared/uhid.h"
 
 #include "device.h"
@@ -68,12 +69,12 @@ struct input_device {
 	struct hidp_connadd_req *req;
 	bool			disable_sdp;
 	enum reconnect_mode_t	reconnect_mode;
-	guint			reconnect_timer;
+	unsigned int		reconnect_timer;
 	uint32_t		reconnect_attempt;
 	struct bt_uhid		*uhid;
 	bool			uhid_created;
 	uint8_t			report_req_pending;
-	guint			report_req_timer;
+	unsigned int		report_req_timer;
 	uint32_t		report_rsp_id;
 	bool			virtual_cable_unplug;
 };
@@ -140,10 +141,10 @@ static void input_device_free(struct input_device *idev)
 	}
 
 	if (idev->reconnect_timer > 0)
-		g_source_remove(idev->reconnect_timer);
+		timeout_remove(idev->reconnect_timer);
 
 	if (idev->report_req_timer > 0)
-		g_source_remove(idev->report_req_timer);
+		timeout_remove(idev->report_req_timer);
 
 	g_free(idev);
 }
@@ -439,7 +440,7 @@ static void hidp_recv_ctrl_handshake(struct input_device *idev, uint8_t param)
 	if (pending_req_complete) {
 		idev->report_req_pending = 0;
 		if (idev->report_req_timer > 0) {
-			g_source_remove(idev->report_req_timer);
+			timeout_remove(idev->report_req_timer);
 			idev->report_req_timer = 0;
 		}
 		idev->report_rsp_id = 0;
@@ -499,7 +500,7 @@ static void hidp_recv_ctrl_data(struct input_device *idev, uint8_t param,
 
 	idev->report_req_pending = 0;
 	if (idev->report_req_timer > 0) {
-		g_source_remove(idev->report_req_timer);
+		timeout_remove(idev->report_req_timer);
 		idev->report_req_timer = 0;
 	}
 	idev->report_rsp_id = 0;
@@ -588,7 +589,7 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 
 #define REPORT_REQ_TIMEOUT  3
 
-static gboolean hidp_report_req_timeout(gpointer data)
+static bool hidp_report_req_timeout(gpointer data)
 {
 	struct input_device *idev = data;
 	uint8_t pending_req_type;
@@ -669,8 +670,8 @@ static void hidp_send_set_report(struct uhid_event *ev, void *user_data)
 	if (sent) {
 		idev->report_req_pending = hdr;
 		idev->report_req_timer =
-			g_timeout_add_seconds(REPORT_REQ_TIMEOUT,
-					hidp_report_req_timeout, idev);
+			timeout_add_seconds(REPORT_REQ_TIMEOUT,
+					hidp_report_req_timeout, idev, NULL);
 		idev->report_rsp_id = ev->u.set_report.id;
 	} else
 		uhid_send_set_report_reply(idev, ev->u.set_report.id, EIO);
@@ -712,8 +713,9 @@ static void hidp_send_get_report(struct uhid_event *ev, void *user_data)
 	if (sent) {
 		idev->report_req_pending = hdr;
 		idev->report_req_timer =
-			g_timeout_add_seconds(REPORT_REQ_TIMEOUT,
-						hidp_report_req_timeout, idev);
+			timeout_add_seconds(REPORT_REQ_TIMEOUT,
+						hidp_report_req_timeout, idev,
+						NULL);
 		idev->report_rsp_id = ev->u.get_report.id;
 	} else
 		uhid_send_get_report_reply(idev, NULL, 0, ev->u.get_report.id,
@@ -1282,7 +1284,7 @@ static int dev_connect(struct input_device *idev)
 	return -EIO;
 }
 
-static gboolean input_device_auto_reconnect(gpointer user_data)
+static bool input_device_auto_reconnect(gpointer user_data)
 {
 	struct input_device *idev = user_data;
 
@@ -1352,12 +1354,13 @@ static void input_device_enter_reconnect_mode(struct input_device *idev)
 		return;
 
 	if (idev->reconnect_timer > 0)
-		g_source_remove(idev->reconnect_timer);
+		timeout_remove(idev->reconnect_timer);
 
 	DBG("registering auto-reconnect");
 	idev->reconnect_attempt = 0;
-	idev->reconnect_timer = g_timeout_add_seconds(30,
-					input_device_auto_reconnect, idev);
+	idev->reconnect_timer = timeout_add_seconds(30,
+					input_device_auto_reconnect, idev,
+					NULL);
 
 }
 
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 7e777e29c..f94f1da8a 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -32,6 +32,7 @@
 #include "lib/uuid.h"
 
 #include "src/log.h"
+#include "src/shared/timeout.h"
 #include "src/shared/util.h"
 #include "btio/btio.h"
 
@@ -54,7 +55,7 @@ struct bnep {
 	bdaddr_t	dst_addr;
 	char	iface[16];
 	guint	attempts;
-	guint	setup_to;
+	unsigned int	setup_to;
 	guint	watch;
 	bnep_connect_cb	conn_cb;
 	void	*conn_data;
@@ -209,7 +210,7 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 		return FALSE;
 
 	if (session->setup_to > 0) {
-		g_source_remove(session->setup_to);
+		timeout_remove(session->setup_to);
 		session->setup_to = 0;
 	}
 
@@ -313,7 +314,7 @@ static int bnep_setup_conn_req(struct bnep *session)
 	return 0;
 }
 
-static gboolean bnep_conn_req_to(gpointer user_data)
+static bool bnep_conn_req_to(gpointer user_data)
 {
 	struct bnep *session = user_data;
 
@@ -402,8 +403,9 @@ int bnep_connect(struct bnep *session, bnep_connect_cb conn_cb,
 	if (err < 0)
 		return err;
 
-	session->setup_to = g_timeout_add_seconds(CON_SETUP_TO,
-						bnep_conn_req_to, session);
+	session->setup_to = timeout_add_seconds(CON_SETUP_TO,
+						bnep_conn_req_to, session,
+						NULL);
 	return 0;
 }
 
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index b0a454ced..82365fca9 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -31,6 +31,7 @@
 #include "src/log.h"
 #include "src/error.h"
 #include "src/dbus-common.h"
+#include "src/shared/timeout.h"
 #include "src/shared/util.h"
 
 #include "sap.h"
@@ -62,7 +63,7 @@ struct sap_connection {
 	GIOChannel *io;
 	uint32_t state;
 	uint8_t processing_req;
-	guint timer_id;
+	unsigned int timer_id;
 };
 
 struct sap_server {
@@ -74,7 +75,7 @@ struct sap_server {
 
 static void start_guard_timer(struct sap_server *server, guint interval);
 static void stop_guard_timer(struct sap_server *server);
-static gboolean guard_timeout(gpointer data);
+static bool guard_timeout(gpointer data);
 
 static size_t add_result_parameter(uint8_t result,
 					struct sap_parameter *param)
@@ -554,8 +555,8 @@ static void start_guard_timer(struct sap_server *server, guint interval)
 		return;
 
 	if (!conn->timer_id)
-		conn->timer_id = g_timeout_add_seconds(interval, guard_timeout,
-								server);
+		conn->timer_id = timeout_add_seconds(interval, guard_timeout,
+								server, NULL);
 	else
 		error("Timer is already active.");
 }
@@ -565,12 +566,12 @@ static void stop_guard_timer(struct sap_server *server)
 	struct sap_connection *conn = server->conn;
 
 	if (conn  && conn->timer_id) {
-		g_source_remove(conn->timer_id);
+		timeout_remove(conn->timer_id);
 		conn->timer_id = 0;
 	}
 }
 
-static gboolean guard_timeout(gpointer data)
+static bool guard_timeout(gpointer data)
 {
 	struct sap_server *server = data;
 	struct sap_connection *conn = server->conn;
-- 
2.18.0

