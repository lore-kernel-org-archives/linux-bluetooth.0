Return-Path: <SRS0=e/tT=4Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4159C3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A66B246B5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsZ6TMow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgB1XrN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:47:13 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55334 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgB1XrM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 18:47:12 -0500
Received: by mail-pj1-f67.google.com with SMTP id a18so1900791pjs.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2020 15:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M0G9TugDn5OKwPo71nYWIjdIsvuqwMBKvnlVGuB2yEw=;
        b=UsZ6TMow/PrA4nvRmAzfXjFQP6rF3wMrGr8U0C7ChZg6j+DBDNAAktfT3ejO67YjCB
         m2j29tJM+2yt2K7w0WjviyP3faF7lOaqb5GnCWx5CZekXkdBUNZiIGMha13L2qiY+sQ+
         /jfSh5ZH9ZowAFK9Uu+3+PuZAMqs7pr7J69E4wkCmAc3tGIqlAQq5idSVYZxtuklCQRW
         Ro0ilkj4g/ml293nvAOTrrTtNTAKT4MgX6aDSWQYM9zP6jS5SrXRtW2EELmVoJdLauNB
         QwqA7tLQeAJWfXoqnYyQ3eW/2S7VPwxRDZQYxmvjFVs8ltbef2IxAWGT2RrYBtA8euOO
         3q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M0G9TugDn5OKwPo71nYWIjdIsvuqwMBKvnlVGuB2yEw=;
        b=hZ0vvTbbxhuqENT7t+vt2DDC0Lg4FEfdPnRR0cHsHs3y8Z+HcYU6fZyPBrD/abjBVt
         3M6Eo1fPCvTfKYuPnv9cgKVcr64aAzc4IXbhiHAhKoYALrUseB/DtdMfNGaPTL1SscvP
         2du+pIWBJepUeW121EZ6bGCCbDjoNs6V10TvoECKnWbKVnbsMCNqhSxyLIlWUSkI/gln
         c2NBZjkgEPVbTcXfay+dpL21mVTL3QbyYxM/fhN4ql6d2Up/LXGzjf9R3Rx9d5LmXkUS
         w9TV8GOBdm54181KVa+mozBBHKHt5Sb7FQ8Qk69c68v9+5BM55QNXURLqsDv5jm+VpWF
         spnw==
X-Gm-Message-State: APjAAAVWOmUoeZJcbme9EMEw/tEoIIR7cdqkRYxZfKxeNNLqxTDTcf7z
        hi5wFR4x6cO50ovy0RP3L61YC/Lkr4U=
X-Google-Smtp-Source: APXvYqzWMvaQtN+2vfd4o1isRYf5z/jkWXUTCCQMu/flwEyQlsiKnWJUrGIGd4MCB7Ob95qJM9xfyQ==
X-Received: by 2002:a17:902:8f91:: with SMTP id z17mr6340710plo.234.1582933628802;
        Fri, 28 Feb 2020 15:47:08 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q13sm13643954pfn.162.2020.02.28.15.47.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:47:08 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/12] shared/gatt-client: Add support for EATT features
Date:   Fri, 28 Feb 2020 15:46:54 -0800
Message-Id: <20200228234701.14614-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228234701.14614-1-luiz.dentz@gmail.com>
References: <20200228234701.14614-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables EATT in the Client Features if the EATT characteristic is
present in the database.
---
 attrib/gattrib.c         |   5 +-
 lib/uuid.h               |   3 +
 peripheral/gatt.c        |   2 +-
 src/device.c             |   2 +-
 src/shared/att.c         | 271 ++++++++++++++++++++++++++-------------
 src/shared/att.h         |  14 +-
 src/shared/gatt-client.c | 167 ++++++++++++++++++++++--
 src/shared/gatt-client.h |   5 +-
 src/shared/gatt-server.c | 205 ++++++++++++++++-------------
 tools/btgatt-client.c    |   2 +-
 unit/test-gatt.c         |  23 ++--
 11 files changed, 494 insertions(+), 205 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 57ca01541..8aa0f5eff 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -275,8 +275,9 @@ static void attrib_callback_result(uint8_t opcode, const void *pdu,
 	free(buf);
 }
 
-static void attrib_callback_notify(uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
+static void attrib_callback_notify(struct bt_att_chan *chan, uint8_t opcode,
+					const void *pdu, uint16_t length,
+					void *user_data)
 {
 	uint8_t *buf;
 	struct attrib_callbacks *cb = user_data;
diff --git a/lib/uuid.h b/lib/uuid.h
index fbc08f51e..ebdcf729c 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -154,6 +154,9 @@ extern "C" {
 #define GATT_CHARAC_CLI_FEAT				0x2B29
 #define GATT_CHARAC_DB_HASH				0x2B2A
 
+/* GATT Server Supported features */
+#define GATT_CHARAC_SERVER_FEAT				0x2B3A
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index 08541c424..bbbf3f59f 100644
--- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -136,7 +136,7 @@ static struct gatt_conn *gatt_conn_new(int fd)
 		return NULL;
 	}
 
-	conn->client = bt_gatt_client_new(gatt_cache, conn->att, mtu);
+	conn->client = bt_gatt_client_new(gatt_cache, conn->att, mtu, 0);
 	if (!conn->gatt) {
 		fprintf(stderr, "Failed to create GATT client\n");
 		bt_gatt_server_unref(conn->gatt);
diff --git a/src/device.c b/src/device.c
index a8f4c22f3..3f4afa281 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4939,7 +4939,7 @@ static void gatt_client_init(struct btd_device *device)
 	}
 
 	device->client = bt_gatt_client_new(device->db, device->att,
-							device->att_mtu);
+							device->att_mtu, 0);
 	if (!device->client) {
 		DBG("Failed to initialize");
 		return;
diff --git a/src/shared/att.c b/src/shared/att.c
index 1313703f9..56ea40c46 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -56,6 +56,8 @@ struct bt_att_chan {
 	uint8_t type;
 	int sec_level;			/* Only used for non-L2CAP */
 
+	struct queue *queue;		/* Channel dedicated queue */
+
 	struct att_send_op *pending_req;
 	struct att_send_op *pending_ind;
 	bool writer_active;
@@ -375,32 +377,47 @@ static struct att_send_op *pick_next_send_op(struct bt_att_chan *chan)
 	struct bt_att *att = chan->att;
 	struct att_send_op *op;
 
-	/* See if any operations are already in the write queue */
-	op = queue_pop_head(att->write_queue);
+	/* Check if there is anything queued on the channel */
+	op = queue_pop_head(chan->queue);
 	if (op)
 		return op;
 
+	/* See if any operations are already in the write queue */
+	op = queue_peek_head(att->write_queue);
+	if (op && op->len <= chan->mtu)
+		return queue_pop_head(att->write_queue);
+
 	/* If there is no pending request, pick an operation from the
 	 * request queue.
 	 */
 	if (!chan->pending_req) {
-		op = queue_pop_head(att->req_queue);
-		if (op)
-			return op;
+		op = queue_peek_head(att->req_queue);
+		if (op && op->len <= chan->mtu)
+			return queue_pop_head(att->req_queue);
 	}
 
 	/* There is either a request pending or no requests queued. If there is
 	 * no pending indication, pick an operation from the indication queue.
 	 */
 	if (!chan->pending_ind) {
-		op = queue_pop_head(att->ind_queue);
-		if (op)
-			return op;
+		op = queue_peek_head(att->ind_queue);
+		if (op && op->len <= chan->mtu)
+			return queue_pop_head(att->ind_queue);
 	}
 
 	return NULL;
 }
 
+static void disc_att_send_op(void *data)
+{
+	struct att_send_op *op = data;
+
+	if (op->callback)
+		op->callback(BT_ATT_OP_ERROR_RSP, NULL, 0, op->user_data);
+
+	destroy_att_send_op(op);
+}
+
 struct timeout_data {
 	struct bt_att_chan *chan;
 	unsigned int id;
@@ -425,13 +442,14 @@ static bool timeout_cb(void *user_data)
 		return false;
 
 	util_debug(att->debug_callback, att->debug_data,
-				"Operation timed out: 0x%02x", op->opcode);
+				"(chan %p) Operation timed out: 0x%02x",
+				chan, op->opcode);
 
 	if (att->timeout_callback)
 		att->timeout_callback(op->id, op->opcode, att->timeout_data);
 
 	op->timeout_id = 0;
-	destroy_att_send_op(op);
+	disc_att_send_op(op);
 
 	/*
 	 * Directly terminate the connection as required by the ATT protocol.
@@ -450,39 +468,52 @@ static void write_watch_destroy(void *user_data)
 	chan->writer_active = false;
 }
 
+static ssize_t bt_att_chan_write(struct bt_att_chan *chan, uint8_t opcode,
+					const void *pdu, uint16_t len)
+{
+	struct bt_att *att = chan->att;
+	ssize_t ret;
+	struct iovec iov;
+
+	iov.iov_base = (void *) pdu;
+	iov.iov_len = len;
+
+	util_debug(att->debug_callback, att->debug_data,
+					"(chan %p) ATT op 0x%02x",
+					chan, opcode);
+
+	ret = io_send(chan->io, &iov, 1);
+	if (ret < 0) {
+		util_debug(att->debug_callback, att->debug_data,
+					"(chan %p) write failed: %s",
+					chan, strerror(-ret));
+
+		return ret;
+	}
+
+	util_hexdump('<', pdu, ret, att->debug_callback, att->debug_data);
+
+	return ret;
+}
+
 static bool can_write_data(struct io *io, void *user_data)
 {
 	struct bt_att_chan *chan = user_data;
-	struct bt_att *att = chan->att;
 	struct att_send_op *op;
 	struct timeout_data *timeout;
-	ssize_t ret;
-	struct iovec iov;
 
 	op = pick_next_send_op(chan);
 	if (!op)
 		return false;
 
-	iov.iov_base = op->pdu;
-	iov.iov_len = op->len;
-
-	ret = io_send(io, &iov, 1);
-	if (ret < 0) {
-		util_debug(att->debug_callback, att->debug_data,
-					"write failed: %s", strerror(-ret));
+	if (!bt_att_chan_write(chan, op->opcode, op->pdu, op->len)) {
 		if (op->callback)
 			op->callback(BT_ATT_OP_ERROR_RSP, NULL, 0,
 							op->user_data);
-
 		destroy_att_send_op(op);
 		return true;
 	}
 
-	util_debug(att->debug_callback, att->debug_data,
-					"ATT op 0x%02x", op->opcode);
-
-	util_hexdump('<', op->pdu, ret, att->debug_callback, att->debug_data);
-
 	/* Based on the operation type, set either the pending request or the
 	 * pending indication. If it came from the write queue, then there is
 	 * no need to keep it around.
@@ -528,7 +559,7 @@ static void wakeup_chan_writer(void *data, void *user_data)
 	/* Set the write handler only if there is anything that can be sent
 	 * at all.
 	 */
-	if (queue_isempty(att->write_queue)) {
+	if (queue_isempty(chan->queue) && queue_isempty(att->write_queue)) {
 		if ((chan->pending_req || queue_isempty(att->req_queue)) &&
 			(chan->pending_ind || queue_isempty(att->ind_queue)))
 			return;
@@ -558,16 +589,6 @@ static void disconn_handler(void *data, void *user_data)
 		disconn->callback(err, disconn->user_data);
 }
 
-static void disc_att_send_op(void *data)
-{
-	struct att_send_op *op = data;
-
-	if (op->callback)
-		op->callback(BT_ATT_OP_ERROR_RSP, NULL, 0, op->user_data);
-
-	destroy_att_send_op(op);
-}
-
 static void bt_att_chan_free(void *data)
 {
 	struct bt_att_chan *chan = data;
@@ -578,6 +599,8 @@ static void bt_att_chan_free(void *data)
 	if (chan->pending_ind)
 		destroy_att_send_op(chan->pending_ind);
 
+	queue_destroy(chan->queue, destroy_att_send_op);
+
 	io_destroy(chan->io);
 
 	free(chan->buf);
@@ -595,8 +618,8 @@ static bool disconnect_cb(struct io *io, void *user_data)
 
 	if (getsockopt(chan->fd, SOL_SOCKET, SO_ERROR, &err, &len) < 0) {
 		util_debug(chan->att->debug_callback, chan->att->debug_data,
-					"Failed to obtain disconnect error: %s",
-					strerror(errno));
+					"(chan %p) Failed to obtain disconnect"
+					" error: %s", chan, strerror(errno));
 		err = 0;
 	}
 
@@ -728,7 +751,8 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
 	}
 
 	util_debug(att->debug_callback, att->debug_data,
-						"Retrying operation %p", op);
+						"(chan %p) Retrying operation "
+						"%p", chan, op);
 
 	chan->pending_req = NULL;
 
@@ -752,7 +776,8 @@ static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint8_t *pdu,
 	 */
 	if (!op) {
 		util_debug(att->debug_callback, att->debug_data,
-					"Received unexpected ATT response");
+					"(chan %p) Received unexpected ATT "
+					"response", chan);
 		io_shutdown(chan->io);
 		return;
 	}
@@ -784,7 +809,8 @@ static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint8_t *pdu,
 
 fail:
 	util_debug(att->debug_callback, att->debug_data,
-			"Failed to handle response PDU; opcode: 0x%02x", opcode);
+			"(chan %p) Failed to handle response PDU; opcode: "
+			"0x%02x", chan, opcode);
 
 	rsp_opcode = BT_ATT_OP_ERROR_RSP;
 
@@ -809,7 +835,8 @@ static void handle_conf(struct bt_att_chan *chan, uint8_t *pdu, ssize_t pdu_len)
 	 */
 	if (!op || pdu_len) {
 		util_debug(att->debug_callback, att->debug_data,
-				"Received unexpected/invalid ATT confirmation");
+				"(chan %p) Received unexpected/invalid ATT "
+				"confirmation", chan);
 		io_shutdown(chan->io);
 		return;
 	}
@@ -935,7 +962,7 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t opcode,
 		found = true;
 
 		if (notify->callback)
-			notify->callback(opcode, pdu, pdu_len,
+			notify->callback(chan, opcode, pdu, pdu_len,
 							notify->user_data);
 
 		/* callback could remove all entries from notify list */
@@ -966,6 +993,10 @@ static bool can_read_data(struct io *io, void *user_data)
 	if (bytes_read < 0)
 		return false;
 
+	util_debug(att->debug_callback, att->debug_data,
+				"(chan %p) ATT received: %zd",
+				chan, bytes_read);
+
 	util_hexdump('>', chan->buf, bytes_read,
 				att->debug_callback, att->debug_data);
 
@@ -981,12 +1012,14 @@ static bool can_read_data(struct io *io, void *user_data)
 	switch (get_op_type(opcode)) {
 	case ATT_OP_TYPE_RSP:
 		util_debug(att->debug_callback, att->debug_data,
-				"ATT response received: 0x%02x", opcode);
+				"(chan %p) ATT response received: 0x%02x",
+				chan, opcode);
 		handle_rsp(chan, opcode, pdu + 1, bytes_read - 1);
 		break;
 	case ATT_OP_TYPE_CONF:
 		util_debug(att->debug_callback, att->debug_data,
-				"ATT confirmation received: 0x%02x", opcode);
+				"(chan %p) ATT confirmation received: 0x%02x",
+				chan, opcode);
 		handle_conf(chan, pdu + 1, bytes_read - 1);
 		break;
 	case ATT_OP_TYPE_REQ:
@@ -997,8 +1030,9 @@ static bool can_read_data(struct io *io, void *user_data)
 		 */
 		if (chan->in_req) {
 			util_debug(att->debug_callback, att->debug_data,
-					"Received request while another is "
-					"pending: 0x%02x", opcode);
+					"(chan %p) Received request while "
+					"another is pending: 0x%02x",
+					chan, opcode);
 			io_shutdown(chan->io);
 			bt_att_unref(chan->att);
 
@@ -1017,7 +1051,8 @@ static bool can_read_data(struct io *io, void *user_data)
 		 * let them act on it.
 		 */
 		util_debug(att->debug_callback, att->debug_data,
-					"ATT PDU received: 0x%02x", opcode);
+					"(chan %p) ATT PDU received: 0x%02x",
+					chan, opcode);
 		handle_notify(chan, opcode, pdu + 1, bytes_read - 1);
 		break;
 	}
@@ -1075,16 +1110,19 @@ static void bt_att_free(struct bt_att *att)
 	free(att);
 }
 
-static uint16_t get_l2cap_mtu(int fd)
+static uint16_t io_get_mtu(int fd)
 {
 	socklen_t len;
 	struct l2cap_options l2o;
 
 	len = sizeof(l2o);
-	if (getsockopt(fd, SOL_L2CAP, L2CAP_OPTIONS, &l2o, &len) < 0)
-		return 0;
+	if (!getsockopt(fd, SOL_L2CAP, L2CAP_OPTIONS, &l2o, &len))
+		return l2o.omtu;
 
-	return l2o.omtu;
+	if (!getsockopt(fd, SOL_BLUETOOTH, BT_SNDMTU, &l2o.omtu, &len))
+		return l2o.omtu;
+
+	return 0;
 }
 
 static uint8_t io_get_type(int fd)
@@ -1135,7 +1173,7 @@ static struct bt_att_chan *bt_att_chan_new(int fd, uint8_t type)
 		chan->mtu = BT_ATT_DEFAULT_LE_MTU;
 		break;
 	default:
-		chan->mtu = get_l2cap_mtu(chan->fd);
+		chan->mtu = io_get_mtu(chan->fd);
 	}
 
 	if (chan->mtu < BT_ATT_DEFAULT_LE_MTU)
@@ -1145,6 +1183,8 @@ static struct bt_att_chan *bt_att_chan_new(int fd, uint8_t type)
 	if (!chan->buf)
 		goto fail;
 
+	chan->queue = queue_new();
+
 	return chan;
 
 fail:
@@ -1153,6 +1193,23 @@ fail:
 	return NULL;
 }
 
+static void bt_att_attach_chan(struct bt_att *att, struct bt_att_chan *chan)
+{
+	/* Push to head as EATT channels have higher priority */
+	queue_push_head(att->chans, chan);
+	chan->att = att;
+
+	if (chan->mtu > att->mtu)
+		att->mtu = chan->mtu;
+
+	io_set_close_on_destroy(chan->io, att->close_on_unref);
+
+	util_debug(att->debug_callback, att->debug_data, "Channel %p attached",
+									chan);
+
+	wakeup_chan_writer(chan, NULL);
+}
+
 struct bt_att *bt_att_new(int fd, bool ext_signed)
 {
 	struct bt_att *att;
@@ -1166,9 +1223,6 @@ struct bt_att *bt_att_new(int fd, bool ext_signed)
 	att->chans = queue_new();
 	att->mtu = chan->mtu;
 
-	queue_push_head(att->chans, chan);
-	chan->att = att;
-
 	/* crypto is optional, if not available leave it NULL */
 	if (!ext_signed)
 		att->crypto = bt_crypto_new();
@@ -1179,6 +1233,8 @@ struct bt_att *bt_att_new(int fd, bool ext_signed)
 	att->notify_list = queue_new();
 	att->disconn_list = queue_new();
 
+	bt_att_attach_chan(att, chan);
+
 	return bt_att_ref(att);
 }
 
@@ -1237,13 +1293,7 @@ int bt_att_attach_fd(struct bt_att *att, int fd)
 	if (!chan)
 		return -EINVAL;
 
-	queue_push_tail(att->chans, chan);
-	chan->att = att;
-
-	if (chan->mtu > att->mtu)
-		att->mtu = chan->mtu;
-
-	io_set_close_on_destroy(chan->io, att->close_on_unref);
+	bt_att_attach_chan(att, chan);
 
 	return 0;
 }
@@ -1258,7 +1308,7 @@ int bt_att_get_fd(struct bt_att *att)
 	if (queue_isempty(att->chans))
 		return -ENOTCONN;
 
-	chan = queue_peek_head(att->chans);
+	chan = queue_peek_tail(att->chans);
 
 	return chan->fd;
 }
@@ -1306,7 +1356,8 @@ bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu)
 	if (mtu < BT_ATT_DEFAULT_LE_MTU)
 		return false;
 
-	chan = queue_peek_head(att->chans);
+	/* Original channel is always the last */
+	chan = queue_peek_tail(att->chans);
 	if (!chan)
 		return -ENOTCONN;
 
@@ -1332,7 +1383,7 @@ uint8_t bt_att_get_link_type(struct bt_att *att)
 	if (!att)
 		return -EINVAL;
 
-	chan = queue_peek_head(att->chans);
+	chan = queue_peek_tail(att->chans);
 	if (!chan)
 		return -ENOTCONN;
 
@@ -1392,7 +1443,7 @@ bool bt_att_unregister_disconnect(struct bt_att *att, unsigned int id)
 		return false;
 
 	/* Check if disconnect is running */
-	if (!queue_isempty(att->chans)) {
+	if (queue_isempty(att->chans)) {
 		disconn = queue_find(att->disconn_list, match_disconn_id,
 							UINT_TO_PTR(id));
 		if (!disconn)
@@ -1461,6 +1512,33 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 	return op->id;
 }
 
+unsigned int bt_att_chan_send(struct bt_att_chan *chan, uint8_t opcode,
+				const void *pdu, uint16_t len,
+				bt_att_response_func_t callback,
+				void *user_data,
+				bt_att_destroy_func_t destroy)
+{
+	struct att_send_op *op;
+
+	if (!chan || !chan->att)
+		return -EINVAL;
+
+	op = create_att_send_op(chan->att, opcode, pdu, len, callback,
+						user_data, destroy);
+	if (!op)
+		return -EINVAL;
+
+	if (!queue_push_tail(chan->queue, op)) {
+		free(op->pdu);
+		free(op);
+		return 0;
+	}
+
+	wakeup_chan_writer(chan, NULL);
+
+	return op->id;
+}
+
 static bool match_op_id(const void *a, const void *b)
 {
 	const struct att_send_op *op = a;
@@ -1469,6 +1547,33 @@ static bool match_op_id(const void *a, const void *b)
 	return op->id == id;
 }
 
+bool bt_att_chan_cancel(struct bt_att_chan *chan, unsigned int id)
+{
+	struct att_send_op *op;
+
+	if (chan->pending_req && chan->pending_req->id == id) {
+		/* Don't cancel the pending request; remove it's handlers */
+		cancel_att_send_op(chan->pending_req);
+		return true;
+	}
+
+	if (chan->pending_ind && chan->pending_ind->id == id) {
+		/* Don't cancel the pending indication; remove it's handlers. */
+		cancel_att_send_op(chan->pending_ind);
+		return true;
+	}
+
+	op = queue_remove_if(chan->queue, match_op_id, UINT_TO_PTR(id));
+	if (!op)
+		return false;
+
+	destroy_att_send_op(op);
+
+	wakeup_chan_writer(chan, NULL);
+
+	return true;
+}
+
 bool bt_att_cancel(struct bt_att *att, unsigned int id)
 {
 	const struct queue_entry *entry;
@@ -1477,25 +1582,13 @@ bool bt_att_cancel(struct bt_att *att, unsigned int id)
 	if (!att || !id)
 		return false;
 
+	/* Lookuo request on each channel first */
 	for (entry = queue_get_entries(att->chans); entry;
 						entry = entry->next) {
 		struct bt_att_chan *chan = entry->data;
 
-		if (chan->pending_req && chan->pending_req->id == id) {
-			/* Don't cancel the pending request; remove it's
-			 * handlers
-			 */
-			cancel_att_send_op(chan->pending_req);
-			return true;
-		}
-
-		if (chan->pending_ind && chan->pending_ind->id == id) {
-			/* Don't cancel the pending indication; remove it's
-			 * handlers.
-			 */
-			cancel_att_send_op(chan->pending_ind);
+		if (bt_att_chan_cancel(chan, id))
 			return true;
-		}
 	}
 
 	op = queue_remove_if(att->req_queue, match_op_id, UINT_TO_PTR(id));
@@ -1580,14 +1673,14 @@ static uint8_t att_ecode_from_error(int err)
 	return BT_ATT_ERROR_UNLIKELY;
 }
 
-unsigned int bt_att_send_error_rsp(struct bt_att *att, uint8_t opcode,
+int bt_att_chan_send_error_rsp(struct bt_att_chan *chan, uint8_t opcode,
 						uint16_t handle, int error)
 {
 	struct bt_att_pdu_error_rsp pdu;
 	uint8_t ecode;
 
-	if (!att || !opcode)
-		return 0;
+	if (!chan || !chan->att || !opcode)
+		return -EINVAL;
 
 	ecode = att_ecode_from_error(error);
 
@@ -1597,8 +1690,8 @@ unsigned int bt_att_send_error_rsp(struct bt_att *att, uint8_t opcode,
 	put_le16(handle, &pdu.handle);
 	pdu.ecode = ecode;
 
-	return bt_att_send(att, BT_ATT_OP_ERROR_RSP, &pdu, sizeof(pdu),
-							NULL, NULL, NULL);
+	return bt_att_chan_send_rsp(chan, BT_ATT_OP_ERROR_RSP, &pdu,
+							sizeof(pdu));
 }
 
 unsigned int bt_att_register(struct bt_att *att, uint8_t opcode,
@@ -1665,7 +1758,7 @@ int bt_att_get_security(struct bt_att *att, uint8_t *enc_size)
 	if (!att)
 		return -EINVAL;
 
-	chan = queue_peek_head(att->chans);
+	chan = queue_peek_tail(att->chans);
 	if (!chan)
 		return -ENOTCONN;
 
@@ -1687,7 +1780,7 @@ bool bt_att_set_security(struct bt_att *att, int level)
 						level > BT_ATT_SECURITY_HIGH)
 		return false;
 
-	chan = queue_peek_head(att->chans);
+	chan = queue_peek_tail(att->chans);
 	if (!chan)
 		return -ENOTCONN;
 
diff --git a/src/shared/att.h b/src/shared/att.h
index 110700846..ed20bb5b8 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -27,6 +27,7 @@
 #include "src/shared/att-types.h"
 
 struct bt_att;
+struct bt_att_chan;
 
 struct bt_att *bt_att_new(int fd, bool ext_signed);
 
@@ -43,7 +44,8 @@ int bt_att_get_channels(struct bt_att *att);
 
 typedef void (*bt_att_response_func_t)(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data);
-typedef void (*bt_att_notify_func_t)(uint8_t opcode, const void *pdu,
+typedef void (*bt_att_notify_func_t)(struct bt_att_chan *chan,
+					uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data);
 typedef void (*bt_att_destroy_func_t)(void *user_data);
 typedef void (*bt_att_debug_func_t)(const char *str, void *user_data);
@@ -68,10 +70,18 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 					bt_att_response_func_t callback,
 					void *user_data,
 					bt_att_destroy_func_t destroy);
+unsigned int bt_att_chan_send(struct bt_att_chan *chan, uint8_t opcode,
+					const void *pdu, uint16_t len,
+					bt_att_response_func_t callback,
+					void *user_data,
+					bt_att_destroy_func_t destroy);
+#define bt_att_chan_send_rsp(chan, opcode, pdu, len) \
+	bt_att_chan_send(chan, opcode, pdu, len, NULL, NULL, NULL)
+bool bt_att_chan_cancel(struct bt_att_chan *chan, unsigned int id);
 bool bt_att_cancel(struct bt_att *att, unsigned int id);
 bool bt_att_cancel_all(struct bt_att *att);
 
-unsigned int bt_att_send_error_rsp(struct bt_att *att, uint8_t opcode,
+int bt_att_chan_send_error_rsp(struct bt_att_chan *chan, uint8_t opcode,
 						uint16_t handle, int error);
 
 unsigned int bt_att_register(struct bt_att *att, uint8_t opcode,
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 3ce126485..2c5fe14dc 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -60,6 +60,7 @@ struct ready_cb {
 struct bt_gatt_client {
 	struct bt_att *att;
 	int ref_count;
+	uint8_t features;
 
 	struct bt_gatt_client *parent;
 	struct queue *clones;
@@ -326,6 +327,7 @@ struct discovery_op {
 	struct queue *ext_prop_desc;
 	struct gatt_db_attribute *cur_svc;
 	struct gatt_db_attribute *hash;
+	uint8_t server_feat;
 	bool success;
 	uint16_t start;
 	uint16_t end;
@@ -1278,6 +1280,9 @@ static void notify_client_ready(struct bt_gatt_client *client, bool success,
 	bt_gatt_client_ref(client);
 	client->ready = success;
 
+	if (client->parent)
+		client->features = client->parent->features;
+
 	for (entry = queue_get_entries(client->ready_cbs); entry;
 							entry = entry->next) {
 		struct ready_cb *ready = entry->data;
@@ -1381,7 +1386,7 @@ static void db_hash_read_cb(bool success, uint8_t att_ecode,
 	util_hexdump(' ', value, len, client->debug_callback,
 						client->debug_data);
 
-	/* Store the new hash in the db */
+	/* Store ithe new hash in the db */
 	gatt_db_attribute_write(op->hash, 0, value, len, 0, NULL,
 					db_hash_write_value_cb, client);
 
@@ -1431,6 +1436,67 @@ static bool read_db_hash(struct discovery_op *op)
 	return true;
 }
 
+static void db_server_feat_read(bool success, uint8_t att_ecode,
+				struct bt_gatt_result *result, void *user_data)
+{
+	struct discovery_op *op = user_data;
+	struct bt_gatt_client *client = op->client;
+	const uint8_t *value;
+	uint16_t len, handle;
+	struct bt_gatt_iter iter;
+
+	if (!result)
+		return;
+
+	bt_gatt_iter_init(&iter, result);
+	bt_gatt_iter_next_read_by_type(&iter, &handle, &len, &value);
+
+	util_debug(client->debug_callback, client->debug_data,
+				"Server Features found: handle 0x%04x "
+				"length 0x%04x value 0x%02x", handle, len,
+				value[0]);
+
+	op->server_feat = value[0];
+}
+
+static void server_feat_read_value(struct gatt_db_attribute *attrib,
+						int err, const uint8_t *value,
+						size_t length, void *user_data)
+{
+	const uint8_t **feat = user_data;
+
+	if (err)
+		return;
+
+	*feat = value;
+}
+
+static void read_server_feat(struct discovery_op *op)
+{
+	struct bt_gatt_client *client = op->client;
+	struct gatt_db_attribute *attr = NULL;
+	const uint8_t *feat = NULL;
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_SERVER_FEAT);
+
+	gatt_db_find_by_type(client->db, 0x0001, 0xffff, &uuid,
+						get_first_attribute, &attr);
+	if (attr) {
+		/* Read stored value in the db */
+		gatt_db_attribute_read(attr, 0, BT_ATT_OP_READ_REQ, NULL,
+					server_feat_read_value, &feat);
+		if (feat)
+			return;
+	}
+
+	if (!bt_gatt_read_by_type(client->att, 0x0001, 0xffff, &uuid,
+							db_server_feat_read,
+							discovery_op_ref(op),
+							discovery_op_unref))
+		discovery_op_unref(op);
+}
+
 static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 {
 	struct discovery_op *op = user_data;
@@ -1464,6 +1530,8 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 					bt_att_get_mtu(client->att));
 
 discover:
+	read_server_feat(op);
+
 	if (read_db_hash(op)) {
 		op->success = false;
 		return;
@@ -1839,12 +1907,41 @@ static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
 	queue_push_tail(client->svc_chngd_queue, op);
 }
 
+static void server_feat_write_value(struct gatt_db_attribute *attrib,
+						int err, void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+
+	util_debug(client->debug_callback, client->debug_data,
+			"Server Features Value set status: %d", err);
+}
+
+static void write_server_features(struct bt_gatt_client *client, uint8_t feat)
+{
+	bt_uuid_t uuid;
+	struct gatt_db_attribute *attr = NULL;
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_SERVER_FEAT);
+
+	gatt_db_find_by_type(client->db, 0x0001, 0xffff, &uuid,
+						get_first_attribute, &attr);
+	if (!attr)
+		return;
+
+	/* Store value in the DB */
+	if (!gatt_db_attribute_write(attr, 0, &feat, sizeof(feat),
+					0, NULL, server_feat_write_value,
+					client))
+		util_debug(client->debug_callback, client->debug_data,
+					"Unable to store Server Features");
+}
+
 static void write_client_features(struct bt_gatt_client *client)
 {
 	bt_uuid_t uuid;
 	struct gatt_db_attribute *attr = NULL;
 	uint16_t handle;
-	uint8_t value;
+	const uint8_t *feat = NULL;
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_CLI_FEAT);
 
@@ -1854,10 +1951,28 @@ static void write_client_features(struct bt_gatt_client *client)
 		return;
 
 	handle = gatt_db_attribute_get_handle(attr);
-	value = BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING;
 
-	bt_gatt_client_write_value(client, handle, &value, sizeof(value), NULL,
-								NULL, NULL);
+	client->features = BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING;
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_SERVER_FEAT);
+
+	attr = NULL;
+	gatt_db_find_by_type(client->db, 0x0001, 0xffff, &uuid,
+						get_first_attribute, &attr);
+	if (attr) {
+		/* Read stored value in the db */
+		gatt_db_attribute_read(attr, 0, BT_ATT_OP_READ_REQ,
+						NULL, server_feat_read_value,
+						&feat);
+		if (feat && feat[0] & BT_GATT_CHRC_SERVER_FEAT_EATT)
+			client->features |= BT_GATT_CHRC_CLI_FEAT_EATT;
+	}
+
+	util_debug(client->debug_callback, client->debug_data,
+			"Writing Client Features 0x%02x", client->features);
+
+	bt_gatt_client_write_value(client, handle, &client->features,
+				sizeof(client->features), NULL, NULL, NULL);
 }
 
 static void init_complete(struct discovery_op *op, bool success,
@@ -1870,6 +1985,9 @@ static void init_complete(struct discovery_op *op, bool success,
 	if (!success)
 		goto fail;
 
+	if (op->server_feat)
+		write_server_features(client, op->server_feat);
+
 	write_client_features(client);
 
 	if (register_service_changed(client))
@@ -1932,6 +2050,8 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 	return true;
 
 discover:
+	read_server_feat(op);
+
 	if (read_db_hash(op)) {
 		op->success = false;
 		goto done;
@@ -2026,8 +2146,9 @@ static void notify_handler(void *data, void *user_data)
 							notify_data->user_data);
 }
 
-static void notify_cb(uint8_t opcode, const void *pdu, uint16_t length,
-								void *user_data)
+static void notify_cb(struct bt_att_chan *chan, uint8_t opcode,
+					const void *pdu, uint16_t length,
+					void *user_data)
 {
 	struct bt_gatt_client *client = user_data;
 	struct pdu_data pdu_data;
@@ -2041,7 +2162,7 @@ static void notify_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	queue_foreach(client->notify_list, notify_handler, &pdu_data);
 
 	if (opcode == BT_ATT_OP_HANDLE_VAL_IND && !client->parent)
-		bt_att_send(client->att, BT_ATT_OP_HANDLE_VAL_CONF, NULL, 0,
+		bt_att_chan_send(chan, BT_ATT_OP_HANDLE_VAL_CONF, NULL, 0,
 							NULL, NULL, NULL);
 
 	bt_gatt_client_unref(client);
@@ -2099,7 +2220,8 @@ static void att_disconnect_cb(int err, void *user_data)
 }
 
 static struct bt_gatt_client *gatt_client_new(struct gatt_db *db,
-							struct bt_att *att)
+							struct bt_att *att,
+							uint8_t features)
 {
 	struct bt_gatt_client *client;
 
@@ -2129,6 +2251,7 @@ static struct bt_gatt_client *gatt_client_new(struct gatt_db *db,
 
 	client->att = bt_att_ref(att);
 	client->db = gatt_db_ref(db);
+	client->features = features;
 
 	return client;
 
@@ -2140,14 +2263,15 @@ fail:
 
 struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
 							struct bt_att *att,
-							uint16_t mtu)
+							uint16_t mtu,
+							uint8_t features)
 {
 	struct bt_gatt_client *client;
 
 	if (!att || !db)
 		return NULL;
 
-	client = gatt_client_new(db, att);
+	client = gatt_client_new(db, att, features);
 	if (!client)
 		return NULL;
 
@@ -2166,7 +2290,7 @@ struct bt_gatt_client *bt_gatt_client_clone(struct bt_gatt_client *client)
 	if (!client)
 		return NULL;
 
-	clone = gatt_client_new(client->db, client->att);
+	clone = gatt_client_new(client->db, client->att, client->features);
 	if (!clone)
 		return NULL;
 
@@ -2284,6 +2408,14 @@ uint16_t bt_gatt_client_get_mtu(struct bt_gatt_client *client)
 	return bt_att_get_mtu(client->att);
 }
 
+struct bt_att *bt_gatt_client_get_att(struct bt_gatt_client *client)
+{
+	if (!client)
+		return NULL;
+
+	return client->att;
+}
+
 struct gatt_db *bt_gatt_client_get_db(struct bt_gatt_client *client)
 {
 	if (!client || !client->db)
@@ -2292,6 +2424,17 @@ struct gatt_db *bt_gatt_client_get_db(struct bt_gatt_client *client)
 	return client->db;
 }
 
+uint8_t bt_gatt_client_get_features(struct bt_gatt_client *client)
+{
+	if (!client)
+		return 0;
+
+	if (client->parent)
+		return client->parent->features;
+
+	return client->features;
+}
+
 static bool match_req_id(const void *a, const void *b)
 {
 	const struct request *req = a;
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 6d8bf8043..10900168b 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -31,7 +31,8 @@ struct bt_gatt_client;
 
 struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
 							struct bt_att *att,
-							uint16_t mtu);
+							uint16_t mtu,
+							uint8_t features);
 struct bt_gatt_client *bt_gatt_client_clone(struct bt_gatt_client *client);
 
 struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client);
@@ -73,7 +74,9 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
 					bt_gatt_client_destroy_func_t destroy);
 
 uint16_t bt_gatt_client_get_mtu(struct bt_gatt_client *client);
+struct bt_att *bt_gatt_client_get_att(struct bt_gatt_client *client);
 struct gatt_db *bt_gatt_client_get_db(struct bt_gatt_client *client);
+uint8_t bt_gatt_client_get_features(struct bt_gatt_client *client);
 
 bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id);
 bool bt_gatt_client_cancel_all(struct bt_gatt_client *client);
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 0d9bb0762..ee0058486 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -52,6 +52,7 @@
 #define DEFAULT_MAX_PREP_QUEUE_LEN 30
 
 struct async_read_op {
+	struct bt_att_chan *chan;
 	struct bt_gatt_server *server;
 	uint8_t opcode;
 	bool done;
@@ -62,6 +63,7 @@ struct async_read_op {
 };
 
 struct async_write_op {
+	struct bt_att_chan *chan;
 	struct bt_gatt_server *server;
 	uint8_t opcode;
 };
@@ -239,8 +241,9 @@ static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
 	return true;
 }
 
-static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
+static void read_by_grp_type_cb(struct bt_att_chan *chan, uint8_t opcode,
+					const void *pdu, uint16_t length,
+					void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t start, end;
@@ -308,15 +311,14 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 
 	queue_destroy(q, NULL);
 
-	bt_att_send(server->att, BT_ATT_OP_READ_BY_GRP_TYPE_RSP,
-							rsp_pdu, rsp_len,
-							NULL, NULL, NULL);
+	bt_att_chan_send_rsp(chan, BT_ATT_OP_READ_BY_GRP_TYPE_RSP,
+						rsp_pdu, rsp_len);
 
 	return;
 
 error:
 	queue_destroy(q, NULL);
-	bt_att_send_error_rsp(server->att, opcode, ehandle, ecode);
+	bt_att_chan_send_error_rsp(chan, opcode, ehandle, ecode);
 }
 
 static void async_read_op_destroy(struct async_read_op *op)
@@ -350,7 +352,7 @@ static void read_by_type_read_complete_cb(struct gatt_db_attribute *attr,
 
 	/* Terminate the operation if there was an error */
 	if (err) {
-		bt_att_send_error_rsp(server->att, BT_ATT_OP_READ_BY_TYPE_REQ,
+		bt_att_chan_send_error_rsp(op->chan, BT_ATT_OP_READ_BY_TYPE_REQ,
 								handle, err);
 		async_read_op_destroy(op);
 		return;
@@ -451,10 +453,8 @@ static void process_read_by_type(struct async_read_op *op)
 	attr = queue_pop_head(op->db_data);
 
 	if (op->done || !attr) {
-		bt_att_send(server->att, BT_ATT_OP_READ_BY_TYPE_RSP, op->pdu,
-								op->pdu_len,
-								NULL, NULL,
-								NULL);
+		bt_att_chan_send_rsp(op->chan, BT_ATT_OP_READ_BY_TYPE_RSP,
+						op->pdu, op->pdu_len);
 		async_read_op_destroy(op);
 		return;
 	}
@@ -472,13 +472,14 @@ static void process_read_by_type(struct async_read_op *op)
 	ecode = BT_ATT_ERROR_UNLIKELY;
 
 error:
-	bt_att_send_error_rsp(server->att, BT_ATT_OP_READ_BY_TYPE_REQ,
+	bt_att_chan_send_error_rsp(op->chan, BT_ATT_OP_READ_BY_TYPE_REQ,
 				gatt_db_attribute_get_handle(attr), ecode);
 	async_read_op_destroy(op);
 }
 
-static void read_by_type_cb(uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
+static void read_by_type_cb(struct bt_att_chan *chan, uint8_t opcode,
+					const void *pdu, uint16_t length,
+					void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t start, end;
@@ -535,6 +536,7 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 		goto error;
 	}
 
+	op->chan = chan;
 	op->opcode = opcode;
 	op->server = server;
 	op->db_data = q;
@@ -545,7 +547,7 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 	return;
 
 error:
-	bt_att_send_error_rsp(server->att, opcode, ehandle, ecode);
+	bt_att_chan_send_error_rsp(chan, opcode, ehandle, ecode);
 	queue_destroy(q, NULL);
 }
 
@@ -603,8 +605,9 @@ static bool encode_find_info_rsp(struct gatt_db *db, struct queue *q,
 	return true;
 }
 
-static void find_info_cb(uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
+static void find_info_cb(struct bt_att_chan *chan, uint8_t opcode,
+					const void *pdu, uint16_t length,
+					void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t start, end;
@@ -653,14 +656,14 @@ static void find_info_cb(uint8_t opcode, const void *pdu,
 		goto error;
 	}
 
-	bt_att_send(server->att, BT_ATT_OP_FIND_INFO_RSP, rsp_pdu, rsp_len,
-							NULL, NULL, NULL);
+	bt_att_chan_send_rsp(chan, BT_ATT_OP_FIND_INFO_RSP, rsp_pdu, rsp_len);
+
 	queue_destroy(q, NULL);
 
 	return;
 
 error:
-	bt_att_send_error_rsp(server->att, opcode, ehandle, ecode);
+	bt_att_chan_send_error_rsp(chan, opcode, ehandle, ecode);
 	queue_destroy(q, NULL);
 
 }
@@ -702,8 +705,9 @@ static void find_by_type_val_att_cb(struct gatt_db_attribute *attrib,
 	data->len += 4;
 }
 
-static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
+static void find_by_type_val_cb(struct bt_att_chan *chan, uint8_t opcode,
+					const void *pdu, uint16_t length,
+					void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t start, end, uuid16;
@@ -748,13 +752,13 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 	if (data.ecode)
 		goto error;
 
-	bt_att_send(server->att, BT_ATT_OP_FIND_BY_TYPE_RSP, data.pdu,
-						data.len, NULL, NULL, NULL);
+	bt_att_chan_send_rsp(chan, BT_ATT_OP_FIND_BY_TYPE_RSP,
+					data.pdu, data.len);
 
 	return;
 
 error:
-	bt_att_send_error_rsp(server->att, opcode, ehandle, data.ecode);
+	bt_att_chan_send_error_rsp(chan, opcode, ehandle, data.ecode);
 }
 
 static void async_write_op_destroy(struct async_write_op *op)
@@ -772,6 +776,9 @@ static void write_complete_cb(struct gatt_db_attribute *attr, int err,
 	struct bt_gatt_server *server = op->server;
 	uint16_t handle;
 
+	util_debug(server->debug_callback, server->debug_data,
+				"Write Complete: err %d", err);
+
 	if (!server || op->opcode == BT_ATT_OP_WRITE_CMD) {
 		async_write_op_destroy(op);
 		return;
@@ -780,10 +787,9 @@ static void write_complete_cb(struct gatt_db_attribute *attr, int err,
 	handle = gatt_db_attribute_get_handle(attr);
 
 	if (err)
-		bt_att_send_error_rsp(server->att, op->opcode, handle, err);
+		bt_att_chan_send_error_rsp(op->chan, op->opcode, handle, err);
 	else
-		bt_att_send(server->att, BT_ATT_OP_WRITE_RSP, NULL, 0,
-							NULL, NULL, NULL);
+		bt_att_chan_send_rsp(op->chan, BT_ATT_OP_WRITE_RSP, NULL, 0);
 
 	async_write_op_destroy(op);
 }
@@ -798,7 +804,7 @@ static uint8_t authorize_req(struct bt_gatt_server *server,
 						server->authorize_data);
 }
 
-static void write_cb(uint8_t opcode, const void *pdu,
+static void write_cb(struct bt_att_chan *chan, uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
@@ -840,6 +846,7 @@ static void write_cb(uint8_t opcode, const void *pdu,
 	}
 
 	op = new0(struct async_write_op, 1);
+	op->chan = chan;
 	op->server = server;
 	op->opcode = opcode;
 	server->pending_write_op = op;
@@ -857,7 +864,7 @@ error:
 	if (opcode == BT_ATT_OP_WRITE_CMD)
 		return;
 
-	bt_att_send_error_rsp(server->att, opcode, handle, ecode);
+	bt_att_chan_send_error_rsp(chan, opcode, handle, ecode);
 }
 
 static uint8_t get_read_rsp_opcode(uint8_t opcode)
@@ -893,6 +900,9 @@ static void read_complete_cb(struct gatt_db_attribute *attr, int err,
 	uint16_t mtu;
 	uint16_t handle;
 
+	util_debug(server->debug_callback, server->debug_data,
+				"Read Complete: err %d", err);
+
 	if (!server) {
 		async_read_op_destroy(op);
 		return;
@@ -902,22 +912,21 @@ static void read_complete_cb(struct gatt_db_attribute *attr, int err,
 	handle = gatt_db_attribute_get_handle(attr);
 
 	if (err) {
-		bt_att_send_error_rsp(server->att, op->opcode, handle, err);
+		bt_att_chan_send_error_rsp(op->chan, op->opcode, handle, err);
 		async_read_op_destroy(op);
 		return;
 	}
 
 	rsp_opcode = get_read_rsp_opcode(op->opcode);
 
-	bt_att_send(server->att, rsp_opcode, len ? value : NULL,
-						MIN((unsigned) mtu - 1, len),
-						NULL, NULL, NULL);
+	bt_att_chan_send_rsp(op->chan, rsp_opcode, len ? value : NULL,
+					MIN((unsigned int) mtu - 1, len));
 	async_read_op_destroy(op);
 }
 
-static void handle_read_req(struct bt_gatt_server *server, uint8_t opcode,
-								uint16_t handle,
-								uint16_t offset)
+static void handle_read_req(struct bt_att_chan *chan,
+				struct bt_gatt_server *server, uint8_t opcode,
+				uint16_t handle, uint16_t offset)
 {
 	struct gatt_db_attribute *attr;
 	uint8_t ecode;
@@ -950,6 +959,7 @@ static void handle_read_req(struct bt_gatt_server *server, uint8_t opcode,
 	}
 
 	op = new0(struct async_read_op, 1);
+	op->chan = chan;
 	op->opcode = opcode;
 	op->server = server;
 	server->pending_read_op = op;
@@ -964,34 +974,35 @@ error:
 	if (op)
 		async_read_op_destroy(op);
 
-	bt_att_send_error_rsp(server->att, opcode, handle, ecode);
+	bt_att_chan_send_error_rsp(chan, opcode, handle, ecode);
 }
 
-static void read_cb(uint8_t opcode, const void *pdu,
+static void read_cb(struct bt_att_chan *chan, uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t handle;
 
 	if (length != 2) {
-		bt_att_send_error_rsp(server->att, opcode, 0,
+		bt_att_chan_send_error_rsp(chan, opcode, 0,
 						BT_ATT_ERROR_INVALID_PDU);
 		return;
 	}
 
 	handle = get_le16(pdu);
 
-	handle_read_req(server, opcode, handle, 0);
+	handle_read_req(chan, server, opcode, handle, 0);
 }
 
-static void read_blob_cb(uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
+static void read_blob_cb(struct bt_att_chan *chan, uint8_t opcode,
+					const void *pdu, uint16_t length,
+					void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t handle, offset;
 
 	if (length != 4) {
-		bt_att_send_error_rsp(server->att, opcode, 0,
+		bt_att_chan_send_error_rsp(chan, opcode, 0,
 						BT_ATT_ERROR_INVALID_PDU);
 		return;
 	}
@@ -999,10 +1010,11 @@ static void read_blob_cb(uint8_t opcode, const void *pdu,
 	handle = get_le16(pdu);
 	offset = get_le16(pdu + 2);
 
-	handle_read_req(server, opcode, handle, offset);
+	handle_read_req(chan, server, opcode, handle, offset);
 }
 
 struct read_multiple_resp_data {
+	struct bt_att_chan *chan;
 	struct bt_gatt_server *server;
 	uint16_t *handles;
 	size_t cur_handle;
@@ -1029,7 +1041,7 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 	uint8_t ecode;
 
 	if (err != 0) {
-		bt_att_send_error_rsp(data->server->att,
+		bt_att_chan_send_error_rsp(data->chan,
 					BT_ATT_OP_READ_MULT_REQ, handle, err);
 		read_multiple_resp_data_free(data);
 		return;
@@ -1039,7 +1051,7 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 						BT_ATT_PERM_READ_AUTHEN |
 						BT_ATT_PERM_READ_ENCRYPT);
 	if (ecode) {
-		bt_att_send_error_rsp(data->server->att,
+		bt_att_chan_send_error_rsp(data->chan,
 					BT_ATT_OP_READ_MULT_REQ, handle, ecode);
 		read_multiple_resp_data_free(data);
 		return;
@@ -1054,8 +1066,8 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 
 	if ((data->length >= data->mtu - 1) ||
 				(data->cur_handle == data->num_handles)) {
-		bt_att_send(data->server->att, BT_ATT_OP_READ_MULT_RSP,
-				data->rsp_data, data->length, NULL, NULL, NULL);
+		bt_att_chan_send_rsp(data->chan, BT_ATT_OP_READ_MULT_RSP,
+						data->rsp_data, data->length);
 		read_multiple_resp_data_free(data);
 		return;
 	}
@@ -1069,7 +1081,7 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 					data->handles[data->cur_handle]);
 
 	if (!next_attr) {
-		bt_att_send_error_rsp(data->server->att,
+		bt_att_chan_send_error_rsp(data->chan,
 					BT_ATT_OP_READ_MULT_REQ,
 					data->handles[data->cur_handle],
 					BT_ATT_ERROR_INVALID_HANDLE);
@@ -1080,7 +1092,7 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 	if (!gatt_db_attribute_read(next_attr, 0, BT_ATT_OP_READ_MULT_REQ,
 					data->server->att,
 					read_multiple_complete_cb, data)) {
-		bt_att_send_error_rsp(data->server->att,
+		bt_att_chan_send_error_rsp(data->chan,
 						BT_ATT_OP_READ_MULT_REQ,
 						data->handles[data->cur_handle],
 						BT_ATT_ERROR_UNLIKELY);
@@ -1088,8 +1100,9 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 	}
 }
 
-static void read_multiple_cb(uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
+static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
+					const void *pdu, uint16_t length,
+					void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	struct gatt_db_attribute *attr;
@@ -1103,6 +1116,7 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu,
 	}
 
 	data = new0(struct read_multiple_resp_data, 1);
+	data->chan = chan;
 	data->handles = NULL;
 	data->rsp_data = NULL;
 	data->server = server;
@@ -1139,7 +1153,7 @@ error:
 	if (data)
 		read_multiple_resp_data_free(data);
 
-	bt_att_send_error_rsp(server->att, opcode, 0, ecode);
+	bt_att_chan_send_error_rsp(chan, opcode, 0, ecode);
 }
 
 static bool append_prep_data(struct prep_write_data *prep_data, uint16_t handle,
@@ -1230,6 +1244,7 @@ static bool store_prep_data(struct bt_gatt_server *server,
 }
 
 struct prep_write_complete_data {
+	struct bt_att_chan *chan;
 	void *pdu;
 	uint16_t length;
 	struct bt_gatt_server *server;
@@ -1245,8 +1260,8 @@ static void prep_write_complete_cb(struct gatt_db_attribute *attr, int err,
 	handle = get_le16(pwcd->pdu);
 
 	if (err) {
-		bt_att_send_error_rsp(pwcd->server->att,
-					BT_ATT_OP_PREP_WRITE_REQ, handle, err);
+		bt_att_chan_send_error_rsp(pwcd->chan, BT_ATT_OP_PREP_WRITE_REQ,
+								handle, err);
 		free(pwcd->pdu);
 		free(pwcd);
 
@@ -1257,19 +1272,20 @@ static void prep_write_complete_cb(struct gatt_db_attribute *attr, int err,
 
 	if (!store_prep_data(pwcd->server, handle, offset, pwcd->length - 4,
 						&((uint8_t *) pwcd->pdu)[4]))
-		bt_att_send_error_rsp(pwcd->server->att,
-					BT_ATT_OP_PREP_WRITE_RSP, handle,
+		bt_att_chan_send_error_rsp(pwcd->chan, BT_ATT_OP_PREP_WRITE_RSP,
+					handle,
 					BT_ATT_ERROR_INSUFFICIENT_RESOURCES);
 
-	bt_att_send(pwcd->server->att, BT_ATT_OP_PREP_WRITE_RSP, pwcd->pdu,
-						pwcd->length, NULL, NULL, NULL);
+	bt_att_chan_send_rsp(pwcd->chan, BT_ATT_OP_PREP_WRITE_RSP, pwcd->pdu,
+								pwcd->length);
 
 	free(pwcd->pdu);
 	free(pwcd);
 }
 
-static void prep_write_cb(uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
+static void prep_write_cb(struct bt_att_chan *chan, uint8_t opcode,
+					const void *pdu, uint16_t length,
+					void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t handle = 0;
@@ -1307,6 +1323,7 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
 		goto error;
 
 	pwcd = new0(struct prep_write_complete_data, 1);
+	pwcd->chan = chan;
 	pwcd->pdu = malloc(length);
 	memcpy(pwcd->pdu, pdu, length);
 	pwcd->length = length;
@@ -1323,23 +1340,28 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
 	ecode = BT_ATT_ERROR_UNLIKELY;
 
 error:
-	bt_att_send_error_rsp(server->att, opcode, handle, ecode);
+	bt_att_chan_send_error_rsp(chan, opcode, handle, ecode);
 }
 
-static void exec_next_prep_write(struct bt_gatt_server *server,
-						uint16_t ehandle, int err);
+struct exec_data {
+	struct bt_att_chan *chan;
+	struct bt_gatt_server *server;
+};
+
+static void exec_next_prep_write(struct exec_data *data, uint16_t ehandle,
+								int err);
 
 static void exec_write_complete_cb(struct gatt_db_attribute *attr, int err,
 								void *user_data)
 {
-	struct bt_gatt_server *server = user_data;
+	struct exec_data *data = user_data;
 	uint16_t handle = gatt_db_attribute_get_handle(attr);
 
-	exec_next_prep_write(server, handle, err);
+	exec_next_prep_write(data, handle, err);
 }
 
-static void exec_next_prep_write(struct bt_gatt_server *server,
-						uint16_t ehandle, int err)
+static void exec_next_prep_write(struct exec_data *data, uint16_t ehandle,
+								int err)
 {
 	struct prep_write_data *next = NULL;
 	struct gatt_db_attribute *attr;
@@ -1348,14 +1370,15 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
 	if (err)
 		goto error;
 
-	next = queue_pop_head(server->prep_queue);
+	next = queue_pop_head(data->server->prep_queue);
 	if (!next) {
-		bt_att_send(server->att, BT_ATT_OP_EXEC_WRITE_RSP, NULL, 0,
-							NULL, NULL, NULL);
+		bt_att_chan_send_rsp(data->chan, BT_ATT_OP_EXEC_WRITE_RSP,
+								NULL, 0);
+		free(data);
 		return;
 	}
 
-	attr = gatt_db_get_attribute(server->db, next->handle);
+	attr = gatt_db_get_attribute(data->server->db, next->handle);
 	if (!attr) {
 		err = BT_ATT_ERROR_UNLIKELY;
 		goto error;
@@ -1364,8 +1387,8 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
 	status = gatt_db_attribute_write(attr, next->offset,
 						next->value, next->length,
 						BT_ATT_OP_EXEC_WRITE_REQ,
-						server->att,
-						exec_write_complete_cb, server);
+						data->server->att,
+						exec_write_complete_cb, data);
 
 	prep_write_data_destroy(next);
 
@@ -1375,11 +1398,12 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
 	err = BT_ATT_ERROR_UNLIKELY;
 
 error:
-	queue_remove_all(server->prep_queue, NULL, NULL,
+	queue_remove_all(data->server->prep_queue, NULL, NULL,
 						prep_write_data_destroy);
 
-	bt_att_send_error_rsp(server->att, BT_ATT_OP_EXEC_WRITE_REQ,
+	bt_att_chan_send_error_rsp(data->chan, BT_ATT_OP_EXEC_WRITE_REQ,
 								ehandle, err);
+	free(data);
 }
 
 static bool find_no_reliable_characteristic(const void *data,
@@ -1390,10 +1414,12 @@ static bool find_no_reliable_characteristic(const void *data,
 	return !prep_data->reliable_supported;
 }
 
-static void exec_write_cb(uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
+static void exec_write_cb(struct bt_att_chan *chan, uint8_t opcode,
+					const void *pdu, uint16_t length,
+					void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
+	struct exec_data *data;
 	uint8_t flags;
 	uint8_t ecode;
 	bool write;
@@ -1421,8 +1447,7 @@ static void exec_write_cb(uint8_t opcode, const void *pdu,
 	if (!write) {
 		queue_remove_all(server->prep_queue, NULL, NULL,
 						prep_write_data_destroy);
-		bt_att_send(server->att, BT_ATT_OP_EXEC_WRITE_RSP, NULL, 0,
-							NULL, NULL, NULL);
+		bt_att_chan_send_rsp(chan, BT_ATT_OP_EXEC_WRITE_RSP, NULL, 0);
 		return;
 	}
 
@@ -1439,18 +1464,23 @@ static void exec_write_cb(uint8_t opcode, const void *pdu,
 		}
 	}
 
-	exec_next_prep_write(server, 0, 0);
+	data = new0(struct exec_data, 1);
+	data->chan = chan;
+	data->server = server;
+
+	exec_next_prep_write(data, 0, 0);
 
 	return;
 
 error:
 	queue_remove_all(server->prep_queue, NULL, NULL,
 						prep_write_data_destroy);
-	bt_att_send_error_rsp(server->att, opcode, ehandle, ecode);
+	bt_att_chan_send_error_rsp(chan, opcode, ehandle, ecode);
 }
 
-static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
+static void exchange_mtu_cb(struct bt_att_chan *chan, uint8_t opcode,
+				const void *pdu, uint16_t length,
+				void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t client_rx_mtu;
@@ -1458,7 +1488,7 @@ static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
 	uint8_t rsp_pdu[2];
 
 	if (length != 2) {
-		bt_att_send_error_rsp(server->att, opcode, 0,
+		bt_att_chan_send_error_rsp(chan, opcode, 0,
 						BT_ATT_ERROR_INVALID_PDU);
 		return;
 	}
@@ -1468,8 +1498,7 @@ static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
 
 	/* Respond with the server MTU */
 	put_le16(server->mtu, rsp_pdu);
-	bt_att_send(server->att, BT_ATT_OP_MTU_RSP, rsp_pdu, 2, NULL, NULL,
-									NULL);
+	bt_att_chan_send_rsp(chan, BT_ATT_OP_MTU_RSP, rsp_pdu, 2);
 
 	/* Set MTU to be the minimum */
 	server->mtu = final_mtu;
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 7df659747..82a9e3fe0 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -218,7 +218,7 @@ static struct client *client_create(int fd, uint16_t mtu)
 		return NULL;
 	}
 
-	cli->gatt = bt_gatt_client_new(cli->db, cli->att, mtu);
+	cli->gatt = bt_gatt_client_new(cli->db, cli->att, mtu, 0);
 	if (!cli->gatt) {
 		fprintf(stderr, "Failed to create GATT client\n");
 		gatt_db_unref(cli->db);
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index e35271b61..d94993b9c 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -124,8 +124,16 @@ struct context {
 		raw_pdu(0x02, 0x00, 0x02),				\
 		raw_pdu(0x03, 0x00, 0x02)
 
-#define SERVICE_DATA_1_PDUS						\
+#define READ_SERVER_FEAT_PDUS						\
+		raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x3a, 0x2b),	\
+		raw_pdu(0x01, 0x08, 0x01, 0x00, 0x0a)
+
+#define CLIENT_INIT_PDUS						\
 		MTU_EXCHANGE_CLIENT_PDUS,				\
+		READ_SERVER_FEAT_PDUS
+
+#define SERVICE_DATA_1_PDUS						\
+		CLIENT_INIT_PDUS,					\
 		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),	\
 		raw_pdu(0x11, 0x06, 0x01, 0x00, 0x04, 0x00, 0x01, 0x18),\
 		raw_pdu(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28),	\
@@ -150,7 +158,7 @@ struct context {
 		raw_pdu(0x05, 0x01, 0x08, 0x00, 0x01, 0x29)
 
 #define SERVICE_DATA_2_PDUS						\
-		MTU_EXCHANGE_CLIENT_PDUS,				\
+		CLIENT_INIT_PDUS,					\
 		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),	\
 		raw_pdu(0x11, 0x06, 0x01, 0x00, 0x04, 0x00, 0x01, 0x18),\
 		raw_pdu(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28),	\
@@ -175,7 +183,7 @@ struct context {
 		raw_pdu(0x05, 0x01, 0x0a, 0x00, 0x01, 0x29)
 
 #define SERVICE_DATA_3_PDUS						\
-		MTU_EXCHANGE_CLIENT_PDUS,				\
+		CLIENT_INIT_PDUS,					\
 		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),	\
 		raw_pdu(0x11, 0x06, 0x00, 0x01, 0x21, 0x01, 0x00, 0x18, \
 			0x00, 0x02, 0x00, 0x02, 0x01, 0x18),		\
@@ -683,7 +691,7 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 		g_assert(context->client_db);
 
 		context->client = bt_gatt_client_new(context->client_db,
-							context->att, mtu);
+							context->att, mtu, 0);
 		g_assert(context->client);
 
 		bt_gatt_client_set_debug(context->client, print_debug,
@@ -2371,8 +2379,7 @@ int main(int argc, char *argv[])
 	 * Discovery of Services and Service Characteristics.
 	 */
 	define_test_att("/TP/GAD/CL/BV-01-C", test_search_primary, NULL, NULL,
-			raw_pdu(0x02, 0x00, 0x02),
-			raw_pdu(0x03, 0x00, 0x02),
+			MTU_EXCHANGE_CLIENT_PDUS,
 			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 			raw_pdu(0x11, 0x06, 0x10, 0x00, 0x13, 0x00, 0x00, 0x18,
 					0x20, 0x00, 0x29, 0x00, 0xb0, 0x68,
@@ -3245,7 +3252,7 @@ int main(int argc, char *argv[])
 
 	define_test_client("/TP/GAN/CL/BV-01-C", test_client, ts_small_db,
 			&test_notification_1,
-			MTU_EXCHANGE_CLIENT_PDUS,
+			CLIENT_INIT_PDUS,
 			SMALL_DB_DISCOVERY_PDUS,
 			raw_pdu(0x12, 0x04, 0x00, 0x03, 0x00),
 			raw_pdu(0x13),
@@ -3271,7 +3278,7 @@ int main(int argc, char *argv[])
 
 	define_test_client("/TP/GAI/CL/BV-01-C", test_client, ts_small_db,
 			&test_indication_1,
-			MTU_EXCHANGE_CLIENT_PDUS,
+			CLIENT_INIT_PDUS,
 			SMALL_DB_DISCOVERY_PDUS,
 			raw_pdu(0x12, 0x04, 0x00, 0x03, 0x00),
 			raw_pdu(0x13),
-- 
2.21.1

