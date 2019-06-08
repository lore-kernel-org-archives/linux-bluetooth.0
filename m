Return-Path: <SRS0=Jazt=UH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28A8C28CC5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Jun 2019 11:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84179214AE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Jun 2019 11:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2gGjBbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfFHLP5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:15:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54183 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfFHLP5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 8 Jun 2019 07:15:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so4370855wmj.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Jun 2019 04:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1uv38z7jdROtYEtg+nuedDhs4RO9oTEXTYIZtPcbQJI=;
        b=E2gGjBbHdga/NAAYp3kNgMhd2aJB9QvMHlk5Rd0ggAGC/XlCdMCOQVSHxfFcA6aX3/
         5B7HE8391WDy7s5ELPP9T7BmTglVCtLjltLRzW421UX87xOZKWFB0PwGk3svr/Z76W81
         aACixWODliJDWEg5eNpK30bT4AbOy+366/8Zh7LrwpofDzQDNlQdA/QroOvodj8UG/vE
         8FAIQQQllFqnwndeD2EZf0to1WRU+tyP96w+oaHGQjzH9UzHfowa29JE6uq3WVUSJkRg
         xqZxpE+u/VndZQPRBbaDjzwD+zS/ilnU3OVfbrKzSvoD1Sc/FPfDnxV3DocvS/SenAmO
         Op6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1uv38z7jdROtYEtg+nuedDhs4RO9oTEXTYIZtPcbQJI=;
        b=YwereLLgSqtrR7xUbPMUjhjy++VM/+wdJkvOi/2lZvc405avUbTCIbfrD2xQjWDYVH
         6zBwrQPFoZitqITm5CjvmKTRh/yd91IoVVm5w15l8N3v/9tLQy2ZB2dLCmhpR698bWJC
         tGrBGDASOzOs4MTq+EuTC6G8cGDPl5RpNk7M0i3l6SA+3be2ZNEQNa0F2z0ylOCsSsRS
         k11Z7w88eYFPaq1HBlf/v4QB1KiVLyjXGwPpwENNlplwaCZwL2m9IEJRrMBZcE7hX6TV
         prpRQgCfStJIEyrYcsFSKgXK+AjyH6bntRGacKxPhAnyEfdoQLrnuHGdjtKQwP59wof9
         pqYA==
X-Gm-Message-State: APjAAAXVlU8LyZS7cmxhpiJKgL00dLAtH2vuOW2nnlm+IunwveHD66yI
        Eob9kTwAguSsqOWScITMN68=
X-Google-Smtp-Source: APXvYqxzqp3PtdVHwLEfZ6vC4Vft0Q57wKp/D9f8AZM4bWL66djPe1NWqtatqpSwIZ6h+JDWm0qCvg==
X-Received: by 2002:a1c:f319:: with SMTP id q25mr6537630wmq.129.1559992555195;
        Sat, 08 Jun 2019 04:15:55 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id h1sm4245139wrt.20.2019.06.08.04.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Jun 2019 04:15:54 -0700 (PDT)
Date:   Sat, 8 Jun 2019 13:15:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez - check for new a2dp features
Message-ID: <20190608111553.65s6yoyhmusmr3pc@pali>
References: <20190513170550.bsbr2mh7w36hj7io@pali>
 <20190607125800.trsx2o3njaiaitu2@pali>
 <CABBYNZLtgaCi5VGHapsKQG4iAC33ySow3AuH0Qkx8iCo3LcZDg@mail.gmail.com>
 <20190607153715.w5exsodd25qxc6xv@pali>
 <CABBYNZ+gPRkAgFAeeoSqZ7tp5fYimGdju9JSuSpn_kL+f9hJhQ@mail.gmail.com>
 <20190608105924.qmauvrwyz7nofx74@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="buq7kc7sfudypo5w"
Content-Disposition: inline
In-Reply-To: <20190608105924.qmauvrwyz7nofx74@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--buq7kc7sfudypo5w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 08 June 2019 12:59:24 Pali Roh=C3=A1r wrote:
> Ok. So is there any way how to check if bluez supports profile switching
> or not? And if not, could be introduced some flag/property on DBus so
> applications would not this information?

Because older versions of bluez does not support profile switching and
does not support properly remembering last used SEP, I need to know this
information in pulseaudio. To prevent any breakage e.g. that high
bandwidth codec would be chosen by old version of bluez in unsuitable
environment. Because of these problems I do not think that pulseaudio
should register these high quality codec with fixed high bandwidth. And
currently there is no way (or at last I do not know) how to check if
bluez support these features. And I need to know it at time when
pulseaudio is registering to DBus so it would correctly decide if SBC
UHQ codec should be registered via DBus to bluez or not.

Currently I know one way how to detect it -- look if there are available
SEP paths at dbus. But this works only after A2DP connection is active.
So I cannot use this "heuristic".

Therefore I'm asking for some DBus property or flag or whatever which
would tell me, prior to registering A2DP codecs via DBus to bluez, if
bluez supports profile switching or not.

Without this information, pulseaudio could enter into state when it is
unable to transmit any audio via bluetooth because old bluez chosen
unsuitable codec. And because old bluez version does not support profile
switching, nobody (pulseaudio or user) is able to fix this problem.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--buq7kc7sfudypo5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXPuY6AAKCRCL8Mk9A+RD
Uj3XAKCCZqr/XHtb8whAcXKIUO/N28rQbgCgvfjrpupJz8Xz00gl3voNHakUrgU=
=HvE9
-----END PGP SIGNATURE-----

--buq7kc7sfudypo5w--
