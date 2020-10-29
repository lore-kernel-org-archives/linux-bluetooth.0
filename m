Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FD9C55179
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 10:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4905C2076E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 10:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2Oc43OP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgJ2KJ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 06:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgJ2KJ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 06:09:58 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D4CC0613D2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 03:09:57 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id r9so1658904plo.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 03:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qAxecWkY82CNqox5BnnnB1aHpXO+0cSvp3WarkQEDVU=;
        b=H2Oc43OPe+PvVZyV5HBGlWf+IVnywYZ3CpOq2bEoCvaFAfj/4LPKa5Hnjy4W4F3Y5S
         IrwVkLwpWlyOaGaTEyzjK+XSIY+8nwotuU4T33ZsPHJQ2C5mmgNWHG/aBIVAALTyCile
         nyiaEZWWmK0wtpaX9IIYvpuYmU9SO62XEO+X689oqIZvhCrEH7viBQ04gwnjcqDkUsPA
         cL+4VYGonkTwlK1xJUJEQdiL6o/dtfghAWkP3az4Vhz+OnRw7p0imGXpPt+vAHvKDimX
         3EXFq6v68sH3wDDbve6prKOI/kYH7NQ3YqaC/YZ+kkRMt6a02zLU55AbZU/UxpV1I8jA
         bh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qAxecWkY82CNqox5BnnnB1aHpXO+0cSvp3WarkQEDVU=;
        b=Mx1vJVpc01oBx4/qjw8/7tKXLRw1zNjrbF9t1eVXCYrjKfU2jZ3W2z53XwM8dkXPEA
         V6Mm+4rkCWNFJZyqx7ZYwThfgmpwz6hubexzp0Pk+1ejacOBiR+SPQrPTvE319zMQ05C
         r4vgW1SQ44zCXnZ3wITtjcGoWLfC00JgUjU1a9BrF91BjcZuSU0G9Wqfx35tVmlJaI7m
         Pn7rAJWZu1vdFBvPswZbJOPMmb22lVbVGqd6h2tvbHiEXMWgmeN8UIsvHup7tZg+QGXf
         aF8ohQ9hB1s06FPK1R7YQbnrJJ/LTePAlIQabIv9WmpwDjBIXU5TbA3cwPgxzuYbtFtr
         KdYg==
X-Gm-Message-State: AOAM530NxVtZh0AbU0Ph+tfDR2oEIhMkg+pWwYiBvpna4uVzMmfZa0lz
        3pFqBvBC0Qewog7nc6T2SdhQmPJtfCTC2IPCyYhq1z+xRzdmB3T+JG/5Ya9Tu4Ty34hcwEyNK/d
        DFQe3uzUO9CAq/o/vqCm8ItNTYTzSdL9C+wx0NmYDi0QG2jMHuM6HTNH7rLo2NOZEQjUr4Un2gk
        S6/3R6k8jyd+o=
X-Google-Smtp-Source: ABdhPJxhJFZPy0aTzYzfGWAYHatVYqx6xmL7M1NBX1bzU2Fww9498hBhxtI4dRulfoZd2uMxj9kLDiP3UXSanTvZdQ==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:902:342:b029:d5:ab9e:19ce with
 SMTP id 60-20020a1709020342b02900d5ab9e19cemr3308856pld.48.1603966196397;
 Thu, 29 Oct 2020 03:09:56 -0700 (PDT)
Date:   Thu, 29 Oct 2020 18:09:44 +0800
In-Reply-To: <20201029180756.BlueZ.1.I3e9cc07cf60d04d69c8045c442b6cf9f0c3292e7@changeid>
Message-Id: <20201029180756.BlueZ.2.I194824d306a62ad461fd47421c505a39fbdc1bf4@changeid>
Mime-Version: 1.0
References: <20201029180756.BlueZ.1.I3e9cc07cf60d04d69c8045c442b6cf9f0c3292e7@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [BlueZ PATCH 2/3] monitor: Decode Add ADV monitor command
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, luiz.dentz@gmail.com, mcchou@chromium.org,
        mmandlik@chromium.org, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for Add Advertisement Monitor MGMT command and event.

@ MGMT Command: Add Advertisement Monitor (0x0052) plen 69
        Number of patterns: 2
          Pattern 1:
            AD type: 0
            Offset: 1
            Length: 2
            Value : ...
          Pattern 2:
            AD type: 1
            Offset: 10
            Length: 4
            Value : ...
@ MGMT Event: Advertisement Monitor Added (0x002b) plen 2
        Handle: 1
@ MGMT Event: Command Complete (0x0001) plen 5
      Add Advertisement Monitor (0x0052) plen 2
        Status: Success (0x00)
        Handle: 1

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 monitor/packet.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 2516cf970f9f..b3a6ed24d5fc 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13196,6 +13196,42 @@ static void mgmt_read_adv_monitor_features_rsp(const void *data, uint16_t size)
 	mgmt_print_adv_monitor_handles(data + 13, size - 13);
 }
 
+static void mgmt_print_adv_monitor_patterns(const void *data, uint8_t len)
+{
+	uint8_t data_idx = 0, pattern_idx = 1;
+
+	/* Reference: struct mgmt_adv_pattern in lib/mgmt.h. */
+	while (data_idx + 34 <= len) {
+		uint8_t ad_type = get_u8(data + data_idx);
+		uint8_t offset = get_u8(data + data_idx + 1);
+		uint8_t length = get_u8(data + data_idx + 2);
+
+		print_field("  Pattern %d:", pattern_idx);
+		print_field("    AD type: %d", ad_type);
+		print_field("    Offset: %d", offset);
+		print_field("    Length: %d", length);
+		print_hex_field("    Value ", data + data_idx + 3, 31);
+
+		pattern_idx += 1;
+		data_idx += 34;
+	}
+}
+
+static void mgmt_add_adv_monitor_patterns_cmd(const void *data, uint16_t size)
+{
+	uint8_t pattern_count = get_u8(data);
+
+	print_field("Number of patterns: %d", pattern_count);
+	mgmt_print_adv_monitor_patterns(data + 1, size - 1);
+}
+
+static void mgmt_add_adv_monitor_patterns_rsp(const void *data, uint16_t size)
+{
+	uint16_t handle = get_le16(data);
+
+	print_field("Handle: %d", handle);
+}
+
 struct mgmt_data {
 	uint16_t opcode;
 	const char *str;
@@ -13430,6 +13466,9 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x0051, "Read Advertisement Monitor Features",
 				mgmt_null_cmd, 0, true,
 				mgmt_read_adv_monitor_features_rsp, 13, false},
+	{ 0x0052, "Add Advertisement Monitor",
+				mgmt_add_adv_monitor_patterns_cmd, 1, false,
+				mgmt_add_adv_monitor_patterns_rsp, 2, true},
 	{ }
 };
 
@@ -13834,6 +13873,13 @@ static void mgmt_device_flags_changed_evt(const void *data, uint16_t size)
 	mgmt_print_added_device_flags("Current Flags", current_flags);
 }
 
+static void mgmt_adv_monitor_added_evt(const void *data, uint16_t size)
+{
+	uint16_t handle = get_le16(data);
+
+	print_field("Handle: %d", handle);
+}
+
 static void mgmt_controller_suspend_evt(const void *data, uint16_t size)
 {
 	uint8_t state = get_u8(data);
@@ -13963,6 +14009,8 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_exp_feature_changed_evt, 20, true },
 	{ 0x002a, "Device Flags Changed",
 			mgmt_device_flags_changed_evt, 15, true },
+	{ 0x002b, "Advertisement Monitor Added",
+			mgmt_adv_monitor_added_evt, 2, true },
 	{ 0x002d, "Controller Suspended",
 			mgmt_controller_suspend_evt, 1, true },
 	{ 0x002e, "Controller Resumed",
-- 
2.29.1.341.ge80a0c044ae-goog

