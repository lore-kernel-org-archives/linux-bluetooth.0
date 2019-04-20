Return-Path: <SRS0=jtTj=SW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBC7C282DD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Apr 2019 07:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2B221479
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Apr 2019 07:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REQoYwIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfDTHBE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Apr 2019 03:01:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51856 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTHBD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Apr 2019 03:01:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so8312306wmf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2019 00:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o3rLcw+l9M3HfWsnllSlHU2pjY84Abn3pKTN01JGXnI=;
        b=REQoYwIvI/NnilU21VUeG5ZFxs43/83Tc2bs5peyDbU+jHmpA4QbqNq+s+0sbS3d3r
         saHhbfBO6CtdMC8BFs9tGyTHnQCymuXk632PRrQsO+/Z5q2mLK/tZPYXw1L+kIWSb22/
         DOVdOgNJibH3Jngk39vaseJaEGiNBZYJlAQ42Ee9yBFm7fEK2eoq9HWnwQ/6Og0owvk3
         gfMys8nLhStXO2zOvzOKUr9q6Mu2mPp6M5XU4OxjYHJwvRh5cdioIkddNRWdzii09b2q
         Zlx22rofmCF4LuxZSkTuZ5DiQbTTRQCBzTFzYK/Tkrk98yZJWJuXeJSfBXbF6v1DHJdc
         CJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o3rLcw+l9M3HfWsnllSlHU2pjY84Abn3pKTN01JGXnI=;
        b=q1lNe6p89UoDrQ/ZLIPmgkvLgdLAPzwohs5wbdhEblNrORsJWwdeMsMjXP6/4/3921
         GT8iqIjlAx1SX3Hc4Yd1rvkmrgQYLUTnirK9tw2l51z9uXsNgx2PgiOrzHpX0we4/jLp
         AF63kJN8Gd4uh8T1R/suoHjBfZGw+0QXOvbMNp7VrElzbc4W7d0zpnIRdeZM+zKZgutt
         qgRBB1LacrKLv/lvHrcy6YC2Gd0TYCt13fA4I02jM0mZaaC42BpRmQTB8RpKihBEVBH8
         fXJURh5A2724aB79Rm8BST6u8DFZkccXegFrKYMQ6DKwJ+sQ6D5Zzba1mA1inPjl/hro
         7hyA==
X-Gm-Message-State: APjAAAXjPl00AiQJbzmkBNFURseuQnneXHoGUCi0p3HBMsvQbafn0bXR
        tzUVv8f0zIPKFYTezPJRTP0=
X-Google-Smtp-Source: APXvYqyi8Uf4q51Ia/1p0xaGj3V/alDbQ9LhV1I2+cb/IUnfSU6dXARB+yY3ZG9/MHp6yQbMp6aIwA==
X-Received: by 2002:a1c:f702:: with SMTP id v2mr5325497wmh.0.1555743661049;
        Sat, 20 Apr 2019 00:01:01 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u17sm5195826wmj.1.2019.04.20.00.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 00:00:59 -0700 (PDT)
Date:   Sat, 20 Apr 2019 09:00:58 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
Message-ID: <20190420070058.3wn2ikabgrtmgqze@pali>
References: <20190122175622.dj6riiim6zukpetw@pali>
 <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
 <20190127020038.q3hm5h7xl2ku6fse@pali>
 <20190327111430.6gliqodnnojsifjd@pali>
 <20190419080348.fbgs55qqs3j2yovb@pali>
 <CABBYNZLNBFVNh42eQ-SDeRPKpS96AUdOsoN3jqZgHSvHfRwxOQ@mail.gmail.com>
 <20190419110159.7tec3yejhh4lnokb@pali>
 <CABBYNZLEGBErmSiJAUV=+6b1SvXh98ExiMmMDkh3p=MqP53gzQ@mail.gmail.com>
 <20190419120455.ojjvok6cvp24jxd6@pali>
 <CABBYNZ+PAyJun4=3Rq0C-iKqhCeFKfUtVEgTBMNFu36HXh=amA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bsgjjt6u32shuj4h"
Content-Disposition: inline
In-Reply-To: <CABBYNZ+PAyJun4=3Rq0C-iKqhCeFKfUtVEgTBMNFu36HXh=amA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--bsgjjt6u32shuj4h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 20 April 2019 09:43:17 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Fri, Apr 19, 2019 at 3:04 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > On Friday 19 April 2019 14:48:38 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Fri, Apr 19, 2019 at 2:02 PM Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> > > >
> > > > On Friday 19 April 2019 13:04:01 Luiz Augusto von Dentz wrote:
> > > > > Hi Pali,
> > > > >
> > > > > On Fri, Apr 19, 2019 at 11:03 AM Pali Roh=C3=A1r <pali.rohar@gmai=
l.com> wrote:
> > > > > >
> > > > > > On Wednesday 27 March 2019 12:14:30 Pali Roh=C3=A1r wrote:
> > > > > > > On Sunday 27 January 2019 03:00:38 Pali Roh=C3=A1r wrote:
> > > > > > > > On Wednesday 23 January 2019 13:24:22 Luiz Augusto von Dent=
z wrote:
> > > > > > > > > Hi Pali,
> > > > > > > > > On Tue, Jan 22, 2019 at 7:56 PM Pali Roh=C3=A1r <pali.roh=
ar@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tuesday 22 January 2019 16:20:12 Luiz Augusto von De=
ntz wrote:
> > > > > > > > > > > Hi Pali,
> > > > > > > > > > > On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von Dentz
> > > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.=
com>
> > > > > > > > > > > >
> > > > > > > > > > > > This adds the possibility to expose remote SEP usin=
g MediaEndpoint
> > > > > > > > > > > > interface to allow setting a configuration.
> > > > > > > > > > > > ---
> > > > > > > > > > > >  doc/media-api.txt | 27 +++++++++++++++++++++++++--
> > > > > > > > > > > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > > > > > > > > > index b5ad2db12..af9485342 100644
> > > > > > > > > > > > --- a/doc/media-api.txt
> > > > > > > > > > > > +++ b/doc/media-api.txt
> > > > > > > > > > > > @@ -500,14 +500,23 @@ Properties        object Play=
er [readonly]
> > > > > > > > > > > >  MediaEndpoint1 hierarchy
> > > > > > > > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > > >
> > > > > > > > > > > > -Service                unique name
> > > > > > > > > > > > +Service                unique name (Server role)
> > > > > > > > > > > > +               org.bluez (Client role)
> > > > > > > > > > > >  Interface      org.bluez.MediaEndpoint1
> > > > > > > > > > > > -Object path    freely definable
> > > > > > > > > > > > +Object path    freely definable (Server role)
> > > > > > > > > > > > +               [variable prefix]/{hci0,hci1,...}/d=
ev_XX_XX_XX_XX_XX_XX/sepX
> > > > > > > > > > > > +               (Client role)
> > > > > > > > > > > >
> > > > > > > > > > > >  Methods                void SetConfiguration(objec=
t transport, dict properties)
> > > > > > > > > > > >
> > > > > > > > > > > >                         Set configuration for the t=
ransport.
> > > > > > > > > > > >
> > > > > > > > > > > > +                       For client role transport m=
ust be set with a server
> > > > > > > > > > > > +                       endpoint oject which will b=
e configured and the
> > > > > > > > > > > > +                       properties must contain the=
 following properties:
> > > > > > > > > > > > +
> > > > > > > > > > > > +                               array{byte} Capabil=
ities
> > > > > > > > > > > > +
> > > > > > > > > > > >                 array{byte} SelectConfiguration(arr=
ay{byte} capabilities)
> > > > > > > > > > > >
> > > > > > > > > > > >                         Select preferable configura=
tion from the supported
> > > > > > > > > > > > @@ -532,6 +541,20 @@ Methods            void SetCon=
figuration(object transport, dict properties)
> > > > > > > > > > > >                         endpoint, because when this=
 method gets called it has
> > > > > > > > > > > >                         already been unregistered.
> > > > > > > > > > > >
> > > > > > > > > > > > +Properties     string UUID [readonly, optional]:
> > > > > > > > > > > > +
> > > > > > > > > > > > +                       UUID of the profile which t=
he endpoint is for.
> > > > > > > > > > > > +
> > > > > > > > > > > > +               byte Codec [readonly, optional]:
> > > > > > > > > > > > +
> > > > > > > > > > > > +                       Assigned number of codec th=
at the endpoint implements.
> > > > > > > > > > > > +                       The values should match the=
 profile specification which
> > > > > > > > > > > > +                       is indicated by the UUID.
> > > > > > > > > > > > +
> > > > > > > > > > > > +               array{byte} Capabilities [readonly,=
 optional]:
> > > > > > > > > > > > +
> > > > > > > > > > > > +                       Capabilities blob, it is us=
ed as it is so the size and
> > > > > > > > > > > > +                       byte order must match.
> > > > > > > > > > > >
> > > > > > > > > > > >  MediaTransport1 hierarchy
> > > > > > > > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.17.2
> > > > > > > > > > >
> > > > > > > > > > > Can you try this set?
> > > > > > > > > >
> > > > > > > > > > Hi! In V3 you added only "a2dp: Add reverse discovery" =
patch right?
> > > > > > > > > > I tested my setup also with this patch and there is no =
difference,
> > > > > > > > > > pulseaudio is working fine :-)
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Applied.
> > > > > > > >
> > > > > > > > Hi! I have one bug report for these patches.
> > > > > > > >
> > > > > > > > When I manually disconnect A2DP profile, but let HFP active=
 then all SEP
> > > > > > > > paths on D-Bus disappear.
> > > > > > > >
> > > > > > > >   qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_=
XX_XX org.bluez.Device1.DisconnectProfile 0000110b-0000-1000-8000-00805f9b3=
4fb
> > > > > > > >
> > > > > > > > So pulseaudio would still see bluetooth device as active (b=
ecause HFP is
> > > > > > > > in use), but does not see any A2DP codec as all remote SEPs=
 from DBus
> > > > > > > > were removed.
> > > > > > > >
> > > > > > > > It is possible to not remove remote SEPs when A2DP sink pro=
file is
> > > > > > > > manually disconnected?
> > > > > > >
> > > > > > > Hi Luiz! Have you looked at above problem?
> > > > > >
> > > > > > Hi! This one problem is still there.
> > > > >
> > > > > This should have been fixed:
> > > > >
> > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D9=
f7659a44601e043bdb6724b0ab4f3f59c46e9fe
> > > >
> > > > Hi! It is still not fixed. I have that commit applied (it is in mas=
ter
> > > > branch), but SEPs still disappears from dbus after calling
> > > > DisconnectProfile 0000110b-0000-1000-8000-00805f9b34fb as described
> > > > above; even HFP/HSP is still active.
> > > >
> > > > Can you reproduce that problem?
> > >
> > > We remove the objects when we disconnect AVDTP, this is working as
> > > intended as we don't want to initiate the connection directly from the
> > > endpoint as those may have disappeared or changed to some other codec
> > > while disconnected.
> >
> > That is a bit problematic. Pulseaudio see device as active when either
> > A2DP or HFP/HSP profile is connected. It makes sense. But when A2DP is
> > disconnected then bluez remove SEP from dbus which says to pulseaudio
> > that all codecs (as they belongs to SEPs) are unsupported. Which leads
> > to situation that pulseaudio has no idea which codecs are supported nor
> > if A2DP is supported at all.
>=20
> Usually, all audio profiles are connected simultaneously, we even have
> a policy plugin to enforce this. Also keep in mind that we never
> intend to PulseAudio to trigger connections, for that you use the
> Bluetooth system settings.

Look, I'm able to achieve state when A2DP is not connected and HFP/HSP
is. Only via public dbus API. So such thing is possible and it could be
available in the future in some program (command line or bluetooth gui).

And as this state is not only possible, but also valid then pulseaudio
needs to deal with it.

And as you wrote that pulseaudio should not trigger connection, how it
should know list of available codecs?

> > So if bluez remove all SEPs from dbus, how can pulseaudio again activate
> > A2DP connection with codec X? It is impossible as SEP endpoint exported
> > by dbus does not exist anymore.
>=20
> It doesn't, if you want to reconnect that should be triggered via
> Device.Connect, the daemon will remember the last connected SEP and do
> the right thing, if the user wants to later overwrite the default it
> is free to do so by selecting a different SEP.

A2DP is connected, HSP is. Currently HSP audio output is used in
pulseaudio and user want to switch it to codec X. bluez has remembered
codec Y (but this information is not available to pulseaudio).

How should now pulseaudio activate A2DP with codec X?

> So, in short, it is a
> design choice not to support connecting directly from SEP, anyway in
> most cases that would not even be possible since the device should not
> be connected PA would not list any audio device for it.

If device is not connected then pulseaudio does not list audio device.

But if HSP is connected and A2DP not, then pulseaudio show that
bluetooth audio device.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--bsgjjt6u32shuj4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXLrDqAAKCRCL8Mk9A+RD
UoAqAJ9xt54+LxpgNPClvmgLWc4vD5YFOQCgyhGTgB2vJONgBsd4n07V5ZIznjE=
=osex
-----END PGP SIGNATURE-----

--bsgjjt6u32shuj4h--
