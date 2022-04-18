Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6FFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Apr 2022 17:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiDRRwP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiDRRwO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Apr 2022 13:52:14 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C698D344CA
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 10:49:34 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id c194-20020a6335cb000000b0039d9a489d44so9408602pga.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fmwGAZcMMoLjRQmyKmKefv+VzaTEZbmfWgfUw9A8RyM=;
        b=QbiM2647quIc5ijnGpLEpBFhYU2I85ipThKF12iXZ02GSkixj01jXgkaLjqrEGxAPb
         mVPOi3MI476fQVu0KUFikD8/W6/lrO6uN579nvdJX+I/plEFr4MbI4xKn3BBfqHwOtwj
         dMXbbop5yLKxYVl5r6gfHkQ6nrT/GU586Taa/BKCfQak1kLdMM3f6frRZCzQoUtl5kPg
         t3buqnZTy1XOz39mf9pvEuLWd51TNI5rGtaEsKe8KUB7WNHaCvUn6Smu0e7nvb4+eo84
         mYmJAQRTlnsg9PhpfVJmVNiUz/iNBgpBI0xLaPUE4YPaANjSi7tx1FSddrJCOl1vQQw+
         vBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fmwGAZcMMoLjRQmyKmKefv+VzaTEZbmfWgfUw9A8RyM=;
        b=7QSILF852Fou9sJnIiGXLNwh9agovwaE4dRAp/gEjFG1Wdl3urLyKSk7SQFiSy29Sc
         KMFmVccx9Emac0LFkXJuEo7BKDRTCizrF7gUgX6tMMZ1/MSJOzz6JBqMW6ft7s4cr+Dw
         EkWbLsSW/K+RPgjwyoytrb1pIwqpaPuyXFJ9F8cCar7mYV8hVKR+LDA7v0tu3nLK5umr
         7Fx+hubFbF4vksUS5XkehMIBfRtdLu3Tyl4VmEDjl6tFRB5Sj8LfHaZe0sOobtKMCG+3
         01XAV+NZm7u3KOHLz7o7oziMddkRlj8zISQMGa0ecqJh84fMcX1HQckfKozlMEEO6KSX
         htTg==
X-Gm-Message-State: AOAM532Lmi2NmB/u/J+pEyvXhkispxFDxUkYB3PAq5drSabiAuknla9f
        oenceb78G2afD5Ml9jKf6gBAvHk1k2gtxOE3RSgDFdZY9HJkBcY6zd8VcYFtyaZ0x1wp0fQLK5Z
        ddBXTroSnqkg2EhGtZ0S1PZZOOb8cEK8YaYDtnz1ZEu73OIwbXUUWsvBTwtnDlnxoD23+rlfjSm
        l1
X-Google-Smtp-Source: ABdhPJwKHibpIQFhSy4l6UIzy0CtQ0RIQkRgArUklcHjirglBgnnSsdd/jSPgPlyRr4GuBlZanHasx+AI81s
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a63:e209:0:b0:3a9:fd41:dc17 with SMTP id
 q9-20020a63e209000000b003a9fd41dc17mr4695072pgh.94.1650304174166; Mon, 18 Apr
 2022 10:49:34 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:49:27 +0000
Message-Id: <20220418174929.2777339-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [Bluez PATCH v2 0/2] Adding bonded flag to D-Bus property
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently BlueZ client can't know easily whether a device is bonded or
not. This is causing issues for a number of applications. For example,
in the Nearby Share case, the peer device is paired, but not bonded.
This series will add the "Bonded" property in org.bluez.Device1 D-Bus
interface. Changes are also made in bluetoothctl to show the status of
the bonded flag as well as a list of bonded devices.

Changes in v2:
- Move one variable declaration to the top following C90 standard

Changes in v1:
- Add "Bonded" to D-Bus interface
- Send property changed signal if the bonded flag is changed
- Show the status of the "Bonded" flag in bluetoothctl
- Add option to show list of bonded devices

Zhengping Jiang (2):
  device: Add "Bonded" flag to dbus property
  client: Add bonded-devices and show Bonded flag in info

 client/main.c      | 29 +++++++++++++++++++++++++++++
 doc/device-api.txt |  4 ++++
 src/device.c       | 40 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 68 insertions(+), 5 deletions(-)

-- 
2.36.0.rc0.470.gd361397f0d-goog

