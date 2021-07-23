Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9368EC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 14:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5AC60EB1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 14:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhGWNv5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 09:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhGWNv4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 09:51:56 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7A7C061575
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 07:32:30 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id x3so1528592qkl.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+tWp1No06cfIZ716aVrqwQ6dOB/pfn8Q+DdUtmqaDi0=;
        b=QWKhJbRI5FuVDstialQ9Sqw8edy80V9Fwor2i1effgRSRa1cnuxalGC72p06FwrYg/
         0aoLKpl0SMh5SnzP6buGXohhhWPIwwPQVPcACKATctC9Lq9mbfkq1UojzfNnp8pyk5XN
         4BuR1kIAWStuDmIEJEBD7JPtY9PTZCOjfOshvApae1TLEBz2Lhid7zCB38LqM2XA7rTW
         5/gL46qAhlE3PD+Pljjf1afR5lkTyhfSEo2UT/GagVHZbGuU/dwcw+nKwVOSucrnsRK+
         BtRGLuV6hCF/r/xnrdHXqPwCNVvPUGW8Fi7My2nkzqJ/Gg8jJw6D33M1aUicWLn3cA4T
         6fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+tWp1No06cfIZ716aVrqwQ6dOB/pfn8Q+DdUtmqaDi0=;
        b=tnKLUq9CuAqY+kp7auZHC8ud7WxIxNtGeGcBV9fPXwOT3qqr2G5aTw4jyu0+AOJlGT
         XXuQpaW/6qAjQqjJN/Tx6k66mUai1OfpBwsFo7jdFd8IuogUSK8KzMI4H625gqCD8B2V
         tlxVhsq1tH0pkQGNLElc4MS5fJ5HEbRas11spuyR6wLyeYviNK95q1uJZwP7P9V89/rR
         OR8/Cn64AzUFISFzMN/A3vH7Bf0s9Vgw8HDxmknEK0+T7a0J1QWggBurMFzkuTmvpew9
         0chejd93Pxc6jDTq3PY1HZEPwiwrHvRZKq6DAUMgQ3EVJG0e2sb8ckQA1XBRqQv5qNo1
         wasg==
X-Gm-Message-State: AOAM5331fR7D4Y7q6hoiyqP+0F2J7sYz9IQMj6KdguAZbRtXFQXLxtvZ
        R07aALZU1HybwDn6v0oVbjCVC6k9lrmLTg==
X-Google-Smtp-Source: ABdhPJwDn+0Ocun33D3/Er/2JBo+LFT3/jEP+YbZYEHFQYXdNJYREjQ/pnIdUZa9JIARqfOHXADz+Q==
X-Received: by 2002:a37:4652:: with SMTP id t79mr4816189qka.93.1627050749326;
        Fri, 23 Jul 2021 07:32:29 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.71.48])
        by smtp.gmail.com with ESMTPSA id t30sm14098109qkm.11.2021.07.23.07.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 07:32:28 -0700 (PDT)
Message-ID: <60fad2fc.1c69fb81.4c2fc.785c@mx.google.com>
Date:   Fri, 23 Jul 2021 07:32:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2675257332697632981=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, me@dylanvanassche.be
Subject: RE: obexd: phonebook-ebook: modernize
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210723135824.8032-2-me@dylanvanassche.be>
References: <20210723135824.8032-2-me@dylanvanassche.be>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2675257332697632981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=520361

---Test result---

Test Summary:
CheckPatch                    PASS      1.25 seconds
GitLint                       PASS      0.38 seconds
Prep - Setup ELL              PASS      36.63 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      6.37 seconds
Build - Make                  PASS      159.94 seconds
Make Check                    PASS      9.12 seconds
Make Distcheck                PASS      195.35 seconds
Build w/ext ELL - Configure   PASS      6.54 seconds
Build w/ext ELL - Make        PASS      150.40 seconds

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
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============2675257332697632981==--
