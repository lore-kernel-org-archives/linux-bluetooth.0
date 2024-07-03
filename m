Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2017E46A
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019193; cv=none; b=F6B+VqLtl1kWedSs+aFlY5KorbjQDlYPpGznjtQfdnAYe5SX6tEulwxXchMrqSf+Kd1SNGlTyJhPiuzc2JoODXfUc4gELqk9Z13rY7cA/NOnYB5empxL0eRBG4DcFxMgkQFweLqVDKCAYLOzEYNJsv9SoJkmjw9eUpzCsjeIemM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019193; c=relaxed/simple;
	bh=yyweQCSh24CDgbkKMPskoIfs9NoH/e8H9GQzVTdg7J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehTOUp2uHE8UQM1EXl7XOzcLuuH1gMJemOc8QZm4nHkezf+FnM81Fi9QtsHfqYw1JwL5n8r1iSoh0AuXOP9cg5aGmjGzmex6QcUyrKarHj3b/I7l1c1ydXUx2ahRpAyiz55Q23kFaf1ZFTABz/mRiW9vmudBp17696a2eOpZgH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBP7JREa; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBP7JREa"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so62727331fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 08:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720019189; x=1720623989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2Cv3jC2w6mkoU0XBvBsZKzyGfc6dr9C87H/ZVxFi0c=;
        b=RBP7JREapp0HoN7xhHbqK/JZoO3N/9hHXMndhH/MmE1fc41pPGMt4huZtXK/PGUGnc
         H6ICq6GALVad08QX50+zc3OxLJpxqf1QaTyE1XeXAvg0un7UvpInWhCO9jA09aUMIUE6
         oisnKSTDzLRb///xY30HmFfzd8pDfTbuNTh/YrT4LVHpCK0PQMrK8mF3ZCK1psUa0MhT
         PpZ0/s5ICjZEDsCbyj71Hy3JUceJGwQiLxg+JEyfSYqnXhNVptw0dikS8KqHaMx/o6J2
         a5T9qNGPdOmUk7op1jaCQt69pBExsLo904HeMzLKPU26ikc+TBVI675UjuuI85Wa++VG
         FIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019189; x=1720623989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2Cv3jC2w6mkoU0XBvBsZKzyGfc6dr9C87H/ZVxFi0c=;
        b=gWQF3tDcTZckq5emLphD5C3qoOpH0q0xldM88tr3cx2lzwfujZcGoOQMT61Bv6k87+
         4LXskvh69+1MisymMhPWKYHhHDnFehYSzc73jlpjnwJbE29hsqBrqshLzjMRzKhEB518
         d4rADapL6aIAQyzO41HGOjc9E67ok8ggzleWUQZRjXYTeEyp+AN0Ah9Rn3rXdW3or3A1
         lo6PcuKnpXy2h1i3BSoKrYifNJmgKu7z5LwZgZ427q8gU3lz4y/UMQwEbYTNlJMEL1x+
         xPYevsB2Kq9Q4RHTRXVuq3nYbGkfwbSjx5Gs7oYRfckkVsoQ4W5mgOZQyQADT0AwKSDW
         hIgA==
X-Gm-Message-State: AOJu0Yx/UCS4nd2JSEHiamPiNWq8P6eHXzNfLQt7OYf3UQ5DDJlcnOvt
	HVHCDDrUdka6Xf6BFXCwOU8k23vnq54sCcyjwQAjahrZlYE10T+AtZ+nRvvNZh579ksvWZLCO6a
	e08lSRH5yjtr7NMjF2qBqZDWvnaP/Xn0T
X-Google-Smtp-Source: AGHT+IFmEMRztvKbhp+bbEke6oCG8SXbcqdTU6M3Xmln1501EbtYAw3Mz3PCGsgduLtx8dNsuuKHZGcMKLqlZ3fdD7M=
X-Received: by 2002:a2e:b7c9:0:b0:2ec:56b9:259b with SMTP id
 38308e7fff4ca-2ee5e6bd1demr64259251fa.49.1720019188392; Wed, 03 Jul 2024
 08:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703123745.56443-1-r.smirnov@omp.ru> <20240703123745.56443-2-r.smirnov@omp.ru>
In-Reply-To: <20240703123745.56443-2-r.smirnov@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jul 2024 11:06:16 -0400
Message-ID: <CABBYNZ+FTK=+R75RSY8Po5R0w_3S-AKuThximnQJvzWn8043oQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 1/3] shared/vcp: prevent dereferencing of NULL pointers
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman,

On Wed, Jul 3, 2024 at 8:39=E2=80=AFAM Roman Smirnov <r.smirnov@omp.ru> wro=
te:
>
> It is necessary to check that malloc() was able to allocate memory.
>
> Found with the SVACE static analysis tool.
> ---
>  src/shared/vcp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/src/shared/vcp.c b/src/shared/vcp.c
> index b7e17e448..2ffdb22a0 100644
> --- a/src/shared/vcp.c
> +++ b/src/shared/vcp.c
> @@ -2128,14 +2128,15 @@ static void read_vocs_audio_descriptor(struct bt_=
vcp *vcp, bool success,
>         }
>
>         vocs_ao_dec_r =3D malloc(length+1);
> -       memset(vocs_ao_dec_r, 0, length+1);
> -       memcpy(vocs_ao_dec_r, value, length);
>
>         if (!vocs_ao_dec_r) {
>                 DBG(vcp, "Unable to get VOCS Audio Descriptor");
>                 return;
>         }
>
> +       memset(vocs_ao_dec_r, 0, length+1);
> +       memcpy(vocs_ao_dec_r, value, length);
> +
>         DBG(vcp, "VOCS Audio Descriptor: %s", vocs_ao_dec_r);
>         free(vocs_ao_dec_r);
>         vocs_ao_dec_r =3D NULL;
> @@ -2532,14 +2533,15 @@ static void read_aics_audio_ip_description(struct=
 bt_vcp *vcp, bool success,
>         }
>
>         ip_descrptn =3D malloc(length+1);
> -       memset(ip_descrptn, 0, length+1);
> -       memcpy(ip_descrptn, value, length);
>
>         if (!ip_descrptn) {
>                 DBG(vcp, "Unable to get Audio Input Description");
>                 return;
>         }
>
> +       memset(ip_descrptn, 0, length+1);
> +       memcpy(ip_descrptn, value, length);
> +
>         DBG(vcp, "Audio Input Description: %s", ip_descrptn);
>         free(ip_descrptn);
>         ip_descrptn =3D NULL;
> --
> 2.43.0

We might be better off using util_memdup here since it already
incorporates these checks and aborts if we cannot allocate memory.

>
>


--=20
Luiz Augusto von Dentz
