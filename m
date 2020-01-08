Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0974BC33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C971A206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpMIA+mE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgAHAeG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:34:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44922 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbgAHAeG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:34:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id 195so681261pfw.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y4EsnV3rmy2JYkmitLzzQFCHf6OSmOCvy3njIh0Di/Y=;
        b=SpMIA+mEdhRe4ZuYn63i+PSGWoxfJL6VxLOBIrzX3lppj7Jjp0pfU2e7hrf0MnCGD4
         n4tX3gVg+4xIOGaYsXBdKnYpSk3wWmAJHYjoQR4PTSBHL9ZEVOOjRMuslCy/TdGqrLwV
         WtL1YBVIrdsTIK6Vl1/XEXU+PvhB+Q4miOMkt9nyuFrHhxnWpKOCmWMKiuQ8ebE07i4v
         Eqo9xzsUMi0i+/gJa9oz5xeNtM3D/Uyn+/p/xV7XPpotAHoh8j3pPww8sv22Vg1ffObU
         7TXej3R3eCepc0tQb98MAoCyhvL1GVMlTvZlZtuO4PCBKWTdFCD3t3gu0o8EpVXz0rpn
         Ucrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y4EsnV3rmy2JYkmitLzzQFCHf6OSmOCvy3njIh0Di/Y=;
        b=nTo6y9eZgpXlLaOH7gNIZG1dgKu4kO+Xj0r+7vFp9umH17Z61/SdygHdk7yGTXnkU4
         d+jjpPfE6eboZLYivpIj1JlgGxsJhl1yHmZMI8b7NpTf4uFH45wotjooy757SQnoZxFO
         iCpcLmicT1HbN3luxu7zzYOnEYGeMaK2hUnxRNhPcUCRXecKUuTBJtzv+H58qtnW5QHZ
         phYs1oP/yHAf5QwVqQf5Q8JufInjVR0FZ2GyXlbdXwF32lKHVV10qfTQ1qjed4ki9V09
         pmP3+2S8KbI53G+Z4GJBdWex4YZDmrELN5kHLnG7olgy8e6a4IDtT2IWE7Ku7CrwAEUP
         B5Dg==
X-Gm-Message-State: APjAAAV50mq46lsZ8S4WZUqIMVxL3H/B4dC59dGFolflNLotIKsfpuo1
        JYKk8YYii/AuO6okNdYEXMER9+xI3nI=
X-Google-Smtp-Source: APXvYqxFq8bOpJ6Trziw20t4hw9gEgM04W+GGF0vq+WpgLlBC42zVWu2LeZa/ZnDjr0bHaFIWX2efA==
X-Received: by 2002:a63:66c6:: with SMTP id a189mr2164237pgc.401.1578443645038;
        Tue, 07 Jan 2020 16:34:05 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.34.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:34:04 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 20/22] gatt: Add support for Notify Multiple
Date:   Tue,  7 Jan 2020 16:33:40 -0800
Message-Id: <20200108003342.15458-21-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200108003342.15458-1-luiz.dentz@gmail.com>
References: <20200108003342.15458-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for Notify Multiple procedure marking its bit as
supported in the Client Features.
---
 src/gatt-database.c      |  8 +++--
 src/shared/att.c         |  3 +-
 src/shared/gatt-client.c |  2 ++
 src/shared/gatt-server.c | 77 +++++++++++++++++++++++++++++++++-------
 src/shared/gatt-server.h |  2 +-
 tools/btgatt-server.c    |  4 +--
 unit/test-gatt.c         |  2 +-
 7 files changed, 78 insertions(+), 20 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 47d32889d..d4c892113 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1011,7 +1011,7 @@ static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
 	if (ccc_cb->callback) {
 		struct pending_op *op;
 
-		op = pending_ccc_new(att, attrib, get_le16(value),
+		op = pending_ccc_new(att, attrib, val,
 					bt_att_get_link_type(att));
 		if (!op) {
 			ecode = BT_ATT_ERROR_UNLIKELY;
@@ -1098,7 +1098,8 @@ static void cli_feat_write_cb(struct gatt_db_attribute *attrib,
 	struct btd_gatt_database *database = user_data;
 	struct device_state *state;
 	uint8_t bits[] = { BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING,
-				BT_GATT_CHRC_CLI_FEAT_EATT };
+				BT_GATT_CHRC_CLI_FEAT_EATT,
+				BT_GATT_CHRC_CLI_FEAT_NFY_MULTI };
 	uint8_t ecode = 0;
 	unsigned int i;
 
@@ -1330,7 +1331,8 @@ static void send_notification_to_device(void *data, void *user_data)
 		DBG("GATT server sending notification");
 		bt_gatt_server_send_notification(server,
 					notify->handle, notify->value,
-					notify->len);
+					notify->len, device_state->cli_feat[0] &
+					BT_GATT_CHRC_CLI_FEAT_NFY_MULTI);
 		return;
 	}
 
diff --git a/src/shared/att.c b/src/shared/att.c
index 6fa16e422..948a5548b 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -145,6 +145,7 @@ static const struct {
 	{ BT_ATT_OP_EXEC_WRITE_REQ,		ATT_OP_TYPE_REQ },
 	{ BT_ATT_OP_EXEC_WRITE_RSP,		ATT_OP_TYPE_RSP },
 	{ BT_ATT_OP_HANDLE_NFY,			ATT_OP_TYPE_NFY },
+	{ BT_ATT_OP_HANDLE_NFY_MULT,		ATT_OP_TYPE_NFY },
 	{ BT_ATT_OP_HANDLE_IND,			ATT_OP_TYPE_IND },
 	{ BT_ATT_OP_HANDLE_CONF,		ATT_OP_TYPE_CONF },
 	{ }
@@ -842,7 +843,7 @@ static void handle_conf(struct bt_att_chan *chan, uint8_t *pdu, ssize_t pdu_len)
 	}
 
 	if (op->callback)
-		op->callback(BT_ATT_OP_HANDLE_NFY, NULL, 0, op->user_data);
+		op->callback(BT_ATT_OP_HANDLE_CONF, NULL, 0, op->user_data);
 
 	destroy_att_send_op(op);
 	chan->pending_ind = NULL;
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 8c563cdcc..596ab30ca 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1965,6 +1965,8 @@ static void write_client_features(struct bt_gatt_client *client)
 			client->features |= BT_GATT_CHRC_CLI_FEAT_EATT;
 	}
 
+	client->features |= BT_GATT_CHRC_CLI_FEAT_NFY_MULTI;
+
 	util_debug(client->debug_callback, client->debug_data,
 			"Writing Client Features 0x%02x", client->features);
 
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 0711f1d75..7a95fd4ce 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -36,6 +36,7 @@
 #include "src/shared/gatt-server.h"
 #include "src/shared/gatt-helpers.h"
 #include "src/shared/util.h"
+#include "src/shared/timeout.h"
 
 #ifndef MAX
 #define MAX(a, b) ((a) > (b) ? (a) : (b))
@@ -51,6 +52,8 @@
  */
 #define DEFAULT_MAX_PREP_QUEUE_LEN 30
 
+#define NFY_MULT_TIMEOUT 10
+
 struct async_read_op {
 	struct bt_att_chan *chan;
 	struct bt_gatt_server *server;
@@ -86,6 +89,13 @@ static void prep_write_data_destroy(void *user_data)
 	free(data);
 }
 
+struct nfy_mult_data {
+	unsigned int id;
+	uint8_t *pdu;
+	uint16_t offset;
+	uint16_t len;
+};
+
 struct bt_gatt_server {
 	struct gatt_db *db;
 	struct bt_att *att;
@@ -120,6 +130,8 @@ struct bt_gatt_server {
 
 	bt_gatt_server_authorize_cb_t authorize;
 	void *authorize_data;
+
+	struct nfy_mult_data *nfy_mult;
 };
 
 static void bt_gatt_server_free(struct bt_gatt_server *server)
@@ -1729,28 +1741,69 @@ bool bt_gatt_server_set_debug(struct bt_gatt_server *server,
 	return true;
 }
 
+static bool notify_multiple(void *user_data)
+{
+	struct bt_gatt_server *server = user_data;
+
+	bt_att_send(server->att, BT_ATT_OP_HANDLE_NFY_MULT,
+			server->nfy_mult->pdu, server->nfy_mult->offset, NULL,
+			NULL, NULL);
+
+	free(server->nfy_mult->pdu);
+	free(server->nfy_mult);
+	server->nfy_mult = NULL;
+
+	return false;
+}
+
 bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 					uint16_t handle, const uint8_t *value,
-					uint16_t length)
+					uint16_t length, bool multiple)
 {
-	uint16_t pdu_len;
-	uint8_t *pdu;
+	struct nfy_mult_data *data = NULL;
 	bool result;
 
 	if (!server || (length && !value))
 		return false;
 
-	pdu_len = MIN(bt_att_get_mtu(server->att) - 1, length + 2);
-	pdu = malloc(pdu_len);
-	if (!pdu)
-		return false;
+	if (multiple)
+		data = server->nfy_mult;
 
-	put_le16(handle, pdu);
-	memcpy(pdu + 2, value, pdu_len - 2);
+	if (!data) {
+		data = new0(struct nfy_mult_data, 1);
+		data->len = bt_att_get_mtu(server->att) - 1;
+		data->pdu = malloc(data->len);
+	}
 
-	result = !!bt_att_send(server->att, BT_ATT_OP_HANDLE_NFY, pdu,
-						pdu_len, NULL, NULL, NULL);
-	free(pdu);
+	put_le16(handle, data->pdu + data->offset);
+	data->offset += 2;
+
+	length = MIN(data->len - data->offset, length);
+
+	if (multiple) {
+		put_le16(length, data->pdu + data->offset);
+		data->offset += 2;
+	}
+
+	memcpy(data->pdu + data->offset, value, length);
+	data->offset += length;
+
+	if (multiple) {
+		if (!server->nfy_mult)
+			server->nfy_mult = data;
+
+		if (!server->nfy_mult->id)
+			server->nfy_mult->id = timeout_add(NFY_MULT_TIMEOUT,
+						   notify_multiple, server,
+						   NULL);
+
+		return true;
+	}
+
+	result = !!bt_att_send(server->att, BT_ATT_OP_HANDLE_NFY,
+				data->pdu, data->offset, NULL, NULL, NULL);
+	free(data->pdu);
+	free(data);
 
 	return result;
 }
diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
index c3d83f225..a2492d275 100644
--- a/src/shared/gatt-server.h
+++ b/src/shared/gatt-server.h
@@ -52,7 +52,7 @@ bool bt_gatt_server_set_authorize(struct bt_gatt_server *server,
 
 bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 					uint16_t handle, const uint8_t *value,
-					uint16_t length);
+					uint16_t length, bool multiple);
 
 bool bt_gatt_server_send_indication(struct bt_gatt_server *server,
 					uint16_t handle, const uint8_t *value,
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index d9d96e691..5b7857b00 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -305,7 +305,7 @@ static bool hr_msrmt_cb(void *user_data)
 
 	bt_gatt_server_send_notification(server->gatt,
 						server->hr_msrmt_handle,
-						pdu, len);
+						pdu, len, false);
 
 
 	cur_ee = server->hr_energy_expended;
@@ -831,7 +831,7 @@ static void cmd_notify(struct server *server, char *cmd_str)
 							conf_cb, NULL, NULL))
 			printf("Failed to initiate indication\n");
 	} else if (!bt_gatt_server_send_notification(server->gatt, handle,
-								value, length))
+							value, length, false))
 		printf("Failed to initiate notification\n");
 
 done:
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index d3f3dd696..a0b1d9844 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2263,7 +2263,7 @@ static void test_server_notification(struct context *context)
 	const struct test_step *step = context->data->step;
 
 	bt_gatt_server_send_notification(context->server, step->handle,
-						step->value, step->length);
+					step->value, step->length, false);
 }
 
 static const struct test_step test_notification_server_1 = {
-- 
2.21.0

