Return-Path: <cyrus@holtmann.org>
From: Giovanni Gherdovich <g.gherdovich@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Giovanni Gherdovich <g.gherdovich@gmail.com>
Subject: [PATCH 2/2] AVCTP: Replace calls to g_queue_free_full function
Date: Thu,  3 Jan 2013 20:37:15 +0100
Message-Id: <1357241835-4861-1-git-send-email-g.gherdovich@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The function g_queue_free_full is available only from GLib 2.32.
If BlueZ has to build against GLib 2.28, as stated in the configure.ac,
this patch replaces the calls to g_queue_free_full in the AVTCP module
with its body, taken from the sources of GLib 2.32.
---
 profiles/audio/avctp.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 013c587..b26abe5 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -370,7 +370,7 @@ static struct avctp_pdu_handler *find_handler(GSList *list, uint8_t opcode)
 	return NULL;
 }
 
-static void pending_destroy(void *data)
+static void pending_destroy(gpointer data, gpointer user_data)
 {
 	struct avctp_pending_req *req = data;
 
@@ -395,8 +395,10 @@ static void avctp_channel_destroy(struct avctp_channel *chan)
 		g_source_remove(chan->process_id);
 
 	g_free(chan->buffer);
-	g_queue_free_full(chan->queue, pending_destroy);
-	g_slist_free_full(chan->processed, pending_destroy);
+	g_queue_foreach(chan->queue, pending_destroy, NULL);
+	g_queue_free(chan->queue);
+	g_slist_foreach(chan->processed, pending_destroy, NULL);
+	g_slist_free(chan->processed);
 	g_slist_free_full(chan->handlers, g_free);
 	g_free(chan);
 }
@@ -540,7 +542,7 @@ static gboolean req_timeout(gpointer user_data)
 
 	p->timeout = 0;
 
-	pending_destroy(p);
+	pending_destroy(p, NULL);
 	chan->p = NULL;
 
 	if (chan->process_id == 0)
@@ -574,7 +576,7 @@ static gboolean process_queue(void *user_data)
 		if (p->process(p->data) == 0)
 			break;
 
-		pending_destroy(p);
+		pending_destroy(p, NULL);
 	}
 
 	if (p == NULL)
@@ -626,7 +628,7 @@ static void control_response(struct avctp_channel *control,
 			return;
 
 		control->processed = g_slist_remove(control->processed, p);
-		pending_destroy(p);
+		pending_destroy(p, NULL);
 
 		return;
 	}
-- 
1.7.4.1

