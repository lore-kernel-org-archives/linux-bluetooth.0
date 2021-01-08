Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 21:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E7D23A9B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 21:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbhAHVP6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Jan 2021 16:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbhAHVP5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Jan 2021 16:15:57 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A13C061786
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Jan 2021 13:15:16 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id i7so8417269pgc.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Jan 2021 13:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yGO0/O9TdjJe02BtFsztUjYvEiNDX4bPcn9FA5513Ag=;
        b=HDdOu/hYRHGEw6l5RkqIdf/Sv2VLJVGZJlfzb2VU+GVqtoqRmLyJR4FsGaOQ8gMYg8
         JFozEoIJw3SowUl7qZVoYi53dye50PrGWMnNUMp1EkZG+HYAobmeJjNaURO90xdlFx69
         AnJX6QdALg0YsABiQKR5xqrSXDqQJN+oxhGc1ri/DVL1l+3OhXucib9VwDtNfwpSCGYr
         aLRmJAwaEj11b/dvlVzNu7QkU7uYNlympN4JPBf+Gjzh+ZgTzwSrtS1zLZdhnwGnlljH
         klDmSNLEUbbczrZDrIMdeaG35CwS32d2DYtadBQiwxsR3acxWQdJEX7Ufv+uLsBTH3sH
         P9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGO0/O9TdjJe02BtFsztUjYvEiNDX4bPcn9FA5513Ag=;
        b=PPkchra6F4Jor0uUoKV6C0Pv3hDZMqJWRVYbXxFCOayjl5osm4+iOSNNbovbH4rxCs
         z77N9bUAC4d58RWl5N9IVPOkC2p5pfUtOhFKRtJjbGiAw/ORvStvA3JE4fkoatO0Q4yq
         K/ujD7AqGcTdqjOitkjDvqou9inFyEJFKPAsrNsGkPSL1fv0D5AhzBGnKSn362HA+RRI
         JzvbQ0QDrvbfl5tDOBIKSFWw7v0BZTMjcXMf6lwLY6K/BASrcSKhpRv4lpYzOaTW9yHs
         DE6PMxvdUp8r8FZcD+0MDQxUQqnzHZcc3QaMFDrULkeniZEM5BU5OmHT6wbsUS12iu9j
         uYCQ==
X-Gm-Message-State: AOAM530X3DZLx7xyjLLNAKbKcjCMcmERP3qV5/oxPHOj7ccpyU0WHR1f
        +Ll7Hnj+qkssxvBozQ3XwM+I/o4BnNc=
X-Google-Smtp-Source: ABdhPJyE8DsAa55G/wctrZZLGVMjRsq5ubwmMPX+zzUunFl3nyPIJ76nJE4Abr5WwBywvemrcINQlQ==
X-Received: by 2002:a63:c205:: with SMTP id b5mr8801191pgd.281.1610140516086;
        Fri, 08 Jan 2021 13:15:16 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 21sm9721699pfx.84.2021.01.08.13.15.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 13:15:15 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] shared/att: Add debug level to bt_att_set_debug
Date:   Fri,  8 Jan 2021 13:15:11 -0800
Message-Id: <20210108211513.5180-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210108211513.5180-1-luiz.dentz@gmail.com>
References: <20210108211513.5180-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This creates different levels of debugging which can be passed to
bt_att_set_debug as depending on the application it may not need to
print everything which can pollute the logs quite a bit.
---
 src/shared/att.c      | 108 +++++++++++++++++++++++-------------------
 src/shared/att.h      |   9 +++-
 tools/btgatt-client.c |   3 +-
 tools/btgatt-server.c |   3 +-
 unit/test-gatt.c      |   2 +-
 5 files changed, 71 insertions(+), 54 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 429ba6696..ccc753c4e 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -77,6 +77,7 @@ struct bt_att {
 	bt_att_destroy_func_t timeout_destroy;
 	void *timeout_data;
 
+	uint8_t debug_level;
 	bt_att_debug_func_t debug_callback;
 	bt_att_destroy_func_t debug_destroy;
 	void *debug_data;
@@ -274,6 +275,34 @@ static bool match_disconn_id(const void *a, const void *b)
 	return disconn->id == id;
 }
 
+static void att_log(struct bt_att *att, uint8_t level, const char *format,
+								...)
+{
+	va_list va;
+
+	if (att->debug_level < level)
+		return;
+
+	va_start(va, format);
+	util_debug_va(att->debug_callback, att->debug_data, format, va);
+	va_end(va);
+}
+
+#define att_debug(_att, _format, _arg...) \
+	att_log(_att, BT_ATT_DEBUG, _format, ## _arg)
+
+#define att_verbose(_att, _format, _arg...) \
+	att_log(_att, BT_ATT_DEBUG_VERBOSE, _format, ## _arg)
+
+static void att_hexdump(struct bt_att *att, char dir, const void *data,
+							size_t len)
+{
+	if (att->debug_level < 2)
+		return;
+
+	util_hexdump(dir, data, len, att->debug_callback, att->debug_data);
+}
+
 static bool encode_pdu(struct bt_att *att, struct att_send_op *op,
 					const void *pdu, uint16_t length)
 {
@@ -309,8 +338,7 @@ static bool encode_pdu(struct bt_att *att, struct att_send_op *op,
 				sign_cnt, &((uint8_t *) op->pdu)[1 + length])))
 		return true;
 
-	util_debug(att->debug_callback, att->debug_data,
-					"ATT unable to generate signature");
+	att_debug(att, "ATT unable to generate signature");
 
 fail:
 	free(op->pdu);
@@ -432,9 +460,8 @@ static bool timeout_cb(void *user_data)
 	if (!op)
 		return false;
 
-	util_debug(att->debug_callback, att->debug_data,
-				"(chan %p) Operation timed out: 0x%02x",
-				chan, op->opcode);
+	att_debug(att, "(chan %p) Operation timed out: 0x%02x", chan,
+						op->opcode);
 
 	if (att->timeout_callback)
 		att->timeout_callback(op->id, op->opcode, att->timeout_data);
@@ -469,20 +496,18 @@ static ssize_t bt_att_chan_write(struct bt_att_chan *chan, uint8_t opcode,
 	iov.iov_base = (void *) pdu;
 	iov.iov_len = len;
 
-	util_debug(att->debug_callback, att->debug_data,
-					"(chan %p) ATT op 0x%02x",
-					chan, opcode);
+	att_verbose(att, "(chan %p) ATT op 0x%02x", chan, opcode);
 
 	ret = io_send(chan->io, &iov, 1);
 	if (ret < 0) {
-		util_debug(att->debug_callback, att->debug_data,
-					"(chan %p) write failed: %s",
-					chan, strerror(-ret));
-
+		att_debug(att, "(chan %p) write failed: %s", chan,
+						strerror(-ret));
 		return ret;
 	}
 
-	util_hexdump('<', pdu, ret, att->debug_callback, att->debug_data);
+	if (att->debug_level)
+		util_hexdump('<', pdu, ret, att->debug_callback,
+						att->debug_data);
 
 	return ret;
 }
@@ -608,15 +633,12 @@ static bool disconnect_cb(struct io *io, void *user_data)
 	len = sizeof(err);
 
 	if (getsockopt(chan->fd, SOL_SOCKET, SO_ERROR, &err, &len) < 0) {
-		util_debug(chan->att->debug_callback, chan->att->debug_data,
-					"(chan %p) Failed to obtain disconnect"
-					" error: %s", chan, strerror(errno));
+		att_debug(att, "(chan %p) Failed to obtain disconnect "
+				"error: %s", chan, strerror(errno));
 		err = 0;
 	}
 
-	util_debug(chan->att->debug_callback, chan->att->debug_data,
-					"Channel %p disconnected: %s",
-					chan, strerror(err));
+	att_debug(att, "Channel %p disconnected: %s", chan, strerror(err));
 
 	/* Dettach channel */
 	queue_remove(att->chans, chan);
@@ -745,9 +767,7 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
 		op->timeout_id = 0;
 	}
 
-	util_debug(att->debug_callback, att->debug_data,
-						"(chan %p) Retrying operation "
-						"%p", chan, op);
+	att_debug(att, "(chan %p) Retrying operation %p", chan, op);
 
 	chan->pending_req = NULL;
 
@@ -770,9 +790,8 @@ static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint8_t *pdu,
 	 * the bearer.
 	 */
 	if (!op) {
-		util_debug(att->debug_callback, att->debug_data,
-					"(chan %p) Received unexpected ATT "
-					"response", chan);
+		att_debug(att, "(chan %p) Received unexpected ATT response",
+								chan);
 		io_shutdown(chan->io);
 		return;
 	}
@@ -803,8 +822,7 @@ static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint8_t *pdu,
 	goto done;
 
 fail:
-	util_debug(att->debug_callback, att->debug_data,
-			"(chan %p) Failed to handle response PDU; opcode: "
+	att_debug(att, "(chan %p) Failed to handle response PDU; opcode: "
 			"0x%02x", chan, opcode);
 
 	rsp_opcode = BT_ATT_OP_ERROR_RSP;
@@ -829,8 +847,7 @@ static void handle_conf(struct bt_att_chan *chan, uint8_t *pdu, ssize_t pdu_len)
 	 * invalid.
 	 */
 	if (!op || pdu_len) {
-		util_debug(att->debug_callback, att->debug_data,
-				"(chan %p) Received unexpected/invalid ATT "
+		att_debug(att, "(chan %p) Received unexpected/invalid ATT "
 				"confirmation", chan);
 		io_shutdown(chan->io);
 		return;
@@ -904,8 +921,7 @@ static bool handle_signed(struct bt_att *att, uint8_t *pdu, ssize_t pdu_len)
 	return true;
 
 fail:
-	util_debug(att->debug_callback, att->debug_data,
-			"ATT failed to verify signature: 0x%02x", opcode);
+	att_debug(att, "ATT failed to verify signature: 0x%02x", opcode);
 
 	return false;
 }
@@ -987,12 +1003,9 @@ static bool can_read_data(struct io *io, void *user_data)
 	if (bytes_read < 0)
 		return false;
 
-	util_debug(att->debug_callback, att->debug_data,
-				"(chan %p) ATT received: %zd",
-				chan, bytes_read);
+	att_verbose(att, "(chan %p) ATT received: %zd", chan, bytes_read);
 
-	util_hexdump('>', chan->buf, bytes_read,
-				att->debug_callback, att->debug_data);
+	att_hexdump(att, '>', chan->buf, bytes_read);
 
 	if (bytes_read < ATT_MIN_PDU_LEN)
 		return true;
@@ -1005,14 +1018,12 @@ static bool can_read_data(struct io *io, void *user_data)
 	/* Act on the received PDU based on the opcode type */
 	switch (get_op_type(opcode)) {
 	case ATT_OP_TYPE_RSP:
-		util_debug(att->debug_callback, att->debug_data,
-				"(chan %p) ATT response received: 0x%02x",
+		att_verbose(att, "(chan %p) ATT response received: 0x%02x",
 				chan, opcode);
 		handle_rsp(chan, opcode, pdu + 1, bytes_read - 1);
 		break;
 	case ATT_OP_TYPE_CONF:
-		util_debug(att->debug_callback, att->debug_data,
-				"(chan %p) ATT confirmation received: 0x%02x",
+		att_verbose(att, "(chan %p) ATT confirmation received: 0x%02x",
 				chan, opcode);
 		handle_conf(chan, pdu + 1, bytes_read - 1);
 		break;
@@ -1023,8 +1034,7 @@ static bool can_read_data(struct io *io, void *user_data)
 		 * promptly notify the upper layer via disconnect handlers.
 		 */
 		if (chan->in_req) {
-			util_debug(att->debug_callback, att->debug_data,
-					"(chan %p) Received request while "
+			att_debug(att, "(chan %p) Received request while "
 					"another is pending: 0x%02x",
 					chan, opcode);
 			io_shutdown(chan->io);
@@ -1044,9 +1054,8 @@ static bool can_read_data(struct io *io, void *user_data)
 		/* For all other opcodes notify the upper layer of the PDU and
 		 * let them act on it.
 		 */
-		util_debug(att->debug_callback, att->debug_data,
-					"(chan %p) ATT PDU received: 0x%02x",
-					chan, opcode);
+		att_debug(att, "(chan %p) ATT PDU received: 0x%02x", chan,
+							opcode);
 		handle_notify(chan, pdu, bytes_read);
 		break;
 	}
@@ -1198,8 +1207,7 @@ static void bt_att_attach_chan(struct bt_att *att, struct bt_att_chan *chan)
 
 	io_set_close_on_destroy(chan->io, att->close_on_unref);
 
-	util_debug(att->debug_callback, att->debug_data, "Channel %p attached",
-									chan);
+	att_debug(att, "Channel %p attached", chan);
 
 	wakeup_chan_writer(chan, NULL);
 }
@@ -1315,8 +1323,9 @@ int bt_att_get_channels(struct bt_att *att)
 	return queue_length(att->chans);
 }
 
-bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
-				void *user_data, bt_att_destroy_func_t destroy)
+bool bt_att_set_debug(struct bt_att *att, uint8_t level,
+			bt_att_debug_func_t callback, void *user_data,
+			bt_att_destroy_func_t destroy)
 {
 	if (!att)
 		return false;
@@ -1324,6 +1333,7 @@ bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
 	if (att->debug_destroy)
 		att->debug_destroy(att->debug_data);
 
+	att->debug_level = level;
 	att->debug_callback = callback;
 	att->debug_destroy = destroy;
 	att->debug_data = user_data;
diff --git a/src/shared/att.h b/src/shared/att.h
index 1938fc724..03a450988 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -13,6 +13,10 @@
 
 #include "src/shared/att-types.h"
 
+#define BT_ATT_DEBUG		0x00
+#define BT_ATT_DEBUG_VERBOSE	0x01
+#define BT_ATT_DEBUG_HEXDUMP	0x02
+
 struct bt_att;
 struct bt_att_chan;
 
@@ -41,8 +45,9 @@ typedef void (*bt_att_timeout_func_t)(unsigned int id, uint8_t opcode,
 typedef void (*bt_att_disconnect_func_t)(int err, void *user_data);
 typedef bool (*bt_att_counter_func_t)(uint32_t *sign_cnt, void *user_data);
 
-bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
-				void *user_data, bt_att_destroy_func_t destroy);
+bool bt_att_set_debug(struct bt_att *att, uint8_t level,
+			bt_att_debug_func_t callback, void *user_data,
+			bt_att_destroy_func_t destroy);
 
 uint16_t bt_att_get_mtu(struct bt_att *att);
 bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu);
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 523d6ec30..8c9365aa2 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -218,7 +218,8 @@ static struct client *client_create(int fd, uint16_t mtu)
 								NULL, NULL);
 
 	if (verbose) {
-		bt_att_set_debug(cli->att, att_debug_cb, "att: ", NULL);
+		bt_att_set_debug(cli->att, BT_ATT_DEBUG_VERBOSE, att_debug_cb,
+								"att: ", NULL);
 		bt_gatt_client_set_debug(cli->gatt, gatt_debug_cb, "gatt: ",
 									NULL);
 	}
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index aa3448765..000145a3d 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -584,7 +584,8 @@ static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 	server->hr_visible = hr_visible;
 
 	if (verbose) {
-		bt_att_set_debug(server->att, att_debug_cb, "att: ", NULL);
+		bt_att_set_debug(server->att, BT_ATT_DEBUG_VERBOSE,
+						att_debug_cb, "att: ", NULL);
 		bt_gatt_server_set_debug(server->gatt, gatt_debug_cb,
 							"server: ", NULL);
 	}
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 6a49210c5..4aa87d09c 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -658,7 +658,7 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 
 	switch (test_data->context_type) {
 	case ATT:
-		bt_att_set_debug(context->att, print_debug, "bt_att:", NULL);
+		bt_att_set_debug(context->att, 1, print_debug, "bt_att:", NULL);
 
 		bt_gatt_exchange_mtu(context->att, mtu, NULL, NULL, NULL);
 		break;
-- 
2.26.2

