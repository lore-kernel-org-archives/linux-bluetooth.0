Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA8AC433C1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 17:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B2B6196C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 17:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhC3RMM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbhC3RLn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 13:11:43 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADC0C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 10:11:42 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id p12so7535785pgj.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 10:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Ii0GdYqoNhI0rJP1v+nODicEmLM311yN6/BASfxZUo=;
        b=AlJhF4HDSljCD6u+3smGUqoi3Wgrkz/G0dZZjPFRAMFJXsrcUZkJEo8t2tihXbDyPO
         UDSgL8xpyJBDPOFDVTRvzmcb4MXEsZJ3a/4DK8c4U+ozcKKt9mQ2GZ1H+Hkang5v/sKU
         duGk3f29/UB0hzjSEG2KYpcy2vKauJAbn9m3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Ii0GdYqoNhI0rJP1v+nODicEmLM311yN6/BASfxZUo=;
        b=t1eAQ9yEiZOQDZe73bNhmmSST8kLDXmY0IeVw7xYw0UkBvI7vIsU/n5dAgh33wa3lH
         WcbkQFNZGt26whGDoJ5FqhtTfL2KiXp67vflRlMQdxxDDxRpXfb6k40tZWjg8OLfXkTQ
         jC3VJ+Dm4qcUgvHj9FhHwv7XAfvZCnNk/xgcgS5uCkuKPLidaajU6KTOBu2iAm7K2vhX
         sIpqD/aV4SRGzbSn2moWTW7Sgd+gByqN50if2nO7q6de8Y5eGJH5ySWmioxej102lAqT
         ylovmXsADdhoI0YVSPb5LqlGRplzZvKyCV/vZlA5qJIpXe1DgxjTsZX2X9iOyhy5ybVu
         EtLw==
X-Gm-Message-State: AOAM530AX8X9BBw0GLwYE6LmKWpzIK9SSY7sv7VRf/TgCeb7fBOzDjl3
        egh3SWmwABH2xc6iQxf/lVm0d7fqKqRJ9w==
X-Google-Smtp-Source: ABdhPJwvFdK8rup7WyMwZtzU1dwOg0vqUtoky0A4nIWIzgJPUCIHepbAS/P94ueNlBJ7G1q8/wayVA==
X-Received: by 2002:a63:520e:: with SMTP id g14mr29006033pgb.350.1617124302149;
        Tue, 30 Mar 2021 10:11:42 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:7587:91c9:c28b:2af5])
        by smtp.gmail.com with ESMTPSA id r1sm20487848pfh.153.2021.03.30.10.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 10:11:41 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH BlueZ] profiles/battery: Always update initial battery value
Date:   Tue, 30 Mar 2021 10:11:37 -0700
Message-Id: <20210330171137.17112-1-sonnysasaka@chromium.org>
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
 profiles/battery/battery.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 81f849d57..0f8d6ef18 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -88,12 +88,13 @@ static void batt_reset(struct batt *batt)
 }
 
 static void parse_battery_level(struct batt *batt,
-				const uint8_t *value)
+				const uint8_t *value,
+				bool force_update)
 {
 	uint8_t percentage;
 
 	percentage = value[0];
-	if (batt->percentage != percentage) {
+	if (force_update || batt->percentage != percentage) {
 		batt->percentage = percentage;
 		DBG("Battery Level updated: %d%%", percentage);
 		if (!batt->battery) {
@@ -110,7 +111,7 @@ static void batt_io_value_cb(uint16_t value_handle, const uint8_t *value,
 	struct batt *batt = user_data;
 
 	if (value_handle == batt->batt_level_io_handle) {
-		parse_battery_level(batt, value);
+		parse_battery_level(batt, value, false /* force_update */);
 	} else {
 		g_assert_not_reached();
 	}
@@ -134,7 +135,7 @@ static void batt_io_ccc_written_cb(uint16_t att_ecode, void *user_data)
 		return;
 	}
 
-	parse_battery_level(batt, batt->initial_value);
+	parse_battery_level(batt, batt->initial_value, true /* force_update */);
 	g_free (batt->initial_value);
 	batt->initial_value = NULL;
 
-- 
2.29.2

