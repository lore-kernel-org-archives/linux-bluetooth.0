Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB09C38A2A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 20:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C14362075E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 20:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDiC+6y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGU6a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 16:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbgEGU6a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 16:58:30 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054CDC05BD43
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2020 13:58:30 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id a2so6291336oia.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2020 13:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2ZAVTUfkbRM2mB15HE5Zm8oQHtVVkvfNmIkvWyuSQ0=;
        b=BDiC+6y8ma+QGgdaL+EJshvnlI/Kco7JOsVdl4GR8IPzXke4JA8pn2UwBVdZ3yYdSO
         ZGea8SP6u3FdWDwzdFicMpisI9Ua2ZRmGi4TldLNGktu7BMWjVOOzJeDuLIWVKGxQhE2
         hkdgdX5/clOOQHt2hRB+XGAKSM8Q42W0zQ1yH9mvLM1Y8Voa4De5j+nemAmhcztcNGPT
         yuChjZRbAgB20vDhFH1dBXYr0eoH1IIg9M4hsrv881ObxPN6JMrtkXYv6QJL3ICw5Ww8
         8HA56KuNhbOGURS+KfmvodfKTyNbCCpy/AoNvwTIZY6MAU6+R7B8bzehhTwOMTqR83K7
         6Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2ZAVTUfkbRM2mB15HE5Zm8oQHtVVkvfNmIkvWyuSQ0=;
        b=jqo2iVgtQqqMXyoqBTVoZIxI1VUCzbILwV+w87jpRbaXAGsnHfMP6PfS6yUfYxDaXh
         EGAsBgAG+btgJBdCE+31zimqmnXDboDCxclvX9v+exyPYWZatTqOumcZOejsT8k20KBt
         yPfdaWPo00lMBcgXO7qBPzZVBX/NrjOA2IlWABJnYhRd71WhttU4/0MK+k1XUFiNpRPa
         /yQ5wwxQcdtOF/0pySDbUp/H5nFdYOD8u1FZX5Ryv0NgVtRPem50MbexPwhjCOd2QRUf
         988RhujQ5Mgva9e1h+GTtiIRVJe+on91W+XkqwEU/r3oSgNrSW1PislMzGod3eX60S5u
         Pw6w==
X-Gm-Message-State: AGi0Pubb0/5M8uNTqQ3snXWgtdN51tBNcQ/eqFzcpOrN/KHH1fy6hCh4
        ssCOBArpe2cvxRDKRaADvrzZ5t5i26fvvnR3wYE=
X-Google-Smtp-Source: APiQypIAovTZkHo/SeumvooXtYt/c6+rMCw44NMHiwa6a64u/lb/Zc5C2Jr3NlQhGc2O3XOcDLoGuAZMfwSq5yn0RfQ=
X-Received: by 2002:aca:b155:: with SMTP id a82mr8359219oif.110.1588885109311;
 Thu, 07 May 2020 13:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <7c4e6f59-d2ef-36c0-46df-0195fad40e7e@gmail.com>
 <76911d0f-dd24-5536-586a-a8e9bc7ad786@gmail.com> <CABBYNZKr3r-6cXGAS3w6SR2-fw2h9gHqvnH=H7O6MSxnandUcg@mail.gmail.com>
In-Reply-To: <CABBYNZKr3r-6cXGAS3w6SR2-fw2h9gHqvnH=H7O6MSxnandUcg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 7 May 2020 13:58:17 -0700
Message-ID: <CABBYNZJ=gUUOGY8BAnt0EU+q3H2SyWXE3nxG1aS7NX1WdJY=MA@mail.gmail.com>
Subject: Re: avrcp: Cannot connect Sennheiser Momentum True Wireless 2
To:     Andrey Semashev <andrey.semashev@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

On Thu, May 7, 2020 at 1:29 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Andrey,
>
> On Wed, May 6, 2020 at 10:32 AM Andrey Semashev
> <andrey.semashev@gmail.com> wrote:
> >
> > On 2020-05-06 19:56, Andrey Semashev wrote:
> > > Hello!
> > >
> > > I have a problem connecting Sennheiser Momentum True Wireless 2
> > > headphones over Bluetooth. The headphones say "Connected" and then
> > > reboot immediately after. After reboot the headphones say "Power on" and
> > > try connecting again, and fail the same way, and so on.
> > >
> > >  From the Bluetooth packet dump it looks like the problem happens after
> > > bluetoothd sends AVRCP ListPlayerApplicationSettingAttributes message to
> > > the headphones. The headphones send Not Implemented response and then
> > > reboot. Both in the request and the response Wireshark shows warnings
> > > about encoding issues.
> > >
> > > I'm attaching a packet dump captured from one of the connection
> > > attempts. The ListPlayerApplicationSettingAttributes message is in
> > > packet 262 and the response is in packet 264.
> > >
> > > This is on Kubuntu 20.04. I tried bluez 5.53 from Kubuntu and revision
> > > 3146b7a0785758be2d4e894d44e99d29c0db983e from git master - the behavior
> > > is the same.
> > >
> > > I've also verified that the headphones do work on Windows 10. On that
> > > system, ListPlayerApplicationSettingAttributes is not present in the
> > > packet exchange. I can provide the packet dump from Windows, if needed.
> > >
> > > I hope this is the right place to report problems like this one. If not
> > > - sorry, and please point me to the right place.
> > >
> > > Thank you.
> >
> > I'll add that I can connect the headphones if I disable AVRCP by adding
> > --noplugin=avrcp to bluetoothd command line.
>
> Weird the ListPlayerApplicationSettingAttributes should only really be
> used when the remote device claims to be have target role but I doubt
> the headsets would be implementing that so perhaps we are not
> detecting this properly, do you have the HCI traces in btsnoop format?
> You can collect that with use of btmon.

Looks like the device is setting the bit for Category 1:
Player/Recorder which is why we are sending player related command,
other stacks might not do that because they are not dual-role, cannot
act as controllers, even if Player Application Settings is optional
for category 1 it still means that we could perhaps list them. It
looks like we are not parsing properly the ctype since it appears that
it returns AVC_CTYPE_NOT_IMPLEMENTED instead of AVC_CTYPE_REJECTED, is
that perhaps causing a crash on bluetoothd?


>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
