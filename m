Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A5CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Sep 2021 02:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A9761132
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Sep 2021 02:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhIJC1V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 22:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhIJC1U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 22:27:20 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31C2C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Sep 2021 19:26:10 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id u4so405862qvb.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Sep 2021 19:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wia2rdT2gxyKqemlhu1uGA6Hmj9Qqt1TlbSCz9UEZcs=;
        b=mBe5ajBFjJ2NfxHELCHGkExfWZI3rracNpF8LhCI1EL5vWK+fx6tQND2pKw4mYU6v6
         H+H9TtXtvoSWDAB66cEuze+Oq/nDsjMnBpp9c9YA37MuPQM4JBWar9r+Nzmwi9XHEb9+
         v3LOhPjtV2CAwTWEinxAG17Ye5X/rwFMnTWkVDnSSSiRSLFY17UbCOYFrK2HTlwUpDy+
         7OYKT7n8/Cx5XRxW0yzyiEMP/rcZk97kIOxCKbkTWrK7IeZc3sKyDVQY3XtKcj44mch0
         ZopKPM6RFyWhdIAqkhARLbIjMrqQPhDw82zHQ6Rh4OgKusvLRLUH9tiqhoSKmDFcONvL
         vnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wia2rdT2gxyKqemlhu1uGA6Hmj9Qqt1TlbSCz9UEZcs=;
        b=DDBl1+SbHlVSDnpV6G/R17S2+6X9KDS4ZIxGagTalOSoDuasqzYuHoUdI6VSWMZHZC
         Z9NHMRGA3B8qEEC1JZOrq6/em/PI0v9sh69UH59uWVZnNtXW0aHLo3lRpWcBH0Gdmyzh
         lTsXAuZhXRygqIUfj1/oOBWsQLkwmHquU1Eot4gxotIXmTH7E47KZvtF/JUQiqGQLd7B
         Bq5mrBC/ks4kVprLXlPrCC43IEqFM2bKpUN5qb9WMpAYSm3GDcSrSw2lHeEFuHapLIRv
         3uIUq+GcN8EKiXDXA0PQf3UYCVDVpKO38mHtjWgW2hbFnkD2OLgLR5ckekjAbeII9/E/
         NmRw==
X-Gm-Message-State: AOAM530Ca1p4fGH4jMznEmritRIb8ePGKRKHC4lO0OcEfSyaRSiRAjcv
        MJlvUAi+YBem3d3vZJQylAXfWfyn6638Pw==
X-Google-Smtp-Source: ABdhPJxMeXgN1S1jElhwMBgg9vbPCUmHBgJT6j2+smfuFVTRUVN4bLRhlDIn+Irg+ny+aousTG+EdA==
X-Received: by 2002:a05:6214:268e:: with SMTP id gm14mr6196897qvb.51.1631240769793;
        Thu, 09 Sep 2021 19:26:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.20.141])
        by smtp.gmail.com with ESMTPSA id o7sm2300017qtw.87.2021.09.09.19.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 19:26:09 -0700 (PDT)
Message-ID: <613ac241.1c69fb81.47b0f.0176@mx.google.com>
Date:   Thu, 09 Sep 2021 19:26:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3292554232790421458=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [BlueZ,v2] adv_monitor: Clear any running DeviceLost timers on power down
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210909190503.BlueZ.v2.1.Iae4b26a8036d47ca4d0db470f2bb23247f6cac7d@changeid>
References: <20210909190503.BlueZ.v2.1.Iae4b26a8036d47ca4d0db470f2bb23247f6cac7d@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3292554232790421458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=544689

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      36.89 seconds
Build - Prep                  PASS      0.08 seconds
Build - Configure             PASS      6.37 seconds
Build - Make                  PASS      164.22 seconds
Make Check                    PASS      8.91 seconds
Make Distcheck                PASS      195.81 seconds
Build w/ext ELL - Configure   PASS      6.89 seconds
Build w/ext ELL - Make        PASS      156.41 seconds

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


--===============3292554232790421458==--
