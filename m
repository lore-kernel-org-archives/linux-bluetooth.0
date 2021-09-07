Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FC5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 04:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829B9610C7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 04:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhIGEjf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Sep 2021 00:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhIGEje (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Sep 2021 00:39:34 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6E2C061575
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Sep 2021 21:38:28 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z1so11112782ioh.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Sep 2021 21:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xX2EaTUrIbY5bRyjU+7YfwK4QgNx0pXJ4LXKTqRoBy4=;
        b=ey1eiu+Jjm+MshmucjpMu7V0LFONCC0S4w97oOBeOhUq5wWlP82p+UdRXfRwmmQm1X
         vhdNXXa4R4SNpBLg8pQ8BVG8bpAlFweh7eWME72t6D0DAD+mfB1GLNb1dBtQSAFSjxuX
         POHKsWuyduaJ3sBXW1sErjP5dh2XfNJIn3gZkyz4N9KkS3iVGB/zZdmhXgUDRoDiVMnd
         rcutHMjljT9alI2DBKphmeD+XlBZj/ad+Qn3ZxKImDZZ+juaUnaxdJPAIGUJRNL9Egnz
         vVKd914/cVEkNLfWfqZwgAtmeeX6rYIvAz/qovilBgHgbjTqBiwwZ3YM7EUpbSEdM+K/
         5cXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xX2EaTUrIbY5bRyjU+7YfwK4QgNx0pXJ4LXKTqRoBy4=;
        b=SJwUQQy3WIov4KMfsrhPjO7fzZCw5fBHKnaJUHMj8QIKMk7+oUeiWpkBK+QAy7vsi7
         GaHYsTNNi1ujcFWc5+ADJU1tkwDQHTXpsRdH2Y4/NCS91V2kgnxpdqvpvPDa4zHENAF7
         OIRm4nClfmY+vDfDH3lr5t57GNFD/IR3CKst+ES9kv4yfWiNzEURBtS1uwe54zZAjqnG
         mjKZs6iTknPvh7H6wAu6Qoq/l6mT7rOBx0yyn2GhuF53Z5wrFwzVkwI26dVweD8svamr
         oKLciZMgPDrbRdZL1y0j+OUAkNXJ78VDhehK+gNernU5JilP/wRL8xMzexhhh4ZEswqf
         1+9Q==
X-Gm-Message-State: AOAM533xq3B9PsVKIUVX2lj6eySRcmzlRFZ4GxnWuxheFn2ovwTwP64w
        LAXNtlJmi8B9jmJHicXu7ilHz1eWbBs3IqjeVZZHlbSP
X-Google-Smtp-Source: ABdhPJw8JGwBdF5Hfxd5x6VLoUoS+8Z8p5nkLP+8OBlepe+rnaGRla/FmIHChvS3avC8mxRCQ4RussC++mM0+/ba61Q=
X-Received: by 2002:a5e:9249:: with SMTP id z9mr12607460iop.14.1630989507683;
 Mon, 06 Sep 2021 21:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210905154356.8296-1-pav@iki.fi> <6134f507.1c69fb81.343cf.76d5@mx.google.com>
In-Reply-To: <6134f507.1c69fb81.343cf.76d5@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Sep 2021 21:38:16 -0700
Message-ID: <CABBYNZKC4bd0ViN=Hmo8vKSEXh7JCNzuEQjK1jodcgnm70qGSA@mail.gmail.com>
Subject: Re: [BlueZ,v2,1/2] shared/util: use 64-bit bitmap in util_get/clear_uid
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sun, Sep 5, 2021 at 10:01 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=542233
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.30 seconds
> GitLint                       PASS      0.11 seconds
> Prep - Setup ELL              PASS      44.86 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.75 seconds
> Build - Make                  PASS      192.81 seconds
> Make Check                    PASS      9.37 seconds
> Make Distcheck                PASS      229.33 seconds
> Build w/ext ELL - Configure   PASS      8.02 seconds
> Build w/ext ELL - Make        PASS      181.60 seconds
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
