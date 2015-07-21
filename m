Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] obexd: Fix possible crash while processing pending request
Date: Tue, 21 Jul 2015 15:05:45 +0300
Message-Id: <1437480345-18329-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

session_process_queue needs to be able to access the request .func in
case an error happen and it later calls pending_request_free so .process
shall not attempt to free the request otherwise it will cause crashes:

Invalid read of size 8
   at 0x4349D2: session_process_queue (session.c:857)
   by 0x434AC5: setpath_complete.isra.1 (session.c:1026)
   by 0x434B29: setpath_cb (session.c:1077)
   by 0x416448: handle_response (gobex.c:1128)
   by 0x41739D: incoming_data (gobex.c:1402)
   by 0x59747FA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x5974B97: ??? (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x5974EC1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x40E23F: main (main.c:322)
 Address 0x66e3d30 is 32 bytes inside a block of size 56 free'd
   at 0x4C2ACE9: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x597A50E: g_free (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4345F5: pending_request_free (session.c:193)
   by 0x4348DF: session_process_setpath (session.c:1131)
   by 0x4349C9: session_process_queue (session.c:854)
   by 0x434AC5: setpath_complete.isra.1 (session.c:1026)
   by 0x434B29: setpath_cb (session.c:1077)
   by 0x416448: handle_response (gobex.c:1128)
   by 0x41739D: incoming_data (gobex.c:1402)
   by 0x59747FA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x5974B97: ??? (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x5974EC1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.2)
---
 obexd/client/session.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 39c82e6..d6da0a7 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -1121,15 +1121,11 @@ static int session_process_setpath(struct pending_request *p, GError **err)
 
 	p->req_id = g_obex_setpath(p->session->obex, first, setpath_cb, p, err);
 	if (*err != NULL)
-		goto fail;
+		return (*err)->code;
 
 	p->session->p = p;
 
 	return 0;
-
-fail:
-	pending_request_free(p);
-	return (*err)->code;
 }
 
 guint obc_session_setpath(struct obc_session *session, const char *path,
@@ -1213,15 +1209,11 @@ static int session_process_mkdir(struct pending_request *p, GError **err)
 	p->req_id = g_obex_mkdir(p->session->obex, req->srcname, async_cb, p,
 									err);
 	if (*err != NULL)
-		goto fail;
+		return (*err)->code;
 
 	p->session->p = p;
 
 	return 0;
-
-fail:
-	pending_request_free(p);
-	return (*err)->code;
 }
 
 guint obc_session_mkdir(struct obc_session *session, const char *folder,
@@ -1255,15 +1247,11 @@ static int session_process_copy(struct pending_request *p, GError **err)
 	p->req_id = g_obex_copy(p->session->obex, req->srcname, req->destname,
 							async_cb, p, err);
 	if (*err != NULL)
-		goto fail;
+		return (*err)->code;
 
 	p->session->p = p;
 
 	return 0;
-
-fail:
-	pending_request_free(p);
-	return (*err)->code;
 }
 
 guint obc_session_copy(struct obc_session *session, const char *srcname,
@@ -1298,15 +1286,11 @@ static int session_process_move(struct pending_request *p, GError **err)
 	p->req_id = g_obex_move(p->session->obex, req->srcname, req->destname,
 							async_cb, p, err);
 	if (*err != NULL)
-		goto fail;
+		return (*err)->code;
 
 	p->session->p = p;
 
 	return 0;
-
-fail:
-	pending_request_free(p);
-	return (*err)->code;
 }
 
 guint obc_session_move(struct obc_session *session, const char *srcname,
@@ -1341,15 +1325,11 @@ static int session_process_delete(struct pending_request *p, GError **err)
 	p->req_id = g_obex_delete(p->session->obex, req->srcname, async_cb, p,
 									err);
 	if (*err != NULL)
-		goto fail;
+		return (*err)->code;
 
 	p->session->p = p;
 
 	return 0;
-
-fail:
-	pending_request_free(p);
-	return (*err)->code;
 }
 
 guint obc_session_delete(struct obc_session *session, const char *file,
-- 
2.1.0

