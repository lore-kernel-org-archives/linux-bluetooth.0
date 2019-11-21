Return-Path: <SRS0=kdk/=ZN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B560FC432C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 23:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D48020692
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 23:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gm5OlokZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfKUXAV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:00:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33283 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfKUXAU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Nov 2019 18:00:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id t26so4913464wmi.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2019 15:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cZwKxNQN0fl24EguBjRt3ic7KOlx7KkId0ZH5i0c+8M=;
        b=Gm5OlokZ9LfPvXM/eOzddvTybQdHXNd49c0SLeuaCj3WAc7X2z39MrJLJOrwr7uPta
         VkvmqvCEo9NQ1/4sZYLlpK9gHqu8xKAN9eCdYdO/QXpUx61/iV3hWdVXCqLUVdcD7t9V
         J+MVQJX1o+P6V5icK9XIfBNIXbxK9rs8eXdyGLS8gJOITrQf6TVsAexmOMXUGGAW/mkD
         YrKbouJosCuolHRe41Udwzhm7v00zh4wpmaIFzmTsJfGNc14SMKxxeB8YiieN3NaDVgG
         Yyj6qLUmRg046UHPQXPikKJ4nwSQtGbV0vtQSoZYnVljcCPIe8ABIBFzZGomzd/B73eS
         bEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cZwKxNQN0fl24EguBjRt3ic7KOlx7KkId0ZH5i0c+8M=;
        b=LLUltHumj710D3qcgDlIA1GTuJ9VgA3h1PIXQjX+JXHPWSxs2ZfuOLlpkCvWXi5G9i
         I6AZS2+Lm2yDOHS6I9Pggvro1wGJSWxXDeNXGqO/M+JQ3YHTXeLuhGi7UrePFld3QNsY
         mBPbwQqC/+eej6CPRljT2ogkdoQY7tjmV+m8oyCsmt35ZQydZR2f/yh/ukeSjZ6iZhvV
         plBnXUDrTPriisUqKp5IgVuPHFiTaTkg8GUFuEI0ycaHdNKKtFQmJxhxKsl9RPycIagl
         fTQVixle3CytDSoqdPwQn5PMR5QyZXxYLLp9xGCu6/SrkhpIt8mzp3Gh6M1DzyhgC6Sd
         njKA==
X-Gm-Message-State: APjAAAUsiKbinyGrERd5FnhXGUZcPbSM3mIe+LOL6xsTuDVebnBdgmSE
        K7JedKopV9iAhxZ59bD7eDo=
X-Google-Smtp-Source: APXvYqz3Q8/LfTuzMuXqfq5jzBzk0McH2mj2awLrnHJjLFi/F9uq/TfXulP0xigy5fEVhrx113D94Q==
X-Received: by 2002:a05:600c:212:: with SMTP id 18mr13508711wmi.93.1574377217688;
        Thu, 21 Nov 2019 15:00:17 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id g11sm1256099wmh.27.2019.11.21.15.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 15:00:16 -0800 (PST)
Date:   Fri, 22 Nov 2019 00:00:15 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20191121230015.be7qyufbll2khhbx@pali>
References: <CABBYNZJKO07p-8ufP7=4WUYS1oLhnsKY_pnP6-0SbVzi=CYZsQ@mail.gmail.com>
 <20190519212157.GB31403@amd>
 <20190607130245.mv4ch6dxnuptzdki@pali>
 <ED456CCA-CF85-48D9-B7E9-9B0BF02A32FC@holtmann.org>
 <20190708122512.qqfvtm455ltxxg3h@pali>
 <E4A6E61C-DE37-4E5D-9401-71CCE4AE2419@holtmann.org>
 <20190708210616.x2dlnzjhnplu37bz@pali>
 <D0A44CC7-CABC-408A-894E-AAD700FA9B0D@holtmann.org>
 <20190718100939.bwl26qcfxe6ppcto@pali>
 <814EF218-4123-4C29-BECB-AF1B556C0F67@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2gzlfzjr2rb6aj6q"
Content-Disposition: inline
In-Reply-To: <814EF218-4123-4C29-BECB-AF1B556C0F67@holtmann.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--2gzlfzjr2rb6aj6q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 18 July 2019 22:06:03 Marcel Holtmann wrote:
> Hi Pali,
>=20
> >>>>>>>>>>> to be honest, I would rather see WBS implementation finally
> >>>>>>>>>>> reach PA before we start digging into this.
> >>>>>>>>>>=20
> >>>>>>>>>> First I want to finish improving A2DP codec support in pulseau=
dio. Later
> >>>>>>>>>> I can look at HSP/HFP profiles. Ideally it should have modular=
/plugin
> >>>>>>>>>> extensible design. So the aim is that adding new codec would b=
e very
> >>>>>>>>>> simple, without need to hack something related to mSBC/WBC, Au=
riStream
> >>>>>>>>>> or any other codec.
> >>>>>>>>>=20
> >>>>>>>>> Well HSP don't have support for codec negotiation, but yes a mo=
dular
> >>>>>>>>> design is probably recommended.
> >>>>>>>>>=20
> >>>>>>>>>> But for AuriStream I need to set custom SCO parameters as desc=
ribed
> >>>>>>>>>> below and currently kernel does not support it. This is why I'=
m asking
> >>>>>>>>>> how kernel can export for userspace configuration of SCO param=
eters...
> >>>>>>>>>=20
> >>>>>>>>> We can always come up with socket options but we got to see the=
 value
> >>>>>>>>> it would bring since AuriStream don't look that popular among
> >>>>>>>>> headsets, at least Ive never seem any device advertising it like
> >>>>>>>>> apt-X, etc.
> >>>>>>>>=20
> >>>>>>>> Pali clearly has such device and he is willing to work on it. Su=
rely
> >>>>>>>> that means it is popular enough to be supported...?
> >>>>>>>=20
> >>>>>>> Just put AT+CSRSF=3D0,0,0,0,0,7 to google search and you would se=
e that
> >>>>>>> not only I have such device...
> >>>>>>>=20
> >>>>>>> So I would really would like to see that kernel finally stops blo=
cking
> >>>>>>> usage of this AuriStream codec.
> >>>>>>=20
> >>>>>> we need to figure out on how we do the kernel API to allow you thi=
s specific setting.
> >>>>>=20
> >>>>> Hi Marcel! Kernel API for userspace should be simple. Just add two
> >>>>> ioctls for retrieving and setting structure with custom parameters:
> >>>>>=20
> >>>>> syncPktTypes =3D 0x003F
> >>>>> bandwidth =3D 4000
> >>>>> max_latency =3D 16
> >>>>> voice_settings =3D 0x63
> >>>>> retx_effort =3D 2
> >>>>>=20
> >>>>> Or add more ioctls, one ioctl per parameter. There is already only =
ioctl
> >>>>> for voice settings and moreover it is whitelisted only for two valu=
es.
> >>>>=20
> >>>> it is not that simple actually. Most profiles define a certain set o=
f parameters and then they try to configure better settings and only fallba=
ck to a specification defined default as last resort.
> >>>=20
> >>> Ok. I see that there is another "example" configuration for AuriStream
> >>> with just different syncPktTypes =3D 0x02BF and bandwidth =3D 3850.
> >>>=20
> >>> So it really is not simple as it can be seen.
> >>=20
> >> currently the stepping for mSBC and CVSD are hard-coded in esco_param_=
cvsd and esco_param_msbc arrays in hci_conn.c and then selected by the ->se=
tting parameter.
> >>=20
> >> So either we provide an new socket option (for example BT_VOICE_EXT) o=
r we extend BT_VOICE to allow providing the needed information. However thi=
s needs to be flexible array size since we should then be able to encode mu=
ltiple stepping that are tried in order.
> >>=20
> >> My preference is that we extend BT_VOICE and not introduce a new socke=
t option. So feel free to propose how we can load the full tables into the =
SCO socket. I mean we are not really far off actually. The only difference =
is that currently the tables are in the hci_conn.c file and selected by the=
 provided voice->setting. However nothing really stops us from providing th=
e full table via user space.
> >=20
> > Ok. I will look at it and I will try to propose how to extend current
> > BT_VOICE ioctl API for supporting all those new parameters.
> >=20
> >>>>>> We have kept is really simple since there was only CVSD and mSBC a=
s of now.
> >>>>>=20
> >>>>> Seems that custom codecs are already widely used, so it would be gr=
eat
> >>>>> it Linux kernel allows to use also other codecs in future without n=
eed
> >>>>> to explicitly whitelist them.
> >>>>=20
> >>>> This is an overstatement. I see only one custom codec being used. Un=
less you have heard from others. However as stated above, I think we need t=
o provide an array of settings that are similar defined to what the HFP spe=
c does. Then we just load the whole set into the kernel.
> >>>=20
> >>> CVSD and mSBC are in use. IIRC specification also mandates ulaw a alaw
> >>> codecs but I have not seen it used. Has somebody tried to implement i=
t?
> >>> I think just replacing voice_settings should be enough as encoding /
> >>> decoding should be done in bluetooth firmware / hardware.
> >>>=20
> >>> And then there is AuriStream which based on google results it support=
ed
> >>> by lot of headsets.
> >>>=20
> >>> So at least 3 different codecs are widely supported by headset.
> >>=20
> >> The ulaw and alaw air codecs are in theory possible, but nobody in the=
 history of Bluetooth has used them. So just ignore that part of the specif=
ication. For air codecs you have either CVSD or transparent. And then with =
transparent you get mSBC and AuriStream.
> >=20
> > More interesting question would be if alaw codec can be used in
> > transparent mode by transmitter and in "normal alaw" mode by receiver.
> > So it is possible to "tell" bluetooth chip "hey, I have already prepared
> > alaw or CVSD packets for you=E2=80=9D?
>=20
> actually alaw is an over the air codec. Using it in transparent mode has =
no profile support. So while possible, it is not interoperable.

I'm looking at Voice Setting parameters and it is possible to set Input
Coding Format to alaw and also Air Coding Format to alaw. It is not
Transparent Air mode, so above problem with profile interoperability
does not have to be there. So in theory it should be possible to
configure bluetooth chip to pass-thru alaw data without re-encoding
them. So after new API for "unlocking" other non-whitelisted Voice
Settings is there, this can start to be tested...

Apparently there is no CVSD Input Coding Format in Voice Setting, so
CVSD codec data cannot be pass-thru to bt chip via existing Setup
Synchronous Connection. But there is Enhanced Setup Synchronous
Connection command which does not use Voice Setting structure which
seems to be more powerfull in codec handling.

> > In Europe all landline phones (and also their SIP non-compressed
> > equivalents) use alaw codec. So ability to pass SIP alaw samples
> > directly to headset could increase quality of SIP calls. As currently
> > received alaw samples are converted to linear PCM, then send to
> > bluetooth chip which converts it into CVSD codec and finally bluetooth
> > headset converts CVSD to analog.
>=20
> Nice idea, but not worth the effort.
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--2gzlfzjr2rb6aj6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXdcW/QAKCRCL8Mk9A+RD
UujeAJsEp2pQuvIcmMBjXGMhysuduC2IBwCgukEg7Jaej7NC17Oh4oS1wg6Bn7M=
=uZhV
-----END PGP SIGNATURE-----

--2gzlfzjr2rb6aj6q--
