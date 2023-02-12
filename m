Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7449AC636D3
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Feb 2023 17:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBLRYK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Feb 2023 12:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBLRYJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Feb 2023 12:24:09 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A6D10A9C
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 09:24:08 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id lu11so26737517ejb.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 09:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t7KS/FVyi50yUpdaDCPQzfOsD+Ed5CpJnHGDFzFskc4=;
        b=bKNdWjQqnpaTfd0B1ZYKNPkVfa0INtEYD2PbxJk6HfH6WZLGdyGJDB65b/KTB4L7zq
         9mV01oGSB9nHI+nDCSzIe4sTUFyH2AjSOyfgN33OBoF7eqJMsKgKa5trIHYazyxE+hhx
         0ILHG+U0ntw6d47e/d6RPdRZglVaCiiLeLyEZ6RokNnh55Y06hFo8xR/Wi+ZGlENGLmQ
         U/qZ6HjnXh3drKnKdtMbHLiiFeovtJhIE1swpgrrk1H1+hNutfssvz4eVNHDVGmJXT1/
         9U1J2hmgQ2d54HaIVNnG2QncXOHuc00lexo/Tz24/2YYHT0AOYIPQh0XaNj9ZyFrxlSx
         Rs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7KS/FVyi50yUpdaDCPQzfOsD+Ed5CpJnHGDFzFskc4=;
        b=P1eUpIcGoWgYWqZUBhlZLjrC+DjKUvdM9S7sNZrCh1KUMW27kDzqHo5++q8mIcebgt
         KTsClK53Qqy2s0s3P/qGZ/Ymmnzewi/MQ/alzXB2WYkOnRXlV3Tm+79PiJJhg1v3RNAm
         XItRdn+eIe6nf7Axn5KiLnZyVn2qw9bm/3KIf0pyRR3HnC7JhPRDO/9V1gXjYMk3txYS
         M2QqUpg+IjLMOBhlNWtM1DphpzjjXK+MHELmLHg7T3F3cL5FaKKsEMMWL1X/RtUSZQ8E
         zsQ8W+8623PL4mYOF7aMZfGaohzjssRWG3DPjjAMtK+UFHnhOgnaoOms+0s5+al+5J/U
         LXkw==
X-Gm-Message-State: AO0yUKVa93xP/E3uX/XVWeNJB+sdjNqlU7pAH0XrdJDoe7bLUqXwvPHw
        ObYQ2Ad8PJNt+oAqmtpKQhQvaQpNKeR64A==
X-Google-Smtp-Source: AK7set+KN2BnXVdxQg31MB/hOKG+V4urK5AsEQg57FkTe9oHUyk04QeIBMZbEbdsbwF/Fv+Tfjf0CA==
X-Received: by 2002:a17:906:5a84:b0:87a:6a63:9014 with SMTP id l4-20020a1709065a8400b0087a6a639014mr22161591ejq.20.1676222646818;
        Sun, 12 Feb 2023 09:24:06 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:af1:ef01:c05a:c0b6:c4ab:d610])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906115500b008711cab8875sm5469923eja.216.2023.02.12.09.24.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Feb 2023 09:24:06 -0800 (PST)
From:   David Nicolson <david.nicolson@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dave Nicolson <david.nicolson@gmail.com>
Subject: [PATCH BlueZ] gatttool: Use consistent spacing before brackets
Date:   Sun, 12 Feb 2023 18:24:02 +0100
Message-Id: <20230212172402.19018-1-david.nicolson@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Dave Nicolson <david.nicolson@gmail.com>

---
 attrib/gatttool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 6a0ddfaad..2d03875b0 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -456,17 +456,17 @@ static gboolean parse_uuid(const char *key, const char *value,
 
 static GOptionEntry primary_char_options[] = {
 	{ "start", 's' , 0, G_OPTION_ARG_INT, &opt_start,
-		"Starting handle(optional)", "0x0001" },
+		"Starting handle (optional)", "0x0001" },
 	{ "end", 'e' , 0, G_OPTION_ARG_INT, &opt_end,
-		"Ending handle(optional)", "0xffff" },
+		"Ending handle (optional)", "0xffff" },
 	{ "uuid", 'u', G_OPTION_FLAG_OPTIONAL_ARG, G_OPTION_ARG_CALLBACK,
-		parse_uuid, "UUID16 or UUID128(optional)", "0x1801"},
+		parse_uuid, "UUID16 or UUID128 (optional)", "0x1801"},
 	{ NULL },
 };
 
 static GOptionEntry char_rw_options[] = {
 	{ "handle", 'a' , 0, G_OPTION_ARG_INT, &opt_handle,
-		"Read/Write characteristic by handle(required)", "0x0001" },
+		"Read/Write characteristic by handle (required)", "0x0001" },
 	{ "value", 'n' , 0, G_OPTION_ARG_STRING, &opt_value,
 		"Write characteristic value (required for write operation)",
 		"0x0001" },
-- 
2.38.1

