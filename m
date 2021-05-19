Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70734C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46719611BF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhESSDy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 14:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhESSDw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 14:03:52 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B3BC06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 11:02:30 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id n4so789574ybf.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 11:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nkThnXx2iBY/T18GixunCNqIyeVOtf2seSQHxbS8F1k=;
        b=cVFifWs37GbqKQQtiNl5NmdZHZib9bWxp03wxIPqHqpW5f/Tbw9oggP+gXnwMFVojX
         JCW+bRDFFQTboj70hWJr5M4s+zZKaP8Jtk36/+kewcVMdzKkwkCaxfnEbsDeWldRHNbr
         yJGiHf40qHF4pdAJ1fhAoXPVcIisxXGupav2QO/H4o4/9CA9ofNZ6Ay1rTBJjwmXbsK1
         B+JrYnkaKJbnnSFSpWDDeDajvfb+EZCCkOHLcHwiRsE7tCrBj0EBhcAO3KQiY/zjw8i/
         kCZxKm1qMFgAsU5Hwv47pjhv/WldRg3HXdL5T5ZYstLPSIb79SeQJpxx2MdNE6hCkypr
         H07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nkThnXx2iBY/T18GixunCNqIyeVOtf2seSQHxbS8F1k=;
        b=DE7PpT8Gjfb67eH4cd9k/5RvPV748wUBen0RAlbBuaJQz/mW/ht8+3Y/weXBrHY2h3
         +jdY8Byx9+CPmfTGSLCas3ACq1cfd3R0N6Nmnb+qQZ17ySANE17wBdI3p9hM1KjCTjeO
         n7TTFqNFPz0JjQdDkpuIt+mT7DmeS1xzf69lsYcCdZJkZWzJZIORZHHWTZXzPMeyjiB2
         qtbeaUzkFE9SsINnaUU+HVc1YDSP1mazp1rqKlc2XCobSm120cNxXUzkDaFZfQCmugSw
         +928JMPIfyKGvLfh6c3XuA4cYPVBjhZ/ZO+W3TCHuFfsvswXQU+Hvl7er64UqxBUORok
         sOJA==
X-Gm-Message-State: AOAM5326v//GQb2dtIgM1UnYVrg/fbKgEKx6vg3azvfWM+85jlCTWaZg
        HWhk2lX2LLIrCougiBjwkJ4PODEummCw4glAFiK21uRd
X-Google-Smtp-Source: ABdhPJz2et6Tw/FIPiIexa+aiGl9m3Qe5kERc8nfw6L0a95+MdPMFtjZaJN/tjx8Qrwz/inACMTdkDCRcqoYfFtOsdo=
X-Received: by 2002:a25:380b:: with SMTP id f11mr1141580yba.222.1621447349946;
 Wed, 19 May 2021 11:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210519005313.867382-1-luiz.dentz@gmail.com> <60a46c04.1c69fb81.54a63.6f83@mx.google.com>
In-Reply-To: <60a46c04.1c69fb81.54a63.6f83@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 May 2021 11:02:19 -0700
Message-ID: <CABBYNZJoMo3Q=fEnNaZQCE3Bv-9qeB7HxLiju4PE_wUV0rrZ4Q@mail.gmail.com>
Subject: Re: [BlueZ] core: Enable experimental MGMT when experimental is set
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, May 18, 2021 at 6:38 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=484631
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.45 seconds
> GitLint                       PASS      0.12 seconds
> Prep - Setup ELL              PASS      43.11 seconds
> Build - Prep                  PASS      0.12 seconds
> Build - Configure             PASS      7.59 seconds
> Build - Make                  PASS      189.85 seconds
> Make Check                    PASS      8.41 seconds
> Make Distcheck                PASS      229.02 seconds
> Build w/ext ELL - Configure   PASS      8.08 seconds
> Build w/ext ELL - Make        PASS      184.29 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
>
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
>
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
>
> ##############################
> Test: Make Distcheck - PASS
> Desc: Run distcheck to check the distribution
>
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Pushed.

-- 
Luiz Augusto von Dentz
