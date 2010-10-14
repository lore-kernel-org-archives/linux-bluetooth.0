Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/2] Code cleanup: immidiately to immediately in comments
Date: Thu, 14 Oct 2010 15:35:30 +0300
Message-Id: <1287059730-10988-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1287059730-10988-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1287059730-10988-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/obex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 4e1db9c..5f6ad47 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -818,7 +818,7 @@ static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 		OBEX_ObjectAddHeader (obex, obj, OBEX_HDR_BODY,
 				hd, 0, OBEX_FL_STREAM_START);
 
-		/* Try to write to stream and suspend the stream immidiately
+		/* Try to write to stream and suspend the stream immediately
 		 * if no data available to send. */
 		err = obex_write_stream(os, obex, obj);
 		if (err == -EAGAIN) {
-- 
1.7.0.4

