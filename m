Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADFAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 20:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbiDMU5b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbiDMU52 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 16:57:28 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9C86A42B
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:55:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d2d45c0df7so26831037b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6LJF+h/akEcwhrcKGG2Skrxic+lav38EsF4kiYAdZbg=;
        b=ok9u4niOOz0V1a+9YkmZq9LN8Qyv2y9qKc3wKaM9JozM74VJmMbEmQsVNL8SYgRknV
         hHeJubzVNpf4J6PRnhAicP942B4HDdDTbiRECgwYTdpg612+77ZEwKGtSa4bKylSgu95
         Z4bI7KSHqhM+eRu9atMYzQte0ok/XntETEmYOIL7ZlARd2NrCHNnI5J8Ev3nd7oXDzLM
         VObs3COCVYR3PYXTGvXCn4WLn/RYPzUABUXT4CKDb14QT0Qo3U/b3kVnQsVqFdLXFZxM
         TrTPaThCOETJt7vlQDUFR398A82ugaRCfwPK6TklAIuqWo9eT+l71dq3EO0JFvE6Hb+F
         OLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6LJF+h/akEcwhrcKGG2Skrxic+lav38EsF4kiYAdZbg=;
        b=XVuVPy3Boh8mRBi9c19eE0DMRojqUT8iVPCAGQQjleIZBzN5g+r1L7MmaOdlLVEGTN
         i5efd+0ndQpBX7MxbAcOql0UnoYQQSG3jElxRsZOHqrrdP02tWly2tvlDuxPZnc9P/Ix
         VC0Eb5XKj8snNWoIRqUukuhgSSJkdGVOO9DllyPw4jVuVmNtZrsVSeDlWEBA6PeaYfvU
         /fLHW/sOvaK2OxPIx49bRgoCCvFUeXMBHaXZJyd4KxKX4Y8lewDd2HxNyw6PHsALajIs
         T9f+RiYqNATKpc6iFsdZLiUcf9L0CCmUEuFi+38Sz8tqGJWX58pCIdcDE+VUINow9oYr
         ClxA==
X-Gm-Message-State: AOAM532YSNBJMbnCeTvAjLnaJoxqtD1qkqsvFAHJGOtxrzLBNauDqxNZ
        T/wgOBnXKGe9L38Ggpe0gmgEeXImxsSA5Q==
X-Google-Smtp-Source: ABdhPJyDHPgaBrEu+DCNJmbji2xwRFNzK/BtY3//idNSXOoTs4C3JDmOmSowMQnAhRk27SIscCMjIOqUeTno4Q==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:2620:46aa:79ff:778d])
 (user=mmandlik job=sendgmr) by 2002:a81:59d5:0:b0:2ef:4aa0:fdc1 with SMTP id
 n204-20020a8159d5000000b002ef4aa0fdc1mr661801ywb.113.1649883306144; Wed, 13
 Apr 2022 13:55:06 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:54:45 -0700
In-Reply-To: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220413135223.BlueZ.v2.5.I53ad1b66c8f8a65e5950354cd20417d812ad9c72@changeid>
Mime-Version: 1.0
References: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [BlueZ PATCH v2 5/9] monitor: Display AdvMonitor DeviceFound/Lost events
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Display information about MGMT_EV_ADV_MONITOR_DEVICE_FOUND and
MGMT_EV_ADV_MONITOR_DEVICE_LOST events in the btmon output.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 monitor/packet.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index b7431b57d..6f615f7ba 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14103,6 +14103,31 @@ static void mgmt_device_found_evt(const void *data, uint16_t size)
 	print_eir(data + 14, size - 14, false);
 }
 
+static void mgmt_adv_monitor_device_found_evt(const void *data, uint16_t size)
+{
+	uint16_t handle = get_le16(data);
+	uint8_t address_type = get_u8(data + 8);
+	int8_t rssi = get_s8(data + 9);
+	uint32_t flags = get_le32(data + 10);
+	uint16_t data_len = get_le16(data + 14);
+
+	print_field("Handle: %u", handle);
+	mgmt_print_address(data + 2, address_type);
+	print_rssi(rssi);
+	mgmt_print_device_flags(flags);
+	print_field("Data length: %u", data_len);
+	print_eir(data + 16, size - 16, false);
+}
+
+static void mgmt_adv_monitor_device_lost_evt(const void *data, uint16_t size)
+{
+	uint16_t handle = get_le16(data);
+	uint8_t address_type = get_u8(data + 8);
+
+	print_field("Handle: %u", handle);
+	mgmt_print_address(data + 2, address_type);
+}
+
 static void mgmt_discovering_evt(const void *data, uint16_t size)
 {
 	uint8_t type = get_u8(data);
@@ -14414,6 +14439,10 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_controller_suspend_evt, 1, true },
 	{ 0x002e, "Controller Resumed",
 			mgmt_controller_resume_evt, 8, true },
+	{ 0x002f, "Adv Monitor Device Found",
+			mgmt_adv_monitor_device_found_evt, 16, false },
+	{ 0x0030, "Adv Monitor Device Lost",
+			mgmt_adv_monitor_device_lost_evt, 9, true },
 	{ }
 };
 
-- 
2.36.0.rc0.470.gd361397f0d-goog

