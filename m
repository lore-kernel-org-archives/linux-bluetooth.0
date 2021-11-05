Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6383C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF4B611C1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhKEVPb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbhKEVPb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 17:15:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5D8C061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Nov 2021 14:12:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w9-20020a17090a1b8900b001a6b3b7ec17so4118468pjc.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Nov 2021 14:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KPFsCeKStHLUmfZlK4Puuq02SsEfAOOKUWK1jQCadbY=;
        b=PmYR5POEFpatu61DslOiOqLU0Xbish4JkYTfrEAf6mBZdO9fnW2RMxMUsCgW6jlVLj
         kz1BW/JjxQqNUnrkXS6zchzc1qfCXtPa68AxCKffXI9ljLEPMEBAwwx+5ebcofuB/U73
         lxnxjCxh+qk9DnKtND21xaAzmrpKvZKJeaSy94pd2d3Oiu6LP5WBBAY2mFJcYZB853Oi
         Rmvb4dYAREi+wrUg3ulMKP6HChKFiahHVNkMsGJikTN5XoTUcWeXwXW5e0YvPP9hJcra
         DG0P8GANv4YvOGK0lq5P2k2eEKbu/iJs/Sf0Xe0oz9aumqC1iKfSS9Vq8a8BR7X5BniX
         7H+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPFsCeKStHLUmfZlK4Puuq02SsEfAOOKUWK1jQCadbY=;
        b=0qZ3O6pNT+RCsSSiTaDuT1BDxfPKFB5Qd1sYpJVYMXgUHCUSAOvmYZPFwfozEE23ta
         2H79OEuXDyepRWH7HlgdWWF2MpNuA1qNxpWJEL8OAgAr01nRtigyXX8BYYyH2ru53N8P
         ppxXtgueuTbc5w15uj4BLYafGgaU+zP1GDqR8eu8qcj7GLH2Cz07O9ArLBsU86yWuiGX
         nHnsFmfU3PWZPkbuoLu0eWOWitik4RDmJv8zKO6lzx+N4UFVIAayD7z/dAr8ny81v1bc
         +HAnXZrZfwu6NljF9a41zkv6OXHckyKR3SMxrsQd2Y/aiy90k4dpNcFJLb0bHD7NQBrr
         RHzQ==
X-Gm-Message-State: AOAM532X9bMVtPWulebCcU39CgS2KrrmcqIn/le3fooFn3NZM1i30t8z
        bzs6eUEiEDt5NPzQ9mAHGD9Qi3rjg6M=
X-Google-Smtp-Source: ABdhPJyiX3cCrkwBU3YBv5FH9+K6WR8CwI6NwTxVtABOC8D5iOyKLZTSMt/pPbXJL0OGv71M00Uaxg==
X-Received: by 2002:a17:90b:4f4c:: with SMTP id pj12mr32786005pjb.218.1636146770498;
        Fri, 05 Nov 2021 14:12:50 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id om8sm2250553pjb.12.2021.11.05.14.12.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 14:12:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] monitor: Add support for Device Privacy Mode flag
Date:   Fri,  5 Nov 2021 14:12:44 -0700
Message-Id: <20211105211245.424024-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211105211245.424024-1-luiz.dentz@gmail.com>
References: <20211105211245.424024-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds proper decoding for Device Privacy Mode flag:

@ MGMT Command: Set Device... (0x0050) plen 11  {0x0001}
        LE Address: BC:9A:78:56:34:12 (OUI BC-9A-78)
        Current Flags: 0x00000002
          Device Privacy Mode
@ MGMT Event: Device Flags... (0x002a) plen 15  {0x0002}
        LE Address: BC:9A:78:56:34:12 (OUI BC-9A-78)
        Supported Flags: 0x00000003
          Remote Wakeup
          Device Privacy Mode
        Current Flags: 0x00000002
          Device Privacy Mode
---
 monitor/packet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 9030f2493..71f711dc5 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13378,7 +13378,8 @@ static void mgmt_set_exp_feature_rsp(const void *data, uint16_t size)
 }
 
 static const struct bitfield_data mgmt_added_device_flags_table[] = {
-	{ 0, "Remote Wakeup"	},
+	{ 0, "Remote Wakeup"		},
+	{ 1, "Device Privacy Mode"	},
 	{ }
 };
 
-- 
2.31.1

