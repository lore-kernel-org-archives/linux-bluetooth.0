Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3A1B86D6
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721400148; cv=none; b=rrWBaSTR4WrKCL274am9nueEFuesaYYCzkjNs/3WPEec/sDfO8m1z+2JjeT3U1OCdcV4AusISHDDL66ADzfXNBA5dAJENMYUFWwO+TkD2390j/+XMilsydoU07gCShWujBhFi6plcAfzNBcGTeuBco+P1mxSg7PzczsH7CcAgTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721400148; c=relaxed/simple;
	bh=1zSEte2JEN0sD/lfuKoMoMf91C6fnZxIicaHG8ckPyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMEIwzXLuj5EngtO7gpjmWjjpiheXf98ejwm1WGyLuEd1oEpnva9t+ESMff490oUwSNFEmWEKmhOAP2xAk9gKZaauYzb5M4eln5VZI8YjshxeHVmnZ3lRTgQ4KICewjordwJGB/HW0kVODYQaU00FCYuP124IRXFdkN/pQgo2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gF+vHZEu; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gF+vHZEu"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so27146781fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721400145; x=1722004945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxk4Df8VcebnQFOkv6SpE3riubbFeoP6ojdarRz2wKU=;
        b=gF+vHZEuA2Pu4S4VC2YJpdZNT2fmO+DyA87K5Uqi9qdZDEhLg2JpMSa34TQZfAifj3
         BznsLMc1kVxfiNRP+b0S67rDoD6S/TGgEUxEnt2eN9e2sdjCvv4/vcP2A1l92qS5SA2v
         FB2b8abENiaQNLYzCx2L/nF4fvzlq08TIUTBblqkouiBKEkREchu8DYYFfPDqDhUHdSt
         X/4ivBGl1CdoCzOgiies0RHyxlgV+VRhnRM8rnvYu+McetQXc9z/+VmKlm+E1MDqzPNx
         oP9NwtI0PnKFcXTthScB7J/mH2/bG0CJf91OOGLphBSfm4xSWqhbpd8cq6SC3EOCrPdp
         u19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721400145; x=1722004945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxk4Df8VcebnQFOkv6SpE3riubbFeoP6ojdarRz2wKU=;
        b=Ct4+z2WTN9GAMESeZ4vj4SI+U9yRN1Vw4OqoEmng0vjCDBOk6xMiX+QLK6IZQrUSwp
         jNrJVgqqXu+d1hsQ+Yp2nJSvi0RYiPuWHsQGEX2jW0OAgBf7S1DFVOQX8ik0jhpQbn61
         V8wcUoIGDfLam27BPAQbYgaPV8xhBq5OgwXiWs7EiV5qTawnj81TUopocpqXwjjj/yip
         gGODy/Hg35N61iMP/zRALwy33Va+vElffSlwhNgqj6GUXVS7mlPOwiROwlsqa9LIwnDZ
         bXrbIRZE7pbkHhGdy8C1fwFJzJCa1vWdRbZJ8vb+GOBnXzP5rs/Ns4Isgi/1X8rOwZrR
         +cFw==
X-Gm-Message-State: AOJu0Yw7Q9v+2p+jf8B6wdMvu/sZmzS0Srf4cReQLDxV8URjef1eVoW8
	gPYVPzQZmhxFsZuTeAKYKMVMCaKxjIXNE/iGSbLLDjy1ipmJZsRkkYCde7QG5yCoX+Ytt5dGi/7
	yeje8hROhfd30ODvYDhe8U6afl8Q=
X-Google-Smtp-Source: AGHT+IHSIDXumG2ooJqXixyaXfnQZoNuqpTJfVh+coJUgvLzjyNQ5J5Hk1QEhJU6mERWWfTeTIRcNHuCh6OEgkIzgMc=
X-Received: by 2002:a2e:9b8e:0:b0:2ee:87d4:6a58 with SMTP id
 38308e7fff4ca-2ef05d4d3a8mr35016761fa.43.1721400144486; Fri, 19 Jul 2024
 07:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710081338.17262-1-vlad.pruteanu@nxp.com> <CABBYNZJOcRO3SNawYE4D+gXeh-h2pHuj+JwRVQN_JLrGhx53zA@mail.gmail.com>
 <GV1PR04MB90880C90597E584743AB4FBDFEAD2@GV1PR04MB9088.eurprd04.prod.outlook.com>
In-Reply-To: <GV1PR04MB90880C90597E584743AB4FBDFEAD2@GV1PR04MB9088.eurprd04.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 19 Jul 2024 10:42:09 -0400
Message-ID: <CABBYNZKJN1MQMW5b8GCov3kg_EOCFEnO5i5dxPGcjdKBr2+s6A@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH BlueZ 0/3] Add transport.select method
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	Mihai-Octavian Urzica <mihai-octavian.urzica@nxp.com>, Iulia Tanasescu <iulia.tanasescu@nxp.com>, 
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad,

On Fri, Jul 19, 2024 at 3:34=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.co=
m> wrote:
>
> Hello Luiz,
>
> > Hi Vlad,
> >
> > On Wed, Jul 10, 2024 at 4:13=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nx=
p.com>
> > wrote:
> > >
> > > This series adds a new "select" method that can be called by
> > > the user on the broadcast sink side, to select the stream for
> > > which synchronization is desired. This is achieved by changing
> > > the states flow so that transport are not set to pending automaticall=
y
> > > anymore. Instead, the transport must first be selected by the user,
> > > which will update it's state from idle to pending. Any pending
> > > transport will be acquired by PipeWire.
> >
> > Hmm, perhaps it would have been better that PipeWire don't auto
> > pick-up transport on pending state if there are broadcasters, or we
> > could perhaps perhaps use a different state e.g. "broadcasting", since
> > pending doesn't really apply for broadcasters as far as streaming is
> > concerned.
> >
> What I propose with this patch is to slightly change how the PENDING
> state is triggered on the Broadcast Sink side.
>
> Currently:
> A Sink scans a Source and automatically moves the associated transport
> to PENDING. PipeWire sees this and acquires.
>
> My implementation:
> A Sink scans a Source,  the associated transport remains in IDLE. User
> does transport.select, moving it to PENDING. PipeWire sees this and
> acquires.
>
> So I wouldn't be changing how the PENDING state is used, just how the
> transport gets there. In any case, I think that everything is in line wit=
h
> the comment for this state:
> TRANSPORT_STATE_PENDING,        /* Playing but not acquired */
>
> Nonetheless, if you think that the use of this state in the Broadcast con=
text
> can cause confusion I will add a comment clarifying it's meaning. Perhaps=
 it
> could be placed in the select_transport function.

Got it, while this could work I think having a dedicated state for
broadcasters is better since we can document exactly the behavior
since these transports are not attached to any endpoint it need to
manually be acquired by the user rather than automatically like
unicast.

> > > Furthermore, this method will be used for setting the broadcast code
> > > of a stream on the sink side. If the encryption flag is set, the
> > > transport.select call in bluetoothctl will prompt the user to enter
> > > the code
> >
> > The roles of bluetoothctl is mostly to demonstrate how client can
> > implement the handling of D-Bus APIs, so we have to be careful not to
> > assume it will be used to replace things like Pipewire/audio settings,
> > so for instance the broadcast code shall be provided by the same
> > entity attempting to do Transport.Acquire otherwise things may get a
> > little too convoluted if we need different entities to set transport
> > up before it is ready to be acquired.
> >
> > > Vlad Pruteanu (3):
> > >   transport: Add "select" method
> > >   client/player: Expose transport "select" method to the user
> > >   transport: Broadcast sink: wait for user to select transport
> > >
> > >  client/player.c            | 52 ++++++++++++++++++++++++++++++++++++=
++
> > >  profiles/audio/transport.c | 29 ++++++++++++++++++---
> > >  2 files changed, 77 insertions(+), 4 deletions(-)
> > >
> > > --
> > > 2.40.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
