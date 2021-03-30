Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9E8C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3127E619CF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhC3SX7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhC3SX3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 14:23:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E405C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:23:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w8so8180357pjf.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rlwLfk5Pcjc8ov49J3YIWAGsLTxvnqJQPkiZoKs4R1M=;
        b=gsimQjj3KBQqrDjKDcQi3q8HYqgW1Ba+3Dnvxo6QW0nMr/QvTYdQTI2ciAae0w59CU
         TS6SAXr3F7Nt63/MmU9hvmoSo+oyzA/8yTPBuQX0FC+HBXpvPN9cBI3a/lhAVjYd1nhi
         5Xs2nP9seHQAbG1qkqwwOx5kzTf64V7dHRGlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rlwLfk5Pcjc8ov49J3YIWAGsLTxvnqJQPkiZoKs4R1M=;
        b=W9WBzcCqPUNvthgb8eNCZfnnPgXR4LkhmDDyPY05VXqdGdJHrxPIXxuikUrAfXiTa2
         DALPcmcGUquiIKgAq57VOZwWoID1g9OnrMWBr/Ld/0J2waez4qJ3oXwD+DQbx+zzcxko
         yLuwjCzm89Ax/2qn8NaaPnQrHlLk9n6yLU9JO/a6jGEpdFT4ey2n13OEz4Ow75wrxg06
         mDWes5uY8gRKO0luzOoCasA5ZmTZpnfrVjXnB/E2NUSGpaZRougSkBmoanNMRo+j2iYo
         U0hSlTLDM3NuyLFAZ3/3UzlBFgsfR/bcXTSwogi0yhnIhUUt5vCMFgsTNPX6YsUsNo18
         2Hkg==
X-Gm-Message-State: AOAM531vbgGgjF+utD19MHp/2Y3hEALap+SVnv9W44wG7Bvt63eKygao
        5rp8ASkkEz762/BC08jbjubA3912Bdiuyw==
X-Google-Smtp-Source: ABdhPJzQaIHYYgSo2vWBgm0hvv8XjNVbokR8JaD2z11N7kbMaoFeGykaPz27SpBKe5TF/oX3X9vQoA==
X-Received: by 2002:a17:903:188:b029:e6:52f4:1b2d with SMTP id z8-20020a1709030188b02900e652f41b2dmr35534995plg.58.1617128607816;
        Tue, 30 Mar 2021 11:23:27 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:7587:91c9:c28b:2af5])
        by smtp.gmail.com with ESMTPSA id 6sm21154125pfv.179.2021.03.30.11.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 11:23:27 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH BlueZ v2] profiles/battery: Always update initial battery value
Date:   Tue, 30 Mar 2021 11:23:19 -0700
Message-Id: <20210330182319.17537-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Due to cache in gatt db, bluetoothd fails to update publish the battery
value after reconnection when the battery value does not change compared
to before reconnection. For initial battery value, we should update the
value to D-Bus regardless of the cache value.

Reviewed-by: Alain Michaud <alainm@chromium.org>

---
 profiles/battery/battery.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 81f849d57..d273908f9 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -46,6 +46,8 @@
 
 #define BATT_UUID16 0x180f
 
+enum battery_update { UPDATE_ON_CHANGE, ALWAYS_UPDATE };
+
 /* Generic Attribute/Access Service */
 struct batt {
 	struct btd_battery *battery;
@@ -88,12 +90,13 @@ static void batt_reset(struct batt *batt)
 }
 
 static void parse_battery_level(struct batt *batt,
-				const uint8_t *value)
+				const uint8_t *value,
+				enum battery_update update)
 {
 	uint8_t percentage;
 
 	percentage = value[0];
-	if (batt->percentage != percentage) {
+	if (update == ALWAYS_UPDATE || batt->percentage != percentage) {
 		batt->percentage = percentage;
 		DBG("Battery Level updated: %d%%", percentage);
 		if (!batt->battery) {
@@ -110,7 +113,7 @@ static void batt_io_value_cb(uint16_t value_handle, const uint8_t *value,
 	struct batt *batt = user_data;
 
 	if (value_handle == batt->batt_level_io_handle) {
-		parse_battery_level(batt, value);
+		parse_battery_level(batt, value, UPDATE_ON_CHANGE);
 	} else {
 		g_assert_not_reached();
 	}
@@ -134,7 +137,7 @@ static void batt_io_ccc_written_cb(uint16_t att_ecode, void *user_data)
 		return;
 	}
 
-	parse_battery_level(batt, batt->initial_value);
+	parse_battery_level(batt, batt->initial_value, ALWAYS_UPDATE);
 	g_free (batt->initial_value);
 	batt->initial_value = NULL;
 
-- 
2.29.2

