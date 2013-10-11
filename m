Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] obexd/session: Fix crash when transport is disconnected
Date: Fri, 11 Oct 2013 14:42:42 +0300
Message-Id: <1381491762-25395-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1381491762-25395-1-git-send-email-luiz.dentz@gmail.com>
References: <1381491762-25395-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When transport is disconnected unexpectedly it can cause the following
crash:
gobex-DEBUG: gobex/gobex.c:g_obex_send_internal() The transport is not connected
Invalid read of size 8
   at 0x42662E: session_process_queue (session.c:789)
   by 0x42668F: session_process (session.c:719)
   by 0x3D46047E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x3D46048157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x3D46048559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x40D5FC: main (main.c:319)
 Address 0x5086760 is 32 bytes inside a block of size 56 free'd
   at 0x4A074C4: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x3D4604D9AE: g_free (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x426146: session_process_setpath (session.c:1063)
   by 0x426629: session_process_queue (session.c:786)
   by 0x42668F: session_process (session.c:719)
   by 0x3D46047E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x3D46048157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x3D46048559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x40D5FC: main (main.c:319)
---
 obexd/client/session.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 67c2b83..8138b1e 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -296,6 +296,16 @@ done:
 	g_free(callback);
 }
 
+static void session_disconnected(GObex *obex, GError *err, gpointer user_data)
+{
+	struct obc_session *session = user_data;
+
+	if (err)
+		error("%s", err->message);
+
+	obc_session_shutdown(session);
+}
+
 static void transport_func(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct callback_data *callback = user_data;
@@ -345,6 +355,8 @@ static void transport_func(GIOChannel *io, GError *err, gpointer user_data)
 	session->obex = obex;
 	sessions = g_slist_prepend(sessions, session);
 
+	g_obex_set_disconnect_function(obex, session_disconnected, session);
+
 	return;
 done:
 	callback->func(callback->session, NULL, err, callback->data);
-- 
1.8.3.1

