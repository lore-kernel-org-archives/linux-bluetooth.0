Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD31C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 14:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778B622B4D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 14:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d28AYG6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgGQOkN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgGQOkM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 10:40:12 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55C4C0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 07:40:12 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id q15so4968758vso.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjUlDVuPtPdSCx+f/FpW9ivNQqmi/K/CqsiUpmcooyw=;
        b=d28AYG6k+lZi39HwDNYPvF7uULiV5EDpThgcn1pcvl8g5BDJr4dF858+vgDprun91l
         OeN7tM1d9JEHbZea8mYcpZ5VHTPTCPADLue85ZVtUnnQtWXnf/D4vblPQVSkF88oGl0I
         aH0YfyCtPEgLGp8Quuvas797NM0ESRvX4bz3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjUlDVuPtPdSCx+f/FpW9ivNQqmi/K/CqsiUpmcooyw=;
        b=jVA6Zwf0D3/Ct9d9+G/jG4xAVhppww+KJPBOl5Nj9M+o9S5KqPfly3I50uEE3Doo2r
         VGpuqlEJWk82FCNTXjEZFsxY5fs/mXQAhDONyg6XUv0d3gbr8OeVakPGvbjSn9QV1zWQ
         ofF9+eEvJeLTa/AESW7l69Bf2XK4ozthMXqo0dvXE9DVoeAYDHtfvhjthHsreoBgqE4i
         y3eCXuUfTFK5t++ZLauHokumDI6BDaN2jbvQYXu3nq7Yn9W84qOr9Ho3MhavFL6PXylV
         y5noTwsAYUU3/CpRRoYaD0SLz2uH7E96AQJMv0SEpaDYYMv0MgvBo8Apu0wh9IHKOxlh
         mwxA==
X-Gm-Message-State: AOAM530DtS4ZDiANwgyDjZGeScgY2qZJ8yv5/aAoscL3sr9llmu99dHO
        /3cTo34YE9r88OOJVOtfLPIABhAIIRM=
X-Google-Smtp-Source: ABdhPJyaNo5h4VZSx0cj1tXHlgthFAXiKKM1297/45YNRzmLc4pcXcZi0zpvrfvfAmc8XbjNzQ3fFg==
X-Received: by 2002:a67:cb03:: with SMTP id b3mr7815318vsl.214.1594996811360;
        Fri, 17 Jul 2020 07:40:11 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id 132sm1206123vkb.2.2020.07.17.07.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:40:10 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [Bluez PATCH v2] gatt: Support DeviceInfo Service when vid/pid is specified
Date:   Fri, 17 Jul 2020 14:40:07 +0000
Message-Id: <20200717144007.3160721-1-alainm@chromium.org>
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

Changes in v2:
 - Removing file I didn't intend to commit (peripheral/gatt.c)

 src/gatt-database.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

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

