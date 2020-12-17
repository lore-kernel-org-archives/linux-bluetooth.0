Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D96C4361B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 22:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65EE23A51
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 22:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbgLQWy7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Dec 2020 17:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732199AbgLQWy7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Dec 2020 17:54:59 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E30FC061248
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 14:54:16 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id f14so231787pju.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 14:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZ5WSbQtPeUtU/i4otWMR2VgbaOPAzPCIHXFiOM9ruA=;
        b=A4h3Z6nsqjvVlEDu1hHg5MAI22u3KUOUIPnpQOSsrM5dhduiWA2NQCdzkG5RU9pd4p
         tG2KnEnBBJRLCTXyNEa9kQudxBa8ABQImvv+cQfKZB8e1d+x3Her/TfDqAdQ5CwMVwD0
         ED9npRAn0QZZd7pRs9je6E3d1v3BeDX6eV4dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZ5WSbQtPeUtU/i4otWMR2VgbaOPAzPCIHXFiOM9ruA=;
        b=CAD4DasUFGa8jDeZEpyF//RxJCdz5KywODh2yY+Sqv3leI5+AYkRE4XEmL38lcLO5M
         hZfKyiczAW/jZ8ZfNbwAIbDElRn81SV+4XgC5irMdCi7X8zOhbomNINsI1Z6Ciaz2/E7
         P12ImSTULQHJelQzfwnVRdwwW9ojIaLwmDUKBYns+DoknEY8R8dOvVTjjWaHwXQoMQ70
         Zx8cdotDB3jprydG8ftbwK6f2sB+V4s+Vxjx58bMIMRWZj8A/nqHa+my+SqDx6CW20H1
         //dCSFWB8Dv9FjPzz2EToGRTN0P5eBzahw3VnRatGW06OvDpOGD3Z0KfJcsx8FhEkx5M
         Rhtw==
X-Gm-Message-State: AOAM531iDGQ/qad9ooN3R0pMGnqGdRpBOzEcWPpGthpXL+rxXtS500lC
        G2SI91hhcRj8mQzro2kcpddRTBpIa0pm6Q==
X-Google-Smtp-Source: ABdhPJzsZ0rOvLccxWS60JFncVdyDGjlKad9nUpOq5XRfyzyvOUSIchietm1qp1JpAOTfisKkZvUww==
X-Received: by 2002:a17:90a:1182:: with SMTP id e2mr1355532pja.152.1608245655911;
        Thu, 17 Dec 2020 14:54:15 -0800 (PST)
Received: from localhost ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id s7sm5557907pju.37.2020.12.17.14.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 14:54:15 -0800 (PST)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Archie Pusaka <apusaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] Bluetooth: btusb: Enable MSFT extension for Intel controllers
Date:   Thu, 17 Dec 2020 14:53:19 -0800
Message-Id: <20201217145149.v2.3.I84d6a963dbe3a014e8456943785b076344f659bf@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201217145149.v2.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
References: <20201217145149.v2.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Intel JeffersonPeak, HarrisonPeak and CyclonePeak Bluetooth
controllers support the Microsoft vendor extension and they are using
0xFC1E for VsMsftOpCode.

< HCI Command: Vendor (0x3f|0x001e) plen 1
        00
> HCI Event: Command Complete (0x0e) plen 15
      Vendor (0x3f|0x001e) ncmd 1
        Status: Success (0x00)
        00 3f 00 00 00 00 00 00 00 01 50

The following test step was performed.
- Boot the test devices with HarrisonPeak and verify INFO print in
dmesg.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

(no changes since v1)

 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03b83aa912779..25cfa47995a8a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2924,7 +2924,10 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * extension are using 0xFC1E for VsMsftOpCode.
 	 */
 	switch (ver.hw_variant) {
+	case 0x11:	/* JfP */
 	case 0x12:	/* ThP */
+	case 0x13:	/* HrP */
+	case 0x14:	/* CcP */
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
 	}
-- 
2.29.2.684.gfbc64c5ab5-goog

