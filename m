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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D93C4360C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 12:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9261921841
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 12:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5dtQdyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfJFMCu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 08:02:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36495 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfJFMCt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 08:02:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id m18so9737564wmc.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Oct 2019 05:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9K5jhMwWV3ze/kV9FEOyzdHEczmCqPxOBarjjtWmcDc=;
        b=Q5dtQdyuR6RQbfYTtcSo90T5JPloEO5rBtxoZASTKutwAF5pPreQPWpLi9vRLqPHkq
         Tz9jPtANfsSiyACuQcjj+1sI8P+4kS3GJFhBr3u6pM3LWEhpOOo0/irfI7VXhtY/yQqE
         Zt9+Z/yGEDdnI1PPrKRH7Ym39vgebpzY4ZgWXQxc4gBjuz9UnCum4GCa9F8a8bej9Mxr
         a2cv+RW1ILczyNfmFy8aCUnemHOMnZT4djghSYYCOTh9mM2slza3BPiXnvw5MuSwe3oz
         2ti6o+7yvkKhsmbLYhmQ5dXMbLsBhwgCWoRwi4PVQQMc6mxl7k+ErlMQoD0358UJ0jPs
         7FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9K5jhMwWV3ze/kV9FEOyzdHEczmCqPxOBarjjtWmcDc=;
        b=BWpd0CxVHfxQv9vC5DHsepyDv7uClUSxyzym1ylGjbm4LKURn9KQU+wyofeh0wFwHb
         KjWFa/dluIe176mpRC/5CJsmWZPCa0ume9aWE8eLM++6rJJSy/f40QL3C/nx6ttnsTxq
         wy8F+ObXb2f//lJh0HnVyBtolbHcJRHVG5jLJAnwvW75e1uZPY/AJ+hZ4YVAPB6jSLjU
         0PmQ8ngS6dHh9sqbk26jTS4sH5/+kcjsgIEtKIqOz5jQ5f79onZ3AafFi3KyDSip7rhA
         9HJzSTMzwOg7R94fXrm/1FDTy9f8ndu7Y9REHK/1+8M2haxRPjLccSYe6E3jrmTYP88R
         Tvyg==
X-Gm-Message-State: APjAAAU8GvyDa4hFewXRHCPJh1szPe1Q9ezB1UurC8l0jygrdDLwm6wQ
        WFFnlour/yW6Sz+8xwrNfKT+oHaI
X-Google-Smtp-Source: APXvYqzLgCPnmnVI0FKc1fKVvICZWVriNulyRvno+y+Px94Bvxd7+X8DBLe5Xdg11lUG+jDF/Rq+dA==
X-Received: by 2002:a7b:c8c1:: with SMTP id f1mr11928704wml.79.1570363367240;
        Sun, 06 Oct 2019 05:02:47 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id c4sm14307901wru.31.2019.10.06.05.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Oct 2019 05:02:46 -0700 (PDT)
Date:   Sun, 6 Oct 2019 14:02:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
Message-ID: <20191006120245.tkrooh45q7irtm6l@pali>
References: <20190712151329.11333-1-luiz.dentz@gmail.com>
 <CABBYNZLDFAJgkfAFWOOAAqqiX8mpi3KgirBkpwpnBFJ3TxPqyg@mail.gmail.com>
 <20190718100024.ii2igadxb2lmmitm@pali>
 <20190721155522.3vqt7vsprhpxflqf@pali>
 <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
 <20190829125734.GH2840@reaktio.net>
 <20190829200513.6xnta5jx3trbmgxp@pali>
 <20191003181855.GF28704@reaktio.net>
 <20191006100503.fsbttcschr6wgsdq@pali>
 <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oeoa3vlkigw7a7sj"
Content-Disposition: inline
In-Reply-To: <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--oeoa3vlkigw7a7sj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 06 October 2019 13:53:37 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Sun, Oct 6, 2019 at 1:05 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> >
> > On Thursday 03 October 2019 21:18:55 Pasi K=C3=A4rkk=C3=A4inen wrote:
> > > Hi,
> > >
> > > On Thu, Aug 29, 2019 at 10:05:13PM +0200, Pali Roh=C3=A1r wrote:
> > > > On Thursday 29 August 2019 15:57:34 Pasi K=C3=A4rkk=C3=A4inen wrote:
> > > > > Pali: How does it look with porting the PA patches to use the new=
 interfaces?
> > > >
> > > > Hello, I have not had a time yet to play with these pulseaudio patc=
hes
> > > > and porting to the new interface. I guess that I could have more fr=
ee
> > > > time in the last week of next month.
> > > >
> > >
> > > It seems BlueZ 5.51 has been released meanwhile (http://www.bluez.org=
/release-of-bluez-5-51/)
> > > So now at least the new interfaces are in a released bluez version.
> >
> > Ok! Today I have looked at this new Bluez API, but seems that there is
> > not only missing some examples or usages with libdbus-1, but also
> > documentation. I have tried to find something how to register endpoints
> > throw GetManagedObjects() via libdbus-1, but seems that there is no
> > usage of it and also unusable documentation for it in libdbus-1. So
> > currently I'm stuck how to use this exotic API in pulseaudio...
>=20
> It is just another D-Bus method, the only difference is that it
> carries the entire object tree, btw I did add an example of how to
> register Endpoints in python:
>=20
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-endp=
oint

This example uses undocumented property "DelayReporting". What it is doing?

> You can also have a look at how our gdbus internal library (uses
> libdbus) utilize it:
>=20
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/gdbus/client.c#n1=
269
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--oeoa3vlkigw7a7sj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXZnX4wAKCRCL8Mk9A+RD
Uoe4AKCGxMRsw0phqKqJsVyTyspED+o0TwCaA2eW2OTZYOMFUUtheSk52TD9Y8c=
=d/XE
-----END PGP SIGNATURE-----

--oeoa3vlkigw7a7sj--
