Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA50EC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 19:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C49A613BF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 19:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhEETNN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 15:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhEETNN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 15:13:13 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE1BC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 May 2021 12:12:15 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id v20so2655980qkv.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 May 2021 12:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=fvtgPaCuPFVOT8uFn5TWcQhqI6KzPKR1HHHseEC9ErM=;
        b=tSR95dXM4FRQebseampGeuZnjHXUj8f4EmxvuA8McuXsi2p4TuV1t3tP6Nby/ZISZg
         afYbUxbrObwfqOH6tGwoD0XD7OqHm5sAh1Kk7AGW7+3bB9a1f6L2aFVk3k8sBbY31bgV
         eq0zU+vkYXYS+8oSSSTOZ8pW1Ze1c1c2Kj+El9eykmi3uzq0j3NuDRRGaStIxi7k/51A
         fW5Ms9Omoq3P85OZaCA4q5fs/efbiVZR0rULksog2GS7spwh9vnljqgmrYobeTIRq4jv
         AuyER2Un4WKW1Qbf/Z55Z0nE6vDrn0DHYWtTZWoFsXNJn/+gWzy6oaTZvTTeGEYdGz6M
         KHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=fvtgPaCuPFVOT8uFn5TWcQhqI6KzPKR1HHHseEC9ErM=;
        b=ewbEnxTmY3/hR9uD5svIlIjJ78ZBBU7r3Vkhfr4WjDK4Do6eM1VEDCB01QD84MZwE0
         451FfbRjqw38/jejYKDPRBv/Rad3DAbYtrxNvLiPQn94kjp1BSIKuOqpoG8npmnKzgl+
         KydGAZDMnILl8nwxmSsn5LTqnRJMcX05m194bvJsgICk1rrCWg9so0U7+rECqTjXhbTQ
         tjwulxR2nnve3Lha4SGmpB5MVo7ZnQ5dn/r3t5xj7WBvzpVs92J0tITHbwHJ9vtIuA1v
         Pak1imtubsCED2Fa1tSKGIjYvuDfnN0p+zxF7tEFSHAOIqzdiHLiJ07B3l68uDfVZhdb
         d6Fg==
X-Gm-Message-State: AOAM530XPqse9dx7Td6qrEeeoKeW5+4d4SWrQbHlQCCmxNPApoi28sZE
        SuT6CBjiylYsjRrHm5DFsuDKMXiiwhPMmg==
X-Google-Smtp-Source: ABdhPJwlkLMo5H+6VigSN5VoLRYK3GXQrABrzZSKAaA/NAmsL8fNd2VEVF06lnCLX5CfbrhmUK9vXA==
X-Received: by 2002:a05:620a:1678:: with SMTP id d24mr231352qko.317.1620241934527;
        Wed, 05 May 2021 12:12:14 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.53.121])
        by smtp.gmail.com with ESMTPSA id l16sm164339qkg.91.2021.05.05.12.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 12:12:14 -0700 (PDT)
Message-ID: <6092ee0e.1c69fb81.f2cae.13a2@mx.google.com>
Date:   Wed, 05 May 2021 12:12:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3624753075192347235=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,1/2] gitignore: Add generated files to the ignore list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210505184405.1077111-1-hj.tedd.an@gmail.com>
References: <20210505184405.1077111-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3624753075192347235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=477477

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.27 seconds
Prep - Setup ELL              PASS      52.92 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      9.25 seconds
Build - Make                  PASS      231.00 seconds
Make Check                    PASS      9.59 seconds
Make Dist                     PASS      13.58 seconds
Make Dist - Configure         PASS      5.69 seconds
Make Dist - Make              PASS      92.58 seconds
Build w/ext ELL - Configure   PASS      9.32 seconds
Build w/ext ELL - Make        PASS      217.51 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============3624753075192347235==--
