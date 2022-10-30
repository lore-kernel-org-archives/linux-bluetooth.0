Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D78C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Oct 2022 02:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJ3CAI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Oct 2022 22:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ3CAG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Oct 2022 22:00:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FF83686C
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 19:00:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n12so21504065eja.11
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 19:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=leK64/ux89y2qd9eC9AkgP8DUzFj4kGt1/tsFaeWY7Y=;
        b=Z3gfszuoWBvFrR8RfR/eGLrQ0angB+CCjpukk9UU/AKb4QBohxASgO/lelnOIBLTLS
         pswowX4z4CWUEccaz00S0JXqZ8iy/9ps+22Jr3WdxA2b1uK5GCqMkMkssxwrhA4gWTef
         i9/BA5zaa9E7vvp1gOYh6DUxMNxNgPpyH9metsl8do5JV9BJi5LQbaok4ycuQvYK3g5Y
         JtBft/3oK/75vph5UrmACpkv30ERLCLwUVwe6xsMkLeZgrbm/EQ5oOI/7s3zRoQf94hQ
         F/MNT2ZcD/rE13J2qMnHuKF4IC6KVOaf1vw9PdZhD8s/LISLsQB4wrWfmFVVST1k/I+C
         Iecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=leK64/ux89y2qd9eC9AkgP8DUzFj4kGt1/tsFaeWY7Y=;
        b=v1XwTa/cMjnbIYoXuTiCidpdDJs66CszBNIlyzDBBloGz04sEibnELSzsGR/oReiZE
         ENSaofHnv5LUJTy3H0mHQm9T3PVTL5caPhzeLJvXa17HM1DHEoLhpzSF0azjjhCB1qfA
         ewUiZT6218j5omU7nIXtzene3X+LG5EHKlCPSP7zKjrSEDblWBrkspV71TnugluEYl+V
         /QFqARhxCDOxG1dV4e1+2t9h/MBSV9tcNFY0GozHAxk5IbS9BDHCk/48tM3/G4RcYgYc
         EGqI5xHotTvq56B3jXvYpFQ9nJ552SBlxxEEjn5zzD3sCfdzx0Ue5cmiZQ/04kdc9bB8
         /aTw==
X-Gm-Message-State: ACrzQf03qI8oLiYSedqZXlB6QXGFTtOQiUIFjyKMBJ3A6Ztczg7ewHiG
        F4b/xGDVQ7sRDAHzMOiOaT7tYEOkurUAIyIzgNm8q00Nwaw=
X-Google-Smtp-Source: AMsMyM5kpTDFVsUsliYaC7GEI056tLHI5azzfVSqzstf3F6CQskayoGPVWQ1gmqdLxnqhTNrG+YHtG4eS753CvUFwGU=
X-Received: by 2002:a17:907:3f0c:b0:78e:2090:6924 with SMTP id
 hq12-20020a1709073f0c00b0078e20906924mr6285252ejc.332.1667095201337; Sat, 29
 Oct 2022 19:00:01 -0700 (PDT)
MIME-Version: 1.0
From:   Sam Spencer <iconictragedy@gmail.com>
Date:   Sat, 29 Oct 2022 18:59:50 -0700
Message-ID: <CAP3P_uyeFiVp_aWzQDehRLo5YNMB_5u4CvoAkZusF48wm12+_Q@mail.gmail.com>
Subject: How can I pair a BT HID device so I can read its input, but not have
 it mapped to the console
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I have a home automation project where I would like to use a B&O
Beoremote One as an input to a Raspberry PI via Bluetooth using Bluez.

I can pair and trust the device via bluetoothctl and once connected I
get a couple of devices at /dev/input/event3, event4, event5.

Using the python evdev module, I can read every key on the remote
(yay). That gives me enough to be able to write a module to plug into
openhab etc.

The problem is that the remote is also being bound as an input device
for the console. Most of the buttons are not treated as input keys,
except media playback, arrows, and most annoyingly the power off
button. Which has the adverse effect of shutting down the RPI. I would
like to be able to use the remote without any unexpected side effects
of its input being interpreted by the console.

How can I keep it bound so that I can read the input through
/dev/input/event*, but not have it bound to the console?

Thanks,

Sam
