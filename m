Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 2/5] shared/att: Add ext_signed flag to be able to use external crypto
Date: Mon, 11 May 2015 14:49:45 +0200
Message-Id: <1431348588-3974-2-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1431348588-3974-1-git-send-email-mariusz.skamra@tieto.com>
References: <1431348588-3974-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Due to the issues with CSRK tests ext_signed flag has been added to
allow android/gatt handle signed write operations.

This patch fixes following tests:
GAP__TC_SEC_CSIGN_BV_02_C
GAP__TC_SEC_CSIGN_BI_01_C
GAP__TC_SEC_CSIGN_BI_02_C
GAP__TC_SEC_CSIGN_BI_03_C
GAP__TC_SEC_CSIGN_BI_04_C
SM__TC_SIGN_BV_03_C
---
 android/gatt.c        |  2 +-
 attrib/gattrib.c      |  4 ++--
 attrib/gattrib.h      |  2 +-
 attrib/gatttool.c     |  2 +-
 attrib/interactive.c  |  2 +-
 peripheral/gatt.c     |  2 +-
 src/device.c          |  2 +-
 src/shared/att.c      | 10 ++++++----
 src/shared/att.h      |  2 +-
 tools/btgatt-client.c |  2 +-
 tools/btgatt-server.c |  2 +-
 unit/test-gatt.c      |  2 +-
 unit/test-gattrib.c   |  2 +-
 unit/test-hog.c       |  2 +-
 14 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4da959f..1f131e8 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1564,7 +1564,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	if (cid == ATT_CID)
 		mtu = ATT_DEFAULT_LE_MTU;
 
-	attrib = g_attrib_new(io, mtu);
+	attrib = g_attrib_new(io, mtu, true);
 	if (!attrib) {
 		error("gatt: unable to create new GAttrib instance");
 		device_set_state(dev, DEVICE_DISCONNECTED);
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 2011359..2e1e39a 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -95,7 +95,7 @@ static struct id_pair *store_id(GAttrib *attrib, unsigned int org_id,
 	return NULL;
 }
 
-GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu)
+GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu, bool ext_signed)
 {
 	gint fd;
 	GAttrib *attr;
@@ -111,7 +111,7 @@ GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu)
 	g_io_channel_ref(io);
 	attr->io = io;
 
-	attr->att = bt_att_new(fd);
+	attr->att = bt_att_new(fd, ext_signed);
 	if (!attr->att)
 		goto fail;
 
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 374bac2..611f952 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -42,7 +42,7 @@ typedef void (*GAttribDebugFunc)(const char *str, gpointer user_data);
 typedef void (*GAttribNotifyFunc)(const guint8 *pdu, guint16 len,
 							gpointer user_data);
 
-GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu);
+GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu, bool ext_signed);
 GAttrib *g_attrib_ref(GAttrib *attrib);
 void g_attrib_unref(GAttrib *attrib);
 
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 1a40c94..95bd20a 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -148,7 +148,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	if (cid == ATT_CID)
 		mtu = ATT_DEFAULT_LE_MTU;
 
-	attrib = g_attrib_new(io, mtu);
+	attrib = g_attrib_new(io, mtu, false);
 
 	if (opt_listen)
 		g_idle_add(listen_start, attrib);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 451be23..7d4786a 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -174,7 +174,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	if (cid == ATT_CID)
 		mtu = ATT_DEFAULT_LE_MTU;
 
-	attrib = g_attrib_new(iochannel, mtu);
+	attrib = g_attrib_new(iochannel, mtu, false);
 	g_attrib_register(attrib, ATT_OP_HANDLE_NOTIFY, GATTRIB_ALL_HANDLES,
 						events_handler, attrib, NULL);
 	g_attrib_register(attrib, ATT_OP_HANDLE_IND, GATTRIB_ALL_HANDLES,
diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index 8df62a6..554124e 100644
--- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -116,7 +116,7 @@ static struct gatt_conn *gatt_conn_new(int fd)
 	if (!conn)
 		return NULL;
 
-	conn->att = bt_att_new(fd);
+	conn->att = bt_att_new(fd, false);
 	if (!conn->att) {
 		fprintf(stderr, "Failed to initialze ATT transport layer\n");
 		free(conn);
diff --git a/src/device.c b/src/device.c
index 8b678a9..88440d9 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4272,7 +4272,7 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 	}
 
 	dev->att_mtu = MIN(mtu, BT_ATT_MAX_LE_MTU);
-	attrib = g_attrib_new(io, dev->att_mtu);
+	attrib = g_attrib_new(io, dev->att_mtu, false);
 	if (!attrib) {
 		error("Unable to create new GAttrib instance");
 		return false;
diff --git a/src/shared/att.c b/src/shared/att.c
index c5eaa09..053aa47 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -82,6 +82,7 @@ struct bt_att {
 	void *debug_data;
 
 	struct bt_crypto *crypto;
+	bool ext_signed;
 
 	struct sign_info *local_sign;
 	struct sign_info *remote_sign;
@@ -732,7 +733,7 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	const struct queue_entry *entry;
 	bool found;
 
-	if (opcode & ATT_OP_SIGNED_MASK) {
+	if (opcode & ATT_OP_SIGNED_MASK & !att->ext_signed) {
 		if (!handle_signed(att, opcode, pdu, pdu_len))
 			return;
 		pdu_len -= BT_ATT_SIGNATURE_LEN;
@@ -900,7 +901,7 @@ static void bt_att_free(struct bt_att *att)
 	free(att);
 }
 
-struct bt_att *bt_att_new(int fd)
+struct bt_att *bt_att_new(int fd, bool ext_signed)
 {
 	struct bt_att *att;
 
@@ -912,7 +913,7 @@ struct bt_att *bt_att_new(int fd)
 		return NULL;
 
 	att->fd = fd;
-
+	att->ext_signed = ext_signed;
 	att->mtu = BT_ATT_DEFAULT_LE_MTU;
 	att->buf = malloc(att->mtu);
 	if (!att->buf)
@@ -923,7 +924,8 @@ struct bt_att *bt_att_new(int fd)
 		goto fail;
 
 	/* crypto is optional, if not available leave it NULL */
-	att->crypto = bt_crypto_new();
+	if (!ext_signed)
+		att->crypto = bt_crypto_new();
 
 	att->req_queue = queue_new();
 	if (!att->req_queue)
diff --git a/src/shared/att.h b/src/shared/att.h
index 80810a1..2a7f87e 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -28,7 +28,7 @@
 
 struct bt_att;
 
-struct bt_att *bt_att_new(int fd);
+struct bt_att *bt_att_new(int fd, bool ext_signed);
 
 struct bt_att *bt_att_ref(struct bt_att *att);
 void bt_att_unref(struct bt_att *att);
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index fbc01db..1fc8730 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -179,7 +179,7 @@ static struct client *client_create(int fd, uint16_t mtu)
 		return NULL;
 	}
 
-	cli->att = bt_att_new(fd);
+	cli->att = bt_att_new(fd, false);
 	if (!cli->att) {
 		fprintf(stderr, "Failed to initialze ATT transport layer\n");
 		bt_att_unref(cli->att);
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index b30a958..292b584 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -548,7 +548,7 @@ static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 		return NULL;
 	}
 
-	server->att = bt_att_new(fd);
+	server->att = bt_att_new(fd, false);
 	if (!server->att) {
 		fprintf(stderr, "Failed to initialze ATT transport layer\n");
 		goto fail;
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index a7ea7cd..40e2ca9 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -647,7 +647,7 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
 	g_assert(err == 0);
 
-	context->att = bt_att_new(sv[0]);
+	context->att = bt_att_new(sv[0], false);
 	g_assert(context->att);
 
 	switch (test_data->context_type) {
diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c
index 28542f3..416e596 100644
--- a/unit/test-gattrib.c
+++ b/unit/test-gattrib.c
@@ -92,7 +92,7 @@ static void setup_context(struct context *cxt, gconstpointer data)
 	g_io_channel_set_encoding(cxt->server_io, NULL, NULL);
 	g_io_channel_set_buffered(cxt->server_io, FALSE);
 
-	cxt->att = g_attrib_new(cxt->att_io, DEFAULT_MTU);
+	cxt->att = g_attrib_new(cxt->att_io, DEFAULT_MTU, false);
 	g_assert(cxt->att != NULL);
 }
 
diff --git a/unit/test-hog.c b/unit/test-hog.c
index 778f087..24731d7 100644
--- a/unit/test-hog.c
+++ b/unit/test-hog.c
@@ -187,7 +187,7 @@ static struct context *create_context(gconstpointer data)
 
 	g_io_channel_set_close_on_unref(att_io, TRUE);
 
-	context->attrib = g_attrib_new(att_io, 23);
+	context->attrib = g_attrib_new(att_io, 23, false);
 	g_assert(context->attrib);
 
 	g_io_channel_unref(att_io);
-- 
1.9.1

