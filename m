Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D607CF08
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194786; cv=none; b=s2rdZ63R8cadLklJcfj4YEcorUWioPWvCdQZaAm8AYhAzc/hI5m9QOEazp+WkTGKJ4WzmwMBioC0xfXhab3Z49oS9DHBuazXOhE3UBbSmSuOLKmsYVetiCmc6/nCw2nyzP/SqlX+a7LhW0bnXcs6ID+s4dUjBTfyIWb/VSHiIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194786; c=relaxed/simple;
	bh=fQMsFbffobH7sY0ujWHwa3BRDcHYqDJHFGh9j0+9Vzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZCf8GM9lCKGdb018YnR2wSvWDeKO616zlfM7GVSXjWakai6HliaB02sDimdQG6ZdkobSnqhF6Hx38a4GLZ3awKE4OWarjPoaQpzd4tgC0ivp2Apju6Gfni623AJDXAmi1fSBGxK/Iugz7KW8BP0s9CFUObWsodv0cssTlDgS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUHYKMWe; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUHYKMWe"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cdeb954640so84446461fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 06:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706194783; x=1706799583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okA/VMwmkUEdsJA0QdoRfqToMESDFSQVgY6ovwH0aSQ=;
        b=WUHYKMWe07r+hARtsx0KM7GsekP/yAjowJkWh9fISyhKeOeYB+0DjcQEHV9jwNZLCq
         reu6hAqgTQIpZebJ2Mt9ysQEvhpugZ4su8SdcQoK8jCFYjyDPcFV9p+l3oxfo5OBXWsy
         s6DpgEQrBph+9aATD6BvNJK4TJ1JqTgKe1AvpRLS4cew4pu3cZZhL9950cvTiYZ08s95
         hnmzKP7PAghvujWEDhYJ5ub0+A92o4OCSWQydJhv4hoC/muaWAFy0CeUpN+jMJF+JoNx
         c/3ONJ7iKc2QRAjQpXz2JK5rpqsTxZ9B5q+I0tU8XVY3IhbBjFJrkA3LP2BMvcrt97HN
         oBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194783; x=1706799583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okA/VMwmkUEdsJA0QdoRfqToMESDFSQVgY6ovwH0aSQ=;
        b=ZQR9q7x+5OOprPdjfE3j1Qa9rlJ6iLhU6lTrxziNj0Mj6solgEVuIxM1kPV2MmzrRw
         XI5BCu8OnT31a3yIQ5YDYswG+7u3k/H1UYpoaqeEEZiTS5OF6J7+yD0i1+rGqew2a94l
         3iJNDnNmee63Iw0dDbs4RgyKw3T73OBrKmbR2Toepkprae5Y4JPl4HhkNI41H98WHmUs
         lowBSV8Yi4Vlfl2G7tdwg7Tl8oKzUeekda0OvNM3wNr4zBA4UCH87mifVd1y4gFlGW8F
         EXVfynYpLlW8kzGLf6r9eAALpHhUb6jvhF7QC9r36KQcFdVuV/ODz3HiQIb9dhiEtpA5
         435A==
X-Gm-Message-State: AOJu0YxPWoJkonk8MN9MJPtCwzcrt2Hif1bxTmGhHfqn/v81snAADOtw
	/1fQ4c3VYTEIXGjO+CIGG8bWsmujweLnixScap1KUTC6FHtqArhIPat/Hf4nf28vt1Id9XVosFY
	708HBZf1NzQm+Wxm6NSM55wpBMAHxWIwtmJ8=
X-Google-Smtp-Source: AGHT+IGMIOW1hyarfOOLjiuKxWO2uxezkL9/1VwU5QZ8I5ovRRWy6VXX6HEfBS6QO/znk4u5PIiR1zyRX/CBd5o0Q4g=
X-Received: by 2002:a2e:9442:0:b0:2cc:eb95:684d with SMTP id
 o2-20020a2e9442000000b002cceb95684dmr662833ljh.76.1706194782755; Thu, 25 Jan
 2024 06:59:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-disto-patches-v1-0-97e0eb5625a3@gmail.com>
 <20240124-disto-patches-v1-1-97e0eb5625a3@gmail.com> <CABBYNZLibBw-_SJ4wpzF-r5cDPSds99kShO9C3v2FVNJ2Um9vg@mail.gmail.com>
 <CACvgo51BHdhdzhPifJjuz66Dc2vJ1QEvCrkxQwQnC8dNWC8nZA@mail.gmail.com>
In-Reply-To: <CACvgo51BHdhdzhPifJjuz66Dc2vJ1QEvCrkxQwQnC8dNWC8nZA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 25 Jan 2024 09:59:30 -0500
Message-ID: <CABBYNZKmRsr=i4zQcqw8ofs-yrb488FVm8pu5XcpZerudcBGag@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/9] Enable alternate Bluetooth connection modes
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Vicki Pfau <vi@endrift.com>, 
	Rachel Blackman <rachel.blackman@synapse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Thu, Jan 25, 2024 at 8:39=E2=80=AFAM Emil Velikov <emil.l.velikov@gmail.=
com> wrote:
>
> Hi Luiz,
>
> On Thu, 25 Jan 2024 at 03:54, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Emil,
> >
>
> >
> > I'm sort of surprised by this, we do only use the PHYs listed as
> > supported by the controller, so is there a bug or is this really a way
> > to disable PHYs that the controllers report as supported but in
> > reality don't really work properly? In case of the latter I think we
> > would be better off having a quirk added in the kernel so it can be
> > marked to the controllers we know misbehaves rather than limiting all
> > controllers to 1M PHY by default.
> >
>
> Using pristine bluez, bluetoothctl/mgmt/phy lists (omitting the slot phys=
):
>
> Supported phys:     LE1MTX LE1MRX LE2MTX LE2MRX LECODEDTX LECODEDRX
> Configurable phys:                LE2MTX LE2MRX LECODEDTX LECODEDRX
> Selected phys:      LE1MTX LE1MRX
>
> With this patch + the LE/SupportedPHY config set to "LE1MTX LE1MRX
> LE2MTX LE2MRX LECODEDTX LECODEDRX", as per the original patch we get.
> Note: I've intentionally dropped the override for submission, happy to
> bring it back if you prefer.
>
> Supported phys:     LE1MTX LE1MRX LE2MTX LE2MRX LECODEDTX LECODEDRX
> Configurable phys:                LE2MTX LE2MRX LECODEDTX LECODEDRX
> Selected phys:      LE1MTX LE1MRX LE2MTX LE2MRX LECODEDTX LECODEDRX
>
> Note: I've intentionally dropped the override for upstreaming, happy
> to bring it back if you prefer.
>
> So from what I can tell, the controller reports that all (as far as
> we're concerned) PHYs are supported. Yet the selected and configurable
> PHYs are mutually exclusive, which doesn't quite compute here.
> Mind you, my bluetooth knowledge is a bit limited - I'm just going by the=
 code.
>
> What would you say is the best way to move forward with this? It
> doesn't seem like a kernel quirk is needed IMHO.
> Generally, if you feel that a different name and/or semantics for the
> toggle would help, I'm all ears.

Hmm, are you sure you are not missing something like:

commit 288c90224eec55d13e786844b7954ef060752089
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Dec 19 13:37:02 2022 -0800

    Bluetooth: Enable all supported LE PHY by default

    This enables 2M and Coded PHY by default if they are marked as supporte=
d
    in the LE features bits.

    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Later one we had to introduce HCI_QUIRK_BROKEN_LE_CODED because of it,
but so far that was the only drawback.

> Thanks in advance,
> Emil



--=20
Luiz Augusto von Dentz
