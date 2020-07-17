Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430ECC433E3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 13:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C38520734
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 13:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WeuJSBRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgGQNm5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgGQNm5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 09:42:57 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9D2C061755
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 06:42:57 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id o184so4883202vsc.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GGV1wbj0653P2xg+RLSu9dXMV9pkHnXxYlofmrHKvcc=;
        b=WeuJSBRc31y8MSyH7T1a0bhW+jM124fD+aojzvjSwvpGXIolPgVXtJD4nwdJZ2a25z
         +jIUyUrNqxnL48bKJW7FJHqLxIB+dmaHHi4Njk+/mjPrOUuTiQioveu8Vo+I48JhqZnP
         PC1nm0ke1huFdTbtwfXwTDUwuI6HujDtmtSpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GGV1wbj0653P2xg+RLSu9dXMV9pkHnXxYlofmrHKvcc=;
        b=SLOSaAcejGL4Ikq7LTFCw4CiGw6MxXc3nIvoVrsoUzMcbt+9ZmLSikXqOaYGgfDai2
         tDbxngfi+c/GU9mLsEdhReIrgOReEsuqeHYaddVSxRBeAub2hgnWWANuIYe5AtuOAYZ4
         Hkzu0nsn//qMFLmtMznv5bc7MqSWngcpzTK+etXibcnn4wDPi8bMLqHzIiW1lvXz5F6L
         c+WX+N2dDo8vhaCJAebxNIIchYsMguODbra0WLG7GYBQmaReLrm+g0WjcqNv54Qb/v95
         hmwVQXk5mXoixiJNDQSnEUt5V3T89vzgaTuEZaQX5HutqMMDuLtkI2hly3h7xC1KyhPF
         Hy+A==
X-Gm-Message-State: AOAM531BWTKH2utWRVXGnO2pLOO4negmDUvy96mh2bksZHN8DzXIAvJV
        H/DgE5pPL3db5JoGTZYb9WFwYOH+img=
X-Google-Smtp-Source: ABdhPJydS4102D2m3mKfJ/ZoyExOuZGC68+yR+0z60/EnqvDLx9QUGX6QtUafv51qXSL6bplDBYB2g==
X-Received: by 2002:a67:f50e:: with SMTP id u14mr7026446vsn.240.1594993375512;
        Fri, 17 Jul 2020 06:42:55 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id q11sm1283385vkn.47.2020.07.17.06.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:42:54 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [Bluez PATCH] gatt: Support DeviceInfo Service when vid/pid is specified
Date:   Fri, 17 Jul 2020 13:42:51 +0000
Message-Id: <20200717134251.3148686-1-alainm@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support for the PNPID characteristic when configured in
main.conf.

This was validated as read correclty both by manually reading the valud
and confirming in the Ellisys Analyzer.

ATT Read (PnP ID: Source=Bluetooth ID, Vendor=224, Product=50181,
ATT Read Response Packet (Source=Bluetooth ID, Vendor=224,
Product=50181, Version=86)     | OK     | 7 bytes (01 E0 00 05 C4 56 00)

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Alain Michaud <alainm@chromium.org>
---
I admit I don't know how to quantify the compatibility risk with adding
the Device Info Service if the DeviceID is specified.  I can see that
some system may be configured with an app to publish the DIS and this
may break it.

If the community feels it is necessary, I can include a DeviceIdOverLE
configuration which defaults to false in main.conf to address this
compatibility risk.

 peripheral/gatt.c   | 28 +++++++++++++++++++++++++++-
 src/gatt-database.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index bbbf3f59f..aeb286563 100644
--- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -41,11 +41,13 @@
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-server.h"
 #include "src/shared/gatt-client.h"
+#include "src/hcid.h"
 #include "peripheral/gatt.h"
 
 #define ATT_CID 4
 
 #define UUID_GAP 0x1800
+#define UUID_DIS 0x180a
 
 struct gatt_conn {
 	struct bt_att *att;
@@ -229,14 +231,38 @@ static void populate_gap_service(struct gatt_db *db)
 	gatt_db_service_set_active(service, true);
 }
 
+static void device_info_read_pnp_id_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	uint8_t pdu[7];
+
+	pdu[0] = main_opts.did_source;
+	put_le16(main_opts.did_vendor, &pdu[1]);
+	put_le16(main_opts.did_product, &pdu[3]);
+	put_le16(main_opts.did_version, &pdu[5]);
+
+	gatt_db_attribute_read_result(attrib, id, 0, pdu, sizeof(pdu));
+}
+
 static void populate_devinfo_service(struct gatt_db *db)
 {
 	struct gatt_db_attribute *service;
 	bt_uuid_t uuid;
 
-	bt_uuid16_create(&uuid, 0x180a);
+	bt_uuid16_create(&uuid, UUID_DIS);
 	service = gatt_db_add_service(db, &uuid, true, 17);
 
+	if (main_opts.did_source > 0) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_PNP_ID);
+		gatt_db_service_add_characteristic(service, &uuid,
+						BT_ATT_PERM_READ,
+						BT_GATT_CHRC_PROP_READ,
+						device_info_read_pnp_id_cb,
+						NULL, NULL);
+	}
+
 	gatt_db_service_set_active(service, true);
 }
 
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 95ba39897..07d567078 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -57,6 +57,7 @@
 
 #define UUID_GAP	0x1800
 #define UUID_GATT	0x1801
+#define UUID_DIS	0x180a
 
 #ifndef MIN
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
@@ -1233,11 +1234,51 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 	database_add_record(database, service);
 }
 
+static void device_info_read_pnp_id_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	uint8_t pdu[7];
+
+	pdu[0] = main_opts.did_source;
+	put_le16(main_opts.did_vendor, &pdu[1]);
+	put_le16(main_opts.did_product, &pdu[3]);
+	put_le16(main_opts.did_version, &pdu[5]);
+
+	gatt_db_attribute_read_result(attrib, id, 0, pdu, sizeof(pdu));
+}
+
+static void populate_devinfo_service(struct btd_gatt_database *database)
+{
+	struct gatt_db_attribute *service;
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, UUID_DIS);
+	service = gatt_db_add_service(database->db, &uuid, true, 3);
+
+	if (main_opts.did_source > 0) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_PNP_ID);
+		gatt_db_service_add_characteristic(service, &uuid,
+						BT_ATT_PERM_READ,
+						BT_GATT_CHRC_PROP_READ,
+						device_info_read_pnp_id_cb,
+						NULL, database);
+	}
+
+	gatt_db_service_set_active(service, true);
+
+	database_add_record(database, service);
+}
 
 static void register_core_services(struct btd_gatt_database *database)
 {
 	populate_gap_service(database);
 	populate_gatt_service(database);
+
+	if (main_opts.did_source > 0)
+		populate_devinfo_service(database);
+
 }
 
 static void conf_cb(void *user_data)
-- 
2.28.0.rc0.105.gf9edc3c819-goog

