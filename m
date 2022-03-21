Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E8CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 20:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiCUU5D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiCUU5B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Mar 2022 16:57:01 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB7E197522
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 13:55:35 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z7so18215756iom.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 13:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A5mU7ZW/EoX09OtoTGJHt6b6/ozCCsZy6iGJ/CCN76Y=;
        b=kluyaFcgm/qU5YUbCiySwx60XK+QQTEDGo0EuwNSinsgKFRw7kTE+BY1qVqfC+fgZG
         A23yC1T8Q/yyCirPyllJM34r6QP9tMwm/BKnACrr+mW+n3SxiiSfRhXDdZ2uO+1MD5rq
         NTxgpMOmhmLkbGCqUW8piTKzESdstaRO4M7Ae/NZtpHLbQyt1SjrKS2HDq8T1+8KqfkI
         e/60xx+2ALmMk16z12GJGFWDKjSORsI6qPAO0XRf4WYcObA9Ohoxr62GDV0gHMzPtrur
         QnELBMnjNdmzzFcRf2PxqelTwpm78fbIEKrQEPITWBHZBHKRnD4NvWnMh1/9U2fN0z+O
         eB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5mU7ZW/EoX09OtoTGJHt6b6/ozCCsZy6iGJ/CCN76Y=;
        b=v4P0dWq6fdzKB18Go9eKHN+Tfjcm6Cui7hZXJH2mkFXNby9ag62j56oIqLDpFKdhYA
         eZjQblIjFBjcTWuUS84ijXBeVbXcRidkiIYRewzfWBIEs64Cz54XfFRIWMtuefkIvlEy
         VEXeNvPXNstiQwB7tubXzvt7skHfrOI/FU/eo0fOKb+98QgBoby5kejGnPhqvWXz3z/6
         C82fb3JsO6nhLzPN+PElxp67ra25mx6Ys1Eca6XxVajritWpsLW2ec7XFEdttvKcw2F9
         fQx/uOcuyBc32imwNpiT2m+O9lVN0fZTjxlEjz5Q8XZIGXa7cwQw2pIMreo/StljQFq+
         cQ0Q==
X-Gm-Message-State: AOAM532ee+RhxqUa6hov5PRGdIeVLs+ZMdBbLnnZ+NFPfTyAu9C3AUee
        Xpr+1UqBWvFdr8B+ufJwFhJTO/SvhSM=
X-Google-Smtp-Source: ABdhPJz2lqFLAeklW5sx87SpKy6K9X93Oh8qabnp2FfCGB6q33gBr+CYvfLC7bkUdicIifD8N1HRWA==
X-Received: by 2002:a5d:9651:0:b0:641:6371:fb77 with SMTP id d17-20020a5d9651000000b006416371fb77mr10796985ios.99.1647896134436;
        Mon, 21 Mar 2022 13:55:34 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q4-20020a056e0215c400b002c5fdff3087sm10962223ilu.29.2022.03.21.13.55.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:55:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] att: Rename att_debug and att_verbose to DBG and VERBOSE
Date:   Mon, 21 Mar 2022 13:55:29 -0700
Message-Id: <20220321205529.2469387-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321205529.2469387-1-luiz.dentz@gmail.com>
References: <20220321205529.2469387-1-luiz.dentz@gmail.com>
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

