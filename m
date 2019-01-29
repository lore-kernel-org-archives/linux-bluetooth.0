Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4FEC169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213F92147A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuHxFuxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfA2N0v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:26:51 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:33263 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfA2N0v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 08:26:51 -0500
Received: by mail-ed1-f49.google.com with SMTP id p6so16017141eds.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 05:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=J7uhUtEootXzSWc/VHDajLB7MO18Ec7bTzsGtorW4Zc=;
        b=AuHxFuxZNSqJTCvQQ4BOfrZ223uVxYiXzsxUANl/eaWzwQUqL6Iw26Fjq+WO3tRK1H
         Khz8fmLLjkd+H4MzxrqcXM7g6rcIhdVYt8AU77WgnbNujwuIa5gEsxVPFii9U8tTGlcA
         8cYT/c9U7jB9dqve8H3rH9sFVsPgs2Z4zGMBZ7FgyWM3uvxPrGcI8zKi0ealkf6eFl56
         B+t+sKYn6QY2xnCdnxzxcMTpnItUOC5ucbZMAR1IbJiQyG+MkUg02dC/Nxg4Af66JfN6
         egVs4arlQhyYGcHRg5InBMLBctxYi43oKSGJTzFDa5SP5dfx7ARIStc3rwreCfKOI/HU
         MK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=J7uhUtEootXzSWc/VHDajLB7MO18Ec7bTzsGtorW4Zc=;
        b=PlykxphRCgpE9EarNs9pTPRjrRboD6DI4BTy2QX5vvpxDPmivEa0UxGRpOtgbt+uWT
         jCJF41A/BHnh1QCCkfabDZqoGm8BKxqn613phmTGQlKj2hTU3hSTXOU1/t/f0fsSMdog
         7mgMyLf/Ddtm+hiSplsF1MxX3QU6LGvzXMCEsDkIWXK7W3uB9izVSy1C/Hgwmfg5xo0y
         5qQ4gOCLO1hqNOpy8Hn/+cbIPhN0AAQrlX+CJULV5Gi5FlNjLEmnc1d+ZsjbW20ZAHj1
         4rUSe3SEXI8LDLRdEUTY7EWLWRTfxNmzpNYs/JMllJdeHUdkOmBoyvZ/CqvsenrGH/dF
         oAAQ==
X-Gm-Message-State: AJcUukfJVfDp5m6c8sMnQUix3kSWFF8zrZ0VKTijqyJXjs2gFCovupcw
        YE6lBknuz1c0012MUYM6sUr0RGJD
X-Google-Smtp-Source: ALg8bN6DdrQlyFBjgkUAzCd5gy9Js+KyaKQulXHF9797PeqEB3WWieesPAATkAjKtQl3A0kyEutn3g==
X-Received: by 2002:a50:d797:: with SMTP id w23mr26250983edi.19.1548768408501;
        Tue, 29 Jan 2019 05:26:48 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id i14-v6sm8179964ejy.40.2019.01.29.05.26.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:26:47 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/15] gatt: Add caching support for server
Date:   Tue, 29 Jan 2019 15:26:28 +0200
Message-Id: <20190129132634.28786-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129132634.28786-1-luiz.dentz@gmail.com>
References: <20190129132634.28786-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This registers both Client Features and Database Hash Characteristics
which are mandatory for the server.
---
 src/gatt-database.c | 103 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 2c2f035b1..d72f2c781 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -86,6 +86,8 @@ struct btd_gatt_database {
 	struct queue *ccc_callbacks;
 	struct gatt_db_attribute *svc_chngd;
 	struct gatt_db_attribute *svc_chngd_ccc;
+	struct gatt_db_attribute *cli_feat;
+	struct gatt_db_attribute *db_hash;
 	struct queue *apps;
 	struct queue *profiles;
 };
@@ -177,6 +179,7 @@ struct device_state {
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
 	unsigned int disc_id;
+	uint8_t cli_feat[1];
 	struct queue *ccc_states;
 	struct notify *pending;
 };
@@ -1055,6 +1058,90 @@ service_add_ccc(struct gatt_db_attribute *service,
 	return ccc;
 }
 
+static void cli_feat_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct btd_gatt_database *database = user_data;
+	struct device_state *state;
+	uint8_t ecode = 0;
+	const uint8_t *value = NULL;
+	size_t len = 0;
+
+	DBG("Client Features read");
+
+	state = get_device_state(database, att);
+	if (!state) {
+		ecode = BT_ATT_ERROR_UNLIKELY;
+		goto done;
+	}
+
+	len = sizeof(state->cli_feat) - offset;
+	value = len ? &state->cli_feat[offset] : NULL;
+
+done:
+	gatt_db_attribute_read_result(attrib, id, ecode, value, len);
+}
+
+static void cli_feat_write_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct btd_gatt_database *database = user_data;
+	struct device_state *state;
+	uint8_t ecode = 0;
+
+	DBG("Client Features write");
+
+	state = get_device_state(database, att);
+	if (!state) {
+		ecode = BT_ATT_ERROR_UNLIKELY;
+		goto done;
+	}
+
+	if (!value || !len) {
+		ecode = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+		goto done;
+	}
+
+	/* A client shall never clear a bit it has set.
+	 * TODO: make it generic to any bits.
+	 */
+	if (state->cli_feat[0] & BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING &&
+			!(value[0] & BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING)) {
+		ecode = BT_ATT_ERROR_VALUE_NOT_ALLOWED;
+		goto done;
+	}
+
+	/* Shall we reallocate the feat array if bigger? */
+	len = MIN(sizeof(state->cli_feat), len);
+	while (len) {
+		state->cli_feat[len - 1] |= value[len -1];
+		len--;
+	}
+
+done:
+	gatt_db_attribute_write_result(attrib, id, ecode);
+}
+
+static void db_hash_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct btd_gatt_database *database = user_data;
+	const uint8_t *hash;
+
+	DBG("Database Hash read");
+
+	hash = gatt_db_get_hash(database->db);
+
+	gatt_db_attribute_read_result(attrib, id, 0, hash, 16);
+}
+
 static void populate_gatt_service(struct btd_gatt_database *database)
 {
 	bt_uuid_t uuid;
@@ -1062,7 +1149,7 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 
 	/* Add the GATT service */
 	bt_uuid16_create(&uuid, UUID_GATT);
-	service = gatt_db_add_service(database->db, &uuid, true, 4);
+	service = gatt_db_add_service(database->db, &uuid, true, 8);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
 	database->svc_chngd = gatt_db_service_add_characteristic(service, &uuid,
@@ -1072,11 +1159,25 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 	database->svc_chngd_ccc = service_add_ccc(service, database, NULL, NULL,
 									NULL);
 
+	bt_uuid16_create(&uuid, GATT_CHARAC_CLI_FEAT);
+	database->cli_feat = gatt_db_service_add_characteristic(service,
+				&uuid, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+				BT_GATT_CHRC_PROP_READ |
+				BT_GATT_CHRC_PROP_WRITE,
+				cli_feat_read_cb, cli_feat_write_cb,
+				database);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
+	database->db_hash = gatt_db_service_add_characteristic(service,
+				&uuid, BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
+				db_hash_read_cb, NULL, database);
+
 	gatt_db_service_set_active(service, true);
 
 	database_add_record(database, service);
 }
 
+
 static void register_core_services(struct btd_gatt_database *database)
 {
 	populate_gap_service(database);
-- 
2.17.2

