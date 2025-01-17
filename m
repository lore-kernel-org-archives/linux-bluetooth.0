Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E5185B72
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137867; cv=none; b=AQypqYADzA1n4JWo0f0hTtpYd2vNdaR+MswzbCLo3ik1Dme8Ns3ElIlGqYRbkOCBLNs1eB1s+RmIlJ0C32FuN6n6emUiqpsvqwPGNckPDFyHFkNn6nMVMXEPJT+e5U9iWYWElXOeCCwUYP2NuFYsbQrwKEUCC8o2I29h0HWKS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137867; c=relaxed/simple;
	bh=wuUQdVAxkqgM06hQR4Ocbp22bnPGrvRKHbZMlySP6rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfhDT0asAjW3Lcivr4g+qa8LRH79k/TUhEEeU5CErkvzEFaCrSisIW8V/oFuaFK4dV2eqnZ+DlPKNcwQRKWldSwgRjhEnDKtqW7rsFBbISzzMw/d31UPkGhAPhEaughXUlEoC9uUPmNwswIqiIcRhSUr+j3trT492D46Uc2E44s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTxViroC; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTxViroC"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30229d5b21cso20866641fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 10:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737137864; x=1737742664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ok2dVW/xReeyLXlnBndMEKAK9Ue1lPXDqY+UY3cu+yA=;
        b=PTxViroCdC1ePQZIgTLIDBGJ9QCDAzMBQ2GBtMEW80S6zgRGwDWL6cxqVTUrQsIBuB
         WOvSWrAzytT+xl4RJ3CGoqjMc19+vJCU73TBgba5XM7oxh0mhdWGn7ig9o3BZU/98YNX
         ttiTPzvmtpB2l9++1ZKpL2+ygM0rB80yQB5HrbGLf3ruRTfWfuk4eA3C6qYJl85ktrXX
         gv3JvA+z16R5Vcgr2vKf/SbZF4P+h/PK0g6zwT3blR5NCyNv/iX6WTOGek8JxgmhpdSa
         0sDsSc2J+gynp4KkGwTm/5dE89Z3TJ9ibf0slEPMO8g56woxvkfs4Min4P/RufTat5Cs
         GIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737137864; x=1737742664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ok2dVW/xReeyLXlnBndMEKAK9Ue1lPXDqY+UY3cu+yA=;
        b=dZYoqphbNiBmzWozOT9QKpAsmeKXzAL3CjUgVFCJeERdRZ247+h3+z6LXwaZJYaiqB
         6lFR/8w4Min69Z2rlAH2CGyu5xD6JNmvIXrCZrYIDUidz9dduv7dkzfUObyijXJHLhXV
         G6IUwIpeKBmQRWS9jr5f7JjFrLn4M87zrkbcKrSy9PhhJv9Dl2n305INRYKPU2+RDRzB
         WCQZvM3UNGnofS6/Lz1UEjW/v1HKCfy6VpH5MOS/TxwfVBrseiQW4KGdZ2wvo/8BVkMq
         SM+1KKfnUwbZm8hdUsYJJE9ZyyCUEsw6SntpDum6eJq0SPlMaxY0OiiyxNcvrBV0nQP7
         q3YA==
X-Gm-Message-State: AOJu0YwCnIO8LRTTiCdkT/vgf7jFtPaa+g3OW4x7bqbYfPdTDnLgdn/p
	i42RY6CMfg8m+UjXZYrsrsZSNuJuLV+br4fkUIGmMpgHUxgNTgenFSl52ej1wq+c+5v8n6FzcKv
	OlANcLWcN9XVyZZcaK3+Lzlj8EW58iZG2
X-Gm-Gg: ASbGncv7Q099JZL48XgNGpXqm2FzF/MUz4v7ay2coeuh23hrgs74k+BeYvqG/+5gJr7
	CJNC6Xms53AyyRmV7BDZOQPUppk8b/1V8+3d9exw=
X-Google-Smtp-Source: AGHT+IEJyGLKDJo18xf+HJc87xljpKr93mmGImBM3zTsz7OlECM7VJAFaL4dQDA5Z+lLkxGP3YO8GY9fprIk9RDDjs4=
X-Received: by 2002:a05:651c:896:b0:300:1947:a28c with SMTP id
 38308e7fff4ca-3072cb66472mr17393811fa.26.1737137863565; Fri, 17 Jan 2025
 10:17:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117180611.14869-1-hitechshell@mail.ru>
In-Reply-To: <20250117180611.14869-1-hitechshell@mail.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Jan 2025 13:17:31 -0500
X-Gm-Features: AbW1kvaR8whVpBCShPTcAmxIuY2E5Bnh5po_RL9wNY29MjqqfOeJ6nBcluyK4Dw
Message-ID: <CABBYNZLK4hAmUXp-yZVDXUJ6M8_faDYPN2i6kccdbvc945f0fA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/shell: add proper line clean to bt_shell_printf
To: Denis Burkov <hitechshell@mail.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Jan 17, 2025 at 1:08=E2=80=AFPM Denis Burkov <hitechshell@mail.ru> =
wrote:

We normally expect some description of why this change is required,
for instance what is the output with and without your changes here,
are there artifacts if we don't use rl_clear_visible_line?

> ---
>  src/shared/shell.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index aa6c16c8c..837152525 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -719,6 +719,7 @@ void bt_shell_printf(const char *fmt, ...)
>                 saved_line =3D rl_copy_text(0, rl_end);
>                 if (!data.saved_prompt)
>                         rl_save_prompt();
> +               rl_clear_visible_line();
>                 rl_reset_line_state();
>         }
>
> --
> 2.45.2
>
>


--=20
Luiz Augusto von Dentz
