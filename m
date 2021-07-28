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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2970C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 20:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD006023D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 20:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhG1UsF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 16:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbhG1UsF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 16:48:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3EFC061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 13:48:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so6078253pjd.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skKSfOcmM8SlX/jWeC/JEFpjH0uXzUrXQVzuHFTmAx4=;
        b=Fg4YApfxqKnxc0DhH6YXsYTlU5mFLkW+lsRSKQDiAMeYb8eYHcMD+yOE0zy0l+tDzO
         TfpN+cbhdckezUtG0zgClw8/b90uyytwxzPzDbx5hyo/K8RZWutQ0jQablhUIMuzhlXH
         4BfAe4buQAxdRG7r8lC4nUx0U+QERq28gDwLp4U65dkUdjXbVBDqbM0o7gG/rMrQUiHL
         EAp2wicR3OR6ZRQDZ20BrmaqC/fCUwPfFBGhQIrJv8/VbYnbXq6X8TOWlXZvPVLzTZMB
         Eb+daQCgtZXim97ng2Cq/s+0wHbFkI5BDm/xcVF15L89pNjLq/mYvREWY6x/E0umEILB
         EkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skKSfOcmM8SlX/jWeC/JEFpjH0uXzUrXQVzuHFTmAx4=;
        b=hIJ59KpFY04BQIF+ZV2HJRKvSZxGD2hQEYnxgtYb51KT51FwQCWd0BsuHoQnWlHmQ2
         g3fVmf9rBE/TVOZxumv7JMepBkgdSj8jPOBhK/Vr0fXST2QXIpKTQU2hbJ3I0VurbiaL
         X+oLEzdFidal+jVVnKx79UPg4VNTJk43SAJyTHygjpmcSni6JA7xZDXFokUhj14KCmXT
         ClG0hpfaZZfpwMNCzoi8qXT/ZyVDAPfWlkkn534cqdGCxWT5b3hsuz1tL/M9YE/HUDjS
         QIaVl6V0UPRGc56wKPCGrCHzlxlybLEov5bVQbHqfOzmzjx5SmuvRhtQslLbUskXD4RG
         dFdg==
X-Gm-Message-State: AOAM5314znacB7kBr68wphGVl3aiEAPDXYJsPm01NcRv7xssFoY5ews7
        fu6yrKJ0FKQ6vogqSgpS3l+XhD/a/7g=
X-Google-Smtp-Source: ABdhPJwm0Q8JZh4YQU2RiWcKJePG4Afi2RNxT5lALjVogAH2pY33WIt44RwVA+CfGCcpiEFWnp7EOg==
X-Received: by 2002:aa7:9a07:0:b029:329:46d2:c6e4 with SMTP id w7-20020aa79a070000b029032946d2c6e4mr1635643pfj.81.1627505281717;
        Wed, 28 Jul 2021 13:48:01 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s195sm933276pfs.119.2021.07.28.13.48.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 13:48:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] gatt: Add support for Central Address Resolution characteristic
Date:   Wed, 28 Jul 2021 13:48:00 -0700
Message-Id: <20210728204800.2205665-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Central Address Resolution characteristic so peripherals can
use directed advertising using RPA as initiator address.
---
 lib/uuid.h          |  1 +
 src/gatt-database.c | 33 +++++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/lib/uuid.h b/lib/uuid.h
index 1a4029b68..6236752a1 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -116,6 +116,7 @@ extern "C" {
 #define GATT_CHARAC_SOFTWARE_REVISION_STRING		0x2A28
 #define GATT_CHARAC_MANUFACTURER_NAME_STRING		0x2A29
 #define GATT_CHARAC_PNP_ID				0x2A50
+#define GATT_CHARAC_CAR					0x2AA6
 
 /* GATT Characteristic Descriptors */
 #define GATT_CHARAC_EXT_PROPER_UUID			0x2900
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 8cf60c597..99c95f2d6 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -699,6 +699,18 @@ static void gap_appearance_read_cb(struct gatt_db_attribute *attrib,
 	gatt_db_attribute_read_result(attrib, id, error, value, len);
 }
 
+static void gap_car_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	uint8_t value = 0x01;
+
+	DBG("GAP Central Address Resolution read request\n");
+
+	gatt_db_attribute_read_result(attrib, id, 0, &value, sizeof(value));
+}
+
 static sdp_record_t *record_new(uuid_t *uuid, uint16_t start, uint16_t end)
 {
 	sdp_list_t *svclass_id, *apseq, *proto[2], *root, *aproto;
@@ -820,7 +832,7 @@ static void populate_gap_service(struct btd_gatt_database *database)
 
 	/* Add the GAP service */
 	bt_uuid16_create(&uuid, UUID_GAP);
-	service = gatt_db_add_service(database->db, &uuid, true, 5);
+	service = gatt_db_add_service(database->db, &uuid, true, 7);
 
 	/*
 	 * Device Name characteristic.
@@ -842,6 +854,17 @@ static void populate_gap_service(struct btd_gatt_database *database)
 							NULL, database);
 	gatt_db_attribute_set_fixed_length(attrib, 2);
 
+	/*
+	 * Central Address Resolution characteristic.
+	 */
+	bt_uuid16_create(&uuid, GATT_CHARAC_CAR);
+	attrib = gatt_db_service_add_characteristic(service, &uuid,
+							BT_ATT_PERM_READ,
+							BT_GATT_CHRC_PROP_READ,
+							gap_car_read_cb,
+							NULL, database);
+	gatt_db_attribute_set_fixed_length(attrib, 1);
+
 	gatt_db_service_set_active(service, true);
 
 	database_add_record(database, service);
@@ -3853,13 +3876,7 @@ void btd_gatt_database_restore_svc_chng_ccc(struct btd_gatt_database *database)
 	 */
 	btd_adapter_for_each_device(database->adapter, restore_state, database);
 
-	/* This needs to be updated (probably to 0x0001) if we ever change
-	 * core services
-	 *
-	 * TODO we could also store this info (along with CCC value) and be able
-	 * to send 0x0001-0xffff only once per device.
-	 */
-	put_le16(0x000a, value);
+	put_le16(0x0001, value);
 	put_le16(0xffff, value + 2);
 
 	send_notification_to_devices(database, handle, value, sizeof(value),
-- 
2.31.1

