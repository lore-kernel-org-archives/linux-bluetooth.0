Return-Path: <SRS0=JtDF=AF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8654AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 18:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CAA8207E8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 18:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fTiXdWrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405469AbgFXSYj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405892AbgFXSYh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Jun 2020 14:24:37 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57938C061573
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2020 11:24:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f3so1804734pgr.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2020 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9lLOK81twl/FSwqjR5V402nJJvfN+JrXUUdr5SEYJXY=;
        b=fTiXdWrLnppoFCxoKkJuIDXUFodq6DG+1Y2Jjz7CMkEzbk8K+tYADM34DoiMq4Ffg5
         kLowrWac63p2CapGAfAMrdAaGh87PMr0E6gApO+gx1d1fNhGo7UgKpnKU9tIWGqOkce0
         9m5Iu8uuC8glYdO4JNUQL+yJFknhSL8TObdfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9lLOK81twl/FSwqjR5V402nJJvfN+JrXUUdr5SEYJXY=;
        b=Zywras578un3wiQAp/u6IjchxkjyibMpd+Q4G4pfM3pflBcy15cik2dnk2MnNRuVZS
         NSkZq76b0hm7DAVH/cPYN5csryyuotCJ5wX4rTrZL5MRR8jH1MV+ITIe4CyigBu+GP1k
         lAjqE2XNDAnHEhZAbM8SMose0aSy4MFwXCdH6lKL7MSZOcdCAQJAjSdha8rnYcOpub7g
         FovhY+lBUt3Nhozeyg/gM9uqa1+i80Pobmm/kSn6eSW5Bmo+t3PT/iNBL14XL9jI3+aI
         5au8vTU9Iof2WkTuDarCF8fJOfXVGTMEVTLZf4kkF4OaBOo5vWScpgdWU5XAIR5aKvhP
         2Fog==
X-Gm-Message-State: AOAM530JJUpiAoNv5ltDiKLCAr9I6pXma4slgA5CeELMX8m3xQ2S74+n
        mwH4V4fme/5pehTo7R/w7jNYTA==
X-Google-Smtp-Source: ABdhPJz4+rcX+rL/L5DgXKGJqcpQlcupEbsXhdvyJc+ljmHfgrLOIJdIZ3KvQwlbsStIhH+HLY2SOg==
X-Received: by 2002:a62:78d0:: with SMTP id t199mr29026301pfc.77.1593023075852;
        Wed, 24 Jun 2020 11:24:35 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id v1sm9396772pfn.210.2020.06.24.11.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 11:24:35 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: BTUSB_WAKEUP_DISABLE prevents wake
Date:   Wed, 24 Jun 2020 11:24:30 -0700
Message-Id: <20200624112428.1.Ib42ab202cfd82e7734571c302071da30a24ea27b@changeid>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When the BTUSB_WAKEUP_DISABLE flag is set, always return true for
prevent wake. This tells the suspend notifier not to prepare the
controller for reconnections during suspend.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
Realtek chipsets currently lose their firmware when suspending (except
in autosuspend where they assert remote_wakeup on the usb interface).
There's no need to configure the Bluetooth stack for wake-up in this
case so use the BTUSB_WAKEUP_DISABLE flag to also prevent wakeup from
being configured.

This was tested on Chromebooks with Realtek chipsets running both 4.14
and 5.4 kernel. It was tested with suspend functional tests and
a suspend stress test for 50 iterations.

 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e42fdd625eb023..7627d79696b5aa 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3727,6 +3727,9 @@ static bool btusb_prevent_wake(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 
+	if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags))
+		return true;
+
 	return !device_may_wakeup(&data->udev->dev);
 }
 
-- 
2.27.0.111.gc72c7da667-goog

