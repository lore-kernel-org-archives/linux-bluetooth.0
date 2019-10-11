Return-Path: <SRS0=4il6=YE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213A8C47404
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 18:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E050421D7D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 18:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTuyYDO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfJKSfK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:35:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43981 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbfJKSfI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Oct 2019 14:35:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id j18so12960524wrq.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2019 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gFEMSvQzNw+NORdiy/bTnNItr4lwvnuxJRewNjG1apI=;
        b=jTuyYDO1ZKWgqRnCfVVhQIP0wUBakIAEtwXogUMtgxnPCl89kDd1WGDCom9a7Tw1pw
         tGymRrOLExr5ieFZ/hfnOD8X2jMda+WxWvhGQiWJksAVmmDmV7YJsieAn/efE+PL7EQz
         kn8CfGRtHgrfn440x0BxChIN6ivuMit9uAYhN6ypTOI5H4COYiSnq128+kKVHF3IHU32
         +s3AOQRjmWoV3CjyKn9LquzV5o6ga65cu7kl2N/tXSg9p2ARHJXl5qHDWZ/s0miTSVdm
         uAntuxkpiLWeFpX4oaxmibVrXomHv/j4eUj4Wy4jKbdobEgaZJvlhMm1I0K6bNfP+0rX
         5R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gFEMSvQzNw+NORdiy/bTnNItr4lwvnuxJRewNjG1apI=;
        b=dRvZIBfvp43PbgO23Xjk2YEUgaV09uRjyieAIKlQt+tY5EasNNwYl1nGnvDYLU8DsS
         mCDO2GTfauQcZqFWcZsJyopMLLkI4VjIRRcseV+iGr0zSEAflr3VCy4MA0tWjSQR5L2F
         LzZy+7hozhBeQvgxem0mlqsb/TYJ9G7++Jb4mlUPYHQmweQzlQ+V0416zQd+Rzv9ymcE
         rjsI+tLPqLkIl3fRJZ5XK6NQCT00Zo87XbT3VRtRYoGUFwi7sZ6dvbXaoUXDafnRUhJi
         VozV/apMU+drSWwwNf38s93mWbpDm1g9Je87ID0sLqo6FaLfGSA+hAtT9ubxVhW0eCRF
         JNYg==
X-Gm-Message-State: APjAAAUr+ZJ7wyzQY09VwKslPY9q9p2vjfuyQi3n5etMfcqyvs7Qt2d6
        UgQqec9dwtDwxrMn+LRrD/0=
X-Google-Smtp-Source: APXvYqz8ahVXIKoEPmABLhtZWsOELb54E4u1GrF1Y1pFPqGRNOnxj8bcHQ9hWmQ2LNihXe2DzDAmSw==
X-Received: by 2002:adf:9e02:: with SMTP id u2mr15064627wre.329.1570818905081;
        Fri, 11 Oct 2019 11:35:05 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t203sm12423237wmf.42.2019.10.11.11.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 11:35:03 -0700 (PDT)
Date:   Fri, 11 Oct 2019 20:35:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     ValdikSS <iam@valdikss.org.ru>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Determinate EDR speed
Message-ID: <20191011183502.ao45xlyfabpbadxo@pali>
References: <20191011082723.t6w2jcg7v4erlnq6@pali>
 <319f751481bbdb5aa012e5fa4daa1d95965b54c3.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4hgky5wzzjghpkvs"
Content-Disposition: inline
In-Reply-To: <319f751481bbdb5aa012e5fa4daa1d95965b54c3.camel@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--4hgky5wzzjghpkvs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Friday 11 October 2019 18:15:47 Gix, Brian wrote:
> Hi Pali,
>=20
> On Fri, 2019-10-11 at 10:27 +0200, Pali Roh=C3=A1r wrote:
> > Hello!
> >=20
> > I would like to ask, how can userspace application which uses bluez DBus
> > API determinate EDR speed of remote bluetooth device?
> >=20
> > Particularly, I'm interested in detection if bluetooth headset supports
> > EDR 2 Mbps or EDR 3 Mbps speed and based on this decide which SBC
> > parameters would be used for encoding audio via SBC codec.
>=20
> There are a variety of things that can affect real-time throughput, and I=
 think even EDR 2 vs 3 might
> dynamically change to fit the current conditions.  If you have the abilit=
y to have fine control of the SBC
> parameters, I think the *best* way to adjust for throughput is to choose =
what sample rate and subands you
> want, and then squeeze or expand the bitpool to fit your throughput. (bit=
pool is something that can be
> dynamically adjusted, I believe, without re-negotiation).

I know about all SBC parameters, I'm implementing/improving SBC codec
support in pulseaudio, de-facto standard way how current Linux desktop
system can do playback via bluetooth/bluez.

I'm already using fixed SBC subbands and sample rate based on pulseaudio
source. And SBC bitpool is really the thing which I want to choose based
on EDR 2 vs 3 availability.

ValdikSS (CCed) created a nice calculator for SBC codec parameters and
via it you can easily calculate which bitpool values you want to use to
minimize wasted bytes in bluetooth frames. But to do it, you need to
know MTU resp. information if device supports EDR 2 or EDR 3.

https://btcodecs.valdikss.org.ru/sbc-bitrate-calculator/

> Howeverever, the real question is how to tell what the instantaneous real=
time throughput is...  which is
> certainly affected by support for EDR2 vs EDR3, but is also affected by d=
istance, RSSI, environmental RF, and
> what the other L2CAP channels on the connection are carrying (AVRCP for e=
xample).
>=20
> I don't think a simple boolean for EDR2 and/or EDR3, especially in user s=
pace, is going to give you the level
> of information you need.

Currently bluez API, method Acquire() already inform called application
what is socket MTU for input and output. So from this information it is
possible to detect if device supports EDR 3 or not.

But it is too late to have this information. I need to send SBC
parameters to bluez first when doing A2DP negotiation, this is early
steps before Acquire() is called.

Therefore I'm asking for some way how to get information if device
supports EDR 2 or EDR 3. This is basically requirement for proper
implementation of SBC in high quality mode. So if there are not such API
yet, could it be exported from kernel to userspace and bluetoothd
daemon?

See these two articles for more details about SBC and its high quality:

https://habr.com/en/post/456182/
http://soundexpert.org/articles/-/blogs/audio-quality-of-sbc-xq-bluetooth-a=
udio-codec

> >=20
> > Is there any bluez API for it?
> >=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--4hgky5wzzjghpkvs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXaDLVAAKCRCL8Mk9A+RD
Utc8AJ4zS0vMFVq0q+/7et6wqVsZsnaqMwCZAe0DyMvaexOU0CiXJLBKIBGJWqI=
=ogm4
-----END PGP SIGNATURE-----

--4hgky5wzzjghpkvs--
