Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: mcchou@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, josephsih@chromium.org,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH 1/2] gobex: Fix a compilation error for the compatibility with LLVM
Date: Fri,  2 Dec 2016 18:06:12 -0800
Message-Id: <1480730772-41236-1-git-send-email-mcchou@chromium.org>
In-Reply-To: <CABBYNZJ25XQswsT6s-Qrhv_X09z9Np4dZ9Fa0P1_kQDAumOifA@mail.gmail.com>
References: <CABBYNZJ25XQswsT6s-Qrhv_X09z9Np4dZ9Fa0P1_kQDAumOifA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Miao-chen Chou <mcchou@chromium.org>

The C Standard, subclause 7.16.1.4, paragraph 4 [ISO/IEC 9899:2011], states:
The parameter parmN is the identifier of the rightmost parameter in
the variable parameter list in the function definition (the one just
before the ...). If the parameter parmN is declared with the register
storage class, with a function or array type, or with a type that is
not compatible with the type that results after application of the
default argument promotions, the behavior is undefined.
---
 gobex/gobex-packet.c   |  4 ++--
 gobex/gobex-packet.h   |  4 ++--
 gobex/gobex-transfer.c |  8 ++++----
 gobex/gobex.c          |  4 ++--
 gobex/gobex.h          | 12 ++++++------
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/gobex/gobex-packet.c b/gobex/gobex-packet.c
index db56ed0..cd5c131 100644
--- a/gobex/gobex-packet.c
+++ b/gobex/gobex-packet.c
@@ -228,7 +228,7 @@ gboolean g_obex_packet_set_data(GObexPacket *pkt, const void *data, gsize len,
 }

 GObexPacket *g_obex_packet_new_valist(guint8 opcode, gboolean final,
-					guint8 first_hdr_id, va_list args)
+					guint first_hdr_id, va_list args)
 {
 	GObexPacket *pkt;

@@ -246,7 +246,7 @@ GObexPacket *g_obex_packet_new_valist(guint8 opcode, gboolean final,
 }

 GObexPacket *g_obex_packet_new(guint8 opcode, gboolean final,
-						guint8 first_hdr_id, ...)
+						guint first_hdr_id, ...)
 {
 	GObexPacket *pkt;
 	va_list args;
diff --git a/gobex/gobex-packet.h b/gobex/gobex-packet.h
index d1007ea..1d94ccf 100644
--- a/gobex/gobex-packet.h
+++ b/gobex/gobex-packet.h
@@ -98,9 +98,9 @@ gboolean g_obex_packet_set_data(GObexPacket *pkt, const void *data, gsize len,
 						GObexDataPolicy data_policy);
 const void *g_obex_packet_get_data(GObexPacket *pkt, gsize *len);
 GObexPacket *g_obex_packet_new(guint8 opcode, gboolean final,
-						guint8 first_hdr_id, ...);
+						guint first_hdr_id, ...);
 GObexPacket *g_obex_packet_new_valist(guint8 opcode, gboolean final,
-					guint8 first_hdr_id, va_list args);
+					guint first_hdr_id, va_list args);
 void g_obex_packet_free(GObexPacket *pkt);

 GObexPacket *g_obex_packet_decode(const void *data, gsize len,
diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index a5115bf..bc99306 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -296,7 +296,7 @@ guint g_obex_put_req_pkt(GObex *obex, GObexPacket *req,

 guint g_obex_put_req(GObex *obex, GObexDataProducer data_func,
 			GObexFunc complete_func, gpointer user_data,
-			GError **err, guint8 first_hdr_id, ...)
+			GError **err, guint first_hdr_id, ...)
 {
 	GObexPacket *req;
 	va_list args;
@@ -414,7 +414,7 @@ done:
 guint g_obex_put_rsp(GObex *obex, GObexPacket *req,
 			GObexDataConsumer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err,
-			guint8 first_hdr_id, ...)
+			guint first_hdr_id, ...)
 {
 	struct transfer *transfer;
 	va_list args;
@@ -471,7 +471,7 @@ guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,

 guint g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
 			GObexFunc complete_func, gpointer user_data,
-			GError **err, guint8 first_hdr_id, ...)
+			GError **err, guint first_hdr_id, ...)
 {
 	struct transfer *transfer;
 	GObexPacket *req;
@@ -617,7 +617,7 @@ guint g_obex_get_rsp_pkt(GObex *obex, GObexPacket *rsp,

 guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 			GObexFunc complete_func, gpointer user_data,
-			GError **err, guint8 first_hdr_id, ...)
+			GError **err, guint first_hdr_id, ...)
 {
 	GObexPacket *rsp;
 	va_list args;
diff --git a/gobex/gobex.c b/gobex/gobex.c
index 42175fc..0e5817e 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -853,7 +853,7 @@ immediate_completion:
 }

 gboolean g_obex_send_rsp(GObex *obex, guint8 rspcode, GError **err,
-						guint8 first_hdr_type, ...)
+						guint first_hdr_type, ...)
 {
 	GObexPacket *rsp;
 	va_list args;
@@ -1549,7 +1549,7 @@ void g_obex_unref(GObex *obex)
 /* Higher level functions */

 guint g_obex_connect(GObex *obex, GObexResponseFunc func, gpointer user_data,
-					GError **err, guint8 first_hdr_id, ...)
+					GError **err, guint first_hdr_id, ...)
 {
 	GObexPacket *req;
 	struct connect_data data;
diff --git a/gobex/gobex.h b/gobex/gobex.h
index 5bc9103..b223a2f 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -51,7 +51,7 @@ gboolean g_obex_cancel_req(GObex *obex, guint req_id,
 						gboolean remove_callback);

 gboolean g_obex_send_rsp(GObex *obex, guint8 rspcode, GError **err,
-						guint8 first_hdr_type, ...);
+						guint first_hdr_type, ...);

 void g_obex_set_disconnect_function(GObex *obex, GObexFunc func,
 							gpointer user_data);
@@ -73,7 +73,7 @@ void g_obex_unref(GObex *obex);
 /* High level client functions */

 guint g_obex_connect(GObex *obex, GObexResponseFunc func, gpointer user_data,
-				GError **err, guint8 first_hdr_id, ...);
+				GError **err, guint first_hdr_id, ...);

 guint g_obex_disconnect(GObex *obex, GObexResponseFunc func, gpointer user_data,
 								GError **err);
@@ -102,7 +102,7 @@ guint g_obex_abort(GObex *obex, GObexResponseFunc func, gpointer user_data,

 guint g_obex_put_req(GObex *obex, GObexDataProducer data_func,
 			GObexFunc complete_func, gpointer user_data,
-			GError **err, guint8 first_hdr_id, ...);
+			GError **err, guint first_hdr_id, ...);

 guint g_obex_put_req_pkt(GObex *obex, GObexPacket *req,
 			GObexDataProducer data_func, GObexFunc complete_func,
@@ -110,7 +110,7 @@ guint g_obex_put_req_pkt(GObex *obex, GObexPacket *req,

 guint g_obex_get_req(GObex *obex, GObexDataConsumer data_func,
 			GObexFunc complete_func, gpointer user_data,
-			GError **err, guint8 first_hdr_id, ...);
+			GError **err, guint first_hdr_id, ...);

 guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
 			GObexDataConsumer data_func, GObexFunc complete_func,
@@ -119,11 +119,11 @@ guint g_obex_get_req_pkt(GObex *obex, GObexPacket *req,
 guint g_obex_put_rsp(GObex *obex, GObexPacket *req,
 			GObexDataConsumer data_func, GObexFunc complete_func,
 			gpointer user_data, GError **err,
-			guint8 first_hdr_id, ...);
+			guint first_hdr_id, ...);

 guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 			GObexFunc complete_func, gpointer user_data,
-			GError **err, guint8 first_hdr_id, ...);
+			GError **err, guint first_hdr_id, ...);

 guint g_obex_get_rsp_pkt(GObex *obex, GObexPacket *rsp,
 			GObexDataProducer data_func, GObexFunc complete_func,
--
2.8.0.rc3.226.g39d4020

