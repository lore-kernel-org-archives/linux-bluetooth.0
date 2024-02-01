Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7762159
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802386; cv=none; b=iAL6GOdkGc+c+Verj2/Zplwy2WdR7tQVEBtOmAyFCUz74JR9JWFSf2u90NswbNIlrn3OdloM3U0Cy5GKG3oG4sPsxdcP08yuv9Y0nJSnGwRmChkXGN4vfNi4Smk9jbF2AqTKhIwliukMrofuqdblhi6rd9iP4zCO5gwd2nzMDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802386; c=relaxed/simple;
	bh=qO84xf0TAnzBPeZnOdovQFxAhlvEhkH9b9OtYABuFAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xf9QAkCZKJnZZcn8TnklhUg9EEdLzzU3AbEuTlHLoiy5IXWI17Rd97yoyexKJFHFX9i3F4F38YwY9TMwzli1X69LqEgvm8kHY/8/+C8ym1b1rsjHb5bEnHzA84tkOhh9kd/SocKDEhMZpZzGh9fTy7qnJfIduAY+Icml3UOJaPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixjzN/J7; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixjzN/J7"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf1288097aso14682051fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 07:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706802383; x=1707407183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJVlBzJscMcA2voHMWrDxawYWbtejRaZS3mMueBEAW8=;
        b=ixjzN/J7sOnmSX9PeZl1U17HsGeuDgns+4CduKG4BBZouJC9vcV2sqdhrTz6qyhAGn
         +lmgUSXbjM6a5WPxugw+j4dR6JOlmbow6eeapKaaxSGtxoXKCO7ZeZR+qFEp/avNG3ff
         el3c8+poxFTrte15j/gnkHKrODzTSgL6GNsHsv96dbOKzZpoCYGqxoA5LwpJjruyCJrI
         d2AOUTOQCZ1J+KXuZ1m9b/3LnJx90UuxiUxnutnOKoRhjBkueECQi67dhY+j0MEfdbJ8
         bWuwcQ+L1difAYzER1zW7x2KraOTgZeXXRrCbYLJYIlpIH62V+EpW2dr1Uuq8QSUrr2n
         Z+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802383; x=1707407183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJVlBzJscMcA2voHMWrDxawYWbtejRaZS3mMueBEAW8=;
        b=wV8ls+uW4kEUg8eBdhmC+LNui8urgC/VwforQawrXj64Zcwnl3TqHkpcAkRjuV08Te
         Bvs8uP5Z6X9OXCTrxrt0MXZifTXK6ZSiTnkDO5jGYQ44JDWncWGN4G6ydavUbFhU8c24
         CZhqo5PrBSZ81/LFbtqLSZo2sva1jlnuag5Bo+Jeq5ayG2GytvfW2sqtmFB5OoA0htXF
         uvadmnhK24u4nMkvoWAp8O/DlsKFTrFOVTh3/a/avPMAxXZOMJG7pEkYRTTaJTCkNL/W
         9cBg9vx5YyoeE66sJ3alg78g5RkvMH+McHdA8o2t2boU1Pp4Hu9BdeBDCL+QQgYcRskg
         v+Hw==
X-Gm-Message-State: AOJu0Yy0CYxglIE90kUUlNHpJ6owlJh8TqTOpEtEOD8bIfrAejliYwmY
	rKgjMgswB5iaUOvL6fjsIx0K9kK6CE89+wV3o5STb4SLAOMc0WeAQVmuQQbGi1FREfBGRPbqprl
	YbIkOfrH9G/On0rZoD2SSiF8cmEE=
X-Google-Smtp-Source: AGHT+IHfm9mY7zZd3hoPPVPTS5A6Xtd5WSAPnJev2T4N1n2AuKDvZaAoXMtWseDKEVOQi2rKEhzee6XfDwUvBKelrTM=
X-Received: by 2002:a2e:a26f:0:b0:2cf:1174:44a with SMTP id
 k15-20020a2ea26f000000b002cf1174044amr3565314ljm.13.1706802382477; Thu, 01
 Feb 2024 07:46:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 1 Feb 2024 10:46:09 -0500
Message-ID: <CABBYNZ+HidHsCYBPrhedgsPOZ+=bHGzP==JyWELcaieLqYVT2w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/7] Add support for multiple BISes on the bcast source
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Thu, Feb 1, 2024 at 10:28=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> This patch adds support for multiple BISes in broadcast sources.
>
> Example commands:
> Create a local endpoint and an endpoint for BIS1:
> endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
> [/local/endpoint/ep0] Auto Accept (yes/no): y
> [/local/endpoint/ep0] Max Transports (auto/value): a
> [/local/endpoint/ep0] Locations: 0x03
> [/local/endpoint/ep0] Supported Context (value): 0
>
> Configure BIS1, create BIS1 transport and endpoint for BIS2:
> endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
> [/local/endpoint/ep0] BIG (auto/value): 0x01
> [/local/endpoint/ep0] Enter channel location (value/no): 0x01
> [/local/endpoint/ep0] Enter Metadata (value/no): n
>
> Configure BIS2, create BIS2 transport and endpoint for BIS3:
> endpoint.config /org/bluez/hci0/pac_bcast1 /local/endpoint/ep0 48_4_1
> [/local/endpoint/ep0] BIG (auto/value): 0x01
> [/local/endpoint/ep0] Enter channel location (value/no): 0x02
> [/local/endpoint/ep0] Enter Metadata (value/no): n
>
> For multiple BISes acquire must be called on all transports
> before the BIG is created:
> transport.acquire /org/bluez/hci0/pac_bcast0/fd0
> transport.acquire /org/bluez/hci0/pac_bcast1/fd1
> .....
> transport.release /org/bluez/hci0/pac_bcast0/fd0
> transport.release /org/bluez/hci0/pac_bcast1/fd1
>
> Silviu Florian Barbulescu (7):
>   bap: Remove set lpac user data at bcast ep register
>   shared/bap: Add support to create multiple streams for the same pac
>   bap: Create a new endpoint to be available for the next BIS
>     configuration
>   bap: Split bap_state and bap_connecting in two functions
>   shared/bap: Check the state of all the streams with the same BIG ID
>   bap: Set the generated BASE on all setups from the same BIG
>   shared/bap: Generate single BIS BASE for a configuration with BIG ID
>     0xFF
>
>  profiles/audio/bap.c | 239 ++++++++++++++++++++++++++++++++-----------
>  src/shared/bap.c     |  67 ++++++++++--
>  src/shared/bap.h     |   2 +
>  3 files changed, 238 insertions(+), 70 deletions(-)
>
>
> base-commit: a692cc44dc8735b9303f8893f784306b4d2654fe
> --
> 2.39.2

Not sure how you guys are testing these changes but currently I can't
get Broadcast Sink to work, and it crashes on the the cleanup:

https://gist.github.com/Vudentz/00a62914b0dc08261065cea65c0e04f0

So until we fix that I'm actually not merging new code on top, I'm
also considering moving the driver out of bap plugin and perhaps have
it as a standalone bcaa plugin since there have been quite a few
occasions where broadcast code has caused regressions on unicast.

Anyway Ive been working on the following fixes and I do appreciate
some feedback:

https://patchwork.kernel.org/project/bluetooth/patch/20240131173002.834951-=
1-luiz.dentz@gmail.com/
https://patchwork.kernel.org/project/bluetooth/list/?series=3D822175

--=20
Luiz Augusto von Dentz
