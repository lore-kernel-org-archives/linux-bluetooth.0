Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v3 BlueZ 4/4] attrib: Remove opcode parameter from g_attrib_send()
Date: Mon, 24 Sep 2012 19:33:39 -0300
Message-Id: <1348526019-28402-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1348526019-28402-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1348526019-28402-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In all uses of g_attrib_send() the opcode of the command/event is
already clear because of the att.h functions used to build the ATT
PDU.
---
 attrib/client.c                    |  3 +-
 attrib/gatt.c                      | 56 ++++++++++++++++----------------------
 attrib/gattrib.c                   |  9 ++++--
 attrib/gattrib.h                   |  6 ++--
 attrib/gatttool.c                  |  2 +-
 attrib/interactive.c               |  2 +-
 profiles/gatt/gas.c                |  2 +-
 profiles/thermometer/thermometer.c |  3 +-
 src/attrib-server.c                |  3 +-
 9 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 2423fad..a1cc2f3 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -365,8 +365,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len,
 	case ATT_OP_HANDLE_IND:
 		opdu = g_attrib_get_buffer(gatt->attrib, &plen);
 		olen = enc_confirmation(opdu, plen);
-		g_attrib_send(gatt->attrib, 0, opdu[0], opdu, olen,
-						NULL, NULL, NULL);
+		g_attrib_send(gatt->attrib, 0, opdu, olen, NULL, NULL, NULL);
 	case ATT_OP_HANDLE_NOTIFY:
 		if (characteristic_set_value(chr, &pdu[3], len - 3) < 0)
 			DBG("Can't change Characteristic 0x%02x", handle);
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 902ac23..e6db227 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -176,8 +176,7 @@ static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
 	if (oplen == 0)
 		goto done;
 
-	g_attrib_send(dp->attrib, 0, buf[0], buf, oplen, primary_by_uuid_cb,
-								dp, NULL);
+	g_attrib_send(dp->attrib, 0, buf, oplen, primary_by_uuid_cb, dp, NULL);
 	return;
 
 done:
@@ -242,7 +241,7 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		guint16 oplen = encode_discover_primary(end + 1, 0xffff, NULL,
 								buf, buflen);
 
-		g_attrib_send(dp->attrib, 0, buf[0], buf, oplen, primary_all_cb,
+		g_attrib_send(dp->attrib, 0, buf, oplen, primary_all_cb,
 								dp, NULL);
 
 		return;
@@ -280,7 +279,7 @@ guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 	} else
 		cb = primary_all_cb;
 
-	return g_attrib_send(attrib, 0, buf[0], buf, plen, cb, dp, NULL);
+	return g_attrib_send(attrib, 0, buf, plen, cb, dp, NULL);
 }
 
 static void resolve_included_uuid_cb(uint8_t status, const uint8_t *pdu,
@@ -331,8 +330,8 @@ static guint resolve_included_uuid(struct find_included *fi,
 	resolve->fi = find_included_ref(fi);
 	resolve->included = incl;
 
-	return g_attrib_send(fi->attrib, 0, buf[0], buf, oplen,
-					resolve_included_uuid_cb, resolve, NULL);
+	return g_attrib_send(fi->attrib, 0, buf, oplen,
+				resolve_included_uuid_cb, resolve, NULL);
 }
 
 static struct gatt_included *included_from_buf(const uint8_t *buf, gsize buflen)
@@ -370,8 +369,8 @@ static guint find_included(struct find_included *fi, uint16_t start)
 
 	find_included_ref(fi);
 
-	return g_attrib_send(fi->attrib, 0, buf[0], buf, oplen,
-						find_included_cb, fi, NULL);
+	return g_attrib_send(fi->attrib, 0, buf, oplen, find_included_cb,
+								fi, NULL);
 }
 
 static void find_included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
@@ -508,8 +507,8 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		if (oplen == 0)
 			return;
 
-		g_attrib_send(dc->attrib, 0, buf[0], buf, oplen,
-						char_discovered_cb, dc, NULL);
+		g_attrib_send(dc->attrib, 0, buf, oplen, char_discovered_cb,
+								dc, NULL);
 
 		return;
 	}
@@ -547,7 +546,7 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 	dc->end = end;
 	dc->uuid = g_memdup(uuid, sizeof(bt_uuid_t));
 
-	return g_attrib_send(attrib, 0, buf[0], buf, plen, char_discovered_cb,
+	return g_attrib_send(attrib, 0, buf, plen, char_discovered_cb,
 								dc, NULL);
 }
 
@@ -563,8 +562,7 @@ guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
 	if (plen == 0)
 		return 0;
 
-	return g_attrib_send(attrib, 0, ATT_OP_READ_BY_TYPE_REQ,
-					buf, plen, func, user_data, NULL);
+	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
 }
 
 struct read_long_data {
@@ -623,8 +621,7 @@ static void read_blob_helper(guint8 status, const guint8 *rpdu, guint16 rlen,
 
 	plen = enc_read_blob_req(long_read->handle, long_read->size - 1,
 								buf, buflen);
-	id = g_attrib_send(long_read->attrib, long_read->id,
-				ATT_OP_READ_BLOB_REQ, buf, plen,
+	id = g_attrib_send(long_read->attrib, long_read->id, buf, plen,
 				read_blob_helper, long_read, read_long_destroy);
 
 	if (id != 0) {
@@ -660,9 +657,8 @@ static void read_char_helper(guint8 status, const guint8 *rpdu,
 	long_read->size = rlen;
 
 	plen = enc_read_blob_req(long_read->handle, rlen - 1, buf, buflen);
-	id = g_attrib_send(long_read->attrib, long_read->id,
-			ATT_OP_READ_BLOB_REQ, buf, plen, read_blob_helper,
-			long_read, read_long_destroy);
+	id = g_attrib_send(long_read->attrib, long_read->id, buf, plen,
+			read_blob_helper, long_read, read_long_destroy);
 
 	if (id != 0) {
 		g_atomic_int_inc(&long_read->ref);
@@ -698,12 +694,12 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, uint16_t offset,
 	if (offset > 0) {
 		plen = enc_read_blob_req(long_read->handle, offset, buf,
 									buflen);
-		id = g_attrib_send(attrib, 0, ATT_OP_READ_BLOB_REQ, buf, plen,
-				read_blob_helper, long_read, read_long_destroy);
+		id = g_attrib_send(attrib, 0, buf, plen, read_blob_helper,
+						long_read, read_long_destroy);
 	} else {
 		plen = enc_read_req(handle, buf, buflen);
-		id = g_attrib_send(attrib, 0, ATT_OP_READ_REQ, buf, plen,
-				read_char_helper, long_read, read_long_destroy);
+		id = g_attrib_send(attrib, 0, buf, plen, read_char_helper,
+						long_read, read_long_destroy);
 	}
 
 	if (id == 0)
@@ -738,8 +734,7 @@ static guint execute_write(GAttrib *attrib, uint8_t flags,
 	if (plen == 0)
 		return 0;
 
-	return g_attrib_send(attrib, 0, buf[0], buf, plen, func, user_data,
-									NULL);
+	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
 }
 
 static guint prepare_write(GAttrib *attrib, uint16_t handle, uint16_t offset,
@@ -788,7 +783,7 @@ static guint prepare_write(GAttrib *attrib, uint16_t handle, uint16_t offset,
 	if (plen == 0)
 		return 0;
 
-	return g_attrib_send(attrib, 0, buf[0], buf, plen, prepare_write_cb,
+	return g_attrib_send(attrib, 0, buf, plen, prepare_write_cb,
 							user_data, NULL);
 }
 
@@ -812,7 +807,7 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 			plen = enc_write_cmd(handle, value, vlen, buf,
 								buflen);
 
-		return g_attrib_send(attrib, 0, buf[0], buf, plen, func,
+		return g_attrib_send(attrib, 0, buf, plen, func,
 							user_data, NULL);
 	}
 
@@ -841,8 +836,7 @@ guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu, GAttribResultFunc func,
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
 	plen = enc_mtu_req(mtu, buf, buflen);
-	return g_attrib_send(attrib, 0, ATT_OP_MTU_REQ, buf, plen, func,
-							user_data, NULL);
+	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
 }
 
 guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
@@ -857,8 +851,7 @@ guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
 	if (plen == 0)
 		return 0;
 
-	return g_attrib_send(attrib, 0, ATT_OP_FIND_INFO_REQ, buf, plen, func,
-							user_data, NULL);
+	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
 }
 
 guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
@@ -870,8 +863,7 @@ guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
 	plen = enc_write_cmd(handle, value, vlen, buf, buflen);
-	return g_attrib_send(attrib, 0, ATT_OP_WRITE_CMD, buf, plen, NULL,
-							user_data, notify);
+	return g_attrib_send(attrib, 0, buf, plen, NULL, user_data, notify);
 }
 
 static sdp_data_t *proto_seq_find(sdp_list_t *proto_list)
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 108d1d3..6f6942f 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -472,12 +472,13 @@ GAttrib *g_attrib_new(GIOChannel *io)
 	return g_attrib_ref(attrib);
 }
 
-guint g_attrib_send(GAttrib *attrib, guint id, guint8 opcode,
-			const guint8 *pdu, guint16 len, GAttribResultFunc func,
-			gpointer user_data, GDestroyNotify notify)
+guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
+			GAttribResultFunc func, gpointer user_data,
+			GDestroyNotify notify)
 {
 	struct command *c;
 	GQueue *queue;
+	uint8_t opcode;
 
 	if (attrib->stale)
 		return 0;
@@ -486,6 +487,8 @@ guint g_attrib_send(GAttrib *attrib, guint id, guint8 opcode,
 	if (c == NULL)
 		return 0;
 
+	opcode = pdu[0];
+
 	c->opcode = opcode;
 	c->expected = opcode2expected(opcode);
 	c->pdu = g_malloc(len);
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index bcff039..bca966f 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -50,9 +50,9 @@ GIOChannel *g_attrib_get_channel(GAttrib *attrib);
 gboolean g_attrib_set_destroy_function(GAttrib *attrib,
 		GDestroyNotify destroy, gpointer user_data);
 
-guint g_attrib_send(GAttrib *attrib, guint id, guint8 opcode,
-			const guint8 *pdu, guint16 len, GAttribResultFunc func,
-			gpointer user_data, GDestroyNotify notify);
+guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
+			GAttribResultFunc func, gpointer user_data,
+			GDestroyNotify notify);
 
 gboolean g_attrib_cancel(GAttrib *attrib, guint id);
 gboolean g_attrib_cancel_all(GAttrib *attrib);
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 416bb71..dea1fc4 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -105,7 +105,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	olen = enc_confirmation(opdu, plen);
 
 	if (olen > 0)
-		g_attrib_send(attrib, 0, opdu[0], opdu, olen, NULL, NULL, NULL);
+		g_attrib_send(attrib, 0, opdu, olen, NULL, NULL, NULL);
 }
 
 static gboolean listen_start(gpointer user_data)
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 9f1192e..1b0b9cf 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -135,7 +135,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	olen = enc_confirmation(opdu, plen);
 
 	if (olen > 0)
-		g_attrib_send(attrib, 0, opdu[0], opdu, olen, NULL, NULL, NULL);
+		g_attrib_send(attrib, 0, opdu, olen, NULL, NULL, NULL);
 }
 
 static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 28d7fbf..4d8797e 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -150,7 +150,7 @@ static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	/* Confirming indication received */
 	opdu = g_attrib_get_buffer(gas->attrib, &plen);
 	olen = enc_confirmation(opdu, plen);
-	g_attrib_send(gas->attrib, 0, opdu[0], opdu, olen, NULL, NULL, NULL);
+	g_attrib_send(gas->attrib, 0, opdu, olen, NULL, NULL, NULL);
 
 	if (gas->changed.start == start && gas->changed.end == end)
 		return;
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 77dcb26..e9f61b1 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -1167,8 +1167,7 @@ static void ind_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	olen = enc_confirmation(opdu, plen);
 
 	if (olen > 0)
-		g_attrib_send(t->attrib, 0, opdu[0], opdu, olen, NULL, NULL,
-									NULL);
+		g_attrib_send(t->attrib, 0, opdu, olen, NULL, NULL, NULL);
 }
 
 static void notif_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 9b03e54..afe5e48 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1031,8 +1031,7 @@ done:
 		length = enc_error_resp(ipdu[0], 0x0000, status, opdu,
 								channel->mtu);
 
-	g_attrib_send(channel->attrib, 0, opdu[0], opdu, length,
-							NULL, NULL, NULL);
+	g_attrib_send(channel->attrib, 0, opdu, length, NULL, NULL, NULL);
 }
 
 guint attrib_channel_attach(GAttrib *attrib)
-- 
1.7.12.1

