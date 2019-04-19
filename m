Return-Path: <SRS0=AkUh=SV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722B3C282DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 18:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24870205ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 18:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS9bP8kL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfDSS6f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:58:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35215 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbfDSS6e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Apr 2019 14:58:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id o12so4613726wrn.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2019 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sV1BpmqHG/FwMI4OkOyLfSF0KCvdn1JDLP1l4m/WblA=;
        b=jS9bP8kLnZ+bKtbjIU+CCf/XergnMUKk/p9eneHglMZRd4lb8xDpjjp27oqZGgCmog
         8NBOj/1soV4z5MZyCjDXE/y+ce9jU8056/du8TJQ2hxR0yzaVF/2zCwYKdthhUYAdsiF
         Vybw9nShi6h1XifTfbaGo2yuDHiN7ypwWCiOWZOtpz0tAZb4Aa+b9Z8hsEkW7Y4/wZnd
         ZStxC/UTXakGYNS3qopte48d2/M/NUjPQqRBB7XoWFKxePVD8Gj8vHNQP/buiaHuwd+S
         Zdtoa6zoSlBzhkyfWSYQtO/LHERd8jwawbfi3L5xWx/jT99ZAM+AVntO53e6llxDNt3b
         GhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sV1BpmqHG/FwMI4OkOyLfSF0KCvdn1JDLP1l4m/WblA=;
        b=o9Kr8YdbUcqd1fU0Z7o8hzR7dc7/e9Z/2i0MHF6ggrRUtdQUUXwlakz8JMy3zbaVRX
         W3Mu3mNehybAL8MCbUPf3+Am3W25jrSJGC27wzD7ks9gewB+tcZm6GqS1niVPKsGD9iD
         YBPRikfzIbvih3f7v2FccalheczE4b3mPk/8CCGGZkBA8IHzKFMqcZo01IUvnHd9ybK+
         W4rwPM9PxjYo94ZdJqXDwykHnN+IB0YPTu22S2CO6+crl+1hU4VLgqczT1NwkYM7cxXd
         nx30uZ16gP+SPpghZMWWwPmFOv0heC2qDdj9oz1BCfNCPvL/B++pjwXDw4oB4Z+RGe7C
         Xy2w==
X-Gm-Message-State: APjAAAUEL58TdD52xg/Wvc41vkLBUBu3fO5xxlIWJmbVGS4SsA9lS/mB
        aOQ+LntIz0tPUUwrNmVLWzvaYQ1C
X-Google-Smtp-Source: APXvYqxTPYD+okoag9DF9fTBcNvBAqIheRlnSefw9IL2Ks16Jub9ArdVqlYyy1AeDXFHZd5u0nosvw==
X-Received: by 2002:adf:edca:: with SMTP id v10mr2616724wro.157.1555675497780;
        Fri, 19 Apr 2019 05:04:57 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t76sm6581962wmt.8.2019.04.19.05.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 05:04:56 -0700 (PDT)
Date:   Fri, 19 Apr 2019 14:04:55 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
Message-ID: <20190419120455.ojjvok6cvp24jxd6@pali>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
 <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
 <20190122175622.dj6riiim6zukpetw@pali>
 <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
 <20190127020038.q3hm5h7xl2ku6fse@pali>
 <20190327111430.6gliqodnnojsifjd@pali>
 <20190419080348.fbgs55qqs3j2yovb@pali>
 <CABBYNZLNBFVNh42eQ-SDeRPKpS96AUdOsoN3jqZgHSvHfRwxOQ@mail.gmail.com>
 <20190419110159.7tec3yejhh4lnokb@pali>
 <CABBYNZLEGBErmSiJAUV=+6b1SvXh98ExiMmMDkh3p=MqP53gzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="krkgqb6ad3bkqvr3"
Content-Disposition: inline
In-Reply-To: <CABBYNZLEGBErmSiJAUV=+6b1SvXh98ExiMmMDkh3p=MqP53gzQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--krkgqb6ad3bkqvr3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 19 April 2019 14:48:38 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Fri, Apr 19, 2019 at 2:02 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > On Friday 19 April 2019 13:04:01 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Fri, Apr 19, 2019 at 11:03 AM Pali Roh=C3=A1r <pali.rohar@gmail.co=
m> wrote:
> > > >
> > > > On Wednesday 27 March 2019 12:14:30 Pali Roh=C3=A1r wrote:
> > > > > On Sunday 27 January 2019 03:00:38 Pali Roh=C3=A1r wrote:
> > > > > > On Wednesday 23 January 2019 13:24:22 Luiz Augusto von Dentz wr=
ote:
> > > > > > > Hi Pali,
> > > > > > > On Tue, Jan 22, 2019 at 7:56 PM Pali Roh=C3=A1r <pali.rohar@g=
mail.com> wrote:
> > > > > > > >
> > > > > > > > On Tuesday 22 January 2019 16:20:12 Luiz Augusto von Dentz =
wrote:
> > > > > > > > > Hi Pali,
> > > > > > > > > On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von Dentz
> > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > > > > >
> > > > > > > > > > This adds the possibility to expose remote SEP using Me=
diaEndpoint
> > > > > > > > > > interface to allow setting a configuration.
> > > > > > > > > > ---
> > > > > > > > > >  doc/media-api.txt | 27 +++++++++++++++++++++++++--
> > > > > > > > > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > > > > > > > index b5ad2db12..af9485342 100644
> > > > > > > > > > --- a/doc/media-api.txt
> > > > > > > > > > +++ b/doc/media-api.txt
> > > > > > > > > > @@ -500,14 +500,23 @@ Properties        object Player [=
readonly]
> > > > > > > > > >  MediaEndpoint1 hierarchy
> > > > > > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > > > > > > >
> > > > > > > > > > -Service                unique name
> > > > > > > > > > +Service                unique name (Server role)
> > > > > > > > > > +               org.bluez (Client role)
> > > > > > > > > >  Interface      org.bluez.MediaEndpoint1
> > > > > > > > > > -Object path    freely definable
> > > > > > > > > > +Object path    freely definable (Server role)
> > > > > > > > > > +               [variable prefix]/{hci0,hci1,...}/dev_X=
X_XX_XX_XX_XX_XX/sepX
> > > > > > > > > > +               (Client role)
> > > > > > > > > >
> > > > > > > > > >  Methods                void SetConfiguration(object tr=
ansport, dict properties)
> > > > > > > > > >
> > > > > > > > > >                         Set configuration for the trans=
port.
> > > > > > > > > >
> > > > > > > > > > +                       For client role transport must =
be set with a server
> > > > > > > > > > +                       endpoint oject which will be co=
nfigured and the
> > > > > > > > > > +                       properties must contain the fol=
lowing properties:
> > > > > > > > > > +
> > > > > > > > > > +                               array{byte} Capabilities
> > > > > > > > > > +
> > > > > > > > > >                 array{byte} SelectConfiguration(array{b=
yte} capabilities)
> > > > > > > > > >
> > > > > > > > > >                         Select preferable configuration=
 from the supported
> > > > > > > > > > @@ -532,6 +541,20 @@ Methods            void SetConfigu=
ration(object transport, dict properties)
> > > > > > > > > >                         endpoint, because when this met=
hod gets called it has
> > > > > > > > > >                         already been unregistered.
> > > > > > > > > >
> > > > > > > > > > +Properties     string UUID [readonly, optional]:
> > > > > > > > > > +
> > > > > > > > > > +                       UUID of the profile which the e=
ndpoint is for.
> > > > > > > > > > +
> > > > > > > > > > +               byte Codec [readonly, optional]:
> > > > > > > > > > +
> > > > > > > > > > +                       Assigned number of codec that t=
he endpoint implements.
> > > > > > > > > > +                       The values should match the pro=
file specification which
> > > > > > > > > > +                       is indicated by the UUID.
> > > > > > > > > > +
> > > > > > > > > > +               array{byte} Capabilities [readonly, opt=
ional]:
> > > > > > > > > > +
> > > > > > > > > > +                       Capabilities blob, it is used a=
s it is so the size and
> > > > > > > > > > +                       byte order must match.
> > > > > > > > > >
> > > > > > > > > >  MediaTransport1 hierarchy
> > > > > > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > --
> > > > > > > > > > 2.17.2
> > > > > > > > >
> > > > > > > > > Can you try this set?
> > > > > > > >
> > > > > > > > Hi! In V3 you added only "a2dp: Add reverse discovery" patc=
h right?
> > > > > > > > I tested my setup also with this patch and there is no diff=
erence,
> > > > > > > > pulseaudio is working fine :-)
> > > > > > > >
> > > > > > >
> > > > > > > Applied.
> > > > > >
> > > > > > Hi! I have one bug report for these patches.
> > > > > >
> > > > > > When I manually disconnect A2DP profile, but let HFP active the=
n all SEP
> > > > > > paths on D-Bus disappear.
> > > > > >
> > > > > >   qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_X=
X org.bluez.Device1.DisconnectProfile 0000110b-0000-1000-8000-00805f9b34fb
> > > > > >
> > > > > > So pulseaudio would still see bluetooth device as active (becau=
se HFP is
> > > > > > in use), but does not see any A2DP codec as all remote SEPs fro=
m DBus
> > > > > > were removed.
> > > > > >
> > > > > > It is possible to not remove remote SEPs when A2DP sink profile=
 is
> > > > > > manually disconnected?
> > > > >
> > > > > Hi Luiz! Have you looked at above problem?
> > > >
> > > > Hi! This one problem is still there.
> > >
> > > This should have been fixed:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D9f765=
9a44601e043bdb6724b0ab4f3f59c46e9fe
> >
> > Hi! It is still not fixed. I have that commit applied (it is in master
> > branch), but SEPs still disappears from dbus after calling
> > DisconnectProfile 0000110b-0000-1000-8000-00805f9b34fb as described
> > above; even HFP/HSP is still active.
> >
> > Can you reproduce that problem?
>=20
> We remove the objects when we disconnect AVDTP, this is working as
> intended as we don't want to initiate the connection directly from the
> endpoint as those may have disappeared or changed to some other codec
> while disconnected.

That is a bit problematic. Pulseaudio see device as active when either
A2DP or HFP/HSP profile is connected. It makes sense. But when A2DP is
disconnected then bluez remove SEP from dbus which says to pulseaudio
that all codecs (as they belongs to SEPs) are unsupported. Which leads
to situation that pulseaudio has no idea which codecs are supported nor
if A2DP is supported at all.

So if bluez remove all SEPs from dbus, how can pulseaudio again activate
A2DP connection with codec X? It is impossible as SEP endpoint exported
by dbus does not exist anymore.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--krkgqb6ad3bkqvr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXLm5ZgAKCRCL8Mk9A+RD
UmF1AJ4kfK827T/L8sgkpiAa1EoYZhYuZACeJyt9D+OIwsdOOcLgu6l2dOkbdH8=
=hEbT
-----END PGP SIGNATURE-----

--krkgqb6ad3bkqvr3--
