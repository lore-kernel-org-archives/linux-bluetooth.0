Return-Path: <cyrus@holtmann.org>
From: Giovanni Gherdovich <g.gherdovich@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Giovanni Gherdovich <g.gherdovich@gmail.com>
Subject: [PATCH 1/1] adapter, AVCTP: Replaced calls to g_queue_free_full function
Date: Sun, 30 Dec 2012 11:17:12 +0100
Message-Id: <1356862632-5938-1-git-send-email-g.gherdovich@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The function g_queue_free_full is available only from GLib 2.32.
If BlueZ has to build against GLib 2.28, as stated in the configure.ac,
this patch replaces the calls to g_queue_free_full with its body,
taken from the sources of GLib 2.32.

Signed-off-by: Giovanni Gherdovich <g.gherdovich@gmail.com>
---
 profiles/audio/avctp.c |    3 ++-
 src/adapter.c          |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 013c587..745ced8 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -395,7 +395,8 @@ static void avctp_channel_destroy(struct avctp_channel *chan)
 		g_source_remove(chan->process_id);
 
 	g_free(chan->buffer);
-	g_queue_free_full(chan->queue, pending_destroy);
+	g_queue_foreach(chan->queue, (GFunc)pending_destroy, NULL);
+	g_queue_free(chan->queue);
 	g_slist_free_full(chan->processed, pending_destroy);
 	g_slist_free_full(chan->handlers, g_free);
 	g_free(chan);
diff --git a/src/adapter.c b/src/adapter.c
index e71cea8..a244ae2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1697,7 +1697,8 @@ static void adapter_free(gpointer user_data)
 	if (adapter->auth_idle_id)
 		g_source_remove(adapter->auth_idle_id);
 
-	g_queue_free_full(adapter->auths, g_free);
+	g_queue_foreach (adapter->auths, (GFunc)g_free, NULL);
+	g_queue_free (adapter->auths);
 
 	sdp_list_free(adapter->services, NULL);
 
-- 
1.7.4.1

