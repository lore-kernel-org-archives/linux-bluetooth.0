Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982ACC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 May 2022 16:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbiEIQhJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 May 2022 12:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbiEIQhI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 May 2022 12:37:08 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D1728D4C8
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 09:33:13 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AD1CF3F164
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652113990;
        bh=G0fQK34FSbU838pd4orLwIr99mE4R02XgVm1RsaYD5M=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Bn2xnB7ZToKx27Yna7Z8AiUg8m55h6HWS78Y2CppOzroHX/R91Mnkc1CwFfjjueCH
         dptoPgL6oqJcvmipIYHsyKCO40Y22YG1ffUpaEOSnHcVW0nA72CYvexp2sMKlPwp13
         cn0SxdCoEMp/hH+EVjrxMLEDKEuFM0gdrH+9M7zl6Trt1ABzI9gjyGGVSI8kj+OCBw
         d1oq2e0OmEIfx8RMaO0Sp+EsGBguf7+rWnhqe58CZeSkmWKCPVHZq203BTq3oa16Nw
         o3iQmQbj5ruGpZ6/Figed/j/9MeBcnONXh2eJ8/IoervdHYTaEGAPlMLDpXURytD5o
         1zkr0BVNw/lwA==
Received: by mail-wr1-f72.google.com with SMTP id ba21-20020a0560001c1500b0020ca6a45dfcso4131102wrb.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 May 2022 09:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0fQK34FSbU838pd4orLwIr99mE4R02XgVm1RsaYD5M=;
        b=TO8m1tkVM1L3c3QCe/GXArcG1DyZ3XrpXt53ouIPAu54IOxEKKmh9GRGmpBwQVIyM4
         /HSsvuo77djXsUknJatm5idoQQtgOZz5rjwEkh/xRwnHeTtqxtpxJwNTMG2z1uSVJMZW
         LXKSSv2K9Z/F4UeAZZAuQVs+F6M72CVRZuY28HSIwnNuf+souOoOBqAsYZ8BZtC2KKVn
         lJ2X9i7chwBC/unMIVbd+hIFv2yO5u9ZgV3lz1wLmwt37RuOAfltDhczCtXz9mXLE6wh
         eeEigGudnK7KbbunBPctbJ4a6H/m49+EJksUeV4qvJ9/yfinxtEe2CUmYJtTHaCJZemW
         0RxQ==
X-Gm-Message-State: AOAM531ziISB6hK4R7tiTaMCZAZulbn0FDj0G9ROhJjpI3rcHl7GQmIf
        mm57/yZqxNjxhxpv2LkGKS+0U6bJXQETKK9N170DUwNk4pA4U3UuB0OL3M82fH6YQ1WHrGRwRly
        5cAzAhCRAGLyQ8IS+wz9Zbn7VkRArT3S03sxePvkvD9hAIQ==
X-Received: by 2002:a5d:4090:0:b0:20c:8b91:3b17 with SMTP id o16-20020a5d4090000000b0020c8b913b17mr14421289wrp.348.1652113990233;
        Mon, 09 May 2022 09:33:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxYfsuILOQFrqnaxz7RV4eyZtu3B70E+bGIbCOUWW6WYzKsmOs5GHdqY3YkpYeDWJEN6W0JQ==
X-Received: by 2002:a5d:4090:0:b0:20c:8b91:3b17 with SMTP id o16-20020a5d4090000000b0020c8b913b17mr14421261wrp.348.1652113989903;
        Mon, 09 May 2022 09:33:09 -0700 (PDT)
Received: from localhost ([2a01:4b00:85fd:d700:4359:3fb2:1bdd:60fe])
        by smtp.gmail.com with ESMTPSA id m65-20020a1ca344000000b003943558a976sm13210503wme.29.2022.05.09.09.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 09:33:09 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: Correctly declare all module firmware files.
Date:   Mon,  9 May 2022 17:32:59 +0100
Message-Id: <20220509163259.1513242-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Correctly declare wildcard of module firmwares to include, as the
driver & linux-firmware ship many sfi/ddc files for many different
devices which are dynamically calculated and loaded by the driver.

This especially affects environments that only install firmware files
declared and referenced by the kernel module. In such environments,
only the declared firmware files were copied resulting in most Intel
Bluetooth devices not working. I.e. host-only dracut-install initrds,
or Ubuntu Core kernel snaps.

BugLink: https://bugs.launchpad.net/bugs/1970819
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 drivers/bluetooth/btintel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 06514ed66022..9f5fc1ab154d 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2654,7 +2654,5 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
-MODULE_FIRMWARE("intel/ibt-11-5.sfi");
-MODULE_FIRMWARE("intel/ibt-11-5.ddc");
-MODULE_FIRMWARE("intel/ibt-12-16.sfi");
-MODULE_FIRMWARE("intel/ibt-12-16.ddc");
+MODULE_FIRMWARE("intel/ibt-*.sfi");
+MODULE_FIRMWARE("intel/ibt-*.ddc");
-- 
2.32.0

