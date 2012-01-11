Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/3] Fix not responding when driver_get_headers return 0
Date: Wed, 11 Jan 2012 15:22:01 +0200
Message-Id: <1326288123-31807-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When calling driver_get_headers it may not be ready but after the backend
respond the result can still be 0 which indicades no headers need to
added and we can start sending the body.
---
 src/obex.c |   40 ++++++++++++++++++----------------------
 1 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 6307eaa..eb91f4c 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -643,16 +643,26 @@ static gssize driver_get_headers(struct obex_session *os)
 		total += len;
 	}
 
-	if (total == 0) {
-		g_obex_packet_free(rsp);
-		return 0;
+	if (total != 0) {
+		g_obex_send(os->obex, rsp, NULL);
+		os->get_rsp = g_obex_add_request_function(os->obex,
+							G_OBEX_OP_GET,
+							cmd_get_rsp, os);
+		goto done;
 	}
 
-	g_obex_send(os->obex, rsp, NULL);
-
-	os->get_rsp = g_obex_add_request_function(os->obex, G_OBEX_OP_GET,
-							cmd_get_rsp, os);
+	g_obex_packet_free(rsp);
+	if (os->size != OBJECT_SIZE_UNKNOWN && os->size < UINT32_MAX)
+		g_obex_get_rsp(os->obex, send_data, transfer_complete,
+						os, NULL,
+						G_OBEX_HDR_LENGTH, os->size,
+						G_OBEX_HDR_INVALID);
+	else
+		g_obex_get_rsp(os->obex, send_data, transfer_complete,
+						os, NULL,
+						G_OBEX_HDR_INVALID);
 
+done:
 	os->headers_sent = TRUE;
 
 	print_event(-1, G_OBEX_RSP_CONTINUE);
@@ -887,22 +897,8 @@ int obex_get_stream_start(struct obex_session *os, const char *filename)
 		g_obex_suspend(os->obex);
 		os->driver->set_io_watch(os->object, handle_async_io, os);
 		return 0;
-	} else if (err < 0) {
+	} else if (err < 0)
 		return err;
-	} else if (err > 0)
-		return 0;
-
-	if (os->size != OBJECT_SIZE_UNKNOWN && os->size < UINT32_MAX)
-		g_obex_get_rsp(os->obex, send_data, transfer_complete,
-						os, NULL,
-						G_OBEX_HDR_LENGTH, os->size,
-						G_OBEX_HDR_INVALID);
-	else
-		g_obex_get_rsp(os->obex, send_data, transfer_complete,
-						os, NULL,
-						G_OBEX_HDR_INVALID);
-
-	print_event(G_OBEX_OP_GET, G_OBEX_RSP_SUCCESS);
 
 	return 0;
 }
-- 
1.7.7.5

