Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66891C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 09:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 249362067C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 09:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGZ/T6L9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgHZJyn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgHZJym (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 05:54:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B2BC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 02:54:42 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id i10so794933pgk.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 02:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFJyxn0sYlOZ7uMd8lMntiT/9xQLuQk8yZ+XjHsuGEI=;
        b=DGZ/T6L9zlP50gGxSUQguqktO/Pi8kGcUE8UCT3vylg465RFHflFsrNtC324K61672
         /bX/XL3i6MU81QDNKea8cYq3GI5PR0wITcatvGcENK8Uq8XA+pxLaW7KWbok6pMVHPmZ
         12kqWoDbHbsUOWcG7VjBZd/R34qpmR2h1preJO9iJhdlve5IkA9fklFPPe0zrHSYejKb
         1X/0ix+YAjzLDxEMIgaC7uhhF/hEdeNj3AnTkci6GxoCcRrHAHJJQxykyVyjEEdg07Bl
         4MLqTWRkwxkoe131oQoWpYKDdYfR1w2R+pq/iUjOrQeZptN4IMUSUSLkXQq36Uj3Ldef
         dEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFJyxn0sYlOZ7uMd8lMntiT/9xQLuQk8yZ+XjHsuGEI=;
        b=kQAXMTu8OyJoPAIeADeLg0PGiWA+BUifCZpN7MtIe5jxzvF5HzoHXHCquhId8EIjnW
         2jNWH5e8pWyT4PlbK9Y7Y7WvqkeLzbe+tky+3MDpDKjO5dNAVVGzU1CRdaAOgvooWHqL
         rM6h3FWMUgJ7u5WO6vwBzrwkNdTMq+2IeMH0HOUlKinj251nW4ysZD0qrGOLmiDI7Cuw
         8O97aaCFwquHJSE+xQSoXrWsvHvltzSnLNo9NmMMmSmSO6HMBZx/lvNQmpp1fr/6xMfx
         Cxy9GRZSYWInTo8/RTHeMo2OPetVr/luIpgsKHICEgK36EXdMEgR58txFYQ+s5AjsagC
         BvVw==
X-Gm-Message-State: AOAM531W1C4H8MU5eSZWfq7bsXv8cOgoa9l87uY3lMpgBr5R8R4mVwsQ
        2jy/ayfTuBrEo2VXSEkKv4xBKALdmlzLwCSa
X-Google-Smtp-Source: ABdhPJyBmG5k3Y9KZ0ZCu9sR5v2zFqJ1V+FJYJu9ssiRemeAMsFGIh6jJYcMFawgJ6rZP/u6fTYxIQ==
X-Received: by 2002:a63:6346:: with SMTP id x67mr10035840pgb.121.1598435681601;
        Wed, 26 Aug 2020 02:54:41 -0700 (PDT)
Received: from localhost.localdomain ([122.171.201.76])
        by smtp.gmail.com with ESMTPSA id a10sm2376687pfk.26.2020.08.26.02.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:54:41 -0700 (PDT)
From:   Kiran K <kiraank@gmail.com>
X-Google-Original-From: Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, Kiran K <kiran.k@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>
Subject: [PATCH] Bluetooth: btusb: Update boot parameter specific to SKU
Date:   Wed, 26 Aug 2020 15:24:32 +0530
Message-Id: <20200826095432.18825-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

boot parameter gets updated during firmware download process. Use the
updated boot parameter while doing soft reset of controller. This patch
fixes updating of boot parameter.

Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btusb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8d2608ddfd08..414575eccbad 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2338,10 +2338,10 @@ static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
 
 static int btusb_intel_download_firmware(struct hci_dev *hdev,
 					 struct intel_version *ver,
-					 struct intel_boot_params *params)
+					 struct intel_boot_params *params,
+					 u32 *boot_param)
 {
 	const struct firmware *fw;
-	u32 boot_param;
 	char fwname[64];
 	int err;
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2479,7 +2479,7 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
 	/* Start firmware downloading and get boot parameter */
-	err = btintel_download_firmware(hdev, fw, &boot_param);
+	err = btintel_download_firmware(hdev, fw, boot_param);
 	if (err < 0) {
 		/* When FW download fails, send Intel Reset to retry
 		 * FW download.
@@ -2561,7 +2561,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		return err;
 	}
 
-	err = btusb_intel_download_firmware(hdev, &ver, &params);
+	err = btusb_intel_download_firmware(hdev, &ver, &params, &boot_param);
 	if (err)
 		return err;
 
-- 
2.25.1

