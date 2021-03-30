Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F43C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 17:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C43619AA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 17:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhC3RKE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhC3RJd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 13:09:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA54C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 10:09:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t18so8084449pjs.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZS6sThfqjshdRC3W4218xxZ9WPfdlcU3PbIZ0teUGGM=;
        b=mQOaLv+9F5+g70Jb42sXzpCiQveylupneUNCKOeytQpL3/iWsM/EfoiId+q5QneyHJ
         fIod0PntWeWpBCqqHGUD9926cU68v8hU621iXET7UU57JtE2bxpZQhiHvAOIzpE7/HQh
         L9ygnLx6t5j7SkoUGDl6U/t5EVdrYZ5Z4m11c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZS6sThfqjshdRC3W4218xxZ9WPfdlcU3PbIZ0teUGGM=;
        b=ta5uNgm3qdVdkbKOGi65JMlzfRc+sDbr4hQPKX4Hkc0/6GvfAmvsVIrHhkcumQ2j1k
         FXbtoI/IJ+aEnMAaNSWkeoEyKDtIZxWKNYOrVmT8moYMQ0qgUaSIW9dV00DV+Vc2eVAA
         MxKuxRYWiPFC5CzZrXlEbl3Up0/gyQ7kr7tA/AdPWE/7fnEESqDz+reI7c2Kw3zGI505
         nUQK3nz6LDaxQOkwNvvhhAeAOgI0zhZSBWY1Ws/NnPn5gqwTFbzvnniQ3MYvUMcGZMlF
         5TQ1p2v2bk6CJo2Zp+/YkeyZ6y6+KXu4xaxv81BQCgw+RamvHVjIAXzfK2fIameBVi4z
         4RPQ==
X-Gm-Message-State: AOAM532ME20X7FEAjINVDPBA0nOigxZ+DLBmtw2YLtmvY6RwnXfjeo3R
        A191Xxi00EpmhbiYra83XOuNyU53qp0t8w==
X-Google-Smtp-Source: ABdhPJxT9EQ7zZ+SOfe1rUQ99QkpsVd6ugdGkAxk2eMJxHO+ARLvipnrM++2jTznUGWcDR03ZSUiKA==
X-Received: by 2002:a17:90b:360d:: with SMTP id ml13mr5222217pjb.161.1617124171965;
        Tue, 30 Mar 2021 10:09:31 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:7587:91c9:c28b:2af5])
        by smtp.gmail.com with ESMTPSA id m9sm11534006pgt.65.2021.03.30.10.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 10:09:31 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] profiles/battery: Always update initial battery value
Date:   Tue, 30 Mar 2021 10:09:24 -0700
Message-Id: <20210330170924.16983-1-sonnysasaka@chromium.org>
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

