Return-Path: <SRS0=JVds=Q5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F63C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 00:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E93D206B6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 00:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="maLsgR67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfBVAa4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:30:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36898 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfBVAa4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Feb 2019 19:30:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so242612pfh.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Feb 2019 16:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yaipkiEto6//B2LCDASYez8pzOCmttYr63wlq8gTkQU=;
        b=maLsgR67ikjNc2kG8WnI8HNrhyQDIQvEhBLb35V0PYl5r/pNv1e28VgM4bqgPhjwtH
         K5g5IHc7RU82W7NO3+EmdvRe2SjpHEuwLu4tZl+UypLjx9O9GU/Tx1LTMAndcMCSGYHK
         70vLVOfKxvEr4HQs8vRvyYEzGwjBRQHDokVSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yaipkiEto6//B2LCDASYez8pzOCmttYr63wlq8gTkQU=;
        b=KIU3QpjaVh9bfrUWLe+9ndbV3kHEdMHmNV1GQhaJPb7WlxAPielMoW6gUp+W32Nlyj
         ITX3V125CZQLY92Ix8cA/aEH5DsOlT03X9QKArZSJGY3hRggh8aPq4QqBwGGH9UvBYTg
         GPA2ZIQTzIQmdqHRGhBWIXbG5aCb3DanLED2RPV+J8M7iAe0Xla+nr7iGwnUVD1QWQvF
         9Gw89SnabK9oj8FfRwMcWF5nzR0fVFBsIyAU65rEK6IXek5+JcjpjQOLk3UH8ZVMV8BL
         hegzYtLqXEGB+jCyv4IzLUmf0iEcfVmOU1q+Bd4rleFykkcKviOp/CyvtQ+ePKv589cC
         mEaA==
X-Gm-Message-State: AHQUAuaPND/osogkFu/zX7APtNG8j77b1l9rZyZkpRTVF/gyl6jTGlro
        6YrqOk6uEx7y+izoGE612gEMYA==
X-Google-Smtp-Source: AHgI3IbKXeA+X4k8N3vzESXPqAJbPdlIPcsUsPoNYEVykZhyzus7ytZGbA1+vD3LZPtfoxneL7Oi3A==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr1242421pgg.16.1550795455497;
        Thu, 21 Feb 2019 16:30:55 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id v15sm265674pfa.75.2019.02.21.16.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 16:30:54 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] Bluetooth: btusb: request wake pin with NOAUTOEN
Date:   Thu, 21 Feb 2019 16:30:51 -0800
Message-Id: <20190222003051.127006-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Badly-designed systems might have (for example) active-high wake pins
that default to high (e.g., because of external pull ups) until they
have an active firmware which starts driving it low. This can cause an
interrupt storm in the time between request_irq() and disable_irq().

We don't support shared interrupts here, so let's just pre-configure the
interrupt to avoid auto-enabling it.

Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4761499db9ee..470ee68555d9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2885,6 +2885,7 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 		return 0;
 	}
 
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&hdev->dev, irq, btusb_oob_wake_handler,
 			       0, "OOB Wake-on-BT", data);
 	if (ret) {
@@ -2899,7 +2900,6 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 	}
 
 	data->oob_wake_irq = irq;
-	disable_irq(irq);
 	bt_dev_info(hdev, "OOB Wake-on-BT configured at IRQ %u", irq);
 	return 0;
 }
-- 
2.21.0.rc0.258.g878e2cd30e-goog

