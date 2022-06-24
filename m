Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99856C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jun 2022 08:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiFXIZy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jun 2022 04:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXIZw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jun 2022 04:25:52 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B767668F
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 01:25:51 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 59so3615438qvb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 01:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TVNe5mvGwxoMiAI3zD/zrxle7aFiZ4zMW7xpowqfrJE=;
        b=KHOPkeGs9ngHWMGWAg2q/sbX4/hGAOBw1G0VEwdGlQ2sKi745B04NZyBw8d1aHU+WB
         e4Yh6y6obob2VCJ4XNIVMHmIwk2DKF9eehT1DngVBLUPgqssbOQLLsh5IRGO1LSwngHd
         75YD1TpqlR0B6m+ugcse4tf4cjHyg3LoKmnPJ+92tuTZ9QayHoxyOrWtrwk9BIOgKqm8
         7rQgB/FuSon8zCehyZW7pbcUubgg31rvcAePIN1mUutXZ3eKuP5xiO6wSNz9ymayBVT0
         aNEd/8GlUWw7B6Sm5uGta0/j+fmuawnWZiJ6RZKHXog7xzL/bAALlm6TGjKu7SFQzbnD
         x3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TVNe5mvGwxoMiAI3zD/zrxle7aFiZ4zMW7xpowqfrJE=;
        b=IYadPRSBB+DCF7YRrlzsdjfPeFBwCYWqpeJVtMNfCaj3LzadZJ8N7QlpYvkdliuMIL
         5p6DNuXrzHTJBmud3w7CfPVjuGCl1ZWP54puPZfQm8ysoy+liTH+OBOUN/EEcnk+s6Na
         edMxivEzHCCuV0j8kccjKuQVFO3E75OGFg6Z/7hCfEa0eB16acd7osNtvYXtd+MQktfk
         U0r9iU/lAS/miIn5WlPe2OE0FQHP7GObgX98DKZHrqN4G31IeEAVwIUXtUdz2iYdKcLh
         5/O8bdx7w7sAkHkrJDqbZyhvk8eH8d3FuUPYWpV7XRWvAF2IqFcPZS4hvcr0OkLgcUHy
         j9zA==
X-Gm-Message-State: AJIora9Ad5Awg3MMscB40A7O+V0Z7iXhRhjIIenUKIuQtyR09+/3bUDI
        Q3W+4iCcetVyWD0Z4rJ/lEX88AWKVApfEg==
X-Google-Smtp-Source: AGRyM1toCusyKBVHERpgV4oVj2xEgJFx7lptAD8+iQV463oCa20mjJQAzyedYUDfHVGQWkGJzS5nFA==
X-Received: by 2002:ac8:4e53:0:b0:305:2d86:8bce with SMTP id e19-20020ac84e53000000b003052d868bcemr11789311qtw.639.1656059150409;
        Fri, 24 Jun 2022 01:25:50 -0700 (PDT)
Received: from ix.. ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a404a00b006a6d4261f40sm1437897qko.111.2022.06.24.01.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:25:49 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] monitor: Fix crash when using RTT backend
Date:   Fri, 24 Jun 2022 10:25:41 +0200
Message-Id: <20220624082541.51687-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fix regression introduced by "monitor: Fix memory leaks".
J-Link shared library is in use if jlink_init() returns 0 and thus
handle shall not be closed.
---
 monitor/jlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/jlink.c b/monitor/jlink.c
index f1d8ce660..f9d4037f4 100644
--- a/monitor/jlink.c
+++ b/monitor/jlink.c
@@ -112,7 +112,7 @@ int jlink_init(void)
 		return -EIO;
 	}
 
-	dlclose(so);
+	/* don't dlclose(so) here cause symbols from it are in use now */
 	return 0;
 }
 
-- 
2.36.1

