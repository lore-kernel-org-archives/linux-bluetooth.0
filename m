Return-Path: <SRS0=9HFX=YG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73A2C4360C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Oct 2019 08:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75ECD2067B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Oct 2019 08:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Thk17emS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfJMIqR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Oct 2019 04:46:17 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:36215 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbfJMIqQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Oct 2019 04:46:16 -0400
Received: by mail-oi1-f172.google.com with SMTP id k20so11445028oih.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Oct 2019 01:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=igB7cUH4peo5mvs8mC0rT2ZvoPaz+ORoGundUP+e9AE=;
        b=Thk17emSKbRFpi4JemHPL4ESuwWfVD7HTVu28HbdmehDgWBC1Xv4YowjqvGeDfocB/
         V5yn86AaVEZUKOGSyGC0EOICL/+tSvShq/zKi2GxHMUD5cMCRmAL4kDpBWVv2KvVPkOI
         gptE1V8en+qduNDbaOtdXp3LWW1WmjWnYTJA6dqo72KMVZAfjqpzBcSGJZ6FGNtMjiOl
         rpDBoBnCoAae9eT/mGm0g/ofsGJWkDoF8Zwa1YaN5SIRDR5cEVrxJf2Lh1p7HMn8ESi7
         RvjvXyzhAOpHeqeD+L1pAhF9vPEXe1Dywy/SUfUEVyGdPHSQOxvj/hUfQnjCEP1di1lI
         ytBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=igB7cUH4peo5mvs8mC0rT2ZvoPaz+ORoGundUP+e9AE=;
        b=g3JUKWtBau2x9aG5hY2zBulPEQE2800Hf4HOVIACFzrQa0WG4FeD++kRecbZL69qrc
         dOkBdgYhqpiWSoCJkoMrZ+3bZbaXKmUsCpWr2qgEoLx7Mf0+RIsnALOu58EbqDNMzzEB
         y7AsXMGkIOP28qRWanrU7bOBnQiFH6QRRv9tZD+wfnwBqODuGn7bNZVyW4Gi63YWy2tI
         hlDoohAHypJYUhCAj/gCtnF6GyfA9DN0M3JR/OaW0cq1dJIpUSoOXsyBM3M5dcYeIHhu
         YqKCtKQ7wptRRDHMu6Lu8woi47/yHOzS6VttkhgYqR1RDdzjUQYVsOqpXpCG4CYIDu73
         tNgQ==
X-Gm-Message-State: APjAAAUPzTUjOSpf+atPXbK+Rk6x9bqySNsL7WweW0nqptzuArC6aMKJ
        VEz55NNisSrTOo3/aqM8JlizJkq2qUAYh4ERSgE=
X-Google-Smtp-Source: APXvYqyAV5tBRrfJdwW0kXp/aFt0+RVtl1N2yPiTaKoZBANUSod1YCpWw6iUuMbgtuVXRIR8p9cvIlrUvniDdTrTcYE=
X-Received: by 2002:a54:4d02:: with SMTP id v2mr12106455oix.8.1570956373721;
 Sun, 13 Oct 2019 01:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191011082723.t6w2jcg7v4erlnq6@pali> <319f751481bbdb5aa012e5fa4daa1d95965b54c3.camel@intel.com>
 <20191011183502.ao45xlyfabpbadxo@pali> <fea0a8efd80c4c444f56d4f3902aeae4f4f9de32.camel@intel.com>
 <64060b6a2bc9aee7b7eef0347ee3bafe3fddd18b.camel@intel.com>
 <20191011200420.hbrutdclfva2uqpv@pali> <CABBYNZL8u2kUnPqiA56DtZyAPZEAUQBaBOC-wuqUQmOW6ZJ=Og@mail.gmail.com>
 <20191013073603.6jnczqr4fk7lpyxq@pali>
In-Reply-To: <20191013073603.6jnczqr4fk7lpyxq@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 13 Oct 2019 11:45:58 +0300
Message-ID: <CABBYNZJx6ZKfBftJoZ2b0pdUXyuY23kA1OUAsZTA4KHVLwoF3w@mail.gmail.com>
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

On Sun, Oct 13, 2019 at 10:36 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> On Saturday 12 October 2019 10:23:58 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Fri, Oct 11, 2019 at 11:07 PM Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> > >
> > > On Friday 11 October 2019 19:05:56 Gix, Brian wrote:
> > > > On Fri, 2019-10-11 at 19:00 +0000, Gix, Brian wrote:
> > > > > Hi Pali,
> > > > >
> > > > > On Fri, 2019-10-11 at 20:35 +0200, Pali Roh=C3=A1r wrote:
> > > > > > Currently bluez API, method Acquire() already inform called app=
lication
> > > > > > what is socket MTU for input and output. So from this informati=
on it is
> > > > > > possible to detect if device supports EDR 3 or not.
> > > > > >
> > > > > > But it is too late to have this information. I need to send SBC
> > > > > > parameters to bluez first when doing A2DP negotiation, this is =
early
> > > > > > steps before Acquire() is called.
> > > > >
> > > > > This seems to be the kind of information which is fixed, for the =
life of the pairing.
> > > > >
> > > > > What if you assumed the lower speed the first time you connected,=
 determined the
> > > > > speed during the first streaming, and then either immediately ren=
egotiate (caching the identifying
> > > > > information
> > > > > of the SNK), or just cache the information for future connections=
.
> > > > >
> > > > > Or the reverse, and assume fast, but immediately adjust down if y=
ou aren't getting what you hoped for.
> > > > >
> > > > > In any case, this would be a "Device Setup" glitch which you coul=
d note as a routine part of pairing in the
> > > > > documentation.
> > > >
> > > > Or, Stream "Silence" the first time you connect, in order to determ=
ine throughput.  It would add 1-2 seconds to
> > > > your connection time perhaps, but would be less noticable to the us=
er.
> > >
> > > This increase connection time, increase complexity of implementation
> > > (lot of things can fail) and just complicate lot of things there. Plu=
s
> > > adds that glitch which is not user friendly.
> > >
> > > Also bluetooth devices, like headsets, probably do not expects that
> > > somebody is going to do such thing and we can hit other implementatio=
n
> > > problems...
> > >
> > > And moreover it is just big hack and workaround for that problem. Not=
 a
> > > reasonable solution.
> > >
> > > In btmon I can see it, so kernel already knows that information. Why =
it
> > > cannot tell it to userspace and bluetooth daemon to client applicatio=
n?
> > >
> > > Client application (e.g. pulseaudio) should really know if is going t=
o
> > > talk with bluetooth device with EDR 2 or EDR 3.
> > >
> > > > >
> > > > > > Therefore I'm asking for some way how to get information if dev=
ice
> > > > > > supports EDR 2 or EDR 3. This is basically requirement for prop=
er
> > > > > > implementation of SBC in high quality mode. So if there are not=
 such API
> > > > > > yet, could it be exported from kernel to userspace and bluetoot=
hd
> > > > > > daemon?
> > > > > >
> > > > > > See these two articles for more details about SBC and its high =
quality:
> > > > > >
> > > > > > https://habr.com/en/post/456182/
> > > > > > http://soundexpert.org/articles/-/blogs/audio-quality-of-sbc-xq=
-bluetooth-audio-codec
> > > > > >
> > > > > > > > Is there any bluez API for it?
> > > > > > > >
> >
> > There quite a few assumption here that are not really how it is
> > implemented in BlueZ:
> >
> > 1. The L2CAP MTU is not based on the ACL link (should be relatively
> > easy to change)
> > 2. L2CAP MTU is not required to be symmetric.
> > 3. Since the ACL link is shared for all channels we shouldn't really
> > assume all throughput will be available
> > 4. PA flow control is not just filling up packets and sending them
> > when they are full to maximize speed, instead it send packets when
> > necessary to maintain a constant speed so the MTU may not be fully
> > used, in fact trying to maximize the MTU may result in higher latency
> > since packets would be sent less frequently.
> >
> > With this in mind I think the only thing we should look into is to
> > adjust the default L2CAP MTU to match the underline ACL Link, so it
> > maximizes throughput, the remote side may choose a different MTU which
> > will have to follow though.
>
> Hi Luiz! The main problem is not MTU size, as I wrote I cannot use it
> normally for distinguish for usage of SBC XQ or not. Instead of MTU I
> rather need to know if device supports EDR 2 or EDR 3.

I was trying to implement this on the kernel to match the MTU size of
L2CAP with ACL but the packet type current in use by the connection is
not exposed in the connection complete, or at least I couldn't any
reference to it, we could possibly expose the packet types via socket
option as well but changing it at runtime is probably not a good idea.

--=20
Luiz Augusto von Dentz
