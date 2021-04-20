Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB0CC433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Apr 2021 22:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D86613FD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Apr 2021 22:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhDTWRx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhDTWRv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Apr 2021 18:17:51 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3AEC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Apr 2021 15:17:18 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v3so42517912ybi.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Apr 2021 15:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/P2si4bYf2PFXY6JboE2R231xS79klUOPxwRu4oCHk=;
        b=HgTbI48JmgssibahBDXFN4718B3pFNOpdNgkZHJWYGcRQa8LDY+iGtd5/prtBKtYdN
         WM2Xin2XZlTYlIIFPW4FyORgpvocPbpCfgldSujWv/cr2AqirRre+bPpVHPU6Vv3JhxD
         l0dBqpz8n0qONR05vt/YBj4OxMdhagsoNwlxEJ2ySHppasDJwvmMGY3VTX2yp0dvkoS6
         5PG8k12xC4hlAs0so7qmphcFv3R+9MUropDzJz754m6nbJmh28cf/CvOZlzx3wRM9+YJ
         s/R2z4475jAoDgOhgOWBiLRfOcSWyLjUD0hk5rFTuHd8Rs8MZpe/hTmdqgKBkX/t/CVe
         7jzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/P2si4bYf2PFXY6JboE2R231xS79klUOPxwRu4oCHk=;
        b=mXBj3eKT+ngJwW9RURD14LbyHizsxy0F3lZC4K5F3jrxh/qNI4S3+WUWqz7cmkSkkG
         /hp5bZY81W3XHHWoM5z8NODpAMirx0kUYv1jW+Bnstq2NN3z0KmKjdgCU7IQM6y7fF1B
         4+vGKuq4AM+LiRlD1df2Iev8TCWpofI6lCjrxJMdEVy9VAUZ8JL2y+OZ/d/UTN3+kHSW
         JoYy3I2+3V/v+E8ZuTp2x9rFtrU7c/AZ5bAu1sHFWjH7c+WLG+K/a7Ie/PugbUimyhjc
         7PPlj1T5WHN1tLLUvXz+ytLwst6+/+TcRW5BWDQi0tDDWlkYoXLELeeUbu3VvtjTS11j
         llvQ==
X-Gm-Message-State: AOAM532eL9ApMsMY/fBjE8rGQKNnm4XpsVRJBTGEQ8/75apzQUGRgAwR
        RqsXe0I1oUJ9icEzT1luAWaWtphC3QAWQDqca57PT5bw7GE=
X-Google-Smtp-Source: ABdhPJwBoQGJZS4Mbo3Amo9NeDhM0Wn6Yy3/4RJgLUdNgr85YZbvXcRe6+WzvH+Ryqyh/D3vc1BBGs+/JhOqgOCl63Q=
X-Received: by 2002:a05:6902:120a:: with SMTP id s10mr7366252ybu.91.1618957037327;
 Tue, 20 Apr 2021 15:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210419182149.712000-1-hj.tedd.an@gmail.com> <607dd135.1c69fb81.e26c5.62f4@mx.google.com>
In-Reply-To: <607dd135.1c69fb81.e26c5.62f4@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 20 Apr 2021 15:17:06 -0700
Message-ID: <CABBYNZ+OFW3CT19MMW7wCa2FiErP1a6iu_RMpk6LgST=8=qOHA@mail.gmail.com>
Subject: Re: [BlueZ,v3] monitor: Add Intel read supported features command
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Mon, Apr 19, 2021 at 3:15 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=469821
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.40 seconds
> GitLint                       PASS      0.11 seconds
> Prep - Setup ELL              PASS      45.05 seconds
> Build - Prep                  PASS      0.14 seconds
> Build - Configure             PASS      7.67 seconds
> Build - Make                  PASS      191.17 seconds
> Make Check                    PASS      9.48 seconds
> Make Dist                     PASS      11.11 seconds
> Make Dist - Configure         PASS      5.18 seconds
> Make Dist - Make              PASS      78.79 seconds
> Build w/ext ELL - Configure   PASS      7.70 seconds
> Build w/ext ELL - Make        PASS      178.80 seconds
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
> Test: Make Dist - PASS
> Desc: Run 'make dist' and build the distribution tarball
>
> ##############################
> Test: Make Dist - Configure - PASS
> Desc: Configure the source from distribution tarball
>
> ##############################
> Test: Make Dist - Make - PASS
> Desc: Build the source from distribution tarball
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
