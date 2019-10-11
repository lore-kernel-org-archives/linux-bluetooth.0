Return-Path: <SRS0=4il6=YE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78221C47404
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 20:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D6C21835
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 20:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihFezdBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfJKUEY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:04:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54134 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbfJKUEY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Oct 2019 16:04:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so11568323wmd.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2019 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n7vMcy4tIIesKJHdpO1OY/PSHKoB6gRoFPy7zySND84=;
        b=ihFezdBzZlmHfKl6Q2tHYXQfcGmzLA6D7SxkhMfybKPRlPb7SQNHSqexLutsAaLl0g
         780H+lfZjOzVp0Jgde1twn+wp6z5MsutoCEGTre1rUVqerPLNWx4+9g0nWRtb31aZd4p
         QBYrKdZvZ7l25ruxGGt0rp4UJsR3pE40pGOuvbui67LP4nblRznOsTFBzXLgmliUDPpg
         WjKJsBSC95wbxcfKhDh2PllmNezROZC+H8PorrogbTXl9Qt2TdsmAxbNX290ttkkdW01
         VMq0AEUCrsfTz/kWqCaAZW9R0Esz6lQMKmuoAEjttIhn7oMl70d3cHhHLYfREnLIG9wN
         Q1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n7vMcy4tIIesKJHdpO1OY/PSHKoB6gRoFPy7zySND84=;
        b=ROhGvWs0f1vzMKa7FQEoT4IO9G19rIJp3wU9i/zz0T71RYIB4SfjB8Ssw/oxEPPxOH
         5Y5RTlns0WjieEDb33vF4fSLM/k8REH4bQCqFLUZnI9yYDNUxyjplYMDIDOaCC50LCxv
         rnJ57RI38noSWOBuqCtryHl1QD1JF3Olg7XFw1Yc0HbMrXHXOhMFtDdNeCT6/0qhOih1
         D73vRmziJl883iLjHXRlKz0YLyH/vNLMOCeyaCv8YLvdx8zT1Y6CrlVVlUOeEgbGZAMJ
         hbr4JmPHfywL5FYKBqGHTFtnNJa3yB/Os7wO5rx2pccaHFi6Aq4WKr20F5jjaVSUnfFU
         P/1Q==
X-Gm-Message-State: APjAAAVWaSWiH7J8NATaezwDCETNGLJbOnOu0R0iQxg3alvFKs8tSQWN
        w9DyqztU0/oecP06Ju5j0VwCshkk
X-Google-Smtp-Source: APXvYqzEghqkFLbVFJ4AAkrq/4qS4NB0Io+C2K5FgEQ8toVayK9uagHljYAzK4ErgHtPiYZFni+K4A==
X-Received: by 2002:a1c:1f54:: with SMTP id f81mr4749484wmf.142.1570824262749;
        Fri, 11 Oct 2019 13:04:22 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v8sm14225940wra.79.2019.10.11.13.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 13:04:21 -0700 (PDT)
Date:   Fri, 11 Oct 2019 22:04:20 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "iam@valdikss.org.ru" <iam@valdikss.org.ru>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Determinate EDR speed
Message-ID: <20191011200420.hbrutdclfva2uqpv@pali>
References: <20191011082723.t6w2jcg7v4erlnq6@pali>
 <319f751481bbdb5aa012e5fa4daa1d95965b54c3.camel@intel.com>
 <20191011183502.ao45xlyfabpbadxo@pali>
 <fea0a8efd80c4c444f56d4f3902aeae4f4f9de32.camel@intel.com>
 <64060b6a2bc9aee7b7eef0347ee3bafe3fddd18b.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="h242c63yzlp34kqw"
Content-Disposition: inline
In-Reply-To: <64060b6a2bc9aee7b7eef0347ee3bafe3fddd18b.camel@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--h242c63yzlp34kqw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 11 October 2019 19:05:56 Gix, Brian wrote:
> On Fri, 2019-10-11 at 19:00 +0000, Gix, Brian wrote:
> > Hi Pali,
> >=20
> > On Fri, 2019-10-11 at 20:35 +0200, Pali Roh=C3=A1r wrote:
> > > Currently bluez API, method Acquire() already inform called applicati=
on
> > > what is socket MTU for input and output. So from this information it =
is
> > > possible to detect if device supports EDR 3 or not.
> > >=20
> > > But it is too late to have this information. I need to send SBC
> > > parameters to bluez first when doing A2DP negotiation, this is early
> > > steps before Acquire() is called.
> >=20
> > This seems to be the kind of information which is fixed, for the life o=
f the pairing.
> >=20
> > What if you assumed the lower speed the first time you connected, deter=
mined the
> > speed during the first streaming, and then either immediately renegotia=
te (caching the identifying
> > information
> > of the SNK), or just cache the information for future connections.
> >=20
> > Or the reverse, and assume fast, but immediately adjust down if you are=
n't getting what you hoped for.
> >=20
> > In any case, this would be a "Device Setup" glitch which you could note=
 as a routine part of pairing in the
> > documentation.
>=20
> Or, Stream "Silence" the first time you connect, in order to determine th=
roughput.  It would add 1-2 seconds to
> your connection time perhaps, but would be less noticable to the user.

This increase connection time, increase complexity of implementation
(lot of things can fail) and just complicate lot of things there. Plus
adds that glitch which is not user friendly.

Also bluetooth devices, like headsets, probably do not expects that
somebody is going to do such thing and we can hit other implementation
problems...

And moreover it is just big hack and workaround for that problem. Not a
reasonable solution.

In btmon I can see it, so kernel already knows that information. Why it
cannot tell it to userspace and bluetooth daemon to client application?

Client application (e.g. pulseaudio) should really know if is going to
talk with bluetooth device with EDR 2 or EDR 3.

> >=20
> > > Therefore I'm asking for some way how to get information if device
> > > supports EDR 2 or EDR 3. This is basically requirement for proper
> > > implementation of SBC in high quality mode. So if there are not such =
API
> > > yet, could it be exported from kernel to userspace and bluetoothd
> > > daemon?
> > >=20
> > > See these two articles for more details about SBC and its high qualit=
y:
> > >=20
> > > https://habr.com/en/post/456182/
> > > http://soundexpert.org/articles/-/blogs/audio-quality-of-sbc-xq-bluet=
ooth-audio-codec
> > >=20
> > > > > Is there any bluez API for it?
> > > > >=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--h242c63yzlp34kqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXaDgQgAKCRCL8Mk9A+RD
UkOcAJ0Sj74ErJ8xB6jPFvP6l5M41jChBgCeKOSu53JxbU9iR2lNk7iNTy7Z/EA=
=oBIC
-----END PGP SIGNATURE-----

--h242c63yzlp34kqw--
