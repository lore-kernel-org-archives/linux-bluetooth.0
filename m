Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0095FEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 21:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjGXV1j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jul 2023 17:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGXV1h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jul 2023 17:27:37 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62235125
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 14:27:36 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-577ddda6ab1so71744977b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 14:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690234055; x=1690838855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6LA4V+YmdCfiyvWfCNoKpDYw2rK0pj+t+9AqFXmTaoI=;
        b=gEdidN53KzznZWXIa7WOo/6nwqiBoA3joNnsxDrgUOc+mXpufj+0MGIlztlv+n+wSX
         PdONeYSQhHfmng1xESKnt7kRjEBudgfDok9sw2WGduEFwcqx7gPgfkEX+0BffS+cMP//
         lIUKt0KNnqZstnpMDSgHU042sBao6GLnWi7VZ0EIByoCk0JapPKNzctmzONxWuf4Rh8k
         rCi64VwrfYn9p1mOR93+lHQle3zzob8GJC9plC/ZGFfayXp2xX/+0xg6wvUR0FPqL53y
         AqMUuRHjGlT/PbyG6muXjYjsdblCgPn2hNdRQyJqw24bcBq29HXBStHZiNNFEkOQarp8
         +F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234055; x=1690838855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LA4V+YmdCfiyvWfCNoKpDYw2rK0pj+t+9AqFXmTaoI=;
        b=DJD8cH5ksW9gvcFSlWJGah9Hj8hLJBXYJRuIE46zSDb6YoCr16+VUOeDrefcE1dRyy
         kmHjjOecPaDzBx53O34YillowTVEDfCCiKo41GZVWDScmlzzGLMKeH5GpmJ9gSkwgCB5
         y4noZ8kGNt+WKV9LibLtWpPUPtFGIhj3AtrshfU41tWtMqo8anMMcPRxXPlXXbZlvQYQ
         lD/qihErPwuScFHIGn22GFlQ+sado/SETilYKgAfrLfCKZAKZ+LyXQ9QBvuxd41cgekL
         VnaIs2xoe9pSFBCZtOWN0prZdsoYHwU4sPbfN5AnTQspJEVdyVSOld5CUzNI/H/ZiYYg
         mOkQ==
X-Gm-Message-State: ABy/qLb9VBu0Auq3VunvRauYG6Dm04F4OYfIlQhfKsnQPcR0nTz90UgL
        udiu+Rw1iDu8a1XwwsuQq3xbaBQ3jag=
X-Google-Smtp-Source: APBJJlGqWJOl3I7YjRF1Xqu0Dd/gjPWUr3zfWw4bHzMnBHmOgMlD4I/kwovaG49GQQ+ezsPd+YJ8xQ==
X-Received: by 2002:a81:92d4:0:b0:56d:4d1e:74ab with SMTP id j203-20020a8192d4000000b0056d4d1e74abmr570552ywg.23.1690234054744;
        Mon, 24 Jul 2023 14:27:34 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id w135-20020a0dd48d000000b0057d24f8278bsm3039128ywd.104.2023.07.24.14.27.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 14:27:33 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Fix not establishing a socket for each device
Date:   Mon, 24 Jul 2023 14:27:31 -0700
Message-ID: <20230724212731.848134-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

AcquireWrite and AcquireNotify shall establish a socket pair for each
device connected otherwise the application cannot distinct the
operations of each client.

Fixes: https://github.com/bluez/bluez/issues/460
---
 src/gatt-database.c | 160 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 138 insertions(+), 22 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 01dd84e8e3f7..7221ffc87f0d 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -110,6 +110,12 @@ struct external_profile {
 	struct queue *profiles; /* btd_profile list */
 };
 
+struct client_io {
+	struct bt_att *att;
+	unsigned int disconn_id;
+	struct io *io;
+};
+
 struct external_chrc {
 	struct external_service *service;
 	char *path;
@@ -119,8 +125,8 @@ struct external_chrc {
 	uint32_t perm;
 	uint32_t ccc_perm;
 	uint16_t mtu;
-	struct io *write_io;
-	struct io *notify_io;
+	struct queue *write_ios;
+	struct queue *notify_ios;
 	struct gatt_db_attribute *attrib;
 	struct gatt_db_attribute *ccc;
 	struct queue *pending_reads;
@@ -463,12 +469,22 @@ static void cancel_pending_write(void *data)
 	op->owner_queue = NULL;
 }
 
+static void client_io_free(void *data)
+{
+	struct client_io *client = data;
+
+	bt_att_unregister_disconnect(client->att, client->disconn_id);
+	bt_att_unref(client->att);
+	io_destroy(client->io);
+	free(client);
+}
+
 static void chrc_free(void *data)
 {
 	struct external_chrc *chrc = data;
 
-	io_destroy(chrc->write_io);
-	io_destroy(chrc->notify_io);
+	queue_destroy(chrc->write_ios, client_io_free);
+	queue_destroy(chrc->notify_ios, client_io_free);
 
 	queue_destroy(chrc->pending_reads, cancel_pending_read);
 	queue_destroy(chrc->pending_writes, cancel_pending_write);
@@ -2543,18 +2559,29 @@ static void flush_pending_writes(GDBusProxy *proxy,
 	queue_remove_all(owner_queue, NULL, NULL, NULL);
 }
 
+static bool match_client_io(const void *data, const void *user_data)
+{
+	const struct client_io *client = data;
+	const struct io *io = user_data;
+
+	return client->io == io;
+}
+
 static bool sock_hup(struct io *io, void *user_data)
 {
 	struct external_chrc *chrc = user_data;
+	struct client_io *client;
 
 	DBG("%p closed\n", io);
 
-	if (io == chrc->write_io)
-		chrc->write_io = NULL;
-	else
-		chrc->notify_io = NULL;
+	client = queue_remove_if(chrc->write_ios, match_client_io, io);
+	if (!client) {
+		client = queue_remove_if(chrc->notify_ios, match_client_io, io);
+		if (!client)
+			return false;
+	}
 
-	io_destroy(io);
+	client_io_free(client);
 
 	return false;
 }
@@ -2608,10 +2635,68 @@ static int sock_io_send(struct io *io, const void *data, size_t len)
 	return sendmsg(io_get_fd(io), &msg, MSG_NOSIGNAL);
 }
 
+static void att_disconnect_cb(int err, void *user_data)
+{
+	struct client_io *client = user_data;
+
+	/* If ATT is disconnected shutdown correspondent client IO so sock_hup
+	 * is triggered and the server socket is closed.
+	 */
+	io_shutdown(client->io);
+}
+
+static struct client_io *
+client_io_new(struct external_chrc *chrc, int fd, struct bt_att *att)
+{
+	struct client_io *client;
+
+	client = new0(struct client_io, 1);
+	client->att = bt_att_ref(att);
+	client->disconn_id = bt_att_register_disconnect(att, att_disconnect_cb,
+							client, NULL);
+	client->io = sock_io_new(fd, chrc);
+
+	return client;
+}
+
+static bool match_client_att(const void *data, const void *user_data)
+{
+	const struct client_io *client = data;
+	const struct bt_att *att = user_data;
+
+	/* Always match if ATT instance is not set since that is used by
+	 * clear_cc_state to clear all instances.
+	 */
+	if (!att)
+		return true;
+
+	return client->att == att;
+}
+
+static struct client_io *
+client_write_io_get(struct external_chrc *chrc, int fd, struct bt_att *att)
+{
+	struct client_io *client;
+
+	client = queue_find(chrc->write_ios, match_client_att, att);
+	if (client)
+		return client;
+
+	client = client_io_new(chrc, fd, att);
+
+	if (!chrc->write_ios)
+		chrc->write_ios = queue_new();
+
+	queue_push_tail(chrc->write_ios, client);
+
+	return client;
+}
+
 static void acquire_write_reply(DBusMessage *message, void *user_data)
 {
 	struct pending_op *op = user_data;
 	struct external_chrc *chrc;
+	struct client_io *client;
 	DBusError err;
 	int fd;
 	uint16_t mtu;
@@ -2651,10 +2736,12 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 
 	DBG("AcquireWrite success: fd %d MTU %u\n", fd, mtu);
 
-	chrc->write_io = sock_io_new(fd, chrc);
+	client = client_write_io_get(chrc, fd, op->att);
+	if (!client)
+		goto retry;
 
 	while ((op = queue_peek_head(chrc->pending_writes)) != NULL) {
-		if (sock_io_send(chrc->write_io, op->data.iov_base,
+		if (sock_io_send(client->io, op->data.iov_base,
 					op->data.iov_len) < 0)
 			goto retry;
 
@@ -2711,10 +2798,32 @@ static struct pending_op *acquire_write(struct external_chrc *chrc,
 	return NULL;
 }
 
+static struct client_io *
+client_notify_io_get(struct external_chrc *chrc, int fd, struct bt_att *att)
+{
+	struct client_io *client;
+
+	client = queue_find(chrc->notify_ios, match_client_att, att);
+	if (client)
+		return client;
+
+	client = client_io_new(chrc, fd, att);
+
+	io_set_read_handler(client->io, sock_io_read, chrc, NULL);
+
+	if (!chrc->notify_ios)
+		chrc->notify_ios = queue_new();
+
+	queue_push_tail(chrc->notify_ios, client);
+
+	return client;
+}
+
 static void acquire_notify_reply(DBusMessage *message, void *user_data)
 {
 	struct pending_op *op = user_data;
 	struct external_chrc *chrc = (void *) op->data.iov_base;
+	struct client_io *client;
 	DBusError err;
 	int fd;
 	uint16_t mtu;
@@ -2748,8 +2857,9 @@ static void acquire_notify_reply(DBusMessage *message, void *user_data)
 
 	DBG("AcquireNotify success: fd %d MTU %u\n", fd, mtu);
 
-	chrc->notify_io = sock_io_new(fd, chrc);
-	io_set_read_handler(chrc->notify_io, sock_io_read, chrc, NULL);
+	client = client_notify_io_get(chrc, fd, op->att);
+	if (!client)
+		goto retry;
 
 	__sync_fetch_and_add(&chrc->ntfy_cnt, 1);
 
@@ -2782,6 +2892,7 @@ static void acquire_notify_setup(DBusMessageIter *iter, void *user_data)
 static uint8_t ccc_write_cb(struct pending_op *op, void *user_data)
 {
 	struct external_chrc *chrc = user_data;
+	struct client_io *client;
 	DBusMessageIter iter;
 	uint16_t value;
 
@@ -2794,15 +2905,17 @@ static uint8_t ccc_write_cb(struct pending_op *op, void *user_data)
 		if (!chrc->ntfy_cnt)
 			goto done;
 
-		if (__sync_sub_and_fetch(&chrc->ntfy_cnt, 1))
-			goto done;
-
-		if (chrc->notify_io) {
-			io_destroy(chrc->notify_io);
-			chrc->notify_io = NULL;
+		client = queue_remove_if(chrc->notify_ios, match_client_att,
+							op ? op->att : NULL);
+		if (client) {
+			client_io_free(client);
+			__sync_sub_and_fetch(&chrc->ntfy_cnt, 1);
 			goto done;
 		}
 
+		if (__sync_sub_and_fetch(&chrc->ntfy_cnt, 1))
+			goto done;
+
 		/*
 		 * Send request to stop notifying. This is best-effort
 		 * operation, so simply ignore the return the value.
@@ -2822,7 +2935,8 @@ static uint8_t ccc_write_cb(struct pending_op *op, void *user_data)
 		(value == 2 && !(chrc->props & BT_GATT_CHRC_PROP_INDICATE)))
 		return BT_ERROR_CCC_IMPROPERLY_CONFIGURED;
 
-	if (chrc->notify_io) {
+	client = queue_find(chrc->notify_ios, match_client_att, op->att);
+	if (client) {
 		__sync_fetch_and_add(&chrc->ntfy_cnt, 1);
 		goto done;
 	}
@@ -3123,6 +3237,7 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 					void *user_data)
 {
 	struct external_chrc *chrc = user_data;
+	struct client_io *client;
 	struct btd_device *device;
 	struct queue *queue;
 	DBusMessageIter iter;
@@ -3158,8 +3273,9 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 	if (opcode == BT_ATT_OP_EXEC_WRITE_REQ)
 		chrc->prep_authorized = false;
 
-	if (chrc->write_io) {
-		if (sock_io_send(chrc->write_io, value, len) < 0) {
+	client = queue_find(chrc->write_ios, match_client_att, att);
+	if (client) {
+		if (sock_io_send(client->io, value, len) < 0) {
 			error("Unable to write: %s", strerror(errno));
 			goto fail;
 		}
-- 
2.41.0

