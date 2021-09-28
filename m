Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5913C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 23:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD59960C41
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 23:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243424AbhI1X4q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243378AbhI1X4b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 19:56:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A11C06174E
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 16:54:51 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g184so767469pgc.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 16:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rFJfo9UA7EWn0jdsuC56C4WB6j0tLZeUI4W8l+S6Oiw=;
        b=IbVqhA6WMQlqtfxV99nWGakpzBJbpCYmAV5mJiXE9Q34/TMnPytFhb8q2d6O19uqJJ
         cmQsp5IpNt//Qp4YRFGy4Cz/RU8LRCIdAK9+2Xsp+/QTqulpGKIMTvhSU3tO4khbTW/H
         o99iK1UNHgIMRtcLSIlCjABxtp1pqNIm0k2z6J3KUgifsGC6W+nBL1EuAMFS1gDOGGZs
         dSJd3FhAwcDmN3sy22Lu109U+B3hjJ/rNIW9wfr5EgqEamrq22Juwmzy9gHDz1AcA30q
         IBjWrxWtwFJB43GEeLpNlMG0FpFe/66t4FU+XIk3LOBgFmDocfutiUVxSBBBG4454JHO
         AG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFJfo9UA7EWn0jdsuC56C4WB6j0tLZeUI4W8l+S6Oiw=;
        b=jXK2okMOZW4s5s9ppIM/wPaZxVrDh/kOv/kDWTXj12mzrsV8y4K/+eu8gwf+/A0/zC
         /ldr+F4xTiXuItZWq3eC5P6fw3H8n5x9a+trrOFvGARV+sWAuStfQVCRH87o+Pz3I1Qy
         m1KMHbYs2XFmV+w188BcWdBUNdDapFymoxTgOPBMtwzQxFyBfuxCt7ZJtB9NcIBB5iy8
         GJCyO/rhdrNI0qiH7MKPSKTwOEpXSqK2P/we6GIsoKBrkBGLHaPgFDFNZf9/wv99VZrV
         GgPr3jPceux8IjITORyS+H9M6xRWZuwEF4uiZf3YvI8N2iKu/PEZ0FotNke4evLc87eb
         qa/w==
X-Gm-Message-State: AOAM532a55xMj4Fn3Hj5J1fUWll3loWwfP2+jLDz2IiUQNj3aJjxJ0N8
        dp+kIqcT+Y7ZjxELQDznoGREYNb5pws=
X-Google-Smtp-Source: ABdhPJy0TLiC9/+1N5gu+LFLe9ZvIQIZwmK0hyFH33tfvHbiUUDVdRVeEGXN1UoizBeI7gubilO7/g==
X-Received: by 2002:a63:790b:: with SMTP id u11mr6900751pgc.71.1632873290407;
        Tue, 28 Sep 2021 16:54:50 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o2sm3553139pja.7.2021.09.28.16.54.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:54:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] shared/att: Add bt_att_register_exchange
Date:   Tue, 28 Sep 2021 16:54:45 -0700
Message-Id: <20210928235447.3077055-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928235447.3077055-1-luiz.dentz@gmail.com>
References: <20210928235447.3077055-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_att_register_exchange which can be used to register
handlers that gets notified when the MTU gets changed via MTU exchange
procedure.
---
 src/shared/att.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/att.h |  6 ++++
 2 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 329497728..2387fe4c3 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -64,6 +64,7 @@ struct bt_att {
 
 	struct queue *notify_list;	/* List of registered callbacks */
 	struct queue *disconn_list;	/* List of disconnect handlers */
+	struct queue *exchange_list;	/* List of MTU changed handlers */
 
 	unsigned int next_send_id;	/* IDs for "send" ops */
 	unsigned int next_reg_id;	/* IDs for registered callbacks */
@@ -257,6 +258,14 @@ struct att_disconn {
 	void *user_data;
 };
 
+struct att_exchange {
+	unsigned int id;
+	bool removed;
+	bt_att_exchange_func_t callback;
+	bt_att_destroy_func_t destroy;
+	void *user_data;
+};
+
 static void destroy_att_disconn(void *data)
 {
 	struct att_disconn *disconn = data;
@@ -267,6 +276,16 @@ static void destroy_att_disconn(void *data)
 	free(disconn);
 }
 
+static void destroy_att_exchange(void *data)
+{
+	struct att_exchange *exchange = data;
+
+	if (exchange->destroy)
+		exchange->destroy(exchange->user_data);
+
+	free(exchange);
+}
+
 static bool match_disconn_id(const void *a, const void *b)
 {
 	const struct att_disconn *disconn = a;
@@ -1116,6 +1135,7 @@ static void bt_att_free(struct bt_att *att)
 	queue_destroy(att->write_queue, NULL);
 	queue_destroy(att->notify_list, NULL);
 	queue_destroy(att->disconn_list, NULL);
+	queue_destroy(att->exchange_list, NULL);
 	queue_destroy(att->chans, bt_att_chan_free);
 
 	free(att);
@@ -1242,6 +1262,7 @@ struct bt_att *bt_att_new(int fd, bool ext_signed)
 	att->write_queue = queue_new();
 	att->notify_list = queue_new();
 	att->disconn_list = queue_new();
+	att->exchange_list = queue_new();
 
 	bt_att_attach_chan(att, chan);
 
@@ -1357,6 +1378,18 @@ uint16_t bt_att_get_mtu(struct bt_att *att)
 	return att->mtu;
 }
 
+static void exchange_handler(void *data, void *user_data)
+{
+	struct att_exchange *exchange = data;
+	uint16_t mtu = PTR_TO_INT(user_data);
+
+	if (exchange->removed)
+		return;
+
+	if (exchange->callback)
+		exchange->callback(mtu, exchange->user_data);
+}
+
 bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu)
 {
 	struct bt_att_chan *chan;
@@ -1382,8 +1415,11 @@ bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu)
 	chan->mtu = mtu;
 	chan->buf = buf;
 
-	if (chan->mtu > att->mtu)
+	if (chan->mtu > att->mtu) {
 		att->mtu = chan->mtu;
+		queue_foreach(att->exchange_list, exchange_handler,
+						INT_TO_PTR(att->mtu));
+	}
 
 	return true;
 }
@@ -1474,6 +1510,61 @@ bool bt_att_unregister_disconnect(struct bt_att *att, unsigned int id)
 	return true;
 }
 
+unsigned int bt_att_register_exchange(struct bt_att *att,
+					bt_att_exchange_func_t callback,
+					void *user_data,
+					bt_att_destroy_func_t destroy)
+{
+	struct att_exchange *mtu;
+
+	if (!att || queue_isempty(att->chans))
+		return 0;
+
+	mtu = new0(struct att_exchange, 1);
+	mtu->callback = callback;
+	mtu->destroy = destroy;
+	mtu->user_data = user_data;
+
+	if (att->next_reg_id < 1)
+		att->next_reg_id = 1;
+
+	mtu->id = att->next_reg_id++;
+
+	if (!queue_push_tail(att->exchange_list, mtu)) {
+		free(att);
+		return 0;
+	}
+
+	return mtu->id;
+}
+
+bool bt_att_unregister_exchange(struct bt_att *att, unsigned int id)
+{
+	struct att_exchange *mtu;
+
+	if (!att || !id)
+		return false;
+
+	/* Check if disconnect is running */
+	if (queue_isempty(att->chans)) {
+		mtu = queue_find(att->exchange_list, match_disconn_id,
+							UINT_TO_PTR(id));
+		if (!mtu)
+			return false;
+
+		mtu->removed = true;
+		return true;
+	}
+
+	mtu = queue_remove_if(att->exchange_list, match_disconn_id,
+							UINT_TO_PTR(id));
+	if (!mtu)
+		return false;
+
+	destroy_att_exchange(mtu);
+	return true;
+}
+
 unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 				const void *pdu, uint16_t length,
 				bt_att_response_func_t callback, void *user_data,
@@ -1785,6 +1876,7 @@ bool bt_att_unregister_all(struct bt_att *att)
 
 	queue_remove_all(att->notify_list, NULL, NULL, destroy_att_notify);
 	queue_remove_all(att->disconn_list, NULL, NULL, destroy_att_disconn);
+	queue_remove_all(att->exchange_list, NULL, NULL, destroy_att_exchange);
 
 	return true;
 }
diff --git a/src/shared/att.h b/src/shared/att.h
index 03a450988..de136a066 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -43,6 +43,7 @@ typedef void (*bt_att_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_att_timeout_func_t)(unsigned int id, uint8_t opcode,
 							void *user_data);
 typedef void (*bt_att_disconnect_func_t)(int err, void *user_data);
+typedef void (*bt_att_exchange_func_t)(uint16_t mtu, void *user_data);
 typedef bool (*bt_att_counter_func_t)(uint32_t *sign_cnt, void *user_data);
 
 bool bt_att_set_debug(struct bt_att *att, uint8_t level,
@@ -88,6 +89,11 @@ unsigned int bt_att_register_disconnect(struct bt_att *att,
 					bt_att_destroy_func_t destroy);
 bool bt_att_unregister_disconnect(struct bt_att *att, unsigned int id);
 
+unsigned int bt_att_register_exchange(struct bt_att *att,
+					bt_att_exchange_func_t callback,
+					void *user_data,
+					bt_att_destroy_func_t destroy);
+bool bt_att_unregister_exchange(struct bt_att *att, unsigned int id);
 bool bt_att_unregister_all(struct bt_att *att);
 
 int bt_att_get_security(struct bt_att *att, uint8_t *enc_size);
-- 
2.31.1

