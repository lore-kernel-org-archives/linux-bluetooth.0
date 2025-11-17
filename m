Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0441EEA55
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390638; cv=none; b=capKbyUEv5ob8oo9oMkLIKrn3GUCGzX4wvSQqDC79By7i4l+YQWjjRV7c/xqu3rb/4Q/nRtB05h5Wsig42uDmfprKTY5VzgG2QOxIkr9h5oJuHhG6wpduQ0QXvNWCBVGcxZN6tXxwJAR3vrLO3DKZr9mYBAuwv6SSKpX+hxwJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390638; c=relaxed/simple;
	bh=H0hd1TO1y8Xlr6Z/1SeV53ZM1WKoTl2PTSZialG4/Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsyFOA9VH7vWQeMhZfe7QMQRW907Y59N5UZw5D4E6EImAFox9/pNQJx6eERZv1/EnQq7AdOt8BFHk2pvtJqF12NFNe/81DEHeEplrFjVYDzbbwalTA/VV9fOpX8lLbYjNp84rrJ3MGn+yKMXUty8y2zT9uBWPfWKyfV0o8NCP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnbBpRgM; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnbBpRgM"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37a33f49018so36539041fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 06:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763390635; x=1763995435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0hd1TO1y8Xlr6Z/1SeV53ZM1WKoTl2PTSZialG4/Vs=;
        b=DnbBpRgMs13Sya824HcaDZkxN4hzW5AP04TpiNpF0EZ8YeO2Di9lRGTO6gQSSTM1Q3
         KgTdN12neG3fAEpLMvJR5j3uJ2LEASqCqETChK/EYrsYIIvjma7LUS8rHUBXQlwbnnUs
         2D1oNzKFYGSx+Hj98ABzmveCPEaOR1a4BV8ykzTyrsrFz0pVpE4usYrJqsS5fi2YBNVA
         qpbqmkaSfmgx4vXKv8Y2MC5+zOq+lpz8NsZuOJ2b+r9ego85wya8bgyJBIOJs8JOrZt8
         AMi7sBvEQZ1lY7W+T74VzOq0KG12Xw0d18rtjnv8l3h2EAFgF1Mz4gfS0Kj/gf+uxTcf
         fuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763390635; x=1763995435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H0hd1TO1y8Xlr6Z/1SeV53ZM1WKoTl2PTSZialG4/Vs=;
        b=jZhkbq4LCsV8lBp5uSxRZ5zVrJGqUcUgU+8VlMCCnMpO2c9H8CsSh/HwzF7KZD+0IB
         fvC6VZSNKPB0km2dKYVrH+4F63OTpczyOkj/UC5SVLqXe6NdYB5bttAc9TlmqBkCJ981
         QI0+3y3aeDM1nRyc9iTfpQyyEeU/GevkAI9Ps18P6FvMxxtd2JKB/g6whhszEegPgYdZ
         y4Y7c4AUuqi10AkvPXEwU8fsoDFONq8FxlDFs09HXat4Dlxot63Cp5fIdC61ABg04jQF
         OwUBQiRNo4tc7dZb19/ZuIPDxbvm43xoqmjcrZqUWjH4hefXxhQZpUID35mNe497NPYS
         akkA==
X-Gm-Message-State: AOJu0YzD1QO4m0x44dh5v+HA86EimwlcKT3xwX++zEry5pck8iytsQsq
	vwMBv5oRH9cQQ5fv4Wn6/ZONlmThU8zxs9Odr5yzQ3IUPR3evlhY+6j6zVPMscw/Oyvonr+2q1q
	UnYYG62m+Wf//K3y891f3Jo+OttR8aLQ6+jfuQ+A=
X-Gm-Gg: ASbGncu8NH8lc4HjchIiB6euje+TVRvBkvT+URuyai1j40QB19DhN6rQ4crBTL0JHeB
	evKmEbdeGdhDYW3LUoDNCoDWwXTaeM1pOoIY9Te71CXPg6kPicF6SIHXMkwscZPODyHAOR9FaQT
	Mg6u5Zz6R+O0fvQFYxkB9tBTV63a5jtEOXCjiif8eyaZxTO23lEYnTUtih4HcpNjQm3xRdJonWe
	4iS9w+k3vnzB5c3d2Nw/AklyP4umEbXlZv44YKFoMWIrav2NBmi6zMYylU=
X-Google-Smtp-Source: AGHT+IFZhO6eOFyYtv7ETutGgnLGalxVPwqwVy0s+LQReiqUlN6sU8tInNrXdcBWkp2PRLC3DSpGrPcBIPB9kNeQwXQ=
X-Received: by 2002:a05:651c:3253:b0:37b:b731:3c92 with SMTP id
 38308e7fff4ca-37bb73147e1mr19619121fa.5.1763390634637; Mon, 17 Nov 2025
 06:43:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO8FxWrNEAw_X_TT=T82639H0o+HfRCj9O_0WZjAZUPYrMYS3g@mail.gmail.com>
In-Reply-To: <CAO8FxWrNEAw_X_TT=T82639H0o+HfRCj9O_0WZjAZUPYrMYS3g@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Nov 2025 09:43:42 -0500
X-Gm-Features: AWmQ_bm24a1F3WreTRlHLGAC7tJ1fDeRco0cobjmItA-zcB5KqN_PDoRzSm-_qc
Message-ID: <CABBYNZLpcN9FrmqqfQRuYEd2wLEztMS9o29mgtBiOgjY6x2mtQ@mail.gmail.com>
Subject: Re: Subject: [Bluetooth] Request for status on stable implementation
 of LC3 + Auracast for hearing aid support
To: fortune elkins <frelkins@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 17, 2025 at 6:39=E2=80=AFAM fortune elkins <frelkins@gmail.com>=
 wrote:
>
> Hello BlueZ and Bluetooth kernel maintainers,
>
> I am writing to report an issue encountered while trying to enable the
> LC3 audio protocol or Auracast support on my TuxedoOS 4 laptop for use
> with ReSound Vivia Bluetooth LE hearing aids.
>
> Linux distro: TuxedoOS 4
> Pipewire version: 1.4.9-1tux1
> BlueZ version: 5.82-3~really5.72~tux1
> Kernel version: 6.14.0-115036-tuxedo
> Device: Tuxedo Infinity Book Pro 14 (Gen 8)
>
> I have paired my hearing aids successfully but they are recognized
> only as an "other device."
>
> btmgmt commands:
> sudo btmgmt le on
> btmgmt ssp on
> btmgmt isoback on
>
> While the first two commands succeed, the third one (isoback on) fails wi=
th:
>
> Invalid command in menu mgmt: isoback

Where did you get this command from? Or it was supposed to be:

btmgmt iso on

Anyway, that doesn't exist either, what you are probably after is a
way to enable the ISO sockets which can be done with the following
changes to main.conf:

@@ -124,7 +124,7 @@

 # Enables D-Bus experimental interfaces
 # Possible values: true or false
-#Experimental =3D false
+Experimental =3D true

 # Enables D-Bus testing interfaces
 # Possible values: true or false
@@ -141,7 +141,7 @@
 # a6695ace-ee7f-4fb9-881a-5fac66c629af (BlueZ Experimental Offload Codecs)
 # 6fbaf188-05e0-496a-9885-d6ddfdb4e03e (BlueZ Experimental ISO socket)
 # Defaults to false.
-#KernelExperimental =3D false
+KernelExperimental =3D 6fbaf188-05e0-496a-9885-d6ddfdb4e03e

Or you can follow the pipewire wiki if you are planning to use pipewire:

https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/LE-Audio-+-LC3-sup=
port

> I have explored the btmgmt menus and found no alternative command
> related to isoback or Isochronous Broadcast backchannel. My
> understanding is that this command is necessary to fully enable
> streaming to Auracast-compatible devices such as Bluetooth-enabled
> hearing aids.
>
> Is there a known workaround or timeline for these features until the
> experimental LC3 audio protocol kernel is complete and stable?
>
> Thank you very much for your continued work on Linux Bluetooth
> support. I look forward to any advice or pointers.
>
> Kind regards.
>
> --
> Let's experiment & learn together.
> Book your time: https://zcal.co/fortunebuchholtz
>


--=20
Luiz Augusto von Dentz
