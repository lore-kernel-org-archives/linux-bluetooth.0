Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/3] sdp-client: Extract cleanup function for cached session
Date: Tue,  9 Sep 2014 11:02:08 +0200
Message-Id: <1410253330-27768-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410253330-27768-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410253330-27768-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Cleanup function will be used by next patch
---
 src/sdp-client.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/sdp-client.c b/src/sdp-client.c
index edbdaec..b6a3663 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -49,15 +49,18 @@ struct cached_sdp_session {
 
 static GSList *cached_sdp_sessions = NULL;
 
-static gboolean cached_session_expired(gpointer user_data)
+static void cleanup_cached_session(struct cached_sdp_session *cached)
 {
-	struct cached_sdp_session *cached = user_data;
-
 	cached_sdp_sessions = g_slist_remove(cached_sdp_sessions, cached);
-
 	sdp_close(cached->session);
-
 	g_free(cached);
+}
+
+static gboolean cached_session_expired(gpointer user_data)
+{
+	struct cached_sdp_session *cached = user_data;
+
+	cleanup_cached_session(cached);
 
 	return FALSE;
 }
-- 
1.8.4

