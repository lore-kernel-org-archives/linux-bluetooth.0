Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEA6EEAA78
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 22:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjINWCg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Sep 2023 18:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINWCg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Sep 2023 18:02:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFD62120
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 15:02:32 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41215efeb1aso8826481cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 15:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694728951; x=1695333751; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TKu2BiEqWVNgrZ/Ftcw07+PpV3txQ0t+R2grgO73Ekk=;
        b=WG5Ze5UwGL6y0vLxQv+zVZvIl8Mv21Wx5ogK20UeSRVXIzN62vyxdGCPAG0Q25UVKO
         gz5xoYEvWd57hRqyP2pOKF2SbsAhZ4sFgVw+4NwL+AhCHGD2yEYNbZOQ0VuwSqhUTfJY
         u0P64+WUeuXnjv7S2GgyS9QFCP5Fhmg1lk9Ujtk3QQ/AmAeNDx1q/EbeRtgZ9nRXnW9K
         SLLOiiHObmTB9l7iIypA3F1uEv636kO71onsVkBOCqH928/TOaH7iSxXRU7OCpXbuAoM
         hhKHF4qk0n0NvGe1ngl99AwidXD4JWv3vQpZjpobXYOnHLhNiiTNbf4VkYpIcmAb67dV
         UeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694728951; x=1695333751;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKu2BiEqWVNgrZ/Ftcw07+PpV3txQ0t+R2grgO73Ekk=;
        b=FRDxDkd0iqVu4TAOc6S01R5tjsupOfITwI+jyPMg90R3hOueigdSEaPQGL5uGxONVN
         XW5KyQqNXEEOqoNwHtH9MbAcpqNXEiVa2saODcfaJ+QXMGgQnWHx+CSDB+3qJtpjqpeJ
         7+JuGqoBWak6y4YGWWbviblmW7SSn7zGqjOLZFL8QvkqUoa8EOtDs1PmjF8qysi7LDF1
         KDVogAQgEiNyK+D+36zaiXUdRDOp2sWfteNeL734bvVba8u7ks9YrXTyYH0b1WbAma06
         UwQ/aiaWGBiUS8pIqxlkeIPE65qDdAW69Emna2mjekQVSmsCjGKTA5Iq50a0WJdnyN2d
         ni+A==
X-Gm-Message-State: AOJu0YwJ9LIHOyS3Zs4Ma2ZDYNvRebfpoz6EQXjEnK++dlZAh52iPX9c
        toj0yKeBSQKfIzf5wrDt7RhyIGJZAP8=
X-Google-Smtp-Source: AGHT+IEF3Ei0fxcHYm9ZLoDfE/g+6sy7ZKKeRzQzROFTGIt+Krd80/kSwCaR/FdgmjjCiibNrCkr8A==
X-Received: by 2002:ac8:7101:0:b0:416:e391:1cf9 with SMTP id z1-20020ac87101000000b00416e3911cf9mr2881608qto.44.1694728951063;
        Thu, 14 Sep 2023 15:02:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.255.83])
        by smtp.gmail.com with ESMTPSA id g5-20020a05620a108500b0076ef3e6e6a4sm772800qkk.42.2023.09.14.15.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 15:02:30 -0700 (PDT)
Message-ID: <650382f6.050a0220.bf2af.3fc4@mx.google.com>
Date:   Thu, 14 Sep 2023 15:02:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2353996213075293740=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: L2CAP: Fix leaking l2cap_conn objects
In-Reply-To: <20230914211133.3339473-1-luiz.dentz@gmail.com>
References: <20230914211133.3339473-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2353996213075293740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=784344

---Test result---

Test Summary:
CheckPatch                    FAIL      1.36 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      34.64 seconds
CheckAllWarning               PASS      38.21 seconds
CheckSparse                   PASS      46.51 seconds
CheckSmatch                   PASS      117.13 seconds
BuildKernel32                 PASS      33.76 seconds
TestRunnerSetup               PASS      518.75 seconds
TestRunner_l2cap-tester       PASS      30.61 seconds
TestRunner_iso-tester         PASS      58.41 seconds
TestRunner_bnep-tester        PASS      10.75 seconds
TestRunner_mgmt-tester        PASS      226.15 seconds
TestRunner_rfcomm-tester      PASS      16.41 seconds
TestRunner_sco-tester         PASS      19.73 seconds
TestRunner_ioctl-tester       PASS      18.39 seconds
TestRunner_mesh-tester        PASS      13.67 seconds
TestRunner_smp-tester         PASS      14.52 seconds
TestRunner_userchan-tester    PASS      11.31 seconds
IncrementalBuild              PASS      32.15 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: L2CAP: Fix leaking l2cap_conn objects
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#88: 
Reported-by: Olivier L'Heureux <olivier.lheureux@fortrobotics.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

total: 0 errors, 1 warnings, 0 checks, 88 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13386062.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2353996213075293740==--
