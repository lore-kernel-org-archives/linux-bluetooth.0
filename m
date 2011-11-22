Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/2] gobex: add reference count implementation to GObexPacket
Date: Tue, 22 Nov 2011 17:09:46 +0200
Message-Id: <1321974587-25047-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This allow applications to respond asyncronously to requests by holding
a reference which can be used latter.
---
 gobex/gobex-packet.c     |   40 ++++++++++++++++++++++++++++++++++++++--
 gobex/gobex-packet.h     |    6 ++++--
 gobex/gobex.c            |   27 ++++++++++++++++++++++++---
 unit/test-gobex-packet.c |   30 +++++++++++++++++-------------
 unit/test-gobex.c        |    2 +-
 5 files changed, 84 insertions(+), 21 deletions(-)

diff --git a/gobex/gobex-packet.c b/gobex/gobex-packet.c
index c3e3953..d98e7a9 100644
--- a/gobex/gobex-packet.c
+++ b/gobex/gobex-packet.c
@@ -35,9 +35,12 @@
 struct _GObexPacket {
 	guint8 opcode;
 	gboolean final;
+	gint ref_count;
 
 	GObexDataPolicy data_policy;
+	GDestroyNotify data_destroy;
 
+	const void *base;
 	union {
 		void *buf;		/* Non-header data */
 		const void *buf_ref;	/* Reference to non-header data */
@@ -241,7 +244,7 @@ GObexPacket *g_obex_packet_new_valist(guint8 opcode, gboolean final,
 								&pkt->hlen);
 	pkt->data_policy = G_OBEX_DATA_COPY;
 
-	return pkt;
+	return g_obex_packet_ref(pkt);
 }
 
 GObexPacket *g_obex_packet_new(guint8 opcode, gboolean final,
@@ -259,7 +262,7 @@ GObexPacket *g_obex_packet_new(guint8 opcode, gboolean final,
 	return pkt;
 }
 
-void g_obex_packet_free(GObexPacket *pkt)
+static void g_obex_packet_free(GObexPacket *pkt)
 {
 	g_obex_debug(G_OBEX_DEBUG_PACKET, "opcode 0x%02x", pkt->opcode);
 
@@ -272,11 +275,40 @@ void g_obex_packet_free(GObexPacket *pkt)
 		break;
 	}
 
+	if (pkt->data_destroy != NULL)
+		pkt->data_destroy((gpointer) pkt->base);
+
 	g_slist_foreach(pkt->headers, (GFunc) g_obex_header_free, NULL);
 	g_slist_free(pkt->headers);
 	g_free(pkt);
 }
 
+GObexPacket *g_obex_packet_ref(GObexPacket *pkt)
+{
+	if (pkt == NULL)
+		return NULL;
+
+	g_atomic_int_inc(&pkt->ref_count);
+
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "ref %u", pkt->ref_count);
+
+	return pkt;
+}
+
+void g_obex_packet_unref(GObexPacket *pkt)
+{
+	gboolean last_ref;
+
+	last_ref = g_atomic_int_dec_and_test(&pkt->ref_count);
+
+	g_obex_debug(G_OBEX_DEBUG_PACKET, "ref %u", pkt->ref_count);
+
+	if (!last_ref)
+		return;
+
+	g_obex_packet_free(pkt);
+}
+
 static gboolean parse_headers(GObexPacket *pkt, const void *data, gsize len,
 						GObexDataPolicy data_policy,
 						GError **err)
@@ -313,6 +345,7 @@ static const guint8 *get_bytes(void *to, const guint8 *from, gsize count)
 GObexPacket *g_obex_packet_decode(const void *data, gsize len,
 						gsize header_offset,
 						GObexDataPolicy data_policy,
+						GDestroyNotify data_destroy,
 						GError **err)
 {
 	const guint8 *buf = data;
@@ -365,6 +398,9 @@ headers:
 							data_policy, err))
 		goto failed;
 
+	pkt->base = data;
+	pkt->data_destroy = data_destroy;
+
 	return pkt;
 
 failed:
diff --git a/gobex/gobex-packet.h b/gobex/gobex-packet.h
index e4cea0b..de425e1 100644
--- a/gobex/gobex-packet.h
+++ b/gobex/gobex-packet.h
@@ -97,14 +97,16 @@ gboolean g_obex_packet_set_data(GObexPacket *pkt, const void *data, gsize len,
 						GObexDataPolicy data_policy);
 const void *g_obex_packet_get_data(GObexPacket *pkt, gsize *len);
 GObexPacket *g_obex_packet_new(guint8 opcode, gboolean final,
-						guint8 first_hdr_id, ...);
+					guint8 first_hdr_id, ...);
 GObexPacket *g_obex_packet_new_valist(guint8 opcode, gboolean final,
 					guint8 first_hdr_id, va_list args);
-void g_obex_packet_free(GObexPacket *pkt);
+GObexPacket *g_obex_packet_ref(GObexPacket *pkt);
+void g_obex_packet_unref(GObexPacket *pkt);
 
 GObexPacket *g_obex_packet_decode(const void *data, gsize len,
 						gsize header_offset,
 						GObexDataPolicy data_policy,
+						GDestroyNotify data_destroy,
 						GError **err);
 gssize g_obex_packet_encode(GObexPacket *pkt, guint8 *buf, gsize len);
 
diff --git a/gobex/gobex.c b/gobex/gobex.c
index b374b06..9b48faa 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -46,6 +46,8 @@
 
 guint gobex_debug = 0;
 
+GSList *rx_buf_list = NULL;
+
 struct _GObex {
 	gint ref_count;
 	GIOChannel *io;
@@ -159,7 +161,7 @@ static void pending_pkt_free(struct pending_pkt *p)
 	if (p->timeout_id > 0)
 		g_source_remove(p->timeout_id);
 
-	g_obex_packet_free(p->pkt);
+	g_obex_packet_unref(p->pkt);
 
 	g_free(p);
 }
@@ -839,6 +841,18 @@ fail:
 	return FALSE;
 }
 
+static void rx_buf_destroy(gpointer data)
+{
+	if (rx_buf_list == NULL)
+		return;
+
+	/* Free if another buffer was allocated */
+	if (data != g_slist_nth_data(rx_buf_list, 0))
+		g_free(data);
+
+	rx_buf_list = g_slist_remove(rx_buf_list, data);
+}
+
 static gboolean incoming_data(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -857,6 +871,10 @@ static gboolean incoming_data(GIOChannel *io, GIOCondition cond,
 		goto failed;
 	}
 
+	/* Check if current buffer is in use */
+	if (g_slist_find(rx_buf_list, obex->rx_buf) != NULL)
+		obex->rx_buf = g_malloc(obex->rx_mtu);
+
 	if (!obex->read(obex, &err))
 		goto failed;
 
@@ -887,10 +905,13 @@ static gboolean incoming_data(GIOChannel *io, GIOCondition cond,
 	}
 
 	pkt = g_obex_packet_decode(obex->rx_buf, obex->rx_data, header_offset,
-							G_OBEX_DATA_REF, &err);
+						G_OBEX_DATA_REF, rx_buf_destroy,
+						&err);
 	if (pkt == NULL)
 		goto failed;
 
+	rx_buf_list = g_slist_prepend(rx_buf_list, obex->rx_buf);
+
 	/* Protect against user callback freeing the object */
 	g_obex_ref(obex);
 
@@ -907,7 +928,7 @@ static gboolean incoming_data(GIOChannel *io, GIOCondition cond,
 		g_error_free(err);
 
 	if (pkt != NULL)
-		g_obex_packet_free(pkt);
+		g_obex_packet_unref(pkt);
 
 	return TRUE;
 
diff --git a/unit/test-gobex-packet.c b/unit/test-gobex-packet.c
index 6da974a..83362bb 100644
--- a/unit/test-gobex-packet.c
+++ b/unit/test-gobex-packet.c
@@ -58,7 +58,7 @@ static void test_pkt(void)
 
 	g_assert(pkt != NULL);
 
-	g_obex_packet_free(pkt);
+	g_obex_packet_unref(pkt);
 }
 
 static void test_decode_pkt(void)
@@ -67,10 +67,11 @@ static void test_decode_pkt(void)
 	GError *err = NULL;
 
 	pkt = g_obex_packet_decode(pkt_put, sizeof(pkt_put), 0,
-						G_OBEX_DATA_REF, &err);
+						G_OBEX_DATA_REF, NULL,
+						&err);
 	g_assert_no_error(err);
 
-	g_obex_packet_free(pkt);
+	g_obex_packet_unref(pkt);
 }
 
 static void test_decode_pkt_header(void)
@@ -82,7 +83,8 @@ static void test_decode_pkt_header(void)
 	guint8 val;
 
 	pkt = g_obex_packet_decode(pkt_put_action, sizeof(pkt_put_action),
-						0, G_OBEX_DATA_REF, &err);
+						0, G_OBEX_DATA_REF, NULL,
+						&err);
 	g_assert_no_error(err);
 
 	header = g_obex_packet_get_header(pkt, G_OBEX_HDR_ACTION);
@@ -92,7 +94,7 @@ static void test_decode_pkt_header(void)
 	g_assert(ret == TRUE);
 	g_assert(val == 0xab);
 
-	g_obex_packet_free(pkt);
+	g_obex_packet_unref(pkt);
 }
 
 static void test_decode_connect(void)
@@ -106,7 +108,8 @@ static void test_decode_connect(void)
 	gsize len;
 
 	pkt = g_obex_packet_decode(pkt_connect, sizeof(pkt_connect),
-						4, G_OBEX_DATA_REF, &err);
+						4, G_OBEX_DATA_REF, NULL,
+						&err);
 	g_assert_no_error(err);
 	g_assert(pkt != NULL);
 
@@ -117,7 +120,7 @@ static void test_decode_connect(void)
 	g_assert(ret == TRUE);
 	assert_memequal(target, sizeof(target), buf, len);
 
-	g_obex_packet_free(pkt);
+	g_obex_packet_unref(pkt);
 }
 
 static void test_decode_nval(void)
@@ -126,7 +129,7 @@ static void test_decode_nval(void)
 	GError *err = NULL;
 
 	pkt = g_obex_packet_decode(pkt_nval_len, sizeof(pkt_nval_len), 0,
-						G_OBEX_DATA_REF, &err);
+						G_OBEX_DATA_REF, NULL, &err);
 	g_assert_error(err, G_OBEX_ERROR, G_OBEX_ERROR_PARSE_ERROR);
 	g_assert(pkt == NULL);
 
@@ -141,7 +144,8 @@ static void test_decode_encode(void)
 	gssize len;
 
 	pkt = g_obex_packet_decode(pkt_put_action, sizeof(pkt_put_action),
-						0, G_OBEX_DATA_REF, &err);
+						0, G_OBEX_DATA_REF, NULL,
+						&err);
 	g_assert_no_error(err);
 
 	len = g_obex_packet_encode(pkt, buf, sizeof(buf));
@@ -152,7 +156,7 @@ static void test_decode_encode(void)
 
 	assert_memequal(pkt_put_action, sizeof(pkt_put_action), buf, len);
 
-	g_obex_packet_free(pkt);
+	g_obex_packet_unref(pkt);
 }
 
 static gssize get_body_data(void *buf, gsize len, gpointer user_data)
@@ -181,7 +185,7 @@ static void test_encode_on_demand(void)
 
 	assert_memequal(pkt_put_body, sizeof(pkt_put_body), buf, len);
 
-	g_obex_packet_free(pkt);
+	g_obex_packet_unref(pkt);
 }
 
 static gssize get_body_data_fail(void *buf, gsize len, gpointer user_data)
@@ -202,7 +206,7 @@ static void test_encode_on_demand_fail(void)
 
 	g_assert_cmpint(len, ==, -EIO);
 
-	g_obex_packet_free(pkt);
+	g_obex_packet_unref(pkt);
 }
 
 static void test_create_args(void)
@@ -226,7 +230,7 @@ static void test_create_args(void)
 
 	assert_memequal(pkt_put_long, sizeof(pkt_put_long), buf, len);
 
-	g_obex_packet_free(pkt);
+	g_obex_packet_unref(pkt);
 }
 
 int main(int argc, char *argv[])
diff --git a/unit/test-gobex.c b/unit/test-gobex.c
index cce5b98..004b17e 100644
--- a/unit/test-gobex.c
+++ b/unit/test-gobex.c
@@ -584,7 +584,7 @@ static void test_recv_unexpected(void)
 
 	req = g_obex_packet_new(G_OBEX_RSP_CONTINUE, TRUE, G_OBEX_HDR_INVALID);
 	len = g_obex_packet_encode(req, buf, sizeof(buf));
-	g_obex_packet_free(req);
+	g_obex_packet_unref(req);
 	g_assert_cmpint(len, >=, 0);
 
 	g_io_channel_write_chars(io, (gchar *) buf, len, NULL, &err);
-- 
1.7.7.3

