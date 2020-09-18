Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93F4C43464
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A394821734
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LX5owZHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIRWO3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgIRWO2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 18:14:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC655C0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z40so6901612ybi.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=J9drwgPy+u2RdCrwGcexg5BWKopBb6gwvWAeo8EJ6zw=;
        b=LX5owZHSulCKx/HtzveTh6GC8JYO6n9t6YRoPjKZ4Dy8lydChwsBl5C0bG5QshekF+
         VVAp+yFpdmOnfeH/BgYhJXOeamsmGw70pscql5gXqyWiKSjeVus+rRRN0dYIS4cT9Fcc
         eh7FH7vy9yMF2L1tXpOmtsQ5me3n5vYsXC7BTULmUYBUYIJB6Y8+StxzDmajNP/ZXpmk
         +V26LlDKqpRou7PL6gXqgxkwfsjoK1Wec5YgEUQ58YYGCu8kFsTTw78bipqaCLY9+0Cv
         Y3kTg3ImzJLgwwtJ0B9ZnS3JDbmFovaJwGvkWgkPeoa8Sce9LvhmMpbjAGG7NZRrASPN
         /mtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J9drwgPy+u2RdCrwGcexg5BWKopBb6gwvWAeo8EJ6zw=;
        b=CInNNWqjg0+7iiCnmCWMdotxksuUdOPHQJgUkkHLvwV45O7bIcl1XF3WHZ7lerrpXQ
         BTzNCjWSArUNz16h7TQ8VJDSJCvGwlxGOkeFnX1fEKgB8h0SGyOU2XePU0nwTgMmdFxE
         2IZhg8cSJ3XQFPUU+KpnP35r9d0WAv57ZgUAPzZ/IuBvqMgK32+spEA/KjzVec7wQWPk
         ZtNp+8YZ3Ay79pYHnUdukPBh4gTfJBe3bE8Ouy4h2cDiaWkk3lKqxOZy51oLd6Jgb97P
         xeiA/wLzQL3/19u2+EbJZD4pB+DdjDaiqNsln5yUjh65JRK+aq6DIjECnJTUB4BAiQZ+
         OxyA==
X-Gm-Message-State: AOAM533nwnMrYwg1pjMTLdxoSf06mBgYRLWSbD+CZJj5dRDf4vwOmxj6
        X/IS+74OA1kuolDhVCi15GHxBs8AqgFimNxPxNNh
X-Google-Smtp-Source: ABdhPJyEImXuHW26vYPy0cgbzxuJIP36uq3MyO4zARnZnpXVqruym//Ug1ejiDGB9CnaEchde6KCuEztUTado2E0dIEn
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:c747:: with SMTP id
 w68mr20501310ybe.349.1600467267930; Fri, 18 Sep 2020 15:14:27 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:13:57 -0700
In-Reply-To: <20200918221357.3436905-1-danielwinkler@google.com>
Message-Id: <20200918151041.Bluez.v2.10.I2884e6456c272dadb3d70a629674027f23b0393e@changeid>
Mime-Version: 1.0
References: <20200918221357.3436905-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [Bluez PATCH v2 10/10] monitor: Add new MGMT adv commands and events
 to monitor
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the following to packet monitor:
-Add Ext Adv Params command and response
-Add Ext Adv Data command and response
-Add Advertising Power Selected event

This patch was manually tested by registering advertisements with
various features and verifying in btmon log.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v2: None

 monitor/packet.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index bef134095..5d1e6868e 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11872,6 +11872,26 @@ static void mgmt_print_adv_flags(uint32_t flags)
 							" (0x%8.8x)", mask);
 }
 
+static const struct bitfield_data mgmt_adv_params_table[] = {
+	{  0, "Use Duration parameter"	},
+	{  1, "Use Timeout parameter"	},
+	{  2, "Use Interval parameters"	},
+	{  3, "Use TX Power parameter"	},
+	{ }
+};
+
+static void mgmt_print_adv_params(uint16_t flags)
+{
+	uint32_t mask;
+
+	print_field("Enabled parameters: 0x%4.4x", flags);
+
+	mask = print_bitfield(2, flags, mgmt_adv_params_table);
+	if (mask)
+		print_text(COLOR_UNKNOWN_ADV_FLAG, "  Unknown advertising param"
+							" (0x%8.8x)", mask);
+}
+
 static void mgmt_print_store_hint(uint8_t hint)
 {
 	const char *str;
@@ -13163,6 +13183,53 @@ static void mgmt_set_device_flags_rsp(const void *data, uint16_t size)
 
 	mgmt_print_address(data, type);
 }
+static void mgmt_add_ext_adv_params_cmd(const void *data, uint16_t size)
+{
+	uint8_t instance = get_u8(data);
+	uint32_t flags = get_le32(data + 1);
+	uint16_t params = get_le16(data + 5);
+	uint16_t duration = get_le16(data + 7);
+	uint16_t timeout = get_le16(data + 9);
+	uint32_t min_interval = get_le32(data + 11);
+	uint32_t max_interval = get_le32(data + 15);
+	int8_t tx_power = get_s8(data + 19);
+
+	print_field("Instance: %u", instance);
+	mgmt_print_adv_flags(flags);
+	mgmt_print_adv_params(params);
+	print_field("Duration: %u", duration);
+	print_field("Timeout: %u", timeout);
+	print_ext_slot_625("Min advertising interval", &min_interval);
+	print_ext_slot_625("Max advertising interval", &max_interval);
+	print_power_level(tx_power, NULL);
+}
+
+static void mgmt_add_ext_adv_params_rsp(const void *data, uint16_t size)
+{
+	uint8_t instance = get_u8(data);
+
+	print_field("Instance: %u", instance);
+}
+
+static void mgmt_add_ext_adv_data_cmd(const void *data, uint16_t size)
+{
+	uint8_t instance = get_u8(data);
+	uint8_t adv_data_len = get_u8(data + 1);
+	uint8_t scan_rsp_len = get_u8(data + 2);
+
+	print_field("Instance: %u", instance);
+	print_field("Advertising data length: %u", adv_data_len);
+	print_eir(data + 3, adv_data_len, false);
+	print_field("Scan response length: %u", scan_rsp_len);
+	print_eir(data + 3 + adv_data_len, scan_rsp_len, false);
+}
+
+static void mgmt_add_ext_adv_data_rsp(const void *data, uint16_t size)
+{
+	uint8_t instance = get_u8(data);
+
+	print_field("Instance: %u", instance);
+}
 
 struct mgmt_data {
 	uint16_t opcode;
@@ -13395,6 +13462,12 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x0050, "Set Device Flags",
 				mgmt_set_device_flags_cmd, 11, true,
 				mgmt_set_device_flags_rsp, 7, true},
+	{ 0x0054, "Add Ext Adv Params",
+				mgmt_add_ext_adv_params_cmd, 20, false,
+				mgmt_add_ext_adv_params_rsp, 1, true },
+	{ 0x0055, "Add Ext Adv Data",
+				mgmt_add_ext_adv_data_cmd, 3, false,
+				mgmt_add_ext_adv_data_rsp, 1, true },
 	{ }
 };
 
@@ -13847,6 +13920,15 @@ static void mgmt_controller_resume_evt(const void *data, uint16_t size)
 	mgmt_print_address(data, addr_type);
 }
 
+static void mgmt_adv_power_selected_evt(const void *data, uint16_t size)
+{
+	uint8_t instance = get_u8(data);
+	int8_t tx_power = get_s8(data + 1);
+
+	print_field("Instance: %u", instance);
+	print_power_level(tx_power, NULL);
+}
+
 static const struct mgmt_data mgmt_event_table[] = {
 	{ 0x0001, "Command Complete",
 			mgmt_command_complete_evt, 3, false },
@@ -13932,6 +14014,8 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_controller_suspend_evt, 1, true },
 	{ 0x002e, "Controller Resumed",
 			mgmt_controller_resume_evt, 8, true },
+	{ 0x002f, "Advertising Power Selected",
+			mgmt_adv_power_selected_evt, 2, true },
 	{ }
 };
 
-- 
2.28.0.681.g6f77f65b4e-goog

