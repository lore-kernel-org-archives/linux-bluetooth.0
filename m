Return-Path: <SRS0=ztA9=VS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D1EC76191
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Jul 2019 15:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7270C2083B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Jul 2019 15:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdmEriSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfGUPz0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Jul 2019 11:55:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39157 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfGUPz0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Jul 2019 11:55:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so36815180wrt.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jul 2019 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ygvBZlLVRFcQ1rWmFwvLk0UErbyFefQDSV2rjJuwSRs=;
        b=mdmEriShNfUSij6KuLEwyNXMGxz0iAyCMhr6uuTHxt3wYxkdUZgUaIe3glKjAB2/oO
         0Ort8sPQHFNSYT1ucBhH4FNq5OzwCHjQIopk2WSAgxoInXDb2Pl6m3wgicMNQxlur/Wc
         8GCXdHCVtHnvAnTXtIJTbB33aiJu5wkimXmxsavO+T4D1uUVdxsjy4YVIITLhXmibBRN
         9A8heeIWw68O5+p6ZXUhrXdq+Cs1GEPpg02yW4jENH4NAKueuhqJy+lFGHcGLusOEBXG
         fOIlK6C3mcnxZVntFueCdz5evdUlVB0VwxXYeemj3K9Z+66mgX0ljH6ewqOSglnQrxlT
         TVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ygvBZlLVRFcQ1rWmFwvLk0UErbyFefQDSV2rjJuwSRs=;
        b=HvSGFmECHweHgXQRroBgfIhv/SLoTZhCECmfLC30jSYnu3hLryE64fLoT45MEA6Bpw
         eStvx/9Dvn/DDvCSLGuJ4ahf2ncGseAoH+9X49L1Qnd15L6D4VPJxwmpXaqj2j8IYJvM
         aEkaeSmNUyCbHieyXy2cLBZqbIp1+n4pijWwVvM+jcyZvpnh5vaYsizx2izd7EPTnrDH
         6++ObmmpxMr/jfAt2bJEOnNfypKi2zJ7kyVz/4Pcbbix6ztey+q6hGb/mExH7MA3niZD
         IHfMDqnfzk7EmyiqAGzSCv7ADKGJRhemzJD32mqbqrI1klwS0sLWaehPYOi87sMD/GNK
         4eRA==
X-Gm-Message-State: APjAAAWQodPa9lcqBPGOttCBGGNoDAi0yzxHQUxBjDDD2yFNjsi2zDoP
        tdh3ytgbYuMGdKdsAu9jRaE=
X-Google-Smtp-Source: APXvYqy0WkfqrRmoD0DuYKvCRswb9gnSJ7ec1qAyWxY/59RWxEwDF/129JmMkiGh8KaRNphbmK5Pgg==
X-Received: by 2002:adf:e483:: with SMTP id i3mr28902842wrm.210.1563724524496;
        Sun, 21 Jul 2019 08:55:24 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id g8sm41378874wme.20.2019.07.21.08.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Jul 2019 08:55:23 -0700 (PDT)
Date:   Sun, 21 Jul 2019 17:55:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
Message-ID: <20190721155522.3vqt7vsprhpxflqf@pali>
References: <20190712151329.11333-1-luiz.dentz@gmail.com>
 <CABBYNZLDFAJgkfAFWOOAAqqiX8mpi3KgirBkpwpnBFJ3TxPqyg@mail.gmail.com>
 <20190718100024.ii2igadxb2lmmitm@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7t6vwjx5czol3o3p"
Content-Disposition: inline
In-Reply-To: <20190718100024.ii2igadxb2lmmitm@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--7t6vwjx5czol3o3p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 18 July 2019 12:00:24 Pali Roh=C3=A1r wrote:
> On Saturday 13 July 2019 17:52:46 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >=20
> > On Fri, Jul 12, 2019 at 6:13 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This uses application ObjectManager to discover the MediaEndpoint and
> > > MediaPlayer object of an application and deprecates the use of
> > > RegisterEndpoint and RegisterPlayer.
> > > ---
> > >  doc/media-api.txt | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > index bca8c9563..07f7ac3e0 100644
> > > --- a/doc/media-api.txt
> > > +++ b/doc/media-api.txt
> > > @@ -66,7 +66,27 @@ Methods              void RegisterEndpoint(object =
endpoint, dict properties)
> > >
> > >                         Unregister sender media player.
> > >
> > > +               void RegisterApplication(object root, dict options)
> > >
> > > +                       Register endpoints an player objects within r=
oot
> > > +                       object which must implement ObjectManager.
> > > +
> > > +                       The application object path together with the=
 D-Bus
> > > +                       system bus connection ID define the identific=
ation of
> > > +                       the application.
> > > +
> > > +                       Possible errors: org.bluez.Error.InvalidArgum=
ents
> > > +                                        org.bluez.Error.AlreadyExists
> > > +
> > > +               void UnregisterApplication(object application)
> > > +
> > > +                       This unregisters the services that has been
> > > +                       previously registered. The object path parame=
ter
> > > +                       must match the same value that has been used
> > > +                       on registration.
> > > +
> > > +                       Possible errors: org.bluez.Error.InvalidArgum=
ents
> > > +                                        org.bluez.Error.DoesNotExist
> > >  Media Control hierarchy
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > --
> > > 2.21.0
> >=20
> > Can you try this set?
>=20
> Hello, I will try it later in next week. To test it would mean to
> rewrite pulseaudio bluetooth modules to use this new API, so it would
> take me longer time.

Hi! I looked at it. But I do not know how to implement
GetManagedObjects() method via libdbus properly. Any idea?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--7t6vwjx5czol3o3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXTSK6QAKCRCL8Mk9A+RD
UsiNAKC87jE9gV3eXQhDk3YJi3lR+Ud2cgCbBnsudwzxI98dCghoBnSJ8T8j4r4=
=qtUl
-----END PGP SIGNATURE-----

--7t6vwjx5czol3o3p--
