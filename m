Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C28C192483
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632364; cv=none; b=eY5KukrPzsyX2HAZkKlBNUtwL4XbaysRAHf6/OYTmuK8sWnDWuveBKhXPdMYjStvfALigNRZL+pfwGrpyrUJgG6OeNGJ5Li9/hwCeiwKhoe0VAYtmGbvjgvE/Yh42oUS5o0D+gHUhwfAJuneu3GJjVtx8w947NWcGAnp7ZWAslk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632364; c=relaxed/simple;
	bh=tRLsnPKjkOW6GkRpum3iecH3Bc5KX4uL5452rkWw4aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFuNrHVaRrx6uH0leudipvcpMLtHK6SJ80hXdetHI8XjXO1BkUMs5zYumhhLrhrr2bCM+l8WH1z63KWvK7n0V+iimECSaR8iSZVWg2KCGVOTU6Ds7Q6D2VX+UnF/Je1RmGVD5poFjzGNN2Z4s5CidlQZmOHOxPgIrL85FUdy3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iefekaJU; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iefekaJU"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ee90f56e31so62571631fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 10:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720632361; x=1721237161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbDj7PZNlqxCfIzypqlD+yAGuQUBl/tKcZIHeqiu2s0=;
        b=iefekaJUTMKuNNKGxyW+IAuxnrVbirfgkwYImDQ/75+Yvrpdl+q2YnH4toPdW8qXip
         Ui64eQ2y6uPeh9rjNXROU5B9rscK6U/lCCN7SYln9TOQ9sQXx7HKMxfeIvZgv1MXqKjj
         OtHF/odZwNqUx1GehZUoDk5WKrNopDSAKk9QvPQHi1ShBhaxPqfQtPIAgWCeAl9U3wTQ
         w6MDkWEzMOb0PfvqqC6yUGuymR6V2GdnHXAZAx7/C3HwEiHPEvISkMZUfJMMSx/R8dco
         Ga2t+BuM67isTu1qsP0u2SJWh9HZV1jsKRNAdFPUK7XkMSmHWqsUXO41f/eIR+dwiPNI
         ossg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720632361; x=1721237161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbDj7PZNlqxCfIzypqlD+yAGuQUBl/tKcZIHeqiu2s0=;
        b=cRGKVmWGBjwN3G/tBcGymXaTzod6wypHtrisu5bT2EI/9FkBT7eLVLglO1iDisMm4l
         kDvgIRMcoGz1UacvUapKcSOd4LZqYavtWOSyhPTtKfRQZMkSIHmiguZsroGf3MBnlB2V
         nv3GXdo1pF3yRf8N4ZWEuxjm/SEtFmhvyKkvpSbAYbNPIyq4iV6UECkOJRfoKzrbMXGH
         UVU7P8Xwpqc3mTW+CBGEeJ6sLcfPtn/TgYolYqP+e0mSE3hx8qNvxOqqW5AYJwVCXuVG
         1pYoa/AJMGi6y1eNn8q8IWR54AUWJyaVsBpoCh/D3ufEAWRqLfKI+chP+1KSIuU/1SIO
         pOwg==
X-Gm-Message-State: AOJu0YwojBpwy2lbs3i8sntEU0LEfKC5zO/0BB2RxSlVqBCIkwPlmQDh
	pCctpGWpGP5K0CgUIh5oNYCvnmhJSnoSjAMV4ILsytZsKX1sUiQiyTPD404PpEB3mAFp107tVIe
	jvhY2jAyyn+cK1+co5wvPAZKFfBBkkg==
X-Google-Smtp-Source: AGHT+IGoW6rUu8y4u4YcWBw4AQq3IljW8FXDx24bSjcfCGzR4ANaDIKaurFIOd6AA3TpBpTHusp8kzq9zlLzER9urV8=
X-Received: by 2002:a05:651c:198b:b0:2ec:681b:5b50 with SMTP id
 38308e7fff4ca-2eeb30b4cd4mr50163021fa.11.1720632360332; Wed, 10 Jul 2024
 10:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710081338.17262-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20240710081338.17262-1-vlad.pruteanu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Jul 2024 13:25:47 -0400
Message-ID: <CABBYNZJOcRO3SNawYE4D+gXeh-h2pHuj+JwRVQN_JLrGhx53zA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Add transport.select method
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad,

On Wed, Jul 10, 2024 at 4:13=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.co=
m> wrote:
>
> This series adds a new "select" method that can be called by
> the user on the broadcast sink side, to select the stream for
> which synchronization is desired. This is achieved by changing
> the states flow so that transport are not set to pending automatically
> anymore. Instead, the transport must first be selected by the user,
> which will update it's state from idle to pending. Any pending
> transport will be acquired by PipeWire.

Hmm, perhaps it would have been better that PipeWire don't auto
pick-up transport on pending state if there are broadcasters, or we
could perhaps perhaps use a different state e.g. "broadcasting", since
pending doesn't really apply for broadcasters as far as streaming is
concerned.

> Furthermore, this method will be used for setting the broadcast code
> of a stream on the sink side. If the encryption flag is set, the
> transport.select call in bluetoothctl will prompt the user to enter
> the code

The roles of bluetoothctl is mostly to demonstrate how client can
implement the handling of D-Bus APIs, so we have to be careful not to
assume it will be used to replace things like Pipewire/audio settings,
so for instance the broadcast code shall be provided by the same
entity attempting to do Transport.Acquire otherwise things may get a
little too convoluted if we need different entities to set transport
up before it is ready to be acquired.

> Vlad Pruteanu (3):
>   transport: Add "select" method
>   client/player: Expose transport "select" method to the user
>   transport: Broadcast sink: wait for user to select transport
>
>  client/player.c            | 52 ++++++++++++++++++++++++++++++++++++++
>  profiles/audio/transport.c | 29 ++++++++++++++++++---
>  2 files changed, 77 insertions(+), 4 deletions(-)
>
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
