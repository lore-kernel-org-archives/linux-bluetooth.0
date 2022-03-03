Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928D8C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Mar 2022 22:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiCCWR6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiCCWR6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Mar 2022 17:17:58 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70751B0D3A
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Mar 2022 14:17:12 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso9042666pjk.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Mar 2022 14:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=N2urqP76zwookiB2jBmOML63kwD8rQXsaS6vMAOGWjU=;
        b=DTqUNOzZobYYNGeXRe0EP6KiJIlj5IRz2W8pIEwiHoKTSS893wzwOBXsaotlM1oHFg
         2VbqIPpmA69BEt7VAk8YEoKAbBWo3j1wobr4mOwzqy3dUcQO0g30bBxrdxXYJCdax99e
         c8h6bROVQeVSNw5dMSMLVQCyi6RPua9RSNv2upp0CNBCLnD7eCPzDpbdTt++17tBFq+w
         nIGsnop3cyrMd0HZ7x5rpXF+reecWomYRIgBtuspWaAwLOUJjNHyokYxBiMgeQwL7ftO
         Frq4PNGBmfuAXsf3sNQFNTXJfY4nD/dYnc9iTCFwkFSn9CnDi7hiYuHYuzsdCfeV63rl
         EJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N2urqP76zwookiB2jBmOML63kwD8rQXsaS6vMAOGWjU=;
        b=DwNUUmOoHsw/JDeeXMh+1LVmC/pErpHh/HLlU5Uxeq5dA1ATW2jrPhlS3chIKHGf/u
         EGZwuSdO2wKNKcq3Pzzn7IQuPimuh735VWGnMY9ksu+GJplCDd/nxUkGISjbkhL2zY3o
         RtDjGC805qg7bThpYGnxRfoZDbC+CK4axScndC1ZsH9Zmk9r9Ay7fEToc6BeFn4NLGtI
         jHonj8EsXiJD/Jv3OB2OSHiHUrlbEiHoAxpv3NauaMHz2UusJt9CVmuaQ2p2ThW7qdro
         8Y8vYJ1rlvd4MVRQjhDkKz4Z0PCvrTKP0PHru+akNUCRTc3BoA432w/vQ++zWE3ByzGK
         n37w==
X-Gm-Message-State: AOAM5309bnmiL1KBLuOM56brird0rpx3yxWTiaAKwlJBHZetb8tU/fP6
        xpbdouJTpSqesf7tGVe1wiZtibcmSGw=
X-Google-Smtp-Source: ABdhPJyzjZZFdIoIvpfb9kYP8hbr86/mtbmQdqg+qydrzI5V5WilHirrSmHHxNv63a3X1XayPjB1kQ==
X-Received: by 2002:a17:90a:c782:b0:1bc:dac0:88e with SMTP id gn2-20020a17090ac78200b001bcdac0088emr7617919pjb.172.1646345831606;
        Thu, 03 Mar 2022 14:17:11 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p28-20020a056a000a1c00b004f6519e61b7sm3856932pfh.21.2022.03.03.14.17.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:17:11 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: btusb: Add BTUSB_BROKEN_ENHANCED_SETUP_SCO flag
Date:   Thu,  3 Mar 2022 14:17:09 -0800
Message-Id: <20220303221709.387865-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303221709.387865-1-luiz.dentz@gmail.com>
References: <20220303221709.387865-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BTUSB_BROKEN_ENHANCED_SETUP_SCO flag which can be used to set
HCI_QUIRK_BROKEN_ENHANCED_SETUP_SCO disabling the use of
HCI_OP_ENHANCED_SETUP_SYNC_CONN command.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 34d008380fdb..d09a6a712632 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -63,6 +63,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	BIT(24)
 #define BTUSB_INTEL_BROKEN_INITIAL_NCMD BIT(25)
 #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
+#define BTUSB_BROKEN_ENHANCED_SETUP_SCO	BIT(27)
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -3848,6 +3849,9 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 	}
 
+	if (id->driver_info & BTUSB_BROKEN_ENHANCED_SETUP_SCO)
+		set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SCO, &hdev->quirks);
+
 	if (id->driver_info & BTUSB_CSR) {
 		struct usb_device *udev = data->udev;
 		u16 bcdDevice = le16_to_cpu(udev->descriptor.bcdDevice);
-- 
2.35.1

