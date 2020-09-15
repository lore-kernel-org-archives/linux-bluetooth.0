Return-Path: <SRS0=CFtH=CY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C557C433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 17:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96752193E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 17:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iL0KxC3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgIORmU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Sep 2020 13:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgIORl5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Sep 2020 13:41:57 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3109C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 10:41:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bd2so1724050plb.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mSVukHJaf23dU18xrmYveJEVtHAOgsrL/FM6fto8MZ0=;
        b=iL0KxC3JRJNuDjTFZsEYYrqoKEgxAtpjRiXqy436MhG07ru7gDqa1a7R3MsDjmDSY8
         Z6g7JzpYn0N11Lsbz2mjNuYm4QtAT5fH4MuxjHDPYow0U/QeLI765Jox8ermxjrEre1R
         wuvmzubPUJAi++Wd7AUVbfw0qZSYQSAWblpp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mSVukHJaf23dU18xrmYveJEVtHAOgsrL/FM6fto8MZ0=;
        b=c1PkMZS2p820SQcVY8yUh3N7lwUKuyfNeNlpOXu3frJFOUin3+O7WHBQb6bC168OOb
         qAAKMjq8A7o9PFHbaYpstC1U2c5T0Hr/5/9Yx3DgKH4J/yTb5PDdyCI3Aj+XKeNCD31k
         B/fkj8MsRQoBZbJxVnVCUbG4k5R9Xh/pKdIiucZzgCV9dXPDM2Wi4+IkWGnO5ng5fV2N
         rOXNxbyiyTd/KkcryBFrSgnZsqKwssVV8j4GO7Ei5Rsdl9C4ewQvGUWd/cULREliFHv6
         613nXLKUqe0IqxXA862gwugB8LsmeJbbFQgeaP97OSLzIUp1+L9vbFtGqaCON/XVJrEI
         gn4w==
X-Gm-Message-State: AOAM533l7sB3xZOFrQruIPKuKerZ4ipv+0jjAIUV523DsNWkQRvE0m6c
        W75xiuPb9iqlbHEi2jraZhiFMg==
X-Google-Smtp-Source: ABdhPJywvk6gs4v3oj8E7xFuwTHAL28fQaX+WXa7jY6xwOS32lw/CwWN5z+fwYDg+dgrvnfAD6tFnQ==
X-Received: by 2002:a17:90a:cb0f:: with SMTP id z15mr446612pjt.76.1600191716217;
        Tue, 15 Sep 2020 10:41:56 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id y29sm15490232pfq.207.2020.09.15.10.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:41:55 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [Bluez PATCH v5 0/4] adapter: Reconnect audio when resuming from suspend
Date:   Tue, 15 Sep 2020 10:41:42 -0700
Message-Id: <20200915174146.1693687-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
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


Changes in v5:
- Remove use of !! in has_kernel_features

Changes in v4:
- Set reconnect timer in disconnect if resume events aren't supported
- Only set reconnect timer if adapter matches current notification
- Refactor changes in src/adapter to its own commit
- Refactor enabling A2DP_SINK_UUID into its own commit

Changes in v3:
- Refactored resume notification to use btd_adapter_driver
- Renamed ReconnectAudioDelay to ResumeDelay and set default to 2
- Added A2DP_SINK_UUID to default reconnect list

Changes in v2:
- Refactored to use policy instead of connecting directly in adapter

Abhishek Pandit-Subedi (4):
  adapter: Refactor kernel feature globals
  adapter: Handle controller resume and notify drivers
  policy: Enable reconnect for a2dp-sink in defaults
  policy: Reconnect audio on controller resume

 plugins/policy.c |  87 +++++++++++++++++++++++++++++++++-------
 src/adapter.c    | 102 +++++++++++++++++++++++++++++++++--------------
 src/adapter.h    |  11 +++++
 src/main.c       |   1 +
 src/main.conf    |  11 ++++-
 5 files changed, 168 insertions(+), 44 deletions(-)

-- 
2.28.0.618.gf4bc123cb7-goog

