Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] obexd: Fix file_op_complete callback
Date: Mon, 17 Jun 2013 14:10:54 +0200
Message-Id: <1371471055-25591-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1371471055-25591-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1371471055-25591-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The file_op_complete callback added for the OBEX session command queuing
is called with a file_data parameter and not with a pending_request.

This fixes a crash when calling one of the file commands (like delete).

  0  0x0000000000438cd6 in file_op_complete (session=0x6a9d30,
       transfer=0x0,
     err=0x0, user_data=0x6762e0) at obexd/client/session.c:1054
  1  0x0000000000438c64 in async_cb (obex=0x6aa980, err=0x0,
       rsp=0x67a710,
     user_data=0x6ac2c0) at obexd/client/session.c:1035
  2  0x000000000041cbcc in handle_response (obex=0x6aa980, err=0x0,
     rsp=0x67a710) at gobex/gobex.c:949
  3  0x000000000041d49f in incoming_data (io=0x67d0f0, cond=G_IO_IN,
     user_data=0x6aa980) at gobex/gobex.c:1192
  4  0x00007ffff702de46 in g_main_context_dispatch ()
     from /usr/lib/libglib-2.0.so.0
  5  0x00007ffff702e198 in ?? () from /usr/lib/libglib-2.0.so.0
  6  0x00007ffff702e59a in g_main_loop_run () from
       /usr/lib/libglib-2.0.so.0
  7  0x00000000004309f0 in main (argc=1, argv=0x7fffffffddc8)
     at obexd/src/main.c:319
---
 obexd/client/session.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index a780b8c..558b9f8 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -1057,8 +1057,7 @@ static void file_op_complete(struct obc_session *session,
 						struct obc_transfer *transfer,
 						GError *err, void *user_data)
 {
-	struct pending_request *p = user_data;
-	struct file_data *data = p->data;
+	struct file_data *data = user_data;
 
 	if (data->func)
 		data->func(session, NULL, err, data->user_data);
-- 
1.8.2.3

