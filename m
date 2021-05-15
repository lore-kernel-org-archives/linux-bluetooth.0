Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37ADC433B4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 May 2021 01:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 763F5613BC
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 May 2021 01:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhEOBls (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 21:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhEOBlr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 21:41:47 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17E9C06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 18:40:34 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id o59so594418qva.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 18:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=J1g1bZKJHsoDrkcldV9zzobk7cIHsGAlsrHjgw+udno=;
        b=S2BpMrDvNKxBz5vHyL1YgIudH0u9lLIRNvmvAQftT7PwY+rhZZ7lmTCNSFSglA3j2X
         ej/xKYYlwAsqDR6cHOQVxcH6gXhKn4vnuc7HXoQJEcp817igI7vLPx32K5mHh1vKblB6
         m66MErZpUyWTcv8XeO5wMBF9VTgkQqZ1BSU94hfvjXtRVLAwY9LPfMeSOjySdFRnhUE6
         cKWqH2OgKWeo1LrbBSWzfZfRLwmaobVhhRjBPZDoCM22IdE1nphmS0zDKlEyoajbiHwJ
         pWvUQiR0QfKZ+oDaXGUnbcmXDTDmubcqnkHfEUXDRV2kaGORyImRFkGAl3ztlxquDW2p
         LRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=J1g1bZKJHsoDrkcldV9zzobk7cIHsGAlsrHjgw+udno=;
        b=W+e2Fwk89Y96xEbzvRYzaOjzmx7DvA/GK35GQ0UnQrNUqdT3eWR5VdF09QmQjaBWd5
         xyd3tFVQI7CtSC/Qo/rG8Numa3R51o8H7f71DY7dOwPaA20f4vHCc4zBc8jFYczw0o7q
         tjxBbZMaDgxZ24Pj6SXZ73xjggnmD1DlHwmpUeqTc1NuOD7PMZlIEbSOcShesFvCPUTL
         gc3bJ5P33SEgA3zB1HbrHbOXF5oWozM2x4Dkpg7qJLLkVRJp11bAT1XSdc0bCOHfoHub
         fRVHwWSV+PiOECXvsD3rygYn6d2H//IbnD1sZfgv55c5CF/5K9qkrccQ/zHGAbvDaxSP
         /ndw==
X-Gm-Message-State: AOAM532U6NVE9EIIEyZY0n/jGDFDtkv+68sfl7wj0rKGm3SZH+jWDtDR
        huG12IAgwKgP0jwUhnAi4JS/v5PYlWY/aA==
X-Google-Smtp-Source: ABdhPJzkE7rz/VtEsXyC9cQ1zYb4StWitl/kNQmaN8dO2dCYoJwBAdN9tcD2Byue7MKdlt8SLQxREw==
X-Received: by 2002:a05:6214:d0b:: with SMTP id 11mr21670323qvh.46.1621042833681;
        Fri, 14 May 2021 18:40:33 -0700 (PDT)
Received: from [172.17.0.2] ([137.116.80.48])
        by smtp.gmail.com with ESMTPSA id b8sm5880763qtj.37.2021.05.14.18.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 18:40:32 -0700 (PDT)
Message-ID: <609f2690.1c69fb81.a9bb9.7a94@mx.google.com>
Date:   Fri, 14 May 2021 18:40:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5613422146471232727=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client: Fix advertise broadcast
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210514235854.143010-1-luiz.dentz@gmail.com>
References: <20210514235854.143010-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5613422146471232727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=482855

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.18 seconds
Prep - Setup ELL              PASS      49.72 seconds
Build - Prep                  PASS      0.12 seconds
Build - Configure             PASS      8.58 seconds
Build - Make                  PASS      210.40 seconds
Make Check                    PASS      9.74 seconds
Make Distcheck                PASS      246.39 seconds
Build w/ext ELL - Configure   PASS      8.87 seconds
Build w/ext ELL - Make        PASS      201.20 seconds

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


--===============5613422146471232727==--
