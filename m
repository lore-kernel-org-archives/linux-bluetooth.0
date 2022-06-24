Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0602FC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jun 2022 11:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiFXLUU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jun 2022 07:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXLUT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jun 2022 07:20:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B322F6F7BC
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 04:20:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so1950507ybp.19
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kNHqgFkl4YtCT8pApbI11s72RFD7Nt0OXIvThCLw2Rc=;
        b=ip2rsVnLkEXP2nEvAFw/6ziC0Ey7lsJnGlf1m/VagPLcx9QLX2XmZa8VwX/GffV0F2
         4P/V6EXhVlUAm9jt5y8faz2KrK5IA2RbQGSIKladV+3a6eUzSqXtRd2UVxXhjKuh3ivH
         dXUK/kVjsfphNKyEr+qpiE0+72XQgaLrwsB2u7j+NFI4KSlJhphu9XES6QOU8mfSb8LU
         m7+AitHnhFbSugm772jNJfcYfA8nqURR6IHxqQQD4sJvFae4nb0uNWssyPekbIUlrAWw
         w/CwN7Or004nIsaWGO7Gvn19Y9eqr1TO9qhdVcGpuK3qmVqlN34uDxFxtup6qQupj1IA
         r8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kNHqgFkl4YtCT8pApbI11s72RFD7Nt0OXIvThCLw2Rc=;
        b=KaYDC5mUgWC5vkCZ3xdSquWEk9rrmr1kgbNydQ4YitQhaNYnUuJDjOCZa1jbO+ZOtP
         PbDEFF+pqcfaHAFRzDcuBaLp2wzyFhCUzMJEVZbw2SXhBy+b01eY5FG/AXO+ur5dzQjx
         eiDXfWV2vn0DFR61OMWkVVYHwDW1uKDlbEEQxMpp8T6SbC189XbRGeUdZ9HJmdXUd1cG
         ZD3XmELeWU5ETSXW7xMe0hFkFFqEV+qAKUjGDcJgRs4wtPcg8zMhSvN2SHa/yl834sgT
         y+iqDoOUtRJMftv8Ai6c8qPLxId065HUeRxAvXAeYsJ2KYJxY3x+9LgcwOZsuPPSDAyE
         BaRw==
X-Gm-Message-State: AJIora/BypcjMjGlsz2rz31pakksJfOsRAT/IV6dmlTz2c7M+Ie/YCk9
        IxXHUrW1jVu6YLD6WIAma7NILnXvOdL611XOIFo+w+hvO08vUvv8/rhC9XziZ2v7pEJnz8clzrK
        JrEIePAMxLvu6GiZZv5J+1BlEVMaiCvltzuDnMVsqxzvEhWaAt/okaPoeyUsdcYoDLhw/YeLT9E
        YM
X-Google-Smtp-Source: AGRyM1vZ2O5HPCKW+EpLjwKc7xAvjgcKU/GyVldbwoFqhyL9pKjZ3jZxN3A3KOAYEQyaMB2Ziq0YTbgmnJN9
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:fcdb:e3a1:45d7:ed39])
 (user=apusaka job=sendgmr) by 2002:a25:2309:0:b0:668:a570:f69a with SMTP id
 j9-20020a252309000000b00668a570f69amr14997205ybj.554.1656069617958; Fri, 24
 Jun 2022 04:20:17 -0700 (PDT)
Date:   Fri, 24 Jun 2022 19:20:12 +0800
Message-Id: <20220624192010.1.I9afcc6142cb963cf7014aa09edf61a94f5684799@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH] Bluetooth: btmrvl_sdio: Remove hci_{suspend|resume}_dev
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@google.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Both calls are already handled by the hci_suspend_notifier.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>

---

 drivers/bluetooth/btmrvl_sdio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index b8ef66f89fc1..41f1c15ec5c1 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1656,7 +1656,6 @@ static int btmrvl_sdio_suspend(struct device *dev)
 	priv->adapter->is_suspending = true;
 	hcidev = priv->btmrvl_dev.hcidev;
 	BT_DBG("%s: SDIO suspend", hcidev->name);
-	hci_suspend_dev(hcidev);
 
 	if (priv->adapter->hs_state != HS_ACTIVATED) {
 		if (btmrvl_enable_hs(priv)) {
@@ -1721,7 +1720,6 @@ static int btmrvl_sdio_resume(struct device *dev)
 	BT_DBG("%s: HS DEACTIVATED in resume!", hcidev->name);
 	priv->adapter->is_suspended = false;
 	BT_DBG("%s: SDIO resume", hcidev->name);
-	hci_resume_dev(hcidev);
 
 	/* Disable platform specific wakeup interrupt */
 	if (card->plt_wake_cfg && card->plt_wake_cfg->irq_bt >= 0 &&
-- 
2.37.0.rc0.104.g0611611a94-goog

