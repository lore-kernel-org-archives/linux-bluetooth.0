Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 02/16] gobex: Get rid of gint
Date: Wed,  1 May 2013 02:11:57 -0300
Message-Id: <1367385131-24034-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int, so it's safe to use it even for callbacks with glib.
---
 gobex/gobex.c | 14 +++++++-------
 gobex/gobex.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 6badfeb..deeab40 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -55,7 +55,7 @@ struct srm_config {
 };
 
 struct _GObex {
-	gint ref_count;
+	int ref_count;
 	GIOChannel *io;
 	guint io_source;
 
@@ -623,7 +623,7 @@ static void prepare_srm_req(GObex *obex, GObexPacket *pkt)
 	g_obex_packet_prepend_header(pkt, hdr);
 }
 
-guint g_obex_send_req(GObex *obex, GObexPacket *req, gint timeout,
+guint g_obex_send_req(GObex *obex, GObexPacket *req, int timeout,
 			GObexResponseFunc func, gpointer user_data,
 			GError **err)
 {
@@ -677,7 +677,7 @@ create_pending:
 	return p->id;
 }
 
-static gint pending_pkt_cmp(gconstpointer a, gconstpointer b)
+static int pending_pkt_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct pending_pkt *p = a;
 	guint id = GPOINTER_TO_UINT(b);
@@ -782,20 +782,20 @@ void g_obex_set_disconnect_function(GObex *obex, GObexFunc func,
 	obex->disconn_func_data = user_data;
 }
 
-static gint req_handler_cmpop(gconstpointer a, gconstpointer b)
+static int req_handler_cmpop(gconstpointer a, gconstpointer b)
 {
 	const struct req_handler *handler = a;
 	guint opcode = GPOINTER_TO_UINT(b);
 
-	return (gint) handler->opcode - (gint) opcode;
+	return (int) handler->opcode - (int) opcode;
 }
 
-static gint req_handler_cmpid(gconstpointer a, gconstpointer b)
+static int req_handler_cmpid(gconstpointer a, gconstpointer b)
 {
 	const struct req_handler *handler = a;
 	guint id = GPOINTER_TO_UINT(b);
 
-	return (gint) handler->id - (gint) id;
+	return (int) handler->id - (int) id;
 }
 
 guint g_obex_add_request_function(GObex *obex, guint8 opcode,
diff --git a/gobex/gobex.h b/gobex/gobex.h
index c42c42c..3ac7b13 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -44,7 +44,7 @@ typedef void (*GObexResponseFunc) (GObex *obex, GError *err, GObexPacket *rsp,
 
 gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err);
 
-guint g_obex_send_req(GObex *obex, GObexPacket *req, gint timeout,
+guint g_obex_send_req(GObex *obex, GObexPacket *req, int timeout,
 			GObexResponseFunc func, gpointer user_data,
 			GError **err);
 gboolean g_obex_cancel_req(GObex *obex, guint req_id,
-- 
1.8.2.2

