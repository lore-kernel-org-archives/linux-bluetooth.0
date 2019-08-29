Return-Path: <SRS0=q5Cw=WZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A485C3A59F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 20:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA80D208C2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 20:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc2/TnNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfH2UFS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:05:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50609 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfH2UFS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Aug 2019 16:05:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so4992350wml.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2019 13:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=erx3gK+Wv7MRBDvcm6dITcEj9IF3dTvMXH5pT3dSSs4=;
        b=Pc2/TnNxR2q2d5S6VdJ6AZHhEarRYB7H/xwjmEBFQpKk5Sf+bMv7FIdM2YKx+trt4H
         thzeHsYn+EdrAD0YzAnWMD+YyArc6a6p0wzbMYSUm9TUW0dBWPF9ucFPl3NCXzot4Q/B
         Vj7M+XAtqzJT9eTUBrTNONrXwUJO2W/nAgmchyx+XFgKgY5L1U/IwipAoXO4wO6dJq3A
         2SpCabxhAENyX97QUdLC40zIIefm5C0CmKAHVuiUfzwM7vOHjd8GZ8qmhq4OSUsodl0+
         CEPGnRDc3E/vDSmSiJ0lBtkK79+Qac6K/UFzBbjP1jJisYpWwqraGUfMsPp7QYWnENIt
         mZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=erx3gK+Wv7MRBDvcm6dITcEj9IF3dTvMXH5pT3dSSs4=;
        b=CW9bwSwD7PEhTw/E1C1p2PdSMK62YjW5e2rMhQMtB/R6tVAk95eMM0AUTBgyJ2lGDa
         i1WoXzF+YaUsjdjsunlaLeuP1WaYAOAI9yvz2sUQ+pST0LmtFUUo0NRXBoDZcJGmY5oq
         obtdqECYKcfXlrxYLYZd4gjnqiBaioWZjMDCiosZUb/aG+e8dWaoVU1ArKgcQLvII9Xa
         sb8qXCb3jDzdoWjst7TjU9YiGtGoxC9dC+CEoSU8PIt08Gv+eLVHN++YpRPjGljLpV/0
         4NaN2jaNu3qs6Mz7ZVyEMOXdBEUU8quAbNRaMRqIw5sClm8brlSqXvhDTPertT+FqtuS
         aGDg==
X-Gm-Message-State: APjAAAVMDC8MAaDFrinP1iNviFrvuQX+0p1GYwVmq98mc6EOfnq1cBcg
        g26PFwuY7Nx2+Ww0CcF44IY=
X-Google-Smtp-Source: APXvYqyguNjTG6VLjltHFGc6V0e3c9TGIHW9XqSG0XW1Yt/ODA0lBHjKzDp9O7lQbRdGCHFx4pAG0g==
X-Received: by 2002:a1c:7009:: with SMTP id l9mr13759434wmc.159.1567109116180;
        Thu, 29 Aug 2019 13:05:16 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id e6sm3926972wrw.35.2019.08.29.13.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 13:05:14 -0700 (PDT)
Date:   Thu, 29 Aug 2019 22:05:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
Message-ID: <20190829200513.6xnta5jx3trbmgxp@pali>
References: <20190712151329.11333-1-luiz.dentz@gmail.com>
 <CABBYNZLDFAJgkfAFWOOAAqqiX8mpi3KgirBkpwpnBFJ3TxPqyg@mail.gmail.com>
 <20190718100024.ii2igadxb2lmmitm@pali>
 <20190721155522.3vqt7vsprhpxflqf@pali>
 <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
 <20190829125734.GH2840@reaktio.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ahgnhanjziijqqin"
Content-Disposition: inline
In-Reply-To: <20190829125734.GH2840@reaktio.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--ahgnhanjziijqqin
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 29 August 2019 15:57:34 Pasi K=C3=A4rkk=C3=A4inen wrote:
> Pali: How does it look with porting the PA patches to use the new interfa=
ces?

Hello, I have not had a time yet to play with these pulseaudio patches
and porting to the new interface. I guess that I could have more free
time in the last week of next month.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--ahgnhanjziijqqin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXWgv+AAKCRCL8Mk9A+RD
UqG1AKCjQNxgR43uK78/HIPPhPcE5Z6mFgCffWF5tVrqBBga/n+K0kidyPRAHus=
=5dh5
-----END PGP SIGNATURE-----

--ahgnhanjziijqqin--
