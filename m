Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F69FC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 21:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiKAVW2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 17:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiKAVWF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 17:22:05 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4449C1DDF6
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 14:21:40 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e189so2678937iof.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Nov 2022 14:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AxX1Cktp6gphiF4roBan9FbTP4i2T9/txTh51XcmZh8=;
        b=AC/mo59MEaZTzt8J3eF8HfL2S2HCQYamkZ902rUiFoaPwerUY22IuQbLA3FyJlDjiu
         Jk4ZaPDAy2QcWcD3RI+g7U2p8VXq15sXp9T6wUN0ZirpuJvjTBQcLnIRHgRnFjaqeUp5
         WDj02vxR5GRubihTgTPcchF+PwF/PKG9CFTGRhyVyIW/aM46D8LyomGolvslVgsZbydV
         Rh+db0stuqn3BWbMHPiNTcLCiqEYp3CE1qBpvKAmqVzJJC7jv+Wfq4V4ms5A379BPHyW
         j8ZYivg7VkJ/czwKayzfGAbR+Fk396dB8KOVOSOaixip9QyOqq8GNT2ygtp63Uyj+9Zd
         uesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxX1Cktp6gphiF4roBan9FbTP4i2T9/txTh51XcmZh8=;
        b=KTBuZyAXGwxyJ2+U55PBzFke7PRx9Wxkc45ZkwZUIvH2ut2n+5Wf3eYUaL7FiFymQN
         huvsPC3pNX+f6xXn2vv/KmKUL0h1HQS0qfcVngTjXgdr8sMcVAcw3XcpruVgdwa+lpKK
         0vQtvq6uZoRsRPP5yqZT/k2QLq8+lqU7mzzJdxeNtZgAX+E4O4E04wB2/WHZ1py2bhpC
         dcOKMX5bXa3/HaVOFSvUrgq57Ivd9pfAEtTzC4zd6G4yFcUIxeucxzdiZVDQJaW018aF
         QDi4/cgQjNSdj78M60qES1TI03WjTmvkArx58riOznySQsdrMsXSJNprtmaArr4wSTvB
         +6yg==
X-Gm-Message-State: ACrzQf3UwjxQ2U7W4222Q6rwWC60VdnpoRbb/6BokN7ONz5dZ5sziwg1
        0fkpH+alVSjnQtMYO7xfGcUj03pdcAM=
X-Google-Smtp-Source: AMsMyM5l9lqQKD5uM2103nOfrKn6AEkZbKx7cHpuccQHMZZAApeJGHGmtH5PuUKVHbsVviVJ4okeEg==
X-Received: by 2002:a02:3346:0:b0:375:4c11:ee4d with SMTP id k6-20020a023346000000b003754c11ee4dmr10872472jak.207.1667337699491;
        Tue, 01 Nov 2022 14:21:39 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.137.117])
        by smtp.gmail.com with ESMTPSA id g9-20020a025b09000000b00363dfbb145asm4094555jab.30.2022.11.01.14.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 14:21:39 -0700 (PDT)
Message-ID: <63618de3.020a0220.35076.6c44@mx.google.com>
Date:   Tue, 01 Nov 2022 14:21:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6011425308638644755=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marex@denx.de
Subject: RE: [BlueZ] tools: Switch hciattach_qualcomm to FAILIF macro completely
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221101202636.143165-1-marex@denx.de>
References: <20221101202636.143165-1-marex@denx.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6011425308638644755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690948

---Test result---

Test Summary:
CheckPatch                    PASS      1.14 seconds
GitLint                       PASS      0.76 seconds
Prep - Setup ELL              PASS      26.29 seconds
Build - Prep                  PASS      0.71 seconds
Build - Configure             PASS      8.19 seconds
Build - Make                  PASS      731.42 seconds
Make Check                    PASS      11.41 seconds
Make Check w/Valgrind         PASS      289.30 seconds
Make Distcheck                PASS      237.17 seconds
Build w/ext ELL - Configure   PASS      8.27 seconds
Build w/ext ELL - Make        PASS      84.31 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      471.06 seconds



---
Regards,
Linux Bluetooth


--===============6011425308638644755==--
