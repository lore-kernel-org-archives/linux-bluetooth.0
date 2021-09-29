Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ED2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BEC7613A6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 16:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345615AbhI2QSt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 12:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243284AbhI2QSt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 12:18:49 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018BAC061760
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 09:17:08 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x9so2880309qtv.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starry.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pRaytAfl6ilM+Q4ixE2ucbX/SWzErqihRcIrfif8rBE=;
        b=Avqh2jQosBciDPUla2MiaSHYCgyK8aO/j2t6TQevYzqo6OX84b7+CUJnw1GQIX0dOQ
         MPrzVYJFG+Hly380Qz0B7TirpWQYGeukqZZVpM4UonMSN5NeEywzXEi4Wc9bBY2sIvma
         LwlHq2TkeHt3yNyD7wf4Xw6vM3295x0/haXj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pRaytAfl6ilM+Q4ixE2ucbX/SWzErqihRcIrfif8rBE=;
        b=A1xiZ/nbs44OiveB51UI1c37ZVXX1SmxrPnarTBfpzKwhIx35gab2njW4KMVuF63iy
         wz8JQcJVVoIAqVEcHjgleOGL2LJ+v6hfShZyrf2434GxryHIZxcdFiRZbE0ZJLNJkUVl
         HGCYyWLZCfnIHCYseZ94W6FUnLc2MISQLB2jfDOm2fyyA6OEH5tyxw4CH1EwaZlTOYck
         +yEG6Fo28WOYlJQx/CCj10YtTVzfsYNwZwRe2uTBmd/X8TVhjRrO0sKV0Zs9HUBCPEGG
         2mjLQWHKD8xC11HkutZulI+VoK8kfoaq4J6XegHADQKo+zIyq/iNmo9LzMXTv3KDHLHs
         pEGw==
X-Gm-Message-State: AOAM533ChamXg681XzcMRn8FOAzwHZGL+EZLXYpZMmkB6cX3SF3qunxU
        vLfRXatV+rxlyBRTxy05d95Vc/0SW9iNJg==
X-Google-Smtp-Source: ABdhPJxEXz+HHmHiAx1W+Jx4rR3ZEARemk3ezd2pt/gfHufLbVObSl5g8PpWjczPnaJh/UQtsaMAgg==
X-Received: by 2002:ac8:4645:: with SMTP id f5mr846936qto.75.1632932227018;
        Wed, 29 Sep 2021 09:17:07 -0700 (PDT)
Received: from MrComputer.nevonetnext (205-201-16-55.starry-inc.net. [205.201.16.55])
        by smtp.gmail.com with ESMTPSA id 205sm165863qkf.19.2021.09.29.09.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 09:17:06 -0700 (PDT)
From:   Dagan Martinez <dmartinez@starry.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dagan Martinez <dmartinez@starry.com>
Subject: [PATCH BlueZ 1/2] gatt: allow GATT server to dicate CCC permissions
Date:   Wed, 29 Sep 2021 12:16:55 -0400
Message-Id: <20210929161656.413300-2-dmartinez@starry.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929161656.413300-1-dmartinez@starry.com>
References: <20210929161656.413300-1-dmartinez@starry.com>
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
 src/gatt-database.c    | 29 +++++++++++++++++++++++++----
 src/shared/att-types.h |  4 ++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 1f7ce5f02..bb65656bd 100644
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
+									0, NULL);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_CLI_FEAT);
 	database->cli_feat = gatt_db_service_add_characteristic(service,
@@ -1674,6 +1689,12 @@ static bool parse_chrc_flags(DBusMessageIter *array, uint8_t *props,
 			*perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_SECURE;
 		} else if (!strcmp("authorize", flag)) {
 			*req_prep_authorization = true;
+		} else if (!strcmp("encrypt-asynchronous", flag)) {
+			*perm |= BT_ATT_PERM_ASYNCHRONOUS_ENCRYPT;
+		} else if (!strcmp("encrypt-authenticated-asynchronous", flag)) {
+			*perm |= BT_ATT_PERM_ASYNCHRONOUS_AUTHEN;
+		} else if (!strcmp("secure-asynchronous", flag)) {
+			*perm |= BT_ATT_PERM_ASYNCHRONOUS_SECURE;
 		} else {
 			error("Invalid characteristic flag: %s", flag);
 			return false;
@@ -2773,7 +2794,7 @@ static bool database_add_ccc(struct external_service *service,
 		return true;
 
 	chrc->ccc = service_add_ccc(service->attrib, service->app->database,
-						ccc_write_cb, chrc, NULL);
+						ccc_write_cb, chrc, chrc->perm, NULL);
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

