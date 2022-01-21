Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9D3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 20:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiAUUy6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 15:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiAUUy6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 15:54:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B2BC06173B
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 12:54:57 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c3so9710930pls.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 12:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7+4JIuezm2ASlIUJy4Hq9LioKL5A046o9d+k5kWIPuc=;
        b=FU4qvtfRSJ7zlGQvHJfS5YEcpkWg6KQHtZwnX7xMUDA2kfo9yPtaVUCHWt4LVMu245
         j+pkZXm0xdfJDAGuxZDUSDX3eMqY7gOvJCMCgbxOcL4dkI3NE4RyEj4o6jLMWn3rp0A9
         JHwa7AhlE7p1r/CHvIB3J37rg7aQylWXpQbGwxP00DwIr5PGQ64NSuTaoKL4zsTMpRKq
         F9ID+KO2w+4GVgEv3/V9YUffcE4EozxWc9fXZo8s9bwIe3qUMau4RqqULozaRlBPtK0s
         VABpjGNz1JoDnyaSn0fbCcGp5TkJBhAFuqCjNj2Hk5JgA+gWCC6mtND+ulsDxLsFykmJ
         dFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+4JIuezm2ASlIUJy4Hq9LioKL5A046o9d+k5kWIPuc=;
        b=WF7lbEM2569CyNgOBvLnfBMH1LvIH4Kt8irfBAnSbTg+CaxyFVjCTUhlnqA377V9fP
         SxvNQKb/MU80C8JmDgONu1hRbjOABAcZY7oQIV2WantMr+dJmt06Tc5ClD/2WwNB44Nb
         Ul+8I5p/DjXjoq0kKitGouaubKjIAAThYSF4SmZhJK7KLYvGjVrfA8Ao4jI20EP+WrtN
         ISggOErnTShJz5RofokwXe8crSgeWOm7S5OYlTF8dZCnxBP8eIGvlXGBqC2riPrVf1ni
         yQPjXCRLscESr8Bgtcz18A7DokhPYZucJ9OQK/mGoYE9z1q5UlZMWieWApVBQbDOF1uw
         XqSw==
X-Gm-Message-State: AOAM533MS3ob5FpvY/RmkGlRfQcVsXQSyeCpmbQIYHgvdNDdcK5I0ake
        //D2vgG11BmhC7ubU3c30IGnHe9SBa4W/A==
X-Google-Smtp-Source: ABdhPJzJZ8lhr8PlmY2mO+w/6Vs/VGYzCoNjY9jhVIHnNpRYYqbbO2m2Fnbj27GZ8uJStMNhsovsQA==
X-Received: by 2002:a17:902:7c09:b0:148:e02f:176b with SMTP id x9-20020a1709027c0900b00148e02f176bmr5273432pll.130.1642798496877;
        Fri, 21 Jan 2022 12:54:56 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id j20sm7441279pfj.218.2022.01.21.12.54.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 12:54:56 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] gatt: Make use of gatt_db_service_add_ccc
Date:   Fri, 21 Jan 2022 12:54:52 -0800
Message-Id: <20220121205454.1413365-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121205454.1413365-1-luiz.dentz@gmail.com>
References: <20220121205454.1413365-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses gatt_db_service_add_ccc and gatt_db_ccc_register so any ccc
registered with the use of the former gets proper state tracking.
---
 src/gatt-database.c | 62 ++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index dbe9415a3..25641da8a 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1018,13 +1018,6 @@ static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
 		goto done;
 	}
 
-	ccc_cb = queue_find(database->ccc_callbacks, ccc_cb_match_handle,
-			UINT_TO_PTR(gatt_db_attribute_get_handle(attrib)));
-	if (!ccc_cb) {
-		ecode = BT_ATT_ERROR_UNLIKELY;
-		goto done;
-	}
-
 	if (len == 1)
 		val = *value;
 	else
@@ -1034,7 +1027,9 @@ static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
 	if (val == ccc->value)
 		goto done;
 
-	if (ccc_cb->callback) {
+	ccc_cb = queue_find(database->ccc_callbacks, ccc_cb_match_handle,
+			UINT_TO_PTR(gatt_db_attribute_get_handle(attrib)));
+	if (ccc_cb) {
 		struct pending_op *op;
 
 		op = pending_ccc_new(att, attrib, val,
@@ -1056,6 +1051,22 @@ done:
 	gatt_db_attribute_write_result(attrib, id, ecode);
 }
 
+static void ccc_add_cb(struct btd_gatt_database *database,
+			struct gatt_db_attribute *ccc,
+			btd_gatt_database_ccc_write_t callback,
+			void *user_data, btd_gatt_database_destroy_t destroy)
+{
+	struct ccc_cb_data *ccc_cb;
+
+	ccc_cb = new0(struct ccc_cb_data, 1);
+	ccc_cb->handle = gatt_db_attribute_get_handle(ccc);
+	ccc_cb->callback = callback;
+	ccc_cb->destroy = destroy;
+	ccc_cb->user_data = user_data;
+
+	queue_push_tail(database->ccc_callbacks, ccc_cb);
+}
+
 static struct gatt_db_attribute *
 service_add_ccc(struct gatt_db_attribute *service,
 				struct btd_gatt_database *database,
@@ -1064,34 +1075,14 @@ service_add_ccc(struct gatt_db_attribute *service,
 				btd_gatt_database_destroy_t destroy)
 {
 	struct gatt_db_attribute *ccc;
-	struct ccc_cb_data *ccc_cb;
-	bt_uuid_t uuid;
-
-	ccc_cb = new0(struct ccc_cb_data, 1);
-
-	/*
-	 * Provide a way for the permissions on a characteristic to dictate
-	 * the permissions on the CCC
-	 */
-	perm |= BT_ATT_PERM_READ | BT_ATT_PERM_WRITE;
-
-	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	ccc = gatt_db_service_add_descriptor(service, &uuid, perm,
-				gatt_ccc_read_cb, gatt_ccc_write_cb, database);
-	if (!ccc) {
-		error("Failed to create CCC entry in database");
-		free(ccc_cb);
-		return NULL;
-	}
-
-	gatt_db_attribute_set_fixed_length(ccc, 2);
 
-	ccc_cb->handle = gatt_db_attribute_get_handle(ccc);
-	ccc_cb->callback = write_callback;
-	ccc_cb->destroy = destroy;
-	ccc_cb->user_data = user_data;
+	ccc = gatt_db_service_add_ccc(service, perm);
+	if (!ccc)
+		return ccc;
 
-	queue_push_tail(database->ccc_callbacks, ccc_cb);
+	/* Only add ccc_cb if callback is set */
+	if (write_callback)
+		ccc_add_cb(database, ccc, write_callback, user_data, destroy);
 
 	return ccc;
 }
@@ -1310,6 +1301,9 @@ static void populate_devinfo_service(struct btd_gatt_database *database)
 
 static void register_core_services(struct btd_gatt_database *database)
 {
+	gatt_db_ccc_register(database->db, gatt_ccc_read_cb, gatt_ccc_write_cb,
+								database);
+
 	populate_gap_service(database);
 	populate_gatt_service(database);
 	populate_devinfo_service(database);
-- 
2.34.1

