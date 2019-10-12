Return-Path: <SRS0=HOwO=YF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18172C4360C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Oct 2019 07:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D892D206CD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Oct 2019 07:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYsuiF9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfJLHYN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Oct 2019 03:24:13 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:44991 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbfJLHYN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Oct 2019 03:24:13 -0400
Received: by mail-ot1-f51.google.com with SMTP id 21so9862993otj.11
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Oct 2019 00:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=36SzZ0m5Y+Mkwh/DDI362pxkgmtrcuznfPL+V3nlT0I=;
        b=fYsuiF9B+Gxs/JDx4qAuiTGgGDxXC8sQ1eSkbOc8JTrsap0u/G3sq6pkvrs2e/uyVu
         4yhAh9FqHkQt+DDlczDo2DVA2BGUm0igjkJdF3qIG+hhKoOt0dQihwKiT4US9iyyEdyf
         PjzZ2f2fS8DYpeJI8WkHdp63PrfQwZDnE3lvByuJV3voObrZQh4Zi7L+bg78LwOO+FY3
         tQdE26jU++iW2NduRri/CMaanOh/NWZiV5plyBHdTxJfYH1bHFkhTREdFJxiC6W8ZrDA
         kSqkO/QKfK7IkJp5SX38ahaB7MSUGDchHURummfSYX/M8/OEJDz3C/zq9FMgH0tCC2jC
         O4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=36SzZ0m5Y+Mkwh/DDI362pxkgmtrcuznfPL+V3nlT0I=;
        b=iJFjheudDGBBRRF9dku23aimd+QXIlXESC90fD9UklPimrSfG6omDu6ZG3V4zdVKHo
         iH93OxvfuH+/w+LUhZpVtmjgf0WlgXHyKA2KtIfyA6TPYQCc9R2fn6qi2qSSl7Jvonx4
         z/8HrvNMMeZu9WQS5sLVS3kxVgzr+UH5HOOhSX9tfAWPyV9dArTtYSK/ZuwVT5iOMLq+
         SfkxNMSRqiKSpZPnXhXm09nyDkJnCzVj5P0sVBsBkzVlNVgIZuqCRSSOBnfFjJhCG1PH
         zp46Cc15CJgatfXP6Ao2li5Ll2UsJWI5pEFixk400+XACEpDKCvuUxAWyr5ncL0lj+KS
         qRkw==
X-Gm-Message-State: APjAAAURMHIohlYDdWMIMoXtc1Xeu28us0TG/3Ti0bdpUJ/P8S3P7Tks
        HxAHdtM46+mGe6q2OyB57M2eSZawtFDWYPhefKg=
X-Google-Smtp-Source: APXvYqxYADs2XrkhcxP6iLSjSX4XECEerGypjmHX5ZFh+GHnchNONjUhXfLjnZ4pyntfXLvSp1Yh0uWnUDH6e+RgP8k=
X-Received: by 2002:a9d:197:: with SMTP id e23mr16386671ote.28.1570865051947;
 Sat, 12 Oct 2019 00:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191011082723.t6w2jcg7v4erlnq6@pali> <319f751481bbdb5aa012e5fa4daa1d95965b54c3.camel@intel.com>
 <20191011183502.ao45xlyfabpbadxo@pali> <fea0a8efd80c4c444f56d4f3902aeae4f4f9de32.camel@intel.com>
 <64060b6a2bc9aee7b7eef0347ee3bafe3fddd18b.camel@intel.com> <20191011200420.hbrutdclfva2uqpv@pali>
In-Reply-To: <20191011200420.hbrutdclfva2uqpv@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 12 Oct 2019 10:23:58 +0300
Message-ID: <CABBYNZL8u2kUnPqiA56DtZyAPZEAUQBaBOC-wuqUQmOW6ZJ=Og@mail.gmail.com>
Subject: Re: Determinate EDR speed
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "Gix, Brian" <brian.gix@intel.com>,
        "iam@valdikss.org.ru" <iam@valdikss.org.ru>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Fri, Oct 11, 2019 at 11:07 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> On Friday 11 October 2019 19:05:56 Gix, Brian wrote:
> > On Fri, 2019-10-11 at 19:00 +0000, Gix, Brian wrote:
> > > Hi Pali,
> > >
> > > On Fri, 2019-10-11 at 20:35 +0200, Pali Roh=C3=A1r wrote:
> > > > Currently bluez API, method Acquire() already inform called applica=
tion
> > > > what is socket MTU for input and output. So from this information i=
t is
> > > > possible to detect if device supports EDR 3 or not.
> > > >
> > > > But it is too late to have this information. I need to send SBC
> > > > parameters to bluez first when doing A2DP negotiation, this is earl=
y
> > > > steps before Acquire() is called.
> > >
> > > This seems to be the kind of information which is fixed, for the life=
 of the pairing.
> > >
> > > What if you assumed the lower speed the first time you connected, det=
ermined the
> > > speed during the first streaming, and then either immediately renegot=
iate (caching the identifying
> > > information
> > > of the SNK), or just cache the information for future connections.
> > >
> > > Or the reverse, and assume fast, but immediately adjust down if you a=
ren't getting what you hoped for.
> > >
> > > In any case, this would be a "Device Setup" glitch which you could no=
te as a routine part of pairing in the
> > > documentation.
> >
> > Or, Stream "Silence" the first time you connect, in order to determine =
throughput.  It would add 1-2 seconds to
> > your connection time perhaps, but would be less noticable to the user.
>
> This increase connection time, increase complexity of implementation
> (lot of things can fail) and just complicate lot of things there. Plus
> adds that glitch which is not user friendly.
>
> Also bluetooth devices, like headsets, probably do not expects that
> somebody is going to do such thing and we can hit other implementation
> problems...
>
> And moreover it is just big hack and workaround for that problem. Not a
> reasonable solution.
>
> In btmon I can see it, so kernel already knows that information. Why it
> cannot tell it to userspace and bluetooth daemon to client application?
>
> Client application (e.g. pulseaudio) should really know if is going to
> talk with bluetooth device with EDR 2 or EDR 3.
>
> > >
> > > > Therefore I'm asking for some way how to get information if device
> > > > supports EDR 2 or EDR 3. This is basically requirement for proper
> > > > implementation of SBC in high quality mode. So if there are not suc=
h API
> > > > yet, could it be exported from kernel to userspace and bluetoothd
> > > > daemon?
> > > >
> > > > See these two articles for more details about SBC and its high qual=
ity:
> > > >
> > > > https://habr.com/en/post/456182/
> > > > http://soundexpert.org/articles/-/blogs/audio-quality-of-sbc-xq-blu=
etooth-audio-codec
> > > >
> > > > > > Is there any bluez API for it?
> > > > > >

There quite a few assumption here that are not really how it is
implemented in BlueZ:

1. The L2CAP MTU is not based on the ACL link (should be relatively
easy to change)
2. L2CAP MTU is not required to be symmetric.
3. Since the ACL link is shared for all channels we shouldn't really
assume all throughput will be available
4. PA flow control is not just filling up packets and sending them
when they are full to maximize speed, instead it send packets when
necessary to maintain a constant speed so the MTU may not be fully
used, in fact trying to maximize the MTU may result in higher latency
since packets would be sent less frequently.

With this in mind I think the only thing we should look into is to
adjust the default L2CAP MTU to match the underline ACL Link, so it
maximizes throughput, the remote side may choose a different MTU which
will have to follow though.

--=20
Luiz Augusto von Dentz
