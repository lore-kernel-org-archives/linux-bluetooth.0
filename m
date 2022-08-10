Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6EBC00140
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Aug 2022 10:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiHJKCT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 06:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHJKCQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 06:02:16 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E86D9D8
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 03:02:15 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id d4so8001334ilc.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 03:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=MFfiZLE5P4jlCiWDUeXnF2ssNthvQWx4IdS4+OZXZPg=;
        b=EgW3IjNE+m1Tj5fI6iA6WEj1bB+vaHFbw0idAVvUgcBkqWw3Cd4rAzt1lROh11UPsx
         j2ztZfu9fWs+WZqe2EntifavgrgUzNrR4ViceZsKdD5CljF72A6euzbs3EbJiCkG0C3S
         0l2F2QnxPslRqVL76le+Fg2mAxaq9h9FtwgDkqTYeVVtv4W/X45dZfV25eJax/P4xp1e
         OuC2YZClhNMnLlO1CYzNF6X6lwbPrut6C/b4Ic0Radv/tzCaoQW4aSsrAQqDNngAVAsm
         yFWC3VBhO7A6MhiL4WEbVcNa4fW8B76LCXPO9LyqrK/yaJ9yMSKfqlrGX5WPS9um8siO
         53eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=MFfiZLE5P4jlCiWDUeXnF2ssNthvQWx4IdS4+OZXZPg=;
        b=fqxuYKczFgV/RhRt/znDgm5UGCMWwcyah1k7HdNz6iJJGinoQ7z9ZY5J9s4wYSKQtI
         Dh6EI09ThGf9crsz7NgvxZpMEi2pc3F6TiZlYo1d8l7NS9v444sBJaw0ziRdBfhD46GV
         UrulU6oNURfv6YmnmvbyFuaiTbgP5W10En0TusXzeKk9vglVOB6byh/YSR+6NQI84/9a
         sNHkNflH2enQWXMlhw0wHBvQVO+cyRKYdmxiyXy1hpTJchf1HThQRLl1m0j1Ys3ZfQAX
         au2hiDmFIy7SYs9i6cXTufm1zi80wMImeurfaJgK7EDVxxo4o26vvfGLFBWyq9pYrS6n
         Efng==
X-Gm-Message-State: ACgBeo2HMXnzq08c80T1A33zhuqJHDPDjt7rzhn1zfDZa501Tb/bLjp5
        D64FFPEPyoim8JJG42qeglx1h7x4X6Q=
X-Google-Smtp-Source: AA6agR5W5USbsi1lwjr53Q2v8yQZkvipGZyFAAzFs2QOmubKvL7LepBSmRWhryDGCucHQGCRmccEzw==
X-Received: by 2002:a05:6e02:b26:b0:2de:b192:9dfc with SMTP id e6-20020a056e020b2600b002deb1929dfcmr12623433ilu.273.1660125734310;
        Wed, 10 Aug 2022 03:02:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.12.235.254])
        by smtp.gmail.com with ESMTPSA id m14-20020a026d0e000000b0034322c00433sm2414980jac.53.2022.08.10.03.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 03:02:14 -0700 (PDT)
Message-ID: <62f38226.020a0220.2cd53.3554@mx.google.com>
Date:   Wed, 10 Aug 2022 03:02:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0457209846440899381=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Bluetooth: Honor name resolve evt regardless of discov state
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220810164627.1.Id730b98f188a504d9835b96ddcbc83d49a70bb36@changeid>
References: <20220810164627.1.Id730b98f188a504d9835b96ddcbc83d49a70bb36@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0457209846440899381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=666528

---Test result---

Test Summary:
CheckPatch                    PASS      1.28 seconds
GitLint                       PASS      0.75 seconds
SubjectPrefix                 PASS      0.61 seconds
BuildKernel                   PASS      34.64 seconds
BuildKernel32                 PASS      29.78 seconds
Incremental Build with patchesPASS      42.19 seconds
TestRunner: Setup             PASS      488.42 seconds
TestRunner: l2cap-tester      PASS      16.73 seconds
TestRunner: bnep-tester       PASS      6.27 seconds
TestRunner: mgmt-tester       PASS      99.81 seconds
TestRunner: rfcomm-tester     PASS      9.64 seconds
TestRunner: sco-tester        PASS      9.39 seconds
TestRunner: smp-tester        PASS      9.45 seconds
TestRunner: userchan-tester   PASS      6.51 seconds



---
Regards,
Linux Bluetooth


--===============0457209846440899381==--
