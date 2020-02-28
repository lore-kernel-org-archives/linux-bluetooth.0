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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BBEC3F2D3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103C8246BA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9YE6H/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgB1XrR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:47:17 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:52738 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1XrR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 18:47:17 -0500
Received: by mail-pj1-f53.google.com with SMTP id ep11so1910637pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2020 15:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9MeUOiYNiKf6MLQmBNl/ygbA8CVOmtoSr1PMVUY3JEs=;
        b=d9YE6H/v/l/C1sK5nneHEp60x/ifEApV+tzj4vjjmiz2eu3kay8oe0dOU00tF37Qkt
         fWXkJGDJrE+sV78q3EwfhupUxyJK7MU2Zdhs2vi8k2tdQSi9SJ0Gnw7NClRs5iRrGUls
         a1qv6k6iZ98mnV3kC4/epNgN6gO6QFuCU8yXB1312YVDfp9CsFIlzY/9p1lPBfMwHyXs
         BkCpLMoRC3I6ONZhp1OcTKoN3JnkPU53fs0qvlpEODW0gN6uP1+wC3JblU2/qtagcJTK
         4si8hw56wuVqpuM6kF6rpgDqh5nxPgaxN9ew7KsoeY3Z3rIan9IWim2fYKPt2hb+Pk3K
         MgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9MeUOiYNiKf6MLQmBNl/ygbA8CVOmtoSr1PMVUY3JEs=;
        b=o54I69hwOUGMGikud7cYaR8HoreMQz7ODR2HlqTsO48525WGCUYMYWwS/YFByYrl4j
         RxMQPpppgWg6PDoRWuTNKROO07+GLk9fO8B4drBJOj1QRdunXoPsnf/gOX7vwMFSvsia
         WaaoiQ+nnx6PW0sKatUBcUudKT9swU75vL7gE2iQ6mr/fzPaOi/0ni6ClAGWrQlwR6E/
         EM++yl3XeI7HnF9OOYWSQl7MgKUYFf0e8AbwLZjxUuRPpMu2wbxToNsp93uo6ZwXGyja
         xxWH2D19xRka3k3t3lzo2QsD5BuYoC2Ic4FS3Ghz0OBQZ8bkr3U5I2gg3sV96G5PgGDN
         rT+A==
X-Gm-Message-State: APjAAAXj98ze6pWyzIXmyoKwhhuuJhuhQWyJ2t3kHVf7+JHisgRivhi/
        zaLAV39YDDsyq7z3iYNPJzfdaRZriv8=
X-Google-Smtp-Source: APXvYqwK3x3btGe2qQmUeWAVC7CuXBmRWM2gyJOMl+7hxT/8qj2GYwfcQ/sBcS0FequPAE18+Bk3LA==
X-Received: by 2002:a17:90a:a617:: with SMTP id c23mr7485620pjq.32.1582933634471;
        Fri, 28 Feb 2020 15:47:14 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q13sm13643954pfn.162.2020.02.28.15.47.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:47:13 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/12] gatt: Add support for Notify Multiple
Date:   Fri, 28 Feb 2020 15:46:59 -0800
Message-Id: <20200228234701.14614-11-luiz.dentz@gmail.com>
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
index 2445d1fa5..1b514aa4f 100644
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
index 7381f96e0..963ad619f 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1968,6 +1968,8 @@ static void write_client_features(struct bt_gatt_client *client)
 			client->features |= BT_GATT_CHRC_CLI_FEAT_EATT;
 	}
 
+	client->features |= BT_GATT_CHRC_CLI_FEAT_NFY_MULTI;
+
 	util_debug(client->debug_callback, client->debug_data,
 			"Writing Client Features 0x%02x", client->features);
 
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 8e81d6e0e..7e5d652e4 100644
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
@@ -1726,28 +1738,69 @@ bool bt_gatt_server_set_debug(struct bt_gatt_server *server,
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
index d94993b9c..36dd2847c 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2271,7 +2271,7 @@ static void test_server_notification(struct context *context)
 	const struct test_step *step = context->data->step;
 
 	bt_gatt_server_send_notification(context->server, step->handle,
-						step->value, step->length);
+					step->value, step->length, false);
 }
 
 static const struct test_step test_notification_server_1 = {
-- 
2.21.1

