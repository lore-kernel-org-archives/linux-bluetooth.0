Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0C7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Apr 2022 04:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiDRE3Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Apr 2022 00:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiDRE3W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Apr 2022 00:29:22 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2042DF7E
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Apr 2022 21:26:44 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q1-20020a17090a2dc100b001cba43e127dso8358893pjm.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Apr 2022 21:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jCNva7Rl42FAZBxwEKnKxvp1RzSj6SsCkhgIxDwxIzk=;
        b=WxewwsbP3hiqEba3NsFv721LuAzKiAyvqvfQfLgkNyc+Iz3VI1c/MnXpwkjX0AVa3T
         R04syX8CzVpdQxqU6jdQ28gjbQ1vys+o7MjnLRvoHfvMopJS/GEK411nNKhSP0qK/lZ+
         zh9vPHorOKqQ72fgvL4hmGq94qtEFz63rJMcGXkpWw/+7nhn5mAfGjAbC1wBDPYWhQHo
         ZRqai7UGG5tayYe8djtZmR/w2Bxdv1RtqzvmsPrDNO0o9i+oPd9HGJbXnITecA+ND4SX
         LPJYSoV2kKochxmTpxrW0mWrH7ZO70A+3ixRJaWjoImh9pmyj0p9TPQh34FCI2wsJl2g
         +otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jCNva7Rl42FAZBxwEKnKxvp1RzSj6SsCkhgIxDwxIzk=;
        b=AUxn2D8k5cwC82kEy35x58FiBiWBALim2HSkHLsGfOwc+fb8hzWmz/x18I4CL3IsEB
         U3lRcitMsl3ZSeEzDHjo5VLi8qPrwxLw4bbdaKt974g+22X0IdKEkggpvhH2lvSbRxGa
         j+tXI7df9FiNKKc6WG4s7F+nd5JIXoKd2HJr+pYzrGOerz7n6m9KBJb4oY76s26OMcrC
         xAHwfQg1w27CvpnRzagiVU2T8uYzAv/CmdmxtZ6s6KL5a2WvDrmRPeyvVSAvTlpobtBc
         qEu+KmD0Kym4wbAT/0eEF5JgbBoZMzmuw8hLARYAk1A/OuNhEJkjoy2MQ5HkvccHClYH
         qhRg==
X-Gm-Message-State: AOAM5328iYROP4tfSW0rBI2WMC4gScImoQQFn0B7iHBZQte4gWQPsu49
        hdEvU+fWW3R1wWsa304JWmXmVh3qE9dUWB1Aj6UUmTxObgAVRY3DSunyS1VCWV3CHwgFVPhya11
        5z7xEK3bpLaB2gakUiM86agbz9fCr4JvfYn0wTF9PBUBHbeK/UdejRNjMuWFCofJovxVYV4uP3w
        +p
X-Google-Smtp-Source: ABdhPJy2LEPmlC04FzoTL4Qp//FumiHyB0b246OzZJx/ZgLmjOUAr40lXQ4Hg67GZyTiSVNpFBtEz8l2S34F
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90b:2384:b0:1cb:5223:9dc4 with SMTP id
 mr4-20020a17090b238400b001cb52239dc4mr1128302pjb.1.1650256003648; Sun, 17 Apr
 2022 21:26:43 -0700 (PDT)
Date:   Mon, 18 Apr 2022 04:26:32 +0000
Message-Id: <20220418042635.2567170-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [Bluez PATCH v1 0/2] Adding bonded flag to D-Bus property
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
 src/device.c       | 38 +++++++++++++++++++++++++++++++++-----
 3 files changed, 66 insertions(+), 5 deletions(-)

-- 
2.36.0.rc0.470.gd361397f0d-goog

