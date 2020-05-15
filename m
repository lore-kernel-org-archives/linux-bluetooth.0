Return-Path: <SRS0=w0Ns=65=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D324FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 May 2020 17:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5E420756
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 May 2020 17:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rj1fAU1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgEOR0V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 May 2020 13:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726179AbgEOR0V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 May 2020 13:26:21 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE968C061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2020 10:26:20 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id x7so2901057oic.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2020 10:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sz53O+u1aSe+jZLwEggDR+04Eu0cpgOBV46vxBKzjBY=;
        b=Rj1fAU1Fq7NqQcSCln3cbXesWb8Jc2aQad8F76CLn5s2uwQNbJ8zItt7KQF6aeX2DS
         0rjip2WsNeEefAGkqfHd8TuiV3v65/KK6NTHm5AfD1yTKTyZkKOyz+O7NoJsW8QfU8HZ
         GhBVN0gIaVAnnliMHLaG2ByMpIoyHkHd2fHvo7l42naZkWXKPvqxps+wMYUF0eAZR/xb
         xKjb8ULCRzRYNyJHc9M5rkKVPQnB/gywdtJXxlHExRmrEkLeqqQ/DYHBXPF3/CJE1MyS
         cCugrVIR25VLqMvoXrtetBeCpJ0ZNZXWtfPqQyCcT9Y8Bg5sGaCGevrvxo9bX/ajX0Ot
         htXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sz53O+u1aSe+jZLwEggDR+04Eu0cpgOBV46vxBKzjBY=;
        b=NHMjBadsCZ4NmBJvPaaY2rrziXLqJn+LMb/qAMpLoSBtkmNMh6tCq+NjDj0zSCXXbR
         IC0j1tjG0EJJjxRBjgr5+s9iz4/RnN2Yeu7A3i90Ax3UfEdeNeyMZsJejEiHMNUygkCL
         OREtv6aSehXjPuQGkhjGmLXYETVOSxZnc02shAZO1jVord5Lt8Ds5lqnH2MvJjtwO0AE
         13SMCU+ud9L69GVtwH7gPfV5fM9MyJB4LoDHrPO3pyxCX2w4mrbuDShss2UFot5hAbwe
         ALUlTjFLLgZ/tAZzcALyFAZ+qJmjTYU8bqQwVQCMaZqsC26OpcdYfIOGM4HASktGpZBr
         Y4+Q==
X-Gm-Message-State: AOAM530jS1VPAF1jx6Azal8s2P75J/+ANhKpvRf0j0sJ8514brR5G7p0
        2Yjz4w9ByzelJxTKwCsjjPWslSoW1RBpn8dmcpk=
X-Google-Smtp-Source: ABdhPJxOvHv2zoBHs8G5fxlBqipDzUR1hbKXpQ8o4smZHJK30Ak9+JGt9CUm0xNYsxkcwCF4C2SHwb3pC0bux/vSJPI=
X-Received: by 2002:aca:b5d5:: with SMTP id e204mr2969051oif.108.1589563579594;
 Fri, 15 May 2020 10:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOVXEJL_zq0_-KTh2HEBT1VvSCCkuwdecXLaEGFquMi30oH6Eg@mail.gmail.com>
 <CABBYNZLVKHVbHXc5=uem1JtKa=eSBi=nc92eaKWgT-kCWj552Q@mail.gmail.com> <CAOVXEJKf5dAv5eriZf04PLABLhPU9uW5CLAnzKf8ePEJRq-GGg@mail.gmail.com>
In-Reply-To: <CAOVXEJKf5dAv5eriZf04PLABLhPU9uW5CLAnzKf8ePEJRq-GGg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 15 May 2020 10:26:07 -0700
Message-ID: <CABBYNZJbCJjNzJVaKKVVLS5TWnzv27F57-c8bHNxEVRZcdN0Eg@mail.gmail.com>
Subject: Re: OPP File Transfer From Settings always uses L2cap Conf as
 BASIC_MODE- OS: Ubuntu 18.04
To:     Sathish Narasimman <nsathish41@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Fri, May 15, 2020 at 1:27 AM Sathish Narasimman <nsathish41@gmail.com> wrote:
>
> Hi Luiz
>
> On Thu, May 14, 2020 at 11:17 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sathish,
> >
> > On Wed, May 13, 2020 at 12:14 AM Sathish Narasimman
> > <nsathish41@gmail.com> wrote:
> > >
> > > Hi
> > >
> > > In Ubuntu when trying to do OPP File transfer using Bluetooth settings
> > > the L2cap Configuration  uses BASIC_MODE
> > >
> > > whereas obexctl it is using ERTM_MODE mode.
> > >
> > > Once the initial connection made from obexctl.later any transfer of
> > > files from setting UI also used ERTM mode.
> > >
> > > How to change the MODE to ERTM for the transfer of file using settings?
> >
> > Is ubuntu setting really using obexd? Or perhaps they are setting a
> > Channel on CreateSession which is then forcing to use RFCOMM instead
> > of L2CAP ERTM, when you use obexctl and don't set any Channel it will
> > attempt to discover the record using SDP and if there is an entry for
> > L2CAP channel it will use to connect using ERTM.
>
> Ubuntu settings are using obexd (OBEX over L2CAP).
> The same is confirmed using the attached logs
>
> The transfer is made between two Ubuntu-18.04 machines

You woulld need to look into obexd logs to check what is going on, as
I said Ubuntu might be trying to set the Channel manually which then
disables the logic to discover the SDP record which is then used to
parse the L2CAP PSM for ERTM or the RFCOMM channel.

-- 
Luiz Augusto von Dentz
