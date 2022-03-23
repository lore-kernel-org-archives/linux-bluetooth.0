Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8EEC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 20:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344567AbiCWUPY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344555AbiCWUPV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 16:15:21 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D7C6576
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:50 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t13so829204pgn.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A5mU7ZW/EoX09OtoTGJHt6b6/ozCCsZy6iGJ/CCN76Y=;
        b=H3FzOY1VOLiGbSf3bcZgwJOAog+ocvS09VQY+JEa5jE+OFZRUhfDVnygVE2emEz8vz
         WxU5+tO8N0AKUAP/kuhx6L8r7BUHzNjBD0wNFO63shiKZUnEYaZoNwU3efsyltuvr7iu
         bzyQS7r6whNn7sGJbO557ThH8ujuKmETYvK6ZyfLNVZ0IsBmgipLcCR2w2avlWnnBOXt
         0fK3arbJxuZv6bUeDl1hwNpjTPiCq3nFeaZvWEOzeVqswU/9hg6qTabDDeC9bZrkwjCu
         EWQgBgsjXDe9Jxg8jpgBL6dxaPxIRL4kaLS00/JHH3NCd3o6vISEX3UI9hjD55M9DTzO
         OWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5mU7ZW/EoX09OtoTGJHt6b6/ozCCsZy6iGJ/CCN76Y=;
        b=RjZdsD+uTI/TEY45hOdNkCgDFcQBIYPn6UzZOMs/cA92AovgFggwPep+kOnz+ycEQy
         xqcLQYsoECN9Bt7mujesenG5gH7zG8XSmeit0aN8sSAXndcqVn2JyQylYSq5fXesQ9cN
         +63CePL9WqH5H6WrzNwCwW9Cbd8pjhjASboZkIJrP3yh0fjUx5ERiW6uPa2fOUH4p554
         8GwmkFXwu6Ioqs5QPVyvvjauHdogkj3hVezjpvY45cZDJbLQr73+aBqU7f4G+QCgbw0J
         hdR4u0w+talTNaiisNsWXcz1SLd4gx/ncP+CbdWb8kGsTZ4/ZnSoulO5Voe17syLMtu+
         QUSw==
X-Gm-Message-State: AOAM5325KINUBiyHQbZt77duK0Ty1+eluGp0IRnIJDQbRVm8oHwR8QbT
        XQgDFn+y1p/ARcZTZItuFKY/sDGQZoU=
X-Google-Smtp-Source: ABdhPJzqMRoNlOnQXBRGFrj7rPUVMQC4fKdB5XuvZGEWuxSrXfu/y8Wqi/H07ewMAhR78jY1cOgnVQ==
X-Received: by 2002:a05:6a00:1312:b0:4e1:58c4:ddfd with SMTP id j18-20020a056a00131200b004e158c4ddfdmr1207246pfu.65.1648066429649;
        Wed, 23 Mar 2022 13:13:49 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a7f8400b001bef3fc3938sm478361pjl.49.2022.03.23.13.13.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:13:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 8/9] att: Rename att_debug and att_verbose to DBG and VERBOSE
Date:   Wed, 23 Mar 2022 13:13:40 -0700
Message-Id: <20220323201341.3596128-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323201341.3596128-1-luiz.dentz@gmail.com>
References: <20220323201341.3596128-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

att_debug and att_verbose are macros which are more common to be
used as uppercase, this also change them to use DBG like other parts of
the code.
---
 src/shared/att.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 7344b0c46..f7bef08bc 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -307,11 +307,11 @@ static void att_log(struct bt_att *att, uint8_t level, const char *format,
 	va_end(va);
 }
 
-#define att_debug(_att, _format, _arg...) \
+#define DBG(_att, _format, _arg...) \
 	att_log(_att, BT_ATT_DEBUG, "%s:%s() " _format, __FILE__, __func__,\
 		## _arg)
 
-#define att_verbose(_att, _format, _arg...) \
+#define VERBOSE(_att, _format, _arg...) \
 	att_log(_att, BT_ATT_DEBUG_VERBOSE, "%s:%s() " _format, __FILE__, \
 		__func__, ## _arg)
 
@@ -359,7 +359,7 @@ static bool encode_pdu(struct bt_att *att, struct att_send_op *op,
 				sign_cnt, &((uint8_t *) op->pdu)[1 + length])))
 		return true;
 
-	att_debug(att, "ATT unable to generate signature");
+	DBG(att, "ATT unable to generate signature");
 
 fail:
 	free(op->pdu);
@@ -488,7 +488,7 @@ static bool timeout_cb(void *user_data)
 	if (!op)
 		return false;
 
-	att_debug(att, "(chan %p) Operation timed out: 0x%02x", chan,
+	DBG(att, "(chan %p) Operation timed out: 0x%02x", chan,
 						op->opcode);
 
 	if (att->timeout_callback)
@@ -524,11 +524,11 @@ static ssize_t bt_att_chan_write(struct bt_att_chan *chan, uint8_t opcode,
 	iov.iov_base = (void *) pdu;
 	iov.iov_len = len;
 
-	att_verbose(att, "(chan %p) ATT op 0x%02x", chan, opcode);
+	VERBOSE(att, "(chan %p) ATT op 0x%02x", chan, opcode);
 
 	ret = io_send(chan->io, &iov, 1);
 	if (ret < 0) {
-		att_debug(att, "(chan %p) write failed: %s", chan,
+		DBG(att, "(chan %p) write failed: %s", chan,
 						strerror(-ret));
 		return ret;
 	}
@@ -661,12 +661,12 @@ static bool disconnect_cb(struct io *io, void *user_data)
 	len = sizeof(err);
 
 	if (getsockopt(chan->fd, SOL_SOCKET, SO_ERROR, &err, &len) < 0) {
-		att_debug(att, "(chan %p) Failed to obtain disconnect "
+		DBG(att, "(chan %p) Failed to obtain disconnect "
 				"error: %s", chan, strerror(errno));
 		err = 0;
 	}
 
-	att_debug(att, "Channel %p disconnected: %s", chan, strerror(err));
+	DBG(att, "Channel %p disconnected: %s", chan, strerror(err));
 
 	/* Dettach channel */
 	queue_remove(att->chans, chan);
@@ -795,7 +795,7 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
 		op->timeout_id = 0;
 	}
 
-	att_debug(att, "(chan %p) Retrying operation %p", chan, op);
+	DBG(att, "(chan %p) Retrying operation %p", chan, op);
 
 	chan->pending_req = NULL;
 
@@ -818,7 +818,7 @@ static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint8_t *pdu,
 	 * the bearer.
 	 */
 	if (!op) {
-		att_debug(att, "(chan %p) Received unexpected ATT response",
+		DBG(att, "(chan %p) Received unexpected ATT response",
 								chan);
 		io_shutdown(chan->io);
 		return;
@@ -850,7 +850,7 @@ static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint8_t *pdu,
 	goto done;
 
 fail:
-	att_debug(att, "(chan %p) Failed to handle response PDU; opcode: "
+	DBG(att, "(chan %p) Failed to handle response PDU; opcode: "
 			"0x%02x", chan, opcode);
 
 	rsp_opcode = BT_ATT_OP_ERROR_RSP;
@@ -875,7 +875,7 @@ static void handle_conf(struct bt_att_chan *chan, uint8_t *pdu, ssize_t pdu_len)
 	 * invalid.
 	 */
 	if (!op || pdu_len) {
-		att_debug(att, "(chan %p) Received unexpected/invalid ATT "
+		DBG(att, "(chan %p) Received unexpected/invalid ATT "
 				"confirmation", chan);
 		io_shutdown(chan->io);
 		return;
@@ -949,7 +949,7 @@ static bool handle_signed(struct bt_att *att, uint8_t *pdu, ssize_t pdu_len)
 	return true;
 
 fail:
-	att_debug(att, "ATT failed to verify signature: 0x%02x", opcode);
+	DBG(att, "ATT failed to verify signature: 0x%02x", opcode);
 
 	return false;
 }
@@ -1032,7 +1032,7 @@ static bool can_read_data(struct io *io, void *user_data)
 	if (bytes_read < 0)
 		return false;
 
-	att_verbose(att, "(chan %p) ATT received: %zd", chan, bytes_read);
+	VERBOSE(att, "(chan %p) ATT received: %zd", chan, bytes_read);
 
 	att_hexdump(att, '>', chan->buf, bytes_read);
 
@@ -1047,12 +1047,12 @@ static bool can_read_data(struct io *io, void *user_data)
 	/* Act on the received PDU based on the opcode type */
 	switch (get_op_type(opcode)) {
 	case ATT_OP_TYPE_RSP:
-		att_verbose(att, "(chan %p) ATT response received: 0x%02x",
+		VERBOSE(att, "(chan %p) ATT response received: 0x%02x",
 				chan, opcode);
 		handle_rsp(chan, opcode, pdu + 1, bytes_read - 1);
 		break;
 	case ATT_OP_TYPE_CONF:
-		att_verbose(att, "(chan %p) ATT confirmation received: 0x%02x",
+		VERBOSE(att, "(chan %p) ATT confirmation received: 0x%02x",
 				chan, opcode);
 		handle_conf(chan, pdu + 1, bytes_read - 1);
 		break;
@@ -1063,7 +1063,7 @@ static bool can_read_data(struct io *io, void *user_data)
 		 * promptly notify the upper layer via disconnect handlers.
 		 */
 		if (chan->in_req) {
-			att_debug(att, "(chan %p) Received request while "
+			DBG(att, "(chan %p) Received request while "
 					"another is pending: 0x%02x",
 					chan, opcode);
 			io_shutdown(chan->io);
@@ -1083,7 +1083,7 @@ static bool can_read_data(struct io *io, void *user_data)
 		/* For all other opcodes notify the upper layer of the PDU and
 		 * let them act on it.
 		 */
-		att_debug(att, "(chan %p) ATT PDU received: 0x%02x", chan,
+		DBG(att, "(chan %p) ATT PDU received: 0x%02x", chan,
 							opcode);
 		handle_notify(chan, pdu, bytes_read);
 		break;
@@ -1237,7 +1237,7 @@ static void bt_att_attach_chan(struct bt_att *att, struct bt_att_chan *chan)
 
 	io_set_close_on_destroy(chan->io, att->close_on_unref);
 
-	att_debug(att, "Channel %p attached", chan);
+	DBG(att, "Channel %p attached", chan);
 
 	wakeup_chan_writer(chan, NULL);
 }
-- 
2.35.1

