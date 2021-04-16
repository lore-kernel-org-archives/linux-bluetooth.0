Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC08C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 20:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED0C6124B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 20:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbhDPUHB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbhDPUHA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 16:07:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E61C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 13:06:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so17005133pjh.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 13:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=o2AGPONljbYZiX7hnBKFJGfWLt9TAIwGmTkRUL6wU2w=;
        b=AGKj69K76XxTtvDJYknoHS4I0xSawurstVChWdHd/dDNKWC4J049ezXNULy3l2AdaF
         8UgLJnw07rOSaPeeDU4pnJWYMdp4qzS/25NhEJ5RW7jHd+nEQ/t02OVXjwah2ggEysRi
         Y0STit4un66523IaTXzgCdk4nbuFw5hJf3GkW+JdEspGmYq3x3c1wo1GwAhH1vg7cKcM
         NLdvwgTXp/EtOGUkEYTCANjkmAINxYKeFJw2G+AUj3ZN6iauJ4B6/NTWSpNcyVkRZInq
         Nb4Y/LUh+GY1HxJ7bJTns0bIlOnPbr7/9jnFkfJ2jDZbMiGHS4woYWPPA7F42Le2GvF5
         vgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2AGPONljbYZiX7hnBKFJGfWLt9TAIwGmTkRUL6wU2w=;
        b=IoJgf88dE2lv2JyrIcLjhqyZRW560i2UKDhH7zYjO3EGj2RkH9OrQ+KgsAMmRP/Azv
         NBsjlVJHKMDWjUjspBgTHrAav+LkCTABx89pcoUAV8dfM6gd78BHIrwDGBgqEEwH9fDX
         LObOt3gOUYqVZTuo8eTRnXFDgVzmSn/uxMBDXgYv+Z74EAK4+/oY2w+k7S4Kmt1UevFf
         FQdHKqvSMOCQ5Ns6nA58CJ/px4+HiBiYHyhTBcGdi9L/BKan/gCywG2AMwMwBWKZW2yr
         KGsNzYDEDKkQEaeQddh53PTX98QwedQKE0QFPmUtDs8BXQv4+pW2U/6QlgiMlWasQfpx
         EvYA==
X-Gm-Message-State: AOAM530s11JABi4ZGoT9QJyv0qp74oLoijN3suJT5L05pqYzPJu5uSJ+
        Eezev8HC94kW49MYAzibkVqPFpH3OcM=
X-Google-Smtp-Source: ABdhPJxYVpNUTpHRexee97sKDWKpuhhYt7geMJiAGSYqpwUBHR/HafVlhIGIEmMOncqswnlhi4pkUA==
X-Received: by 2002:a17:90a:540b:: with SMTP id z11mr3622371pjh.133.1618603593900;
        Fri, 16 Apr 2021 13:06:33 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:b679:8f6d:6528:e787])
        by smtp.gmail.com with ESMTPSA id v8sm5369120pfm.128.2021.04.16.13.06.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:06:33 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] monitor: Add Intel read supported VS features command
Date:   Fri, 16 Apr 2021 13:06:32 -0700
Message-Id: <20210416200632.621635-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Tedd Ho-Jeong An <tedd.an@intel.com>
References: <Tedd Ho-Jeong An <tedd.an@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

< HCI Command: Intel Read Supported VS Features (0x3f|0x00a6) plen 1
        Page: 0x01
> HCI Event: Command Complete (0x0e) plen 22
      Intel Read Supported VS Features (0x3f|0x00a6) ncmd 1
        Status: Success (0x00)
        Page: 0x01
        Max Pages: 0x02
        Supported Features:
        1f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
---
 monitor/intel.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/monitor/intel.c b/monitor/intel.c
index 18840f3e7..1aee29cc8 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -471,6 +471,25 @@ static void memory_write_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 6, size - 6);
 }
 
+static void read_supported_vs_features_cmd(const void *data, uint8_t size)
+{
+	uint8_t page = get_u8(data);
+	print_field("Page: 0x%2.2x", page);
+}
+
+static void read_supported_vs_features_rsp(const void *data, uint8_t size)
+{
+	uint8_t status = get_u8(data);
+	uint8_t page = get_u8(data + 1);
+	uint8_t max_pages = get_u8(data + 2);
+
+	print_status(status);
+	print_field("Page: 0x%2.2x", page);
+	print_field("Max Pages: 0x%2.2x", max_pages);
+	print_field("Supported Features:");
+	packet_hexdump(data + 3, size - 3);
+}
+
 static const struct vendor_ocf vendor_ocf_table[] = {
 	{ 0x001, "Reset",
 			reset_cmd, 8, true,
@@ -533,6 +552,10 @@ static const struct vendor_ocf vendor_ocf_table[] = {
 	{ 0x08e, "Memory Write",
 			memory_write_cmd, 6, false,
 			status_rsp, 1, true },
+	{ 0x0a6, "Read Supported VS Features",
+			read_supported_vs_features_cmd, 1, true,
+			read_supported_vs_features_rsp, 19, true },
+
 	{ }
 };
 
-- 
2.25.1

