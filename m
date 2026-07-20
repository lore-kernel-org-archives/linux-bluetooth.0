Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150B1A4F3C
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577063; cv=pass; b=g4C2d838dSNwkY4VnOId1Q2QylaDZiu5+nZx8CLZ/LqvJZ1t0TGVnpi4BGapYYzmmk+aS+6GSpXBdPNZXpZsMXuqezCYULC0AR1Eho3eW1g222t+E8KiWV1GaTmb3O818i3SbAfmQb9Xbs5Hu1O7wDBlGS6/AqQLkarqPju2Dj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577063; c=relaxed/simple;
	bh=UYoZiXxlCm28NmZTpNom6yePxTBjqMNld0bnfj8xKy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzUPe/l534/HbeVjlkUtBlwtfs7j6UxRjwsGaHFMeP6LepcBVEVRaykp6DjQVjJbwwm/jq/epRa/OnUOCrHe1Jxuk1gtqeDMRB5kvShDf8pQhbjjrQUXz1B1vz6kydDauWLYpk082YzQWRtv8wGKV84Igl5/N2QFMar2WCBoFR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Egj40FE7; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Egj40FE7"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80dc4a68e4aso82258387b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784577061; cv=none;
        d=google.com; s=arc-20260327;
        b=WXOm7JmCob4dcDhnjvtKDJUsvL+iAWin2w9dz/0kBlW2z8ClYsG4iHyiNrsjnGo8os
         itaHnMxsGX2q41yL6wnA63ojYBc53sn782ycP7aU6k356eve5IUVuhenpehH5bV47gYl
         6k58KU1yiomPGkrR0800YMW4j8v5vWtn6R+7NeNJjaeUMpC9XqXfBzAstgNM7TsL2N1G
         HXLiDCVcADYaZWIBi1AWUuwoSCXMAiUiqkkCcx1RE+iCh8WWIAITSHZW1AWabiQMZ+GL
         lj5QfbCO13EutcC8MtvZPrHFZkEbmUu6H7mOKc7MIc0vs6uVdbPNw1/EHWy6ztkSoKq/
         nJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=avchIl4utkIFhuYbPy9jncQVkYIDzPUJKgzWuXig1TQ=;
        fh=CMJB0LeKg4Y3F57S3YmGVZ9DYThgs66xTrq0yHgJMpM=;
        b=L4Jg17JFPrB2Ccdu+/Nxt/Nwg/EiXmRphsOLtlMVVhFxSJ+hhC3F3VkgqJfKeQblG7
         kKB6ain36vMGuEP08RPyB5Cc2WhSmyFTyAgo1wCZWpLKQeY52aDiyKUlhyyVUR+Cj5zX
         5RSbd4mmmM9rzsCQkldxxivLpIMrrYemYwtmp9r05PvcrNjIVLb/PLmEPFjXS0Aiv1hS
         0h/rh1rbdo1wsJlLuapZx5O6O5R7AreaX53n6jGz7gLPdef2nKe95E4hi5/hTeGlAAtY
         CQHG5OH/HaDdWWeuFyorsUwws1qoZZ7XPsfe/HSwNKiYsRyqRSIcA+Ydn24UvErBbZFv
         6OYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784577061; x=1785181861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=avchIl4utkIFhuYbPy9jncQVkYIDzPUJKgzWuXig1TQ=;
        b=Egj40FE7tA9CCTrNvRHCXTBcOYFiJt3T1wwm3Mo7AuUi2BMQgj0ZUkHxInfRkhmSNk
         aClKIb9bLQ4C8I1jt+SXqVcKwzJpqIxrNryuYf171svXvQ6rnn4UyqlpKFCgt9eFTlwW
         gLMPAsSarDo6SGOAh9SssWOVT4qYxNMWTuyJ1c0oo+1pJUBpvO58lcJrdIzHb4gzndhX
         pWyS2Zi2tP0csI3ekgBISK3DOibeQdXG/StDCgyELIG4PlAzxmwORYveE25Ms+I5PfgH
         MDwGXOsquIPzy8EkYL3tWuEdtbQpwaypJFRUMmCtoWcbvnIZqxEEgLUDonvVfWIDHCDj
         luag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784577061; x=1785181861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=avchIl4utkIFhuYbPy9jncQVkYIDzPUJKgzWuXig1TQ=;
        b=JgU95Q7b24c8c24HygxS3PnBe/urx2gOeacmOmzKPE/GEku6fniV3xkcX+ytp1m9ZC
         UP3OMBoBgOKHGBLs/PJ1roBRtsyiCWFTAoVuGV8YZC9E/xFcGmhOFPuOs577WdDxWlsv
         TwvD+QEodBF03kzIr6rHOeob6h5g41gVoOnZGg+f3dQVdpw3ep6a6g9P1D7GYm9Rqyn1
         c/Y/5Ngdp8qdNuRcMLQJRZ8JShCzgFBLNVGBqiO5TrhNnjPi1TFz/Mh3lnvl1hPxkR3n
         x9uAoIWRmjmmXz5UiPWcVwIkyZytMiKkdVPvagMowLdNW29ckCDoTqDweG+8madNUyaw
         sYyw==
X-Forwarded-Encrypted: i=1; AHgh+Rp52vkYn3iz6GusKZ2+e351q+Gidif93yudIzG2ENDVPlzt2IcDSTTopxFM6UFwXa6FlwUW6dCsraJTexjPtnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqNok0YWWyPwUwwVF9CaSqCxnPoz3sahuSm2FkpFcJIaezevT
	8b5fIeVlc8oeZ4+bQZpwQBe98Qtq7TGhUH4y8iZo3DXq/O4meVweMXKs/QgI1aaIfzxGm6SCZg4
	XQYZaAPNnTToojMmwoLxxSfX8aaORV7JwdKTAjh/t+A==
X-Gm-Gg: AR+sD12nThrcACXJ0rdKuP80wYzfRpeLHk3cAQve0vah/DhkzLRsgXjOdZk75ze+eg4
	Dft3MHR/yZY4R5eq+bG5Jc3QcSurgdHlzGvMt7feIKNU6K9mslQWY7PBYN2Fq1Z1mM3PQzV6ViC
	PUgDCIArgv7mhyD1jHVDMap0FqiR/yCDG/vccEI2DdcbtRPXh7xgrBnDqaCLYi+YS612oMaH2Dd
	V3dsNMeVwhr1F6sAN4Cjp/UoDDEgh/JdXqatxpZd4gh/4ADn88NS5eUAkKa9QXb3LOl6C0K3k+S
	B7+6ued7Y9vTOg+E8zDxshi5BDwB22qvx2pJlTBaktxY9bbL
X-Received: by 2002:a05:690c:9b01:b0:80f:d844:779c with SMTP id
 00721157ae682-81ef252ea01mr49543287b3.22.1784577060631; Mon, 20 Jul 2026
 12:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720150919.9602-1-iva@yenya.net>
In-Reply-To: <20260720150919.9602-1-iva@yenya.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Jul 2026 15:50:49 -0400
X-Gm-Features: AUfX_mxd7_jcTju6I7rjcF2jC-TLzW2SUrO7G7ded9j_sFtGvXkAdbrP9jELsUg
Message-ID: <CABBYNZLJALsURmOgwnyEaLqj76nxVqdaGpEFAc2qzqGUNant6Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix BT dependency for submodules
To: =?UTF-8?Q?Iva_Kasprzakov=C3=A1?= <iva@yenya.net>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, xrabek1@fi.muni.cz, 
	xkasprz@fi.muni.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iva,

On Mon, Jul 20, 2026 at 11:09=E2=80=AFAM Iva Kasprzakov=C3=A1 <iva@yenya.ne=
t> wrote:
>
> Rfcomm (BT_RFCOMM), bnep (BT_BNEP), and hidp (BT_HIDP) modules are
> dependent on the bluetooth module (BT, tristate) only transitively
> through the boolean BT_BREDR. Therefore, the modules can be selected as
> built-in even if the BT=3Dm. The combination of BT=3Dm and =3Dy for the s=
aid
> modules leads to the kernel build system silently ignoring those
> modules, without ever compiling them as built-in or as loadable modules.
>
> Add BT as a direct dependency to Kconfig of rfcomm, bnep and hidp. The
> modules set to =3Dy when BT=3Dm will default to =3Dm, rather then getting
> silently ignored by the build system.
>
> Signed-off-by: Iva Kasprzakov=C3=A1 <iva@yenya.net>
> ---
>  net/bluetooth/bnep/Kconfig   | 2 +-
>  net/bluetooth/hidp/Kconfig   | 2 +-
>  net/bluetooth/rfcomm/Kconfig | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/bnep/Kconfig b/net/bluetooth/bnep/Kconfig
> index aac02b5b0d17..f8087e2d2c00 100644
> --- a/net/bluetooth/bnep/Kconfig
> +++ b/net/bluetooth/bnep/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config BT_BNEP
>         tristate "BNEP protocol support"
> -       depends on BT_BREDR
> +       depends on BT && BT_BREDR
>         select CRC32
>         help
>           BNEP (Bluetooth Network Encapsulation Protocol) is Ethernet
> diff --git a/net/bluetooth/hidp/Kconfig b/net/bluetooth/hidp/Kconfig
> index e08aae35351a..ba52c7296f18 100644
> --- a/net/bluetooth/hidp/Kconfig
> +++ b/net/bluetooth/hidp/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config BT_HIDP
>         tristate "HIDP protocol support"
> -       depends on BT_BREDR && HID
> +       depends on BT && BT_BREDR && HID
>         help
>           HIDP (Human Interface Device Protocol) is a transport layer
>           for HID reports.  HIDP is required for the Bluetooth Human
> diff --git a/net/bluetooth/rfcomm/Kconfig b/net/bluetooth/rfcomm/Kconfig
> index 9b9953ebf4c0..e7af2d565cea 100644
> --- a/net/bluetooth/rfcomm/Kconfig
> +++ b/net/bluetooth/rfcomm/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config BT_RFCOMM
>         tristate "RFCOMM protocol support"
> -       depends on BT_BREDR
> +       depends on BT && BT_BREDR
>         help
>           RFCOMM provides connection oriented stream transport.  RFCOMM
>           support is required for Dialup Networking, OBEX and other Bluet=
ooth
>
> base-commit: c1cec2bbbeb5922d42d28c6af1707c4f3f8647e3
> --
> 2.55.0

Looks like BT_6LOWPAN could also use the same logic:

https://sashiko.dev/#/patchset/20260720150919.9602-1-iva%40yenya.net

--=20
Luiz Augusto von Dentz
