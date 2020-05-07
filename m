Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82579C35280
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 23:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5607A20CC7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 23:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwOCpdZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgEGX1k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 19:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEGX1j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 19:27:39 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACAAC05BD43
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2020 16:27:39 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id c124so6602614oib.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2020 16:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzkqP53pZyPXuomW2aY73h25BilrON1kKaNP3r+4C3I=;
        b=uwOCpdZLAgLQ7D6nO3i2+R/xKUI+jgvwyJxfttkKxex+gSg0LaFdZdiIdRVDD95NJQ
         g8W5H/HImZRG386+MRQKZHUZa0zKmPEK0H+XiXGl3bs9H5JCMRWK/UeMLEDc21kz6gBW
         /OFJRh5CAPs0FRWFCcztoFVbNUbyKWor82GDiBY2iXaimqL7nxcNlmcFtadjUA++OGMf
         CpNGsjusSV5D63lj2mvySQvSmFBl7jxi1mNOO2t8OP6gv8yWSRe4Ni35tJ7svxRetEDM
         835pTsyUKWS5ye024/LPPt1nAfWWtlTLlkJRDnZLh04M/qkdhbx/P+dsRCRe6SbRXDt/
         w9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzkqP53pZyPXuomW2aY73h25BilrON1kKaNP3r+4C3I=;
        b=tTiKlnjeNe3somUyfIhogcROcsCvt03mD8+RI+MvNHjBMw6yRX+s/J/ZEwVE6axb2n
         +v2EcYRY+pC1dvnSC5AtsxojLPpkorUBr2fyk5NqM21/nw7EZLLKz789rQMY5yAnAu0+
         3gv/ENUTx9zTrpikANkKJPvSiIqnUvat9S9/Mp5XTsY0ZoCtjodYzwpNyYZk/q0ZTuP6
         60hi0Lvk+tGcQAmj1FZEDJuiyRaVnbhazxuAE60yGf0yFyk6dvzMn3AQFQXVC1coJj5+
         868dIFzW9vqJhEmo5457JUL2PddIsm56+m0BlpXtuXfwYnRe+mwxqq3chw0MGuZn1wT3
         yhqw==
X-Gm-Message-State: AGi0PuZTKJ2EzZ7BHC1zrkh/reFN4UwEXykL/FixX1vXcTOsq3neiAuV
        R/egKWjFVBQeUQj8DM8fdY8Odw4ktFtF5o/459sKlhxVMJY=
X-Google-Smtp-Source: APiQypLpZzN3ZBZWWox17p9DmduI5CyErWvcyROioFe4Gqo/jJrLGVejWGiroDa/DMcYN1AL/idrho+gKDOKBHDbVP0=
X-Received: by 2002:aca:af4a:: with SMTP id y71mr8045432oie.101.1588894058644;
 Thu, 07 May 2020 16:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <7c4e6f59-d2ef-36c0-46df-0195fad40e7e@gmail.com>
 <76911d0f-dd24-5536-586a-a8e9bc7ad786@gmail.com> <CABBYNZKr3r-6cXGAS3w6SR2-fw2h9gHqvnH=H7O6MSxnandUcg@mail.gmail.com>
 <CABBYNZJ=gUUOGY8BAnt0EU+q3H2SyWXE3nxG1aS7NX1WdJY=MA@mail.gmail.com>
In-Reply-To: <CABBYNZJ=gUUOGY8BAnt0EU+q3H2SyWXE3nxG1aS7NX1WdJY=MA@mail.gmail.com>
From:   Andrey Semashev <andrey.semashev@gmail.com>
Date:   Fri, 8 May 2020 02:27:26 +0300
Message-ID: <CAEhD+6CP97VDBqbKKPzG-io54CV926By7NWtyLqFjONYJWsO_w@mail.gmail.com>
Subject: Re: avrcp: Cannot connect Sennheiser Momentum True Wireless 2
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, May 7, 2020 at 11:58 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Andrey,
>
> On Thu, May 7, 2020 at 1:29 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Andrey,
> >
> > On Wed, May 6, 2020 at 10:32 AM Andrey Semashev
> > <andrey.semashev@gmail.com> wrote:
> > >
> > > On 2020-05-06 19:56, Andrey Semashev wrote:
> > > > Hello!
> > > >
> > > > I have a problem connecting Sennheiser Momentum True Wireless 2
> > > > headphones over Bluetooth. The headphones say "Connected" and then
> > > > reboot immediately after. After reboot the headphones say "Power on" and
> > > > try connecting again, and fail the same way, and so on.
> > > >
> > > >  From the Bluetooth packet dump it looks like the problem happens after
> > > > bluetoothd sends AVRCP ListPlayerApplicationSettingAttributes message to
> > > > the headphones. The headphones send Not Implemented response and then
> > > > reboot. Both in the request and the response Wireshark shows warnings
> > > > about encoding issues.
> > > >
> > > > I'm attaching a packet dump captured from one of the connection
> > > > attempts. The ListPlayerApplicationSettingAttributes message is in
> > > > packet 262 and the response is in packet 264.
> > > >
> > > > This is on Kubuntu 20.04. I tried bluez 5.53 from Kubuntu and revision
> > > > 3146b7a0785758be2d4e894d44e99d29c0db983e from git master - the behavior
> > > > is the same.
> > > >
> > > > I've also verified that the headphones do work on Windows 10. On that
> > > > system, ListPlayerApplicationSettingAttributes is not present in the
> > > > packet exchange. I can provide the packet dump from Windows, if needed.
> > > >
> > > > I hope this is the right place to report problems like this one. If not
> > > > - sorry, and please point me to the right place.
> > > >
> > > > Thank you.
> > >
> > > I'll add that I can connect the headphones if I disable AVRCP by adding
> > > --noplugin=avrcp to bluetoothd command line.
> >
> > Weird the ListPlayerApplicationSettingAttributes should only really be
> > used when the remote device claims to be have target role but I doubt
> > the headsets would be implementing that so perhaps we are not
> > detecting this properly, do you have the HCI traces in btsnoop format?
> > You can collect that with use of btmon.
>
> Looks like the device is setting the bit for Category 1:
> Player/Recorder which is why we are sending player related command,
> other stacks might not do that because they are not dual-role, cannot
> act as controllers, even if Player Application Settings is optional
> for category 1 it still means that we could perhaps list them. It
> looks like we are not parsing properly the ctype since it appears that
> it returns AVC_CTYPE_NOT_IMPLEMENTED instead of AVC_CTYPE_REJECTED, is
> that perhaps causing a crash on bluetoothd?

It's not the bluetoothd what crashes, it's the headset. My
understanding is that the headset doesn't support
ListPlayerApplicationSettingAttributes and does a poor job of handling
it. So after sending the (malformed) AVC_CTYPE_NOT_IMPLEMENTED
response it reboots.

If bluetoothd doesn't expect AVC_CTYPE_NOT_IMPLEMENTED, I suppose, it
should be updated to handle it. But I don't think it is going to fix
the problem of the headset rebooting. I think the fix should be to
somehow avoid sending ListPlayerApplicationSettingAttributes. Or maybe
encode it differently (e.g. by adding some parameters, if there are
any required by the spec.) Also, since I never got beyond
ListPlayerApplicationSettingAttributes, there may be more issues down
the road. I'm willing to test any patches.

Also, I filed a support request to Sennheiser regarding this issue. No
reply so far, and I don't have much hope for them solving it, but
still.
