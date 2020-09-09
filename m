Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEA1C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 02:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E5621D80
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 02:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SxkcIkqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgIJCAc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbgIJByT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Sep 2020 21:54:19 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CD7C061389
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 16:54:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j7so14223plk.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 16:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gTez5zBL4O/mFCX1yAYIY6uoJGixvvecrhH5yeefCRU=;
        b=SxkcIkqSWelb6AuUlXuHUzy1a16hhmWXJWuq8Eo/23y2lOyPcWQDUSskXt1hEJUyn6
         u1wOiYNDBdX/GAOiEZ/EkYArPHBOHNGFUNcC9AVgOMGKko3iXNgtwmArngx7TwMORv1T
         Q14fEfQF9K7z06eGlkuJ30cEupLsJdCrymIDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gTez5zBL4O/mFCX1yAYIY6uoJGixvvecrhH5yeefCRU=;
        b=EdRBASCggXyFS7lNosDGcVA2aKF8VpPkQzRJtxq/S8q7PH+yrZXomR6Zr3Hauzot1o
         rA/QUgwBz8FGO2Tf+eV3FA9tkyT5XS98usC+CgX06s95ENrZfCPM1Vg8kIWJs2ZZtkUt
         ft6SRWJwA3WVbw9m1Ouct53orCNgv/I0TfoTMyd+w2JiCj9lzb8EWh0LQC74YO1YvJwm
         XbzrZhhkVXotxsikOOhzfyQ7uYapAI/4JpDgt33NWI2XYi3qKPooY3e5oVxLaV7JuaNW
         Ve2apMQFWrYIebi7E8yYwrgaLmCqVwEInp0nDAr7Zaz5qJj8iLRKtF7KzpmuPyyw0V9w
         4JXw==
X-Gm-Message-State: AOAM530Q0EN0QLci+fV9gUdpAkfYqaU/9jKjTg0p/OWYWTwF+9qTI4ad
        f1s0oTVbczN/yrhOUiHvUzRMKA==
X-Google-Smtp-Source: ABdhPJypCzWo/RzU1A0vkyKGMWGcM+gWL4C+xJq9bpuP3YaGcMPrw6MsySxwiLzgR4TsTQNBxd3ARg==
X-Received: by 2002:a17:90a:4ec4:: with SMTP id v4mr2793960pjl.62.1599695646992;
        Wed, 09 Sep 2020 16:54:06 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id h14sm3817937pfe.67.2020.09.09.16.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 16:54:06 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] Bluetooth: Re-order clearing suspend tasks
Date:   Wed,  9 Sep 2020 16:53:59 -0700
Message-Id: <20200909165317.1.Ie55bb8dde9847e8005f24402f3f2d66ea09cd7b2@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Unregister_pm_notifier is a blocking call so suspend tasks should be
cleared beforehand. Otherwise, the notifier will wait for completion
before returning (and we encounter a 2s timeout on resume).

Fixes: 0e9952804ec9c8 (Bluetooth: Clear suspend tasks on unregister)
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
Should have caught that unregister_pm_notifier was blocking last time
but when testing the earlier patch, I got unlucky and saw that the error
message was never hit (the suspend timeout).

When re-testing this patch on the same device, I was able to reproduce
the problem on an older build with the 0e9952804ec9c8 but not on a newer
build with the same patch. Changing the order correctly fixes it
everywhere. Confirmed this by adding debug logs in btusb_disconnect and
hci_suspend_notifier to confirm what order things were getting called.

Sorry about the churn. Next I'm going try to do something about the palm
shaped indentation on my forehead...

 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index efc0fe2b47dac2..be9cdf5dabe5dc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3794,8 +3794,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	cancel_work_sync(&hdev->power_on);
 
-	unregister_pm_notifier(&hdev->suspend_notifier);
 	hci_suspend_clear_tasks(hdev);
+	unregister_pm_notifier(&hdev->suspend_notifier);
 	cancel_work_sync(&hdev->suspend_prepare);
 
 	hci_dev_do_close(hdev);
-- 
2.28.0.618.gf4bc123cb7-goog

