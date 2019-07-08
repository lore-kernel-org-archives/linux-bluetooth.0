Return-Path: <SRS0=sF93=VF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA64C606CF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 21:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CD921670
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 21:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PirSs1eG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404146AbfGHVGV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:06:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41511 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfGHVGV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jul 2019 17:06:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so18615764wrm.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2019 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NN2kMLuaO04GeJiW+YpmB2NShr1+6XXref8en5TcIRQ=;
        b=PirSs1eGvjARb6PnWgMIoyoH2WfbjXYBtFaFPPoPrjkzPw6lOaNxaOaEPVy5gz0qh2
         GCxJn7F64nBorD9Q7GgIvGNmQWC2LxlXHuwgi1dQo5sNzsvLUVR+sfNW1wKmNIEb/eMI
         mEvrQfGcWOkr2EgiK61KElm5nBS6QL7jOZMuEvt1T3rXIgdcvL0T9EfqP8gScCuAAyd0
         lFllHhPsLjWVpWJ+nWSUeLh1/H30vUoqxGTMYG8HfPbzoEBABJlFRdcUMbTrq2+8KmNt
         NBv5cB4B8EZ3A62Ar6zC4cLS0zVYLAwEL5Y/UUAH97LagtpQySi68pk+Tg3sUGoiwTil
         K1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NN2kMLuaO04GeJiW+YpmB2NShr1+6XXref8en5TcIRQ=;
        b=nXTmXvA2CCle9HZkd6Q0XsohgLpOrCTfIcnoI0VCdnrCFOilPSrBDzY+80Xk8ggNrX
         Rhtoy/MK7vCjUENO4I39NxIjQsKmMHWX9FYUp2xizv+q8ZnUVU7FnWlGaRw01PmlD7wC
         1l/9myQV9qc+1aDCogPYKY/QfJSQUWkWpw3PDzK20CjWtp/uSejKS0GOSyzrqeJ+67zU
         nhEBNxNFowa79gEPG1it+cYqOG9nlmFamlHgc9i+8RtxUoDgM7zhykfhYZMTCRKMHIO+
         VqVeo0kl3b4WjWVXNeXi5+mym99nBiDHSEUyT1DAyWVolja1gX7elwkfIsxTyMfLh0qy
         F5pw==
X-Gm-Message-State: APjAAAWrhms7JSok5gfsobvF9ONsyNwdzspDdavI9ZqvEqw6o/aTUjeK
        T72aRZGb3C3HjEG8kjpM8BgC1uua
X-Google-Smtp-Source: APXvYqy0/J7uUSJZtjA4y1XtFl1dow/FZZ/hPT9xIjbUMJE34XS/1UfJMYHlM+G73GAheRLR4hiJJg==
X-Received: by 2002:adf:e28a:: with SMTP id v10mr21211183wri.178.1562619978721;
        Mon, 08 Jul 2019 14:06:18 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id s3sm899366wmh.27.2019.07.08.14.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 14:06:17 -0700 (PDT)
Date:   Mon, 8 Jul 2019 23:06:16 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20190708210616.x2dlnzjhnplu37bz@pali>
References: <20190506151651.pu2us2fgsf7w2vos@pali>
 <20190516183429.ql3hxtnmiabcq7tj@pali>
 <CABBYNZLJB0bK7o=Tvf9mhb5U41xAin6SdPY9=76AuEvpEiA_8g@mail.gmail.com>
 <20190519082305.q7y4gpmdhvx3vzvo@pali>
 <CABBYNZJKO07p-8ufP7=4WUYS1oLhnsKY_pnP6-0SbVzi=CYZsQ@mail.gmail.com>
 <20190519212157.GB31403@amd>
 <20190607130245.mv4ch6dxnuptzdki@pali>
 <ED456CCA-CF85-48D9-B7E9-9B0BF02A32FC@holtmann.org>
 <20190708122512.qqfvtm455ltxxg3h@pali>
 <E4A6E61C-DE37-4E5D-9401-71CCE4AE2419@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gieebdnoy2n5cdez"
Content-Disposition: inline
In-Reply-To: <E4A6E61C-DE37-4E5D-9401-71CCE4AE2419@holtmann.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--gieebdnoy2n5cdez
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 08 July 2019 15:23:06 Marcel Holtmann wrote:
> Hi Pali,
>=20
> >>>>>>> to be honest, I would rather see WBS implementation finally
> >>>>>>> reach PA before we start digging into this.
> >>>>>>=20
> >>>>>> First I want to finish improving A2DP codec support in pulseaudio.=
 Later
> >>>>>> I can look at HSP/HFP profiles. Ideally it should have modular/plu=
gin
> >>>>>> extensible design. So the aim is that adding new codec would be ve=
ry
> >>>>>> simple, without need to hack something related to mSBC/WBC, AuriSt=
ream
> >>>>>> or any other codec.
> >>>>>=20
> >>>>> Well HSP don't have support for codec negotiation, but yes a modular
> >>>>> design is probably recommended.
> >>>>>=20
> >>>>>> But for AuriStream I need to set custom SCO parameters as described
> >>>>>> below and currently kernel does not support it. This is why I'm as=
king
> >>>>>> how kernel can export for userspace configuration of SCO parameter=
s...
> >>>>>=20
> >>>>> We can always come up with socket options but we got to see the val=
ue
> >>>>> it would bring since AuriStream don't look that popular among
> >>>>> headsets, at least Ive never seem any device advertising it like
> >>>>> apt-X, etc.
> >>>>=20
> >>>> Pali clearly has such device and he is willing to work on it. Surely
> >>>> that means it is popular enough to be supported...?
> >>>=20
> >>> Just put AT+CSRSF=3D0,0,0,0,0,7 to google search and you would see th=
at
> >>> not only I have such device...
> >>>=20
> >>> So I would really would like to see that kernel finally stops blocking
> >>> usage of this AuriStream codec.
> >>=20
> >> we need to figure out on how we do the kernel API to allow you this sp=
ecific setting.
> >=20
> > Hi Marcel! Kernel API for userspace should be simple. Just add two
> > ioctls for retrieving and setting structure with custom parameters:
> >=20
> >  syncPktTypes =3D 0x003F
> >  bandwidth =3D 4000
> >  max_latency =3D 16
> >  voice_settings =3D 0x63
> >  retx_effort =3D 2
> >=20
> > Or add more ioctls, one ioctl per parameter. There is already only ioctl
> > for voice settings and moreover it is whitelisted only for two values.
>=20
> it is not that simple actually. Most profiles define a certain set of par=
ameters and then they try to configure better settings and only fallback to=
 a specification defined default as last resort.

Ok. I see that there is another "example" configuration for AuriStream
with just different syncPktTypes =3D 0x02BF and bandwidth =3D 3850.

So it really is not simple as it can be seen.

> >> We have kept is really simple since there was only CVSD and mSBC as of=
 now.
> >=20
> > Seems that custom codecs are already widely used, so it would be great
> > it Linux kernel allows to use also other codecs in future without need
> > to explicitly whitelist them.
>=20
> This is an overstatement. I see only one custom codec being used. Unless =
you have heard from others. However as stated above, I think we need to pro=
vide an array of settings that are similar defined to what the HFP spec doe=
s. Then we just load the whole set into the kernel.

CVSD and mSBC are in use. IIRC specification also mandates ulaw a alaw
codecs but I have not seen it used. Has somebody tried to implement it?
I think just replacing voice_settings should be enough as encoding /
decoding should be done in bluetooth firmware / hardware.

And then there is AuriStream which based on google results it supported
by lot of headsets.

So at least 3 different codecs are widely supported by headset.

> >> I am also curious on what the assumptions are for the USB driver alter=
nate settings are when using a different codec.
> >=20
> > I did all above tests and kernel changes with USB bluetooth chip which
> > is integrated in notebook's combo bt+wifi intel minipci-e card.
>=20
> Good to know. Since for mSBC in theory they need a new alternate settings=
 that wasn=E2=80=99t really available.

I understood that both mSBC and AuriStream uses "transparent" mode of
transport and bluetooth chip itself does not know if it transmit mSBC or
AuriStream as it does not do any encoding...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--gieebdnoy2n5cdez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXSOwRgAKCRCL8Mk9A+RD
UpDYAKCEVvpSQc5v+9+4XfAvNY8iBnCoeQCfW5W4UcZC2M+2svfcSs75bmQFLXE=
=nZmi
-----END PGP SIGNATURE-----

--gieebdnoy2n5cdez--
