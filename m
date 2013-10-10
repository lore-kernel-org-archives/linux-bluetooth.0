Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/6] avdtp: Rename avdtp_callbacks to state_callbacks
Date: Thu, 10 Oct 2013 10:53:39 +0200
Message-ID: <1381395221-5067-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1381395221-5067-1-git-send-email-szymon.janc@tieto.com>
References: <1381395221-5067-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This better describes what list contains.
---
 profiles/audio/avdtp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index e83245e..bf15935 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -425,7 +425,7 @@ struct avdtp {
 
 static GSList *servers = NULL;
 
-static GSList *avdtp_callbacks = NULL;
+static GSList *state_callbacks = NULL;
 
 static int send_request(struct avdtp *session, gboolean priority,
 			struct avdtp_stream *stream, uint8_t signal_id,
@@ -710,7 +710,7 @@ static void avdtp_set_state(struct avdtp *session,
 
 	session->state = new_state;
 
-	for (l = avdtp_callbacks; l != NULL; l = l->next) {
+	for (l = state_callbacks; l != NULL; l = l->next) {
 		struct avdtp_state_callback *cb = l->data;
 
 		if (session->device != cb->dev)
@@ -3874,7 +3874,8 @@ unsigned int avdtp_add_state_cb(struct btd_device *dev,
 	state_cb->id = ++id;
 	state_cb->user_data = user_data;
 
-	avdtp_callbacks = g_slist_append(avdtp_callbacks, state_cb);
+	state_callbacks = g_slist_append(state_callbacks,
+								state_cb);
 
 	return state_cb->id;
 }
@@ -3883,10 +3884,10 @@ gboolean avdtp_remove_state_cb(unsigned int id)
 {
 	GSList *l;
 
-	for (l = avdtp_callbacks; l != NULL; l = l->next) {
+	for (l = state_callbacks; l != NULL; l = l->next) {
 		struct avdtp_state_callback *cb = l->data;
 		if (cb && cb->id == id) {
-			avdtp_callbacks = g_slist_remove(avdtp_callbacks, cb);
+			state_callbacks = g_slist_remove(state_callbacks, cb);
 			g_free(cb);
 			return TRUE;
 		}
-- 
1.8.4

