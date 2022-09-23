Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92923C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 15:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiIWPWP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 11:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiIWPV6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 11:21:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B6314354D
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 08:21:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e67so517005pgc.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 08:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=duBKzft//SxKRLpKa0oLiPXRd3VThp7dZXRjWBxXKbU=;
        b=djDI0rQ+w/LQ5llHB/42pAQqvLZil2edgGOcXKMiu/ME9LluyuEm8ovusGiFnghsnc
         jKO5YSDkHM2IRkFA3YyX6vYb1aHWKHDAJ1l9skC2ip/zDYe1uFbtr6w9edtN+VUXo9tE
         1c0ShVEmMa3YmoaX77aKgyB4Du1lephG96uBIGK/3lqzAVl7mT3mdJVb6/6rID8G4OIB
         P1nYwI9gUo3+6auK4YmKVQG7Z2SZKBOdZV27HTr9og71sRb37Tqovf5kpAQvxnTb3BFw
         aFCnrqSS+v/SDgKbQwqQI7hqpvy/lDFxm09nMFseo1VU+qv2RTXlrt0MV6h/J6H2PAre
         j48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=duBKzft//SxKRLpKa0oLiPXRd3VThp7dZXRjWBxXKbU=;
        b=Jkrl1JQBsr0X9O3nqelVmYmb7qaEn9FaAoOOOIiWdVuu+8O3YHpmvLS+hjG0E5KaaD
         32znZcPOp41PCMNTuV7c6db/vY3C1X+1xP3BGDhx6DvphEeWUoeFq6NqtV94M3gKjXSy
         4h/NacgVeisL12MDRdSyenfezPMWTa9kWRkC910Go3dNqGaSeWkBwz2ssiTXmPkZFLKp
         +ohgKInEh7McUu7zEN8UTZ+Y2/Iw4TD5io6VVd+eqYuSHx07eUFyp0x3xUIKog577rn+
         yfRmvwh5ZuXcnAVMh/FTCXSNQcr3Yp+2WmNyaRNnXOtkhPV9+K+vHNOS1rp+qa4sFlwI
         rbpw==
X-Gm-Message-State: ACrzQf3q2yB7BUFL72Pi9kowjDO4I21L5Zy1JAot2lTE0CznttXQ4L9j
        Gao0pSzUr8A5i7+9haaSk4p9n7IA3oI=
X-Google-Smtp-Source: AMsMyM7XPf0WB7bDZmlHMXBFluwtzcGIkN7CdLH3ud0L7qkaS49m9JzEArfMm6JLBtvURD6lyLsG8w==
X-Received: by 2002:a63:20f:0:b0:439:c92f:e6d1 with SMTP id 15-20020a63020f000000b00439c92fe6d1mr8035215pgc.334.1663946516191;
        Fri, 23 Sep 2022 08:21:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.96.253])
        by smtp.gmail.com with ESMTPSA id b3-20020a62a103000000b00540de61c967sm6514583pff.201.2022.09.23.08.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:21:55 -0700 (PDT)
Message-ID: <632dcf13.620a0220.d6a7e.d17b@mx.google.com>
Date:   Fri, 23 Sep 2022 08:21:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6913654741418336590=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [BlueZ] client/gatt: gatt_register_app: fix parsing of UUIDs
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220923143331.18926-1-ceggers@arri.de>
References: <20220923143331.18926-1-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6913654741418336590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=679905

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.50 seconds
Prep - Setup ELL              PASS      32.17 seconds
Build - Prep                  PASS      0.69 seconds
Build - Configure             PASS      10.18 seconds
Build - Make                  PASS      998.60 seconds
Make Check                    PASS      12.85 seconds
Make Check w/Valgrind         PASS      350.79 seconds
Make Distcheck                PASS      292.54 seconds
Build w/ext ELL - Configure   PASS      10.28 seconds
Build w/ext ELL - Make        PASS      102.02 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      621.25 seconds



---
Regards,
Linux Bluetooth


--===============6913654741418336590==--
