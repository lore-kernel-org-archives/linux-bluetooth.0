Return-Path: <SRS0=jcZI=CH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F69C433E7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Aug 2020 01:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75873207BB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Aug 2020 01:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vl4Id8eU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgH2BC0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Aug 2020 21:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgH2BCT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Aug 2020 21:02:19 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE28C06121B
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 18:02:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c15so436250plq.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 18:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WzMgBr6hhvcDtrhfuNfDzhOG8Bse/af+dPFv5Ba8Gf8=;
        b=Vl4Id8eUvBWQPvZxBRw3tOc30eVeXWsHO8ttewO4X+HcoSKG9IzlHLa/fZwUychnRI
         KNQcdaDkblXk7BdXi1ufKelVB0L1hXPn72U35pYeDelIlCZ2elLeevOJtzfW4EHSA63d
         Nxd/20OEFE8zn30iw9Rq2FPoptMbsjXrwLO84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WzMgBr6hhvcDtrhfuNfDzhOG8Bse/af+dPFv5Ba8Gf8=;
        b=DguL6BMAFAoAN7Vz4q16X4y2GxkUXATAneOOuxBdGJv4Rh78n3DbhweHT4CQNASiY9
         2zAlEiaFDGENCtAi987V47r5fF1De4G8kYHZ3XRmrmejDICapu6pH4gfJLpnDMq94nKH
         3jDiJV/Mkr5uFRkz4nGL5NXwz9XMKi2lsTVUwIfKYiaIRX4FwOSKl7lI5PFhAPvUsf5H
         yUeCQcvp8899kbCdlWtwmy51sQKV/0aBFvbOZqiyp1ZgcqpiMPkeNZgSP4H+Lk67zlnX
         8Lz1D1KmgcXch58e4ZzjHXIGxW1IyAU91vyEuq6/WrqmTqOFrNFwv3lxj+KoPTL4hWHA
         Lm1A==
X-Gm-Message-State: AOAM533QNOoggyl+VXCz6hhrXXv/vaUEHCB1LZo1KtSf5NP5WafophXk
        MpK7H9MJDXKqn67fUhjlZTl3QA==
X-Google-Smtp-Source: ABdhPJxZMqSLax2XaL6lF0cIkKzf8NWqAFCsuGtvT40baW+lGqSwnWdPCzuZWTu72/IwZAP2te5Djg==
X-Received: by 2002:a17:90b:194d:: with SMTP id nk13mr1353192pjb.92.1598662937746;
        Fri, 28 Aug 2020 18:02:17 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id 78sm630360pfv.200.2020.08.28.18.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 18:02:16 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [Bluez PATCH v3 0/3] adapter: Reconnect audio when resuming from suspend
Date:   Fri, 28 Aug 2020 18:02:07 -0700
Message-Id: <20200829010210.871471-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
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

 * In the device disconnect callback, mark any devices with the A2DP
   service uuid for reconnect. The reconnect will not be queued until
   resume.
 * In the controller resume callback, queue any policy items that are
   marked to reconnect on resume for connection with the ResumeDelay
   value (default = 2s).

A reconnect is queued after the controller resumes and the delay
between resume and reconnect is configurable via the ResumeDelay key in
the Policy settings. The 2s delay was chosen arbitrarily and I think
anywhere up to 10s is probably ok. A longer delay is better to account
for spurious wakeups and Wi-Fi reconnection time (avoiding any co-ex
issues) at the downside of reconnection speed.

Here are the tests I have done with this:
- Single suspend and verified the headphones reconnect
- Suspend stress test for 25 iterations and verify both Wi-Fi and
  Bluetooth audio reconnect on resume. (Ran with wake minimum time of
  10s)
- Suspend test with wake time = 1s to verify that BT reconnect isn't
  attempted. Ran 5 iterations with low wake time and then let it stay
  awake to confirm reconnect finally completed on last resume.
- Suspend test with wake time between 1s - 4s. Ran with 5 iterations and
  verified it connected several times in the middle and finally at the
  end.

I've tested this on a Pixelbook Go (AC-9260 controller) and HP
Chromebook 14a (RTL8822CE controller) with GID6B headset.

I've also tested this with the Pixel Buds 2. These earbuds actually
reconnect automatically to the Chromebook (even without this policy
change) and I verified that the new changes don't break the reconnection
mechanism.

Thanks
Abhishek


Changes in v3:
- Refactored resume notification to use btd_adapter_driver
- Renamed ReconnectAudioDelay to ResumeDelay and set default to 2
- Added A2DP_SINK_UUID to default reconnect list

Changes in v2:
- Refactored to use policy instead of connecting directly in adapter

Abhishek Pandit-Subedi (3):
  mgmt: Add controller suspend and resume events
  monitor: Add btmon support for Suspend and Resume events
  policy: Reconnect audio on controller resume

 lib/mgmt.h       | 14 +++++++++
 monitor/packet.c | 55 +++++++++++++++++++++++++++++++++
 plugins/policy.c | 80 +++++++++++++++++++++++++++++++++++++++---------
 src/adapter.c    | 36 ++++++++++++++++++++++
 src/adapter.h    |  2 ++
 src/main.c       |  1 +
 src/main.conf    | 11 ++++++-
 7 files changed, 184 insertions(+), 15 deletions(-)

-- 
2.28.0.402.g5ffc5be6b7-goog

