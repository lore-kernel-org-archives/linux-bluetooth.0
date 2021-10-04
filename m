Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2663FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 21:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045DE61207
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 21:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhJDV2o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Oct 2021 17:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbhJDV2n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Oct 2021 17:28:43 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EC1C061745
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 14:26:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h1so4916797pfv.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0LFhqWysW2hS0CwRftA7ot1mdwjwz66CUNLa+eEWHqw=;
        b=ckK92Der4jFXcIOqPjjXjI1LTic7UVLPJAda6CAuKEAr1NhgCEZEOtuRD8H5ltJISQ
         78scFKwITGSTyeyEF/jIRnCHcnmlntssa1+apPch9pY4kfXGzYn/ccdiraRUEd0L/Btz
         a0HS3H7174jHwJnq0eEdiclldNUd375pSG+PBDL/MUbzy3c2w06r3emzwYCTqbyqVdnw
         +iLhCwfgi1G9h9AX8vDgsiDzmgiTCDSi5cq3lQsL2GATnPZShhG0W9RJ8Fz0t5UP1WIJ
         vDeqtAf2ABjZ7NWSmASzRunMR0Tq3F5skzMvXfrAJdyVBlvLKs1Pd+/RBqo9PCtuV7C/
         rt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0LFhqWysW2hS0CwRftA7ot1mdwjwz66CUNLa+eEWHqw=;
        b=VJm4LwLDhKW9TU0tlB7dRDH7L3Tppd5dzPDFQusHV/VPc1irmKNpPgiHIN2+Mj5wLt
         9Mf7o1wGo+LD7NSl92333hDwWtGSul+Lqe8eYwKIWqzxi34bv7JrVKFt58xEP4sbVhra
         fTbxdcbFofre8MrwEMTGVZlARcz5LC3rpzpzvBoTrwQlEeiPjjbBVGYFMgw3rtUhnazz
         C+Kl6jvDKj4+AY64iCaLtt/ccUh22S9RvYYiE8VIy5h4CpB49xroHjwU7bm+rxcl636A
         Vgc/KphipbG4eFUr0AU1HU9oERHQM4m86N+QyNuSzzBWcqceHaumOr8HQB72Bsy2eg3I
         zpkQ==
X-Gm-Message-State: AOAM531JOdbjXXwcOnhm3+S1uTDb6bYhFVBbIk6y4qIoW4m9Hf2tzno+
        VY5XLgS4VBrVITqJ4s1HKQCHGTc318g=
X-Google-Smtp-Source: ABdhPJzMRMv1E6Nhhoo568ThDRm+4aBZE0Mb+HmT78CAQ684SGv8O5oCEmIiGVAEg9a7HviyX4CFSA==
X-Received: by 2002:a63:5604:: with SMTP id k4mr12956277pgb.340.1633382813740;
        Mon, 04 Oct 2021 14:26:53 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 126sm16722965pgi.86.2021.10.04.14.26.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 14:26:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 1/2] shared/att: Add bt_att_resend
Date:   Mon,  4 Oct 2021 14:26:51 -0700
Message-Id: <20211004212652.4074831-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_att_resend which can be used with procedures that needs to
send multiple PDUs to complete (e.g. Read Long, Write Long, etc.) so
they are pushed to the head instead of the tail of the queue so one can
retain its position on the queue.
---
 src/shared/att.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/att.h |  5 +++++
 2 files changed, 53 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 2387fe4c3..e99bc07c8 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1615,6 +1615,54 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 	return op->id;
 }
 
+int bt_att_resend(struct bt_att *att, unsigned int id, uint8_t opcode,
+				const void *pdu, uint16_t length,
+				bt_att_response_func_t callback,
+				void *user_data,
+				bt_att_destroy_func_t destroy)
+{
+	const struct queue_entry *entry;
+	struct att_send_op *op;
+	bool result;
+
+	if (!att || !id)
+		return -EINVAL;
+
+	/* Lookup request on each channel */
+	for (entry = queue_get_entries(att->chans); entry;
+						entry = entry->next) {
+		struct bt_att_chan *chan = entry->data;
+
+		if (chan->pending_req && chan->pending_req->id == id)
+			break;
+	}
+
+	if (!entry)
+		return -ENOENT;
+
+	/* Only allow requests to be resend */
+	if (get_op_type(opcode) != ATT_OP_TYPE_REQ)
+		return -EOPNOTSUPP;
+
+	op = create_att_send_op(att, opcode, pdu, length, callback, user_data,
+								destroy);
+	if (!op)
+		return -ENOMEM;
+
+	op->id = id;
+
+	result = queue_push_head(att->req_queue, op);
+	if (!result) {
+		free(op->pdu);
+		free(op);
+		return -ENOMEM;
+	}
+
+	wakeup_writer(att);
+
+	return 0;
+}
+
 unsigned int bt_att_chan_send(struct bt_att_chan *chan, uint8_t opcode,
 				const void *pdu, uint16_t len,
 				bt_att_response_func_t callback,
diff --git a/src/shared/att.h b/src/shared/att.h
index de136a066..4aa3de87b 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -63,6 +63,11 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 					bt_att_response_func_t callback,
 					void *user_data,
 					bt_att_destroy_func_t destroy);
+int bt_att_resend(struct bt_att *att, unsigned int id, uint8_t opcode,
+					const void *pdu, uint16_t length,
+					bt_att_response_func_t callback,
+					void *user_data,
+					bt_att_destroy_func_t destroy);
 unsigned int bt_att_chan_send(struct bt_att_chan *chan, uint8_t opcode,
 					const void *pdu, uint16_t len,
 					bt_att_response_func_t callback,
-- 
2.31.1

