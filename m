Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EAF29408
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809385; cv=none; b=twLFp9vPVompXvRGEKUxhDK3CuLJWHKTgxvC3ChUmiTRm1e+gJl6Iw3jVJXXzDyLleAyDNsEIDsirIdVvslPBaV36JfedhGw8eFhu3dho1tLKuStPCy+xNrzFVm9QlxhEgbWKk4UbycTk6O0c4Ibin2UxLC8sN6m0BY6rnGE7yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809385; c=relaxed/simple;
	bh=WtLOKJqOPwRVKIyMJgyNezN9Kwgsj9hv3GzVetrqeWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMg1p86Yym74QsDTTfmQrhZXDwpu7wnvCwgN7BY9rEpnyY5xzVxFcYkoBWf2LgTgISoh81M1IecUuBoFRTJ/It/RGlPVcz2QiqeWdaWaE9Mc2dib3lkOTdU5z67+tr/fm0Mwa/j0CVhcmHaQVxxWbsIO1pWcKrEONddrJI84S2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2aqGgVV; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2aqGgVV"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30761be8fa7so45674631fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 08:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739809382; x=1740414182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAQRsdLZPHJLgrDhhG3/V3vln6nvwPll+SJ611LpD2s=;
        b=U2aqGgVVjfKf68fby5K7d1s7LSeTKscwEaJ/Yn3xIV0jABszTYQO/nWVsd5RgoNMuU
         bR6PXBjFG9f04779MRb3bUK9JAsG72Nmdgs6lUchEe13Z/kaFKn/ezn9PxvpC8oYy2eL
         vZ5NA4eQSZbMCiPkBCiHNA14oUXec7ifL3sOsAfdMW3XPPBvc8fEs0v7xDi/FT1HKVO7
         QDkLH2NSAVn5fYLoVPRNQEdPqyhiDW6H6Kuk1bzRfJAt0PIbU0vf/OY2hwX8CRuCavYB
         zmB8mb73f9FTgts/PnxyMxFvMm2d48OyFJREuogq74x6ksO3V5NSd2QNyr+OWXzoptjd
         qMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809382; x=1740414182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAQRsdLZPHJLgrDhhG3/V3vln6nvwPll+SJ611LpD2s=;
        b=ei4xB68yV3QOnznFrdo/RFFTOzRapw7W9/r/o7eNxs220vzQ156DIfgauPtNHxrWEt
         l3vx55vr9Do4F+ckGqin9kiHoZR5UApe5m+5FrayonkvD9aKPOtV8BCbWla4ABNXzrDe
         Ck4UtsI6Gvv8mxrpgXw/voOBzxNDDViLrioFTXMHS6hD2sZDW2oMS7/3ZJQcOsK3+9+4
         8Kl93OU1y1753MSF4G0WjBKdvDrtI/lj7sOFySj/i7oMtZ30rotoi2YYmejPOimLuBjm
         ddDA82g9PxoZGkv7fQPupKTvlI3viYoVW/w/cTTOPBo198UTImn1J/MmaTv8MLqlzfXw
         MJJA==
X-Gm-Message-State: AOJu0YwR5loM8pasy9nenwaLD6oaEBZ18/4PwS0d3lo0531Um/sSPnoT
	FBtdGzZ/nAG02t44ONl31Xo5hTwRPH0tcetRyxf4PD7Kwt3fUz3uriiLgJge/uAFg3P/yFwWlxN
	TV5nmMyLMWqXOIBQa1uNbTEmUeQpSuiATIcg=
X-Gm-Gg: ASbGncteS/4D/2I4cAxBv0ZrZqFmlc0t/d6/B4RoRumL+kj9cYcNPLbfOD1O6LzFMRj
	XTvm9MgjNTe2a5uVqHkkpvzYDGTgLDW91OiOnzIy1mS0LED0PcG4XUFyI2S5rRE+UKNMP7/6hfA
	==
X-Google-Smtp-Source: AGHT+IGmt+t1SqS9o7AHhaSebqKQr16/quuSH8U2dM1LVyjfDnRNB1Q3XZia+CprRy2cCqz72uJI/siIa6wDWOMiLrE=
X-Received: by 2002:a2e:8854:0:b0:302:3003:97e with SMTP id
 38308e7fff4ca-30927ad544bmr30820431fa.30.1739809381534; Mon, 17 Feb 2025
 08:23:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214202129.968369-1-luiz.dentz@gmail.com> <CABBYNZJmigw_3=5CZ5eaSGC8ZHTzmsZA11p558EtcET-FcrVEA@mail.gmail.com>
 <3e36e6c2c9b201a5c06c0bc166cd4d38bb8067b3.camel@iki.fi>
In-Reply-To: <3e36e6c2c9b201a5c06c0bc166cd4d38bb8067b3.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Feb 2025 11:22:48 -0500
X-Gm-Features: AWEUYZln0DMZzdEIHeoMslvCis0VFKhdi2lSgyvoXHvwOwUKN9xWVTGEdWiwyqs
Message-ID: <CABBYNZK2_CLBTxEx6Ot7PgV35kBV5botcPrX55fAE60APMLBGw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] org.bluez.Device: Introduced PreferredBearer
To: Pauli Virtanen <pauli.virtanen@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Feb 15, 2025 at 1:27=E2=80=AFPM Pauli Virtanen <pauli.virtanen@iki.=
fi> wrote:
>
> Hi,
>
> pe, 2025-02-14 kello 15:32 -0500, Luiz Augusto von Dentz kirjoitti:
> > On Fri, Feb 14, 2025 at 3:21=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This introduces PreferredBearer property which can be used to indicat=
e
> > > what bearer shall be connected first rather than just using last seen
> > > bearer which may not work always since it seems some devices sometime=
s
> > > advertises on LE bearer but expects connections over BR/EDR e.g:
> > >
> > > https://github.com/bluez/bluez/issues/1092
> > >
> > > Also with the introduction of LE Audio this might become even more of=
 a
> > > problem since most likely users would like to select which bearer to =
use
> > > rather than using the last-seen policy.
> > > ---
> > >  doc/org.bluez.Device.rst | 23 ++++++++++++++++++++++-
> > >  1 file changed, 22 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
> > > index f8d4a68a6b41..e3cf4d12b173 100644
> > > --- a/doc/org.bluez.Device.rst
> > > +++ b/doc/org.bluez.Device.rst
> > > @@ -40,7 +40,8 @@ void Connect()
> > >         are skip and check latest seen bearer.
> > >
> > >         3. Connect last seen bearer, in case the timestamps are the s=
ame BR/EDR
> > > -       takes precedence.
> > > +       takes precedence, or in case **PreferredBearer** has been set=
 to a
> > > +       specific bearer then that is used instead.
> > >
> > >         Possible errors:
> > >
> > > @@ -346,3 +347,23 @@ array{object, dict} Sets [readonly, experimental=
]
> > >         :byte Rank:
> > >
> > >                 Rank of the device in the Set.
> > > +
> > > +string PreferredBearer [readwrite, optional, experimental]
> > > +``````````````````````````````````````````````````````````
> > > +
> > > +       Indicate the preferred bearer when initiating a connection, o=
nly
> > > +       available for dual-mode devices.
> > > +
> > > +       Possible values:
> > > +
> > > +       :"last-seen":
> > > +
> > > +               Connect to last seen bearer first. Default.
> > > +
> > > +       :"bredr":
> > > +
> > > +               Connect to BR/EDR first.
> > > +
> > > +       :"le":
> > > +
> > > +               Connect to LE first.
> > > --
> > > 2.48.1
> >
> > Please have a look at this since we might need some integration with
> > upper layers, at very least bluetooth settings needs to be involved,
> > this is similar to the likes of Windows and Android settings which
> > allows enabling LE Audio on per device basis but instead of being
> > specific to LE Audio, which rules out other services that maybe
> > exposed over LE, this enables the connection policy to be tuned per
> > bearer. Now there maybe another policy which we could use which is to
> > do dual-mode, but I don't think headsets will deal nicely with that,
> > specially because no-one seem to be doing it, that said that would
> > make things simpler since we could expose things to be just a
> > codec/transport switch rather than a entire bearer switch.
>
> This sounds like like it could solve the problem that currently we more
> or less have to set ControllerMode=3Dle to get LE Audio on initial
> pairing.
>
> In Pipewire this probably allows adding an user selectable "profile"
> entry for LE Audio when connected via bredr, which would switch bearer
> and issue disconnect + reconnect.
>
> Probably Gnome BT settings also would need to grow a corresponding
> setting. Labeling such setting so that people understand it is maybe
> harder...
>
> There's a few questions:
>
> - Is there something that tells which bearers are available for a
> device? It would probably be needed too if it doesn't exist.

The presence of PreferredBearer will indicate the device is a
dual-mode, LE+BR/EDR, otherwise you can use the address type to
determine what bearer it is but in that case you only have one bearer
so I don't think it is useful.

> - Interaction with CSIP, if you pair initially with bredr I think you
> don't get the other earbud paired. If you switch bearer + disconnect +
> connect, does it pair & connect the other one?

I think we would normally try to do cross transport pairing
automatically, if that is not currently happening then perhaps there
is a bug, anyway as part of this exercise we can check how dual-mode
is working and if there is some technical debt like this.

> - Who is going to be the agent that accepts the pairing of the other
> CSIP devices? GNOME BT settings I think is not running all time (and
> does it do CSIP accepts?).

Usually it is quick enough that once you attempt to connect to one
member the other are pick up immediately so I assume this is not
really a problem, well except if there is a problem and the other set
members are not advertising or something, we could in theory bypass
authentication based on other set members in case of just-works method
since we are already doing this when there is a call to Device.Pair
for example (see baafe60d9cbbd9e7939fb6d050d9896731d1ac70).

> - Whether disconnect+reconnect should be needed to switch the bearer,
> or if just changing the property is enough if already connected? Maybe
> it is needed?

Hmm, are asking about changing the property would trigger procedures
in case it is already connected? I guess we will need to decide if
that is required, it is not that great to pass errors via reply to a
property change and I'd assume that even if the reconnection fails the
idea is that the new policy persist so I think we would be better off
not attempting to do anything when the property is changed and wait
the user to disconnect, etc, and in that case I wouldn't put anything
at pipewire to attempt to switch the PreferredBearer since this is
sort of out of the Media* interface it probably shall be controlled by
Bluetooth settings rather than audio, Id only recommend messing around
with bearer switch if we ever implement the dual-mode bearer since
then it is just a matter of switching the MediaTransport, but I don't
think headsets realize they could allow dual-mode topology and instead
just restrict the number of stream just as HFP and A2DP cannot be used
simultaneously.

>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
