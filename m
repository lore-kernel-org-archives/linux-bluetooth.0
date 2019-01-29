Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46A0C169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1D82148E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2MoV6GH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfA2N05 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:26:57 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:41851 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfA2N04 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 08:26:56 -0500
Received: by mail-ed1-f45.google.com with SMTP id a20so15941147edc.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 05:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=mJlk2bTrvkMsvMMMkMsXtWQzlaBuMZwWwK9Wt22pCec=;
        b=e2MoV6GHJ5NcTEqZAeTiXxz/teWQawXjqdRw6/+tsUb6glEbwXQFb/ocgVOCUQVJIe
         z4MdvYGxjVNQJOX10XXpHzqch0sBIsz8cTBix90VkwOVCUOF5nenlsVEFiPAsG1SiJCL
         +3KYcbLRM0NfU3AXwGWqOrZrCyYJCCf8xpm0GvBm96SUyNpbj8uUsgHgUWoY6HQtHS82
         kp7IE5cW2NkEhn1Y/2IQzPtua7ML3re0En5amyETh7IriLoGAFpH3FaWmb58Q9f1UqB/
         IRyuMob6SPqXARjlpIgLfZD/ngv3GMphw3UEiCdfN2l7C6ifoyTHqYItGCS9VGsszutj
         prJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=mJlk2bTrvkMsvMMMkMsXtWQzlaBuMZwWwK9Wt22pCec=;
        b=rWAA8+qUmn99DEFUMxLuUJMBUcuAXYzvrxpNUpNhsIe9YbTuWJTuSMdyOjQgIeHRe2
         +nfuEqEGkJe6vdjAqDhDu4BzitT8f6grbK4qIgvFwaseD7mWArw/t9E/pLyzGFZYyfs5
         cCLL8DFlUy2EXWk1y9v+cvCF9V6QCV1dU3msIuIrOzcJjqzfz0lkHABlWPA3+SeZ0ULx
         SIJVoZa2ulLV/2UYGTG0H83CgYLEzDu1RwGM+ABxUYxL4/rfU4cL6iSgj/RQG7FYt3xb
         s5zP+8IctjOH2dEx7gnKh2POkik26cLz/5Xmj1YmQJs2xE4IsURINbIDlWXgVmktigTI
         3KXA==
X-Gm-Message-State: AJcUukf2tWcBSpct0XK6jcUcd3yeruhtdc1ZfAzqw8RMGiJPc8OTIoL/
        3SaNwzsL00s05pb4NSX7oOwwlPuK
X-Google-Smtp-Source: ALg8bN46wNOdGMNudWaTi4171aGw8NS+PVoP0amGBrb8E07dpnHs3i2gR22rMMzGSd395mvbQWgt/g==
X-Received: by 2002:a50:9849:: with SMTP id h9mr24375101edb.36.1548768412607;
        Tue, 29 Jan 2019 05:26:52 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id i14-v6sm8179964ejy.40.2019.01.29.05.26.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:26:51 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/15] gatt: Implement Robust Caching handling for server
Date:   Tue, 29 Jan 2019 15:26:31 +0200
Message-Id: <20190129132634.28786-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129132634.28786-1-luiz.dentz@gmail.com>
References: <20190129132634.28786-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This detects when a client becomes change-unware returning
DB Out of Sync error when that happens.
---
 src/device.c        |  2 +-
 src/gatt-database.c | 75 ++++++++++++++++++++++++++++++++++++++++++---
 src/gatt-database.h |  4 +--
 3 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index 79ede3729..060251f66 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4922,7 +4922,7 @@ static void gatt_server_init(struct btd_device *device,
 	bt_att_set_enc_key_size(device->att, device->ltk_enc_size);
 	bt_gatt_server_set_debug(device->server, gatt_debug, NULL, NULL);
 
-	btd_gatt_database_att_connected(database, device->att);
+	btd_gatt_database_server_connected(database, device->server);
 }
 
 static bool local_counter(uint32_t *sign_cnt, void *user_data)
diff --git a/src/gatt-database.c b/src/gatt-database.c
index d72f2c781..aecfa0e43 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -180,6 +180,8 @@ struct device_state {
 	uint8_t bdaddr_type;
 	unsigned int disc_id;
 	uint8_t cli_feat[1];
+	bool change_aware;
+	bool out_of_sync;
 	struct queue *ccc_states;
 	struct notify *pending;
 };
@@ -328,6 +330,7 @@ static void att_disconnected(int err, void *user_data)
 	DBG("");
 
 	state->disc_id = 0;
+	state->out_of_sync = false;
 
 	device = btd_adapter_find_device(state->db->adapter, &state->bdaddr,
 							state->bdaddr_type);
@@ -1119,10 +1122,13 @@ static void cli_feat_write_cb(struct gatt_db_attribute *attrib,
 	/* Shall we reallocate the feat array if bigger? */
 	len = MIN(sizeof(state->cli_feat), len);
 	while (len) {
-		state->cli_feat[len - 1] |= value[len -1];
+		state->cli_feat[len - 1] |= value[len - 1];
 		len--;
 	}
 
+	state->cli_feat[0] &= BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING;
+	state->change_aware = true;
+
 done:
 	gatt_db_attribute_write_result(attrib, id, ecode);
 }
@@ -1134,12 +1140,22 @@ static void db_hash_read_cb(struct gatt_db_attribute *attrib,
 {
 	struct btd_gatt_database *database = user_data;
 	const uint8_t *hash;
+	struct device_state *state;
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
 
 	DBG("Database Hash read");
 
 	hash = gatt_db_get_hash(database->db);
 
 	gatt_db_attribute_read_result(attrib, id, 0, hash, 16);
+
+	if (!get_dst_info(att, &bdaddr, &bdaddr_type))
+		return;
+
+	state = find_device_state(database, &bdaddr, bdaddr_type);
+	if (state)
+		state->change_aware = true;
 }
 
 static void populate_gatt_service(struct btd_gatt_database *database)
@@ -1197,7 +1213,14 @@ static void conf_cb(void *user_data)
 
 static void service_changed_conf(void *user_data)
 {
+	struct device_state *state = user_data;
+
 	DBG("");
+
+	if (!state)
+		return;
+
+	state->change_aware = true;
 }
 
 static void state_set_pending(struct device_state *state, struct notify *notify)
@@ -1239,6 +1262,14 @@ static void send_notification_to_device(void *data, void *user_data)
 	struct btd_device *device;
 	struct bt_gatt_server *server;
 
+	if (notify->conf == service_changed_conf) {
+		if (device_state->cli_feat[0] &
+				BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING) {
+			device_state->change_aware = false;
+			notify->user_data = device_state;
+		}
+	}
+
 	ccc = find_ccc_state(device_state, notify->ccc_handle);
 	if (!ccc)
 		return;
@@ -3352,6 +3383,40 @@ static const GDBusMethodTable manager_methods[] = {
 	{ }
 };
 
+static uint8_t server_authorize(struct bt_att *att, uint8_t opcode,
+					uint16_t handle, void *user_data)
+{
+	struct btd_gatt_database *database = user_data;
+	struct device_state *state;
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
+
+	if (!get_dst_info(att, &bdaddr, &bdaddr_type))
+		return 0;
+
+	/* Skip if there is no device state */
+	state = find_device_state(database, &bdaddr, bdaddr_type);
+	if (!state)
+		return 0;
+
+	/* Skip if client doesn't support Robust Caching */
+	if (!(state->cli_feat[0] & BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING))
+		return 0;
+
+	if (state->change_aware)
+		return 0;
+
+	if (state->out_of_sync) {
+		state->out_of_sync = false;
+		state->change_aware = true;
+		return 0;
+	}
+
+	state->out_of_sync = true;
+
+	return BT_ATT_ERROR_DB_OUT_OF_SYNC;
+}
+
 struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 {
 	struct btd_gatt_database *database;
@@ -3413,7 +3478,6 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 	if (!database->db_id)
 		goto fail;
 
-
 	return database;
 
 fail:
@@ -3442,9 +3506,10 @@ struct gatt_db *btd_gatt_database_get_db(struct btd_gatt_database *database)
 	return database->db;
 }
 
-void btd_gatt_database_att_connected(struct btd_gatt_database *database,
-						struct bt_att *att)
+void btd_gatt_database_server_connected(struct btd_gatt_database *database,
+						struct bt_gatt_server *server)
 {
+	struct bt_att *att = bt_gatt_server_get_att(server);
 	struct device_state *state;
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
@@ -3452,6 +3517,8 @@ void btd_gatt_database_att_connected(struct btd_gatt_database *database,
 	if (!get_dst_info(att, &bdaddr, &bdaddr_type))
 		return;
 
+	bt_gatt_server_set_authorize(server, server_authorize, database);
+
 	state = find_device_state(database, &bdaddr, bdaddr_type);
 	if (!state || !state->pending)
 		return;
diff --git a/src/gatt-database.h b/src/gatt-database.h
index a77a0fb20..154d3243f 100644
--- a/src/gatt-database.h
+++ b/src/gatt-database.h
@@ -23,9 +23,9 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter);
 void btd_gatt_database_destroy(struct btd_gatt_database *database);
 
 struct gatt_db *btd_gatt_database_get_db(struct btd_gatt_database *database);
-void btd_gatt_database_att_connected(struct btd_gatt_database *database,
-						struct bt_att *att);
 void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
 						struct btd_device *device);
+void btd_gatt_database_server_connected(struct btd_gatt_database *database,
+						struct bt_gatt_server *server);
 
 void btd_gatt_database_restore_svc_chng_ccc(struct btd_gatt_database *database);
-- 
2.17.2

