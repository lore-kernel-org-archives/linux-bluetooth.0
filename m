Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/7] obexd/client: Fix crash while disconnecting
Date: Wed, 27 Aug 2014 19:04:48 +0300
Message-Id: <1409155490-25653-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1409155490-25653-1-git-send-email-luiz.dentz@gmail.com>
References: <1409155490-25653-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case the transport is disconnected while disconnect command is pending
the session is freed on disconnect_complete but disconnect callback is
still valid causing the following crash:

Invalid read of size 4
   at 0x42682A: obc_session_ref (session.c:132)
   by 0x42797B: obc_session_shutdown (session.c:580)
   by 0x4139DA: incoming_data (gobex.c:1406)
   by 0x59712A5: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x5971627: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x5971A39: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x40D78C: main (main.c:320)
 Address 0x728d814 is 4 bytes inside a block of size 120 free'd
   at 0x4C28577: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x5976F7E: g_free (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x4134B9: handle_response (gobex.c:1129)
   by 0x4139BD: incoming_data (gobex.c:1403)
   by 0x59712A5: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x5971627: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x5971A39: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x40D78C: main (main.c:320)
---
 obexd/client/session.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index cb176e4..9bba6c6 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -225,8 +225,10 @@ static void session_free(struct obc_session *session)
 	if (session->watch)
 		g_dbus_remove_watch(session->conn, session->watch);
 
-	if (session->obex != NULL)
+	if (session->obex) {
+		g_obex_set_disconnect_function(session->obex, NULL, NULL);
 		g_obex_unref(session->obex);
+	}
 
 	if (session->id > 0 && session->transport != NULL)
 		session->transport->disconnect(session->id);
-- 
1.9.3

