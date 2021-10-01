Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAF7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 14:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E3E61A81
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 14:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354224AbhJAOTo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbhJAOTm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Oct 2021 10:19:42 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C24C06177D
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Oct 2021 07:17:58 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id dk4so5640288qvb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Oct 2021 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starry.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZqxmUVjcosQRF+elrvgO2NZTOtAA+un2iXV0lGAbjo=;
        b=OaGLGUBJ16c2F9yttC9NJrwXiHOlYWDuGAkqOHuIYbug2PloOGXSXsw/4irFI1Mc0h
         BKLJ+z77F+8fKBtEv7IkPR0kKE69jXTnzuxzCwoJTTa3jNB0n4YRMNhyy0pwPnCeRFp7
         NxTiChYF4mJmD/+nrFP+4DaN4FBRFUyBCFAjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZqxmUVjcosQRF+elrvgO2NZTOtAA+un2iXV0lGAbjo=;
        b=jJ8eGbYso6sJNeWPwsjezMNlDV/lXApMvaKWs6o2ZxD8n+wSM1op4NTS0rWCA1KUzR
         MV0SSnJzT+p+jv9R/eU/8A3ExUpPIGTjsoKvxQkc4p4dA3Q0lR0VP3FWa6U1fyBHMfQ4
         ogNR5Pnxzude+8rE7jHA00ko+vUsdqGSsDlntFJdhKwWfX29X2/mjyKFysWuMuUZxA5l
         rtPcYvoOKemJH3tCd3iK9T9M+KkC9Dtu/5YOUCUOPkq5bqYyO4x6shI3ODs1Y6d2lC9v
         7RkvZDvVfyzZhdykNHERVoXLxZezDJeQ6bHa9QqBNY11FKKjoPku34ASfTn6kiNWfCZX
         9wQw==
X-Gm-Message-State: AOAM532pe2+xKjg/6uOa4rR3uO9WJDzY92WMNn5kprPeJMMYP3fUhYcY
        YIymLukWFnWY2h7eVJ+JVc/G9vfc+nMwK2Dz
X-Google-Smtp-Source: ABdhPJxs8Likt+sMr5ZbTwWZolRVAyeqCYwbVZSpZPnKp/B/o5cbkAaGPU1F0zHoANHs1CynKTnnmQ==
X-Received: by 2002:a0c:8cc3:: with SMTP id q3mr9003839qvb.19.1633097877042;
        Fri, 01 Oct 2021 07:17:57 -0700 (PDT)
Received: from MrComputer.nevonetnext (205-201-16-55.starry-inc.net. [205.201.16.55])
        by smtp.gmail.com with ESMTPSA id u12sm3767299qtw.73.2021.10.01.07.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:17:56 -0700 (PDT)
From:   Dagan Martinez <dmartinez@starry.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dagan Martinez <dmartinez@starry.com>
Subject: [PATCH BlueZ v4 1/2] gatt: Allow GATT server to dicate CCC permissions
Date:   Fri,  1 Oct 2021 10:17:18 -0400
Message-Id: <20211001141719.180087-2-dmartinez@starry.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001141719.180087-1-dmartinez@starry.com>
References: <20211001141719.180087-1-dmartinez@starry.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Allow a GATT server to impose write permissions/restrictions on a CCC by
setting additional `X-notify` and `X-indicate` flags on its associated
characteristic.

This allows a developer to require encryption/authentication in order
for a GATT client to subscribe to server-initiated updates.

```
[bluetooth]# register-characteristic\
	4b75f0f8-1f23-46b1-900c-5bbabcd5ca93 encrypt-read,encrypt-notify

[NEW] Characteristic (Handle 0x0000)
        /org/bluez/app/service0/chrc17
        4b75f0f8-1f23-46b1-900c-5bbabcd5ca93
        Vendor specific
[/org/bluez/app/service0/chrc17] Enter value: 42
```

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
 src/gatt-database.c | 52 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 68f411ba4..475e7873c 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -115,6 +115,7 @@ struct external_chrc {
 	uint8_t props;
 	uint8_t ext_props;
 	uint32_t perm;
+	uint32_t ccc_perm;
 	uint16_t mtu;
 	struct io *write_io;
 	struct io *notify_io;
@@ -1059,7 +1060,7 @@ static struct gatt_db_attribute *
 service_add_ccc(struct gatt_db_attribute *service,
 				struct btd_gatt_database *database,
 				btd_gatt_database_ccc_write_t write_callback,
-				void *user_data,
+				void *user_data, uint32_t perm,
 				btd_gatt_database_destroy_t destroy)
 {
 	struct gatt_db_attribute *ccc;
@@ -1068,9 +1069,14 @@ service_add_ccc(struct gatt_db_attribute *service,
 
 	ccc_cb = new0(struct ccc_cb_data, 1);
 
+	/*
+	 * Provide a way for the permissions on a characteristic to dictate
+	 * the permissions on the CCC
+	 */
+	perm |= BT_ATT_PERM_READ | BT_ATT_PERM_WRITE;
+
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	ccc = gatt_db_service_add_descriptor(service, &uuid,
-				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+	ccc = gatt_db_service_add_descriptor(service, &uuid, perm,
 				gatt_ccc_read_cb, gatt_ccc_write_cb, database);
 	if (!ccc) {
 		error("Failed to create CCC entry in database");
@@ -1227,7 +1233,7 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 				NULL, NULL, database);
 
 	database->svc_chngd_ccc = service_add_ccc(service, database, NULL, NULL,
-									NULL);
+								    0, NULL);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_CLI_FEAT);
 	database->cli_feat = gatt_db_service_add_characteristic(service,
@@ -1633,11 +1639,18 @@ static bool incr_attr_count(struct external_service *service, uint16_t incr)
 
 static bool parse_chrc_flags(DBusMessageIter *array, uint8_t *props,
 					uint8_t *ext_props, uint32_t *perm,
+					uint32_t *ccc_perm,
 					bool *req_prep_authorization)
 {
 	const char *flag;
 
-	*props = *ext_props = 0;
+	if (!props || !ext_props || !perm || !ccc_perm)
+		return false;
+
+	*props = 0;
+	*ext_props = 0;
+	*perm = 0;
+	*ccc_perm = 0;
 
 	do {
 		if (dbus_message_iter_get_arg_type(array) != DBUS_TYPE_STRING)
@@ -1690,6 +1703,24 @@ static bool parse_chrc_flags(DBusMessageIter *array, uint8_t *props,
 			*perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_SECURE;
 		} else if (!strcmp("authorize", flag)) {
 			*req_prep_authorization = true;
+		} else if (!strcmp("encrypt-notify", flag)) {
+			*ccc_perm |= BT_ATT_PERM_WRITE_ENCRYPT;
+			*props |= BT_GATT_CHRC_PROP_NOTIFY;
+		} else if (!strcmp("encrypt-authenticated-notify", flag)) {
+			*ccc_perm |= BT_ATT_PERM_WRITE_AUTHEN;
+			*props |= BT_GATT_CHRC_PROP_NOTIFY;
+		} else if (!strcmp("secure-notify", flag)) {
+			*ccc_perm |= BT_ATT_PERM_WRITE_SECURE;
+			*props |= BT_GATT_CHRC_PROP_NOTIFY;
+		} else if (!strcmp("encrypt-indicate", flag)) {
+			*ccc_perm |= BT_ATT_PERM_WRITE_ENCRYPT;
+			*props |= BT_GATT_CHRC_PROP_INDICATE;
+		} else if (!strcmp("encrypt-authenticated-indicate", flag)) {
+			*ccc_perm |= BT_ATT_PERM_WRITE_AUTHEN;
+			*props |= BT_GATT_CHRC_PROP_INDICATE;
+		} else if (!strcmp("secure-indicate", flag)) {
+			*ccc_perm |= BT_ATT_PERM_WRITE_SECURE;
+			*props |= BT_GATT_CHRC_PROP_INDICATE;
 		} else {
 			error("Invalid characteristic flag: %s", flag);
 			return false;
@@ -1743,7 +1774,8 @@ static bool parse_desc_flags(DBusMessageIter *array, uint32_t *perm,
 }
 
 static bool parse_flags(GDBusProxy *proxy, uint8_t *props, uint8_t *ext_props,
-				uint32_t *perm, bool *req_prep_authorization)
+					    uint32_t *perm, uint32_t *ccc_perm,
+					    bool *req_prep_authorization)
 {
 	DBusMessageIter iter, array;
 	const char *iface;
@@ -1760,7 +1792,7 @@ static bool parse_flags(GDBusProxy *proxy, uint8_t *props, uint8_t *ext_props,
 	if (!strcmp(iface, GATT_DESC_IFACE))
 		return parse_desc_flags(&array, perm, req_prep_authorization);
 
-	return parse_chrc_flags(&array, props, ext_props, perm,
+	return parse_chrc_flags(&array, props, ext_props, perm, ccc_perm,
 							req_prep_authorization);
 }
 
@@ -1810,7 +1842,7 @@ static struct external_chrc *chrc_create(struct gatt_app *app,
 	 * created.
 	 */
 	if (!parse_flags(proxy, &chrc->props, &chrc->ext_props, &chrc->perm,
-					&chrc->req_prep_authorization)) {
+			&chrc->ccc_perm, &chrc->req_prep_authorization)) {
 		error("Failed to parse characteristic properties");
 		goto fail;
 	}
@@ -1892,7 +1924,7 @@ static struct external_desc *desc_create(struct gatt_app *app,
 	 * Parse descriptors flags here since they are used to
 	 * determine the permission the descriptor should have
 	 */
-	if (!parse_flags(proxy, NULL, NULL, &desc->perm,
+	if (!parse_flags(proxy, NULL, NULL, &desc->perm, NULL,
 					&desc->req_prep_authorization)) {
 		error("Failed to parse characteristic properties");
 		goto fail;
@@ -2796,7 +2828,7 @@ static bool database_add_ccc(struct external_service *service,
 		return true;
 
 	chrc->ccc = service_add_ccc(service->attrib, service->app->database,
-						ccc_write_cb, chrc, NULL);
+				    ccc_write_cb, chrc, chrc->ccc_perm, NULL);
 	if (!chrc->ccc) {
 		error("Failed to create CCC entry for characteristic");
 		return false;
-- 
2.31.1

