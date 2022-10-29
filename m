Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DEEC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 21:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJ2VI4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Oct 2022 17:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ2VIw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Oct 2022 17:08:52 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FE73AB10
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 14:08:52 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id g13so4621693ile.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 14:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/C9ZZGoiHlkXH8Z+Of0SQTXYga0/rCphHaWQWi2dvMU=;
        b=V11ptPMxwbtA7cyBlD4RBdOV5rConIBn0aH5t16DPkPB/4h8hhMtb2suemMjrkfZ8k
         olzUAAAdbWbux0/9+AZ0ScP+5wFJXr/5enLHlNurGW39tIArIodnRE2C1eumP9GpxI18
         bkDHHuGSC/7hZiBjxWVq0kQUx48n3PwrhqaXrP+1rTNEcCdDz+yrq/kyoHtGwb9zdhcb
         6BboDkKOEJ6CLraCS1Un8y3YJBemGfNyvN25uiGKTUVaqLuS8yIQ7HVTif2HAllEOTpR
         jYm1KNEbrX9lMkzislJJ7mLQTkxvYTyMFVs8V1n8DKQLteZmuYPdL54Qpbnv79rR/bvf
         UgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/C9ZZGoiHlkXH8Z+Of0SQTXYga0/rCphHaWQWi2dvMU=;
        b=qwcupTdosmH2tDIZd3BsYC1WRH3jvJKFjt+sLy9GqmFPzQ9t/jCRdMmJSM6tT9xRR9
         s8UyrNvC7fEjBNhtA9y+z7cmnsurj+Cqw+9v8d5qUdNAvoeYm3pv5HFyiWg9gRhU+xqW
         Z4/8Jx0+iZDtx/L3DaXFW7WEa3EPhfE0i7iuG3DxRr/d6woNH7SYQthq/8HNJd0Ku5Ff
         H6gFnbDnO81NCufuuOQlJREfOSES/RDbVMrKVllg4T98adLqweeKVGLxHr11DgVCfMvL
         6b4+NlBi8PNiXS5lvQZ3lHfwTef/fWY/7uKlfyrHuW4elYhxL4PhqcTwG4IcifSIvYol
         a3BA==
X-Gm-Message-State: ACrzQf1Y+pzGRX0WIxQA0GGNAB1rLYGbwSMmCkXBRDEq61BzTL2UE7YR
        r0KtHUXyGNh7qIZ7qImx3XL6vPVDXaY=
X-Google-Smtp-Source: AMsMyM77ZyEasY+/PxujjvzFUH33Nq85AgzxXrofkAO+Ku8yGmzs9yjQSsdq4rLq8nrwIFhFB+i3zQ==
X-Received: by 2002:a92:d28a:0:b0:2fc:1400:19c9 with SMTP id p10-20020a92d28a000000b002fc140019c9mr2767188ilp.20.1667077731505;
        Sat, 29 Oct 2022 14:08:51 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.5.10])
        by smtp.gmail.com with ESMTPSA id q28-20020a02a99c000000b00371ef930be0sm1000238jam.1.2022.10.29.14.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 14:08:51 -0700 (PDT)
Message-ID: <635d9663.020a0220.2b849.14a5@mx.google.com>
Date:   Sat, 29 Oct 2022 14:08:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4575241892772402746=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tegongkang@gmail.com
Subject: RE: net: bluetooth: Use kzalloc instead of kmalloc/memset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221029204541.20967-1-tegongkang@gmail.com>
References: <20221029204541.20967-1-tegongkang@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4575241892772402746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690180

---Test result---

Test Summary:
CheckPatch                    PASS      1.31 seconds
GitLint                       PASS      0.78 seconds
SubjectPrefix                 FAIL      0.66 seconds
BuildKernel                   PASS      35.29 seconds
BuildKernel32                 PASS      31.05 seconds
Incremental Build with patchesPASS      47.28 seconds
TestRunner: Setup             PASS      519.68 seconds
TestRunner: l2cap-tester      PASS      17.22 seconds
TestRunner: iso-tester        PASS      16.32 seconds
TestRunner: bnep-tester       PASS      6.29 seconds
TestRunner: mgmt-tester       PASS      104.09 seconds
TestRunner: rfcomm-tester     PASS      10.15 seconds
TestRunner: sco-tester        PASS      9.51 seconds
TestRunner: ioctl-tester      PASS      10.81 seconds
TestRunner: mesh-tester       PASS      7.72 seconds
TestRunner: smp-tester        PASS      9.45 seconds
TestRunner: userchan-tester   PASS      6.49 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.66 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============4575241892772402746==--
