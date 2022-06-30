Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC2FCCA47B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 22:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiF3WO7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiF3WO6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 18:14:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE4A57225
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 15:14:57 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id k9so703448pfg.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 15:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HoF52ca7cPA+2cjagMcPVDx0b0Io030FHaScC+jOWFE=;
        b=erZAYmdQLaGogK8fUofc7zbd3/1bQKti0AUKJ50R9+fR/wd0+j3kNXF5GGFUbuORwA
         HcUUOX6jZRrk/YpjHGM2zULY2xjJMEDUJEJkpKayaxpRKYWRUElJMUYmz1M/nABMlrQH
         +X98OSEGC3QvsOezF39R0SnkWz/P31LFEViO0gMxbixa3SBL6dqR/SYizH6dleK9bdtS
         o9oWWlFXi+qzCzmp959Pzwbaic178p43o++li6zBmwGza2wB5ZMlWVaW+Q16tKx7CJvL
         tGq606hlGjY1wMCBz0ZL5SsRHhNPUmvh/ALsyZwq07vhpFHF71CibAYMhPneavQtJ7g4
         cYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HoF52ca7cPA+2cjagMcPVDx0b0Io030FHaScC+jOWFE=;
        b=NpKcJhJMkRlZwz7pjT/nwH3okeh5b/e48sNguS7W6+W6FMK/W/i4KAN20KNdMyG3SP
         NGP1ORaf6EIIS7g2h15liTHyxn+UhZy4XQscYbgf2iGe790WvE2GWsVlggFzVVomkEo4
         v/m1Nw51s9WMndb15g5a+JW3dhhqOYPPJFNU3iBUAAsb4aQFBkVwZYp+e9d+GkQ8W/d/
         GY2YaSUFMpx6Ar3l0JMDBfQ0DcA1LC3PrkqKD9ZGV0uH/AYQeXMlmZ37orU8ZKCGKg32
         p43tDjvetUkEHe5gunYexp982U36HnZpJRcTpSd3OXNTtWQWl0qDvlQyPi/GEbftBor7
         IURg==
X-Gm-Message-State: AJIora/iaCxfiv0VpWwMqcrZYR/vuT0Z7HUxmhbclDuVvMOhifNwwk57
        l4VSh6AzxEYHIdhX3LMFqNm7vrDtqRwhLw==
X-Google-Smtp-Source: AGRyM1ukTemi5gdi+EX9Xvc+PQy8EjkSdsdYQUTWaS2UAu9kNu/zzQfPBaKubzehkZx4cOCQ5IWFOg==
X-Received: by 2002:a63:3142:0:b0:40d:3fd3:53b5 with SMTP id x63-20020a633142000000b0040d3fd353b5mr9551698pgx.416.1656627296940;
        Thu, 30 Jun 2022 15:14:56 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id me3-20020a17090b17c300b001ec84b0f199sm3460333pjb.1.2022.06.30.15.14.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:14:56 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v8 3/8] mgmt-tester: Fix Read Exp Feature tests
Date:   Thu, 30 Jun 2022 15:14:47 -0700
Message-Id: <20220630221452.638591-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220630221452.638591-1-luiz.dentz@gmail.com>
References: <20220630221452.638591-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds ISO Socket UUID as response to Read Exp Feature.
---
 tools/mgmt-tester.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 6018327f1..02ddfd844 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9858,7 +9858,7 @@ static const struct generic_data set_dev_flags_fail_3 = {
 };
 
 static const uint8_t read_exp_feat_param_success[] = {
-	0x03, 0x00,				/* Feature Count */
+	0x04, 0x00,				/* Feature Count */
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,	/* UUID - Simultaneous */
 	0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,	/* Central Peripheral */
 	0xb5, 0x10, 0x1b, 0x67,
@@ -9870,7 +9870,11 @@ static const uint8_t read_exp_feat_param_success[] = {
 	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f,	/* UUID - Codec Offload */
 	0x1a, 0x88, 0xb9, 0x4f, 0x7f, 0xee,
 	0xce, 0x5a, 0x69, 0xa6,
-	0x00, 0x00, 0x00, 0x00			/* Flags */
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6,	/* UUID - ISO Socket */
+	0x85, 0x98, 0x6a, 0x49, 0xe0, 0x05,
+	0x88, 0xf1, 0xba, 0x6f,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
 };
 
 static const struct generic_data read_exp_feat_success = {
@@ -9882,11 +9886,15 @@ static const struct generic_data read_exp_feat_success = {
 
 
 static const uint8_t read_exp_feat_param_success_index_none[] = {
-	0x01, 0x00,				/* Feature Count */
+	0x02, 0x00,				/* Feature Count */
 	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c,	/* UUID - Debug */
 	0x01, 0xab, 0x9f, 0x46, 0xec, 0xb9,
 	0x30, 0x25, 0x99, 0xd4,
 	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6,	/* UUID - ISO Socket */
+	0x85, 0x98, 0x6a, 0x49, 0xe0, 0x05,
+	0x88, 0xf1, 0xba, 0x6f,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
 };
 
 static const struct generic_data read_exp_feat_success_index_none = {
-- 
2.35.3

