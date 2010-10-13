Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Fix suspend stream on opening if no data
Date: Wed, 13 Oct 2010 15:20:56 +0300
Message-Id: <1286972456-6168-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1286972456-6168-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1286972456-6168-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix write to stream and suspend it immidiately if there is no data
available.
---
 src/obex.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index c7d0753..71bcba8 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -813,10 +813,22 @@ static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 		os->obj = obj;
 		os->driver->set_io_watch(os->object, handle_async_io, os);
 		return;
-	} else
+	} else {
 		/* Standard data stream */
 		OBEX_ObjectAddHeader (obex, obj, OBEX_HDR_BODY,
 				hd, 0, OBEX_FL_STREAM_START);
+		
+		/* Try to write to stream and suspend the stream immidiately
+		 * if no data available to send. */
+		err = obex_write_stream(os, obex, obj);
+		if (err == -EAGAIN) {
+			OBEX_SuspendRequest(obex, obj);
+			os->obj = obj;
+			os->driver->set_io_watch(os->object, handle_async_io,
+									os);
+			return;
+		}
+	}
 
 done:
 	os_set_response(obj, err);
-- 
1.7.0.4

