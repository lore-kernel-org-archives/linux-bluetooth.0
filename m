Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD5BC432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 21:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7099B20869
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 21:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNSMsrro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfK0Ujn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:39:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56071 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbfK0Ujm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 15:39:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id a131so4257832wme.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 12:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7CBJLL+S1K81TsgUIwQ6CBZPazEn+2M4qn4JfmRLu/8=;
        b=LNSMsrroD0mbSCRsApuUcXOP/Z5AhZRMbX/2g7CdqdVYizuhwCfQUUlUPb7EjybTbh
         JSuBdGuzd+6VC3XT8GiQDEHz+/HyIr5Wa+rBznVxnbjSzWpVimfOAniipeF9rgDHqm7G
         fME2rYqnT+9DUutPNJ4LlG4HHsmv2P+wcLN9dnxee4NTO3CAM1GNqqapLcj1PCENntj/
         2v73cxZzRe8gJGUd/sQEwHjkNnLobpnGEIvUNINhcqCd2bwtgdB86YodtEJ69h93k4mp
         p90cl45G4KIPlJ/YDCigZwd5rRlBErwCFXvmhKUWxcR6/OnB/y5ElDmwZjDACzvAiZEZ
         9NXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7CBJLL+S1K81TsgUIwQ6CBZPazEn+2M4qn4JfmRLu/8=;
        b=S0EejHgQdkr+f4Q6+8uKKyIPvZL5vm6OACcOFPVc3x8zx1OdNtL3sGlXvdph/tm8pU
         Q86qizaHajEoJZHYTuF7dJ3KDPLOBsyuFHhC7Xs07xKgNOLfWOJHNCU7MayhR990hBKt
         3Y3j7+mSziM8TGnusYvyj2UEbcDPk0Ez9jslyb0oPyVWvhxIZT9AGfIzm1WiWBFb8VWX
         Fg0gc14oXPVZz+6ayzynQ6eEMKvR58gq0qpApQsZX41XgrfJi9KyXArYHqziUBfL4mOK
         CgJeSsc+T0Yft+9L2vgDDZk4LI50euHr3nxmq5pyqVQvrbd8bU8p9YJgDroYiQuTS3Pj
         HApQ==
X-Gm-Message-State: APjAAAUzW8DHJWsRM2m9magPt8lyC5X3kpdw2GHe1bC56ib3rpOERiSJ
        nMz+djtQHdjlAlXhgTNoSJA=
X-Google-Smtp-Source: APXvYqzmnEoDb2VAQUYQI2QCkEuTKVScfJO0cpm2R3MGo/JY5akwdO2zIoo2rqR22ia3XFD3T0MeCA==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr6550863wmc.130.1574887180709;
        Wed, 27 Nov 2019 12:39:40 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q5sm7983328wmc.27.2019.11.27.12.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Nov 2019 12:39:39 -0800 (PST)
Date:   Wed, 27 Nov 2019 21:39:39 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] avctp: Set more descriptive name for uinput device
Message-ID: <20191127203939.ag4ejy5mzsqgyugf@pali>
References: <20191126212753.18455-1-pali.rohar@gmail.com>
 <CABBYNZ+X1xThm9rrcj7ny9f9r0sVs-fTR2JroQdRgZTRWLcN6g@mail.gmail.com>
 <20191127160720.aleatv6l4swopg57@pali>
 <CANFp7mW47eJ6dquzLYX-uKoAO=Qc=ObgmSWQ5U0Xs7ThEV0Urg@mail.gmail.com>
 <20191127173641.2zsi7ccsnf3seoev@pali>
 <CANFp7mXyUKu7Za02XRcicLgrVUYiDfL-X-Bu6MZV1Of+y8LxgA@mail.gmail.com>
 <20191127175808.o6ajkrlewiwdsaoj@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dzi2xfyd2cncroyl"
Content-Disposition: inline
In-Reply-To: <20191127175808.o6ajkrlewiwdsaoj@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--dzi2xfyd2cncroyl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 27 November 2019 18:58:08 Pali Roh=C3=A1r wrote:
> On Wednesday 27 November 2019 09:45:32 Abhishek Pandit-Subedi wrote:
> > On Wed, Nov 27, 2019 at 9:36 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
> > >
> > > On Wednesday 27 November 2019 09:21:24 Abhishek Pandit-Subedi wrote:
> > > > Wouldn't it be better to use the device name for uinput rather than=
 the address?
> > >
> > > Hi!
> > >
> > > Can we access device name in bluez? If yes that would be improvement =
too!
> > >
> > > But because more profiles can export input device we still should
> > > include profile name (or abbrev) into device name.
> >=20
> > Yup, I would be totally ok with doing something like "Your Device Name
> > Here (AVCTP)"
>=20
> That it fine for me.

Would you prepare patch which change uinput name from address to real
name and add that profile name?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--dzi2xfyd2cncroyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXd7fCQAKCRCL8Mk9A+RD
Uk+FAJ0ZtoVG1sLDskivmhnXlUpfZINvrQCdF6DOEJUspOQU/R0eNazzdm3Zbdk=
=37vj
-----END PGP SIGNATURE-----

--dzi2xfyd2cncroyl--
