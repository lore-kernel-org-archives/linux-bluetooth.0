Return-Path: <SRS0=3wSE=QD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D9BC282C8
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Jan 2019 02:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AAB217D7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Jan 2019 02:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHi/oxOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfA0CAn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jan 2019 21:00:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36585 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfA0CAn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jan 2019 21:00:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so14186249wrp.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jan 2019 18:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0dc6M+QmIm30t8vM1KC3JUNxWvTO+ke58NfZsdDfyOM=;
        b=hHi/oxOSK2/1ld3mT5yBH6m2m/nl6jMJm5DhHrUDP4d8+0o44VPArwB2VQeJ2kc7Z5
         Cq5xQN98Cxj95ndmZ5RyItrK60uWwEx8bV7SHCdIAHKeQ9HHtwTspx4/vGvS8WQxz5iQ
         6eTGbkRTMNsZBmgomnG/LBqGY/4uEl/iPsy1ti7VjeG9cXlGzyPoVpt8BcXGEc+d5LI6
         PRE3Mg4rmc4iQn54nQ5oyIv0eP/9Q4nMmtZrD2VbfQBBt7RzEHGbMP+hjw3YJyDXl1NL
         5mF390W5XQWwG/c/ANh65b0KK+EbIXAvbMmC5YkHSOOsLZ0Wl0j6Aq4/ZODuslv8Ei/K
         9qBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0dc6M+QmIm30t8vM1KC3JUNxWvTO+ke58NfZsdDfyOM=;
        b=GEMilfLKJ0vZtkCaYc6wjXD9sHQspTPtnd6OMYtkN3Yd0UH+Lm/QwLt5NLsT9IqC2t
         NgU+xLEi3RBaCzyxJAr8r8nsfykEnBy7Nlb7YMUG4GKMAmRk78k7Hx/lLR8y7X/MrK+3
         Qxl55F5annHNrTctmowmOVkcuNWlfw1sJMhqtwL17HZoB1wCuwEKxbTnZJ+4+7IB3cfH
         pBa2fRRjIXIS/d7rgjn4MIc75bZ1/1qNtlOsnoPiCZmVx4xHbEINPdgfixoeT3xXEgTJ
         BLSYgGHR4sdGFO6Im//2iVapGNcuRZf1S6p3cp5pMlOHiDZx33mxPb0SWuj1i+ZmuuPH
         RmSQ==
X-Gm-Message-State: AJcUukcu4vPrH9DQ+worBXz21LvX5SNbNE/k0dz7LKLrtBryiDva0ITu
        SPFlQOaECWaavauGXjZs8TgbJaX6
X-Google-Smtp-Source: ALg8bN7tLGR7ACyOztvn1uDGtnn/hWSpmfpTTTW6OJ5D/kFVFbI4Y9QGDyV/+3iUwk2CndB4YZyIWA==
X-Received: by 2002:adf:8544:: with SMTP id 62mr17244608wrh.1.1548554440808;
        Sat, 26 Jan 2019 18:00:40 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id h1sm45263439wmb.0.2019.01.26.18.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 18:00:39 -0800 (PST)
Date:   Sun, 27 Jan 2019 03:00:38 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
Message-ID: <20190127020038.q3hm5h7xl2ku6fse@pali>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
 <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
 <20190122175622.dj6riiim6zukpetw@pali>
 <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="meydeeqaadvqdk5t"
Content-Disposition: inline
In-Reply-To: <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--meydeeqaadvqdk5t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 23 January 2019 13:24:22 Luiz Augusto von Dentz wrote:
> Hi Pali,
> On Tue, Jan 22, 2019 at 7:56 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > On Tuesday 22 January 2019 16:20:12 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > > On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > This adds the possibility to expose remote SEP using MediaEndpoint
> > > > interface to allow setting a configuration.
> > > > ---
> > > >  doc/media-api.txt | 27 +++++++++++++++++++++++++--
> > > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > index b5ad2db12..af9485342 100644
> > > > --- a/doc/media-api.txt
> > > > +++ b/doc/media-api.txt
> > > > @@ -500,14 +500,23 @@ Properties        object Player [readonly]
> > > >  MediaEndpoint1 hierarchy
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > >
> > > > -Service                unique name
> > > > +Service                unique name (Server role)
> > > > +               org.bluez (Client role)
> > > >  Interface      org.bluez.MediaEndpoint1
> > > > -Object path    freely definable
> > > > +Object path    freely definable (Server role)
> > > > +               [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_X=
X_XX/sepX
> > > > +               (Client role)
> > > >
> > > >  Methods                void SetConfiguration(object transport, dic=
t properties)
> > > >
> > > >                         Set configuration for the transport.
> > > >
> > > > +                       For client role transport must be set with =
a server
> > > > +                       endpoint oject which will be configured and=
 the
> > > > +                       properties must contain the following prope=
rties:
> > > > +
> > > > +                               array{byte} Capabilities
> > > > +
> > > >                 array{byte} SelectConfiguration(array{byte} capabil=
ities)
> > > >
> > > >                         Select preferable configuration from the su=
pported
> > > > @@ -532,6 +541,20 @@ Methods            void SetConfiguration(objec=
t transport, dict properties)
> > > >                         endpoint, because when this method gets cal=
led it has
> > > >                         already been unregistered.
> > > >
> > > > +Properties     string UUID [readonly, optional]:
> > > > +
> > > > +                       UUID of the profile which the endpoint is f=
or.
> > > > +
> > > > +               byte Codec [readonly, optional]:
> > > > +
> > > > +                       Assigned number of codec that the endpoint =
implements.
> > > > +                       The values should match the profile specifi=
cation which
> > > > +                       is indicated by the UUID.
> > > > +
> > > > +               array{byte} Capabilities [readonly, optional]:
> > > > +
> > > > +                       Capabilities blob, it is used as it is so t=
he size and
> > > > +                       byte order must match.
> > > >
> > > >  MediaTransport1 hierarchy
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > --
> > > > 2.17.2
> > >
> > > Can you try this set?
> >
> > Hi! In V3 you added only "a2dp: Add reverse discovery" patch right?
> > I tested my setup also with this patch and there is no difference,
> > pulseaudio is working fine :-)
> >
>=20
> Applied.

Hi! I have one bug report for these patches.

When I manually disconnect A2DP profile, but let HFP active then all SEP
paths on D-Bus disappear.

  qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX org.bluez.=
Device1.DisconnectProfile 0000110b-0000-1000-8000-00805f9b34fb

So pulseaudio would still see bluetooth device as active (because HFP is
in use), but does not see any A2DP codec as all remote SEPs from DBus
were removed.

It is possible to not remove remote SEPs when A2DP sink profile is
manually disconnected?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--meydeeqaadvqdk5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXE0QwwAKCRCL8Mk9A+RD
UobOAJ9OzediAGamtkKFleG+7AjeJbCeeACggGudsQZ+zkv0qGlkvnoO6t0jFIk=
=kH82
-----END PGP SIGNATURE-----

--meydeeqaadvqdk5t--
