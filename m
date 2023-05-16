Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBDBC7EE2D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 May 2023 20:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjEPU7j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 May 2023 16:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjEPU7h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 May 2023 16:59:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8E076AF
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae3a5dfa42so1123245ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684270774; x=1686862774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Iobs+R2ddrlT8b4QQ65ACB2Nf3ufHdusbKHpv7a0ow=;
        b=DWheeTkSuUxSG/GGfHIxPYEd2E8nVWOgB8ctozMuVSSARLNHEnXK4nCOPRygluQYMJ
         rDPjrQmU2PhcebJ6YpVymQKwUr5lrE+hRs9z/xYSoc9qEzyLvUy3GgVmWEVNAX6nfw3s
         9wbFOuymnkuV7TW//hp7VpEYSzpWH7ikGAdnTH8zaehRHUzkSlZUqGptZn4cLfO1tZiE
         Z1DB6bVZvsGxTl0mYyBc3uWYUZsaITX7ZxHGxisaYX3HdynbGlDA098gAPGM3iq+KFDp
         ml+deiW7X3zSKPgHjklRwPKIYOfRW7o9A8KbmPoycf+Ta9TLsQbFLJDnXVHAhmvXeaPq
         JSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270774; x=1686862774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Iobs+R2ddrlT8b4QQ65ACB2Nf3ufHdusbKHpv7a0ow=;
        b=h7T7oPYVqM7Cp9mvoUsGQ947GMF8XVkFHvkAvSspP7PVxtDWw48N8T3L6xDrV7RGQo
         BznYi+O4tszZLuGQ2T0KZ2LmPdhVAI1oJqsZPKSJvCiFIW8zyJAQDnyMywrIhw7l6Mqr
         FGaLdUiyK/7fmidddSU4txugi/orvVCH9ycAdRnQyyWC4AMsRQATuD6jeZ6aPAyEBo7f
         jRhb0qqhhQFq1Vn0sRPWCH0goREojoLd5Qu315onbS3JuwiUX5OrPeRtaboUSnsLB00r
         5WqnDMPs0asPa3WUfrOjZzSRAfyWFx4Jbi93v0tanZjUPYLMNZ1yfEgl35+LxnNQR479
         wYOg==
X-Gm-Message-State: AC+VfDz404abon7sW9e2RS6WMp2+En4LP6Y+yHTk3SnNSEbWiBrhWWXh
        m3x0XMCGlseKpjfiSU4Z4S6ywyQUwh4=
X-Google-Smtp-Source: ACHHUZ4AXS5X3qKwcgey0kwefptQxShAWKK9m5lVptZeu7IvvaYIB5ZNySHb7CamOGrR6dY6DqqPIQ==
X-Received: by 2002:a17:903:1110:b0:1a9:bc13:7e20 with SMTP id n16-20020a170903111000b001a9bc137e20mr46746440plh.44.1684270774561;
        Tue, 16 May 2023 13:59:34 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709028c9000b001acad024c8asm14272237plo.40.2023.05.16.13.59.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:59:33 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/10] mcp: Mark driver as experimental
Date:   Tue, 16 May 2023 13:59:19 -0700
Message-Id: <20230516205924.1040506-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516205924.1040506-1-luiz.dentz@gmail.com>
References: <20230516205924.1040506-1-luiz.dentz@gmail.com>
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

