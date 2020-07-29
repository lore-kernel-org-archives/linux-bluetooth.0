Return-Path: <SRS0=Z40G=BI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7955C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 01:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8622120672
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 01:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aTzRitfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgG2Bzr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 21:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgG2Bzr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 21:55:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0E8C061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 18:55:47 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t6so11071436plo.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 18:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0mg8uMGqdODjV0twVLdps/ZZK7k46XwhUkh9iWxwZlk=;
        b=aTzRitfxz9zopfIM5sf1aA962vCcQ41AV5sAyCoKScsjH8DBz42gqa7qT0+4acAQTl
         O3gUENOJcN6Nj3BNQpvAtljk8vlMT+RkpJZv0/+UjMvCGDOBNW1m5yQXB2JsFh8UfJnG
         8G0Uubw1tHMZJ/KXSOTNZI2GR2BWt4JnO5tP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0mg8uMGqdODjV0twVLdps/ZZK7k46XwhUkh9iWxwZlk=;
        b=aTQdo0V6m3isXEtheAdw56nF3rCTxMp2tpNREgQEkQdRhLFMOuqxtrHbzyt6VmW0R2
         BkQRQrNrz9GAGBXN84D36WU2sdiaIL4IC240d9Tmu7Umll/nVw1ovAFxccr3U629bfWo
         dB+lwpN2KmX/157gLXU1H6F3zViLJfej0JYUyKRBOBNu3apcHecrQNvcC6gbaMWJSPDu
         xci1rZ5p2Lt78pdxskQ1afCBRes2K0dproxfUgp27K8x5JVQ0OyHmuMXav9PjdSh2G0K
         dfMSht6XxH9fCuaKaGbxy8M7UeGYfDZOTm99tiRxcBL1f+hwg4oqgU/e5GE0miNA2F+9
         B6GA==
X-Gm-Message-State: AOAM533MDdlJs3eFuaeHWU9rvPfLfVHZR+qfsqarMmfB8c23Xe84Mk7K
        HCed7m9fcGPzfSrpL3eXpr2T5g==
X-Google-Smtp-Source: ABdhPJxhkc0GWRy4AcCb9BdoANI6K3BqmozunmTWCY/XpstZW0eebZ82Nhp2Ej8T4dNGEWBGxeFHOA==
X-Received: by 2002:a17:90a:d30e:: with SMTP id p14mr7466443pju.72.1595987746779;
        Tue, 28 Jul 2020 18:55:46 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id lr1sm371128pjb.27.2020.07.28.18.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 18:55:46 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [RFC Bluez PATCH 0/3] adapter: Reconnect audio when resuming from suspend
Date:   Tue, 28 Jul 2020 18:55:37 -0700
Message-Id: <20200729015540.1848987-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
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

 * In the Device Disconnected management event, if the disconnect reason
   was 0x5 (Disconnected by Local Host for Suspend) and the device is an
   audio sink (implements major services Audio + Rendering), then it is
   queued for reconnect.
 * When the Controller Resumed management event is seen, we check if
   an audio device needs to be reconnected. If yes, we queue a delayed
   callback to do the reconnection. The delay is 5s by default and is
   meant to allow sufficient time for any Wi-Fi activity that may occur
   during resume (since Bluetooth connect may adversely affect that).

A reconnect is only attempted once after the controller resumes and the
delay between resume and reconnect is configurable via the
ReconnectAudioDelay key in the General settings. The 5s delay was chosen
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
Chromebook 14a (RTL8822CE controller) with GID6B headset. I'm hoping to
test this with a few more headsets to make sure this is ok and I'm
looking for some early feedback.

Thanks
Abhishek



Abhishek Pandit-Subedi (3):
  mgmt: Add controller suspend and resume events
  monitor: Add btmon support for Suspend and Resume events
  adapter: Reconnect audio on controller resume

 lib/mgmt.h       | 14 +++++++++
 monitor/packet.c | 55 ++++++++++++++++++++++++++++++++
 src/adapter.c    | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.c     | 27 ++++++++++++++++
 src/device.h     |  2 ++
 src/main.conf    |  6 ++++
 6 files changed, 186 insertions(+)

-- 
2.28.0.rc0.142.g3c755180ce-goog

