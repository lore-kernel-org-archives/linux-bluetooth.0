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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CB3C43460
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Apr 2021 00:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A852760C3E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Apr 2021 00:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbhDQAfO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 20:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDQAfO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 20:35:14 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4247C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 17:34:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id b17so20277181pgh.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 17:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CL44cokoyC1Sgtp5av5HWus4ZW9GRthCw7mZdUsBRZ8=;
        b=WnQXFh3qxoDWoXS6GBvkZaWkMbdgQR98p7/KfNTS3C80pE0FMj3PmjrlQNfaFfos73
         HrpiK46mA3arSfA/TK2qAPKNvr7v2v81C4MWVPllgK/krEGuelQNT0697E1Vj0p37r3t
         xPrXQsZFP5M4EGj6Gx3USU1e+DwStyBM2Fy2aopFVITQXuPtaX9Ws0DoQsYsHPXNfy1N
         iyhndMz/DsqVkzeU48u1nq7NapeZNR91wD0fKBZEA7blpyoBZSWdmOoBuVKqompcVpq4
         7Qn9Q4ob+VMHWTIjxEsk9eYdkFKbbpTt2v4P/WyDBB88w9q8ubYloM6sxnMjPCWlQkr0
         NoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CL44cokoyC1Sgtp5av5HWus4ZW9GRthCw7mZdUsBRZ8=;
        b=Xyl7q/OParioEtuDU9Qive4kfyMbAughS96d7NSkji76mY+BrStxdhEfngV9J8SiiW
         D6+7BGi7N1HeUp9wrnsO/a6CD5QCz+OdQaNZmywAGGag5EDGWqqlkr35stvB8OfzLFQ5
         GO4YqBbflz5On1vMezUZAfLELTY8gXXBYTGYFw+czU2KTZOrRiyoh5wyQgc0K7UonUtj
         fT1W8GyLEdcIg8IT+6h6tIJoM9L4psF7IENYfsngKxe+1j9nL+HI8oLP94fCSO9T6tvl
         umvMaJ5PA6+zfK/zDRMHkdm8t6+FLPWPd+iAWpTBDB3PnTYEEP07JWp3X/4psU81JjkL
         /twQ==
X-Gm-Message-State: AOAM5315qs1HkKG4oC8IbN3uHTDayX0L4sGkHgSuklfEv0yVEkg08sGo
        NxeEPst9ow8+B8ZeECB8vok2cLiVTD4=
X-Google-Smtp-Source: ABdhPJx1E2Ym82nmU0f4AOJZjxTbIUQZqY/q1rXdV8WItCApSboChKARIhFtds/Tk2Vi+vudDSzAcA==
X-Received: by 2002:a63:4848:: with SMTP id x8mr1360639pgk.362.1618619688325;
        Fri, 16 Apr 2021 17:34:48 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:b5db:7c28:fa3b:13c2])
        by smtp.gmail.com with ESMTPSA id gw19sm6714215pjb.4.2021.04.16.17.34.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 17:34:47 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2] monitor: Add Intel read supported VS features command
Date:   Fri, 16 Apr 2021 17:34:46 -0700
Message-Id: <20210417003446.628078-1-hj.tedd.an@gmail.com>
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
 monitor/intel.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/monitor/intel.c b/monitor/intel.c
index 18840f3e7..38ce23b99 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -471,6 +471,26 @@ static void memory_write_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 6, size - 6);
 }
 
+static void read_supported_vs_features_cmd(const void *data, uint8_t size)
+{
+	uint8_t page = get_u8(data);
+
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
@@ -533,6 +553,10 @@ static const struct vendor_ocf vendor_ocf_table[] = {
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

