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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01BBC3F2D5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2D6246B5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgvRXxk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgB1XrP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:47:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34448 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1XrO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 18:47:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id t3so2308023pgn.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2020 15:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fCeTaywODgjO8kmhS2KT8NC14kXxNHPxWVs5X0bXanE=;
        b=CgvRXxk9Fc9Qp/LaliGQtyUt6vmv+1gt9oiBAmaErQPzEfeBcLD2PFzgsTVW79mXpm
         5R06+WwoHN87tD9wvzuAmOHsyGHQJQVmZ4xd7M91suZLy0ZJVReCW8XfnvAu6nAoAIAO
         J4ZNj6qRfgtYasBaEK5qjHG39kk5lUzyBA3cr374LSilquqHgeoCU/DzNuZ94gbIFdWE
         h2/YagpAgvnY5PA9o+yXANX5ABwv59T1OIXirbtmE2dtbxe1muS5ntacZUGz0AgH+Hs1
         jp9SVSagkGZqbllzpULR52Fbaf68tgVUt3B4VexUseii8w8uVzpsF/FFUKLCUVvJOVer
         0BwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCeTaywODgjO8kmhS2KT8NC14kXxNHPxWVs5X0bXanE=;
        b=BiAjKMhCY2crh5MdZe0JIGO190ZM8gSsUU77gXVhPYJlTbJHq8+6ZW/SFa2BTXhD0j
         tJwsPpdNG1pUV2iMX54krk0BBfjFd9lYwHPlPFfUbbasPnGXwUkRL0XWTpDpesg0zr3c
         Tc0WT4VLCVcVa4OWpkDf5fGREkIaHc2d2zDN1N5Wo0Km8aK/KOtSRih/F0jLeYzMy7vr
         TCCSIvhaNokSxxxUfo/krRs8AMAecxF0wpW3bCNparAXK/SmLppwhJSKUbZqSgEpfasy
         l/5Dza7vP/I5ydGKmpoJgPU6TwNGINkjXGx1GXH4l25bG7yx9mIu6I6tF0b16RBJ3foX
         ty8Q==
X-Gm-Message-State: APjAAAVG7w0l5njRaBGqLL3XOrISXFu7Q6KHqaqRKgjPTIydZQpQUGwB
        cy98GFGay/POgoqx9egn3r/uIrohwQI=
X-Google-Smtp-Source: APXvYqyZvhR4V+GfmBc5XQgLy4gzf7Rczqc3R6p9qFvARX/fMErkJAC8XZ1zaFQY4zHdVWHEtWXS1w==
X-Received: by 2002:a63:a062:: with SMTP id u34mr7178395pgn.286.1582933633043;
        Fri, 28 Feb 2020 15:47:13 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q13sm13643954pfn.162.2020.02.28.15.47.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:47:12 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/12] shared/gatt: Add support for Handle Value Multiple Notifications
Date:   Fri, 28 Feb 2020 15:46:58 -0800
Message-Id: <20200228234701.14614-10-luiz.dentz@gmail.com>
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

Handle Value Multiple Notification can be used to notify multiple
values at once.
---
 src/shared/att-types.h   |  7 ++--
 src/shared/att.c         | 16 ++++-----
 src/shared/gatt-client.c | 76 ++++++++++++++++++++++++++--------------
 src/shared/gatt-server.c |  4 +--
 4 files changed, 64 insertions(+), 39 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index cc9cc9fd6..99b108990 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -72,11 +72,12 @@
 #define BT_ATT_OP_PREP_WRITE_RSP		0x17
 #define BT_ATT_OP_EXEC_WRITE_REQ		0x18
 #define BT_ATT_OP_EXEC_WRITE_RSP		0x19
-#define BT_ATT_OP_HANDLE_VAL_NOT		0x1B
-#define BT_ATT_OP_HANDLE_VAL_IND		0x1D
-#define BT_ATT_OP_HANDLE_VAL_CONF		0x1E
+#define BT_ATT_OP_HANDLE_NFY			0x1B
+#define BT_ATT_OP_HANDLE_IND			0x1D
+#define BT_ATT_OP_HANDLE_CONF			0x1E
 #define BT_ATT_OP_READ_MULT_VL_REQ		0x20
 #define BT_ATT_OP_READ_MULT_VL_RSP		0x21
+#define BT_ATT_OP_HANDLE_NFY_MULT		0x23
 
 /* Packed struct definitions for ATT protocol PDUs */
 /* TODO: Complete these definitions for all opcodes */
diff --git a/src/shared/att.c b/src/shared/att.c
index 56ea40c46..6fa16e422 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -110,7 +110,7 @@ enum att_op_type {
 	ATT_OP_TYPE_RSP,
 	ATT_OP_TYPE_CMD,
 	ATT_OP_TYPE_IND,
-	ATT_OP_TYPE_NOT,
+	ATT_OP_TYPE_NFY,
 	ATT_OP_TYPE_CONF,
 	ATT_OP_TYPE_UNKNOWN,
 };
@@ -144,9 +144,9 @@ static const struct {
 	{ BT_ATT_OP_PREP_WRITE_RSP,		ATT_OP_TYPE_RSP },
 	{ BT_ATT_OP_EXEC_WRITE_REQ,		ATT_OP_TYPE_REQ },
 	{ BT_ATT_OP_EXEC_WRITE_RSP,		ATT_OP_TYPE_RSP },
-	{ BT_ATT_OP_HANDLE_VAL_NOT,		ATT_OP_TYPE_NOT },
-	{ BT_ATT_OP_HANDLE_VAL_IND,		ATT_OP_TYPE_IND },
-	{ BT_ATT_OP_HANDLE_VAL_CONF,		ATT_OP_TYPE_CONF },
+	{ BT_ATT_OP_HANDLE_NFY,			ATT_OP_TYPE_NFY },
+	{ BT_ATT_OP_HANDLE_IND,			ATT_OP_TYPE_IND },
+	{ BT_ATT_OP_HANDLE_CONF,		ATT_OP_TYPE_CONF },
 	{ }
 };
 
@@ -530,7 +530,7 @@ static bool can_write_data(struct io *io, void *user_data)
 		chan->in_req = false;
 		/* fall through */
 	case ATT_OP_TYPE_CMD:
-	case ATT_OP_TYPE_NOT:
+	case ATT_OP_TYPE_NFY:
 	case ATT_OP_TYPE_CONF:
 	case ATT_OP_TYPE_UNKNOWN:
 	default:
@@ -842,7 +842,7 @@ static void handle_conf(struct bt_att_chan *chan, uint8_t *pdu, ssize_t pdu_len)
 	}
 
 	if (op->callback)
-		op->callback(BT_ATT_OP_HANDLE_VAL_CONF, NULL, 0, op->user_data);
+		op->callback(BT_ATT_OP_HANDLE_NFY, NULL, 0, op->user_data);
 
 	destroy_att_send_op(op);
 	chan->pending_ind = NULL;
@@ -1042,7 +1042,7 @@ static bool can_read_data(struct io *io, void *user_data)
 		chan->in_req = true;
 		/* fall through */
 	case ATT_OP_TYPE_CMD:
-	case ATT_OP_TYPE_NOT:
+	case ATT_OP_TYPE_NFY:
 	case ATT_OP_TYPE_UNKNOWN:
 	case ATT_OP_TYPE_IND:
 		/* fall through */
@@ -1492,7 +1492,7 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 		result = queue_push_tail(att->ind_queue, op);
 		break;
 	case ATT_OP_TYPE_CMD:
-	case ATT_OP_TYPE_NOT:
+	case ATT_OP_TYPE_NFY:
 	case ATT_OP_TYPE_UNKNOWN:
 	case ATT_OP_TYPE_RSP:
 	case ATT_OP_TYPE_CONF:
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 5b6723f97..7381f96e0 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -95,7 +95,7 @@ struct bt_gatt_client {
 	struct queue *notify_list;
 	struct queue *notify_chrcs;
 	int next_reg_id;
-	unsigned int disc_id, notify_id, ind_id;
+	unsigned int disc_id, nfy_id, nfy_mult_id, ind_id;
 
 	/*
 	 * Handles of the GATT Service and the Service Changed characteristic
@@ -2072,9 +2072,10 @@ done:
 	return true;
 }
 
-struct pdu_data {
-	const void *pdu;
-	uint16_t length;
+struct value_data {
+	uint16_t handle;
+	uint16_t len;
+	const void *data;
 };
 
 static void disable_ccc_callback(uint8_t opcode, const void *pdu,
@@ -2125,25 +2126,18 @@ done:
 static void notify_handler(void *data, void *user_data)
 {
 	struct notify_data *notify_data = data;
-	struct pdu_data *pdu_data = user_data;
-	uint16_t value_handle;
-	const uint8_t *value = NULL;
-
-	value_handle = get_le16(pdu_data->pdu);
+	struct value_data *value_data = user_data;
 
-	if (notify_data->chrc->value_handle != value_handle)
+	if (notify_data->chrc->value_handle != value_data->handle)
 		return;
 
-	if (pdu_data->length > 2)
-		value = pdu_data->pdu + 2;
-
 	/*
 	 * Even if the notify data has a pending ATT request to write to the
 	 * CCC, there is really no reason not to notify the handlers.
 	 */
 	if (notify_data->notify)
-		notify_data->notify(value_handle, value, pdu_data->length - 2,
-							notify_data->user_data);
+		notify_data->notify(value_data->handle, value_data->data,
+				value_data->len, notify_data->user_data);
 }
 
 static void notify_cb(struct bt_att_chan *chan, uint8_t opcode,
@@ -2151,18 +2145,42 @@ static void notify_cb(struct bt_att_chan *chan, uint8_t opcode,
 					void *user_data)
 {
 	struct bt_gatt_client *client = user_data;
-	struct pdu_data pdu_data;
+	struct value_data data;
 
 	bt_gatt_client_ref(client);
 
-	memset(&pdu_data, 0, sizeof(pdu_data));
-	pdu_data.pdu = pdu;
-	pdu_data.length = length;
+	memset(&data, 0, sizeof(data));
+
+	if (opcode == BT_ATT_OP_HANDLE_NFY_MULT) {
+		while (length >= 4) {
+			data.handle = get_le16(pdu);
+			length -= 2;
+			pdu += 2;
+
+			data.len = get_le16(pdu);
+			length -= 2;
+			pdu += 2;
+
+			data.data = pdu;
+
+			queue_foreach(client->notify_list, notify_handler,
+								&data);
 
-	queue_foreach(client->notify_list, notify_handler, &pdu_data);
+			length -= data.len;
+		}
+	} else {
+		data.handle = get_le16(pdu);
+		length -= 2;
+		pdu += 2;
+
+		data.len = length;
+		data.data = pdu;
 
-	if (opcode == BT_ATT_OP_HANDLE_VAL_IND && !client->parent)
-		bt_att_chan_send(chan, BT_ATT_OP_HANDLE_VAL_CONF, NULL, 0,
+		queue_foreach(client->notify_list, notify_handler, &data);
+	}
+
+	if (opcode == BT_ATT_OP_HANDLE_IND && !client->parent)
+		bt_att_chan_send(chan, BT_ATT_OP_HANDLE_CONF, NULL, 0,
 							NULL, NULL, NULL);
 
 	bt_gatt_client_unref(client);
@@ -2181,7 +2199,8 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 
 	if (client->att) {
 		bt_att_unregister_disconnect(client->att, client->disc_id);
-		bt_att_unregister(client->att, client->notify_id);
+		bt_att_unregister(client->att, client->nfy_id);
+		bt_att_unregister(client->att, client->nfy_mult_id);
 		bt_att_unregister(client->att, client->ind_id);
 		bt_att_unref(client->att);
 	}
@@ -2239,12 +2258,17 @@ static struct bt_gatt_client *gatt_client_new(struct gatt_db *db,
 	client->notify_chrcs = queue_new();
 	client->pending_requests = queue_new();
 
-	client->notify_id = bt_att_register(att, BT_ATT_OP_HANDLE_VAL_NOT,
+	client->nfy_id = bt_att_register(att, BT_ATT_OP_HANDLE_NFY,
+						notify_cb, client, NULL);
+	if (!client->nfy_id)
+		goto fail;
+
+	client->nfy_mult_id = bt_att_register(att, BT_ATT_OP_HANDLE_NFY_MULT,
 						notify_cb, client, NULL);
-	if (!client->notify_id)
+	if (!client->nfy_mult_id)
 		goto fail;
 
-	client->ind_id = bt_att_register(att, BT_ATT_OP_HANDLE_VAL_IND,
+	client->ind_id = bt_att_register(att, BT_ATT_OP_HANDLE_IND,
 						notify_cb, client, NULL);
 	if (!client->ind_id)
 		goto fail;
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 8b18cb21f..8e81d6e0e 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1745,7 +1745,7 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 	put_le16(handle, pdu);
 	memcpy(pdu + 2, value, pdu_len - 2);
 
-	result = !!bt_att_send(server->att, BT_ATT_OP_HANDLE_VAL_NOT, pdu,
+	result = !!bt_att_send(server->att, BT_ATT_OP_HANDLE_NFY, pdu,
 						pdu_len, NULL, NULL, NULL);
 	free(pdu);
 
@@ -1806,7 +1806,7 @@ bool bt_gatt_server_send_indication(struct bt_gatt_server *server,
 	put_le16(handle, pdu);
 	memcpy(pdu + 2, value, pdu_len - 2);
 
-	result = !!bt_att_send(server->att, BT_ATT_OP_HANDLE_VAL_IND, pdu,
+	result = !!bt_att_send(server->att, BT_ATT_OP_HANDLE_IND, pdu,
 							pdu_len, conf_cb,
 							data, destroy_ind_data);
 	if (!result)
-- 
2.21.1

