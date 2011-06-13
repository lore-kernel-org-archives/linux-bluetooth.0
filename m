Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH v2 1/4] Fix invalid write to memory issue in a2dp module
Date: Mon, 13 Jun 2011 12:49:49 +0200
Message-Id: <1307962189-15460-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Under some circumstances (such as terminating bluetoothd during music is
streamed) sep object may be destroyed (memory for sep object is internally
freed, directly by "a2dp_unregister_sep") after invoking
"media_endpoint_clear_configuration" (in "stream_state_changed").
It leads to invalid write issue (reported by valgrind) after assignment
"sep->stream = NULL", since "sep" is "alias" pointer to sep object which
is already out of date (memory for sep object has been already freed)

This patch prevents from this issue by ensuring that assignment
"sep->stream = NULL" would be executed when sep object certainly exists.
---
 audio/a2dp.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index b4ec274..f3e7af3 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -371,11 +371,10 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		sep->session = NULL;
 	}
 
-	if (sep->endpoint)
-		media_endpoint_clear_configuration(sep->endpoint);
-
 	sep->stream = NULL;
 
+	if (sep->endpoint)
+		media_endpoint_clear_configuration(sep->endpoint);
 }
 
 static gboolean auto_config(gpointer data)
-- 
1.6.3.3

