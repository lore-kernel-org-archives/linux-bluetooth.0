Return-Path: <SRS0=DWZO=YB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DF7C10F14
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 10:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDB8206BB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 10:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+a+qw73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfJHK3G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:29:06 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44746 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730425AbfJHK3G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Oct 2019 06:29:06 -0400
Received: by mail-oi1-f194.google.com with SMTP id w6so14291863oie.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Oct 2019 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jc4n84+wNrI63u9NJlSKfx6xgW+/Lhr6YGu3ZtKDrlk=;
        b=l+a+qw73vuwI9ly0iMC5woiUzdQDcF/j2s7/Ft5YC9TCulzzndKPHYIzEeBCQ13zIN
         l0gFCzqPhUpqo0LKT5Zyvj6AjNRuMgMwzj/y7fpA+d7gI2WPOvLb4kkDw4jc2AkSoPze
         HpkAAd19cNVgaRR5Nq5LvwBNkevZIyMEet2EbUA9691dJojoWcnGmUF9zruTGnxOltVl
         MpMZi3wnwqKyK6sHHwB/i1XMZpDV5C9NJ7Q+gDFC784OMHivnOz8oazV7iguWe/DNZsr
         9kkIv2I2AWGtMJuCbXXkkIxcACi7cYBWhPhq+Dqbx/7ES//MYd7N7EkX8pJUHZYMqrtf
         fNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jc4n84+wNrI63u9NJlSKfx6xgW+/Lhr6YGu3ZtKDrlk=;
        b=ja/0pLY6KH3t/oonOCQm54muK1r9P9EuiatJAdP/hsAR3r72jxi5Vb6tiaYC7zDRIs
         tM1q96UP1cXG0ASj18IIhjLN1ToAvDgA6vLr/KAD2OPHby1mphNY0XjeiFC8UO/DnS8o
         1bsCJn9o3tV8kPiwe64xnOYltYKMZzhteLIqZcjs/JAmnkezt5HcG7UMHcb+Ox17w59B
         WoRwPfvBXbjoDt+1JT6pqVD6WfMt9H8JcckTQHdKvsUwr8QqBX0Lo/45AcjzZdQUPlDM
         ls+xys35nwaGIdpcYUTatVL/V4SA2iezdoustyTh8YxvbrqjzoLHajwIFULTwYZuaZ1L
         m+4A==
X-Gm-Message-State: APjAAAWlAChlpX2IEn+8zJoSxGbDxWLUssYQ6sXT+9nUu8ZbKjnwLA8u
        FRajQZnTomC9z8sTti11XDvAJfKJN422Op2Y6gs=
X-Google-Smtp-Source: APXvYqxStAVoIZBBAuFgXy87WQLW5yn9Ta4L75urGMB6829Z+jtST0qgdFbM7FhGKnB08R8B/N6gWAAw0AlCemC+WBU=
X-Received: by 2002:aca:1c03:: with SMTP id c3mr3092185oic.8.1570530545495;
 Tue, 08 Oct 2019 03:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZLDFAJgkfAFWOOAAqqiX8mpi3KgirBkpwpnBFJ3TxPqyg@mail.gmail.com>
 <20190718100024.ii2igadxb2lmmitm@pali> <20190721155522.3vqt7vsprhpxflqf@pali>
 <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
 <20190829125734.GH2840@reaktio.net> <20190829200513.6xnta5jx3trbmgxp@pali>
 <20191003181855.GF28704@reaktio.net> <20191006100503.fsbttcschr6wgsdq@pali>
 <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com>
 <20191006120245.tkrooh45q7irtm6l@pali> <20191007143307.ez6g466afu3trlxn@pali>
In-Reply-To: <20191007143307.ez6g466afu3trlxn@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 8 Oct 2019 13:28:53 +0300
Message-ID: <CABBYNZ+2CGn2rONg+Tpdh9vr7E40_SFFT4Mmru2vQw7MKHTFjQ@mail.gmail.com>
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

On Mon, Oct 7, 2019 at 5:33 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Sunday 06 October 2019 14:02:45 Pali Roh=C3=A1r wrote:
> > On Sunday 06 October 2019 13:53:37 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Sun, Oct 6, 2019 at 1:05 PM Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> > > >
> > > > On Thursday 03 October 2019 21:18:55 Pasi K=C3=A4rkk=C3=A4inen wrot=
e:
> > > > > Hi,
> > > > >
> > > > > On Thu, Aug 29, 2019 at 10:05:13PM +0200, Pali Roh=C3=A1r wrote:
> > > > > > On Thursday 29 August 2019 15:57:34 Pasi K=C3=A4rkk=C3=A4inen w=
rote:
> > > > > > > Pali: How does it look with porting the PA patches to use the=
 new interfaces?
> > > > > >
> > > > > > Hello, I have not had a time yet to play with these pulseaudio =
patches
> > > > > > and porting to the new interface. I guess that I could have mor=
e free
> > > > > > time in the last week of next month.
> > > > > >
> > > > >
> > > > > It seems BlueZ 5.51 has been released meanwhile (http://www.bluez=
.org/release-of-bluez-5-51/)
> > > > > So now at least the new interfaces are in a released bluez versio=
n.
> > > >
> > > > Ok! Today I have looked at this new Bluez API, but seems that there=
 is
> > > > not only missing some examples or usages with libdbus-1, but also
> > > > documentation. I have tried to find something how to register endpo=
ints
> > > > throw GetManagedObjects() via libdbus-1, but seems that there is no
> > > > usage of it and also unusable documentation for it in libdbus-1. So
> > > > currently I'm stuck how to use this exotic API in pulseaudio...
> > >
> > > It is just another D-Bus method, the only difference is that it
> > > carries the entire object tree, btw I did add an example of how to
> > > register Endpoints in python:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-=
endpoint
> >
> > This example uses undocumented property "DelayReporting". What it is do=
ing?
>
> Also this new Managed Objects API bring some inconsistency. Codec
> switching API is available only when bluetoothd was started with
> --experimental flag, but this new Object API is available also without
> it. So it just complicated implementation.
>
> How could application (e.g. pulseaudio) check if A2DP codec switching is
> available and based on this decide if via Managed Objects API export
> more codecs or just only default SBC?

The idea was that this API would be experimental as well but it seems
it is not, they should go hand in hand with Endpoint objects to ensure
they will be available as well so we might have to fix this in 5.52,
too bad we didn't see this before 5.51 went out.

> > > You can also have a look at how our gdbus internal library (uses
> > > libdbus) utilize it:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/gdbus/client.=
c#n1269
> > >
> >
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
