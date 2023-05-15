Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F298C77B7D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 May 2023 21:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245377AbjEOVF5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 May 2023 17:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245358AbjEOVF4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 May 2023 17:05:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814D049F9
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 14:05:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aad6f2be8eso122955965ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684184754; x=1686776754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Iobs+R2ddrlT8b4QQ65ACB2Nf3ufHdusbKHpv7a0ow=;
        b=X1BT4JLQBGCNnozOSNkyKpbor74MbEjRth7+dCZx3qk3ku1uz5DnrT/1NXwnZSPDZy
         xvMh5BVqWSEHj//iomNIAxkz1zjv+ExH4ncoXkbx6Po79KbTMoZrFkXzENgNM0Xkwdd0
         KjhWvqv+/xZDPOizVgGMWROLaGxDHmchEMSCkHidN4UjRTzDBoLP+TT4hHJUpV2G8jum
         ijtSmBlHDLnzDQQgLfoLKE7964734SRucwBQgFlfCf+VSe5n9+usdJdnp3Xr+iNXFXIq
         WzdInORygpAlQ1WwokBjLeOfSnPA98OiNfpqX63vQPP/4Dt+QtRqLP2J/V267bxzO40z
         gykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684184754; x=1686776754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Iobs+R2ddrlT8b4QQ65ACB2Nf3ufHdusbKHpv7a0ow=;
        b=KQ/MpnlR5UJOwSqOywJsRDWBgVNkzyGDDR259AuJgX1ouyiFfLk0mPDDQ9YcqooMA+
         NHFfS5LeUXK28V2JjwSzfWecNVH6k+vR74kFqOjtzZD0X2ceoldGMb7LfKn1ojbo4kJj
         iTk10ebzhfKU7xwILm6UkA2r49CZELg8+6aCaPyv0X6ry+5i7/xS0ngOvmdNt2i/smxd
         f5AjGy/arCJVc5yxpetNLaWFAvmCbH2IhtsF+7/3atSxGGTgwNlVpPmArBwbGOhj3L4t
         I+oMBlWisb+D+WfnyOXMURmSVd2Wd5b2Cne7fd1mpSX1Vld6Hydi7MCcsSFhU/ZQL1Zb
         +H4w==
X-Gm-Message-State: AC+VfDwVqtynaXsVMMaJ9PJPuNPA8UhVsETaWnqsAjXMV4qAMhpXm23a
        rtTOPqswRPbpq9Fkfvwj8N/5+9lVxlE=
X-Google-Smtp-Source: ACHHUZ4+hkv33q/z3lrEkadAx7MWx/hursgOM49mzQ0jVJbZ3OREHOGbBTHLw3jcmkQ2IdmcBsqwOw==
X-Received: by 2002:a17:903:41ca:b0:1aa:d545:462e with SMTP id u10-20020a17090341ca00b001aad545462emr48373840ple.13.1684184754132;
        Mon, 15 May 2023 14:05:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id jb4-20020a170903258400b001a04ff0e2eesm13990050plb.58.2023.05.15.14.05.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 14:05:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/7] mcp: Mark driver as experimental
Date:   Mon, 15 May 2023 14:05:43 -0700
Message-Id: <20230515210545.718701-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515210545.718701-1-luiz.dentz@gmail.com>
References: <20230515210545.718701-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses the btd_profile.experimental to mark the driver as
experimental.
---
 profiles/audio/mcp.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index f3ea330f9839..b410b3d2aa03 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -403,27 +403,18 @@ static struct btd_profile mcp_profile = {
 
 	.adapter_probe	= media_control_server_probe,
 	.adapter_remove = media_control_server_remove,
+
+	.experimental	= true,
 };
 
 static int mcp_init(void)
 {
-	DBG("");
-
-	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
-		warn("D-Bus experimental not enabled");
-		return -ENOTSUP;
-	}
-
-	btd_profile_register(&mcp_profile);
-	return 0;
+	return btd_profile_register(&mcp_profile);
 }
 
 static void mcp_exit(void)
 {
-	DBG("");
-
-	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)
-		btd_profile_unregister(&mcp_profile);
+	btd_profile_unregister(&mcp_profile);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(mcp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-- 
2.40.1

