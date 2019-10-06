Return-Path: <SRS0=Uexg=X7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC58C4360C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 11:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67A62084B
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 11:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRAzQbq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfJFLOe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 07:14:34 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41244 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJFLOd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 07:14:33 -0400
Received: by mail-ot1-f65.google.com with SMTP id g13so8741696otp.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Oct 2019 04:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N+v74iv72yBfsZ/LWwZ1oxtKzpKAGQl1YYTJDuPKhj0=;
        b=kRAzQbq9wPfbyoaWq72UQzz2PmpPx+EDC31yrbH8gSqR84xflmIQQpykAxecSrC1aQ
         Y3HiNU0SzsAGxrVl2lUXgtqYHMxvFiJRphw/KV3O/aAP+WBHP7LIuqShtFYyMYYDQQi1
         sRGeZFfKD+Ol78weI+lHfSuJgq4gRbxY3i2cwRRueUp8CLzxXFyCcw6six/HMybewwmL
         aMH4dNwS6hYTfMLE0fvFY+j/t7QPa/dkWBf0OM2xF+WXYBgQ1JtznjHlvMeCAQ545ipX
         K/TOhQSwVVbesmcN79tBD1TGjha8D5gIPT/DA8CtdgYCLZv/rVvuaWexnc+u6P1nZLK2
         rOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N+v74iv72yBfsZ/LWwZ1oxtKzpKAGQl1YYTJDuPKhj0=;
        b=KFA4CQ6AIug1QxXMrGcr4X5XFQrQJwqlV2YOgoLUtaDE8XzKHHm4mQuU2YNIviK21a
         XhH+mqzZo+JxVQrbsI9gXwL8g4rwc5gB0ckH2JFqVp8UwedsugZZpedarA3Os9fESWZs
         m0hIwU9HlWbbT/1GJjR0St6zkz2NvOP2f8n8/KFTUl+JQ3l2wNhjM5WEIqgeDJmGIk0k
         gVaFECjpclQ4/JBV43oGC4wdO+GyzwNN3BixbB9j7fXnSAoir2wpar8dQagydjR7Ov8t
         2akCZWTMiIh1vs29HbBi7wKgM/vYFjTln0fB7OWr1jvgAgbYDOmV4qdfGtk2sRCPu7Uy
         SvfA==
X-Gm-Message-State: APjAAAWyyEc2Tzn/quknfQVz8KghBMSLo/GkKuU29ldE9ZDx53XVqpzs
        qsDEIVeRxS+R3/1b/xRAos824ih0a7fbluU6NwA=
X-Google-Smtp-Source: APXvYqxuaCru5BdRxEEBrNnNFmAUJjwzwGta10i8kmGvv4tbRa5YwmXFFd/jMR6xsG1kmmliO8pO/0RWsVOftexSTCM=
X-Received: by 2002:a05:6830:1afd:: with SMTP id c29mr16197670otd.177.1570360472262;
 Sun, 06 Oct 2019 04:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190712151329.11333-1-luiz.dentz@gmail.com> <CABBYNZLDFAJgkfAFWOOAAqqiX8mpi3KgirBkpwpnBFJ3TxPqyg@mail.gmail.com>
 <20190718100024.ii2igadxb2lmmitm@pali> <20190721155522.3vqt7vsprhpxflqf@pali>
 <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
 <20190829125734.GH2840@reaktio.net> <20190829200513.6xnta5jx3trbmgxp@pali>
 <20191003181855.GF28704@reaktio.net> <20191006100503.fsbttcschr6wgsdq@pali>
 <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com> <20191006105653.joky4pzkwtnntiwo@pali>
In-Reply-To: <20191006105653.joky4pzkwtnntiwo@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 6 Oct 2019 14:14:18 +0300
Message-ID: <CABBYNZLwgZfXf9BhhSJOTvU_-shhj_52YMbYmyhBBNf75OhOsQ@mail.gmail.com>
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

On Sun, Oct 6, 2019 at 1:56 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Sunday 06 October 2019 13:53:37 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Sun, Oct 6, 2019 at 1:05 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> > >
> > > On Thursday 03 October 2019 21:18:55 Pasi K=C3=A4rkk=C3=A4inen wrote:
> > > > Hi,
> > > >
> > > > On Thu, Aug 29, 2019 at 10:05:13PM +0200, Pali Roh=C3=A1r wrote:
> > > > > On Thursday 29 August 2019 15:57:34 Pasi K=C3=A4rkk=C3=A4inen wro=
te:
> > > > > > Pali: How does it look with porting the PA patches to use the n=
ew interfaces?
> > > > >
> > > > > Hello, I have not had a time yet to play with these pulseaudio pa=
tches
> > > > > and porting to the new interface. I guess that I could have more =
free
> > > > > time in the last week of next month.
> > > > >
> > > >
> > > > It seems BlueZ 5.51 has been released meanwhile (http://www.bluez.o=
rg/release-of-bluez-5-51/)
> > > > So now at least the new interfaces are in a released bluez version.
> > >
> > > Ok! Today I have looked at this new Bluez API, but seems that there i=
s
> > > not only missing some examples or usages with libdbus-1, but also
> > > documentation. I have tried to find something how to register endpoin=
ts
> > > throw GetManagedObjects() via libdbus-1, but seems that there is no
> > > usage of it and also unusable documentation for it in libdbus-1. So
> > > currently I'm stuck how to use this exotic API in pulseaudio...
> >
> > It is just another D-Bus method, the only difference is that it
> > carries the entire object tree, btw I did add an example of how to
> > register Endpoints in python:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-en=
dpoint
>
> Now I found this python example and currently I'm doing observations and
> "reverse-engineering" how it is working and how this example behaves on
> D-Bus. I think I understood it now.

One important detail is that RegisterApplication shall not block since
the daemon will call GetManagedObjects the D-Bus mainloop must be able
to process messages.

> > You can also have a look at how our gdbus internal library (uses
> > libdbus) utilize it:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/gdbus/client.c#=
n1269
> >
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
