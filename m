Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C11C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11DAE2076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="reDgmPuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHZURe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgHZURc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 16:17:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03030C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:17:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y9so4321574ybp.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PiO+YY0khA5TeZgvkhFxD4wUEHIs5J/uidiQhfjjKHI=;
        b=reDgmPuMQ+/NY3WaTesgR4ekhIsCpfMhaqBC7u9shCaG39NcHh/PJ+v30oAAXnrLqf
         EY1oWYTVFzrg1aCIJrUkonr6yVUm2yyV0QSFa+Pl5u9jOKS/17rTwttlmBIyo+bvP+4Z
         HZctOS1VSPohKpnptG1bHTYLo8BUEeJNJR9MAMvEQ9PZyHdq5QD5N9jzVbQjJ+vii5CE
         BQiaK38wuRVLdBv1KvjZqO40Ck5agfM6v2teYJphFE2l/fYIzN2H/s7hpfxxBfb5eq4B
         iiV8g612yRV2iHDb6PzNq4Bc0YiwZWe5YM/sGFxYULxgUPxxPEub3scDZ8GFJi2b4II/
         7diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PiO+YY0khA5TeZgvkhFxD4wUEHIs5J/uidiQhfjjKHI=;
        b=iL/swBjzT2Fn2Z1+T/h37hw6ldPChQORu+YnmC8vf00MIZFZcxEKzXNo2viuhZexiu
         iXC2wu8ayAsLvl4q9CydF6D+kg09LXWMSCvuokOdy49EDodLaEMVntQFnkCm0MVPEfNg
         2ONgDCqRLi+jhhx57WmugvxIHnGf3ZYFnBe/kHCUqM6YWN75YrppqVLbTbgPv4rVnvPA
         8oG6y1m7vHeXaKUSommMpEMK5U9e6TvjYmkHreM7pPj+B7OKgjYSysbr3eAafjrEkhYJ
         25rOXa4ow3MSAY/nkND5L5na0iF0Me9HDVqxEgEcYQVze9/tG84WtNX5s8ZplOrR3kNG
         XSug==
X-Gm-Message-State: AOAM532B7bzHnzu5aKQMGz+LOp5+U7E+dfl5W4mLU2OIJKmwIVGwrMJP
        7vunmzp2syRPiSbuTIvEe1TBA0XHxdiL2Hf/qDrojuWJDm2CKLlVJaIeyPAn7DgCrjm4lz4afE4
        h1R1BxI5VQfhERBf97aFxGFWI9+Tw5Jgj/bI0/XOOS55INzBXasborsrg7sH7JgvyqlpNCEmTEI
        ZDvZUs63mwfwkNmsNa
X-Google-Smtp-Source: ABdhPJxQn2zN2psowCQc40L2uP+d8b3nXR2+p9YtTcRG/X94z2yQ8+jWr1B2tm/znx1G6e8dg1sb3gWI2VkKCLyoQjr6
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:c088:: with SMTP id
 c130mr4441613ybf.356.1598473051199; Wed, 26 Aug 2020 13:17:31 -0700 (PDT)
Date:   Wed, 26 Aug 2020 13:17:14 -0700
In-Reply-To: <20200826201715.1911816-1-danielwinkler@google.com>
Message-Id: <20200826131610.Bluez.v1.3.Ieb6522963e3f54b0d63dd88ed3ce24a8942ed73e@changeid>
Mime-Version: 1.0
References: <20200826201715.1911816-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [Bluez PATCH v1 3/3] advertising: Add adv SupportedFeatures to doc
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 doc/advertising-api.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index b0565eab2..0c07f349e 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -209,3 +209,21 @@ Properties	byte ActiveInstances
 			Possible values: "1M"
 					 "2M"
 					 "Coded"
+
+		array{string} SupportedFeatures [readonly, optional]
+
+			List of supported platform features. If no features
+			are available on the platform, the SupportedFeatures
+			endpoint will not be populated.
+
+			Possible values: "CanSetTxPower"
+
+						Indicates whether platform can
+						specify tx power on each
+						advertising instance.
+
+					 "HardwareOffload"
+
+						Indicates whether multiple
+						advertising will be offloaded
+						to the controller.
-- 
2.28.0.297.g1956fa8f8d-goog

