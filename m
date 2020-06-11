Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE3EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 01:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBB4206FA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 01:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XtvA4Ph3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgFKByI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgFKByF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 21:54:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB081C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 18:54:03 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k2so1593111pjs.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 18:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7FIHdEi8UE53+gw/wkyvavC5pix798rp5qt0URRecvU=;
        b=XtvA4Ph3g3MspYhX7MexC/1pPRVk8clbXmFgZwPX+0uFXwvuCcMAkL3nYEuJBoOnuJ
         tZmkRbXGrnZRApp9+PDNUzEZPdvrhqhgOfv6hBlfHM1W2PnxmDhEmspyc0hRZHz167Wg
         QO0Zsa+OSzvbCLDiAAW1FEy5j6torlfwDO6+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7FIHdEi8UE53+gw/wkyvavC5pix798rp5qt0URRecvU=;
        b=UTh2xDNUGpoCvOPW4a+3wGiSnXKCT0Bzd+k8Lg0kMf0MXKawP7PL6mvYCMH6UlqQOA
         dftzvg0SUIERX18VwcXOx2jP5SoHfospRMsPNm4yCXqcCzII0MLeJqb+jDuurqVmsem2
         X7ynXTO6Tsnpi5yAlnU1c4tth33xh85E06hiRQJU85b/kKiDSv99jUp6o4+OfNcBtZs6
         dOvWsm7GDHdSTCmS3XP449+9SpXcFokD2tvqtXMvcKFhYjyptIyxAgfeLdZNOwxSK12k
         mnv6CrySPQqAazZgGnVWRZa3bau2DfRdPGJ13WLZeWGPC03BX85i2cDOOJiaso8oF/N4
         5k4A==
X-Gm-Message-State: AOAM532Cl3GUwldwY1NvMb5TOZ0p+fLptLIhgobM8sofL4Zl6Oas1+Dm
        72NC9VGplflA/wOw3ReqyPPjtw==
X-Google-Smtp-Source: ABdhPJwm1qpCZt/RJk/duXvKTfZz6w74AwJtNSO3tuhVfXLQAx19+C/jnR6GatyZcF1ohWTIaI2+SQ==
X-Received: by 2002:a17:90a:ae04:: with SMTP id t4mr5472625pjq.131.1591840443230;
        Wed, 10 Jun 2020 18:54:03 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id b191sm998661pga.13.2020.06.10.18.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 18:54:02 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtman.org, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        mka@chromium.org, dianders@chromium.org, linux-pm@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Bluetooth: btmrvl_sdio: Refactor remote wakeup support
Date:   Wed, 10 Jun 2020 18:53:52 -0700
Message-Id: <20200611015355.186666-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi linux-bluetooth,

This patch series is refactoring the btmrvl driver to add better support
for controlling remote wakeup during suspend. Previously, the hci device
was getting created as /sys/devices/virtual/bluetooth/hci0 and there
wasn't a way to control wakeup for the device from userspace. This
series of changes adds the proper parent for the hci device, allows irq
configuration via power/wakeup and properly disables scanning during
suspend if wakeup isn't enabled.

This was tested on a Veyron Mighty Chromebook running the 4.19 kernel
with these patches. It passes both automated and manual suspend+resume
tests that make sure wakeup is working properly.

Thanks
Abhishek



Abhishek Pandit-Subedi (3):
  Bluetooth: btmrvl_sdio: Set parent dev to hdev
  Bluetooth: btmrvl_sdio: Implement prevent_wake
  Bluetooth: btmrvl_sdio: Refactor irq wakeup

 drivers/bluetooth/btmrvl_main.c | 11 +++++++++++
 drivers/bluetooth/btmrvl_sdio.c | 13 ++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.27.0.278.ge193c7cf3a9-goog

