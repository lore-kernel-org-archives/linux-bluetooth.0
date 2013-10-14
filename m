Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 19/22] blueatchat: Extend API for sending AT commands
Date: Mon, 14 Oct 2013 10:34:35 +0200
Message-Id: <1381739678-16260-20-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/blueatchat.c |   20 ++++++++++++++++++++
 src/shared/blueatchat.h |    2 ++
 2 files changed, 22 insertions(+)

diff --git a/src/shared/blueatchat.c b/src/shared/blueatchat.c
index 06d8c65..430bb56 100644
--- a/src/shared/blueatchat.c
+++ b/src/shared/blueatchat.c
@@ -47,6 +47,7 @@ struct blueatchat_session {
 	struct circular_buffer *buffer;
 	GSList *data;	/* stores parsed data */
 	blueatchat_debug_func_t debug_callback;
+	struct circular_buffer *send_buffer;
 };
 
 #ifdef BLUEATCHAT_VERBOSE
@@ -449,6 +450,18 @@ bool blueatchat_read(struct blueatchat_session *session, GIOChannel *gio)
 	return true;
 }
 
+bool blueatchat_write(GIOChannel *gio, struct blueatchat_session *session)
+{
+	/* TODO: send as much buffered data as possible to io channel */
+	return true;
+}
+
+bool blueatchat_send(struct blueatchat_session *session, char *message)
+{
+	/* TODO: validate data and push it to the buffer */
+	return true;
+}
+
 struct blueatchat_session *blueatchat_init_session(
 				struct blueatchat_config *config,
 				struct blueatchat_cmd_descriptor *cmd_list,
@@ -467,6 +480,12 @@ struct blueatchat_session *blueatchat_init_session(
 		g_free(session);
 		return NULL;
 	}
+	session->send_buffer = cbuffer_init(session->config->buff_size);
+	if (!session->send_buffer) {
+		cbuffer_free(session->buffer);
+		free(session);
+		return NULL;
+	}
 	return session;
 }
 
@@ -478,6 +497,7 @@ void blueatchat_cleanup_session(struct blueatchat_session *session)
 
 	g_slist_free_full(session->data, g_free);
 	cbuffer_free(session->buffer);
+	cbuffer_free(session->send_buffer);
 	g_free(session);
 	session = NULL;
 }
diff --git a/src/shared/blueatchat.h b/src/shared/blueatchat.h
index 75d055c..ccdcaed 100644
--- a/src/shared/blueatchat.h
+++ b/src/shared/blueatchat.h
@@ -78,3 +78,5 @@ struct blueatchat_session *blueatchat_init_session(
 				blueatchat_debug_func_t debug_fun);
 void blueatchat_cleanup_session(struct blueatchat_session *session);
 bool blueatchat_read(struct blueatchat_session *session, GIOChannel *gio);
+bool blueatchat_write(GIOChannel *gio, struct blueatchat_session *session);
+bool blueatchat_send(struct blueatchat_session *session, char *message);
-- 
1.7.9.5

