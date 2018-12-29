Return-Path: <SRS0=rkTY=PG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF73FC43387
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Dec 2018 13:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CBA2176F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Dec 2018 13:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IccEA8Vl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeL2NIX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Dec 2018 08:08:23 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:36224 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeL2NIX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Dec 2018 08:08:23 -0500
Received: by mail-wm1-f49.google.com with SMTP id p6so21524965wmc.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Dec 2018 05:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FWq/+RXnm+B5ywjB/58bOsz+hUSQzusnMX4vIwgn6D4=;
        b=IccEA8Vlml6wl86F7FvEzDPpPPoTzdQPZcqIjb0gW7Cbx7IhAN+Dl/UiHwc15xZPFp
         bQQrdT6cAGbdjNYIYwYyQne5uVhm7GuMBiB8toCzFrdSCi1m36TzXJODc+9cok+iY1uv
         lHGI1Bgk3pmJnSzqa6XuuhPHzcePabFUNz1cSaN3sZJF6yqBdez4E2anQ2lgQbAGqzpc
         EUnnnzEEdYyjzkfXIujhpKr1odDta+fGDRKww4ecl7d2uOzemNDnG6RFASCVezoWDPwr
         NGgkEPnpCQk/ZqsqoxaHqiq13pxrR+vZpv/NHouKcXY8S6+Na2qCzIG2zx/OO3feJL0M
         lTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FWq/+RXnm+B5ywjB/58bOsz+hUSQzusnMX4vIwgn6D4=;
        b=dYZEjsqj1wAveXD+JFixI1n2m0o5MiVI4O6J9hC54Gm6Vw8a40rtmG/DBPJzjV1WbC
         /QJ2TA42ctl9MbOE0RxJuwRKe69joozz0B5RuCrwwAiglFvD4W2VqqBjWwb020uUxOG5
         3e5dyFGK3EDXuojjaP9ZWYPu7QQxgqYiwj11XxZ/3mKGvlsh4+Vt/d1aO4ExUFjrX34/
         bd4VXky1/I79FyVxiqlz0vxf0gOVx0y+sKKeOpMen2dO1DGKzKJ7y9AZN+I4IVMLpWdl
         27eaHZpaQHpvkTrKWdywhc0Dz0WAejKG9eM1vhgiOHfM+Zcob+JnYhtGIr0eOIQsjQzB
         FH9Q==
X-Gm-Message-State: AJcUukcq+a4vF5pkjUwkUyZEYnwlMls6hUgUDQ3mYiA+EJQxuW5MBG8k
        RrVYGkLlKkn9xJA5yW7NG6A=
X-Google-Smtp-Source: AFSGD/XskDN3DBf/wsIiSYaT9NWMOugB6eqTyULwxhDJbtOiqTOp/6rQj8/WkAArmPOmjgtCqLuUfA==
X-Received: by 2002:a1c:5fd7:: with SMTP id t206mr28065125wmb.145.1546088900588;
        Sat, 29 Dec 2018 05:08:20 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id h17sm32039037wrt.59.2018.12.29.05.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Dec 2018 05:08:19 -0800 (PST)
Date:   Sat, 29 Dec 2018 14:08:18 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: dbus method call for switching endpoint
Message-ID: <20181229130818.jdcpwlpyoyhdqlf3@pali>
References: <20180711082352.oo6srapfnol5nkxq@pali>
 <CABBYNZJuGT5_zhg-BkAc4XjtVu5His92cHTujrin=SMOVbaodQ@mail.gmail.com>
 <20180711144501.ovdxc2expa4bg6sc@pali>
 <20181215202910.j24amjshrvjqprll@pali>
 <CABBYNZLK4tyL8nvWbXxr6VctyEyJkMdwNiWMy4gUge9h9Vb4SQ@mail.gmail.com>
 <20181228191102.GA31975@reaktio.net>
 <CABBYNZ+bwbSkH4qtkuzhE=JY6KAGwJ_E4ABGT_LE6E277eTNDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wfbz7odyvx2pauku"
Content-Disposition: inline
In-Reply-To: <CABBYNZ+bwbSkH4qtkuzhE=JY6KAGwJ_E4ABGT_LE6E277eTNDQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--wfbz7odyvx2pauku
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 28 December 2018 19:10:11 Luiz Augusto von Dentz wrote:
> Hi Pasi,
>=20
> On Fri, Dec 28, 2018 at 4:46 PM Pasi K=C3=A4rkk=C3=A4inen <pasik@iki.fi> =
wrote:
> >
> > Hi Luiz,
> >
> > On Tue, Dec 18, 2018 at 01:02:39PM -0300, Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Sat, Dec 15, 2018 at 5:29 PM Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> > > >
> > > > On Wednesday 11 July 2018 16:45:01 Pali Roh=C3=A1r wrote:
> > > > > On Wednesday 11 July 2018 16:27:07 Luiz Augusto von Dentz wrote:
> > > > > > One way to solve all of these is that we would expose the remote
> > > > > > endpoints using MediaEndpoint1
> > > > >
> > > > > So client application (like pulseadio) would see list of remote
> > > > > endpoints (one for each codec) and choose one for connection?
> > > > >
> > > > > Looks like this should solve this problem.
> > > >
> > > > Are there any progress on such API in bluez?
> > > >
> > > > On pulseaudio mailing list other people proposed patches for other =
A2DP
> > > > codecs and basically bluez API for choosing A2DP codec is still mis=
sing
> > > > part...
> > >
> > > Im currenlty on vacation but will try to find time for that, that said
> > > that shouldn't stop us to include support for other codecs, the last
> > > set seems to have some sort of priority for ordering the registration
> > > of the codecs.
> > >
> >
> > Let us know when you have something to see/try!
> > I'm happy to do testing of the patches.
> >
> > People are currently eager to get support for multiple BT audio codecs =
working and merged upstream :)
>=20
> Note that it is very unlikely that this API would allow multiple
> codecs at the same time, headsets normally only allow one
> configuration at time.

Multiple codecs at the same time is not needed.

> Making it possible to switch codecs is more of
> a workaround for headsets that don't honor the codec priority since
> they normally codec back, although some model no longer configure a
> stream just wait the source.

First thing is to provide list of supported codecs via dbus, so
pulseaudio would know which codecs remote device (headset) support. And
ideally tell it also to user.

Second thing which is needed, is ability to switch to different
supported codec. If headset supports 4 codecs, then user wants to switch
=66rom first codec to second and compare which is "better for him".

And third thing, some headsets remember last used codec for particular
notebook and when headset initialize connection it uses this codec.
So if pulseaudio (or any other application) adds support for a new
codec, which is also supported by that headset, then this codec would
not be used -- even when it has higher priority in pulseaudio.

I think probably all headsets (or at least majority of them) initialize
connection to last "notebook/phone" device after starting it up.

So priority defined by pulseaudio is not going to be used in above cases
and we need a way in pulseaudio to switch from one codec to another.

And forth thing, people lot of times listen music and their music is
stored in some lossy compression codecs (MP3, AAC, ...). A2DP supports
of these codecs and pulseaudio has already support for pass-through
different codec payloads to sound card (if sound card driver support
is). So this would allow us to e.g. pass-through MP3 or AAC data to
supported headset without need to decode and encode again. Pulseaudio in
this case can take care for switching from "better A2DP codec" to AAC
when input application source is already in AAC; and then back to that
previous "better A2DP codec" after AAC playback file finish.

I think that similar technique is already used in Apple products which
propagates AAC format.

Therefore I do not think switching codec is some king of workaround or
hack, but fully valid use case.

> Regarding the API I still didn't have time to start it, so it will
> take a little longer than I antecipated.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--wfbz7odyvx2pauku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXCdxwAAKCRCL8Mk9A+RD
UqujAJ9LW7l94ep4iuvvfbtyBm7ukRvSVwCfQFDxwKqOe9u0T7R/1JVoRdvZJ+g=
=WMgv
-----END PGP SIGNATURE-----

--wfbz7odyvx2pauku--
