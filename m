Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F65C00140
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Aug 2022 03:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiHFDGG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 23:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiHFDGF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 23:06:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5D4DF11
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 20:06:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p18so4104803plr.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Aug 2022 20:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=OtaOzUShaf7sdsQOu11O9MxeEuymY9PKOpmlEWkIqk0=;
        b=KS4oZvYgZ9AN/+cHPfbAMYwMb9iH3sXEWJ30mEI3QPSZ/YAwH0xueTAaFaA/F3QD24
         1ls9CR1FwBshq5B94d2bUKq9YG3l1MR7yHp5PQ/4WRhnUlBjiU0dE2dIhesQwnI8pZ8M
         hXMyI8cOPhfJzUxzw8yw8TjjVBFMLQrt1oepqAZkSOie8mzRGvv/KjSt1T+r9LL8BNrL
         VnRYYJ5armvdRX1lq201aMkvO0V/RDE7EUEv2FnP3hY7Ji2QigtDN6d960UstetXwI7X
         /O/rk9G6QrrFJmnRk6WmuqRssvDLjxpKmC1LPphyw466+xzQzZI5kfQwA7cAk1HOJ4bW
         gSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=OtaOzUShaf7sdsQOu11O9MxeEuymY9PKOpmlEWkIqk0=;
        b=BSCrn0KHx1vOFEI3pX+G6RLaN+Vi41LJbwLjqPZWm/Z3SunBFoSRYP+C6E9xayU8MG
         0ieXLD98nNrpe0S24wTSYvz9QXPQI1eHY7IfAbE/O3HSYwDCtdJZtvS3AnCtzPU39IWm
         rZv7uovlGdzZL0YhkC8nKl41MuPaoaQjGW07vtcTmkBJ01Sm9G/N/yrMZxJZPymi0aFl
         bWNG6ji/5NmwNA6zdf7VE1K7vY4WAvyFzvcbzch39D6aNLQ1K5PmazW5DAhvrDL/JFq+
         MV/cF0wYq+acUCuvoFzIN8/RjXCvXhiDF7btnblewCkCrUCdInmk5H1wdjKqcIurbat5
         Jf6A==
X-Gm-Message-State: ACgBeo2pTftPHiO9lfeema4iBxI0PbvpiDHzfFxK8uv31ao51D+jQhFy
        5i+n9SYwL0r5GHozUZskvWl0dA83HKE=
X-Google-Smtp-Source: AA6agR52FR76T1Z/DP1FGkcGsXYZTWgu1WUE7XR9Wb2jT+cIzHNYa2+lbCMeMZHFr1StTMvpQIcQcw==
X-Received: by 2002:a17:903:1d2:b0:16f:1664:dd3b with SMTP id e18-20020a17090301d200b0016f1664dd3bmr9663323plh.60.1659755163330;
        Fri, 05 Aug 2022 20:06:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.209.234])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b0016bef6f6903sm3863072plg.72.2022.08.05.20.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 20:06:03 -0700 (PDT)
Message-ID: <62edda9b.170a0220.d0d78.6ff4@mx.google.com>
Date:   Fri, 05 Aug 2022 20:06:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0334048351864385828=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Clean-up stale/unused hci_request.c code
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220805234236.704986-2-brian.gix@intel.com>
References: <20220805234236.704986-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0334048351864385828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=665790

---Test result---

Test Summary:
CheckPatch                    PASS      12.16 seconds
GitLint                       PASS      4.20 seconds
SubjectPrefix                 PASS      2.69 seconds
BuildKernel                   PASS      45.26 seconds
BuildKernel32                 PASS      39.57 seconds
Incremental Build with patchesPASS      251.29 seconds
TestRunner: Setup             PASS      639.25 seconds
TestRunner: l2cap-tester      PASS      23.50 seconds
TestRunner: bnep-tester       PASS      8.06 seconds
TestRunner: mgmt-tester       PASS      123.87 seconds
TestRunner: rfcomm-tester     PASS      11.97 seconds
TestRunner: sco-tester        PASS      11.82 seconds
TestRunner: smp-tester        PASS      11.50 seconds
TestRunner: userchan-tester   PASS      7.89 seconds



---
Regards,
Linux Bluetooth


--===============0334048351864385828==--
