Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F0FC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 23:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592332075E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 23:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WlylnxkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHRX2b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgHRX23 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 19:28:29 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30648C061389
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 16:28:29 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id m34so10457536pgl.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 16:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aejUMU5zSaqd7+wMdIKicjWFXZOWAZwkVCeBUjAPWDo=;
        b=WlylnxkI57Y1zTA6NXRygvE9ERDqhBsF2EY1i+DnVp6hopJ6eaEgBLEGqUxBbHuUVj
         6PwdNpEJeekqjYyMxQZMrnptbVvKO/v7YQdhRe9Qdl6dSA/Aj6Rki2J0naWhuK7x3ey0
         Vieu5cpDuS93RHmGP+T8JC0AxeUruh/FkBcu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aejUMU5zSaqd7+wMdIKicjWFXZOWAZwkVCeBUjAPWDo=;
        b=HydFy3tn48PjeqTyQ5YdpYxBoPLi2iruaxIsPCXdjKWvwu/Tho16+PAwDB2cBjY/oI
         0QGihD7rX2mZoFgEZq2rJRYT9nSE2dbNPnbdD1aYNyVhQOa2mYfZpkS5jTikjwmnC/ih
         teP7PMvin0RMpWpBolqrLZJDrFSxhpU55zMPASxgpGKwe/37Q1extVo8UtkVEwPPGKgF
         MStcQcy0z6rEYjpIZSuoGJ7tA+8VcUSj/lhE7rO3I4ROH25ZTdrMfhujqkpV6+W2O/oh
         W8BGM3Pa7m4TwlNqOo4/y9WE6CnfoOvYNT+ttZbMBFhzF+DtNThzOICKLdiNtcu8+2Uz
         BSfg==
X-Gm-Message-State: AOAM533aQh43vvD7hIxDtmQtFv5m8zsf09Ph4w1gA5yGz6OUur6o5fsz
        m1u23JPJvAfCu0YUGGFpnbG29w==
X-Google-Smtp-Source: ABdhPJyNH1vmStdwacwVR7XwfepJJGMq4Osrp+xllXoBHnt3Zv3+vrQl4a8ytgwrxBlK/osjffzvkg==
X-Received: by 2002:a62:838a:: with SMTP id h132mr16810693pfe.72.1597793308492;
        Tue, 18 Aug 2020 16:28:28 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id 30sm904747pjz.24.2020.08.18.16.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 16:28:27 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [Bluez PATCH v2 0/3] adapter: Reconnect audio when resuming from suspend
Date:   Tue, 18 Aug 2020 16:28:19 -0700
Message-Id: <20200818232822.1645054-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi Luiz and Marcel,

This is a quality of life improvement for the behavior of audio devices
during system suspend. This depends on a kernel change that emits
suspend/resume events:

https://patchwork.kernel.org/project/bluetooth/list/?series=325771

Right now, audio devices will be disconnected as part of suspend but
won't be reconnected when the system resumes without user interaction.
This is annoying to some users as it causes an interruption to their
normal work flow.

This change reconnects audio devices that were disconnected for suspend
using the following logic:

 * Register a callback for controller resume in the policy plugin.
 * In the device disconnect callback, mark any devices with the A2DP
   service uuid for reconnect on resume after a delay.
 * In the controller resume callback, queue any policy items that are
   marked to reconnect on resume for connection with the
   ReconnectAudioDelay value (default = 5s for Wi-Fi coexistence).

A reconnect is only attempted once after the controller resumes and the
delay between resume and reconnect is configurable via the
ReconnectAudioDelay key in the Policy settings. The 5s delay was chosen
arbitrarily and I think anywhere up to 10s is probably ok. A longer
delay is better to account for spurious wakeups and Wi-Fi reconnection
time (avoiding any co-ex issues) at the downside of reconnection speed.

Here are the tests I have done with this:
- Single suspend and verified the headphones reconnect
- Suspend stress test for 25 iterations and verify both Wi-Fi and
  Bluetooth audio reconnect on resume. (Ran with wake minimum time of
  10s)
- Suspend test with wake time < 5s to verify that BT reconnect isn't
  attempted. Ran 5 iterations with low wake time and then let it stay
  awake to confirm reconnect finally completed after 5s+ wake time.
- Suspend test with wake time between 3s - 6s. Ran with 5 iterations and
  verified it wasn't connected at the end. A connection attempt was
  made but not completed due to suspend. A reconnect attempt was not
  made afterwards, which is by design.

  Luiz@ Marcel@: Does this sound ok (give up after an attempt)?

I've tested this on a Pixelbook Go (AC-9260 controller) and HP
Chromebook 14a (RTL8822CE controller) with GID6B headset.

I've also tested this with the Pixel Buds 2. These earbuds actually
reconnect automatically to the Chromebook (even without this policy
change) and I verified that the new changes don't break the reconnection
mechanism.

Thanks
Abhishek


Changes in v2:
- Refactored to use policy instead of connecting directly in adapter

Abhishek Pandit-Subedi (3):
  mgmt: Add controller suspend and resume events
  monitor: Add btmon support for Suspend and Resume events
  policy: Reconnect audio on controller resume

 lib/mgmt.h       | 14 +++++++++++
 monitor/packet.c | 55 +++++++++++++++++++++++++++++++++++++++++
 plugins/policy.c | 64 +++++++++++++++++++++++++++++++++++++++++++++---
 src/adapter.c    | 45 ++++++++++++++++++++++++++++++++++
 src/adapter.h    |  6 +++++
 src/main.c       |  1 +
 src/main.conf    |  9 +++++++
 7 files changed, 190 insertions(+), 4 deletions(-)

-- 
2.28.0.297.g1956fa8f8d-goog

