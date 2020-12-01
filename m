Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205D9C83013
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 23:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB682222C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 23:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgLAXQ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 18:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgLAXQ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 18:16:58 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B3BC0613D4
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Dec 2020 15:16:18 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s27so8210053lfp.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 15:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MxLhBmBCneFCr1x6F40S4sMmzzPbSOCcRuJRc5b+h9A=;
        b=Qiqhprq9VsCpachtd3QcSBA8DRbU9WEykGncFY0zTgLShfsFINiLhqr1riyu1Hq3IN
         99zvnF9hPnLa1cZlNKRl0OTfVLGz1d3eTco5qLJaDrxy8K4NJrw7+WcoyWrDpQehQGMh
         0IMaLBCTq8N1fim2bDaabw03lHgYr1rgD4QbXhg0ZNCr6Ljq43L8VJF6g5YwL3I0n9W5
         wyIYTqIdK79niq8lYkeQmxBuaJpYxuJGldG3Wpr2PjF0cLE8lspmHjBep43X7YX5KqjI
         4liSTKjijrve6KkEckHvc8xht7ZCAb78kGHodqqe4fXhEa9qW6epVzpHmeIbcuheP+UD
         WBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MxLhBmBCneFCr1x6F40S4sMmzzPbSOCcRuJRc5b+h9A=;
        b=Bx6041gcSjvtYp9s4Ifqrseexo+Ds+XCOtxFWCq6iCxbI7nb54HqwOQUpfMBhhzBXp
         ZOFMXcBsIKk/Pk13nApwXpigyfLJgQUpoqwxyPLwQ4FqqRvunNW8rhPeyVsdVi+GpfO/
         zH8sraoE9vO2yE0Nh+WcHvJizyf/4vTKp6/zuuy9LSndRoGi7GDos4kYH7ty6izj/C3b
         OSA9+xz3OCVh7uun6/ZoKlx43khaLg5fbdTSKkf3DUkGRtZge39QgNxIYsfMIX7rVpJk
         JnrEZtbFXuXJPlzqvLAo/5C0ESi8F8uheUIuvlDgWKBUxG15EeziYRWrCHd6pLpDE4BB
         LYyQ==
X-Gm-Message-State: AOAM533rOK4AvHYR4nEyiu0B0Vu97IBGdS/Z/MsiwFqSP6BeKprg1wTX
        rcwNdRX6f/dAp+UnEe8nJLp9M3yN7qLsTKOYDcS3og==
X-Google-Smtp-Source: ABdhPJyaPbRzbENp+uHC/gXFN5TEWe/7fpCGhD8biTh/B0re1nKBo+1PMEZpIC1RiTFiWdk/xHaxZYnZVsGJmbqjieQ=
X-Received: by 2002:a05:6512:3054:: with SMTP id b20mr2437950lfb.45.1606864576758;
 Tue, 01 Dec 2020 15:16:16 -0800 (PST)
MIME-Version: 1.0
References: <CALWDO_Ug-VzXmrTOUmMKgQSqqVx-b_L5rekwnv53d4ynjzyfYg@mail.gmail.com>
 <C7HTF3EX487A.12XRHXZKFSF76@rxps> <CALWDO_XbKaLVsfTmkOU56-xtad7RAFAVnGRux_Ls40qDzF-yFg@mail.gmail.com>
 <CABBYNZLN+kGfkhBeANmchjQcEmOTE7DBhZxuJ0mh=DLp-S+Ncg@mail.gmail.com>
In-Reply-To: <CABBYNZLN+kGfkhBeANmchjQcEmOTE7DBhZxuJ0mh=DLp-S+Ncg@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 1 Dec 2020 18:16:08 -0500
Message-ID: <CALWDO_WhBUwh-bj22sND=Ry6U0yiQ19W2yF6+YUTuHuDpoH7dA@mail.gmail.com>
Subject: Re: [BlueZ] main.conf: use correct key for BREDR configuration
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Ronan Pigott <rpigott314@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for the quick turnaround Luiz.  Converging onto BR instead of
BREDR also works.

On Tue, Dec 1, 2020 at 6:13 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain,
>
> On Tue, Dec 1, 2020 at 3:03 PM Alain Michaud <alainmichaud@google.com> wrote:
> >
> > I likely won't get to it for a little while, but if someone will be
> > fixing this, we also noticed this issue while reviewing the related
> > patch:
> >
> > { "PageTimeout",
> > &btd_opts.defaults.br.page_timeout,
> > sizeof(btd_opts.defaults.br.page_scan_win), //<-- this should also be
> > page_timeout rather than page_scan_win
> > 0x0001,
> > 0xFFFF},
>
> Nice catch:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=a37d53db9ae7d21a8f812925303d767d3f03e597
>
> > Thanks!
> > Alain
> >
> > On Tue, Dec 1, 2020 at 5:53 PM Ronan Pigott <rpigott314@gmail.com> wrote:
> > >
> > > On Tue Dec 1, 2020 at 8:33 AM MST, Alain Michaud wrote:
> > > > Hi Luiz/Ronan,
> > > >
> > > > This appears to have been an incorrect fix since
> > > > parse_mode_config(config, "BREDR", params, ARRAY_SIZE(params)); will
> > > > attempt to read from the BREDR section. My suggestion would be to
> > > > update the group table entry instead:
> > >
> > > Oh, that's right. Whoops.
> > >
> > > Updating the group table sounds good to me.
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=e2863c003c8e65b386a981ef6037518beb605795
>
> So now everything should be using BR as group name.
>
>
> --
> Luiz Augusto von Dentz
