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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7FEC433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 18:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CF8611EE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 18:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbhDSSWX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 14:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbhDSSWW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 14:22:22 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7B4C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 11:21:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 10so14875144pfl.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pwg0riq616DSpPdREvNMlmUt29I6wX8BCA1HEwPKrXo=;
        b=L6Fsfdk4J+Mb73TJgM8dlnnSa22kug1I2U/uVKBkiNXd+1b8Xvvo4hn25d9Bi/Kse4
         Rbhx4KqCREr8YsFDDD5uvzgsVUATvH/v7Vsnl7sPuuvx1hcsCy3BELK9WASCqIjaZntV
         kmXvQpHLqnPrILAxZIXIJde6lMyt+4W5yS3XIexoQk7K7E/LAeZuVzP5+qE6ka5ClnCe
         oa08zttHHq8xvklcne6LHmQnpG5QTLLo8hh4wuEI3HeeYUCio0E2IH0wIFLui6R58dvD
         0YT6TDaiiWo+2t5Q6yIXO6wW7zGJ7OAzZY4VXIlBI6Rg14HrAzawbtt263hT7bKQGO8Y
         RtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pwg0riq616DSpPdREvNMlmUt29I6wX8BCA1HEwPKrXo=;
        b=KHbMtC9bDQxB8HnZsnutNR6arXt9+cF8izL5eUdrRvhgZnzws2d9Ft11RH7A+0fQRy
         bL2XgScHxBA65xm0lOLZoWq7xmEgDBisbXxH8CUxPvMX/06rTgeh1S0sNcondiOOiuKY
         qsC0d7aEl4WzlX4dYSKkjDJJDGjlS6b0WneuBUoRj4q6lM6r5q9Qlts0SV4yM/ypEmRx
         9LdB86U2vmdbstVjH9gDxg8hjcNhI+zYk0x7gL2cFI5kUre0/reWfB8/dDHAgE1C4frK
         59hvz+5A+nfVWhxQI3LmoIXqskEqQOh5roUJj/VwlTRQgpjCxri1C7mRLyEx6D+J9tVc
         uXtg==
X-Gm-Message-State: AOAM531uXGtb0SJodxbZs9y5j+kHAqEnNW3VNwIH8GAe8zYM7y6KKG8m
        LW3xt3sLwyLog7GZ1In9Rh4lpkmLq/w=
X-Google-Smtp-Source: ABdhPJxMDTsLuJ/diqWz51l2BkFRWlZTE2t7wp2SRQy82K0vaW/iT6BfzjOGvrs3vBHSG84eXv7t+Q==
X-Received: by 2002:a63:c14c:: with SMTP id p12mr13059273pgi.417.1618856511423;
        Mon, 19 Apr 2021 11:21:51 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:aaa8:65ca:c57a:d36b])
        by smtp.gmail.com with ESMTPSA id f18sm12180952pfk.144.2021.04.19.11.21.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 11:21:51 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ v3] monitor: Add Intel read supported features command
Date:   Mon, 19 Apr 2021 11:21:49 -0700
Message-Id: <20210419182149.712000-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

< HCI Command: Intel Read Supported Features (0x3f|0x00a6) plen 1
        Page: 0x01
> HCI Event: Command Complete (0x0e) plen 22
      Intel Read Supported Features (0x3f|0x00a6) ncmd 1
        Status: Success (0x00)
        Page: 0x01
        Max Pages: 0x02
        Supported Features:
        1f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
---
 monitor/intel.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/monitor/intel.c b/monitor/intel.c
index 18840f3e7..d2aefa6a8 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -471,6 +471,26 @@ static void memory_write_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 6, size - 6);
 }
 
+static void read_supported_features_cmd(const void *data, uint8_t size)
+{
+	uint8_t page = get_u8(data);
+
+	print_field("Page: 0x%2.2x", page);
+}
+
+static void read_supported_features_rsp(const void *data, uint8_t size)
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
+	{ 0x0a6, "Read Supported Features",
+			read_supported_features_cmd, 1, true,
+			read_supported_features_rsp, 19, true },
+
 	{ }
 };
 
-- 
2.25.1

