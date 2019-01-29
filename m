Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9F3C282D0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230102147A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZLDarwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfA2N05 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:26:57 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:36515 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfA2N05 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 08:26:57 -0500
Received: by mail-ed1-f42.google.com with SMTP id f23so15963660edb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 05:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=UAtv7TOrkQDAbkzDsD/saBzd9wZrhlBrAa1rNJHZvwE=;
        b=bZLDarwpx/EOOYXPx6QJzcsKzr0sqN+P0nc/ynF/0VdTvBAORCJrKzYyK4DykZbGhr
         QJaAQpqBdZMhCne0K8xOJsBN/Q/lv1YV2PT9eo7wY+m7doVB6Iuo4oJ9lg/eqPy7nD1I
         LYEhL7KjVuwbDdaz3X7InmHn6DzB1/XDWMKgAOHR7e48ItI87Z6wRfFfxcPgbTibIXxl
         0cS7ELEFrKPtrgq8SBSRm8Sz2ijEamkOwiBu2Ubf1nl33f1cAPPHTFAZxyxZvfm/Akzj
         TnWGo/wwQIhpXsKsvgqVRp6G5LSuo66i3vSrCycidSD+y30cp1JOlcq07rM6ej8L1Mj+
         Wlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=UAtv7TOrkQDAbkzDsD/saBzd9wZrhlBrAa1rNJHZvwE=;
        b=WaHBQsHSxsO+UYFQC6Y+VMN81stfjJc87zkW4aEE59GAeaHr/CSc7YTCOHKWkZxfLQ
         yQOv9LgOIMymuwPH4iEFlMsbKmd6lfXCsIlskXXt9uM9rlkekyWzyykzUSSAD2XP2CBg
         H+bcTjQQAlhWlWox7JjjC5Dm7UmXnkvQsZtH0Qn7t+2eogx8pJnB3tV2erL+sExB+y6q
         4rxPemPhksjXOedGwUwhIkfRYEEHtv4zAEvSL6AyQKiV4fse2FU5NqlWH8SVdwx+D12x
         scH91a7bOVbTgXyPFm0nsCAhvzM9X4reSmjvKfynVonCkNi6bC0CZDwmAdAayytuQgoY
         4Gbg==
X-Gm-Message-State: AJcUukfcL9Z6gp2RBeUYKkrS1KPbOkr3KUfTneJjnx2kkb1gsmVJl5hb
        36CPAqpJZU4p6TTZhkVvgRqbPoFq
X-Google-Smtp-Source: ALg8bN7B0nml+oL7GWRYz1C3ceNju+2ePZLWUH7igksxyl2yqb8/kQEV587E8fw0uZyqhfvoFgSw4A==
X-Received: by 2002:a50:b172:: with SMTP id l47mr25020355edd.225.1548768415297;
        Tue, 29 Jan 2019 05:26:55 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id i14-v6sm8179964ejy.40.2019.01.29.05.26.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:26:54 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/15] shared/gatt-client: Read database hash if available
Date:   Tue, 29 Jan 2019 15:26:32 +0200
Message-Id: <20190129132634.28786-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129132634.28786-1-luiz.dentz@gmail.com>
References: <20190129132634.28786-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reads the database hash if available and compares to the existing
value, if it matches consider the discovery is completed.
---
 src/shared/gatt-client.c | 177 +++++++++++++++++++++++++++++++++------
 1 file changed, 152 insertions(+), 25 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 3c2aa293b..d5f9b1294 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -325,6 +325,7 @@ struct discovery_op {
 	struct queue *pending_chrcs;
 	struct queue *ext_prop_desc;
 	struct gatt_db_attribute *cur_svc;
+	struct gatt_db_attribute *hash;
 	bool success;
 	uint16_t start;
 	uint16_t end;
@@ -349,11 +350,19 @@ static void discovery_op_free(struct discovery_op *op)
 	free(op);
 }
 
+static bool read_db_hash(struct discovery_op *op);
+
 static void discovery_op_complete(struct discovery_op *op, bool success,
 								uint8_t err)
 {
 	const struct queue_entry *svc;
 
+	op->success = success;
+
+	/* Read database hash if discovery has been successful */
+	if (success && read_db_hash(op))
+		return;
+
 	/*
 	 * Unregister remove callback so it is not called when clearing unused
 	 * range.
@@ -380,7 +389,6 @@ static void discovery_op_complete(struct discovery_op *op, bool success,
 	if (op->last != UINT16_MAX)
 		gatt_db_clear_range(op->client->db, op->last + 1, UINT16_MAX);
 
-	op->success = success;
 	op->complete_func(op, success, err);
 }
 
@@ -1249,6 +1257,139 @@ static void notify_client_ready(struct bt_gatt_client *client, bool success,
 	bt_gatt_client_unref(client);
 }
 
+static void discover_all(struct discovery_op *op)
+{
+	struct bt_gatt_client *client = op->client;
+
+	client->discovery_req = bt_gatt_discover_all_primary_services(
+							client->att, NULL,
+							discover_primary_cb,
+							discovery_op_ref(op),
+							discovery_op_unref);
+	if (client->discovery_req)
+		return;
+
+	util_debug(client->debug_callback, client->debug_data,
+			"Failed to initiate primary service discovery");
+
+	client->in_init = false;
+	notify_client_ready(client, false, BT_ATT_ERROR_UNLIKELY);
+
+	discovery_op_unref(op);
+}
+
+static void db_hash_write_value_cb(struct gatt_db_attribute *attrib,
+						int err, void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+
+	util_debug(client->debug_callback, client->debug_data,
+						"Value set status: %d", err);
+}
+
+static void db_hash_read_value_cb(struct gatt_db_attribute *attrib,
+						int err, const uint8_t *value,
+						size_t length, void *user_data)
+{
+	const uint8_t **hash = user_data;
+
+	if (err || (length != 16))
+		return;
+
+	*hash = value;
+}
+
+static void db_hash_read_cb(bool success, uint8_t att_ecode,
+						struct bt_gatt_result *result,
+						void *user_data)
+{
+	struct discovery_op *op = user_data;
+	struct bt_gatt_client *client = op->client;
+	const uint8_t *hash = NULL, *value;
+	uint16_t len, handle;
+	struct bt_gatt_iter iter;
+
+	if (!success)
+		goto discover;
+
+	bt_gatt_iter_init(&iter, result);
+	bt_gatt_iter_next_read_by_type(&iter, &handle, &len, &value);
+
+	util_debug(client->debug_callback, client->debug_data,
+				"DB Hash found: handle 0x%04x length 0x%04x",
+				handle, len);
+
+	if (len != 16)
+		goto discover;
+
+	/* Read stored value in the db */
+	gatt_db_attribute_read(op->hash, 0, BT_ATT_OP_READ_REQ, NULL,
+					db_hash_read_value_cb, &hash);
+
+	/* Check if the has has changed since last time */
+	if (hash && !memcmp(hash, value, len)) {
+		util_debug(client->debug_callback, client->debug_data,
+				"DB Hash match: skipping discovery");
+		queue_remove_all(op->pending_svcs, NULL, NULL, NULL);
+		discovery_op_complete(op, true, 0);
+		return;
+	}
+
+	util_debug(client->debug_callback, client->debug_data,
+						"DB Hash value:");
+	util_hexdump(' ', value, len, client->debug_callback,
+						client->debug_data);
+
+	/* Store the new hash in the db */
+	gatt_db_attribute_write(op->hash, 0, value, len, 0, NULL,
+					db_hash_write_value_cb, client);
+
+discover:
+	if (!op->success) {
+		discover_all(op);
+		return;
+	}
+
+	discovery_op_complete(op, true, 0);
+}
+
+static void get_first_attribute(struct gatt_db_attribute *attrib,
+								void *user_data)
+{
+	struct gatt_db_attribute **stored = user_data;
+
+	if (*stored)
+		return;
+
+	*stored = attrib;
+}
+
+static bool read_db_hash(struct discovery_op *op)
+{
+	struct bt_gatt_client *client = op->client;
+	bt_uuid_t uuid;
+
+	/* Check if hash was already read */
+	if (op->hash)
+		return false;
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
+	gatt_db_find_by_type(client->db, 0x0001, 0xffff, &uuid,
+						get_first_attribute, &op->hash);
+	if (!op->hash)
+		return false;
+
+	if (!bt_gatt_read_by_type(client->att, 0x0001, 0xffff, &uuid,
+							db_hash_read_cb,
+							discovery_op_ref(op),
+							discovery_op_unref)) {
+		discovery_op_unref(op);
+		return false;
+	}
+
+	return true;
+}
+
 static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 {
 	struct discovery_op *op = user_data;
@@ -1282,21 +1423,12 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 					bt_att_get_mtu(client->att));
 
 discover:
-	client->discovery_req = bt_gatt_discover_all_primary_services(
-							client->att, NULL,
-							discover_primary_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
-	if (client->discovery_req)
+	if (read_db_hash(op)) {
+		op->success = false;
 		return;
+	}
 
-	util_debug(client->debug_callback, client->debug_data,
-			"Failed to initiate primary service discovery");
-
-	client->in_init = false;
-	notify_client_ready(client, false, att_ecode);
-
-	discovery_op_unref(op);
+	discover_all(op);
 }
 
 struct service_changed_op {
@@ -1491,17 +1623,6 @@ static unsigned int register_notify(struct bt_gatt_client *client,
 	return notify_data->id;
 }
 
-static void get_first_attribute(struct gatt_db_attribute *attrib,
-								void *user_data)
-{
-	struct gatt_db_attribute **stored = user_data;
-
-	if (*stored)
-		return;
-
-	*stored = attrib;
-}
-
 static void service_changed_register_cb(uint16_t att_ecode, void *user_data)
 {
 	bool success;
@@ -1747,6 +1868,11 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 	return true;
 
 discover:
+	if (read_db_hash(op)) {
+		op->success = false;
+		goto done;
+	}
+
 	client->discovery_req = bt_gatt_discover_all_primary_services(
 							client->att, NULL,
 							discover_primary_cb,
@@ -1757,6 +1883,7 @@ discover:
 		return false;
 	}
 
+done:
 	client->in_init = true;
 	return true;
 }
-- 
2.17.2

