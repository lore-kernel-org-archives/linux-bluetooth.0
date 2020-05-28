Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D2DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 17:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 171232073B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 17:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="px9pL7Rq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405558AbgE1RZb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 13:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405540AbgE1RZ3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 13:25:29 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829D2C08C5C7
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 10:25:29 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n18so13918523pfa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 10:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8rzfdUrlc7E6TiIkd8wKl+Q/Lnr2dT152h0Jn7EafjI=;
        b=px9pL7RqOohNMUTQg9f/XPQesRK7f5KacRP3kF2z5urKa6v1nhzGvfVjGblqQhQDh0
         wlEWgkagN/EI5WsiWWh4LjIefEipKMmG5kbVXnYLEro6tYwQj4iJv3NR0CkEGSUWD1hQ
         QhRSh1gAFO6ZeCMN8SBD4Pybj/eqStQQZ6hM8C/9DQ+D52OXX5GiLS08qb0ZJPOWDS//
         4lzNpN2cnyF8vlkt4XRI3VgT4ZbRgRV3oGnk4QPePSIl4QbgJ/wEOMe1h+RhnDTeX8MD
         fnBaiCsQkprWgLUJbts17+zaSNnGbBpKLB4q2fgor73glzKRnp9zNONz5FNVPS2bIlEb
         HCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rzfdUrlc7E6TiIkd8wKl+Q/Lnr2dT152h0Jn7EafjI=;
        b=rg4iCo1qVPu3tYqPdgJy50jznCtw5NQo3bm/0t1/rh8bVSB7QfZA3qGSQ5wqGU7gtr
         XkZ6hUd/zcpbq6d66LCWhZLiw/Rmf0QMqqGBjVBYiPaHeFyCyyFyyoN+6yIxKmzsSjGX
         lqJg7O2uKy7zCikl4H8lXpQkQl32cFQgvHWZpylOn2GV+b8Vkqr4NA+UJYAQ1cHaJE1M
         kV5dKchWYESocP2Mmpcx7LiYwWN6iyOOttCghUazhSQNRtjNRHb5lgcFs8AKK3AhY8BF
         mkJ427X/MJAbvCVidX85B7r12FY1j7kacFPh2PMnTORzQL982/DiizppBURYOaTYroOA
         Lq9w==
X-Gm-Message-State: AOAM531EAeAlQSKWwuKtuGUKFH9Mj/hCNdxKRIQrCHc/8Le5t6+Sz34b
        Ib/1moGzE8yk76lKPR8/6lshNz0o
X-Google-Smtp-Source: ABdhPJwT/m0YmvQ9MJKZjZxfOtPDhV44BmRjy40ioTONvImiBRN/IU67BxHrY0XWHSxfaMC0gx6V6g==
X-Received: by 2002:a65:4107:: with SMTP id w7mr3980997pgp.226.1590686728742;
        Thu, 28 May 2020 10:25:28 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n5sm4481503pfa.168.2020.05.28.10.25.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 10:25:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] avrcp: Don't attempt to load settings if on volume changed is supported
Date:   Thu, 28 May 2020 10:25:25 -0700
Message-Id: <20200528172525.216354-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200528172525.216354-1-luiz.dentz@gmail.com>
References: <20200528172525.216354-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If only volume changed is supported that means the player cannot really
indicate track/metadata changes so don't attempt to read them.
---
 profiles/audio/avrcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 75811bf98..d46ac0ab7 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3814,6 +3814,10 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
 	if (!session->controller || !session->controller->player)
 		return FALSE;
 
+	/* Skip if player status/metadata if only volume changes is supported */
+	if (events == AVRCP_EVENT_VOLUME_CHANGED)
+		return FALSE;
+
 	if ((session->controller->features & AVRCP_FEATURE_PLAYER_SETTINGS) &&
 			!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
 		avrcp_list_player_attributes(session);
-- 
2.25.3

