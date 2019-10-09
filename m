Return-Path: <SRS0=7chU=YC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19150ECE58D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 13:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86CE206B6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 13:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFHpVAdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfJINQN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:16:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33325 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJINQN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Oct 2019 09:16:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id 60so1681866otu.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Oct 2019 06:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EYX9wm8aPFnWSQAkZoe6KwkkCZ0jD7bYY5NrvTeYvCs=;
        b=FFHpVAdbASg0BYZ62wxpB5j3ZZd6XHEpgoOsO0z+M3sf8adQD5/mnoQPQkOTcppzsM
         8bFrxRw4JydCJTnpQp32KderTuvopDal7Os1mLYPqgfmsAO/96nJDa2vGO8/8bNmDu9M
         0l/+fnen/OaFwb41cnT5rOpverLO1/33wYDrbtYhp+cOpn2k/6/bWaatacTmAKKz/BYf
         7Zmt4IbwgO0ConQM1L5PtCL9uIbvmOBlCf4FFaFoLMqVnh74HQK12wtg/AeiGkMPzy6j
         MU4kKyVE3GyExvgcCmluBAHUCZlhAotXvoGWptY/9z3zaS+fmmcvHW1Y0TEEe875U75U
         4KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EYX9wm8aPFnWSQAkZoe6KwkkCZ0jD7bYY5NrvTeYvCs=;
        b=XJ+3ig4PlLix72M2dbVitUSepDWd+E2PhqAhqA5h8w0ENKz1n/YmbiLpftpo1Gkb+T
         BByNoJiaOqBn/qdhsY18r8gTab/o+N8HL//PTGvOogWOvKuXxg3bGu4zKq+oB47tAhwn
         EiAt6kDjH0SJ6Vk7UOObVgPNej2hgbKynn9lGv/YGGNr+RcYZdyNpVdqp6lrO7+y/eHD
         3rY2wOcdCHYBrtgBYltdjDNaoimNrS/2oS5/Zk42+7w98zolULC9/ApeaXeF+IjEpM7+
         yYnqnUExqeIWuJhPTKTpbOlzrteG+8TmBtScIcwbnCd8DHoVDwEy7ebshRkhPX/oBopt
         lEiA==
X-Gm-Message-State: APjAAAV0zrX5lS8Awm9QE9AOLMDNwXHlYeE0cZ56UwL+J4I0q6udN8Ju
        pPNtvKG4GLaOX2B0OoxBuD11CBFLG5cyGOk1CZk=
X-Google-Smtp-Source: APXvYqzDxyS+TMeuAx2rXrtFiMaLkArgyba6i2+BVwjTbTVkxjz5J7FaR18fZH6rjzjKR+z3c6fuxfPIDvZj3Utl7js=
X-Received: by 2002:a9d:197:: with SMTP id e23mr2948070ote.28.1570626971756;
 Wed, 09 Oct 2019 06:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190721155522.3vqt7vsprhpxflqf@pali> <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
 <20190829125734.GH2840@reaktio.net> <20190829200513.6xnta5jx3trbmgxp@pali>
 <20191003181855.GF28704@reaktio.net> <20191006100503.fsbttcschr6wgsdq@pali>
 <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com>
 <20191006120245.tkrooh45q7irtm6l@pali> <20191007143307.ez6g466afu3trlxn@pali>
 <CABBYNZ+2CGn2rONg+Tpdh9vr7E40_SFFT4Mmru2vQw7MKHTFjQ@mail.gmail.com> <20191008103333.rqn2btlkwtcrpouo@pali>
In-Reply-To: <20191008103333.rqn2btlkwtcrpouo@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Oct 2019 16:15:59 +0300
Message-ID: <CABBYNZKKUf6-FPBEGjuC5GbsNzNsDLy7LgCHxqiW_g98BaX+QA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Tue, Oct 8, 2019 at 1:33 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Tuesday 08 October 2019 13:28:53 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Mon, Oct 7, 2019 at 5:33 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> > >
> > > On Sunday 06 October 2019 14:02:45 Pali Roh=C3=A1r wrote:
> > > > On Sunday 06 October 2019 13:53:37 Luiz Augusto von Dentz wrote:
> > > > > Hi Pali,
> > > > >
> > > > > On Sun, Oct 6, 2019 at 1:05 PM Pali Roh=C3=A1r <pali.rohar@gmail.=
com> wrote:
> > > > > >
> > > > > > On Thursday 03 October 2019 21:18:55 Pasi K=C3=A4rkk=C3=A4inen =
wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Thu, Aug 29, 2019 at 10:05:13PM +0200, Pali Roh=C3=A1r wro=
te:
> > > > > > > > On Thursday 29 August 2019 15:57:34 Pasi K=C3=A4rkk=C3=A4in=
en wrote:
> > > > > > > > > Pali: How does it look with porting the PA patches to use=
 the new interfaces?
> > > > > > > >
> > > > > > > > Hello, I have not had a time yet to play with these pulseau=
dio patches
> > > > > > > > and porting to the new interface. I guess that I could have=
 more free
> > > > > > > > time in the last week of next month.
> > > > > > > >
> > > > > > >
> > > > > > > It seems BlueZ 5.51 has been released meanwhile (http://www.b=
luez.org/release-of-bluez-5-51/)
> > > > > > > So now at least the new interfaces are in a released bluez ve=
rsion.
> > > > > >
> > > > > > Ok! Today I have looked at this new Bluez API, but seems that t=
here is
> > > > > > not only missing some examples or usages with libdbus-1, but al=
so
> > > > > > documentation. I have tried to find something how to register e=
ndpoints
> > > > > > throw GetManagedObjects() via libdbus-1, but seems that there i=
s no
> > > > > > usage of it and also unusable documentation for it in libdbus-1=
. So
> > > > > > currently I'm stuck how to use this exotic API in pulseaudio...
> > > > >
> > > > > It is just another D-Bus method, the only difference is that it
> > > > > carries the entire object tree, btw I did add an example of how t=
o
> > > > > register Endpoints in python:
> > > > >
> > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/exam=
ple-endpoint
> > > >
> > > > This example uses undocumented property "DelayReporting". What it i=
s doing?
> > >
> > > Also this new Managed Objects API bring some inconsistency. Codec
> > > switching API is available only when bluetoothd was started with
> > > --experimental flag, but this new Object API is available also withou=
t
> > > it. So it just complicated implementation.
> > >
> > > How could application (e.g. pulseaudio) check if A2DP codec switching=
 is
> > > available and based on this decide if via Managed Objects API export
> > > more codecs or just only default SBC?
> >
> > The idea was that this API would be experimental as well but it seems
> > it is not,
>
> No, it is not experimental. Managed Objects API is available also when
> bluetoothd is started without --experimental argument.
>
> > they should go hand in hand with Endpoint objects to ensure
> > they will be available as well so we might have to fix this in 5.52,
> > too bad we didn't see this before 5.51 went out.
>
> So... what should applications expects and how they should implement
> above decision?

Actually the decision should be based on the presence of
RegisterApplication method, if that exists then endpoint switching
should be supported as well, so has nothing to do the
GetManagedObjects API of the bluetoothd. That said RegisterApplication
was not made experimental which kind makes 5.51 broken because it
would appear that it endpoint objects would be exposed but when in
fact there are not, anyway lets finally have the code to use this
interface and then we can remove the experimental flag from
MediaEndpoint.

> > > > > You can also have a look at how our gdbus internal library (uses
> > > > > libdbus) utilize it:
> > > > >
> > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/gdbus/cli=
ent.c#n1269
> > > > >
> > > >
> > >
> > > --
> > > Pali Roh=C3=A1r
> > > pali.rohar@gmail.com
> >
> >
> >
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
