Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F706C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 13:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiKANhr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 09:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiKANhq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 09:37:46 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063A01B79B
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 06:37:45 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 16-20020a9d0490000000b0066938311495so8479303otm.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Nov 2022 06:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E0wzVNxN6aTcwvsmfkOT6wbkQLUHvUS3/kAWGpyoJ2M=;
        b=l0zvPRxrvX5K4bt4W0ZcuX5t6ZvY7bIJl0Rb7yPYt4wAGv+9MHv7x+Lm7xS51o1Wqm
         SeOXWNy8dOwCQFlxL7el7aF82qJZQf/PSKnC2JCoSedBdrT6hcZl3ezhr+rkTsC2KQ51
         5PMSpfWhDcdi6T8lOqGPw72/RZECLTLzCF/QAZApRfIYr2eTa81rtZCskOnMuMnM+pPf
         SKXbhjkgRkdPy6YxUk1e4gkqQII05g74EJFzazFnKfoT2qdOZeOlIFe3URVFeyNHfNMr
         t3A5B9vc726QS5kd1bNqApt+zZt4TnAtXTHtD/Puo7uAz+8Q6JKJnoouqOeBDLqK0GD1
         rI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0wzVNxN6aTcwvsmfkOT6wbkQLUHvUS3/kAWGpyoJ2M=;
        b=6D8g14jWPWROAioDUr1wTJ9smxtvsUV5nYSPA7H+x/dzvhlGgH8NEkqkmRnvcEU7yi
         t9XLkI97oVOzak13NJkhK/bg1wnrY9O9Vq4lN5ypdDErcfXZHhIQM4eQfrdI5AnXh1Xu
         j8pE2KLJmUVP0mrSucVmz3g0IW0mJkCjuDBMHc6+aryrMQYEv4QsQC8j/tqO7bdP+u+h
         MF8kXp5vk4UCbpuJsMU5is/4Y9WRivYbieqYhOJTzWBFBD6wirshE3HNrzJTuE7XHgbP
         uiY97KATqLoy5tQtz8k7rJQMdGxWpEngrmO1DsHOWAtnSrtwF15Fjf5iy3gqBxU8Sc6c
         NRWA==
X-Gm-Message-State: ACrzQf3Uf45iKb4jFTaK9kkEH7tJSk+JJhmmozdqQkq82BT/J5cd/8Qe
        PvGYxjseLYKeBjuRTuXsGlnacTIMhR0wcQ==
X-Google-Smtp-Source: AMsMyM614gyfWBvjlnN6+RQEOvmFBw8qOyzn1etkn8wXdqtsUr9idW6EUhcviOG+kXozlWSXsgJ86A==
X-Received: by 2002:a9d:5907:0:b0:665:c301:2f1c with SMTP id t7-20020a9d5907000000b00665c3012f1cmr9406662oth.375.1667309864119;
        Tue, 01 Nov 2022 06:37:44 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.227.139])
        by smtp.gmail.com with ESMTPSA id e66-20020a4a5545000000b004805e9e9f3dsm3434753oob.1.2022.11.01.06.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 06:37:43 -0700 (PDT)
Message-ID: <63612127.4a0a0220.ee3ae.be5c@mx.google.com>
Date:   Tue, 01 Nov 2022 06:37:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2938725012337894439=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marex@denx.de
Subject: RE: [BlueZ] tools: Make hciattach_* firmware path build-time configurable
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221101115333.18223-1-marex@denx.de>
References: <20221101115333.18223-1-marex@denx.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2938725012337894439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690839

---Test result---

Test Summary:
CheckPatch                    PASS      1.01 seconds
GitLint                       PASS      0.86 seconds
Prep - Setup ELL              PASS      26.44 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.16 seconds
Build - Make                  PASS      723.76 seconds
Make Check                    PASS      10.90 seconds
Make Check w/Valgrind         PASS      287.82 seconds
Make Distcheck                PASS      233.70 seconds
Build w/ext ELL - Configure   PASS      8.17 seconds
Build w/ext ELL - Make        PASS      83.94 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    WARNING   476.19 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
tools/hciattach_qualcomm.c:218:8: warning: Although the value stored to 'n' is used in the enclosing expression, the value is never actually read from 'n'
                if ((n = read_hci_event(fd, resp, 100)) < 0) {
                     ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hciattach_qualcomm.c:253:8: warning: Although the value stored to 'n' is used in the enclosing expression, the value is never actually read from 'n'
                if ((n = read_hci_event(fd, resp, 100)) < 0) {
                     ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 warnings generated.




---
Regards,
Linux Bluetooth


--===============2938725012337894439==--
