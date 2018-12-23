Return-Path: <SRS0=7VLe=PA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83948C43387
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 09:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4843A218FD
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 09:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koVOb0Dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeLWJac (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:30:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50458 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeLWJab (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Dec 2018 04:30:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so9021597wmd.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Dec 2018 01:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mgejcjmr1AqK2ft35RLWN3ZW1MAUM9YRSmQpmiQ1/A4=;
        b=koVOb0DdAUDtqNCQEMpS9GHfQKnN333GE+0e53wdWQIU50M102e4sbY5jRaehMZoKD
         z0A324ynfdt4qsxZZRj7wetvIG/TxrTWaIlx1FMjJ5tVbogiFyqHSLjx5lO2lnSpL1El
         nNaMR54nRcXR/LVTK0Q/D1Jd8o5wEhAkq1DirqGdeA8JKoyXszZg1xfy+4TpNwZQSgeH
         7T9rqrtoJGDV2gPIM6xTzD0rjcQUQMIAQ+KQyuAiVv2KKFr6TxvkOsn2LT28oMRSnx2S
         CD8woBN5IgVEbjL98RC7hAPKrAfIPXMvduRPw6APGhyrCi/OfGC0RnkRUB2895yMU3HN
         81XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mgejcjmr1AqK2ft35RLWN3ZW1MAUM9YRSmQpmiQ1/A4=;
        b=SjVsHtp4+WL/OefacjkAhklypxLG1b9YMJgcF1VtlzduolKwSws6gOS9n22akPdgRc
         GWK+Fze5DW3C9FLaSJvbGEfK7bKQgnXTT6XOvwqiNGmjRLHn3siC6Ipci8MJKAOtDcmx
         6g9E/+a5AgaIGAXd/Im/eOM39l8gkXipGpiAXeKegIcKMTwtX8p0KaCypJdOnAY9bdhA
         Wx1GRTCqDLoEt/1wiJFJx0IHN2OQ4QHeOnaKw8px1J9vM7fQHwrHphOBiBLIcGn5f3WY
         y/nFXylPyBs7ucCZHDb+dri9/7S0B30SOOUHvVam+nxVBJNJWp+fFSYt45Z9WSqUSO0e
         tJXg==
X-Gm-Message-State: AJcUuke847DhqtSHo1/SK/4arQ3yioTGd9ZyP08vuInB3sQ3qilUfMJv
        zZEeH7FHys0u5Rd2VYcmde4=
X-Google-Smtp-Source: AFSGD/XOQmrL5WWDeYYCp0ds1Qn8k6Q3+PnAVqkA2eFJsBFcqrCIVI7kxsqtK0aJngk3Pu6R7RiP+g==
X-Received: by 2002:a1c:2d42:: with SMTP id t63mr9211910wmt.9.1545557428793;
        Sun, 23 Dec 2018 01:30:28 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t76sm24614249wme.33.2018.12.23.01.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Dec 2018 01:30:28 -0800 (PST)
Date:   Sun, 23 Dec 2018 10:30:27 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 00/10] A2DP: Fix endianity and define new A2DP codecs
Message-ID: <20181223093027.usl6jemzla3kmo7y@pali>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
 <CABBYNZ+ryN3zywdsFQTguJWZ8jSYSOTT7OghxGVZ6wpoYh_QTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p722ahk4crmizpkz"
Content-Disposition: inline
In-Reply-To: <CABBYNZ+ryN3zywdsFQTguJWZ8jSYSOTT7OghxGVZ6wpoYh_QTQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--p722ahk4crmizpkz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 22 December 2018 19:54:48 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Wed, Dec 19, 2018 at 5:17 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > This patch series try to fix endianity problems in a2dp-codecs.h file,
> > then fixes parsing MPEG bit rate values, extend a2dp-codecs.h file for
> > new A2DP codecs FastStream, aptX Low Latency, aptX HD and finally adds
> > support for parsing information about FastStream, aptX Low Latency,
> > aptX HD and LDAC codecs in avinfo utility.
> >
> > Pali Roh=C3=A1r (10):
> >   avinfo: Fix buffer overflow when parsing broken/malicious data
> >   avinfo: Show Vendor Specific Data
> >   a2dp-codecs: Add SBC prefix for MIN/MAX_BITPOOL constants
> >   a2dp-codecs: Fix codec id for ATRAC
> >   a2dp-codecs & avinfo: Fix parsing MPEG bit rate values
> >   a2dp-codecs: Define a2dp_vendor_codec_t struct in endian neutral way
> >   a2dp-codecs: Add needed includes and properly check for endian macros
> >   a2dp-codecs: Properly define macros and struct for LDAC codec
> >   a2dp-codecs: Add macros and structures for FastStream, aptX Low
> >     Latency and aptX HD codecs
> >   avinfo: Parse information about A2DP codecs: FastStream, aptX Low
> >     Latency, aptX HD and LDAC
> >
> >  android/a2dp.c               |   8 +-
> >  android/avdtp.c              |   4 +-
> >  android/hal-audio-aptx.c     |  15 +-
> >  android/hal-audio-sbc.c      |  12 +-
> >  profiles/audio/a2dp-codecs.h | 256 ++++++++++++++++++++++++++----
> >  profiles/audio/a2dp.c        |   8 +-
> >  tools/avinfo.c               | 362 +++++++++++++++++++++++++++++++++++=
+-------
> >  7 files changed, 551 insertions(+), 114 deletions(-)
> >
> > --
> > 2.11.0
>=20
> gitlint: checking commit message...
> 3: B6 Body message is missing
> -----------------------------------------------
> gitlint: \033[31mYour commit message contains the above violations.\033[0m
>=20
> Please add description to the commit messages.

What should I put into those commit messages? I think that those changes
without commit body are such small, that commit title describes them.+

> Also there seems to be
> several problems with codying style like the following:
>=20
> Applying: avinfo: Fix buffer overflow when parsing broken/malicious data
> WARNING:UNSPECIFIED_INT: Prefer 'unsigned int' to bare use of 'unsigned'
> #77: FILE: tools/avinfo.c:241:
> +    unsigned freq, bitrate;
>=20
> WARNING:LONG_LINE: line over 80 characters
> #124: FILE: tools/avinfo.c:433:
> +static void print_media_codec(struct avdtp_media_codec_capability
> *cap, uint8_t size)
>=20
> WARNING:LONG_LINE: line over 80 characters
> #182: FILE: tools/avinfo.c:510:
> +            print_content_protection((void *) cap->data, cap->length);
>=20
> total: 0 errors, 3 warnings, 173 lines checked

Ok, I will fix them.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--p722ahk4crmizpkz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXB9VsQAKCRCL8Mk9A+RD
UvfrAJ9GVi7vZnZCWDTGgHV6k6eMxoPzJgCeO1BT8qTvPGlFOGj/YVDn1fs1LuI=
=6A5t
-----END PGP SIGNATURE-----

--p722ahk4crmizpkz--
