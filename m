Return-Path: <SRS0=NtgA=26=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1859C32771
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 10:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B182067D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 10:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uoqz0OpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbgAIKnF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:43:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50758 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbgAIKnC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 05:43:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so2355072wmb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jan 2020 02:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SkP26v/29sY5BZoOYQZTZZMRC2NCKhLFiuqXUfgUjgM=;
        b=uoqz0OpGuZlIKpuC1qD25vMQ8f8AwUGhljW7ahY/QhxT8Xe2V3SblVo39+T7MCrfOQ
         p+7+4dCMK3j8YQ4uNpPRGj5JCrFgrzCOK0AC0WYWXm78egPzuldiXFUvffzk4Ph/YrL+
         rb23xRV9xN2hMWIkKiWTswiYewjWish8ZU2ztY+rZl1xtNUz033UCWG7SsNFwihNqK9Z
         nJhSskX+XSv8KkL8U5MeKNzXJSxVU2HhFnTZdFCb14ffLGfnHxoIztFtu58Tdu9YKVtN
         cG3YFf6/zeJe2CkeAcezY8lz1+2heGetqWb9mfUgE9N2xsnOmN9bi6uHSNCCSpGeVFtn
         vtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SkP26v/29sY5BZoOYQZTZZMRC2NCKhLFiuqXUfgUjgM=;
        b=OiS76euLiQJcsl9dAY30B0y3gJdhevu2pGwJYiukrYQJt5P7QWqnTWHQbTyQpjichy
         HEnUHMlsup8m9OqqD+MnSY4tIS5VyM/2g/RI2qt2dyixfFxVIZnAXQxM0Nk6/8yNUeA5
         SarX93IUCDHh0xVrUFpGBrRXFSBynko7MBCxR+p1Jrnzy3CVTuKT+SKJJhfjZbO7o7Jh
         M0qkpuX0BHfrJgkwaNh94b1SwtJvpxKbRB7r2s44veMQUi2vDfrNLZASTEAKKPrA1wGJ
         VV8jBLVYkHc4v5lKxYhWeXrwXmK7Svvwg1JCjL/cRWVcxLl/s2XJeFZ6fcokjGcE1TpL
         bioA==
X-Gm-Message-State: APjAAAWzebiRqeJ90d+fvrOKV28jsKYlIhFMADW0CpZb5I4bWnG7JeGZ
        +jOZ5lsId/7Ne8KY5W9hAT0aVw==
X-Google-Smtp-Source: APXvYqyfTgBCgG8JNZwv9gyCo6cleXy4olSHdPrj/npJ2qIXbxd0e54RdUeD4kfVeYeqABDs4it7ww==
X-Received: by 2002:a1c:81ce:: with SMTP id c197mr4091282wmd.96.1578566580609;
        Thu, 09 Jan 2020 02:43:00 -0800 (PST)
Received: from glaroque-ThinkPad-T480.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q68sm2587167wme.14.2020.01.09.02.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:43:00 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc:     johan@kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: [PATCH v6 1/2] dt-bindings: net: bluetooth: add interrupts properties
Date:   Thu,  9 Jan 2020 11:42:56 +0100
Message-Id: <20200109104257.6942-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109104257.6942-1-glaroque@baylibre.com>
References: <20200109104257.6942-1-glaroque@baylibre.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

add interrupts and interrupt-names as optional properties
to support host-wakeup by interrupt properties instead of
host-wakeup-gpios.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index c44a30dbe43d..d33bbc998687 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -37,7 +37,9 @@ Optional properties:
     - pcm-frame-type: short, long
     - pcm-sync-mode: slave, master
     - pcm-clock-mode: slave, master
-
+ - interrupts: must be one, used to wakeup the host processor if
+   gpiod_to_irq function not supported
+ - interrupt-names: must be "host-wakeup"
 
 Example:
 
-- 
2.17.1

