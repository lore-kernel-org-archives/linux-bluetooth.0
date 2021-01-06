Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53BCC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 09:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B07821D93
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 09:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbhAFJsD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 04:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbhAFJsC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 04:48:02 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6D7C06134D
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jan 2021 01:47:22 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m25so5118674lfc.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Jan 2021 01:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVbuaOe4quZ/LrVooKH17Ulqbxk3AuggFARrX6RfARU=;
        b=uoTTyziPTjwbMOmI+iHZnObcqTu2bMZVQ87oJJBERZ5iA6v6AhBciktpea+ibZwlNB
         nyXVLLpBzF67V+wEyBvBofbgs+rQd6QJ6AumBF8KqUGD5j2Ldhk4Z7iFBo9HIxP9WibF
         0YcwTFin15dl6ioy5mxnxNVRigAo4OBJOCt0lhu7APebyA0yVLRNbDyZZsgw3gMlEw5h
         lesuAIRVwqD/pmkUlFEvdwwqSfvDHx6/33/B86cQZ7O/SK1f2Zn4N4iKtDi3oJfM1PPg
         mI3Mz+DJ1uhIYm+kKLd5dJRjl8/fQJ/CKBJUZRxOuqF+xtwrmZEHHL1QaQ+DSLUlseEt
         xtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVbuaOe4quZ/LrVooKH17Ulqbxk3AuggFARrX6RfARU=;
        b=MoHJBIBsaJvc9fhVTNB1g5ewD3UK5gUng5wBqcb+PRo6sNV/F6rUoIISfHZa5XHS8b
         ixxSyMg6gI/kOFIRBuOKMv0/RdManKk0bFdTa6GoRmUo8mu1yqxw4TIPPuKWEk8U4Ido
         08YGC9zJXIImz4m5hAc/i6ZQNxXgBRx79xV2jHMr3ZgeqtC2/JWO8uqXfujd3g7Mf5rg
         /H1ST+Ns55lWsTdfFT7USvJWv/WVJshAaVWuo3mrQnYX0t9uoyYVCRBI9xt4LePvRVgV
         o52261//Fibu+b7ASHyb7tzbPtjrzw5V0u7TWd5i+f2dI5Hj80npHpkJgjE+qfVoGlpw
         utEA==
X-Gm-Message-State: AOAM531znh7rrKRwRtsamF1MBNpRu8V2gCSQfYw3NipmkOnEDy4o9jQD
        bkzUBnK6gbfudCG4g6/1KOiShFCzyt9ckhJFjgq/nw==
X-Google-Smtp-Source: ABdhPJw74GiaNq1puq7INp+pfeRi0XPcuW7kWAA2WbqyosHKvHI8me5PML8muj17XjIhS2dS6mzrWRSghem+kTaHRH0=
X-Received: by 2002:a05:6512:74d:: with SMTP id c13mr1773220lfs.290.1609926440542;
 Wed, 06 Jan 2021 01:47:20 -0800 (PST)
MIME-Version: 1.0
References: <20201208172912.4352-1-hadess@hadess.net> <CABBYNZJNTDek+kKS5wtrr67Xx8DmFGvcV13cLSxULgJRa5N+3g@mail.gmail.com>
 <6e6d72ff9aa14a65d6d0df5bd68a6ad6887f31c2.camel@hadess.net> <ebbb9f334f6f0cecdb46ddce63483df165ea12ec.camel@hadess.net>
In-Reply-To: <ebbb9f334f6f0cecdb46ddce63483df165ea12ec.camel@hadess.net>
From:   Archie Pusaka <apusaka@google.com>
Date:   Wed, 6 Jan 2021 17:47:09 +0800
Message-ID: <CAJQfnxEpagJOSVdA0MaHg0foy53K6QSpSYk++OQ18hQue9jYCA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Try harder to accept device not knowing options
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Florian Dollinger <dollinger.florian@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

For the test L2CAP/COS/CFD/BV-14-C, this patch is required to pass it.
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=5b8ec15d02f12148ef0185825217162b3bc341f4

I don't think it is merged yet into 5.10, so you might need to apply
the patch yourself.

Thanks,
Archie

On Wed, 6 Jan 2021 at 17:28, Bastien Nocera <hadess@hadess.net> wrote:
>
> On Wed, 2020-12-16 at 16:49 +0100, Bastien Nocera wrote:
> > <snip>
> > The tests fail for me in the same on a kernel with and without
> > the
> > patch:
> > - Expected that the IUT transmits an L2CAP_ConfigRsp includes the
> > unsupported option that Lower Tester sent.
> > Final Verdict:FAIL
> > L2CAP/COS/CFD/BV-14-C finished
> >
> > Is this expected? I was using an 5.10-rc7 kernel with and without the
> > patch I sent. I can send you the full results off-list if you want
> > them.
>
> Any news on that? Is the error expected, should I test with a newer
> version of the kernel? I'd really like to finally land this...
>
