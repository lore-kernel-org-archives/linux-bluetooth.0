Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RCVD_HELO_IP_MISMATCH,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F7DC12002
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Jul 2021 23:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E45613DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Jul 2021 23:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbhGPXYo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Jul 2021 19:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbhGPXYo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Jul 2021 19:24:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90534C06175F;
        Fri, 16 Jul 2021 16:21:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so7814901wmf.5;
        Fri, 16 Jul 2021 16:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=oqAPTwxVBKR2F6EgNjINn0S7aHeY9ZMndbbMupvJ/sc=;
        b=qpKlSowNM05vWwBKSB/rijZI7XGqvVsDEwxdYBrP7tTAubmwh7EeTLRG5XX6b6WCp7
         ZDUBVOZAPvHeaAzPfui5EIiOeGmm34/INzfIZT01oKQ2MkYJY+kclr8r9hLICWkqdAPR
         0MPiW88LlXjqVZ7wWpobGXJ/OwtpBD0VYlQ+lY4+Dcdu+JQxsiGwYeM+K1sv5irDqNmW
         q9tc7f5k971o8axHeOLmFmKwGZT/pBT9NfTL3GhYmyeojxUDvGb2dFMtw/qTncu0nAyV
         sqFqnfIV4fZSRF0rLolxDeeF2WWpvN4gabNTSgzcyTTBDP5Z4Eh9C+FfG1hogv1AXhqA
         qOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=oqAPTwxVBKR2F6EgNjINn0S7aHeY9ZMndbbMupvJ/sc=;
        b=Os6Vjx4A2b6xqE36IKp6Nw0d0C00AepSWjmlyfW5FiCpYX59Z+b3A6R8WvYXUD63QH
         Af3z9eEjTcmpKoo9qsU9lefLQ9R5MURmNMwe1fQfLB9c+8M7HqzCKdk1czTCzxh46On3
         rBTPzyKQ2QMq4vQEiMc172l+suxI11ad18G8EUGeQNcaS+qds8WmIDBgFE4J0m061vQN
         p9yGY7T9tW2bXtAXVzfBSohes7DvYm1Hn3WvTx6uj8Pmd6AmYtB7LdefegO02w2AMl9Q
         8SAp6yP4xCXakWZIgFEuLXmCYezvrtx29iPp4EMby8UZrs88BChcU2lJyljbls+C/uGT
         isAQ==
X-Gm-Message-State: AOAM531t2wwGWGdknafRdIjBnK36ltwYYFS0rUIU352g2enhBCKuqt4x
        CxyGn9p916H8SFekQ+OojLc=
X-Google-Smtp-Source: ABdhPJxqSPkrn04AKrYNjNdcQ9lEq8Q5lmIvO0fMNd+et+TYPRtTHZb8wubX19BnQIfGLc3VY4zGBQ==
X-Received: by 2002:a7b:c0c9:: with SMTP id s9mr13370751wmh.188.1626477706176;
        Fri, 16 Jul 2021 16:21:46 -0700 (PDT)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id j23sm6070815wmo.26.2021.07.16.16.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 16:21:45 -0700 (PDT)
From:   Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Make the CSR clone chip force-suspend
 workaround more generic
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Message-ID: <906e95ce-b0e5-239e-f544-f34d8424c8da@gmail.com>
Date:   Sat, 17 Jul 2021 01:21:43 +0200
User-Agent: nano 6.4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Turns out Hans de Goede completed the work I started last year trying to
improve Chinese-clone detection of CSR controller chips. Quirk after quirk
these Bluetooth dongles are more usable now.

Even after a few BlueZ regressions; these clones are so fickle that some
days they stop working altogether. Except on Windows, they work fine.


But this force-suspend initialization quirk seems to mostly do the trick,
after a lot of testing Bluetooth now seems to work *all* the time.

The only problem is that the solution ended up being masked under a very
stringent check; when there are probably hundreds of fake dongle
models out there that benefit from a good reset. Make it so.


Fixes: 81cac64ba258a ("Bluetooth: Deal with USB devices that are faking CSR vendor")
Fixes: cde1a8a992875 ("Bluetooth: btusb: Fix and detect most of the Chinese Bluetooth controllers")
Fixes: d74e0ae7e0303 ("Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134")
Fixes: 0671c0662383e ("Bluetooth: btusb: Add workaround for remote-wakeup issues with Barrot 8041a02 fake CSR controllers")

Cc: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>
Tested-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
---

I've changed the warning line to make it easy to grep and detect if this updated
workaround is part of the driver. Should make it much more obvious to users in
case their dongle doesn't work for other reasons. There's a clear then-now.

Easy to narrow other future issues down. Let me know what you think.

 drivers/bluetooth/btusb.c | 61 +++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a9855a2dd..197cafe75 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1890,7 +1890,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		is_fake = true;
 
 	if (is_fake) {
-		bt_dev_warn(hdev, "CSR: Unbranded CSR clone detected; adding workarounds...");
+		bt_dev_warn(hdev, "CSR: Unbranded CSR clone detected; adding workarounds and force-suspending once...");
 
 		/* Generally these clones have big discrepancies between
 		 * advertised features and what's actually supported.
@@ -1907,41 +1907,46 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		clear_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 
 		/*
-		 * Special workaround for clones with a Barrot 8041a02 chip,
-		 * these clones are really messed-up:
-		 * 1. Their bulk rx endpoint will never report any data unless
-		 * the device was suspended at least once (yes really).
+		 * Special workaround for these BT 4.0 chip clones, and potentially more:
+		 *
+		 * - 0x0134: a Barrot 8041a02                 (HCI rev: 0x1012 sub: 0x0810)
+		 * - 0x7558: IC markings FR3191AHAL 749H15143 (HCI rev/sub-version: 0x0709)
+		 *
+		 * These controllers are really messed-up.
+		 *
+		 * 1. Their bulk RX endpoint will never report any data unless
+		 * the device was suspended at least once (yes, really).
 		 * 2. They will not wakeup when autosuspended and receiving data
-		 * on their bulk rx endpoint from e.g. a keyboard or mouse
+		 * on their bulk RX endpoint from e.g. a keyboard or mouse
 		 * (IOW remote-wakeup support is broken for the bulk endpoint).
 		 *
 		 * To fix 1. enable runtime-suspend, force-suspend the
-		 * hci and then wake-it up by disabling runtime-suspend.
+		 * HCI and then wake-it up by disabling runtime-suspend.
 		 *
-		 * To fix 2. clear the hci's can_wake flag, this way the hci
+		 * To fix 2. clear the HCI's can_wake flag, this way the HCI
 		 * will still be autosuspended when it is not open.
+		 *
+		 * --
+		 *
+		 * Because these are widespread problems we prefer generic solutions; so
+		 * apply this initialization quirk to every controller that gets here,
+		 * it should be harmless. The alternative is to not work at all.
 		 */
-		if (bcdDevice == 0x8891 &&
-		    le16_to_cpu(rp->lmp_subver) == 0x1012 &&
-		    le16_to_cpu(rp->hci_rev) == 0x0810 &&
-		    le16_to_cpu(rp->hci_ver) == BLUETOOTH_VER_4_0) {
-			bt_dev_warn(hdev, "CSR: detected a fake CSR dongle using a Barrot 8041a02 chip, this chip is very buggy and may have issues");
-
-			pm_runtime_allow(&data->udev->dev);
+		pm_runtime_allow(&data->udev->dev);
 
-			ret = pm_runtime_suspend(&data->udev->dev);
-			if (ret >= 0)
-				msleep(200);
-			else
-				bt_dev_err(hdev, "Failed to suspend the device for Barrot 8041a02 receive-issue workaround");
-
-			pm_runtime_forbid(&data->udev->dev);
-
-			device_set_wakeup_capable(&data->udev->dev, false);
-			/* Re-enable autosuspend if this was requested */
-			if (enable_autosuspend)
-				usb_enable_autosuspend(data->udev);
-		}
+		ret = pm_runtime_suspend(&data->udev->dev);
+		if (ret >= 0)
+			msleep(200);
+		else
+			bt_dev_err(hdev, "CSR: Failed to suspend the device for our Barrot 8041a02 receive-issue workaround");
+
+		pm_runtime_forbid(&data->udev->dev);
+
+		device_set_wakeup_capable(&data->udev->dev, false);
+
+		/* Re-enable autosuspend if this was requested */
+		if (enable_autosuspend)
+			usb_enable_autosuspend(data->udev);
 	}
 
 	kfree_skb(skb);
-- 
2.32.0
