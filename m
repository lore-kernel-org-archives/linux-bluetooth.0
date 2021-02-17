Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D69C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Feb 2021 20:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D4C64E6F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Feb 2021 20:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhBQUiW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Feb 2021 15:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhBQUiT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Feb 2021 15:38:19 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A5AC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Feb 2021 12:37:39 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p21so23977650lfu.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Feb 2021 12:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uN/Yp5ipC4tr/cK+xCBV5eM7jpDf0heDb3PrZX1jkvM=;
        b=BVlg/DpFyk11iGwxFFCYJJPo/tDuKWmzXXtCRCi4sE9tQdMlzulUdvHhaaSesJIOKN
         WpBisAGjvxQx9ZQzQdERhcAP8ckA+FsHoL5AKbLBDXW0nZhJzzRc3SJR8Dq7nrT5Tg/a
         Ilbb+SNN6P3BBG41PoWiutkY5lc/n0UTtYeik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uN/Yp5ipC4tr/cK+xCBV5eM7jpDf0heDb3PrZX1jkvM=;
        b=kuCivCFsXbjp7cgS6KrAQRmpXFfemQHVqm+Adygn8Q8CfKWr8cnNaVEDlhGqMRqkts
         Mf5VcJBQp0ZEO3pHVCDvTIo/XM3T+JPs1tNw46aquhdR0SMkAaTksoLjTlOqV4tNQUbH
         JLZV+UmkMMv78hwFMUDUeJsXlouRBcSMUsv23u34bQ8DxWXvN6WsircsrfRrWFegs42r
         YbyeObfLJ009cC2Lp2PDy27SiW+08TE1ZRnY/Vr5X+dfMraligcI871nXf4/vPeXQ2ib
         g7Nu/rZhbO5K3WcBm6AkDmkrOS9XLdtC0FceUpylJG5loGZwZFdIjdJcYu0Ee8d/7siJ
         fGFg==
X-Gm-Message-State: AOAM532up48W/pappTdOuApuIgjojQwqJEVESrSX+4MBgZqxouu/eCAb
        /+/urmnM3k9r1IuNjJmOI7up3/NUBd51GJ533l+6Ng==
X-Google-Smtp-Source: ABdhPJxUYq/4FTlpCKT8xbkZjox5bniYSG2eRJuMh1r7qJZAzkMRdNSRQMU+zw0CpD0YgrCG5cbD6QZ1RfDAZqDQ+g0=
X-Received: by 2002:a19:ee12:: with SMTP id g18mr383717lfb.265.1613594257484;
 Wed, 17 Feb 2021 12:37:37 -0800 (PST)
MIME-Version: 1.0
References: <20210216233337.859955-1-luiz.dentz@gmail.com> <602c5bd2.1c69fb81.cf0ee.0856@mx.google.com>
 <CABBYNZKnft35iJNnKRQp1N=X319m1VY7Ne2SJ9pGKWOGbbpXvg@mail.gmail.com>
In-Reply-To: <CABBYNZKnft35iJNnKRQp1N=X319m1VY7Ne2SJ9pGKWOGbbpXvg@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Wed, 17 Feb 2021 12:37:26 -0800
Message-ID: <CABmPvSHz8bG9X0zUt3DNo2m+6Pn+wHo182EnYsh8mAm+LvHeAw@mail.gmail.com>
Subject: Re: [BlueZ,1/3] avdtp: Fix setting disconnect timer when there is no
 local endpoints
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I was testing before seeing your email. Please take a look at my
comment on the last commit of the series.
Although this commit doesn't affect the symptom we observed (it was
IDLE state which triggers the disconnection of IO), the change makes
sense.

On Wed, Feb 17, 2021 at 11:45 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Tue, Feb 16, 2021 at 3:57 PM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=434305
> >
> > ---Test result---
> >
> > ##############################
> > Test: CheckPatch - PASS
> >
> > ##############################
> > Test: CheckGitLint - PASS
> >
> > ##############################
> > Test: CheckBuild - PASS
> >
> > ##############################
> > Test: MakeCheck - PASS
> >
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth
>
> Can you give this set a try with the use case you had? I tested with
> unplugged use case and it now seems to trigger session_cb immediately
> so it should work for your case as well.
>
> --
> Luiz Augusto von Dentz
Thanks,
Miao
