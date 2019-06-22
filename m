Return-Path: <SRS0=TRpe=UV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1F0C43613
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jun 2019 17:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8482070B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jun 2019 17:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0X3HWYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfFVRJi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Jun 2019 13:09:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36405 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfFVRJi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Jun 2019 13:09:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id u8so9427653wmm.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Jun 2019 10:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MQfb9mWAgiaErzXudV/lKe1JZ8MI7YZtvTDmsbbiTqQ=;
        b=R0X3HWYnvDR2HXQaIMX0qJylRTybeTSVeYgkGwB0fVvflO5BpFIw/7x7VgWdEK/5Wn
         ufsf++VExKp6Yh2aalc4I5eGlKg2Wbjfs7HHkpp6Jhqq8vwVaxOjVOa/ITNP9o+f8TkX
         0vTwkRl2xPMRhzsqn2KGu84kgqaRtMUbuXF/NphqDrE47vLUN5hwOdqnfzX5CmjVdAg5
         65Iu5lLWd3v1GFA5f+FuT0hUfLHftwnvep9O8G792+7LDfZmiz5f5xaB5R4RXpsCb5lS
         zUxb72lCfJkIvYsEx0429ecxz1NO7DAKWnYdWH2U/0RM/mWGirKY4nsbiDJm8MQB1iDw
         0cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MQfb9mWAgiaErzXudV/lKe1JZ8MI7YZtvTDmsbbiTqQ=;
        b=A+e5pq/qx2FNGGVVq4SqHKORJD91fSmd1miiwt2VeNit+4lOQ4kRAnMd601HIr3Tv9
         qs0O2zzqPYX0xg3hcuDT4t2ho00qZcpqQITdceSipFEwIiY4fvTpuwBicfEdGblzTqhe
         uWTD6wNZTxrANT6k8N+sl59TUCD87oKo0h7xD3gXAELzJ4dKiSGwT5kY1YE63HkEi+u+
         ITnCS1kZMpEYwaKW9PN/mTxpCDcS2bbSCfnhrF/CzPLFfc3UDzT9C5X1xqA654fQW9zF
         zM633KUYsZ2LmAaThZ5bmU3L137dpww2W48rC+32wWHN2jZHQp9CPJG9Bj7/Ed9l29wL
         UnAw==
X-Gm-Message-State: APjAAAXtwiffFznK+NluD6RRwgZBrRXCWo+DrZqBq6nRfmyXtQAHjiIh
        NcUhzSbGW/JGFXMpjfFUNDcXdchq
X-Google-Smtp-Source: APXvYqyi+3JFQxzOxFwomDeqnVJmkEyTt9azMHprYu+7hQkNoIF5Ho64bYWd/rrodaKndQrGQVB7xg==
X-Received: by 2002:a1c:4956:: with SMTP id w83mr8362279wma.67.1561223375297;
        Sat, 22 Jun 2019 10:09:35 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id r5sm13281373wrg.10.2019.06.22.10.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 10:09:34 -0700 (PDT)
Date:   Sat, 22 Jun 2019 19:09:33 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez - check for new a2dp features
Message-ID: <20190622170933.lxuftoxmvtv7ssfo@pali>
References: <20190513170550.bsbr2mh7w36hj7io@pali>
 <20190607125800.trsx2o3njaiaitu2@pali>
 <CABBYNZLtgaCi5VGHapsKQG4iAC33ySow3AuH0Qkx8iCo3LcZDg@mail.gmail.com>
 <20190607153715.w5exsodd25qxc6xv@pali>
 <CABBYNZ+gPRkAgFAeeoSqZ7tp5fYimGdju9JSuSpn_kL+f9hJhQ@mail.gmail.com>
 <20190608105924.qmauvrwyz7nofx74@pali>
 <20190608111553.65s6yoyhmusmr3pc@pali>
 <20190622161837.37mjlsirpoql2plj@pali>
 <CABBYNZK-L0NfuR9Qq8Vj9Q7nxmgurzkimayJHSKV+kTJ7D_tUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qfwjj4tmo3d7tuf5"
Content-Disposition: inline
In-Reply-To: <CABBYNZK-L0NfuR9Qq8Vj9Q7nxmgurzkimayJHSKV+kTJ7D_tUA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--qfwjj4tmo3d7tuf5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 22 June 2019 20:01:15 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Sat, Jun 22, 2019 at 7:18 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > On Saturday 08 June 2019 13:15:53 Pali Roh=C3=A1r wrote:
> > > On Saturday 08 June 2019 12:59:24 Pali Roh=C3=A1r wrote:
> > > > Ok. So is there any way how to check if bluez supports profile swit=
ching
> > > > or not? And if not, could be introduced some flag/property on DBus =
so
> > > > applications would not this information?
> > >
> > > Because older versions of bluez does not support profile switching and
> > > does not support properly remembering last used SEP, I need to know t=
his
> > > information in pulseaudio. To prevent any breakage e.g. that high
> > > bandwidth codec would be chosen by old version of bluez in unsuitable
> > > environment. Because of these problems I do not think that pulseaudio
> > > should register these high quality codec with fixed high bandwidth. A=
nd
> > > currently there is no way (or at last I do not know) how to check if
> > > bluez support these features. And I need to know it at time when
> > > pulseaudio is registering to DBus so it would correctly decide if SBC
> > > UHQ codec should be registered via DBus to bluez or not.
> > >
> > > Currently I know one way how to detect it -- look if there are availa=
ble
> > > SEP paths at dbus. But this works only after A2DP connection is activ=
e.
> > > So I cannot use this "heuristic".
> > >
> > > Therefore I'm asking for some DBus property or flag or whatever which
> > > would tell me, prior to registering A2DP codecs via DBus to bluez, if
> > > bluez supports profile switching or not.
> > >
> > > Without this information, pulseaudio could enter into state when it is
> > > unable to transmit any audio via bluetooth because old bluez chosen
> > > unsuitable codec. And because old bluez version does not support prof=
ile
> > > switching, nobody (pulseaudio or user) is able to fix this problem.
> >
> > Would be possible to provide this runtime dbus information? As explained
> > in previous email, I really need it for pulseaudio for additional A2DP
> > codec support.
> >
> > If not, then I would be forced to use compile time check (probably via
> > bluez.pc) and based on this decide if support for additional codecs and
> > profile switching would be compiled into pulseaudio or not... But this
> > would work only in case whole profile switching would not be hidden
> > under --experimental command line flag. So another configure flag for
> > pulseaudio would be needed.
>=20
> I think a better idea would be that we introduce something specific to
> that, such as the SEID being returned so the next time around you may
> restore a SEID, this may actually make more sense perhaps if we reuse
> the RegisterApplication semantics:
>=20
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#=
n464
>=20
> That means it is no longer required to call RegisterEndpoint as many
> times as there are endpoints since that is time-consuming due to the
> D-Bus round trips, instead, the endpoint are discovered with the use
> of ObjectManager, if the method doesn't exist then you just fall back
> to the old mechanism since it might be an old daemon.

Hi! If I understand it correctly, pulseaudio would register itself via
new dbus method and bluez daemon then discover A2DP SEP endpoints
automatically, right? And if that new dbus method does not exist
pulseaudio would know that in system is running old bluez version
without codec switching support. Seems it is perfectly fine solution.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--qfwjj4tmo3d7tuf5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXQ5gywAKCRCL8Mk9A+RD
UonpAJ9vzZAreilqNELuTE7LIaME/LYpGACgkZAOBgUEHQSDj2poExHIwhoBqd8=
=wBwB
-----END PGP SIGNATURE-----

--qfwjj4tmo3d7tuf5--
