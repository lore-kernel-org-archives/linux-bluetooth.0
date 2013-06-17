Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] obexd: Use correct callback in obc_session_mkdir
Date: Mon, 17 Jun 2013 14:10:55 +0200
Message-Id: <1371471055-25591-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1371471055-25591-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1371471055-25591-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The function obc_session_mkdir needs to use file_op_complete as
callback.

  0  0x00007ffff72f7553 in ?? () from /usr/lib/libdbus-1.so.3
  1  0x00007ffff72f7dff in ?? () from /usr/lib/libdbus-1.so.3
  2  0x00007ffff72fef9a in dbus_message_get_sender ()
     from /usr/lib/libdbus-1.so.3
  3  0x00007ffff72feff9 in dbus_message_new_method_return ()
     from /usr/lib/libdbus-1.so.3
  4  0x000000000043c93f in async_cb (session=0x6a9d30, transfer=0x0,
       err=0x0,
     user_data=0x675660) at obexd/client/ftp.c:65
  5  0x0000000000438c7c in async_cb (obex=0x6aa980, err=0x0,
       rsp=0x67a690,
     user_data=0x67ced0) at obexd/client/session.c:1035
  6  0x000000000041cbcc in handle_response (obex=0x6aa980, err=0x0,
     rsp=0x67a690) at gobex/gobex.c:949
  7  0x000000000041d49f in incoming_data (io=0x67d0f0, cond=G_IO_IN,
     user_data=0x6aa980) at gobex/gobex.c:1192
  8  0x00007ffff702de46 in g_main_context_dispatch ()
     from /usr/lib/libglib-2.0.so.0
  9  0x00007ffff702e198 in ?? () from /usr/lib/libglib-2.0.so.0
  10 0x00007ffff702e59a in g_main_loop_run () from
       /usr/lib/libglib-2.0.so.0
  11 0x0000000000430a09 in main (argc=1, argv=0x7fffffffddc8)
     at obexd/src/main.c:319
---
 obexd/client/session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 558b9f8..12a4997 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -1100,7 +1100,7 @@ guint obc_session_mkdir(struct obc_session *session, const char *folder,
 	data->user_data = user_data;
 
 	p = pending_request_new(session, session_process_mkdir, NULL,
-						func, data, file_data_free);
+					file_op_complete, data, file_data_free);
 	session_queue(p);
 	return p->id;
 }
-- 
1.8.2.3

