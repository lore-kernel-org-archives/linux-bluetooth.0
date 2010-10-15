Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/2] Code cleanup: unnecessary operation and typo removed
Date: Fri, 15 Oct 2010 09:57:08 +0300
Message-Id: <1287125828-5479-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1287125828-5479-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1287125828-5479-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Code cleanup: unnecessary operation 'return len;' removed and typo in
comments immidiately to immediately corrected.
---
 src/obex.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 4e1db9c..adfcc95 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -678,7 +678,6 @@ add_header:
 	if (len == 0) {
 		g_free(os->buf);
 		os->buf = NULL;
-		return len;
 	}
 
 	os->offset += len;
@@ -818,7 +817,7 @@ static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 		OBEX_ObjectAddHeader (obex, obj, OBEX_HDR_BODY,
 				hd, 0, OBEX_FL_STREAM_START);
 
-		/* Try to write to stream and suspend the stream immidiately
+		/* Try to write to stream and suspend the stream immediately
 		 * if no data available to send. */
 		err = obex_write_stream(os, obex, obj);
 		if (err == -EAGAIN) {
-- 
1.7.0.4

