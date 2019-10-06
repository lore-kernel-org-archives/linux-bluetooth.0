Return-Path: <SRS0=Uexg=X7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C79DC4360C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 11:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2105B20867
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 11:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtmH646p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfJFLRE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 07:17:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36275 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfJFLRE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 07:17:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so11973621wrd.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Oct 2019 04:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=93HBm30IMeqSABCFmFDhNt6pvDpW8XHGoHh7kFJK29g=;
        b=VtmH646pf8evSIkSVNkH6CUMmOYNaTv7ta/73gx/fA7L0g5N8egSCMpFqljXLO6rAO
         xQzWXod8HkxannSDmdogd3vvy8IbVhr397PQmP0PzURBFBaBCzDoGSQWeH7TBu6s4m1R
         2lsryCv/FdddwPivFMGo9vFWXn56VCH6wyNYFFnbdC2K3JB2JFGUqxYQLCEZzgLy1fil
         RUKBlXif/in5Id6txfDfuXjyGXBzwWCmDD4NLbxfmBCPSB26AQKkzojbZ25rLpgl0AO1
         xZdfn8PYLgNL3bRsFvDH/tGeo152R7TJk5EptJJ9Pri9LGJphJnljHOW632tF3UIW0jb
         KQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=93HBm30IMeqSABCFmFDhNt6pvDpW8XHGoHh7kFJK29g=;
        b=huZMxNQYFJVZ56hxl0OCG35p6Nuo5PIjtxgjrOkLs3guT4Ls7Ld5CpinlE9blaeG2t
         mkuUgGSSqr94NLFI2xB+N7DdNXq1Bp+7I++zvHbhSx5eLnnFSu6iWuPqFcPhLq7+P2Uq
         pgSYNukpUuq7cUZg9FaQKM3P/XQb92s1DSepfr5zu1bc79rWMav/QnL4BQu6RkCfrjp5
         syk/Cygf8BbKeqin8Z2QogmV0l6qurN0lP2yW7FXVK1A3Ox288zHoeORLSXzl44xE5mC
         w2GotJb25um/JONvqUv61Dn7UvnI0nT9wp1A5J6OdDcebep6R/IZnEUFo8tGoxUbb9nK
         qsdA==
X-Gm-Message-State: APjAAAVNZ7Dcku5GbOISquRwg6xeYjZ3u6MfCsyYo2TwweTv3T5ahVqr
        kNDXEbJmV9apP3vPoWAIMD4=
X-Google-Smtp-Source: APXvYqz/pXIoP81NgHgptOa5E1A0hZMk2HsURdFcsl5X+U1owtBVyQKMvF4AqffAlqzCuasas6C7fQ==
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr13206733wrs.150.1570360622243;
        Sun, 06 Oct 2019 04:17:02 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id j11sm14225247wrw.86.2019.10.06.04.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Oct 2019 04:17:01 -0700 (PDT)
Date:   Sun, 6 Oct 2019 13:17:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
Message-ID: <20191006111700.42kcgojrzwru2et6@pali>
References: <20190718100024.ii2igadxb2lmmitm@pali>
 <20190721155522.3vqt7vsprhpxflqf@pali>
 <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
 <20190829125734.GH2840@reaktio.net>
 <20190829200513.6xnta5jx3trbmgxp@pali>
 <20191003181855.GF28704@reaktio.net>
 <20191006100503.fsbttcschr6wgsdq@pali>
 <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com>
 <20191006105653.joky4pzkwtnntiwo@pali>
 <CABBYNZLwgZfXf9BhhSJOTvU_-shhj_52YMbYmyhBBNf75OhOsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5a4s3cxyttcpxxmt"
Content-Disposition: inline
In-Reply-To: <CABBYNZLwgZfXf9BhhSJOTvU_-shhj_52YMbYmyhBBNf75OhOsQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--5a4s3cxyttcpxxmt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 06 October 2019 14:14:18 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Sun, Oct 6, 2019 at 1:56 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> >
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
=2Eorg/release-of-bluez-5-51/)
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
> > Now I found this python example and currently I'm doing observations and
> > "reverse-engineering" how it is working and how this example behaves on
> > D-Bus. I think I understood it now.
>=20
> One important detail is that RegisterApplication shall not block since
> the daemon will call GetManagedObjects the D-Bus mainloop must be able
> to process messages.

Ok. I'm already using non-blocking / async processing as blocking
variants can cause more problems in event-orientated applications.

> > > You can also have a look at how our gdbus internal library (uses
> > > libdbus) utilize it:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/gdbus/client.=
c#n1269
> > >
> >
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com
>=20
>=20
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--5a4s3cxyttcpxxmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXZnNKgAKCRCL8Mk9A+RD
UrRlAKCq3KWY8Y5qytA0Noggjl87zU4BugCaAzujexzZm7As2tODtKDIRo11jHY=
=TIG/
-----END PGP SIGNATURE-----

--5a4s3cxyttcpxxmt--
