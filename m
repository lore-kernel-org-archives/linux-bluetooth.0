Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D79C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Feb 2021 21:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7977464E6C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Feb 2021 21:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbhBQVZq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhBQVZ1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Feb 2021 16:25:27 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92851C0613D6
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Feb 2021 13:24:47 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q186so12585753oig.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Feb 2021 13:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XW7qrpQt3tZUf6DP9I2wYh4qbJ91/Aancx/GwfDDVvw=;
        b=jAPaFtP6hICRzV++qFbgZVf3aOwESv+AQ6DJ7/bS4AGHsWCKsPZSvFXCCLARx3hISC
         Z2GVJv+FnLF9driuSKVWGBI4NJIdmoRPIHk9P7JoivEarHJ8qQSdDZvPpveZ7ScsEeva
         mAEXsq+Ta3AvFEqC2iGaVrCQ7BA64cg4yIEnvgK2njI3wRluqvhLVbkG5wCvVOqxeP5i
         CAQCLwaLmSmJf8reXLy7ocC7BSyUCFaLFxb5dGuwNNACPPy/b7qBwrxTM+nvXjOpCAiv
         0yWIXihKirIhWcUm0uTcYC5LiVwXuYnsS1m+WIz6eGEVH/EuAL0uF7nX3YuzjSEhQvVD
         yHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XW7qrpQt3tZUf6DP9I2wYh4qbJ91/Aancx/GwfDDVvw=;
        b=nBtDI8hMRygMSzvQdRikAeaK1oAomVwlKj5jvmRVw6F8d4wXpLEu0/PG+vqSKPfi3f
         QeBZ5ZkYqH+iu/xSnyoy1kH0nWNKRSx3+rwOcScv0uw4kqt6sFqLREeMF93dQa1FU1IF
         rFPDOuiVG8ciqOAPAQPjPF4LksZ72/FmnITJbN7OTPImxWcctcDPsF48xJfD/E8snasC
         UlhkDmtEngKjB8V2/Siwy+0P5SLvwYQADVgCBbNKYJzshy4nCrirsEfo/iJ9Q4SR+Ced
         E/dRBnYby9LFOCt/UeET6kg7ZxLOkvWrWmLCfX6rRfXOMTJFf3qh7UHqoj3iNRYTPgki
         po9Q==
X-Gm-Message-State: AOAM531NBbv47OMHAEcCTpHKRLL6iGjhzeH340Wbz1+3KIEmNoWoYHFA
        vkRC+Vbt+ssvYMf7SkEmWyHU6sh+Xbcg+eQ0K2t2avAK9Dg=
X-Google-Smtp-Source: ABdhPJxQdHdv2ITf1t4Z41ogU14kLjC72wh7Ie42bRMLOeGAF12y2KB8PRFhAkjM5XU1FLhuqUaXQj24np+vhtzWa7M=
X-Received: by 2002:a05:6808:1290:: with SMTP id a16mr531657oiw.161.1613597086996;
 Wed, 17 Feb 2021 13:24:46 -0800 (PST)
MIME-Version: 1.0
References: <20210216233337.859955-1-luiz.dentz@gmail.com> <602c5bd2.1c69fb81.cf0ee.0856@mx.google.com>
 <CABBYNZKnft35iJNnKRQp1N=X319m1VY7Ne2SJ9pGKWOGbbpXvg@mail.gmail.com> <CABmPvSHz8bG9X0zUt3DNo2m+6Pn+wHo182EnYsh8mAm+LvHeAw@mail.gmail.com>
In-Reply-To: <CABmPvSHz8bG9X0zUt3DNo2m+6Pn+wHo182EnYsh8mAm+LvHeAw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 Feb 2021 13:24:36 -0800
Message-ID: <CABBYNZKBW+Faraq_Ljj7_WT9HdEZgL19g2-r59T66wxmPt8kEA@mail.gmail.com>
Subject: Re: [BlueZ,1/3] avdtp: Fix setting disconnect timer when there is no
 local endpoints
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Wed, Feb 17, 2021 at 12:37 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> Hi Luiz,
>
> I was testing before seeing your email. Please take a look at my
> comment on the last commit of the series.
> Although this commit doesn't affect the symptom we observed (it was
> IDLE state which triggers the disconnection of IO), the change makes
> sense.

Yep, this doesn't actually make any difference on the matter of
freeing avdtp session when the adapter is removed but as you said it
makes sense on it own given that local endpoints can be unregistered.

> On Wed, Feb 17, 2021 at 11:45 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Miao,
> >
> > On Tue, Feb 16, 2021 at 3:57 PM <bluez.test.bot@gmail.com> wrote:
> > >
> > > This is automated email and please do not reply to this email!
> > >
> > > Dear submitter,
> > >
> > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > This is a CI test results with your patch series:
> > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=434305
> > >
> > > ---Test result---
> > >
> > > ##############################
> > > Test: CheckPatch - PASS
> > >
> > > ##############################
> > > Test: CheckGitLint - PASS
> > >
> > > ##############################
> > > Test: CheckBuild - PASS
> > >
> > > ##############################
> > > Test: MakeCheck - PASS
> > >
> > >
> > >
> > > ---
> > > Regards,
> > > Linux Bluetooth
> >
> > Can you give this set a try with the use case you had? I tested with
> > unplugged use case and it now seems to trigger session_cb immediately
> > so it should work for your case as well.
> >
> > --
> > Luiz Augusto von Dentz
> Thanks,
> Miao



-- 
Luiz Augusto von Dentz
