Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D015C47080
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 22:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F6460C40
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 22:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhFAWEZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Jun 2021 18:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbhFAWEY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Jun 2021 18:04:24 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FC1C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jun 2021 15:02:42 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id b9so869742ybg.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jun 2021 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWd5tOx25DS1GcUXZmHbSMx2WpxtSVAMAqYI53I0p6k=;
        b=ShlWH/xkG4ni6HPac15OrVHY6fNuZBH02O3TfhhlxQ9BsnHk+4MEHElzW5+svKcvPb
         xu+D1uywe47sdvVWkcDeRZXqJ4ElDY+tadFDWqTjHFdkymAhnSJ+4m0Ahz0kySxFgP1V
         1TRVYLvrpCMuTX9o7Oc0tijQdDyPBrlkufkOW00WQZvmRniDS/nELMAmCFW4157mj7NX
         UuxP1TdUgQbJ4Ij2CFAH+P+HMv2tHnl/TyZjzoL7U+nfj9HIAOZ5tIz9XBI1R7zxFxoa
         YoqqTfX4V6rKqCiF3Qrjv/wbPmMOv4oBVHv+atMwsHUhaoEpui9ce+IoeMssEWNa1AGQ
         y0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWd5tOx25DS1GcUXZmHbSMx2WpxtSVAMAqYI53I0p6k=;
        b=tH+7kyr5JjeXwJ2fAbMPUtgpTT6SXriH86xorIdjxHg6D3wBE7CLRDQtUnjR4SA8aj
         saFjgqMO/fd4o5n7JB53gCcv88JRG0DZWDZvUsfiOtDXwhFrbpDbkd53nBDgjDemQ82P
         YmTd9mKv2eNXLJzJfo119OqdOnkAHMw1fpdj3I8Znokc/U8u7/eIavF5Ie8ZPejrk80D
         qsISzgjhsoHazsWGLfbQI7P2BF9R51jiTCACS4Ec2EEnFrd9CzdM4kikntJYfhUIzgzr
         ZCb3ybJO1vbYqTY5Chv/v69ppkm5Sa1qOOf2JX806IGTg7FfqsiFC1/xKS1TCdOyjaSn
         4XNg==
X-Gm-Message-State: AOAM531fLXvyh8YyrXVG14AhtNU7mpKhAbOVO5blhLFYSMbmI4MI8b74
        95hmS/byKSd2YyUOu1gMAjPKiHH1pqdFC57m2XyoH4r3
X-Google-Smtp-Source: ABdhPJztqujI/iYsHOY+A2gdV/uYzeySd5XVMW6LuAwc+xnZ/NcNqnC1rjDPRGF3jkrPYTqCQ/oPjnOeGJUbCiuJ7MI=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr44315626ybu.282.1622584961162;
 Tue, 01 Jun 2021 15:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210601204918.903327-1-hj.tedd.an@gmail.com> <60b6a27a.1c69fb81.bf667.fcf2@mx.google.com>
In-Reply-To: <60b6a27a.1c69fb81.bf667.fcf2@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 1 Jun 2021 15:02:30 -0700
Message-ID: <CABBYNZ+RfMTjQcXve2ULjvmSaiWa8Ci6sfeNJkb6ZiSg=TBiHw@mail.gmail.com>
Subject: Re: [BlueZ,V2,1/3] emulator/btdev: Enable LE Privacy feature
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, Jun 1, 2021 at 2:19 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=492061
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.23 seconds
> GitLint                       PASS      0.32 seconds
> Prep - Setup ELL              PASS      41.15 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.20 seconds
> Build - Make                  PASS      176.25 seconds
> Make Check                    PASS      8.86 seconds
> Make Distcheck                PASS      208.06 seconds
> Build w/ext ELL - Configure   PASS      7.32 seconds
> Build w/ext ELL - Make        PASS      166.59 seconds
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

Applied, thanks.

-- 
Luiz Augusto von Dentz
