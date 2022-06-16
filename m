Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B08CCA47C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jun 2022 19:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378467AbiFPT6M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jun 2022 15:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbiFPT6L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jun 2022 15:58:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E827CD5
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 12:58:10 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id d129so2156540pgc.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DzmLhs2KN8/2XxlIjby9SAzcf+GgCxBXb2K7PJixntg=;
        b=HSeKh4KUeHzjz/+pClcOUADYFfJzMYz1lD/TfMHStj67ePeGQakI0sHGaAz6jK9+UB
         aBeh3fETvJCQ2dc4Lru6kExteW0jCDkQ4Yr9fWZsGZVN+gQZLQJvuxGSB+tr/sjejAFn
         BB9cASphSAyAZcv4brxjkdAT+AikOEqdUxPxILj+yNA57xxXkawLPdbSuqRmv00WSqWF
         7FiAmy7+Lx/pi8OAD6vH4k9yncMsxbhHyAMrYq71hDQ+qQyxiZdzoAef8E5nf9jm6/4U
         wX4bd0YeZBR6UpiOySEWxE7FvmAmn+tiXKcAKZReaPIgtuWaSSfFrw1/Dm9m2zLf6Csk
         YSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzmLhs2KN8/2XxlIjby9SAzcf+GgCxBXb2K7PJixntg=;
        b=7zJ3ZkUoXtwEmG6o+oUDJHMsshCKxnH1bGcOytH/ysIMJxoyzgeBhq2gwuWI2aDuZZ
         +rSXC9M5GmYECVtd0EvWKIu3u+GD8ljgb+UXUIvuwOrOz5MiQMJuGL0vntxFEQckCEvf
         9HaO/oYqVKPdpv9cLSGboOAQ3abN1Y+n3Yrv1a8xvKMPLJfnLHLMU3dOM2gzKvKzs7AT
         4XWPfZnXK0UWNEGZirGDNiAiQhsF/9qY6+fukeCK2Q5/IMEzdkFQ14ncpxf+/WRjhHS6
         L8YT5Ejv104SF4JTNbk/shd0D0xpT0KIUdDiY4JbJVXNEanZ8hVEX4wluY3TSG8ryl4b
         Pw6A==
X-Gm-Message-State: AJIora/IgME4R2CnnHisnxy1WcNpBXDo+NhlDvbJ+3OjavuTMBoajmRk
        d/Rp0E+F8DE4PVqNY2dYJHIZbg86mA4=
X-Google-Smtp-Source: AGRyM1vweFgxyhj+jq8///7kpZrRyORZpS4u2huwBh713ZBqeiYl+oOLTkaJWrsVP8Tz1mDia8vIjw==
X-Received: by 2002:a62:1744:0:b0:51b:ab76:e8c4 with SMTP id 65-20020a621744000000b0051bab76e8c4mr6239208pfx.42.1655409489922;
        Thu, 16 Jun 2022 12:58:09 -0700 (PDT)
Received: from han1-ubuntu-dev.. ([192.102.209.8])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b0016a034ae481sm89285plk.176.2022.06.16.12.58.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 12:58:09 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 2/3] monitor: Update flag information for Extended Advertismement
Date:   Thu, 16 Jun 2022 12:58:02 -0700
Message-Id: <20220616195803.99346-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616195803.99346-1-hj.tedd.an@gmail.com>
References: <20220616195803.99346-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the missing flag details for Advertisement flags

@ MGMT Event: Command Complete (0x0001) plen 11
      Read Advertising Features (0x003d) plen 8
        Status: Success (0x00)
        Flags: 0x0001ffff
	...
          Unknown advertising flag (0x00010c00)
	...
---
 monitor/packet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index bd9efd2c7..3d081c544 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12667,10 +12667,13 @@ static const struct bitfield_data mgmt_adv_flags_table[] = {
 	{  7, "Advertise in 1M on Secondary channel"	},
 	{  8, "Advertise in 2M on Secondary channel"	},
 	{  9, "Advertise in CODED on Secondary channel"	},
+	{  10, "Support setting Tx Power"		},
+	{  11, "Support HW offload"			},
 	{  12, "Use provided duration parameter"	},
 	{  13, "Use provided timeout parameter"		},
 	{  14, "Use provided interval parameters"	},
 	{  15, "Use provided tx power parameter"	},
+	{  16, "Contain Scan Response Data"		},
 	{ }
 };
 #define MGMT_ADV_PARAM_DURATION		(1 << 12)
-- 
2.34.1

