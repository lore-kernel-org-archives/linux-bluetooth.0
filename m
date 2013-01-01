Return-Path: <cyrus@holtmann.org>
From: Giovanni Gherdovich <g.gherdovich@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Giovanni Gherdovich <g.gherdovich@gmail.com>
Subject: [PATCH 2/2] AVCTP: Replace calls to g_queue_free_full function
Date: Tue,  1 Jan 2013 12:21:48 +0100
Message-Id: <1357039308-8913-1-git-send-email-g.gherdovich@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The function g_queue_free_full is available only from GLib 2.32.
If BlueZ has to build against GLib 2.28, as stated in the configure.ac,
this patch replaces the calls to g_queue_free_full in the AVTCP module
with its body, taken from the sources of GLib 2.32.
---
 profiles/audio/avctp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

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
-- 
1.7.4.1

