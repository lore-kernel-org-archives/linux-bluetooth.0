Return-Path: <SRS0=Z40G=BI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35DAC433E3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 01:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D259920672
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 01:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SC7rQlSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgG2Bzu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 21:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgG2Bzt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 21:55:49 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E02C061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 18:55:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 74so3839285pfx.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 18:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:from:to:cc:subject:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9tHOYGHXDOyo1QrY3O2NS3y2FvJoyL66dBlAcJ/QoY=;
        b=SC7rQlSepHJSQg0tfeCHKAL2xOxdBJRzRWmpwTSwYph0EzU1FYxVeP+IkmPYkJ6j1z
         ClgcP2EqO4V+KfW24Hz+sJCROAQkBP5D6W/r5CuTc5aptzyf+XftKPQOgG8xjMULBlva
         IWBUfTLjQxhfSmSOdNhA1Ho/1UuUskTjTPl0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9tHOYGHXDOyo1QrY3O2NS3y2FvJoyL66dBlAcJ/QoY=;
        b=s5i80hoMZmeEvH4EeStGfKeQzctVIMx1lrYtQgJsKA4BLd8p4wMBbuWzsF6sJZR4T2
         YUJlwAZCstz5BvLAuihDomv1U5jCKQFRMOh0CjQxONS/O5gp+/5FkZFZelKwedIXfE8y
         hXRj0GGs6jBKBggVWLe4d31f3aRu0gE3kuGa0XTz+1TwGfl0XMLnatS+6VyGLhAqI70z
         XpVM2Fs+NGiexkIeuWluwjOeFUr7s3NJMl1k50YmPh53u6iJzZFTAO+4NIVRFg3vTzII
         3Xd1Z5mYcIFyg2PN5Hcfnj8Kw8gWfpqvmDU3Zqqxflu/oOQbHpzh7P4k0wZEntNDae/G
         LiGA==
X-Gm-Message-State: AOAM53313JSqEJIOXx6YWHUPTsV755g7YQ5cUGJc2jzSwAA+F4V1FCNk
        lWv2s2noOO9hcMelNQqGBQ6JqA==
X-Google-Smtp-Source: ABdhPJxr9zkj1C+DCF+5a6tg3zWzxJbC2CqLzGKdoccE1LI8M3A2pjItwUtmx7kQUMEn0FMOAkwPRw==
X-Received: by 2002:a65:67d9:: with SMTP id b25mr27592188pgs.311.1595987749068;
        Tue, 28 Jul 2020 18:55:49 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id lr1sm371128pjb.27.2020.07.28.18.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 18:55:48 -0700 (PDT)
Message-ID: <5f20d724.1c69fb81.6d882.1d21@mx.google.com>
X-Google-Original-Message-ID: <20200728185415.RFC Bluez.2.Id78b98210807c1326ee2c187af73a325fc97f1e1@changeid>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [RFC Bluez PATCH 2/3] monitor: Add btmon support for Suspend and Resume events
Date:   Tue, 28 Jul 2020 18:55:39 -0700
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200729015540.1848987-1-abhishekpandit@chromium.org>
References: <20200729015540.1848987-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support to pretty print Suspend and Resume mgmt events in btmon.

Example:

@ MGMT Event: Controller Suspended (0x002d) plen 1
        Suspend state: Page scanning and/or passive scanning (2)

@ MGMT Event: Controller Resumed (0x002e) plen 8
        Wake reason: Remote wake due to peer device connection (2)
        LE Address: CD:F3:CD:13:C5:9A (OUI CD-F3-CD)

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 monitor/packet.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 431a39b66..451630e04 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13555,6 +13555,9 @@ static void mgmt_device_disconnected_evt(const void *data, uint16_t size)
 	case 0x04:
 		str = "Connection terminated due to authentication failure";
 		break;
+	case 0x05:
+		str = "Connection terminated by local host for suspend";
+		break;
 	default:
 		str = "Reserved";
 		break;
@@ -13782,6 +13785,54 @@ static void mgmt_device_flags_changed_evt(const void *data, uint16_t size)
 	mgmt_print_added_device_flags("Current Flags", current_flags);
 }
 
+static void mgmt_controller_suspend_evt(const void *data, uint16_t size)
+{
+	uint8_t state = get_u8(data);
+	char *str;
+
+	switch (state) {
+	case 0x0:
+		str = "Controller running (failed to suspend)";
+		break;
+	case 0x1:
+		str = "Disconnected and not scanning";
+		break;
+	case 0x2:
+		str = "Page scanning and/or passive scanning";
+		break;
+	default:
+		str = "Unknown suspend state";
+		break;
+	}
+
+	print_field("Suspend state: %s (%d)", str, state);
+}
+
+static void mgmt_controller_resume_evt(const void *data, uint16_t size)
+{
+	uint8_t addr_type = get_u8(data + 6);
+	uint8_t wake_reason = get_u8(data + 7);
+	char *str;
+
+	switch (wake_reason) {
+	case 0x0:
+		str = "Resume from non-Bluetooth wake source";
+		break;
+	case 0x1:
+		str = "Wake due to unexpected event";
+		break;
+	case 0x2:
+		str = "Remote wake due to peer device connection";
+		break;
+	default:
+		str = "Unknown wake reason";
+		break;
+	}
+
+	print_field("Wake reason: %s (%d)", str, wake_reason);
+	mgmt_print_address(data, addr_type);
+}
+
 static const struct mgmt_data mgmt_event_table[] = {
 	{ 0x0001, "Command Complete",
 			mgmt_command_complete_evt, 3, false },
@@ -13863,6 +13914,10 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_exp_feature_changed_evt, 20, true },
 	{ 0x002a, "Device Flags Changed",
 			mgmt_device_flags_changed_evt, 15, true },
+	{ 0x002d, "Controller Suspended",
+			mgmt_controller_suspend_evt, 1, true },
+	{ 0x002e, "Controller Resumed",
+			mgmt_controller_resume_evt, 8, true },
 	{ }
 };
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

