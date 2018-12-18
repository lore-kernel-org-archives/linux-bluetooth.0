Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C252C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 21:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1301217D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 21:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aI/4+Kw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeLRVHD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:07:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45397 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeLRVHD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 16:07:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so17176032wrr.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Dec 2018 13:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FFGIGBEwD6+p7kg7f9fgcmzJIR6Az3PNxVbyU2eDguA=;
        b=aI/4+Kw9IPcvhbKtv8Ph8pl7I+Fyge0gWyNpBk6s1fXiet/m0JXtjBJ7rQkUcEV8EC
         heZO7IvawWSwzKgbm7B8dD8ZaJGPxyTLBbWYSFySF5Kpy3kvxn6GSDuLAXeatubcdYHU
         3rNoNdQMaCZL3EVUOtwoboWjelUD3Jl83nXZb27GJYiFoeO3X6iYF31ndJp3c11T7hje
         ad13ghsRroHLIvw/bbmyt6LdHQSdzOAAKMxhCFUbKQj+z7EFI6vlXLJH9J53vxNOMap7
         R7s4b34Zs1r5ii4jQapBCqS1En7uArHmwm0GFuUomdHFjGSiLsK0mSYpxRcqh1GwW66I
         ofzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FFGIGBEwD6+p7kg7f9fgcmzJIR6Az3PNxVbyU2eDguA=;
        b=FpbLGNDqiuBlq14L6oBZ3uUZerQmAU5OMGXVrUS+Zze96KiMOEaHd1PlRNWSpAZM21
         e/f1nHJPZyA8QFFR+364ER0V08CH9hjEYxT41ZoogQc2+xQA5B8XaLwLo7ACu3oZ22Yu
         ijiEXaGj994Oi0AJxyG1vmyRXqIxMqaiFiZ8/gnGa0whH4oiPPMTV1rm446A2KE/HNVA
         k9x/sVpQAEzlwd29Z0pb4Sui2tbTnwAHteceJUXjOasyi3j0YHUpihQpzB4O+ih13/CF
         7AF2opPOrhgjrXpsnNI2D+8j/2LTUz91XQMfPzQsLxEzkf40MmyHo4xPSSXp7YVR70fI
         UJzA==
X-Gm-Message-State: AA+aEWb5Qb/rCp2MtpF8dj9cTEvpjeQ0Xk5Ks1kWN2RCYblNY0huusnV
        S/3t3NF+JlRW+nE6tSeFVm4=
X-Google-Smtp-Source: AFSGD/UWwhsehxAxoHRcZW2ZOei66qMz7NxHZWJiFvnBYQptkRiPmsBJiCYoD0bAamBQvDNGvEUmcQ==
X-Received: by 2002:adf:b190:: with SMTP id q16mr16141323wra.95.1545167221510;
        Tue, 18 Dec 2018 13:07:01 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id k23sm2434214wmj.32.2018.12.18.13.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 13:07:00 -0800 (PST)
Date:   Tue, 18 Dec 2018 22:06:59 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: Bluez has fully broken profiles/audio/a2dp-codecs.h file for big
 endian
Message-ID: <20181218210659.hopw4sllncukb6tj@pali>
References: <20181218145033.itlwcfraxsusafb3@pali>
 <CABBYNZKu-1s=GcyWYOqbjNZGknyPFHk4LEVVP7+w85oauEpDBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kfzuvws4lvwgdlmk"
Content-Disposition: inline
In-Reply-To: <CABBYNZKu-1s=GcyWYOqbjNZGknyPFHk4LEVVP7+w85oauEpDBA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--kfzuvws4lvwgdlmk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 18 December 2018 17:50:52 Luiz Augusto von Dentz wrote:
> On Tue, 18 Dec 2018, 11:54 Pali Roh=C3=A1r <pali.rohar@gmail.com wrote:
>=20
> > Hello,
> >
> > I spotted that bluez has file profiles/audio/a2dp-codecs.h in its git
> > repository with some #if __BYTE_ORDER =3D=3D checks, including #ifdef f=
or
> > big endian systems.
> >
> > But this file is fully broken for big endian systems. For example, there
> > is following structure which is same for both little and big endian
> > systems:
> >
> >   typedef struct {
> >         uint32_t vendor_id;
> >         uint16_t codec_id;
> >   } __attribute__ ((packed)) a2dp_vendor_codec_t;
> >
>=20
> Byte order is not the same as packet order, in this case there is no
> difference between big or little endian because there is no use of bit
> fields, the packet ordering of the fields is the same regardless of the
> byte order meaning that vendor_id is transmitted before codec_id since the
> spec actually defines them in this way and it is wrong to alter this orde=
r.
> You can check how btmon decodes this and you would see it only decodes
> individual fields to host not the entire struct representing the packet.
>=20
> Which is valid only for little endian systems, as those definitions are
> > bound to little endian ordering -- not to host ordering.
> >
>=20
> The spec defines the packets in little endian not in host endian.

But in code, you work with host endian. Therefore uint32_t is in host
endian too. Data are transferred in little endian (as you wrote), so you
need to do some conversion from little endian to host endian.

Or you new gcc6 feature

__attribute__((packed, scalar_storage_order("little-endian")))

to tell that structure field is in little endian and not in host endian.

> Next there is a2dp_mpeg_t. It has different definition for little endian
> > and big endian systems.
> >
> > little endian:
> >
> >   typedef struct {
> >         uint8_t channel_mode:4;
> >         uint8_t crc:1;
> >         uint8_t layer:3;
> >         uint8_t frequency:6;
> >         uint8_t mpf:1;
> >         uint8_t rfa:1;
> >         uint16_t bitrate;
> >   } __attribute__ ((packed)) a2dp_mpeg_t;
> >
> > big endian:
> >
> >   typedef struct {
> >         uint8_t layer:3;
> >         uint8_t crc:1;
> >         uint8_t channel_mode:4;
> >         uint8_t rfa:1;
> >         uint8_t mpf:1;
> >         uint8_t frequency:6;
> >         uint16_t bitrate;
> >   } __attribute__ ((packed)) a2dp_mpeg_t;
> >
> > But as you can see, bitrate on big endian definition is incorrect. It
> > is still in little endian. Proper way would be to define bitrate as
> > "uint8_t bitrate[2];" or as "uint8_t bitrate_lo; uint8_t bitrate_hi".
> >
>=20
> Obviously one need to convert the value when receiving, or perhaps you are
> saying it makes no sense to use bit fields in that case? Anyway when
> accessing this the user must convert to host order of he intends to use t=
he
> value.

Yes, that is the point, user needs to convert values. But they are
marked with types uint32_t and uint16_t, which are types normally used
for host endian. This just confuse people who copy+paste this file to
other projects.

So if correct way is to always convert these values, what about creating
some typedef uint16_t le_uint16_t or add comments that those values are
in little endian and not in host endian?

Or usage of __attribute__((packed, scalar_storage_order("little-endian")))?

> So basically this file a2dp-codecs.h is not compatible with big endian
> > systems, even there are "#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN" branch=
es.
> >
> > If you are not going to support big endian systems, I suggest you to
> > drop all those "#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN" parts as people
> > think that existence of these macros means that code is supported on big
> > endian systems.
> >
> > It is better throw an error that big endian is broken as trying to
> > produce non-working binaries.
> >
> > Moreover, some people started copying this a2dp-codecs.h file to other
> > projects which just leads to copy+paste of broken code.
> >
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com
> >

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--kfzuvws4lvwgdlmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXBlhbwAKCRCL8Mk9A+RD
UrWOAJ4i/GQKIXNuthgOGIGlVbDIj02d5ACgylS7N6q/MbWphPxPJ6SQq7y54i0=
=u8Lm
-----END PGP SIGNATURE-----

--kfzuvws4lvwgdlmk--
