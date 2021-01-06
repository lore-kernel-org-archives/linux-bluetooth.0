Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6A4C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 00:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0088B22242
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 00:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbhAFA4k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAFA4j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jan 2021 19:56:39 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F97DC061796
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jan 2021 16:55:59 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n10so1027590pgl.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Jan 2021 16:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pNpY0c8f+E8GPcj4dhFQrX/MOC9P9C26OqCPtI+siss=;
        b=pgfjgFLa18tXfy3IvGKhxsegwSAYUZDZz8osfC2NQSWjaRBnqqSyjiFtSBvpf4jY+Y
         buQptqGvBDmTZ0Nl1O750LUkQ1xU7VQ20rZmL8mc+cAqTh18siNMRu5v1qd0d8r9wG7E
         HeGswQxf+d6WqZGizFh4FfoGxnae6g5gTIM7TKp8BY+zF4lwVB67abb1jRyH/Mhw65j2
         Vvuqzn994CgEAI6/ci9+HBU7Utfhf4crStkcb0imTgesAfFwkzERLKKM3FNCf8Rr6KmR
         3fPkvv7/17+c5v1SWLPvEYZMr7WOW3Jf4AB5mScHuscfD9XLydRAsarTE2JOcvoUqhb3
         Pe+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNpY0c8f+E8GPcj4dhFQrX/MOC9P9C26OqCPtI+siss=;
        b=LWpSOMRFe4GDBr2PsHkWasz8oVOibWvn8N7i3QZRgohryZ3b9vb6y3COoyHXPuM+tb
         taAHZJFnmokjJbq+uzAQmuDoH2PFvhhOitqSdGxGDvH4WiAqMMTQF3UFBk33e6qvnqeX
         iMKz0pWnFFUC3oIK/ViZK+wi7RlTk+obs0N29wOgqDA47n+PO+m6zVa8JOlzDvpZB8/V
         ko21EXSsZWly9kUJRdEnxaxs18CoQGwX1V4siJ39gHUuK21KizJURpkoZ0h4RJ5TOzdB
         trtfiydFqBfxkdgRHmyYDO+SuYgCOqeEudM6kH2Iz7ZVYy3NrJT84ePBglY+l/dNXw7h
         IHCw==
X-Gm-Message-State: AOAM532eWw0cAD2vIsMHSU6gWtA3nVyebpgqKhEvtcSQgc047abVh8/d
        ht3sDRD0yAjvCTFFHE9HdTn0RDFjYEk=
X-Google-Smtp-Source: ABdhPJyibt0qS1TTA8/Evxfx6k16q5ZS+vUibPfrEIpJKVGcnxlbQ2KaPRwTYdv9TI7QmHUncfcNhg==
X-Received: by 2002:a63:f21:: with SMTP id e33mr1849640pgl.84.1609894558852;
        Tue, 05 Jan 2021 16:55:58 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x28sm485439pff.182.2021.01.05.16.55.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 16:55:58 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gatt: Make use of gatt_db_attribute_set_fixed_length
Date:   Tue,  5 Jan 2021 16:55:56 -0800
Message-Id: <20210106005556.3550549-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210106005556.3550549-1-luiz.dentz@gmail.com>
References: <20210106005556.3550549-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of gatt_db_attribute_set_fixed_length so the database is
aware of the length of the values and perform bounds checking.
---
 src/gatt-database.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index f2d7b5821..b7d2bea1d 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -161,12 +161,14 @@ struct notify {
 	void *user_data;
 };
 
+#define CLI_FEAT_SIZE 1
+
 struct device_state {
 	struct btd_gatt_database *db;
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
 	unsigned int disc_id;
-	uint8_t cli_feat[1];
+	uint8_t cli_feat[CLI_FEAT_SIZE];
 	bool change_aware;
 	bool out_of_sync;
 	struct queue *ccc_states;
@@ -688,18 +690,12 @@ static void gap_appearance_read_cb(struct gatt_db_attribute *attrib,
 
 	dev_class = btd_adapter_get_class(database->adapter);
 
-	if (offset > 2) {
-		error = BT_ATT_ERROR_INVALID_OFFSET;
-		goto done;
-	}
-
 	appearance[0] = dev_class & 0x00ff;
 	appearance[1] = (dev_class >> 8) & 0x001f;
 
 	len -= offset;
 	value = len ? &appearance[offset] : NULL;
 
-done:
 	gatt_db_attribute_read_result(attrib, id, error, value, len);
 }
 
@@ -820,7 +816,7 @@ static void database_add_record(struct btd_gatt_database *database,
 static void populate_gap_service(struct btd_gatt_database *database)
 {
 	bt_uuid_t uuid;
-	struct gatt_db_attribute *service;
+	struct gatt_db_attribute *service, *attrib;
 
 	/* Add the GAP service */
 	bt_uuid16_create(&uuid, UUID_GAP);
@@ -839,10 +835,12 @@ static void populate_gap_service(struct btd_gatt_database *database)
 	 * Device Appearance characteristic.
 	 */
 	bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
-	gatt_db_service_add_characteristic(service, &uuid, BT_ATT_PERM_READ,
+	attrib = gatt_db_service_add_characteristic(service, &uuid,
+							BT_ATT_PERM_READ,
 							BT_GATT_CHRC_PROP_READ,
 							gap_appearance_read_cb,
 							NULL, database);
+	gatt_db_attribute_set_fixed_length(attrib, 2);
 
 	gatt_db_service_set_active(service, true);
 
@@ -865,11 +863,6 @@ static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
 
 	DBG("CCC read called for handle: 0x%04x", handle);
 
-	if (offset) {
-		ecode = BT_ATT_ERROR_INVALID_OFFSET;
-		goto done;
-	}
-
 	ccc = get_ccc_state(database, att, handle);
 	if (!ccc) {
 		ecode = BT_ATT_ERROR_UNLIKELY;
@@ -1046,6 +1039,8 @@ service_add_ccc(struct gatt_db_attribute *service,
 		return NULL;
 	}
 
+	gatt_db_attribute_set_fixed_length(ccc, 2);
+
 	ccc_cb->handle = gatt_db_attribute_get_handle(ccc);
 	ccc_cb->callback = write_callback;
 	ccc_cb->destroy = destroy;
@@ -1075,11 +1070,6 @@ static void cli_feat_read_cb(struct gatt_db_attribute *attrib,
 		goto done;
 	}
 
-	if (offset >= sizeof(state->cli_feat)) {
-		ecode = BT_ATT_ERROR_INVALID_OFFSET;
-		goto done;
-	}
-
 	len = sizeof(state->cli_feat) - offset;
 	value = len ? &state->cli_feat[offset] : NULL;
 
@@ -1208,6 +1198,7 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 				cli_feat_read_cb, cli_feat_write_cb,
 				database);
 
+	gatt_db_attribute_set_fixed_length(database->cli_feat, CLI_FEAT_SIZE);
 
 	/* Only expose database hash chrc if supported */
 	if (gatt_db_hash_support(database->db)) {
@@ -1215,6 +1206,7 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 		database->db_hash = gatt_db_service_add_characteristic(service,
 				&uuid, BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
 				db_hash_read_cb, NULL, database);
+		gatt_db_attribute_set_fixed_length(database->db_hash, 16);
 	}
 
 	/* Only enable EATT if there is a socket listening */
@@ -1223,6 +1215,7 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 		database->eatt = gatt_db_service_add_characteristic(service,
 				&uuid, BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
 				server_feat_read_cb, NULL, database);
+		gatt_db_attribute_set_fixed_length(database->eatt, 1);
 	}
 
 	gatt_db_service_set_active(service, true);
@@ -1254,12 +1247,15 @@ static void populate_devinfo_service(struct btd_gatt_database *database)
 	service = gatt_db_add_service(database->db, &uuid, true, 3);
 
 	if (btd_opts.did_source > 0) {
+		struct gatt_db_attribute *attrib;
+
 		bt_uuid16_create(&uuid, GATT_CHARAC_PNP_ID);
-		gatt_db_service_add_characteristic(service, &uuid,
+		attrib = gatt_db_service_add_characteristic(service, &uuid,
 						BT_ATT_PERM_READ,
 						BT_GATT_CHRC_PROP_READ,
 						device_info_read_pnp_id_cb,
 						NULL, database);
+		gatt_db_attribute_set_fixed_length(attrib, 7);
 	}
 
 	gatt_db_service_set_active(service, true);
-- 
2.26.2

