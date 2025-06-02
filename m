Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D984438B
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Jun 2025 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748888346; cv=none; b=VD9r/EiF9qFCD1+d5mpU2Rz6mWaibtRR0kaqIRfxiw+ipK735NVn56xeCs+OUtoxsNv2FQs0Xhkm09PMl/jjWW/t+UJ3iU3JAE4UIa7dzxyUQHOZjLsN5qYsNklALOlxeZvATGAFJa09i2MZkNjD56LrTcI97PDeGs1adPAEqs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748888346; c=relaxed/simple;
	bh=pn7RP1QhqBpgDOCaIlU5AwipYyIkWde6TV+/dGIZwn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0mh3+tpD80EJWTlvJ9osr2ekFoZZ6OXJVOishY1fQubrIm2Nss8e3H4ZBq5Eyg/gav/nucfdoPY/J54QxsuZwRPANyIN4kgjhHMoVdcgdmy74JMr1FMZN67pSEdD1gAzhUdFaXTZm5PV4UftlJeUn9XJHjbHzofbes87aqGFh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iv3wXNKF; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv3wXNKF"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-310447fe59aso48109681fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Jun 2025 11:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748888342; x=1749493142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rP5mmEkS00SkHFd1IKWfiLcROcj6jbjd83uqCKq6yUA=;
        b=Iv3wXNKF6GHFn7dYZSdDRbXhw9A0msq9PGDSNKa4xJY+ikdzHgHKBplHUuVNuhkozM
         /QRAUdLF6xMtS5TaZ0cushLMcwst2XjEYLjQc1wXHuU0v048zr4IHXpyVHgzFp5VcM+9
         vjzDM8yV/h+JXfmjdFdARit1ZZifl54ZU76Z9yWds4qcrBxBJI3Ft5J8/P1yu+An1cec
         G53gQ1QXikhSDiIuo3XfUL/vYXvO5wk9S+VIbBUZq04jYwQOXJhOO/1f3daspignU5bv
         OxRqtXCB6PT3jZwFMa5SKfLu9gAhQUJkq6YE1MPfZFtNuVqouCocHmpJPYCCKxSJ5Z7v
         mcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748888342; x=1749493142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rP5mmEkS00SkHFd1IKWfiLcROcj6jbjd83uqCKq6yUA=;
        b=g5RyNRCgwi+pCddPlAnE5mN/UpBvQcrtespfgh+3oDW/arqpvlM/Xt8AF1Qj/t6cUU
         u9zdiw6LIqeVa03yl31juamctnC5VQynMBMNPuWhjo70UuXz304eDUuX8za99dLyLWsu
         XMEOtgZqXejaUcXFGgFA7wPTRHwhg3ZLjf9gSaugbUDElYi/RIFSOTIhHtz03pgwcZ2c
         2+ooZ+JCC4Wf5t6XqwrfR0EEl7EXBEzalUtmHkN3EmbKetzTygebSQvt4vCSrgaBX2EO
         2ZY2oGeLmnu9OgiqJiD5yxsmk2I8s5ZysKpEXDfYbubL1Ewu1yAhFwYfvjOqoCumtsij
         Q9Gg==
X-Gm-Message-State: AOJu0YxYhiOc0vbC5w6y83kWgbp0nktDFw2Y3xleqUHw9w72Q6F1pceV
	soc8wTjLaPsM8LVXHGhTX6XLqURY9GFWEynQWu6KeKhMiU7J2eRRo8bKXnJfCEX9/DPSi/Rl7Xo
	Y8v2nwrH88Vem7YimtTB3UpfxcqInYZg=
X-Gm-Gg: ASbGncsc/73HB4z4GEsaIQhyDfsxoaO62nl0XsfP4rfejUpGN1C8iV9rKnqQYKOzgmS
	3ifq3JVkA/g0yk5544sMk0/ydW9u9RqDetQSs0Y+vzCsRVOJHOdzxyfKKbitNFiRPMkMYbz9/h7
	66463VmORrKhZkn0BnPOCXNaPkiAsbWAssNBNjmBA+Xw==
X-Google-Smtp-Source: AGHT+IHBE4UNjsfrTx2QneiA2XgJux2UkHpGkMh9PWruUjb5zAAgiYB2SjJ6XgFLaE8K8hsHw1mNV/6h4Ip4WNvwyd0=
X-Received: by 2002:a05:651c:994:b0:32a:8c29:9311 with SMTP id
 38308e7fff4ca-32a9ea669e5mr30168461fa.32.1748888342260; Mon, 02 Jun 2025
 11:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a15e6919-9000-4628-baec-a2d2cc327903@aerusso.net>
 <aCiLTy-IuqV6V7WA@eldamar.lan> <aCncrfc7qbtLEpta@andrews-2024-laptop.sayers>
 <aDq72xTNkz0kDqpW@eldamar.lan> <aDtHoRCof-iND3Td@quark2.heme.sigxcpu.org> <30a9641a-05fa-4a44-af58-6b155dc7ecfc@aerusso.net>
In-Reply-To: <30a9641a-05fa-4a44-af58-6b155dc7ecfc@aerusso.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Jun 2025 14:18:49 -0400
X-Gm-Features: AX0GCFuXi0JMy7BHIFNTZ1lukjWE4LW3yNkCNX9CaccCundk4cHnJf8HwYCtHDE
Message-ID: <CABBYNZLQ+HkEm0koVtwJGgxaOTxiy=UTOtc2Do1n0q3CRXEm7w@mail.gmail.com>
Subject: Re: Do not start mpris-proxy for root user
To: Antonio Russo <aerusso@aerusso.net>
Cc: linux-bluetooth@vger.kernel.org, 
	Andrew Sayers <kernel.org@pileofstuff.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Salvatore Bonaccorso <carnil@debian.org>, 
	=?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonio,

On Sun, Jun 1, 2025 at 9:24=E2=80=AFPM Antonio Russo <aerusso@aerusso.net> =
wrote:
>
> On 2025-05-31 12:17, Guido G=C3=BCnther wrote:
> >
> > Sounds good to me. The system users include users running the login
> > managers which can have more components on e.g. mobile (for emergency
> > calls, etc) but I don't think they'd need the mpris-proxy.
> >
> >> wonder how we can best move forward here, to have it then as well
> >> resolved downstream.
> >
> > I *think* the patch needs a respin by Antonio and once applied we could
> > cherry-pick to Debian?
>
> Here's an updated version of the patch with the @system condition.
>
> I do not know how to properly acknowledge Andrew Sayers, so please add
> whatever trailer is appropriate for that.
>
>  From eabbcf86ddfff98bf15b32e65c8d385d3e85f14c Mon Sep 17 00:00:00 2001
> From: Antonio Enrico Russo <aerusso@aerusso.net>
> Date: Sun, 1 Jun 2025 18:10:49 -0600
> Subject: [PATCH] Do not start mpris-proxy for system users
>
> A default installation of bluez results in the systemd user unit
> mpris-proxy.service being started for all users---including root.
> This unnecessarily exposes system users to any security
> vulnerabilities in mpris-proxy.
>
> Inhibit this default behavior by using ConditionUser=3D!@system.
>
> Signed-off-by: Antonio Enrico Russo <aerusso@aerusso.net>
> ---
>   tools/mpris-proxy.service.in | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tools/mpris-proxy.service.in b/tools/mpris-proxy.service.in
> index c49d255..6ae56c6 100644
> --- a/tools/mpris-proxy.service.in
> +++ b/tools/mpris-proxy.service.in
> @@ -4,6 +4,7 @@ Documentation=3Dman:mpris-proxy(1)
>
>   Wants=3Ddbus.socket
>   After=3Ddbus.socket dbus.service
> +ConditionUser=3D!@system
>
>   [Service]
>   Type=3Dsimple
> --
> 2.49.0

Can you send a proper patch with git format-patch + git send-email?
Embedding it on another email don't seem to cut it for git am:

Applying: Do not start mpris-proxy for root user
error: corrupt patch at line 16
Patch failed at 0001 Do not start mpris-proxy for root user

>


--=20
Luiz Augusto von Dentz
