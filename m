Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE1DC43217
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Nov 2022 18:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKBSWa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Nov 2022 14:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiKBSVy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Nov 2022 14:21:54 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0E22FC21
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Nov 2022 11:21:33 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id x15so7304208qtv.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Nov 2022 11:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sseegeWh/bRja3a1O2fVn3O+gyiXYngXRzUb8Ni002c=;
        b=DTQEM9jV1PZum7ulwyqDsU6yXYyccwUEQCpwYUx3bimkbjo+6tU0JmvYSLYZ0HAiXx
         JkZgQ0VhQYXYXV8fTvEkaQAWkZHv0GX+4YHwHOXKvS/SKCD4RsFNKaJSBX+05npwzvMS
         bwJ+k7B38YtteicQUZctYypSmsWG9T49f9Srww3yVNg9ba9EswWN0ZFLwV5wQvRoWkBl
         TiF8rX4spNquCbIjo0NmF5HTqc9dfDEOApiGf3ifmf363ZP3fCyT1Bn4O0e716RmndKH
         Jku7GrK/d+Oo7yNyJjkBd4w4bMuplh2Dr4x6Q2CsL2TqYJ4ajpV4SZQgn0+CwD2BrVex
         WuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sseegeWh/bRja3a1O2fVn3O+gyiXYngXRzUb8Ni002c=;
        b=OnZVQd6079FWCXw3h2KY/NVSQJUG4dyGgj1JghTsEUqHprsmJuo1oWTtObNVeXVGDe
         eUKh384DVYAXgWp8/hfCCTi8WEOiuhH/m8dQ1XWuMHhxrhBPL72xAu6XW1lA5DIGwn05
         Xtp8G1DxsBBRvqI4OPkJvbjjsN/zipaE8YO+WvpdOty6hFnn8PCntBvoa+vshApBYN2n
         7aeXKyEchnhEZ72hTNypKis0W1k8QFF4wsixLrgakHMNB0O1FUqt/8qN6QmYvgNKecpi
         5bO3qF6QgMa/f14DGuy+8a9twt0T4jdXz9qMxgqBiUUUIcUlbtIhhvKaPH8geM6eNP/i
         NqDQ==
X-Gm-Message-State: ACrzQf24hU/H12EM41BAi9ZB72c6VtH/DpubsHOjVgTth7ziGPduLtWZ
        AeFGe1dh+2uGPP5DsaQgJVtzPZi7kY422w==
X-Google-Smtp-Source: AMsMyM47fwZ/DbDUlPIDqGftmWW0N5/2Ec++ZAl1itqEuDmZ5zswgp6Ks2q5g/nDAXWup2a2I0024A==
X-Received: by 2002:ac8:4e88:0:b0:39c:d4cb:9720 with SMTP id 8-20020ac84e88000000b0039cd4cb9720mr20607454qtp.345.1667413292231;
        Wed, 02 Nov 2022 11:21:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.173.27])
        by smtp.gmail.com with ESMTPSA id h22-20020ac85156000000b003a533886612sm3185741qtn.3.2022.11.02.11.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:21:32 -0700 (PDT)
Message-ID: <6362b52c.c80a0220.1cf4b.e3bf@mx.google.com>
Date:   Wed, 02 Nov 2022 11:21:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4299988683398459495=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Fix MSFT filter enable
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221102175927.401091-2-brian.gix@intel.com>
References: <20221102175927.401091-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4299988683398459495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691340

---Test result---

Test Summary:
CheckPatch                    PASS      5.77 seconds
GitLint                       PASS      1.16 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      34.04 seconds
BuildKernel32                 PASS      30.65 seconds
Incremental Build with patchesPASS      45.09 seconds
TestRunner: Setup             PASS      506.26 seconds
TestRunner: l2cap-tester      PASS      17.64 seconds
TestRunner: iso-tester        PASS      16.55 seconds
TestRunner: bnep-tester       PASS      6.63 seconds
TestRunner: mgmt-tester       PASS      105.41 seconds
TestRunner: rfcomm-tester     PASS      10.50 seconds
TestRunner: sco-tester        PASS      9.84 seconds
TestRunner: ioctl-tester      PASS      11.15 seconds
TestRunner: mesh-tester       PASS      8.20 seconds
TestRunner: smp-tester        PASS      9.82 seconds
TestRunner: userchan-tester   PASS      6.85 seconds



---
Regards,
Linux Bluetooth


--===============4299988683398459495==--
