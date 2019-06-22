Return-Path: <SRS0=TRpe=UV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958AFC43613
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jun 2019 16:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DD420675
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jun 2019 16:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NopbJ+t/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfFVQSl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:18:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41621 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVQSl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Jun 2019 12:18:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so9425242wrm.8
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Jun 2019 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CMI+mRFz+iLb4ZvKBVqkvplhDFFP5I+NbOdbtWzF1TE=;
        b=NopbJ+t/eJ7KEetIrSzZ7ouUjol9AOJBsxBW+j+EbG06xWKgYmJrlxhsNyEBRAKF8D
         nxRxurZN5+lR4tlmdBeEKoBXSvojA2N9zFPBMkM3kWATOzmBSdNZew8EPRTTVGgrtk7j
         JkoEHB2D2E7J5JBHzC2gBPhbaDOk2tjMGySPf4BOI6YNn4phV0W6MqFDLLQ6fEjakRGM
         UI6K0aASPmzN92VR8zlOWeWfBKtnadwHcwcwJdvKRfWNCaVbLU4nNt7hKRqVaUjvkbPA
         PwloIXExxt0+AcXovbjWUp3xCw013QNttPZ8JKpofEMynqAXQtsZWWTdNDDGf79LUx4t
         Dxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CMI+mRFz+iLb4ZvKBVqkvplhDFFP5I+NbOdbtWzF1TE=;
        b=FfmcTwEPzacX9jR1QDj9CC9dv1zemW5cfFwfGxLNDaTdfIQRCrnWPuzespifNV0esX
         lXJ4RdkBJYWUggqYE8H5DrQoDHADDxt5MSkpAyImJ0hUYK+f8Kujc/43DPOYlVqaDE1w
         0JxyStbMN7Mks65r/FseBtn0sZfyhNFVSLtcxVDjTrWvCwl7EERE+rXuJsXtdyPcrifO
         ydDylWf+UFXCd7DE74dtnQWDFnBbyrNPyYGucOUZoGB51dRzMBuT/sL19rbFZkvFXVeQ
         o+1RRPbqkP6s1YipxGziHkjSOWPQM8cfR4Rn7CALjbZdoKsyeNEh1doHB26v5U5OCWBC
         KomQ==
X-Gm-Message-State: APjAAAVk4Wi2ZqeZDGOy7ZXQmrTAFnvTzIS2TlDp3EzQSKWqfETXaZsV
        dgJqjPIR7Z5Y8ZkEJAqFa8g=
X-Google-Smtp-Source: APXvYqy1D07eeNwLLE5bXDM/HrLBjPMDcT2JdWRhJKSsoOPxPAi2BNGnc5EoWVmtzO+yHtRhppI1OQ==
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr42473129wrq.171.1561220319606;
        Sat, 22 Jun 2019 09:18:39 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v65sm8924290wme.31.2019.06.22.09.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 09:18:38 -0700 (PDT)
Date:   Sat, 22 Jun 2019 18:18:37 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez - check for new a2dp features
Message-ID: <20190622161837.37mjlsirpoql2plj@pali>
References: <20190513170550.bsbr2mh7w36hj7io@pali>
 <20190607125800.trsx2o3njaiaitu2@pali>
 <CABBYNZLtgaCi5VGHapsKQG4iAC33ySow3AuH0Qkx8iCo3LcZDg@mail.gmail.com>
 <20190607153715.w5exsodd25qxc6xv@pali>
 <CABBYNZ+gPRkAgFAeeoSqZ7tp5fYimGdju9JSuSpn_kL+f9hJhQ@mail.gmail.com>
 <20190608105924.qmauvrwyz7nofx74@pali>
 <20190608111553.65s6yoyhmusmr3pc@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rkagearibs2fivhg"
Content-Disposition: inline
In-Reply-To: <20190608111553.65s6yoyhmusmr3pc@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--rkagearibs2fivhg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 08 June 2019 13:15:53 Pali Roh=C3=A1r wrote:
> On Saturday 08 June 2019 12:59:24 Pali Roh=C3=A1r wrote:
> > Ok. So is there any way how to check if bluez supports profile switching
> > or not? And if not, could be introduced some flag/property on DBus so
> > applications would not this information?
>=20
> Because older versions of bluez does not support profile switching and
> does not support properly remembering last used SEP, I need to know this
> information in pulseaudio. To prevent any breakage e.g. that high
> bandwidth codec would be chosen by old version of bluez in unsuitable
> environment. Because of these problems I do not think that pulseaudio
> should register these high quality codec with fixed high bandwidth. And
> currently there is no way (or at last I do not know) how to check if
> bluez support these features. And I need to know it at time when
> pulseaudio is registering to DBus so it would correctly decide if SBC
> UHQ codec should be registered via DBus to bluez or not.
>=20
> Currently I know one way how to detect it -- look if there are available
> SEP paths at dbus. But this works only after A2DP connection is active.
> So I cannot use this "heuristic".
>=20
> Therefore I'm asking for some DBus property or flag or whatever which
> would tell me, prior to registering A2DP codecs via DBus to bluez, if
> bluez supports profile switching or not.
>=20
> Without this information, pulseaudio could enter into state when it is
> unable to transmit any audio via bluetooth because old bluez chosen
> unsuitable codec. And because old bluez version does not support profile
> switching, nobody (pulseaudio or user) is able to fix this problem.

Would be possible to provide this runtime dbus information? As explained
in previous email, I really need it for pulseaudio for additional A2DP
codec support.

If not, then I would be forced to use compile time check (probably via
bluez.pc) and based on this decide if support for additional codecs and
profile switching would be compiled into pulseaudio or not... But this
would work only in case whole profile switching would not be hidden
under --experimental command line flag. So another configure flag for
pulseaudio would be needed.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--rkagearibs2fivhg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXQ5U2wAKCRCL8Mk9A+RD
UnKbAKCzIfKoPaFFFb94t8ax9J3PZY48fgCfTq1J9bO8KAPVfgl47fUsv5/RyAw=
=9hk2
-----END PGP SIGNATURE-----

--rkagearibs2fivhg--
