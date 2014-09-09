Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/3] sdp-client: Add disconnect watch for cached session
Date: Tue,  9 Sep 2014 11:02:09 +0200
Message-Id: <1410253330-27768-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410253330-27768-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410253330-27768-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SDP client keeps sdp session alive for 2 more second after usage in case
there is need for reuse it. However, if ACL is disconnected and
reconnected during that time, sdp session becomes outdated. This patch
makes sure that cached sdp session will be cleaned up on ACL disconnect
---
 src/sdp-client.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/sdp-client.c b/src/sdp-client.c
index b6a3663..f9412f0 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -45,6 +45,7 @@ struct cached_sdp_session {
 	bdaddr_t dst;
 	sdp_session_t *session;
 	guint timer;
+	guint io_id;
 };
 
 static GSList *cached_sdp_sessions = NULL;
@@ -60,6 +61,7 @@ static gboolean cached_session_expired(gpointer user_data)
 {
 	struct cached_sdp_session *cached = user_data;
 
+	g_source_remove(cached->io_id);
 	cleanup_cached_session(cached);
 
 	return FALSE;
@@ -77,6 +79,7 @@ static sdp_session_t *get_cached_sdp_session(const bdaddr_t *src, const bdaddr_t
 			continue;
 
 		g_source_remove(c->timer);
+		g_source_remove(c->io_id);
 
 		session = c->session;
 
@@ -89,10 +92,23 @@ static sdp_session_t *get_cached_sdp_session(const bdaddr_t *src, const bdaddr_t
 	return NULL;
 }
 
+static gboolean disconnect_watch(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	struct cached_sdp_session *cached = user_data;
+
+	g_source_remove(cached->timer);
+	cleanup_cached_session(cached);
+
+	return FALSE;
+}
+
 static void cache_sdp_session(bdaddr_t *src, bdaddr_t *dst,
 						sdp_session_t *session)
 {
 	struct cached_sdp_session *cached;
+	int sk;
+	GIOChannel *chan;
 
 	cached = g_new0(struct cached_sdp_session, 1);
 
@@ -106,6 +122,13 @@ static void cache_sdp_session(bdaddr_t *src, bdaddr_t *dst,
 	cached->timer = g_timeout_add_seconds(CACHE_TIMEOUT,
 						cached_session_expired,
 						cached);
+
+	/* Watch the connection state during cache timeout */
+	sk = sdp_get_socket(session);
+	chan = g_io_channel_unix_new(sk);
+
+	cached->io_id = g_io_add_watch(chan, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+						disconnect_watch, cached);
 }
 
 struct search_context {
-- 
1.8.4

