Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5DDC43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F32B218AE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDy6SQDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbeLSQqL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:46:11 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:55247 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbeLSQqL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 11:46:11 -0500
Received: by mail-wm1-f54.google.com with SMTP id a62so6744875wmh.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Dec 2018 08:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QVqvwMDIFor7JrBGIGREXTaJ+NhyUEW8wpo8h8KF0uA=;
        b=JDy6SQDdYbb1DqsxSmrWM5CoDgssXW8WhQHh5FRLqJ916Dz2n0Uzmz3uuMrx3HZSrs
         cz5RecvXrZn1Af53oZ5EQXUn2C5iSANoydi9AzPkZOZkWwnWj3OZhqGTJemNVPdxxQeK
         /qpeoKavJMTlRDXIy60zJBS4JT55JYikn3438sWMvHXNZgphXptPOcSdJq/4fY1Bhf40
         u+SK06pTIzwjbzbVLd2JJGjYLI3V2Ly3LkC4ge1UKiftwHufa4v9mQ09IzK5r5RhRgCC
         gLUHUsF60UNupOgGpMRt/clVIuoCIIVcvutvIVBlJWETIM5QRywhBO4Suae2pitUaRli
         Srjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QVqvwMDIFor7JrBGIGREXTaJ+NhyUEW8wpo8h8KF0uA=;
        b=VAptwyf1XxLdsT5fPWXiuxDoSl2OXzTsoGirsgDxQBuioAn2zhQ6W/IND7MB1PC46B
         u7pIjp4xRXThiMK6VsNFKYRF8hCsEVv98bJhGK7Nj0S6wsv0Bfy3NHtkASDLHFiyfabU
         LL5rTZUvS7uwRMI8+HHbCUgI3aVNI1lKWPU5b6YbHlZpGOfI0BXNjZRO7GEXAAlXjweA
         5lSbBZYV7G3HQB1Atf8pclxJUS79bovegsigM7ip+sQnKWHX6zSMsh3FZwr7kKUSxLNN
         IFpoey1dkRAXXbLc3TQR8acWA6/uMl4v3j82j4iYJ951YyyGIn/rKOP7wvj9gqM10gMz
         JPvg==
X-Gm-Message-State: AA+aEWYoMTjHH9n4ORgjBuusq2UzTs7MlCwaRhp/Ynq01Q/HU0LWKOgP
        WyVFoLtsmoNt1W4S+LLnJk8=
X-Google-Smtp-Source: AFSGD/WYqObCWAcT1nrbTGN7BKc0Wp/mNZ33+C1Z0cn+OcYt9zCj5UPZlSP1+Gj2qab3Tmblz/Uy1Q==
X-Received: by 2002:a1c:1b4f:: with SMTP id b76mr7628693wmb.147.1545237968607;
        Wed, 19 Dec 2018 08:46:08 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id c65sm6450522wma.24.2018.12.19.08.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 08:46:05 -0800 (PST)
Date:   Wed, 19 Dec 2018 17:46:04 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluez has fully broken profiles/audio/a2dp-codecs.h file for big
 endian
Message-ID: <20181219164604.equwh722kozljipo@pali>
References: <20181218145033.itlwcfraxsusafb3@pali>
 <CABBYNZKu-1s=GcyWYOqbjNZGknyPFHk4LEVVP7+w85oauEpDBA@mail.gmail.com>
 <20181218210659.hopw4sllncukb6tj@pali>
 <CABBYNZKL_Wz9ePMQvY87QN1LpOV4BTwu2hq0j85YeocvDBC5jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k7ucptqyfekc2mti"
Content-Disposition: inline
In-Reply-To: <CABBYNZKL_Wz9ePMQvY87QN1LpOV4BTwu2hq0j85YeocvDBC5jQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--k7ucptqyfekc2mti
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 19 December 2018 10:20:22 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Tue, Dec 18, 2018 at 6:07 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > On Tuesday 18 December 2018 17:50:52 Luiz Augusto von Dentz wrote:
> > > On Tue, 18 Dec 2018, 11:54 Pali Roh=C3=A1r <pali.rohar@gmail.com wrot=
e:
> > >
> > > > Hello,
> > > >
> > > > I spotted that bluez has file profiles/audio/a2dp-codecs.h in its g=
it
> > > > repository with some #if __BYTE_ORDER =3D=3D checks, including #ifd=
ef for
> > > > big endian systems.
> > > >
> > > > But this file is fully broken for big endian systems. For example, =
there
> > > > is following structure which is same for both little and big endian
> > > > systems:
> > > >
> > > >   typedef struct {
> > > >         uint32_t vendor_id;
> > > >         uint16_t codec_id;
> > > >   } __attribute__ ((packed)) a2dp_vendor_codec_t;
> > > >
> > >
> > > Byte order is not the same as packet order, in this case there is no
> > > difference between big or little endian because there is no use of bit
> > > fields, the packet ordering of the fields is the same regardless of t=
he
> > > byte order meaning that vendor_id is transmitted before codec_id sinc=
e the
> > > spec actually defines them in this way and it is wrong to alter this =
order.
> > > You can check how btmon decodes this and you would see it only decodes
> > > individual fields to host not the entire struct representing the pack=
et.
> > >
> > > Which is valid only for little endian systems, as those definitions a=
re
> > > > bound to little endian ordering -- not to host ordering.
> > > >
> > >
> > > The spec defines the packets in little endian not in host endian.
> >
> > But in code, you work with host endian. Therefore uint32_t is in host
> > endian too. Data are transferred in little endian (as you wrote), so you
> > need to do some conversion from little endian to host endian.
> >
> > Or you new gcc6 feature
> >
> > __attribute__((packed, scalar_storage_order("little-endian")))
> >
> > to tell that structure field is in little endian and not in host endian.
> >
> > > Next there is a2dp_mpeg_t. It has different definition for little end=
ian
> > > > and big endian systems.
> > > >
> > > > little endian:
> > > >
> > > >   typedef struct {
> > > >         uint8_t channel_mode:4;
> > > >         uint8_t crc:1;
> > > >         uint8_t layer:3;
> > > >         uint8_t frequency:6;
> > > >         uint8_t mpf:1;
> > > >         uint8_t rfa:1;
> > > >         uint16_t bitrate;
> > > >   } __attribute__ ((packed)) a2dp_mpeg_t;
> > > >
> > > > big endian:
> > > >
> > > >   typedef struct {
> > > >         uint8_t layer:3;
> > > >         uint8_t crc:1;
> > > >         uint8_t channel_mode:4;
> > > >         uint8_t rfa:1;
> > > >         uint8_t mpf:1;
> > > >         uint8_t frequency:6;
> > > >         uint16_t bitrate;
> > > >   } __attribute__ ((packed)) a2dp_mpeg_t;
> > > >
> > > > But as you can see, bitrate on big endian definition is incorrect. =
It
> > > > is still in little endian. Proper way would be to define bitrate as
> > > > "uint8_t bitrate[2];" or as "uint8_t bitrate_lo; uint8_t bitrate_hi=
".
> > > >
> > >
> > > Obviously one need to convert the value when receiving, or perhaps yo=
u are
> > > saying it makes no sense to use bit fields in that case? Anyway when
> > > accessing this the user must convert to host order of he intends to u=
se the
> > > value.
> >
> > Yes, that is the point, user needs to convert values. But they are
> > marked with types uint32_t and uint16_t, which are types normally used
> > for host endian. This just confuse people who copy+paste this file to
> > other projects.
>=20
> packed struct are normally used just for casting using the received
> buffer, so they should never be used as in host order but perhaps that
> is not clearer for everyone.

Hi!

I looked into A2DP specification (a2dp_v1.3.1.pdf page 27 table 4.13)
and apparently, bitrate uses only 15 bits (not all 16 from uint16_t) and
moreover, it is in *big endian* ordering, not little endian. This was
surprise for me. But looking at it deeply, bitrate for AAC is in big
endian too and a2dp-codecs.h has already correct conversion macros from
host endian to big endian.

And it is not bitrate, but "bitrate index". In MPEG standard is then for
each Layer 1 - 3 defined conversion table from "bitrate index" to real
bitrate.

Therefore it is already broken on little endian systems (as in A2DP
buffer it is in big endian) and also on big endian systems (for Layer 1
and Layer 2 as index constants are hardcoded for Layer 3).

In few minutes I will send patch series, which fixes this problem.

> > So if correct way is to always convert these values, what about creating
> > some typedef uint16_t le_uint16_t or add comments that those values are
> > in little endian and not in host endian?
> >
> > Or usage of __attribute__((packed, scalar_storage_order("little-endian"=
)))?
>=20
> Never used the scalar_storage_order, perhaps it would be a nice
> addtion here, not sure if that does the convertion implicitly?

Yes, this is new feature of gcc6, it does implicit conversion.

In my patch series I did not used it as I do not think that bluez has
minimal required gcc version.

> > > So basically this file a2dp-codecs.h is not compatible with big endian
> > > > systems, even there are "#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN" br=
anches.
> > > >
> > > > If you are not going to support big endian systems, I suggest you to
> > > > drop all those "#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN" parts as pe=
ople
> > > > think that existence of these macros means that code is supported o=
n big
> > > > endian systems.
>=20
> It is indeed broken for big endian if no convertion is performed, the
> use o bitfield actually makes a mess in the structs so perhaps it is
> better to use just full bytes and perhaps have macros for accesing the
> bit fields, anyway we don't use them anymore in the daemon itself so
> it is more of an issue in the likes of PulseAudio, neverthless we
> should probably have proper definitions anyway in case anyone use them
> as a reference.

I will try to fix structures, so accessing them on both little and big
endian systems would result in same data. I think this is the best
approach as lot of people develops on little endian systems and if
protocol buffer endianity matches host endianity, nothing is broken and
nobody spot problem.

> > > > It is better throw an error that big endian is broken as trying to
> > > > produce non-working binaries.
> > > >
> > > > Moreover, some people started copying this a2dp-codecs.h file to ot=
her
> > > > projects which just leads to copy+paste of broken code.
> > > >
> > > > --
> > > > Pali Roh=C3=A1r
> > > > pali.rohar@gmail.com
> > > >
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

--k7ucptqyfekc2mti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXBp1ygAKCRCL8Mk9A+RD
UiZ8AKCXaxd9xFu60Ukp6KWgWUOVWpoOXACfUygdxDQJcndgkQ2OQrYcsQiAfpg=
=nta5
-----END PGP SIGNATURE-----

--k7ucptqyfekc2mti--
