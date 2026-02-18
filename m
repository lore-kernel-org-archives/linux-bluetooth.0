Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91031355D
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771425985; cv=pass; b=GxYm2R/Q+4xWj3fgrWMko3upHTckznD/eo0WUQjqUyzZ8KIy30jrhQefeHvhSN+UVJOKn5r5g31OMuZYJ11mtr2p9ppJRPaaYqtZCytvKwmvjem0qh7/8Ovtg0Q9oEqiD6BILxqxfDgDqdYTO95mnoj1xLHjisHaG5HKgZYaCmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771425985; c=relaxed/simple;
	bh=hOzG56crz/u5wn1G24cVdNswyiPjsFOqjVteFXEld6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAtQd1aeEwe5M/ROJIXlsAWxHzmbPiCXeFwTqzIC85aTsCnPQDqI2hF99YJTL5GR4qSZtRARji4dsXGp2vp/bFIFM3liPIbIuGYcFoxadua4wUs6BYkLQco1N1PDJfVUe6JLMLIeSQliH6CowfuMGpcM/YuBW7YfmWBlkOS5/zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg2rlMD0; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg2rlMD0"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-797d3864d89so29213637b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 06:46:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771425983; cv=none;
        d=google.com; s=arc-20240605;
        b=Wit6y4HuUqjNM/ZDswUyhZc724uLrKg4nbMERGVjO+uiAkhUAydt1EpGa4TV/uxKzK
         1jS+6sXhatYEnV6m9QUiZyPgbnx4ESwM50FdHvNL1sP8g8s3x6hleNJDgDtbE5dH7rGK
         2idQLIFPlhv36pobmrNU2uv+4/o8odbtdVy4KCEq+twThKZYBnsrg/sKJWmFqcTHDp2y
         za4FZJS+Bm7E/4GB0pWgpNG/0GCiZbo/wzRxJQJLBMzunpUzYrc7iHJ8oouXabnXS+4U
         8lKjMrzZy7aSik2jN6rYyuVudt81jZLKpnVhY/nZTI1DUG+9D21YYisNKI9YL5TaS4XP
         Y3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4oMrR+NuDhSCmR5ZiFZJyebm1VZlYZWrlvW0njg0q1E=;
        fh=CJsSzaW2GQbi6DSNO/9q0Y7QmQJFr8QpiRe2eegoLd4=;
        b=OzzGDcVI+4wgeSLNK1YvHcoWcKlzhOUDrClGV4/SE3ePChe51YJB6i/FbU/rh6R+h1
         TuzM66N5MXvCFSaNfVw0omXPXSL9vnhf0Q1dUYac/UB92tgqo1NkvVrbIgUxvoRmwR0t
         OzWiiHIqzK3V2eS9e8FDPKoOWKPTu5gI+p8MCphTe3tdFdOfG83h1d+wEo7sXfZ3VmKE
         UcQUIBe1s3Tpx01OEoeVaxAQyMpzklRlouUAZEUm1sTdVxFUdTN2pk1NxdBhfCmrGLXQ
         mIo/T6nrZ8nK8zPcENPOsG8dbz/gCmYVJ3KPTL/gFTrwYLVAqXrUmVyCO++E7y+hpnCO
         32AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771425983; x=1772030783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oMrR+NuDhSCmR5ZiFZJyebm1VZlYZWrlvW0njg0q1E=;
        b=eg2rlMD0jL6dC/ry6mbZlBAp36rBQZWSPmjikNgC3GqkirMlrAoFvKtgTg05HnviLm
         F6VYJ768jzBiv/GLUJjboB6WZDSlDIGd+rq8Cqp9kZQtWGwk5N8E9LFRBsB5XojuOPgA
         3yc1oCdLLmkcTuC1ujT0U+SQZd53PivxRMAJbxR8GKjdcMHk3zVS8GVnaYcyRWIo7zAk
         oL1KulTYMopsq+CwRwUyisYDyghVdj/P6ogrTokgSOoMW0gDbHGaMJQ5fwKnH1KrOYic
         TDiKEKwung0oaSvFITFaUVceeKTPagYsvChJ6T/KCeMLcjmdo7+gKczOtlGHdE7Rs/L9
         0AYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771425983; x=1772030783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4oMrR+NuDhSCmR5ZiFZJyebm1VZlYZWrlvW0njg0q1E=;
        b=k9rkD9R6X5Nj/Zk4HQaSIATIlu7p7JALEvXRzgUtABuzxDfIRCuzomnessBqbPvzT5
         dWw6EFulk58fWjS2jhszbpr3yK8ZE2gr+M9qyXlI6pAq4LHQqjRBT/YBIwTbgzCWv31b
         bfYlRSCRx3ey/qdWeQr289yLMNQjwRzF3VAqlztIhHtJ4YlfqpQrRZZJeVHqtxzt+i45
         w3qoYGCIpvbJMjNGIqRSQqUgx5kKFizS8lSEcj/2vyIMvsRDo8q5DzdnDcUtOqW67Z6d
         XxkHlsgWAJISYOpL790yF8nQkRyUshCHwEa4lwWI8Ux/E44as7zUnZNHrHtJzFhvtJ/z
         MJ7g==
X-Forwarded-Encrypted: i=1; AJvYcCVQLeRGLm2c6owTiMNqTXTkigy2zw9VXD1QfwFQn5f4u2e3Te+FQfw7DkKdhcP1okO4h0mewJClAzg9o8uAMB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGIIVS+JAxZwPAMjGDXhm8NRjcDV/Sk8Z9EekhdgNNaxDuv3pH
	UgXEvzkif1sYvEwd7HEbzbYFt8iQWBciWlL8MieZ3M+D4Vof97/3mRLpr0QnWjYWlgIWrb8qpbL
	YJVXNhMV0AKC0BCAnNL50oNwGN1ZIC/DukPcl9cU=
X-Gm-Gg: AZuq6aIpq/nsuxqEA6Ko4PMG4oOPYehHYe4FJouaH1Sm+w55oX2Amx+ywoa6FN66r3d
	x8277ZGX1pji0fysCw9hOpRtFZAoYEyvckjReyaz3w8Ztc8WMS5d1YC3VmwLQW9PLhtnGrRufH+
	wnOT/9jxiyC0VA+A+H7sqo+luIcOIHBwys6C6CFAdy8g8+JXrsaM58cdBD9RQ0Dwu9Hcwf5L7rw
	zYYHe6D1R9jnTU0Xobp4NuXdG4OGJErmIzx1NDgs8e51l/YgROZbHNKIvO2GnYszbHnjibb7uvw
	8qIfCTBP4My6XYWqfupdH+1BkEvVqn1cnsByCN4uMJsaxk9CbKodXLtInJHZ5/ukkvY=
X-Received: by 2002:a05:690e:1518:b0:64a:ec39:dd53 with SMTP id
 956f58d0204a3-64c21a9b6d1mr10356385d50.39.1771425982666; Wed, 18 Feb 2026
 06:46:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217222954.432676-1-larsch@belunktum.dk> <20260218133040.977435-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20260218133040.977435-1-arkadiusz.bokowy@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Feb 2026 09:46:11 -0500
X-Gm-Features: AZwV_QisUnpmLQDI9rs3hp69F7x1RFhcIeqgvN-DMixoHCLdwWZNkdDpaJQZZjo
Message-ID: <CABBYNZ+k=sdzxz-OL5oUMiaWtSDSOxDLnfFmB2cKDB2EyPvUhw@mail.gmail.com>
Subject: Re: [BlueZ] shared/shell: Fix bt_shell_printf in non-interactive mode
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: larsch@belunktum.dk, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz, Lars,

On Wed, Feb 18, 2026 at 8:32=E2=80=AFAM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> > Fix this by moving the empty inputs check to after the
> > non-interactive mode check, so that non-interactive mode can print
> > using vprintf even when no inputs are registered.
>
> Such approach fixes the problem with no output in the non-interactive mod=
e,
> but does not restore the behavior that was before the e73bf58 commit. It
> prints some additional initialization messages:
>
> > $ bluetoothctl list
> > [NEW] Controller 8C:68:8B:00:5F:D4 MYHOST [default]
> > [NEW] Device D0:16:B4:25:BB:AE HWM20
> > Controller 8C:68:8B:00:5F:D4 MYHOST [default]
> > No agent is registered
>
> Such output might break some scripts which relied on the output formattin=
g.
>
> Below is a naive approach which fully restores behavior prior to the e73b=
f58
> commit:
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index 78d58c513..3f11f696f 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -81,6 +81,7 @@ static struct {
>         bool monitor;
>         int timeout;
>         int init_fd;
> +       bool attached;
>         struct queue *inputs;
>
>         char *line;
> @@ -712,16 +713,18 @@ void bt_shell_printf(const char *fmt, ...)
>         char *saved_line;
>         int saved_point;
>
> -       if (queue_isempty(data.inputs))
> -               return;
> -
>         if (data.mode =3D=3D MODE_NON_INTERACTIVE) {
> +               if (!data.attached)
> +                       return;
>                 va_start(args, fmt);
>                 vprintf(fmt, args);
>                 va_end(args);
>                 return;
>         }
>
> +       if (queue_isempty(data.inputs))
> +               return;
> +
>         save_input =3D !RL_ISSTATE(RL_STATE_DONE);
>
>         if (save_input) {
> @@ -1660,6 +1663,7 @@ bool bt_shell_attach(int fd)
>                                 return false;
>                 }
>         } else {
> +               data.attached =3D true;
>                 if (shell_exec(data.argc, data.argv) < 0) {
>                         bt_shell_noninteractive_quit(EXIT_FAILURE);
>                         return true;
> @@ -1675,6 +1679,7 @@ bool bt_shell_attach(int fd)
>
>  bool bt_shell_detach(void)
>  {
> +       data.attached =3D false;
>         if (queue_isempty(data.inputs))
>                 return false;
>

This looks better, at first I didn't like the idea of having to track
the attach state but there doesn't seem to be a better option,
otherwise we would have to revert back to all attach to STDIN, so this
way we don't reintroduce the issue mentioned in e73bf582d.

--=20
Luiz Augusto von Dentz
