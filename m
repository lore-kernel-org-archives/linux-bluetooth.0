Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd 2/2] obex: Reset obex session in transfer_complete()
Date: Wed, 11 Jan 2012 20:34:08 +0530
Message-id: <1326294248-21268-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix solves the following issues in multiple file push.
Agent authorize is happening only for first file.
Transfer_completed signal is getting called only after last push
Incorrect value is sent for "total" and "transfered" signal from
second file onwards.
---
 src/obex.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index baa5904..5b580d3 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -265,6 +265,7 @@ static void os_reset_session(struct obex_session *os)
 	os->offset = 0;
 	os->size = OBJECT_SIZE_DELETE;
 	os->headers_sent = FALSE;
+	os->checked = FALSE;
 }
 
 static void obex_session_free(struct obex_session *os)
@@ -562,7 +563,7 @@ static void transfer_complete(GObex *obex, GError *err, gpointer user_data)
 
 	if (err != NULL) {
 		error("transfer failed: %s\n", err->message);
-		return;
+		goto reset;
 	}
 
 	if (os->object && os->driver && os->driver->flush) {
@@ -570,8 +571,12 @@ static void transfer_complete(GObex *obex, GError *err, gpointer user_data)
 			g_obex_suspend(os->obex);
 			os->driver->set_io_watch(os->object, handle_async_io,
 									os);
+			return;
 		}
 	}
+
+reset:
+	os_reset_session(os);
 }
 
 static int driver_get_headers(struct obex_session *os)
-- 
1.7.1

