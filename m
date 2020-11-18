Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0D5C64E7D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 23:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474E6246CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 23:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N9sqPWGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgKRXoF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgKRXoE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Nov 2020 18:44:04 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DE5C0613D6
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2020 15:44:04 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id u2so1897282pls.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2020 15:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FtRxO4GemGjvQrMlES911DtV5VS1GNyC2f2uIjqIY44=;
        b=N9sqPWGrOl4w0sTA0YeGv0oEUvPcX29fc3q7s9Lc6kKxI1cin/1FGLDsPklUFx3WH4
         Ndz3RykX+GS/Umt850AWO/UZmdJ6w8noHEcBr13whNVSIyFNUAiDVC73BcdUMd5gUGK5
         KhCWhrKUWg8O8mCW6g3b4mzekeBcI7oVzT3qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FtRxO4GemGjvQrMlES911DtV5VS1GNyC2f2uIjqIY44=;
        b=uTfgr0uuf3fZYeIGteyMT+sEZDSPA/VVSQgrRPlen3oNdhRMEa0ndAiR8ciobx3yFL
         lla9AYX33NZI07p2RfiFXA96ZvJpWP30QkGM8B6Qe6ckcfL8OML8k54hOOyQSGtFioFC
         RjqSl0beRxGJ5smkP1EpiFuKGMVJ1Zrv7hNW2Bp4SahhyzagvlTwTwxQg4gSmPIITUG+
         28iveooPPCDHSFDmTR/iSC2WZ35mnQNy/+xU50aikqNxrGijXX0fxMPK51Y0aJyN0AsS
         KmhVFTMFEPfuB0w0mHU9r/Tc2nnLne1nossWnR46KXXcx40WJMfun3XVeC+eS4QlneZn
         tMLg==
X-Gm-Message-State: AOAM53088xSwEpES40NXyUv3QeguzUZB3ELvCqRvkleNSjmdnmGU3Nfg
        vgB3zGQ3/KdOQiANuWpvm719zQ==
X-Google-Smtp-Source: ABdhPJw3KGa/xIgwjgSmYgn2Vm5bx1X/lCf6LYoKrbV+HuKqVFwlSCwMEaLLx1mEESdUQH/XI5qWLw==
X-Received: by 2002:a17:902:be07:b029:d8:afa1:3d76 with SMTP id r7-20020a170902be07b02900d8afa13d76mr6507615pls.14.1605743044245;
        Wed, 18 Nov 2020 15:44:04 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id f6sm21437435pgi.70.2020.11.18.15.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:44:03 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, mcchou@chromium.org,
        danielwinkler@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 0/3] Bluetooth: Power down controller when suspending
Date:   Wed, 18 Nov 2020 15:43:49 -0800
Message-Id: <20201118234352.2138694-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi Marcel and linux-bluetooth,

This patch series adds support for a quirk that will power down the
Bluetooth controller when suspending and power it back up when resuming.

On Marvell SDIO Bluetooth controllers (SD8897 and SD8997), we are seeing
a large number of suspend failures with the following log messages:

[ 4764.773873] Bluetooth: hci_cmd_timeout() hci0 command 0x0c14 tx timeout
[ 4767.777897] Bluetooth: btmrvl_enable_hs() Host sleep enable command failed
[ 4767.777920] Bluetooth: btmrvl_sdio_suspend() HS not actived, suspend failed!
[ 4767.777946] dpm_run_callback(): pm_generic_suspend+0x0/0x48 returns -16
[ 4767.777963] call mmc2:0001:2+ returned -16 after 4882288 usecs

The daily failure rate with this signature is quite significant and
users are likely facing this at least once a day (and some unlucky users
are likely facing it multiple times a day).

Given the severity, we'd like to power off the controller during suspend
so the driver doesn't need to take any action (or block in any way) when
suspending and power on during resume. This will break wake-on-bt for
users but should improve the reliability of suspend.

We don't want to force all users of MVL8897 and MVL8997 to encounter
this behavior if they're not affected (especially users that depend on
Bluetooth for keyboard/mouse input) so the new behavior is enabled via
module param. We are limiting this quirk to only Chromebooks (i.e.
laptop). Chromeboxes will continue to have the old behavior since users
may depend on BT HID to wake and use the system.

These changes were tested in the following ways on a Chromebook running
the 4.19 kernel and a MVL-SD8897 chipset. We added the module param in
/etc/modprobe.d/btmrvl_sdio.conf with the contents
  "options btmrvl_sdio power_down_suspend=Y".

Tests run:

With no devices paired:
- suspend_stress_test --wake_min 10 --suspend_min 10 --count 500

With an LE keyboard paired:
- suspend_stress_test --wake_min 10 --suspend_min 10 --count 500

Using the ChromeOS AVL test suite (stress tests are 25 iterations):
- bluetooth_AdapterSRHealth (basic suite)
- bluetooth_AdapterSRHealth.sr_reconnect_classic_hid_stress
- bluetooth_AdapterSRHealth.sr_reconnect_le_hid_stress

Thanks,
Abhishek


Abhishek Pandit-Subedi (3):
  Bluetooth: Rename and move clean_up_hci_state
  Bluetooth: Add quirk to power down on suspend
  Bluetooth: btmrvl_sdio: Power down when suspending

 drivers/bluetooth/btmrvl_sdio.c  | 10 ++++
 include/net/bluetooth/hci.h      |  7 +++
 include/net/bluetooth/hci_core.h |  6 +++
 net/bluetooth/hci_core.c         | 93 +++++++++++++++++++++++++++++++-
 net/bluetooth/hci_request.c      | 26 ++++++++-
 net/bluetooth/mgmt.c             | 46 +---------------
 6 files changed, 140 insertions(+), 48 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog

