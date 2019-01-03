Return-Path: <SRS0=oHG9=PL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537F6C43612
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jan 2019 12:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF5F21479
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jan 2019 12:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJh6U+ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfACMcd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:32:33 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36488 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbfACMcd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jan 2019 07:32:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id a16so23073868lfg.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jan 2019 04:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AAzoTxwJomXXs0xiEBSbHa0Xr7zoMK+4ZG8aDWHp/cE=;
        b=ZJh6U+ezbYNU+btEeKAw9kAf0gIr95uf3r6s6nJ6wh0/ts3/96DXPcaD/6S64kYUaZ
         5WrXHPi64oO6j5PFrkBVxq9vz7vLceL+jUU/skJZu5yToTbVPqkQAczOuHZewanZ1Oj4
         qRTfzMdYqIzDrH56K3kxoKBfzRLXX3NylQ5Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AAzoTxwJomXXs0xiEBSbHa0Xr7zoMK+4ZG8aDWHp/cE=;
        b=aA2BuKw1cnTcThOnEzAMs9ORje98kJnXrwZl5wcpRGxwU+9S37+tIDTol9cJKzfU+k
         z8nmiswOCnP65kIfwFSrKTeIt+vHdXnGUSCmZxe5PjXlzuHy9sG8xQkESiX/i+3GxsNI
         WsksOD+b4hv3ORhMoZqc6sAJMEkvxkvqAoI8qP9r7VsqVdkNY7Tnvz3CQPjGuBCosIJX
         KWCkEcj1lai8kUfD/fQ7xo7njEO/iA9dEkHSH0Hj7ywURFF3HkK1FKsYGOOy4JCQpQNk
         6t99sVaSfMEmKSOB3Cvl1LmvCiBkm/XFOmyBE1scgZZkRSwN128FXA9foIWGvhfFDpXQ
         25LQ==
X-Gm-Message-State: AA+aEWYMCVJMr087vl1WnXpI9HEPPLv/DtH4lIk/jYCqeezXK9zhM9d2
        Lml5t9Y6tE+NSm5flzoZsUhcpA==
X-Google-Smtp-Source: AFSGD/Vu6d0c6obja3qeqC2ts++ojcrTGq93yH/GF2sMKGn3PsZvl8cTGYEKZMcLO5ZQ+AcySgBevQ==
X-Received: by 2002:a19:9e11:: with SMTP id h17mr24621392lfe.73.1546518750889;
        Thu, 03 Jan 2019 04:32:30 -0800 (PST)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id t22sm11157523lfb.0.2019.01.03.04.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 04:32:29 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] Bluetooth: btmrv1: Drop unused GPIO includes
Date:   Thu,  3 Jan 2019 13:32:27 +0100
Message-Id: <20190103123227.30424-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I can't see that these drivers use the old GPIO inlcudes in any
way, drop <linux/gpio.h> and <linux/of_gpio.h>.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/bluetooth/btmrvl_drv.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index f0454541e5fd..fb7729779166 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -24,11 +24,9 @@
 #include <linux/slab.h>
 #include <net/bluetooth/bluetooth.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/gfp.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-- 
2.19.2

