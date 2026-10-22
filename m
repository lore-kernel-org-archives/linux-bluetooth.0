Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792683887;
	b=INlsWyOobq1nVD20y7Y/pVZo2SJusfWHB+y9cYGXb3WOb5fsWrA8N6VkF3HteX2SGvfY
	 KXyShey8d41bBd5uQmjGnQLcgS6APO1KBH96RrmWXWAPOsRY/cRK4J9b4BCcD+munVX9u
	 6/QGVP1onTpSB2Q/JwTDxEy1oSazomNQXZfAzUtOKKj1GqhgemSNvjuifQmx+UElE6Wj+
	 vffZK1le4VP2boGy33/MULXouSatPx9+2hcU8psdrE61CQrKH3vhRurUKD2hqHCEU0Iw7
	 +0U8x18ZfERx5c7JQpoND3bMD2T2FEperN+hXPVI9xw6Kps7GJbuSW7SFtRWZkQzr0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oRjx+Xop4Z1GUqRTl5dsbzsj1FUXaqmmx816bae1Ae0=;
	b=Ox0KTCRxutioTve28dDVRl5u6o/LJeUC4hV9u70eKfEft+OB6MVoahr+EQ3iC6ry62/g
	 YJ8Boo5kWMmd0G7AH/ig3OfRhmQLr3rhoO8ZAZ3+mcQG5+47ZQCOAOSlTHR+aYRJgahjO
	 ikVfJBxUc1/254Or4vnHHMAbKPzwzbacGMTTkgyUE35IRGHoK86GNhFjD1HS+jnf91AES
	 5mb8ui313WU+7UrFtrNcPgXo6l6iS+fxGGjq5Hb+lVV/N0f6WFTZyfGTbk8mdDVF2a4HH
	 EkImPStZsnSV5Cku829xP5mu3AeoH+2Xy6TbHHUYIt9WvHlfHFmXa9yBSD6vv/JAvVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DwVJrdCN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41EF606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D41EF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DwVJrdCN
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8726acc5eadso18692237b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792683886; cv=none;
        d=google.com; s=arc-20260327;
        b=imDDqPdOCZpnk9DHxN6sz+b3KZ6uZd2JAyPla/m5unRdGqSWKdza4TweZKZzFiL/c/
         lqzuW1xHz7x/rDMKrg5yb56EQweb/1aMd1jbzX6TaQhEznqfR1pRtbtpSXLLNB666+zW
         xBURnmi4DcNisuRL3eeyqkULIQ6NMbAOx+/OT92CnjNMPdTqWDQDDVJ7Ry62/tW//Vdv
         NhtwWOnO63RGm8QRJo5E5Ocz0YGl5I7rLPWNUAw53vzirIHU+O180m0+8rdeDIvIhh+8
         s0EZjI8TCzqrQ/VRlC43shK4AwYPo9QWLiht/BIa2+S6N9/KIeAVS5uvy6aGGYrGz46W
         DOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oRjx+Xop4Z1GUqRTl5dsbzsj1FUXaqmmx816bae1Ae0=;
        fh=LYH828ZrCNm27jRkDNiQiGnRqJe5XlvVdY4nfPp5xY8=;
        b=T8DeWUEq1GWdLT/JYP7QZgKt+8E9zTGEugdXTKw7A2MmZSDCZNPtMPfYf8js+t3mcu
         2QxeJ7CuGfKSrwQYS8GBeBiSc2JXo1rKLuqRWkttzDe2EA6Jl0w3W6w9BshuJLdaW2L7
         EnQpKi4nExKw0MmG8+2mrIP2mmQUH8jhs3tR0leQpIc25e27PUGt1lDZuz2BBa99g87+
         DG24b2FQ5AFqKPge9fEVWAZBEC1IHMMjlh0zJVkkT1IeSfWR7J90GUDBH7vB6gYpIAJ2
         /uOJ8dL6wXYgeBLrXY/eEj6Jp8CiOhIhG6SQjlIdRcipJ3sLzIidwVp7noEhA4NRTsh8
         4q6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792683886; x=1793288686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oRjx+Xop4Z1GUqRTl5dsbzsj1FUXaqmmx816bae1Ae0=;
        b=DwVJrdCNVkNQ5bxC/hIGCwfripGCsW3fUmDxvP/biec1GRcgNcVtBY3FZEbEY9nRUq
         zSUtJHlXL+K1OVAzMXlsPf2qnh0TMknLQm3c4tAh73ms49FSgq5uqORLNTQkKtly38wH
         yf5WsRc0jOwkCMlkWU1CswHavTiFACy7qoKW38QZNXCcCVudKfHm9i/V9a0W7OmoIwWI
         k/TcT7XcI5Wwlq1oSq5q2FQFcqT2A2eMC3WuB/gkKkjMGkwBKOi5pou1szuwISQufQ7B
         Eih9Oq2RL1dSx4P9T8a19PoMKoHOV2/tnAZ3A94Je0mgqyo01bmXXCJttZNsl3jo4IXW
         1IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792683886; x=1793288686;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oRjx+Xop4Z1GUqRTl5dsbzsj1FUXaqmmx816bae1Ae0=;
        b=VFNjyDgdjkuhZIHs1VQ+d1dpy4Zp/ys6hlXwGHMC244S60jPM96pgexrUtALdIfLqD
         E7osgHXq9OuwJfIvjvhGRE7jsk14cKh4ETQlQyvB5xltTdbRT7QxtPnKBOxLH6OyM5xA
         +XC4HxSh3qGGcc77Uom5ZBHE18FiP1cZ7h2udlD2yQ4G2c8pnXv1xq6zllNGy3U62RN3
         5o7Z+ISFa8olKp5OIUBTFI5jskFcho0fZqbh7OEqu0vRsfstodlqo/h0AiZwPidP2J0J
         K87ERPQrNrYLmA0om1Jet749JLr4WkYnuh4hDMYP+SJYu9HESLROtf6u2bjpx/3z1fNY
         SbFw==
X-Forwarded-Encrypted: i=1; AKwUvBzmOpRRQdHY0F2g6QSiANGoldheTDqkjKay9zs+xH23TvSpBRHxeIgpjFPiLf7JJnY5HITJqrYxNwSUZEjhNMY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUXTTZToVcIiiRj1hyemAi1uWGlt4Fyg0y7VZGMffsfv3vYu3Y
	MOIu8Ej+J0Ze3HnyD64zdfCA+KdVd7ZRvp937M9S7UT9wPu8YeH6aEzd8cLOS7fZN12ALMdD0x5
	P/9Sh8JkESrV1EHOSVlhuRZdZVVvdH+RNjNA6lURwrA==
X-Gm-Gg: AYBFou0cs0ItUOwbi6JLEIHM63yAoo5OxTEPSjdc6OJnnMTAdX12GN+42+2w8r1ZHBS
	ig/WjIw33XlLToFDhjzd0r72ye9xGzIwQVpmDwQRGdwf+Y2KBoW1RfvMMTvDLqpBldunycHFtd2
	d4CpdylctidSeUezQatVbA/f+As1X/oYomlA7T+JyTDwwFyHFv+vHHx6ADNPmId2/JrBJQz3Fkr
	IlNYluogl3p8liLVkt8+Y9FTg71GRPngtdIYUtXBA6BDNgHirIPlAOKilQxOmb2jQz+UDU+CQB6
	JKuB+d9iVF32H1fMoEDdRwEa/1GKVy6m/1O7klVUbBelVnbNGpsW/0NVffo4s0vty7fHNuLejS8
	VGCTzjwTrJ6aH4tR8sjNAjvdTj8LAUcWFoo+PqIAV6J+3AEvjKadF45LVY+yn+9RhRKWNNde8qH
	eFVxD7KnhhLDlUFw7K6enOQg8=
X-Received: by 2002:a05:690c:c4e6:b0:8b0:9409:5ff with SMTP id
 00721157ae682-8b133d5cdfamr36933817b3.47.1792683885510; Thu, 22 Oct 2026
 08:44:45 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
In-Reply-To: <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 22 Oct 2026 11:44:33 -0400
X-Gm-Features: AclHuK8pXn8hZFihyywvYqXLQvQqit6uFoz-znUkdBUwI-jQRhQ-0DBJGJyPSlU
Message-ID: <CABBYNZL_EV5LHaXO4rUGu1jg7domF_h1xfmg1m9odHBfgFPA4Q@mail.gmail.com>
Subject: Re: [PATCH net-next] Bluetooth: btusb: disable by default Qualcomm multi-subsystem
To: Paolo Abeni <pabeni@redhat.com>, Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Thu, Oct 22, 2026 at 11:38=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> New knobs should default to 'n'. The mentioned one depends on
> BT_HCIBTUSB, but the latter is enabled on most systems.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> this is a last minute fixlet to avoid breaking expectation for the
> upcoming net-next PR. I'll merge it in a matter of minutes unless
> someone scream very loudly very soon!
> ---
>  drivers/bluetooth/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index db0189ca3cbe..0dca5e43edc5 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -96,13 +96,12 @@ config BT_HCIBTUSB_QCOM
>         select FW_LOADER
>         select GPIOLIB
>         select WANT_DEV_COREDUMP
> -       default y
> +       default n
>         help
>           Enables various required support, such as configuration, firmwa=
re
>           download, and error recovery, for Qualcomm Bluetooth controller=
s.
>
>           Say Y here to compile support for Qualcomm protocol.
> -         If unsure, say Y.
>
>  config BT_HCIBTSDIO
>         tristate "HCI SDIO driver"
> --
> 2.56.0

Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

@Zijun Hu lets us know if you have any problem with it being default
n, perhaps it can be default y for a specific Qualcomm platform but
not in general.

--=20
Luiz Augusto von Dentz
