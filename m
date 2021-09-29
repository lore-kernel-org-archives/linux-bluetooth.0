Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA727C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 18:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD1C61440
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 18:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhI2SDl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 14:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhI2SDl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 14:03:41 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E1EC06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 11:01:59 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 138so3158618qko.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starry.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UkfiPPr226wJ3TN0lj5br9fnEOEAxLutQs+qhcYfCjM=;
        b=qvR5cP5YU/mhXg+sStbTUMbYA4OM+NBBZD9zSVE09TqeWxAQKHlr9j5MwMBDF+dWMc
         d9tiyjYgSLHMQkk9zEDciQhV9uMZZEoaRKrOzZ9H1y7lb5LPez7Piy8Tc/JEfXXL/tb9
         Mdwb4nlAjch5sHK6/dCBxX1nF+wJOw6OMl3mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UkfiPPr226wJ3TN0lj5br9fnEOEAxLutQs+qhcYfCjM=;
        b=ETpVDRhjgEnpySv/rv7bfNL1gfh6fsjESQfWXutgiSFq7M7Bk69c/Dj/fwhKVBYdRo
         KDWGXfpyKNLCbiC2ku8SU2C/egvDRxF1EdJwTRQpcJochQBDBSIW/yfWEtQ0gu5TlxDq
         FQ+Ru6cDXLX4rdf66MhiRQHLCVTXXk/hsvvVbEkmVBZgpZGl9fYE7W0vNTWZxlR5LhPg
         /dY4H4NOxdgwUxGJwrFfhLplvZxhbKgQ50f7xRTC6+0qJpT/R5cetXfi0wqCFFIV4Frz
         r7BAnIF7HbyJfj4OgWA0qCp+bnYRuFQ1eM4jnltrDZUTq8kKiovj7gf5bGSR7e9ni1yf
         pmxQ==
X-Gm-Message-State: AOAM531bx2P9l7UQX5QW2ThdfIkwN4cqeGMPEdPUwXUJTuu6uV22KpiO
        YS3Fdvl79s1LTl0CUDvxvr4EDFUgW1h9xEMY
X-Google-Smtp-Source: ABdhPJxLuCTutC1t94wq400V8JHhkqX09SAPFT3Mh/wp3P16lLzEMDHrh8+n1QbogmhMxrfnXgVWXw==
X-Received: by 2002:a05:620a:288f:: with SMTP id j15mr1085526qkp.280.1632938518920;
        Wed, 29 Sep 2021 11:01:58 -0700 (PDT)
Received: from MrComputer.nevonetnext (205-201-16-55.starry-inc.net. [205.201.16.55])
        by smtp.gmail.com with ESMTPSA id 14sm367355qtx.33.2021.09.29.11.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:01:58 -0700 (PDT)
From:   Dagan Martinez <dmartinez@starry.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dagan Martinez <dmartinez@starry.com>
Subject: [PATCH BlueZ v2 1/2] gatt: allow GATT server to dicate CCC permissions
Date:   Wed, 29 Sep 2021 14:00:30 -0400
Message-Id: <20210929180031.417090-2-dmartinez@starry.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929180031.417090-1-dmartinez@starry.com>
References: <20210929180031.417090-1-dmartinez@starry.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Allow a GATT server to impose permissions/restrictions on a CCC by
setting additional `X-asynchronous` permissions on its associated
characteristic.

This allows a developer to require encryption/authentication in order
for a GATT client to subscribe to server-initiated updates.

Test procedure:
Attempt to read/write with a "low" security level on an unprotected CCC
using gatttool, and succeed
Attempt to READ with a "low" security level on an protected CCC
using gatttool, and succeed
Attempt to WRITE with a "low" security level on an protected CCC
using gatttool, and fail
Attempt to read/write while paired on a protected CCC using
`bluetoothctl`, and succeed
---
 src/gatt-database.c    | 30 ++++++++++++++++++++++++++----
 src/shared/att-types.h |  4 ++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 1f7ce5f02..4e7938565 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1044,6 +1044,7 @@ service_add_ccc(struct gatt_db_attribute *service,
 				struct btd_gatt_database *database,
 				btd_gatt_database_ccc_write_t write_callback,
 				void *user_data,
+				uint32_t parent_permissions,
 				btd_gatt_database_destroy_t destroy)
 {
 	struct gatt_db_attribute *ccc;
@@ -1052,9 +1053,23 @@ service_add_ccc(struct gatt_db_attribute *service,
 
 	ccc_cb = new0(struct ccc_cb_data, 1);
 
+	/*
+	 * Provide a way for the permissions on a characteristic to dictate
+	 * the permissions on the CCC
+	 */
+	uint32_t permissions = BT_ATT_PERM_READ | BT_ATT_PERM_WRITE;
+
+	if (parent_permissions & BT_ATT_PERM_ASYNCHRONOUS_ENCRYPT)
+		permissions |= BT_ATT_PERM_WRITE_ENCRYPT;
+
+	if (parent_permissions & BT_ATT_PERM_ASYNCHRONOUS_AUTHEN)
+		permissions |= BT_ATT_PERM_WRITE_AUTHEN;
+
+	if (parent_permissions & BT_ATT_PERM_ASYNCHRONOUS_SECURE)
+		permissions |= BT_ATT_PERM_WRITE_SECURE;
+
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	ccc = gatt_db_service_add_descriptor(service, &uuid,
-				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+	ccc = gatt_db_service_add_descriptor(service, &uuid, permissions,
 				gatt_ccc_read_cb, gatt_ccc_write_cb, database);
 	if (!ccc) {
 		error("Failed to create CCC entry in database");
@@ -1211,7 +1226,7 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 				NULL, NULL, database);
 
 	database->svc_chngd_ccc = service_add_ccc(service, database, NULL, NULL,
-									NULL);
+								    0, NULL);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_CLI_FEAT);
 	database->cli_feat = gatt_db_service_add_characteristic(service,
@@ -1674,6 +1689,13 @@ static bool parse_chrc_flags(DBusMessageIter *array, uint8_t *props,
 			*perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_SECURE;
 		} else if (!strcmp("authorize", flag)) {
 			*req_prep_authorization = true;
+		} else if (!strcmp("encrypt-asynchronous", flag)) {
+			*perm |= BT_ATT_PERM_ASYNCHRONOUS_ENCRYPT;
+		} else if (!strcmp(
+				"encrypt-authenticated-asynchronous", flag)) {
+			*perm |= BT_ATT_PERM_ASYNCHRONOUS_AUTHEN;
+		} else if (!strcmp("secure-asynchronous", flag)) {
+			*perm |= BT_ATT_PERM_ASYNCHRONOUS_SECURE;
 		} else {
 			error("Invalid characteristic flag: %s", flag);
 			return false;
@@ -2773,7 +2795,7 @@ static bool database_add_ccc(struct external_service *service,
 		return true;
 
 	chrc->ccc = service_add_ccc(service->attrib, service->app->database,
-						ccc_write_cb, chrc, NULL);
+					ccc_write_cb, chrc, chrc->perm, NULL);
 	if (!chrc->ccc) {
 		error("Failed to create CCC entry for characteristic");
 		return false;
diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index a08b24155..554441aca 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -137,6 +137,10 @@ struct bt_att_pdu_error_rsp {
 					BT_ATT_PERM_WRITE_AUTHEN | \
 					BT_ATT_PERM_WRITE_ENCRYPT | \
 					BT_ATT_PERM_WRITE_SECURE)
+/* Permissions to be applied to the CCC */
+#define BT_ATT_PERM_ASYNCHRONOUS_ENCRYPT 0x0400
+#define BT_ATT_PERM_ASYNCHRONOUS_AUTHEN 0x0800
+#define BT_ATT_PERM_ASYNCHRONOUS_SECURE 0x1000
 
 /* GATT Characteristic Properties Bitfield values */
 #define BT_GATT_CHRC_PROP_BROADCAST			0x01
-- 
2.31.1

