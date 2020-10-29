Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1260C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 10:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48C7220790
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 10:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQLb7sn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgJ2KJy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 06:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgJ2KJx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 06:09:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D86EC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 03:09:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j10so2129883ybl.19
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=sW5mHlAap6rTyxjFI3mUs22oFcWFkQ9PYJatsj0rvu4=;
        b=RQLb7sn79a/WRVWhH37CpoY4AAsRR9BQf3cEtp5+vgBYfYCVKGl2yjwYJsN4d/GxlB
         Xrmb00vU16iXWWrveoKI6VLiKMDQr5PAhrBBpEDJu7XsZqTR+2wHGCKxz1ROp7zjRZ6R
         ADwxMh4l2qAQm2fUdLQ0raB2r8zE8pRB/ZtMLGXhEaY/g8Ks4D7TiBFM16HlePMxujaq
         skpitFJHPEhIuEjC8v+6y6nyP2byP1nQ109/alffeyOS+znnVMsYE62NrK3PMo1HX6r3
         rLgt1lx7roXPOzXIUX4BtnBc1YAi3bBwokCwRFnsoe2Ber7i6or+OezaptMeA18Ru2Ka
         NflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=sW5mHlAap6rTyxjFI3mUs22oFcWFkQ9PYJatsj0rvu4=;
        b=TEFhVn4Xt0Ful5CodrjkOMkrFiG+F+Wa7Fuhw5KkXOp5sszhcawQBgS7qiLhHFzhbI
         P+NvD8CnA+v7yWEkrr93YWecGC3Lu+r1xoHzO6twxD6GNrAL/YiKdEIexSuZzsmvLxKS
         Suan7J1k1d0Tk0vrBXJ3APtHnIyccOBVozsUYuuwnkvUE7JfHaEIkh4F9CJYFgdQPmft
         6NClMrr2olpgdSsaXuvWeQHbBT0PpDasw0tLGxAcgZO7KlsLQFc+SViiiemaQmh/8ov0
         S6KmCRiXtVxIdP676pLFlu9ptxtOAHX69eg6RWX+QJotf5wvDg4irqIbbGgbX1yC4KHs
         FteA==
X-Gm-Message-State: AOAM530mKPT3+0X1ZCprauhYN1KyA8TquseP3eB1aQ+1iX+4NDguEYJB
        mfYne2Vul24j5T88dJspaP1PEFNCySGV8OIrmtAgGhMRZjYThYSf/thFEQ9mxp3Ihgw9GKyFnGX
        cmyOGGfwoEMbs0uONb1TKZDZNdJQ5AAxOabjVp18TXdo7f077aug6jHF/EkwbLn1QDpLpun+q8r
        hZmT7Zf43o448=
X-Google-Smtp-Source: ABdhPJwzl6cPgb+iRjL6LVz6IcKWJkaGL7gIxBx8Qt90UqOicW1GghKM1LdomEAkX4Gs6jN6n5FpX4e27+6LN2lZWg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a5b:ec2:: with SMTP id
 a2mr4719844ybs.13.1603966190734; Thu, 29 Oct 2020 03:09:50 -0700 (PDT)
Date:   Thu, 29 Oct 2020 18:09:43 +0800
Message-Id: <20201029180756.BlueZ.1.I3e9cc07cf60d04d69c8045c442b6cf9f0c3292e7@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [BlueZ PATCH 1/3] monitor: Decode ADV Monitor read feature command
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, luiz.dentz@gmail.com, mcchou@chromium.org,
        mmandlik@chromium.org, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for Read Advertisement Monitor Features mgmt operation.

@ MGMT Command: Read Advertisement Monitor Features (0x0051) plen 0
@ MGMT Event: Command Complete (0x0001) plen 20
      Read Advertisement Monitor Features (0x0051) plen 17
        Status: Success (0x00)
        Supported Features: 0x00000000
        Enabled Features: 0x00000000
        Max number of handles: 32
        Max number of patterns: 16
        Number of handles: 2
          Handle: 1
          Handle: 3

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 monitor/packet.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index d83552f74f5b..2516cf970f9f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -88,6 +88,7 @@
 #define COLOR_UNKNOWN_ADV_FLAG		COLOR_WHITE_BG
 #define COLOR_UNKNOWN_PHY		COLOR_WHITE_BG
 #define COLOR_UNKNOWN_ADDED_DEVICE_FLAG	COLOR_WHITE_BG
+#define COLOR_UNKNOWN_ADVMON_FEATURES	COLOR_WHITE_BG
 
 #define COLOR_PHY_PACKET		COLOR_BLUE
 
@@ -13151,6 +13152,50 @@ static void mgmt_set_device_flags_rsp(const void *data, uint16_t size)
 	mgmt_print_address(data, type);
 }
 
+static const struct bitfield_data mgmt_adv_monitor_features_table[] = {
+	{ 1, "OR Patterns"	},
+	{ }
+};
+
+static void mgmt_print_adv_monitor_features(char *label, uint32_t flags)
+{
+	uint32_t mask;
+
+	print_field("%s: 0x%8.8x", label, flags);
+	mask = print_bitfield(2, flags, mgmt_adv_monitor_features_table);
+	if (mask)
+		print_text(COLOR_UNKNOWN_ADVMON_FEATURES,
+			   "  Unknown Flags (0x%8.8x)", mask);
+}
+
+static void mgmt_print_adv_monitor_handles(const void *data, uint8_t len)
+{
+	uint8_t idx = 0;
+
+	while (idx + 2 <= len) {
+		print_field("  Handle: %d", get_le16(data + idx));
+		idx += 2;
+	}
+}
+
+static void mgmt_read_adv_monitor_features_rsp(const void *data, uint16_t size)
+{
+	uint32_t supported_features = get_le32(data);
+	uint32_t enabled_features = get_le32(data + 4);
+	uint16_t max_num_handles = get_le16(data + 8);
+	uint8_t max_num_patterns = get_u8(data + 10);
+	uint16_t num_handles = get_le16(data + 11);
+
+	mgmt_print_adv_monitor_features("Supported Features",
+							supported_features);
+	mgmt_print_adv_monitor_features("Enabled Features",
+							enabled_features);
+	print_field("Max number of handles: %d", max_num_handles);
+	print_field("Max number of patterns: %d", max_num_patterns);
+	print_field("Number of handles: %d", num_handles);
+	mgmt_print_adv_monitor_handles(data + 13, size - 13);
+}
+
 struct mgmt_data {
 	uint16_t opcode;
 	const char *str;
@@ -13382,6 +13427,9 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x0050, "Set Device Flags",
 				mgmt_set_device_flags_cmd, 11, true,
 				mgmt_set_device_flags_rsp, 7, true},
+	{ 0x0051, "Read Advertisement Monitor Features",
+				mgmt_null_cmd, 0, true,
+				mgmt_read_adv_monitor_features_rsp, 13, false},
 	{ }
 };
 
-- 
2.29.1.341.ge80a0c044ae-goog

