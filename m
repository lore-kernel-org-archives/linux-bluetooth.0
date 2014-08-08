Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] android/a2dp: Fix for PTS testcase
Date: Fri,  8 Aug 2014 15:42:34 +0200
Message-Id: <1407505354-23072-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1407505354-23072-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1407505354-23072-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch is a fix for PTS TC_SRC_REL_BV_01_I
PTS expects us to CLOSE stream not to ABORT the stream when
disconnecting A2DP.
---
 android/avdtp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 85ef94b..3985fb3 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -2180,7 +2180,8 @@ void avdtp_shutdown(struct avdtp *session)
 	for (l = session->streams; l; l = g_slist_next(l)) {
 		struct avdtp_stream *stream = l->data;
 
-		if (stream->abort_int || avdtp_abort(session, stream) == 0)
+		if (stream->abort_int ||
+					avdtp_close(session, stream, TRUE) == 0)
 			aborting = true;
 	}
 
-- 
1.8.4

