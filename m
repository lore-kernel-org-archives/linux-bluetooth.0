Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F85D1A4F0A
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511499; cv=none; b=IyV0NC2a062djR/OJuRDNjNxO9WbHlWefrMURZEUc/A18tKTurdvdxAktk8Gq14/Yr/GAvszr1H+idNSBVM/Hikh/yaV9TOtxkCBPlWCW92K+RgRebgP1hdawParXmNYAbp0r6ToCveg1ABRAcn6XOzZqVGGorysx09P87mywns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511499; c=relaxed/simple;
	bh=366/v48mK+yr0DlcGqCYTlcDhIwGz1I9krrjknlnuIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+Yb1di0i2Vl0Azop30LQGq4lkCcI5eoEwfSok9TqkV90SrQP2eczyH/CWSxIoUHc/kYfh7audLYK6elORRnDHWY6VV8S9mF58euRoPFLP4FMWniBNSqpbrW8ks4ji1/38uZMC9hwkUZxIUMPTuobcATUS7YuayMPKm6QUdSZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXwHA/1s; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXwHA/1s"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso1407682e87.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745511496; x=1746116296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vb89I3y2C6PM2IA/EBUjcJGKT6XNDQapbRSplE8yo6c=;
        b=hXwHA/1sLtqwJELg87FjvJCSi3R9JK3IJUq2nzt+66Fp6zZ8zSv0nFWS3tSWGwLxyE
         lNOvyoKoAGnQPaZ1OQausmW89b53lHW5e9fEgR0nNOLNuRKdPxmL0gAent9Yunrr4fUs
         XY30iJsd3ofH4mJgIsrzi/bS3LBXCAsp+DM+e3cKuQn1stha7nUfyo8OWIlkpOqOwSrf
         5JhIiAlV1W/BjD2KuvDEKggSXgudgsyBhOaQ2oXnFpZHfYYua+EugR9OLRJKYfVxqLeg
         +vtB+4webLbGhZ4o5BbWqnlpd8RVC5cLd3+LX3OJw90YGkq/nDF/lNtQXiSPvx6D/88f
         ewow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745511496; x=1746116296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vb89I3y2C6PM2IA/EBUjcJGKT6XNDQapbRSplE8yo6c=;
        b=d/UfsqHz+xmorrAeIXsoFQq/l58YP7vvxEHi6gudegC/wZa2EOn52A0x2jCctacGGa
         tCWCC61FRaLL0lSlxAcCwoeugrqQI62mPPh+lJijMhYKg1Tfyqs1pDej7CAPqmK2/anL
         IW0B4FB5x81hnuvShjd2Ay48pe89oQOzrN9f9pkED+0u77BvX/BAjaAkKN9GvLMVtImA
         RIChLkN7GXJW1eRsdG/LOszUm1i3n1JdtpfwndauD/zoB3xBrqSm1NZvoxZ6vMUNK63F
         nrAHSS2tJEioxUOb64yct8uX9NGZEZMfje0WZDHRQ2Aw8Ae1ae0Wv2W2Va22qzw4A13u
         jsoA==
X-Gm-Message-State: AOJu0YxpdJ9stHPmv9pIUAVxid4lDiWrLMhAMAHQtkATKD3AkQEiiuZd
	d8iMxBo4PLpG8VW2YCwoDZ0meLvyFFoYoYWIJnpuz/sHSPmunJjJPzohi2IGRn5c4K5eM+qKlMM
	t4g489xuYClxqG70Mesb0hFqscJ1l18tn
X-Gm-Gg: ASbGnct66KR9wpQ76B8Vd2iL75jgCXYNNsxF5WghbHDpVrwWcXJGuquXnqKuTMZJs9w
	Cs0d4TvUJnOHvpZdk8TwRs7osFCeSIsVByAfmNwNF+EiKtlspVuDdzfWsdw4TcQF6KAHQLDRn+R
	qodmBfGlpYxv44Ij/kao2g
X-Google-Smtp-Source: AGHT+IED3ED1+hkkceC0zQndauR5hLVV/ttRz8tgs5faGAMkE85glzxaPbw36QIKNTM12HvH/Jc1tu/wFydjXYnOld0=
X-Received: by 2002:a05:6512:3f08:b0:549:912a:d051 with SMTP id
 2adb3069b0e04-54e7c360638mr1177485e87.0.1745511495335; Thu, 24 Apr 2025
 09:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424160236.179982-1-ludovico.denittis@collabora.com>
In-Reply-To: <20250424160236.179982-1-ludovico.denittis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 24 Apr 2025 12:18:01 -0400
X-Gm-Features: ATxdqUHrpeTg3EXYf0JEXPdS0pyC6K5rURKoyXEgdyVwzXkAzWdVM3qz-3PPcHU
Message-ID: <CABBYNZKFmW8a3MggGHp23d5SYotGQKDZBzn4Q2EB-xUToAUhDQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 0/6] Support Sixaxis gamepad with classic bonded only
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ludovico,

On Thu, Apr 24, 2025 at 12:03=E2=80=AFPM Ludovico de Nittis
<ludovico.denittis@collabora.com> wrote:
>
> This series adds a new "CablePairing" property to allow us to
> indentify devices that have been paired using a custom USB cable
> cable method and that don't support the canonical bonding with
> encryption. With that information, we can dynamically enforce
> encryption to drastically reduce the attack surface, compared to just
> disabling the "ClassicBondedOnly" property.
>
> The "CablePairing" property is exposed via D-Bus to allow
> clients to potentually show this information to end users.
>
> As far as I can tell, starting the listening input server with
> BT_IO_SEC_LOW and then bumping it in `hidp_add_connection()` should not
> have any negative effect regarding the overall security. However,
> please let me know if it turns out not being the case.
>
> Addresses https://github.com/bluez/bluez/issues/1165
>
> Changes in v2:
>  - Start the listening input server with BT_IO_SEC_LOW only if we
>    actually have a known sixaxis device
>
> Changes in v3:
>   - Change the property from being sixaxis specific to a generic
>     "CablePairing"
>   - Remove the manual validation of Sixaxis HID report descriptor
>     because we already replace it with a pre-dermined SDP record
>     in `sixaxis.c`
>
> Changes in v4:
>   - Instead of setting the server security level in adapter.c, we
>     do it when registering the input devices, during probing
>
> Ludovico de Nittis (6):
>   src: Add new CablePairing property
>   client: Print CablePairing property
>   sixaxis: Set CablePairing when pairing a Sixaxis with USB
>   adapter: Add btd_adapter_has_cable_pairing_devices()
>   input: Automatically use sec level low when using a cable paired
>     device
>   sixaxis: Set security level when adding a sixaxis device
>
>  client/main.c            |  1 +
>  doc/org.bluez.Device.rst |  7 +++++
>  plugins/sixaxis.c        |  8 ++++-
>  profiles/input/device.c  | 20 +++++++++++--
>  profiles/input/manager.c |  3 +-
>  profiles/input/server.c  | 63 ++++++++++++++++++++++++++++++++++++++--
>  profiles/input/server.h  |  3 +-
>  src/adapter.c            | 17 +++++++++++
>  src/adapter.h            |  1 +
>  src/device.c             | 40 +++++++++++++++++++++++++
>  src/device.h             |  2 ++
>  11 files changed, 157 insertions(+), 8 deletions(-)
>
> --
> 2.49.0
>

Looks like CI has found something not quite right still:

https://github.com/bluez/bluez/pull/1191#issuecomment-2828175923

--=20
Luiz Augusto von Dentz
