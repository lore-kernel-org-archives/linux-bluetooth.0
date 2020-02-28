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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B360C3F2D2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B01246B5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juUoUVo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgB1XrK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:47:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37931 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1XrK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 18:47:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so2499100pfc.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2020 15:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=P7v08WPCJmgOE+zN+pZI071+aDIMN916uP0KQpxtxkc=;
        b=juUoUVo+l9t1SMSbRzM6G/q3idaKgZFJ0Ubfj+QxqGwT1Co/62YGVThvZyNnnYYcyb
         s9djdwHuxuioji4Ju8BFckrDIurLFrsgpg3qtwy22B1DW2/YBBxU7/2sCiKEzpqUSWOP
         pncJIsodxz3c0x70sXc91X5JBH7TfvW8h6FAShQgBkKIn+ojYomVxl0XHhXtZvumoIUj
         RYyv4w6trQLOMb3OpI18gCzE7o8KRNeVBRfI7azdWNaJowssdJgVuTA8DZR6P2bE0YwL
         kTxiLDB9LUF+Em4QVbBhQcKWU/7PER5rhCvpoIIyNFOnS2q9RyxO57OigDKj9iSEkZ8h
         9UZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P7v08WPCJmgOE+zN+pZI071+aDIMN916uP0KQpxtxkc=;
        b=hOP14/hF3LIiPJpAjDQZ+95q9QMVzHh3/GDWtDaM9OCFjdw/YYKmSCLMlTzKhP+QvT
         jaHUmnQfK9ql/kjEcXj2GYb137pBsArArIUHxFjqHXI/YbqMWrYxcs6wdCYyJTkin8is
         SdDfx51jYZL8i26Ldw+cZH1e5svmTB1lwh11zvzUGnMUApbgIIUwahFzsfbRBJ7SeSyy
         mKpsZgI09tZuiEkBgR7DFIuqGxzUP2R85Dd9N8oqd1vPoIFs7IqcNnPpS1jVDxioeR3P
         af+oDkZF2tSWkHyA3xy0XgguAGy1UIC/QfIYElQoEVhp7R8IaJms2jvBdoB1c3iuM/Ha
         jnog==
X-Gm-Message-State: APjAAAX531REcS34xKbkDDow+SjJgl04gxast2GZxFa5FsVWMQ7crM7W
        I1KJRwMpR8lpi6BUs0eR/engV9KFM+A=
X-Google-Smtp-Source: APXvYqwgbDlOWZX8XcbO5NU1uTistB/cMXNdOoVtHipYJgkMuEirzo26t82MGWUIto78tnCV9CkJSw==
X-Received: by 2002:a62:768d:: with SMTP id r135mr6463474pfc.108.1582933627648;
        Fri, 28 Feb 2020 15:47:07 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q13sm13643954pfn.162.2020.02.28.15.47.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:47:06 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/12] share/att: Add EATT support
Date:   Fri, 28 Feb 2020 15:46:53 -0800
Message-Id: <20200228234701.14614-5-luiz.dentz@gmail.com>
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

This adds EATT support to bt_att, EATT bearers are handled as
additional channels which auto allocated for queued requests.
---
 src/gatt-database.c      |   4 +-
 src/shared/att-types.h   |  16 +-
 src/shared/att.c         | 566 +++++++++++++++++++++++++--------------
 src/shared/att.h         |   4 +
 src/shared/gatt-client.c |   2 +-
 5 files changed, 389 insertions(+), 203 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 2bae8711a..419e4f9e1 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2102,10 +2102,10 @@ static void append_options(DBusMessageIter *iter, void *user_data)
 	uint16_t mtu;
 
 	switch (op->link_type) {
-	case BT_ATT_LINK_BREDR:
+	case BT_ATT_BREDR:
 		link = "BR/EDR";
 		break;
-	case BT_ATT_LINK_LE:
+	case BT_ATT_LE:
 		link = "LE";
 		break;
 	default:
diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index 8a2658de3..7b88e7d92 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -27,6 +27,10 @@
 #define __packed __attribute__((packed))
 #endif
 
+#define BT_ATT_CID		4
+#define BT_ATT_PSM		31
+#define BT_ATT_EATT_PSM		0x27
+
 #define BT_ATT_SECURITY_AUTO	0
 #define BT_ATT_SECURITY_LOW	1
 #define BT_ATT_SECURITY_MEDIUM	2
@@ -37,9 +41,10 @@
 #define BT_ATT_MAX_LE_MTU	517
 #define BT_ATT_MAX_VALUE_LEN	512
 
-#define BT_ATT_LINK_BREDR	0x00
-#define BT_ATT_LINK_LE		0x01
-#define BT_ATT_LINK_LOCAL	0xff
+#define BT_ATT_BREDR		0x00
+#define BT_ATT_LE		0x01
+#define BT_ATT_EATT		0x02
+#define BT_ATT_LOCAL		0xff
 
 /* ATT protocol opcodes */
 #define BT_ATT_OP_ERROR_RSP			0x01
@@ -159,3 +164,8 @@ struct bt_att_pdu_error_rsp {
 
 /* GATT Characteristic Client Features Bitfield values */
 #define BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING		0x01
+#define BT_GATT_CHRC_CLI_FEAT_EATT			0x02
+#define BT_GATT_CHRC_CLI_FEAT_NFY_MULTI			0x04
+
+/* GATT Characteristic Server Features Bitfield values */
+#define BT_GATT_CHRC_SERVER_FEAT_EATT			0x01
diff --git a/src/shared/att.c b/src/shared/att.c
index 0ea6d55bd..1313703f9 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -49,32 +49,40 @@
 
 struct att_send_op;
 
-struct bt_att {
-	int ref_count;
+struct bt_att_chan {
+	struct bt_att *att;
 	int fd;
 	struct io *io;
-	bool io_on_l2cap;
-	int io_sec_level;		/* Only used for non-L2CAP */
-	uint8_t enc_size;
+	uint8_t type;
+	int sec_level;			/* Only used for non-L2CAP */
 
-	struct queue *req_queue;	/* Queued ATT protocol requests */
 	struct att_send_op *pending_req;
-	struct queue *ind_queue;	/* Queued ATT protocol indications */
 	struct att_send_op *pending_ind;
-	struct queue *write_queue;	/* Queue of PDUs ready to send */
 	bool writer_active;
 
-	struct queue *notify_list;	/* List of registered callbacks */
-	struct queue *disconn_list;	/* List of disconnect handlers */
-
 	bool in_req;			/* There's a pending incoming request */
 
 	uint8_t *buf;
 	uint16_t mtu;
+};
+
+struct bt_att {
+	int ref_count;
+	bool close_on_unref;
+	struct queue *chans;
+	uint8_t enc_size;
+	uint16_t mtu;			/* Biggest possible MTU */
+
+	struct queue *notify_list;	/* List of registered callbacks */
+	struct queue *disconn_list;	/* List of disconnect handlers */
 
 	unsigned int next_send_id;	/* IDs for "send" ops */
 	unsigned int next_reg_id;	/* IDs for registered callbacks */
 
+	struct queue *req_queue;	/* Queued ATT protocol requests */
+	struct queue *ind_queue;	/* Queued ATT protocol indications */
+	struct queue *write_queue;	/* Queue of PDUs ready to send */
+
 	bt_att_timeout_func_t timeout_callback;
 	bt_att_destroy_func_t timeout_destroy;
 	void *timeout_data;
@@ -362,8 +370,9 @@ static struct att_send_op *create_att_send_op(struct bt_att *att,
 	return op;
 }
 
-static struct att_send_op *pick_next_send_op(struct bt_att *att)
+static struct att_send_op *pick_next_send_op(struct bt_att_chan *chan)
 {
+	struct bt_att *att = chan->att;
 	struct att_send_op *op;
 
 	/* See if any operations are already in the write queue */
@@ -374,7 +383,7 @@ static struct att_send_op *pick_next_send_op(struct bt_att *att)
 	/* If there is no pending request, pick an operation from the
 	 * request queue.
 	 */
-	if (!att->pending_req) {
+	if (!chan->pending_req) {
 		op = queue_pop_head(att->req_queue);
 		if (op)
 			return op;
@@ -383,7 +392,7 @@ static struct att_send_op *pick_next_send_op(struct bt_att *att)
 	/* There is either a request pending or no requests queued. If there is
 	 * no pending indication, pick an operation from the indication queue.
 	 */
-	if (!att->pending_ind) {
+	if (!chan->pending_ind) {
 		op = queue_pop_head(att->ind_queue);
 		if (op)
 			return op;
@@ -393,22 +402,23 @@ static struct att_send_op *pick_next_send_op(struct bt_att *att)
 }
 
 struct timeout_data {
-	struct bt_att *att;
+	struct bt_att_chan *chan;
 	unsigned int id;
 };
 
 static bool timeout_cb(void *user_data)
 {
 	struct timeout_data *timeout = user_data;
-	struct bt_att *att = timeout->att;
+	struct bt_att_chan *chan = timeout->chan;
+	struct bt_att *att = chan->att;
 	struct att_send_op *op = NULL;
 
-	if (att->pending_req && att->pending_req->id == timeout->id) {
-		op = att->pending_req;
-		att->pending_req = NULL;
-	} else if (att->pending_ind && att->pending_ind->id == timeout->id) {
-		op = att->pending_ind;
-		att->pending_ind = NULL;
+	if (chan->pending_req && chan->pending_req->id == timeout->id) {
+		op = chan->pending_req;
+		chan->pending_req = NULL;
+	} else if (chan->pending_ind && chan->pending_ind->id == timeout->id) {
+		op = chan->pending_ind;
+		chan->pending_ind = NULL;
 	}
 
 	if (!op)
@@ -428,27 +438,28 @@ static bool timeout_cb(void *user_data)
 	 * This should trigger an io disconnect event which will clean up the
 	 * io and notify the upper layer.
 	 */
-	io_shutdown(att->io);
+	io_shutdown(chan->io);
 
 	return false;
 }
 
 static void write_watch_destroy(void *user_data)
 {
-	struct bt_att *att = user_data;
+	struct bt_att_chan *chan = user_data;
 
-	att->writer_active = false;
+	chan->writer_active = false;
 }
 
 static bool can_write_data(struct io *io, void *user_data)
 {
-	struct bt_att *att = user_data;
+	struct bt_att_chan *chan = user_data;
+	struct bt_att *att = chan->att;
 	struct att_send_op *op;
 	struct timeout_data *timeout;
 	ssize_t ret;
 	struct iovec iov;
 
-	op = pick_next_send_op(att);
+	op = pick_next_send_op(chan);
 	if (!op)
 		return false;
 
@@ -478,14 +489,14 @@ static bool can_write_data(struct io *io, void *user_data)
 	 */
 	switch (op->type) {
 	case ATT_OP_TYPE_REQ:
-		att->pending_req = op;
+		chan->pending_req = op;
 		break;
 	case ATT_OP_TYPE_IND:
-		att->pending_ind = op;
+		chan->pending_ind = op;
 		break;
 	case ATT_OP_TYPE_RSP:
 		/* Set in_req to false to indicate that no request is pending */
-		att->in_req = false;
+		chan->in_req = false;
 		/* fall through */
 	case ATT_OP_TYPE_CMD:
 	case ATT_OP_TYPE_NOT:
@@ -497,7 +508,7 @@ static bool can_write_data(struct io *io, void *user_data)
 	}
 
 	timeout = new0(struct timeout_data, 1);
-	timeout->att = att;
+	timeout->chan = chan;
 	timeout->id = op->id;
 	op->timeout_id = timeout_add(ATT_TIMEOUT_INTERVAL, timeout_cb,
 								timeout, free);
@@ -506,25 +517,33 @@ static bool can_write_data(struct io *io, void *user_data)
 	return true;
 }
 
-static void wakeup_writer(struct bt_att *att)
+static void wakeup_chan_writer(void *data, void *user_data)
 {
-	if (att->writer_active)
+	struct bt_att_chan *chan = data;
+	struct bt_att *att = chan->att;
+
+	if (chan->writer_active)
 		return;
 
 	/* Set the write handler only if there is anything that can be sent
 	 * at all.
 	 */
 	if (queue_isempty(att->write_queue)) {
-		if ((att->pending_req || queue_isempty(att->req_queue)) &&
-			(att->pending_ind || queue_isempty(att->ind_queue)))
+		if ((chan->pending_req || queue_isempty(att->req_queue)) &&
+			(chan->pending_ind || queue_isempty(att->ind_queue)))
 			return;
 	}
 
-	if (!io_set_write_handler(att->io, can_write_data, att,
+	if (!io_set_write_handler(chan->io, can_write_data, chan,
 							write_watch_destroy))
 		return;
 
-	att->writer_active = true;
+	chan->writer_active = true;
+}
+
+static void wakeup_writer(struct bt_att *att)
+{
+	queue_foreach(att->chans, wakeup_chan_writer, NULL);
 }
 
 static void disconn_handler(void *data, void *user_data)
@@ -549,44 +568,66 @@ static void disc_att_send_op(void *data)
 	destroy_att_send_op(op);
 }
 
+static void bt_att_chan_free(void *data)
+{
+	struct bt_att_chan *chan = data;
+
+	if (chan->pending_req)
+		destroy_att_send_op(chan->pending_req);
+
+	if (chan->pending_ind)
+		destroy_att_send_op(chan->pending_ind);
+
+	io_destroy(chan->io);
+
+	free(chan->buf);
+	free(chan);
+}
+
 static bool disconnect_cb(struct io *io, void *user_data)
 {
-	struct bt_att *att = user_data;
+	struct bt_att_chan *chan = user_data;
+	struct bt_att *att = chan->att;
 	int err;
 	socklen_t len;
 
 	len = sizeof(err);
 
-	if (getsockopt(att->fd, SOL_SOCKET, SO_ERROR, &err, &len) < 0) {
-		util_debug(att->debug_callback, att->debug_data,
+	if (getsockopt(chan->fd, SOL_SOCKET, SO_ERROR, &err, &len) < 0) {
+		util_debug(chan->att->debug_callback, chan->att->debug_data,
 					"Failed to obtain disconnect error: %s",
 					strerror(errno));
 		err = 0;
 	}
 
-	util_debug(att->debug_callback, att->debug_data,
-					"Physical link disconnected: %s",
-					strerror(err));
+	util_debug(chan->att->debug_callback, chan->att->debug_data,
+					"Channel %p disconnected: %s",
+					chan, strerror(err));
 
-	io_destroy(att->io);
-	att->io = NULL;
-	att->fd = -1;
+	/* Dettach channel */
+	queue_remove(att->chans, chan);
 
 	/* Notify request callbacks */
 	queue_remove_all(att->req_queue, NULL, NULL, disc_att_send_op);
 	queue_remove_all(att->ind_queue, NULL, NULL, disc_att_send_op);
 	queue_remove_all(att->write_queue, NULL, NULL, disc_att_send_op);
 
-	if (att->pending_req) {
-		disc_att_send_op(att->pending_req);
-		att->pending_req = NULL;
+	if (chan->pending_req) {
+		disc_att_send_op(chan->pending_req);
+		chan->pending_req = NULL;
 	}
 
-	if (att->pending_ind) {
-		disc_att_send_op(att->pending_ind);
-		att->pending_ind = NULL;
+	if (chan->pending_ind) {
+		disc_att_send_op(chan->pending_ind);
+		chan->pending_ind = NULL;
 	}
 
+	bt_att_chan_free(chan);
+
+	/* Don't run disconnect callback if there are channels left */
+	if (!queue_isempty(att->chans))
+		return false;
+
 	bt_att_ref(att);
 
 	queue_foreach(att->disconn_list, disconn_handler, INT_TO_PTR(err));
@@ -597,14 +638,49 @@ static bool disconnect_cb(struct io *io, void *user_data)
 	return false;
 }
 
-static bool change_security(struct bt_att *att, uint8_t ecode)
+static int bt_att_chan_get_security(struct bt_att_chan *chan)
+{
+	struct bt_security sec;
+	socklen_t len;
+
+	if (chan->type == BT_ATT_LOCAL)
+		return chan->sec_level;
+
+	memset(&sec, 0, sizeof(sec));
+	len = sizeof(sec);
+	if (getsockopt(chan->fd, SOL_BLUETOOTH, BT_SECURITY, &sec, &len) < 0)
+		return -EIO;
+
+	return sec.level;
+}
+
+static bool bt_att_chan_set_security(struct bt_att_chan *chan, int level)
+{
+	struct bt_security sec;
+
+	if (chan->type == BT_ATT_LOCAL) {
+		chan->sec_level = level;
+		return true;
+	}
+
+	memset(&sec, 0, sizeof(sec));
+	sec.level = level;
+
+	if (setsockopt(chan->fd, SOL_BLUETOOTH, BT_SECURITY, &sec,
+							sizeof(sec)) < 0)
+		return false;
+
+	return true;
+}
+
+static bool change_security(struct bt_att_chan *chan, uint8_t ecode)
 {
 	int security;
 
-	if (att->io_sec_level != BT_ATT_SECURITY_AUTO)
+	if (chan->sec_level != BT_ATT_SECURITY_AUTO)
 		return false;
 
-	security = bt_att_get_security(att, NULL);
+	security = bt_att_chan_get_security(chan);
 
 	if (ecode == BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION &&
 					security < BT_ATT_SECURITY_MEDIUM) {
@@ -622,14 +698,15 @@ static bool change_security(struct bt_att *att, uint8_t ecode)
 		return false;
 	}
 
-	return bt_att_set_security(att, security);
+	return bt_att_chan_set_security(chan, security);
 }
 
-static bool handle_error_rsp(struct bt_att *att, uint8_t *pdu,
+static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
 					ssize_t pdu_len, uint8_t *opcode)
 {
+	struct bt_att *att = chan->att;
 	const struct bt_att_pdu_error_rsp *rsp;
-	struct att_send_op *op = att->pending_req;
+	struct att_send_op *op = chan->pending_req;
 
 	if (pdu_len != sizeof(*rsp)) {
 		*opcode = 0;
@@ -641,7 +718,7 @@ static bool handle_error_rsp(struct bt_att *att, uint8_t *pdu,
 	*opcode = rsp->opcode;
 
 	/* Attempt to change security */
-	if (!change_security(att, rsp->ecode))
+	if (!change_security(chan, rsp->ecode))
 		return false;
 
 	/* Remove timeout_id if outstanding */
@@ -653,16 +730,17 @@ static bool handle_error_rsp(struct bt_att *att, uint8_t *pdu,
 	util_debug(att->debug_callback, att->debug_data,
 						"Retrying operation %p", op);
 
-	att->pending_req = NULL;
+	chan->pending_req = NULL;
 
 	/* Push operation back to request queue */
 	return queue_push_head(att->req_queue, op);
 }
 
-static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
+static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint8_t *pdu,
 								ssize_t pdu_len)
 {
-	struct att_send_op *op = att->pending_req;
+	struct bt_att *att = chan->att;
+	struct att_send_op *op = chan->pending_req;
 	uint8_t req_opcode;
 	uint8_t rsp_opcode;
 	uint8_t *rsp_pdu = NULL;
@@ -675,7 +753,7 @@ static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	if (!op) {
 		util_debug(att->debug_callback, att->debug_data,
 					"Received unexpected ATT response");
-		io_shutdown(att->io);
+		io_shutdown(chan->io);
 		return;
 	}
 
@@ -685,8 +763,8 @@ static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	 */
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		/* Return if error response cause a retry */
-		if (handle_error_rsp(att, pdu, pdu_len, &req_opcode)) {
-			wakeup_writer(att);
+		if (handle_error_rsp(chan, pdu, pdu_len, &req_opcode)) {
+			wakeup_chan_writer(chan, NULL);
 			return;
 		}
 	} else if (!(req_opcode = get_req_opcode(opcode)))
@@ -715,14 +793,15 @@ done:
 		op->callback(rsp_opcode, rsp_pdu, rsp_pdu_len, op->user_data);
 
 	destroy_att_send_op(op);
-	att->pending_req = NULL;
+	chan->pending_req = NULL;
 
-	wakeup_writer(att);
+	wakeup_chan_writer(chan, NULL);
 }
 
-static void handle_conf(struct bt_att *att, uint8_t *pdu, ssize_t pdu_len)
+static void handle_conf(struct bt_att_chan *chan, uint8_t *pdu, ssize_t pdu_len)
 {
-	struct att_send_op *op = att->pending_ind;
+	struct bt_att *att = chan->att;
+	struct att_send_op *op = chan->pending_ind;
 
 	/*
 	 * Disconnect the bearer if the confirmation is unexpected or the PDU is
@@ -731,7 +810,7 @@ static void handle_conf(struct bt_att *att, uint8_t *pdu, ssize_t pdu_len)
 	if (!op || pdu_len) {
 		util_debug(att->debug_callback, att->debug_data,
 				"Received unexpected/invalid ATT confirmation");
-		io_shutdown(att->io);
+		io_shutdown(chan->io);
 		return;
 	}
 
@@ -739,9 +818,9 @@ static void handle_conf(struct bt_att *att, uint8_t *pdu, ssize_t pdu_len)
 		op->callback(BT_ATT_OP_HANDLE_VAL_CONF, NULL, 0, op->user_data);
 
 	destroy_att_send_op(op);
-	att->pending_ind = NULL;
+	chan->pending_ind = NULL;
 
-	wakeup_writer(att);
+	wakeup_chan_writer(chan, NULL);
 }
 
 struct notify_data {
@@ -811,9 +890,10 @@ fail:
 	return false;
 }
 
-static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
-								ssize_t pdu_len)
+static void handle_notify(struct bt_att_chan *chan, uint8_t opcode,
+						uint8_t *pdu, ssize_t pdu_len)
 {
+	struct bt_att *att = chan->att;
 	const struct queue_entry *entry;
 	bool found;
 
@@ -845,7 +925,7 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 		 * link since the MTU size is negotiated using L2CAP channel
 		 * configuration procedures.
 		 */
-		if (bt_att_get_link_type(att) == BT_ATT_LINK_BREDR) {
+		if (bt_att_get_link_type(att) == BT_ATT_BREDR) {
 			switch (opcode) {
 			case BT_ATT_OP_MTU_REQ:
 				goto not_supported;
@@ -876,22 +956,23 @@ not_supported:
 
 static bool can_read_data(struct io *io, void *user_data)
 {
-	struct bt_att *att = user_data;
+	struct bt_att_chan *chan = user_data;
+	struct bt_att *att = chan->att;
 	uint8_t opcode;
 	uint8_t *pdu;
 	ssize_t bytes_read;
 
-	bytes_read = read(att->fd, att->buf, att->mtu);
+	bytes_read = read(chan->fd, chan->buf, chan->mtu);
 	if (bytes_read < 0)
 		return false;
 
-	util_hexdump('>', att->buf, bytes_read,
-					att->debug_callback, att->debug_data);
+	util_hexdump('>', chan->buf, bytes_read,
+				att->debug_callback, att->debug_data);
 
 	if (bytes_read < ATT_MIN_PDU_LEN)
 		return true;
 
-	pdu = att->buf;
+	pdu = chan->buf;
 	opcode = pdu[0];
 
 	bt_att_ref(att);
@@ -901,12 +982,12 @@ static bool can_read_data(struct io *io, void *user_data)
 	case ATT_OP_TYPE_RSP:
 		util_debug(att->debug_callback, att->debug_data,
 				"ATT response received: 0x%02x", opcode);
-		handle_rsp(att, opcode, pdu + 1, bytes_read - 1);
+		handle_rsp(chan, opcode, pdu + 1, bytes_read - 1);
 		break;
 	case ATT_OP_TYPE_CONF:
 		util_debug(att->debug_callback, att->debug_data,
 				"ATT confirmation received: 0x%02x", opcode);
-		handle_conf(att, pdu + 1, bytes_read - 1);
+		handle_conf(chan, pdu + 1, bytes_read - 1);
 		break;
 	case ATT_OP_TYPE_REQ:
 		/*
@@ -914,17 +995,17 @@ static bool can_read_data(struct io *io, void *user_data)
 		 * protocol was violated. Disconnect the bearer, which will
 		 * promptly notify the upper layer via disconnect handlers.
 		 */
-		if (att->in_req) {
+		if (chan->in_req) {
 			util_debug(att->debug_callback, att->debug_data,
 					"Received request while another is "
 					"pending: 0x%02x", opcode);
-			io_shutdown(att->io);
-			bt_att_unref(att);
+			io_shutdown(chan->io);
+			bt_att_unref(chan->att);
 
 			return false;
 		}
 
-		att->in_req = true;
+		chan->in_req = true;
 		/* fall through */
 	case ATT_OP_TYPE_CMD:
 	case ATT_OP_TYPE_NOT:
@@ -937,7 +1018,7 @@ static bool can_read_data(struct io *io, void *user_data)
 		 */
 		util_debug(att->debug_callback, att->debug_data,
 					"ATT PDU received: 0x%02x", opcode);
-		handle_notify(att, opcode, pdu + 1, bytes_read - 1);
+		handle_notify(chan, opcode, pdu + 1, bytes_read - 1);
 		break;
 	}
 
@@ -973,21 +1054,8 @@ static bool is_io_l2cap_based(int fd)
 
 static void bt_att_free(struct bt_att *att)
 {
-	if (att->pending_req)
-		destroy_att_send_op(att->pending_req);
-
-	if (att->pending_ind)
-		destroy_att_send_op(att->pending_ind);
-
-	io_destroy(att->io);
 	bt_crypto_unref(att->crypto);
 
-	queue_destroy(att->req_queue, NULL);
-	queue_destroy(att->ind_queue, NULL);
-	queue_destroy(att->write_queue, NULL);
-	queue_destroy(att->notify_list, NULL);
-	queue_destroy(att->disconn_list, NULL);
-
 	if (att->timeout_destroy)
 		att->timeout_destroy(att->timeout_data);
 
@@ -997,7 +1065,12 @@ static void bt_att_free(struct bt_att *att)
 	free(att->local_sign);
 	free(att->remote_sign);
 
-	free(att->buf);
+	queue_destroy(att->req_queue, NULL);
+	queue_destroy(att->ind_queue, NULL);
+	queue_destroy(att->write_queue, NULL);
+	queue_destroy(att->notify_list, NULL);
+	queue_destroy(att->disconn_list, NULL);
+	queue_destroy(att->chans, bt_att_chan_free);
 
 	free(att);
 }
@@ -1014,60 +1087,101 @@ static uint16_t get_l2cap_mtu(int fd)
 	return l2o.omtu;
 }
 
-struct bt_att *bt_att_new(int fd, bool ext_signed)
+static uint8_t io_get_type(int fd)
 {
-	struct bt_att *att;
+	struct sockaddr_l2 src;
+	socklen_t len;
 
-	if (fd < 0)
-		return NULL;
+	if (!is_io_l2cap_based(fd))
+		return BT_ATT_LOCAL;
 
-	att = new0(struct bt_att, 1);
-	att->fd = fd;
+	len = sizeof(src);
+	memset(&src, 0, len);
+	if (getsockname(fd, (void *)&src, &len) < 0)
+		return -errno;
 
-	att->io = io_new(fd);
-	if (!att->io)
-		goto fail;
+	if (src.l2_bdaddr_type == BDADDR_BREDR)
+		return BT_ATT_BREDR;
 
-	/* crypto is optional, if not available leave it NULL */
-	if (!ext_signed)
-		att->crypto = bt_crypto_new();
+	return BT_ATT_LE;
+}
 
-	att->req_queue = queue_new();
-	att->ind_queue = queue_new();
-	att->write_queue = queue_new();
-	att->notify_list = queue_new();
-	att->disconn_list = queue_new();
+static struct bt_att_chan *bt_att_chan_new(int fd, uint8_t type)
+{
+	struct bt_att_chan *chan;
 
-	if (!io_set_read_handler(att->io, can_read_data, att, NULL))
+	if (fd < 0)
+		return NULL;
+
+	chan = new0(struct bt_att_chan, 1);
+	chan->fd = fd;
+
+	chan->io = io_new(fd);
+	if (!chan->io)
 		goto fail;
 
-	if (!io_set_disconnect_handler(att->io, disconnect_cb, att, NULL))
+	if (!io_set_read_handler(chan->io, can_read_data, chan, NULL))
 		goto fail;
 
-	att->io_on_l2cap = is_io_l2cap_based(att->fd);
-	if (!att->io_on_l2cap)
-		att->io_sec_level = BT_ATT_SECURITY_LOW;
+	if (!io_set_disconnect_handler(chan->io, disconnect_cb, chan, NULL))
+		goto fail;
 
-	if (bt_att_get_link_type(att) == BT_ATT_LINK_BREDR)
-		att->mtu = get_l2cap_mtu(att->fd);
-	else
-		att->mtu = BT_ATT_DEFAULT_LE_MTU;
+	chan->type = type;
+	switch (chan->type) {
+	case BT_ATT_LOCAL:
+		chan->sec_level = BT_ATT_SECURITY_LOW;
+		/* fall through */
+	case BT_ATT_LE:
+		chan->mtu = BT_ATT_DEFAULT_LE_MTU;
+		break;
+	default:
+		chan->mtu = get_l2cap_mtu(chan->fd);
+	}
 
-	if (att->mtu < BT_ATT_DEFAULT_LE_MTU)
+	if (chan->mtu < BT_ATT_DEFAULT_LE_MTU)
 		goto fail;
 
-	att->buf = malloc(att->mtu);
-	if (!att->buf)
+	chan->buf = malloc(chan->mtu);
+	if (!chan->buf)
 		goto fail;
 
-	return bt_att_ref(att);
+	return chan;
 
 fail:
-	bt_att_free(att);
+	bt_att_chan_free(chan);
 
 	return NULL;
 }
 
+struct bt_att *bt_att_new(int fd, bool ext_signed)
+{
+	struct bt_att *att;
+	struct bt_att_chan *chan;
+
+	chan = bt_att_chan_new(fd, io_get_type(fd));
+	if (!chan)
+		return NULL;
+
+	att = new0(struct bt_att, 1);
+	att->chans = queue_new();
+	att->mtu = chan->mtu;
+
+	queue_push_head(att->chans, chan);
+	chan->att = att;
+
+	/* crypto is optional, if not available leave it NULL */
+	if (!ext_signed)
+		att->crypto = bt_crypto_new();
+
+	att->req_queue = queue_new();
+	att->ind_queue = queue_new();
+	att->write_queue = queue_new();
+	att->notify_list = queue_new();
+	att->disconn_list = queue_new();
+
+	return bt_att_ref(att);
+}
+
 struct bt_att *bt_att_ref(struct bt_att *att)
 {
 	if (!att)
@@ -1094,18 +1208,67 @@ void bt_att_unref(struct bt_att *att)
 
 bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close)
 {
-	if (!att || !att->io)
+	const struct queue_entry *entry;
+
+	if (!att)
 		return false;
 
-	return io_set_close_on_destroy(att->io, do_close);
+	att->close_on_unref = do_close;
+
+	for (entry = queue_get_entries(att->chans); entry;
+						entry = entry->next) {
+		struct bt_att_chan *chan = entry->data;
+
+		if (!io_set_close_on_destroy(chan->io, do_close))
+			return false;
+	}
+
+	return true;
+}
+
+int bt_att_attach_fd(struct bt_att *att, int fd)
+{
+	struct bt_att_chan *chan;
+
+	if (!att || fd < 0)
+		return -EINVAL;
+
+	chan = bt_att_chan_new(fd, BT_ATT_EATT);
+	if (!chan)
+		return -EINVAL;
+
+	queue_push_tail(att->chans, chan);
+	chan->att = att;
+
+	if (chan->mtu > att->mtu)
+		att->mtu = chan->mtu;
+
+	io_set_close_on_destroy(chan->io, att->close_on_unref);
+
+	return 0;
 }
 
 int bt_att_get_fd(struct bt_att *att)
 {
+	struct bt_att_chan *chan;
+
 	if (!att)
 		return -1;
 
-	return att->fd;
+	if (queue_isempty(att->chans))
+		return -ENOTCONN;
+
+	chan = queue_peek_head(att->chans);
+
+	return chan->fd;
+}
+
+int bt_att_get_channels(struct bt_att *att)
+{
+	if (!att)
+		return 0;
+
+	return queue_length(att->chans);
 }
 
 bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
@@ -1134,6 +1297,7 @@ uint16_t bt_att_get_mtu(struct bt_att *att)
 
 bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu)
 {
+	struct bt_att_chan *chan;
 	void *buf;
 
 	if (!att)
@@ -1142,38 +1306,37 @@ bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu)
 	if (mtu < BT_ATT_DEFAULT_LE_MTU)
 		return false;
 
+	chan = queue_peek_head(att->chans);
+	if (!chan)
+		return -ENOTCONN;
+
 	buf = malloc(mtu);
 	if (!buf)
 		return false;
 
-	free(att->buf);
+	free(chan->buf);
+
+	chan->mtu = mtu;
+	chan->buf = buf;
 
-	att->mtu = mtu;
-	att->buf = buf;
+	if (chan->mtu > att->mtu)
+		att->mtu = chan->mtu;
 
 	return true;
 }
 
 uint8_t bt_att_get_link_type(struct bt_att *att)
 {
-	struct sockaddr_l2 src;
-	socklen_t len;
+	struct bt_att_chan *chan;
 
 	if (!att)
 		return -EINVAL;
 
-	if (!att->io_on_l2cap)
-		return BT_ATT_LINK_LOCAL;
+	chan = queue_peek_head(att->chans);
+	if (!chan)
+		return -ENOTCONN;
 
-	len = sizeof(src);
-	memset(&src, 0, len);
-	if (getsockname(att->fd, (void *)&src, &len) < 0)
-		return -errno;
-
-	if (src.l2_bdaddr_type == BDADDR_BREDR)
-		return BT_ATT_LINK_BREDR;
-
-	return BT_ATT_LINK_LE;
+	return chan->type;
 }
 
 bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
@@ -1200,7 +1363,7 @@ unsigned int bt_att_register_disconnect(struct bt_att *att,
 {
 	struct att_disconn *disconn;
 
-	if (!att || !att->io)
+	if (!att || queue_isempty(att->chans))
 		return 0;
 
 	disconn = new0(struct att_disconn, 1);
@@ -1229,7 +1392,7 @@ bool bt_att_unregister_disconnect(struct bt_att *att, unsigned int id)
 		return false;
 
 	/* Check if disconnect is running */
-	if (!att->io) {
+	if (!queue_isempty(att->chans)) {
 		disconn = queue_find(att->disconn_list, match_disconn_id,
 							UINT_TO_PTR(id));
 		if (!disconn)
@@ -1256,7 +1419,7 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 	struct att_send_op *op;
 	bool result;
 
-	if (!att || !att->io)
+	if (!att || queue_isempty(att->chans))
 		return 0;
 
 	op = create_att_send_op(att, opcode, pdu, length, callback, user_data,
@@ -1308,21 +1471,31 @@ static bool match_op_id(const void *a, const void *b)
 
 bool bt_att_cancel(struct bt_att *att, unsigned int id)
 {
+	const struct queue_entry *entry;
 	struct att_send_op *op;
 
 	if (!att || !id)
 		return false;
 
-	if (att->pending_req && att->pending_req->id == id) {
-		/* Don't cancel the pending request; remove it's handlers */
-		cancel_att_send_op(att->pending_req);
-		return true;
-	}
+	for (entry = queue_get_entries(att->chans); entry;
+						entry = entry->next) {
+		struct bt_att_chan *chan = entry->data;
 
-	if (att->pending_ind && att->pending_ind->id == id) {
-		/* Don't cancel the pending indication; remove it's handlers */
-		cancel_att_send_op(att->pending_ind);
-		return true;
+		if (chan->pending_req && chan->pending_req->id == id) {
+			/* Don't cancel the pending request; remove it's
+			 * handlers
+			 */
+			cancel_att_send_op(chan->pending_req);
+			return true;
+		}
+
+		if (chan->pending_ind && chan->pending_ind->id == id) {
+			/* Don't cancel the pending indication; remove it's
+			 * handlers.
+			 */
+			cancel_att_send_op(chan->pending_ind);
+			return true;
+		}
 	}
 
 	op = queue_remove_if(att->req_queue, match_op_id, UINT_TO_PTR(id));
@@ -1350,6 +1523,8 @@ done:
 
 bool bt_att_cancel_all(struct bt_att *att)
 {
+	const struct queue_entry *entry;
+
 	if (!att)
 		return false;
 
@@ -1357,13 +1532,22 @@ bool bt_att_cancel_all(struct bt_att *att)
 	queue_remove_all(att->ind_queue, NULL, NULL, destroy_att_send_op);
 	queue_remove_all(att->write_queue, NULL, NULL, destroy_att_send_op);
 
-	if (att->pending_req)
-		/* Don't cancel the pending request; remove it's handlers */
-		cancel_att_send_op(att->pending_req);
-
-	if (att->pending_ind)
-		/* Don't cancel the pending request; remove it's handlers */
-		cancel_att_send_op(att->pending_ind);
+	for (entry = queue_get_entries(att->chans); entry;
+						entry = entry->next) {
+		struct bt_att_chan *chan = entry->data;
+
+		if (chan->pending_req)
+			/* Don't cancel the pending request; remove it's
+			 * handlers
+			 */
+			cancel_att_send_op(chan->pending_req);
+
+		if (chan->pending_ind)
+			/* Don't cancel the pending request; remove it's
+			 * handlers
+			 */
+			cancel_att_send_op(chan->pending_ind);
+	}
 
 	return true;
 }
@@ -1424,7 +1608,7 @@ unsigned int bt_att_register(struct bt_att *att, uint8_t opcode,
 {
 	struct att_notify *notify;
 
-	if (!att || !callback || !att->io)
+	if (!att || !callback || queue_isempty(att->chans))
 		return 0;
 
 	notify = new0(struct att_notify, 1);
@@ -1475,51 +1659,39 @@ bool bt_att_unregister_all(struct bt_att *att)
 
 int bt_att_get_security(struct bt_att *att, uint8_t *enc_size)
 {
-	struct bt_security sec;
-	socklen_t len;
+	struct bt_att_chan *chan;
+	int ret;
 
 	if (!att)
 		return -EINVAL;
 
-	if (!att->io_on_l2cap) {
-		if (enc_size)
-			*enc_size = att->enc_size;
+	chan = queue_peek_head(att->chans);
+	if (!chan)
+		return -ENOTCONN;
 
-		return att->io_sec_level;
-	}
-
-	memset(&sec, 0, sizeof(sec));
-	len = sizeof(sec);
-	if (getsockopt(att->fd, SOL_BLUETOOTH, BT_SECURITY, &sec, &len) < 0)
-		return -EIO;
+	ret = bt_att_chan_get_security(chan);
+	if (ret < 0)
+		return ret;
 
 	if (enc_size)
 		*enc_size = att->enc_size;
 
-	return sec.level;
+	return ret;
 }
 
 bool bt_att_set_security(struct bt_att *att, int level)
 {
-	struct bt_security sec;
+	struct bt_att_chan *chan;
 
 	if (!att || level < BT_ATT_SECURITY_AUTO ||
 						level > BT_ATT_SECURITY_HIGH)
 		return false;
 
-	if (!att->io_on_l2cap) {
-		att->io_sec_level = level;
-		return true;
-	}
+	chan = queue_peek_head(att->chans);
+	if (!chan)
+		return -ENOTCONN;
 
-	memset(&sec, 0, sizeof(sec));
-	sec.level = level;
-
-	if (setsockopt(att->fd, SOL_BLUETOOTH, BT_SECURITY, &sec,
-							sizeof(sec)) < 0)
-		return false;
-
-	return true;
+	return bt_att_chan_set_security(chan, level);
 }
 
 void bt_att_set_enc_key_size(struct bt_att *att, uint8_t enc_size)
diff --git a/src/shared/att.h b/src/shared/att.h
index 49d93269b..110700846 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -37,6 +37,10 @@ bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close);
 
 int bt_att_get_fd(struct bt_att *att);
 
+int bt_att_attach_fd(struct bt_att *att, int fd);
+
+int bt_att_get_channels(struct bt_att *att);
+
 typedef void (*bt_att_response_func_t)(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data);
 typedef void (*bt_att_notify_func_t)(uint8_t opcode, const void *pdu,
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 29254cb61..3ce126485 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1909,7 +1909,7 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 	 * the MTU size is negotiated using L2CAP channel configuration
 	 * procedures.
 	 */
-	if (bt_att_get_link_type(client->att) == BT_ATT_LINK_BREDR)
+	if (bt_att_get_link_type(client->att) == BT_ATT_BREDR)
 		goto discover;
 
 	/* Check if MTU needs to be send */
-- 
2.21.1

