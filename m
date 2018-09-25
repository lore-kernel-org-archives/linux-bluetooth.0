Return-Path: <SRS0=tqgc=MH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04576C43382
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Sep 2018 19:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A942A20867
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Sep 2018 19:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aWIHpjva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A942A20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeIZBTj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:19:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44990 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeIZBT1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Sep 2018 21:19:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so11862795pff.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Sep 2018 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R6+1q7wcqXruOMuQ5i8D8phZzRIqjo3PhmPKpv0q26k=;
        b=aWIHpjvaLB8GmKCtqWWsG2rWvD2y1WqrrIq1OdP/65GNreOU+D46LAtVyunz5Qf6BH
         NmFr9xnqLOjyuYXZqG9/FmwtZNlzY8B6FtNyV6jDxRgUCbFX4wPJXxJzgVK5SOQ8Gy7u
         jP+1YjPUff1AsZptPeN6AJEQiCjTcZFUZDwGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R6+1q7wcqXruOMuQ5i8D8phZzRIqjo3PhmPKpv0q26k=;
        b=XU9YfXG1bUxpcl9wcL8VEsuwiII8CBHpLF13iq69kOX6fYScUqv0HBrI/LgG9eiFXc
         QWXyjjtOOZyibzof8BGEebPX5yJToYgOZtaacKe4pCixAKEZYgepBYuFv5xzlOWwUSoC
         C9DrI9w2MacSHRzd6eVbS4AkTtxher0K6GAV6SFtTcOGKS84+XVV7QToWYLzJAefHDWB
         Vg7bWXc4bP6HR2zwOy0X+p0NgHw3fdOmmLUwKnbhSLHCJSWwsj965jXQzQ8D5Y+wSE0R
         XZTXgOKEsQYCTZDQ9Xa0JD9a6IokuqyeoEgfleCoyO4uo5/xJscVhCBpO3xDE0MNtMDz
         c3cA==
X-Gm-Message-State: ABuFfojP4ZfyH5p9gpf/3QXLUZ6VrMcxTGtOgc9K7++VElIZgg3Bzo7n
        gdtaCNhrZitd5EAOgyhYTBO3WQ==
X-Google-Smtp-Source: ACcGV61xpWecUDtCTLlYv1v63LnhyNhWWG4911tnzT65aufU16mTZPXGUBrslMsMTADevO6k1zl6Ag==
X-Received: by 2002:a17:902:694a:: with SMTP id k10-v6mr2464437plt.166.1537902628276;
        Tue, 25 Sep 2018 12:10:28 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id p4-v6sm5082718pgs.75.2018.09.25.12.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 12:10:27 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3.1 2/2] Bluetooth: btqcomsmd: Get the BD address with device_get_bd_address()
Date:   Tue, 25 Sep 2018 12:10:14 -0700
Message-Id: <20180925191014.85573-3-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20180925191014.85573-1-mka@chromium.org>
References: <20180925191014.85573-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use the new API to get the BD address instead of reading it directly
from the device tree.

Also remove an unncessary pair of braces in the same area of code.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes in v3:
- added 'Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>' tag

Changes in v2:
- pass bdaddr_t instead of byte pointer + len
---
 drivers/bluetooth/btqcomsmd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 7df3eed1ef5e..ff74d2c46991 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -172,11 +172,9 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	/* The local-bd-address property is usually injected by the
 	 * bootloader which has access to the allocated BD address.
 	 */
-	if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
-				       (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
+	if (!device_get_bd_address(&pdev->dev, &btq->bdaddr))
 		dev_info(&pdev->dev, "BD address %pMR retrieved from device-tree",
 			 &btq->bdaddr);
-	}
 
 	hdev = hci_alloc_dev();
 	if (!hdev)
-- 
2.19.0.605.g01d371f741-goog

