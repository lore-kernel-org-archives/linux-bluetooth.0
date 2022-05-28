Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA909C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 May 2022 02:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351288AbiE1Crd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 May 2022 22:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiE1Cra (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 May 2022 22:47:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5D0C3D1A
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 19:47:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q18so5638563pln.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 19:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6c0bAkRG6Gou5iNlcHX7qCQVZYeyHfDLfxzqZWxmBmA=;
        b=K69kXanl8+Qqu08tiHqs0hAePYFkFRAQeVKZB/P+9DIy62atFGZJG9nw5UUk/xlB57
         60sVF37z4QwfdjmDBzyt7TuS4eyvDGpK11ESqwJYq1tINCSy7MiROtu+VEb3Khbu7Ypf
         hJ/a8GGBONLiklUwyR5SbIM2JTF52Av001rss0HDgTzeHp5H0auYmhaSqTiUXMPGfBzj
         v3ezfxdSjgB3a8yWn/UbQg86bqHD0yNptg6eQ73QNwUOBoYrua5EZm4Ol/KYMMd7atf1
         FGFOKYp/UkwlMxMdUnAd48Dqv9QeAeFOFzy781+2kgI/DfM5ovDhuUKVvA3CT4cWblwO
         TUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6c0bAkRG6Gou5iNlcHX7qCQVZYeyHfDLfxzqZWxmBmA=;
        b=ZvetuI3wag7LatWVMnf8jbQqbf2yBwgZSuTEJIlutYwX18ko1U6jbZFYpRr4MU+OOT
         VPZMpRprXEwtfyi5gsRDLwwEYbfdx5l3m1im5FzZiTJp2FoXYjARm5+OsUbr6e880SHl
         RkvYNLadVtdyQ+EwiG3Q847QQGlJJKSn0sJZCV0Kh8MhtB3BPJtyVqS+dfrcuJOX9NmM
         y1ALnTwBWe3aq0noEWvEC8AT+Qq3P9wy1oOyr6zQDt8Ghe9aRg8njZLoLTVrdcCPR/Ot
         SvHtL2jCosT0UGCbL1ZRZhInW4Tnoet6CoanyuSwuBVhUgzgcw8Iy9q4YmK+JS65BLHi
         C9Ew==
X-Gm-Message-State: AOAM532pR8Fsm4BXQ9huGtDvJpAk/MxSnIbquNhQzDcH+SXVGW1IQXSA
        f3mRJnmjIDuF6C/m4/jPBf0qOIAn7Bc=
X-Google-Smtp-Source: ABdhPJwI+JIdS6E30IDd24VhhHfR5gr7fulMrhxW6zuvXAI8LK01lzkd6AnvbZ6PPS2URYe2j732Yg==
X-Received: by 2002:a17:902:bf0a:b0:162:201e:1f49 with SMTP id bi10-20020a170902bf0a00b00162201e1f49mr28787353plb.39.1653706047577;
        Fri, 27 May 2022 19:47:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.201.52])
        by smtp.gmail.com with ESMTPSA id u135-20020a62798d000000b0050dc762815csm4264151pfc.54.2022.05.27.19.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 19:47:27 -0700 (PDT)
Message-ID: <62918d3f.1c69fb81.8595f.a623@mx.google.com>
Date:   Fri, 27 May 2022 19:47:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6133128926769502063=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [PATCH-stable,v2] Bluetooth: eir: Fix using strlen with hdev->{dev_name,short_name}
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220528003528.571351-1-luiz.dentz@gmail.com>
References: <20220528003528.571351-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6133128926769502063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=645709

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
GitLint                       FAIL      0.44 seconds
SubjectPrefix                 PASS      0.32 seconds
BuildKernel                   PASS      37.48 seconds
BuildKernel32                 PASS      34.03 seconds
Incremental Build with patchesPASS      43.64 seconds
TestRunner: Setup             PASS      606.84 seconds
TestRunner: l2cap-tester      PASS      20.58 seconds
TestRunner: bnep-tester       PASS      7.39 seconds
TestRunner: mgmt-tester       PASS      125.53 seconds
TestRunner: rfcomm-tester     PASS      11.44 seconds
TestRunner: sco-tester        PASS      10.94 seconds
TestRunner: smp-tester        PASS      10.50 seconds
TestRunner: userchan-tester   PASS      7.66 seconds

Details
##############################
Test: GitLint - FAIL - 0.44 seconds
Run gitlint with rule in .gitlint
[PATCH-stable,v2] Bluetooth: eir: Fix using strlen with hdev->{dev_name,short_name}
1: T1 Title exceeds max length (83>80): "[PATCH-stable,v2] Bluetooth: eir: Fix using strlen with hdev->{dev_name,short_name}"




---
Regards,
Linux Bluetooth


--===============6133128926769502063==--
