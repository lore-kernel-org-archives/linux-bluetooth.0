Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA22E3A28B
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783589; cv=none; b=hW3vd96VgDSB4gUQAuSlTG1AQWkf5SF6ToAvNgXOZ95DuePoYBeoZ7bDhBtnp7WIFSM3sDLVBh6ey7Y0tcERq9Tm0eewWTsNXQSSjfnXKU98n2jtch5zLHRc0oxP5L+O9lmmu8LcXaYt2Twxpzeq7EcgwlpQYmwx0oRIiu6EScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783589; c=relaxed/simple;
	bh=y2xPd2nMhvLYSrYx185F+5i7fohGFA9Lq95pkCs5DoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsgiYXG5U3sGiEPuj0ja/X/ls5/p2+Hn9l8KBmaYkS2cLJot15bR8qMZ69tbRzmrE2fBArhJNAnt3lChK1vOL0ZAht+FlsmT7ps7qOooBo7ZcWd/egwkwO4Q3e9UmZyrTc42QU8jiInoGIfszAU83//MxfkpuvjpnQGrfHzHUYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecsaNrzm; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecsaNrzm"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d4698f4936so66801701fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 10:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710783586; x=1711388386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFZjjgQzI29l/IqqJLzPwr9dWnW/IhPY07sU09MUe2Q=;
        b=ecsaNrzmOh/UdyQuWyRG85m7NpCDrkRBQrh8T3xudHrr5QZ3bcqKFN7RVRIdFYqk2b
         avH7MfxaE62fKBuwTlfZ0yVSQUzQD1I07IH/VkwUlX/OhB2aEKDZoqSAh1ecgGTkbtH4
         vwgA5chC1TYLtHmSKSYTg4sBlddfCH2qR6R+X47Lbwmzp47lEBx7QQ8f7w3SOV528C0j
         pPhl6f0ki+HXNUVIMnMQPP6eweDhUmsa+9ILQqGVqE5kPZFGeF3jp79FeMxken9rsr8+
         DbpM3f66dghZ1UwY0kJ/hNIbx2z4kMPDjX7vAXZI2OKcQsfDlH1JTFFElVvrsJ+ms7yK
         zRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710783586; x=1711388386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFZjjgQzI29l/IqqJLzPwr9dWnW/IhPY07sU09MUe2Q=;
        b=wIvwifmSgJ+O+qC3M8pIKmfXjZ1hkmJiW3A8F0QyV8a8XkViBLRABiQP45kOxksiOJ
         zZHV+cU/jFkF2n1wRW+bWG3wZg73AT9c096WqWEJ9zlk30UttYJqI+kQj3mdkExRIxhY
         yJSWNGSTBBII6emXsJhGMpeTenqGBIIxX9PAR+BitKcDo3HxMO+pqFog/4TXD8Q9S8mu
         UxCwqHWXfobtsEKQdeLlCrRq0n+OmcW/+ekcup40KJU6AjCXbigalOYuoGW5WYxQwrL1
         VALM4BDirGS+wwiET9IINt7m/p3HPQR+vHyoNsMPLYGePB77eTctcfHjvA8j3/sNuu+t
         RF9w==
X-Gm-Message-State: AOJu0YycUGKfj3QFUSvjOlefree1b2f14H5lzSu+nHTki07TxY9K9l7q
	0zE6ceJl5lPVLCUdqScrdDkoSatzM3zj4iuKTt78TtKOB9T2lOkcOvHovzZ0oG9q3YDlcjZnKGD
	nPX3Q98lNq+HeZEGPyOru6jbbYYLAjOH/fQNPeA==
X-Google-Smtp-Source: AGHT+IGlWUFevFy1RD2X88O93ikWS6riK1Hq9uXXeBkmu3O98g/WW2qk473cvsYkzegh8/eIv6vmjEIAFgzIh7ocnTk=
X-Received: by 2002:a2e:874d:0:b0:2d2:af88:8947 with SMTP id
 q13-20020a2e874d000000b002d2af888947mr8746187ljj.15.1710783585652; Mon, 18
 Mar 2024 10:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318163853.68598-1-silviu.barbulescu@nxp.com> <20240318163853.68598-6-silviu.barbulescu@nxp.com>
In-Reply-To: <20240318163853.68598-6-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Mar 2024 17:39:33 +0000
Message-ID: <CABBYNZJPM6_ieZOi2gTg4M-v5-pRA+rNeW+_CZZEwWv+j=2S_A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 5/5] client: update bcast source script to
 support BIS reconfig
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Mon, Mar 18, 2024 at 4:39=E2=80=AFPM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> update broadcast source script to support the BIS reconfiguration

Please add the resulting output to the patch description.

> ---
>  client/scripts/broadcast-source.bt | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/client/scripts/broadcast-source.bt b/client/scripts/broadcas=
t-source.bt
> index 6da9e23e2..4fb0c3920 100644
> --- a/client/scripts/broadcast-source.bt
> +++ b/client/scripts/broadcast-source.bt
> @@ -5,7 +5,15 @@ a
>  3
>  4
>  endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
> +0
> +1
>  1
> -3
>  0x03 0x02 0x04 0x00
> -transport.acquire /org/bluez/hci0/pac_bcast0/fd0
> \ No newline at end of file
> +transport.acquire /org/bluez/hci0/pac_bcast0/fd0
> +transport.release /org/bluez/hci0/pac_bcast0/fd0
> +endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
> +1
> +1
> +2
> +0x03 0x02 0x04 0x01
> +transport.acquire /org/bluez/hci0/pac_bcast0/fd0
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
