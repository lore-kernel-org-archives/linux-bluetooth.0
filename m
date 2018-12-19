Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC936C43444
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 13:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B187121871
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 13:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRbz2y5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbeLSNUg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:20:36 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:43432 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeLSNUf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 08:20:35 -0500
Received: by mail-oi1-f179.google.com with SMTP id u18so1543850oie.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Dec 2018 05:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8uUnh+fjWsqG6c/lQxzv/FssqgoNjY7sTglblicpbWE=;
        b=RRbz2y5HU9yWOGaDsCgfbnRITGBnGpJj3+P0iQsoOuV2wLH5HFlQmoODE+Pqv0bDH9
         SXfJmZMLyyMkB9e39iTBqgrIcyXp93N+m1niiHybyb9EDxLpRuFxcswewT3T0I4ZX9oW
         FTWma9huTYb3X4G+DXX2sxe2iIvdhiQIJOmQ1/Gf+dmCtxdofmJuGFpPxYfXlf+SZ6qa
         fUBVC3166IPTLJsa9/Uhd3MP7JshEM35n+oABLKH+hSsqmL30Ppy2zCEjZ78oTPTs6M3
         Eppk+cH9b918hIZ98oP3Fmt+bGfAPcZED6NDmvfP5N4W/UA2OS12akWoW9wv7qS86emg
         2YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8uUnh+fjWsqG6c/lQxzv/FssqgoNjY7sTglblicpbWE=;
        b=QpRZkPn1ZzHE9/Ta2FjvGuHZDfVKw5h5dhm7MS/8LIrFtqJCdFEEZ/y6zMK8UgRgrR
         W9i9EX+UitVNsXEJQdZJwQc6+LM3UjQsz+eU69Ja/w19iiANX9NkLiSZlQ/UwdHksAHr
         barHIP+rJLW4FkhaPsJRmM3q6EVoN2wOEWaQkHH8tlzdYos+xkRABXoG2RIDMHIFblL5
         zY78zsSc47q7ZOnohDk++T/dFq2lp63TEZg5jD5RyE24xTf5Zj3C/6iElrMC7KF2veEG
         0GWVeWG6OYRmd9d3no1n/zcrZ7DdFVj36uCjdqSWmiWem/NuTJK4zzInt8QUmaueFktR
         7BBQ==
X-Gm-Message-State: AA+aEWZNQbdqTPwo9mk44+mGOEB0sPPpsbxinTyJ8LFTKZaeBnJARfPA
        iZQpXkAm9Uv2L5RZUpq8jw989el+wKWzee+ektg=
X-Google-Smtp-Source: AFSGD/W7JObi+tB2S6Nkimu9e+cLoroVXWx4ufkwpqlxynJaqYBz39C7JgVXXzZr+rqVErQ7744NrAvOtVAtpOxkJro=
X-Received: by 2002:aca:e755:: with SMTP id e82mr985940oih.153.1545225634743;
 Wed, 19 Dec 2018 05:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20181218145033.itlwcfraxsusafb3@pali> <CABBYNZKu-1s=GcyWYOqbjNZGknyPFHk4LEVVP7+w85oauEpDBA@mail.gmail.com>
 <20181218210659.hopw4sllncukb6tj@pali>
In-Reply-To: <20181218210659.hopw4sllncukb6tj@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 Dec 2018 10:20:22 -0300
Message-ID: <CABBYNZKL_Wz9ePMQvY87QN1LpOV4BTwu2hq0j85YeocvDBC5jQ@mail.gmail.com>
Subject: Re: Bluez has fully broken profiles/audio/a2dp-codecs.h file for big endian
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Tue, Dec 18, 2018 at 6:07 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Tuesday 18 December 2018 17:50:52 Luiz Augusto von Dentz wrote:
> > On Tue, 18 Dec 2018, 11:54 Pali Roh=C3=A1r <pali.rohar@gmail.com wrote:
> >
> > > Hello,
> > >
> > > I spotted that bluez has file profiles/audio/a2dp-codecs.h in its git
> > > repository with some #if __BYTE_ORDER =3D=3D checks, including #ifdef=
 for
> > > big endian systems.
> > >
> > > But this file is fully broken for big endian systems. For example, th=
ere
> > > is following structure which is same for both little and big endian
> > > systems:
> > >
> > >   typedef struct {
> > >         uint32_t vendor_id;
> > >         uint16_t codec_id;
> > >   } __attribute__ ((packed)) a2dp_vendor_codec_t;
> > >
> >
> > Byte order is not the same as packet order, in this case there is no
> > difference between big or little endian because there is no use of bit
> > fields, the packet ordering of the fields is the same regardless of the
> > byte order meaning that vendor_id is transmitted before codec_id since =
the
> > spec actually defines them in this way and it is wrong to alter this or=
der.
> > You can check how btmon decodes this and you would see it only decodes
> > individual fields to host not the entire struct representing the packet=
.
> >
> > Which is valid only for little endian systems, as those definitions are
> > > bound to little endian ordering -- not to host ordering.
> > >
> >
> > The spec defines the packets in little endian not in host endian.
>
> But in code, you work with host endian. Therefore uint32_t is in host
> endian too. Data are transferred in little endian (as you wrote), so you
> need to do some conversion from little endian to host endian.
>
> Or you new gcc6 feature
>
> __attribute__((packed, scalar_storage_order("little-endian")))
>
> to tell that structure field is in little endian and not in host endian.
>
> > Next there is a2dp_mpeg_t. It has different definition for little endia=
n
> > > and big endian systems.
> > >
> > > little endian:
> > >
> > >   typedef struct {
> > >         uint8_t channel_mode:4;
> > >         uint8_t crc:1;
> > >         uint8_t layer:3;
> > >         uint8_t frequency:6;
> > >         uint8_t mpf:1;
> > >         uint8_t rfa:1;
> > >         uint16_t bitrate;
> > >   } __attribute__ ((packed)) a2dp_mpeg_t;
> > >
> > > big endian:
> > >
> > >   typedef struct {
> > >         uint8_t layer:3;
> > >         uint8_t crc:1;
> > >         uint8_t channel_mode:4;
> > >         uint8_t rfa:1;
> > >         uint8_t mpf:1;
> > >         uint8_t frequency:6;
> > >         uint16_t bitrate;
> > >   } __attribute__ ((packed)) a2dp_mpeg_t;
> > >
> > > But as you can see, bitrate on big endian definition is incorrect. It
> > > is still in little endian. Proper way would be to define bitrate as
> > > "uint8_t bitrate[2];" or as "uint8_t bitrate_lo; uint8_t bitrate_hi".
> > >
> >
> > Obviously one need to convert the value when receiving, or perhaps you =
are
> > saying it makes no sense to use bit fields in that case? Anyway when
> > accessing this the user must convert to host order of he intends to use=
 the
> > value.
>
> Yes, that is the point, user needs to convert values. But they are
> marked with types uint32_t and uint16_t, which are types normally used
> for host endian. This just confuse people who copy+paste this file to
> other projects.

packed struct are normally used just for casting using the received
buffer, so they should never be used as in host order but perhaps that
is not clearer for everyone.

> So if correct way is to always convert these values, what about creating
> some typedef uint16_t le_uint16_t or add comments that those values are
> in little endian and not in host endian?
>
> Or usage of __attribute__((packed, scalar_storage_order("little-endian"))=
)?

Never used the scalar_storage_order, perhaps it would be a nice
addtion here, not sure if that does the convertion implicitly?

> > So basically this file a2dp-codecs.h is not compatible with big endian
> > > systems, even there are "#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN" bran=
ches.
> > >
> > > If you are not going to support big endian systems, I suggest you to
> > > drop all those "#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN" parts as peop=
le
> > > think that existence of these macros means that code is supported on =
big
> > > endian systems.

It is indeed broken for big endian if no convertion is performed, the
use o bitfield actually makes a mess in the structs so perhaps it is
better to use just full bytes and perhaps have macros for accesing the
bit fields, anyway we don't use them anymore in the daemon itself so
it is more of an issue in the likes of PulseAudio, neverthless we
should probably have proper definitions anyway in case anyone use them
as a reference.

> > > It is better throw an error that big endian is broken as trying to
> > > produce non-working binaries.
> > >
> > > Moreover, some people started copying this a2dp-codecs.h file to othe=
r
> > > projects which just leads to copy+paste of broken code.
> > >
> > > --
> > > Pali Roh=C3=A1r
> > > pali.rohar@gmail.com
> > >
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
