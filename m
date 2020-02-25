Return-Path: <SRS0=zBEa=4N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7856C35E04
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 18:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC5B20CC7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 18:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=adafruit.com header.i=@adafruit.com header.b="Y5HJ+xDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbgBYSSu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:18:50 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41097 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBYSSu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Feb 2020 13:18:50 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so476153eds.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2020 10:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=adafruit.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCyhXwk1nscmjJ8n90ZEfRfYUu+G/ef8Bt6VQlnf5zs=;
        b=Y5HJ+xDhF/DpMkB8VtsYtaAHswVDUUfdXziW5vi4RkxI5qhiY6ftKS9/9kxVebAN3M
         Qiu72pOdwePTAFvL0mreLeuhEn0Til+56MzXAqlUb7aeNCLxM7vCrq4py2o0sRotv4sU
         els+OUn9FPAGZ6qZ3MhDchI+nQnvzF51InTSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCyhXwk1nscmjJ8n90ZEfRfYUu+G/ef8Bt6VQlnf5zs=;
        b=K3xihfzBgxboN/DAf8RG93m6k66ce4pEp1qfrZShQ1SNkmMW3bUVrxsMSi1tQV/Rav
         P1/lnCMS8FX6r/8rM+BFoVe5oog3DBoGkwHNsPj10JTJ0KMgMed/5cgan1vgNBrU0jQ3
         Gf4SLUm8DIQ0hPaaeezq8W3GESoJrQTcZoi0nTXfl1ea+u5dlboRZbFvGCeaOJL0XBbn
         ouPpg3Z4jFkHXjcdI7hY5F6rgFkT/GePB523cJyDAhkO35wdthPj9YDzQOhm75dyhEc3
         0xqJD3axQG//uzWuirnSEbXn6crVn4X8iWPJO9kr9HpfjxN4mquuZdmkyXEK3/H+19pp
         CAYQ==
X-Gm-Message-State: APjAAAX/PWufw5z747HgLxck0laziw0FWEw5Q4yyLB11ru8YzjV/KPkE
        Sb/BqIw+gkATbfxk79tVCNK5N+mc0a/X0DU3OWEDlw==
X-Google-Smtp-Source: APXvYqwsgHsBXqhE6B9DDjmeqJiinWR1hQz07o0YSJAinSXiNN/92QCQ89A+9ULS4++8MPHvDySCtS9DIF7Vy+/dihU=
X-Received: by 2002:aa7:c616:: with SMTP id h22mr248362edq.352.1582654727952;
 Tue, 25 Feb 2020 10:18:47 -0800 (PST)
MIME-Version: 1.0
References: <CAJ_gUqbKKxt15OhizRN_x4Dy-RvyuEUH0Bwcah_KEcMsQakQoA@mail.gmail.com>
 <CABBYNZKG6hFMgy7ifuEW2kxyQYd=Gw0cWefjBy-fdWS00OWL+g@mail.gmail.com>
 <CAJ_gUqZ5rsV55tO5O07fUYxEoJa=CG0gAz5P3hJ-Lb-kYws2rg@mail.gmail.com> <CABBYNZJhPqb=H0r93mTnLxBMR-AazXdfopHTT-pw+ZXgj1QzeA@mail.gmail.com>
In-Reply-To: <CABBYNZJhPqb=H0r93mTnLxBMR-AazXdfopHTT-pw+ZXgj1QzeA@mail.gmail.com>
From:   Scott Shawcroft <scott@adafruit.com>
Date:   Tue, 25 Feb 2020 10:18:36 -0800
Message-ID: <CAJ_gUqbQZ1+ghj4Gt4AYkOtq8JOPZE6jgoLJry21wfuGo86zTw@mail.gmail.com>
Subject: Re: Adding support for DuplicateData into the kernel
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Feb 24, 2020 at 2:33 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Scott,
>
> On Mon, Feb 24, 2020 at 1:51 PM Scott Shawcroft <scott@adafruit.com> wrote:
> >
> > On Mon, Feb 24, 2020 at 10:57 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Scott,
> > >
> > > On Thu, Feb 20, 2020 at 8:34 PM Scott Shawcroft <scott@adafruit.com> wrote:
> > > >
> > > > Hi!
> > > >
> > > > I'm trying to create a bridge between BLE advertisements and the web
> > > > for sensor data logging. The BLE advertisements use manufacturer data
> > > > to transmit the sensor data. I'm running on a Raspberry Pi 3b.
> > > >
> > > > I've been trying to use the Bluez dbus interface with DuplicateData,
> > > > trying both true and false, and I never seem to get duplicates back. I
> > > > dug into it via hcidump and noticed that the scan enable still has
> > > > filter duplicates set to true regardless. I can only manage to get it
> > > > set to False when using hcitool.
> > > >
> > > > I believe I've tracked the issue down into the kernel here:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_request.c#n858
> > > > where enabling duplicate filtering is hardcoded. It seems that hcitool
> > > > side steps this by talking directly to the hci device.
> > >
> > > Yep, the kernel code don't actually allow setting the duplicate filter
> > > unfortunately.
> > >
> > > > Could someone confirm I'm on the right track? I'd be willing to plumb
> > > > the DuplicateData value through to the kernel if someone could help me
> > > > find the call path down.
> > >
> > > In the past Marcel was against turning off the duplicate filtering but
> > > since we do have a similar setting over D-Bus, though the later shall
> > > not be confused since tracks duplicates by itself since over D-Bus we
> > > are doing it to prevent duplicate signals, Im with the opinion that
> > > DuplicateData could be used to disable duplicate filtering, default
> > > should be still be enabled though.
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> > Thanks for the reply!
> >
> > I agree the default should be to filter duplicates. I'd love to see
> > the Dbus setting actually used in the kernel. Did I find the correct
> > place to change? I'm not sure how it is called from bluez though.
> > (Maybe through the mgmt API?)
>
> Yes, we would need to add it to Start Service Discover or create a new
> one, while at it we may add support for adding both the interval and
> window to SetDiscoveryFilter, Id actually think we might be better off
> adding a new command e.g. Start Filtered Discover which can then
> accomodate all these details, but it probably won't be very simple to
> do as we learn from the addition of the filters making it work with
> multiple clients complicates it a little bit, anyway I don't think we
> want this to be global but rather per client.
>
>
> --
> Luiz Augusto von Dentz

I agree it makes sense to do it on a per-client basis. What I'm not
clear on is the call process from the DBUS api down into the kernel's
`hci_req_start_scan` function I found. This is my first time
considering kernel hacking so I'm not sure of the regular process. I
imagine we'll want to turn on duplicates if any dbus client wants them
and then filter them out for any clients that don't.

Thanks,
Scott
