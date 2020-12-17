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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE041C2BB48
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 07:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905D72360D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 07:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgLQHTF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Dec 2020 02:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgLQHTF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Dec 2020 02:19:05 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959D7C061248
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Dec 2020 23:18:18 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id q22so18448599pfk.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Dec 2020 23:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ROFwraclmZafOx9+Edkeznx8P384VynmuQCntAzvR8=;
        b=MyC9Vmv2wxTErdNuK46uB+6W+ZeVo7CEvAm4CwVHoHH6x/Qe6krRpXc5BwLHrwfy5s
         dqz3p5R0K8lWPFghYVZh8kljchH/xI8owsl/XOAqXzGWZZt8QqTi6lOnUujDFNWHp/MG
         dexyi7hbmLntzWFV7khcS9933ojZMNj1UgUxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ROFwraclmZafOx9+Edkeznx8P384VynmuQCntAzvR8=;
        b=F7pzkgpbF0JEZQD7qc7khkkM9eNhhOQsM3M2RVAsSquBJTxob02xRnphUCa7DcSMYx
         sB/wOLBnrcf1N0C2LZd+lvIyQcFa6EhRKR41iz2uj9OJ99Lg4qHgNuHq5LUHNSoZhE8i
         vL+qrQU+JGsv4j9OqwOwIZ+mCKLczMoMTQBukAoJXSG8FbyNM2lGayQ+wzUoTTkA3sDB
         3K+5w+0LRMX4luBRRfIOcvVEPABUxFqV6M1y2Y+dQxau3WnOnvQtwGRZNzAYPn7WLEZ1
         dEiW1blmn8qNYoKB4dkm1e70upRwA81r74MyiSM+YhBDe8sZxTjnL0Xh/Rps9YDy8gUx
         TPZw==
X-Gm-Message-State: AOAM53272k04u210cuDwmRInRV6PqMx4lUYI1W+/ETX/xOxu+wcigR0a
        UNVxcMdjpGBW14hqSPB8jPK1vQrePgfARA==
X-Google-Smtp-Source: ABdhPJyTjk/xJ2oFRvRDO7TmL23v4R2kPT5mfGpPjmsduIU3UXGQFAsrW08FGb/A5mFBqOJB4ekjQA==
X-Received: by 2002:a63:f702:: with SMTP id x2mr35802021pgh.414.1608189497840;
        Wed, 16 Dec 2020 23:18:17 -0800 (PST)
Received: from localhost ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id a31sm4956916pgb.93.2020.12.16.23.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 23:18:17 -0800 (PST)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] Bluetooth: btusb: Enable MSFT extension for Intel controllers
Date:   Wed, 16 Dec 2020 23:17:31 -0800
Message-Id: <20201216231652.v1.3.I84d6a963dbe3a014e8456943785b076344f659bf@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201216231652.v1.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
References: <20201216231652.v1.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
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

