Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A36C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 18:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2707A61002
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 18:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241175AbhDSSwF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 14:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbhDSSwE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 14:52:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C7DC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 11:51:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m11so23811152pfc.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Mf0wGrK3vcGnTqxsFER45Cloyezx7oyPKMM3azYSQKg=;
        b=Ch0aR0pb29BBv/e6hTldybSvMJqRDJ97cRrmjAmW4vB7qwffqFAaEkAbHSFbM0R8d2
         ldnNi312CJ4eGNxHbmb5yu3fM5bihqObz14z2zYtsPwkhFoKwBrx/+MKgilJk4VleX0T
         QMO6K9Uu7+wIifMZqZ2gc5qaBRCLM7Wgrk5CwB72Diyv3WwiJp1OFya8Erp62PyZtRhs
         qD+rY3+lC6074uBs0KIRrpZbE/PVZCKZNzJY81Q8ackbXRUYIdWNRo7D+UC3lqn3qG0F
         8e7enIKnITxS1NcLe7a3IMmHdtNDhnhQv/5s/XqsEdJXaJCWFCKN2n5jiKc/jt3i2n+8
         FqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Mf0wGrK3vcGnTqxsFER45Cloyezx7oyPKMM3azYSQKg=;
        b=WAswVNvHJi8x3CYlC5gAW8UWghYeCkua6P/1fr5Pr2qYMzg2mR6lo9I1hjyf2jbg36
         g0p3Xug5O6YPSlPpRb82dtHetFSCvyE5wfNEYg2+NE+D9RMRAxyo8k3ZRlG3sk+4DB5v
         MBCTE7cv9JRvyLzJ03PwQuoA5boFqg698Mnv7U8jOHpyn0qNpXmQVTy7XQp8MN+uAUJ/
         iv2GqhNkTmGyFr9uxSgoeTlOa0oaf84hpIeh2cd94dBl0licbUcHZtXOFkv89rzR4Vbp
         jJK/DWghLoWpTbPvAp6yu7S3dfenT54sRmRbsbMFTWptnt4uU9ix2HMIw7cI5nouqhl8
         bToQ==
X-Gm-Message-State: AOAM531yioHogrflt8oXcPGvMIpIAWGUF9ridplXitck5FO65T5ns3Qt
        7PBF1PMxtLKv8ORhpiRpl9PwjMCz1yg=
X-Google-Smtp-Source: ABdhPJye80YwaH7kXbIDe8fM9vleZgp7cycwpJ+LrxsynxVueANxBQBwaAnEDOLvfRZwhqvY5fibFw==
X-Received: by 2002:aa7:9e4f:0:b029:25e:cf65:c554 with SMTP id z15-20020aa79e4f0000b029025ecf65c554mr7596097pfq.66.1618858294317;
        Mon, 19 Apr 2021 11:51:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.233.76.98])
        by smtp.gmail.com with ESMTPSA id z65sm2513751pfb.13.2021.04.19.11.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 11:51:33 -0700 (PDT)
Message-ID: <607dd135.1c69fb81.e26c5.62f4@mx.google.com>
Date:   Mon, 19 Apr 2021 11:51:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0198711781943036920=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3] monitor: Add Intel read supported features command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210419182149.712000-1-hj.tedd.an@gmail.com>
References: <20210419182149.712000-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0198711781943036920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=469821

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      45.05 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      7.67 seconds
Build - Make                  PASS      191.17 seconds
Make Check                    PASS      9.48 seconds
Make Dist                     PASS      11.11 seconds
Make Dist - Configure         PASS      5.18 seconds
Make Dist - Make              PASS      78.79 seconds
Build w/ext ELL - Configure   PASS      7.70 seconds
Build w/ext ELL - Make        PASS      178.80 seconds

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


--===============0198711781943036920==--
