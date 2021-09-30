Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5345FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 15:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB5D615E5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 15:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244567AbhI3PKg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 11:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238364AbhI3PKX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 11:10:23 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699C4C06176C
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 08:08:35 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id f130so6098142qke.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starry.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFXcGRR7RQNbBiFGSuxwA5cUY3XljILCQ477LZcwhgY=;
        b=m/JJG/juDEMU+zPF2et4WQcksZM3O3voZ/b1dVlG1LqI/M/Z3xv827OpB3pFNVgWDv
         u3zD4e15LfvMTS3JLfz6HryN9L5ml8gj9qkmMimMmutJuA8iJfve/FFKIkaAJxWTn/Rz
         Ku1FQnUSc3z2kXGtGXkpAmJUAnynPrvEohSbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFXcGRR7RQNbBiFGSuxwA5cUY3XljILCQ477LZcwhgY=;
        b=frlJMooRq5ec7FeAd/Ooi+f00TuxTCDZF3pbhQqzWbfE1JMcHV2jF+eWF9SelIjtl1
         jE+ZYFeyj4gBlSeyduKDRcMKz72+M8CE4ChsjnY5kQbkDvR3hhRRoLlk/7A0/5aB6z91
         tlMOH3ym1Dw/qS40xOcOYEnLv5D1EpR9XXSPWhTLEVXvy3qCqLUypoq9QiI4BDHcuMHF
         QgipNT8ryUOXXcB7ujMcWrEk3je6kU7IiNbdVPfG2oQiVTa0CEFR+Tt+01SU60fpQtBt
         RleF90r9L6k/Pux6afPFdX34a48vm2p/NObzvvOhArg6tr5K9p7OAlv4cys2mgcpJvBM
         YXvw==
X-Gm-Message-State: AOAM533H4SPtkWtrXBgXfGjdNG/TSVgUwGCgNAb8UH/R+mMZhRde404w
        kudstqL9DZdxnCG86ZllE91gMBjH61BInkJ9
X-Google-Smtp-Source: ABdhPJwz/VjbJaRNES8WWASCqRnMGj3LRLRWqloZ+gtEWt0sfurOC3hoG8fQsbl+wD0I9LONQ/ADfQ==
X-Received: by 2002:a37:2717:: with SMTP id n23mr4913895qkn.149.1633014514512;
        Thu, 30 Sep 2021 08:08:34 -0700 (PDT)
Received: from MrComputer.nevonetnext (205-201-16-55.starry-inc.net. [205.201.16.55])
        by smtp.gmail.com with ESMTPSA id w17sm1573741qkf.97.2021.09.30.08.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 08:08:34 -0700 (PDT)
From:   Dagan Martinez <dmartinez@starry.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dagan Martinez <dmartinez@starry.com>
Subject: [PATCH BlueZ v3 1/2] gatt: Allow GATT server to dicate CCC permissions
Date:   Thu, 30 Sep 2021 11:08:18 -0400
Message-Id: <20210930150819.34270-2-dmartinez@starry.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210930150819.34270-1-dmartinez@starry.com>
References: <20210930150819.34270-1-dmartinez@starry.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Allow a GATT server to impose permissions/restrictions on a CCC by
setting additional `X-notify` and `X-indicate` permissions on its
associated characteristic.

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
 src/gatt-database.c    | 42 ++++++++++++++++++++++++++++++++++++++----
 src/shared/att-types.h |  4 ++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 68f411ba4..fd4a39166 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1060,17 +1060,33 @@ service_add_ccc(struct gatt_db_attribute *service,
 				struct btd_gatt_database *database,
 				btd_gatt_database_ccc_write_t write_callback,
 				void *user_data,
+				uint32_t parent_permissions,
 				btd_gatt_database_destroy_t destroy)
 {
 	struct gatt_db_attribute *ccc;
 	struct ccc_cb_data *ccc_cb;
 	bt_uuid_t uuid;
+	uint32_t permissions;
 
 	ccc_cb = new0(struct ccc_cb_data, 1);
 
+	/*
+	 * Provide a way for the permissions on a characteristic to dictate
+	 * the permissions on the CCC
+	 */
+	permissions = BT_ATT_PERM_READ | BT_ATT_PERM_WRITE;
+
+	if (parent_permissions & BT_ATT_PERM_SERVER_INITIATED_UPDATE_ENCRYPT)
+		permissions |= BT_ATT_PERM_WRITE_ENCRYPT;
+
+	if (parent_permissions & BT_ATT_PERM_SERVER_INITIATED_UPDATE_AUTHEN)
+		permissions |= BT_ATT_PERM_WRITE_AUTHEN;
+
+	if (parent_permissions & BT_ATT_PERM_SERVER_INITIATED_UPDATE_SECURE)
+		permissions |= BT_ATT_PERM_WRITE_SECURE;
+
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	ccc = gatt_db_service_add_descriptor(service, &uuid,
-				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+	ccc = gatt_db_service_add_descriptor(service, &uuid, permissions,
 				gatt_ccc_read_cb, gatt_ccc_write_cb, database);
 	if (!ccc) {
 		error("Failed to create CCC entry in database");
@@ -1227,7 +1243,7 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 				NULL, NULL, database);
 
 	database->svc_chngd_ccc = service_add_ccc(service, database, NULL, NULL,
-									NULL);
+								    0, NULL);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_CLI_FEAT);
 	database->cli_feat = gatt_db_service_add_characteristic(service,
@@ -1690,6 +1706,24 @@ static bool parse_chrc_flags(DBusMessageIter *array, uint8_t *props,
 			*perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_SECURE;
 		} else if (!strcmp("authorize", flag)) {
 			*req_prep_authorization = true;
+		} else if (!strcmp("encrypt-notify", flag)) {
+			*perm |= BT_ATT_PERM_SERVER_INITIATED_UPDATE_ENCRYPT;
+			*props |= BT_GATT_CHRC_PROP_NOTIFY;
+		} else if (!strcmp("encrypt-authenticated-notify", flag)) {
+			*perm |= BT_ATT_PERM_SERVER_INITIATED_UPDATE_AUTHEN;
+			*props |= BT_GATT_CHRC_PROP_NOTIFY;
+		} else if (!strcmp("secure-notify", flag)) {
+			*perm |= BT_ATT_PERM_SERVER_INITIATED_UPDATE_SECURE;
+			*props |= BT_GATT_CHRC_PROP_NOTIFY;
+		} else if (!strcmp("encrypt-indicate", flag)) {
+			*perm |= BT_ATT_PERM_SERVER_INITIATED_UPDATE_ENCRYPT;
+			*props |= BT_GATT_CHRC_PROP_INDICATE;
+		} else if (!strcmp("encrypt-authenticated-indicate", flag)) {
+			*perm |= BT_ATT_PERM_SERVER_INITIATED_UPDATE_AUTHEN;
+			*props |= BT_GATT_CHRC_PROP_INDICATE;
+		} else if (!strcmp("secure-indicate", flag)) {
+			*perm |= BT_ATT_PERM_SERVER_INITIATED_UPDATE_SECURE;
+			*props |= BT_GATT_CHRC_PROP_INDICATE;
 		} else {
 			error("Invalid characteristic flag: %s", flag);
 			return false;
@@ -2796,7 +2830,7 @@ static bool database_add_ccc(struct external_service *service,
 		return true;
 
 	chrc->ccc = service_add_ccc(service->attrib, service->app->database,
-						ccc_write_cb, chrc, NULL);
+					ccc_write_cb, chrc, chrc->perm, NULL);
 	if (!chrc->ccc) {
 		error("Failed to create CCC entry for characteristic");
 		return false;
diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index a08b24155..eb5def503 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -137,6 +137,10 @@ struct bt_att_pdu_error_rsp {
 					BT_ATT_PERM_WRITE_AUTHEN | \
 					BT_ATT_PERM_WRITE_ENCRYPT | \
 					BT_ATT_PERM_WRITE_SECURE)
+/* Permissions to be applied to the CCC*/
+#define BT_ATT_PERM_SERVER_INITIATED_UPDATE_ENCRYPT 0x0400
+#define BT_ATT_PERM_SERVER_INITIATED_UPDATE_AUTHEN 0x0800
+#define BT_ATT_PERM_SERVER_INITIATED_UPDATE_SECURE 0x1000
 
 /* GATT Characteristic Properties Bitfield values */
 #define BT_GATT_CHRC_PROP_BROADCAST			0x01
-- 
2.31.1

