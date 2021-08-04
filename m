Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188D8C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9D460F56
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhHDEqf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhHDEqe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 00:46:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF81C0613D5
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 21:46:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t3so1663068plg.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 21:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=K3HCsokFwC1BTT2TIIVQjOKdrpuzirOisfZGV3eZ7kU=;
        b=ohmvWd3VI/6KLQABeuGRSTdBYekadCZpEl6/GliqY8N6GS66HjUnDAkD/JbPM8CzRn
         R9/Zoi2GoeariHJY0KwzRNvUhFAV4tx8RmjVQLMLPQAv7nGq3CVJMXquelfW50wRVTsg
         TaM20xYQaFZrCVbmB/tHSDi52PGfXralTwierF0Y/8V4Ujv2RA6NwFZCG3ZshBLCRmdp
         RCi6v/VegFv6P6i3GB4yaXJxCCKTeoasKFuJXrQEnTAiGrT870YtyqwyGFPMV7CZGys7
         ixTtP3Aln7hjng2P4J+yc3B+Ws1TJ8VWNVjPtFHvSkJdSO2ovGArXwJTPI9dincXZFKD
         weaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=K3HCsokFwC1BTT2TIIVQjOKdrpuzirOisfZGV3eZ7kU=;
        b=XvHXgvN1+dtge4Q3TlL6AeLLavVLrQpgbKweCzHT+uDGjMO3zn+ppxk3qduUceAzsg
         7dLwzfLqBNi+sKZgEzLMBlvwW4CI12wFhMtukZ0+3C2xx3f+64QoPASAbjlMigcaXnNL
         NQ/AAR2AMh80Hl3CBVurvubdRE+V2YKTK8/heckda02XMQW51YoBDTF2kkqJoOFpg0hq
         FUGJNlZQptjUy07p+Mc3niCQJeCfNDkhclrJrWuD/C/kdirlPCJ2BA02eNfqcQPY/DQr
         up1xyKYaREKfyGiLgkQHcG0WmcqWymkaWtax7eSVhRFWD8ehL5mZ247xGdeSgarqw32A
         nJ6A==
X-Gm-Message-State: AOAM531s0jBYro/121wsX4qMubr5ccowyQnp0y+QFnmz2d15u6fS5yBj
        vyvmYo+pjWN/mJ6Pnt1b9aoF++Ytons=
X-Google-Smtp-Source: ABdhPJwkZz3ArqAKpLfKu349QzUorHDxBXW7x1h6o9MEqlSgXfz7k6Y9ART4tCOBQGADfRbCJnQnyA==
X-Received: by 2002:a17:902:ab4a:b029:12c:4a36:1561 with SMTP id ij10-20020a170902ab4ab029012c4a361561mr21571901plb.8.1628052381005;
        Tue, 03 Aug 2021 21:46:21 -0700 (PDT)
Received: from [172.17.0.2] ([52.143.119.44])
        by smtp.gmail.com with ESMTPSA id y67sm850127pfg.218.2021.08.03.21.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:46:20 -0700 (PDT)
Message-ID: <610a1b9c.1c69fb81.82c8.3c7d@mx.google.com>
Date:   Tue, 03 Aug 2021 21:46:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8459405247527863619=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alexhenrie24@gmail.com
Subject: RE: [bluez] btmgmt: Fix misspellings of "Toggle"
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210804042008.42404-1-alexhenrie24@gmail.com>
References: <20210804042008.42404-1-alexhenrie24@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8459405247527863619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=525991

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       FAIL      0.13 seconds
Prep - Setup ELL              PASS      51.00 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      9.15 seconds
Build - Make                  PASS      226.69 seconds
Make Check                    PASS      9.05 seconds
Make Distcheck                PASS      266.77 seconds
Build w/ext ELL - Configure   PASS      9.11 seconds
Build w/ext ELL - Make        PASS      213.89 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
btmgmt: Fix misspellings of "Toggle"
3: B6 Body message is missing


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


--===============8459405247527863619==--
