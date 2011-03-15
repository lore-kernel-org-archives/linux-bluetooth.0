Return-Path: <cyrus@holtmann.org>
From: Arun Raghavan <arun.raghavan@collabora.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: [PATCH] Always reset the remote SEP when reconfiguring A2DP
Date: Tue, 15 Mar 2011 19:57:41 +0530
Message-Id: <1300199261-27481-2-git-send-email-arun.raghavan@collabora.co.uk>
In-Reply-To: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>
References: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This forces the remote SEP to be recalculated when reconfiguring an A2DP
stream. This is required, for example, when reconfiguring the sink to
accept MPEG audio instead of SBC (and thus the remote SEID changes).
---
 audio/a2dp.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 3407d6f..27759b8 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1101,9 +1101,6 @@ static void close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 		return;
 	}
 
-	if (!setup->rsep)
-		setup->rsep = avdtp_stream_get_remote_sep(stream);
-
 	if (setup->reconfigure)
 		g_timeout_add(RECONFIGURE_TIMEOUT, a2dp_reconfigure, setup);
 }
@@ -2048,6 +2045,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 			if (a2dp_sep_get_lock(tmp))
 				goto failed;
 			setup->reconfigure = TRUE;
+			setup->rsep = NULL;
 			if (avdtp_close(session, tmp->stream, FALSE) < 0) {
 				error("avdtp_close failed");
 				goto failed;
@@ -2077,6 +2075,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 			g_idle_add((GSourceFunc) finalize_config, setup);
 		} else if (!setup->reconfigure) {
 			setup->reconfigure = TRUE;
+			setup->rsep = NULL;
 			if (avdtp_close(session, sep->stream, FALSE) < 0) {
 				error("avdtp_close failed");
 				goto failed;
-- 
1.7.4.1

