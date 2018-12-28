Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7036C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 18:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767D720652
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 18:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTkjJrT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbeL1S7p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:59:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39424 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbeL1S7p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Dec 2018 13:59:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id f81so20333814wmd.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Dec 2018 10:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EJ8Kyz4T1470jH/3ag198BU8fTKVqTHzi3vTBoINJW8=;
        b=tTkjJrT+7ZM18/NgwO93m0HiWU182W9yoW+fRzre8kRo1epHEUBMHNMHFpd9FGTJpL
         RwbZpgZ7fKytmFPtWO0p5UrA2oeOgfwpScI4zxD2igXh8l8Mu4IAfvMjKW/H1cFvL2V4
         YiNkK8Y8UN1IdGTxM5ZkhWtAEZTefp1ukYrJKZQS3Kryug5ZClWXG11jiu8glUuYYssN
         ZITkDhROzY+p2ZT9mu3UJ/CsMJ1CVLSRhRdVNpMOdyPaGxWDSBP6L+v7k3MAev/ycRGN
         teLTEcGS9lM/gJ3Hi5O0sjmtHF7EWqm+1l75/Z/IomJTQkZWESoKEqmJ8md1XJhuTvMS
         CALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EJ8Kyz4T1470jH/3ag198BU8fTKVqTHzi3vTBoINJW8=;
        b=CVj8D7vCVneVZkNbrbz2ZdmCIZq2KDEv/qxgUJxjpRDCGx7i1gmQlP7A9WX6/Ny0mf
         qiuhCMzkEtcU/x+wmVjYf6hSx80Zikg1madr/IhMBIkhPW02xAhlgQKKocTJsZ4+sKQJ
         V1MjIvj60qbG7FJUj+Y6Viiil85Kj6CucdITWJ1XZJp7OL262Iqnnc1qorLYrdpu9IXg
         heLf/SWDcGc0sxWnFKaKL1rULHJKedd6KVf6ksPQ6xrIhpFZZKZuSYbhNQIRb7rcvOYh
         t1Et12ya1uYzxpurwXB7XsjOnD+DkILsAxpRcdpadNfo1wacyaIheq+l7t9rDC3X20qm
         8ecA==
X-Gm-Message-State: AJcUukfKAqDJcmZF1CstjwDrEHaWpiJYCTt+VDmXxue120wb+WYjKUYg
        P5oMmm6j0e11+I+wn+v40nk=
X-Google-Smtp-Source: ALg8bN5hXQI8yrUi3LWMDRUdi2uHEn6VmGd6v9uTy7Wsm9YuNDK6GM1DequnHpSDaE0gnVi0kUx0SA==
X-Received: by 2002:a1c:8302:: with SMTP id f2mr2415703wmd.9.1546023583561;
        Fri, 28 Dec 2018 10:59:43 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id a17sm28046526wrs.58.2018.12.28.10.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 10:59:42 -0800 (PST)
Date:   Fri, 28 Dec 2018 19:59:41 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] A2DP: Fix endianity and define new A2DP codecs
Message-ID: <20181228185941.imwjs3dnix7sz5bn@pali>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
 <20181223104021.18620-1-pali.rohar@gmail.com>
 <CABBYNZ+T5ZVaneY8mvVDGZ9Bj4FAj24sDUJ5p4RsyuDhfDKnAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jrswqtpx2fjqunjn"
Content-Disposition: inline
In-Reply-To: <CABBYNZ+T5ZVaneY8mvVDGZ9Bj4FAj24sDUJ5p4RsyuDhfDKnAA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--jrswqtpx2fjqunjn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 28 December 2018 15:23:53 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Sun, Dec 23, 2018 at 1:43 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > This patch series try to fix endianity problems in a2dp-codecs.h file,
> > then fixes parsing MPEG bit rate values, extend a2dp-codecs.h file for
> > new A2DP codecs FastStream, aptX Low Latency, aptX HD and finally adds
> > support for parsing information about FastStream, aptX Low Latency,
> > aptX HD and LDAC codecs in avinfo utility.
> >
> > Changes since v1:
> > * Fix style issues
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
> >   a2dp-codecs: Add macros and structures for new codecs
> >   avinfo: Parse new A2DP codecs
> >
> >  android/a2dp.c               |   8 +-
> >  android/avdtp.c              |   6 +-
> >  android/hal-audio-aptx.c     |  18 +-
> >  android/hal-audio-sbc.c      |  12 +-
> >  profiles/audio/a2dp-codecs.h | 267 ++++++++++++++++++++++++++----
> >  profiles/audio/a2dp.c        |   9 +-
> >  tools/avinfo.c               | 380 +++++++++++++++++++++++++++++++++++=
+-------
> >  7 files changed, 586 insertions(+), 114 deletions(-)
> >
> > --
> > 2.11.0
>=20
> Applies, thanks. Note that I had to fix some patches since they didn't
> compile when applying one by one.

Ok.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--jrswqtpx2fjqunjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXCZymgAKCRCL8Mk9A+RD
Uq/6AKDATwLU7wIOM6BKG6vYCG+KZYRbBACeJTcJJtxJr8zj5f8lvQDaQoyeoUU=
=+8ql
-----END PGP SIGNATURE-----

--jrswqtpx2fjqunjn--
