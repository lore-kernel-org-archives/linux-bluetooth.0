Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F733E36A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426716; cv=pass; b=B2JqtWFgE2ttdvuk/25mxYOIg5Ld04LoX5b8lk4HJs5N4F23A5VNbXixR7C6d/ErNJUVbpCrO1jTB0PabE69eexr8R+YlV2h1b86W+LJMUU2H9hFjNWb0N8AJ4QJ4XucmEGFPK5kNs8YeAmjknNbHnA9ce0OeNqgPcL0KeQJ6gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426716; c=relaxed/simple;
	bh=z3leDWPHlglnt37XLO+pRSBSlXhIzsXOmGxsl7iRBmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xax4hRZDC5vwHBF4R6K7hoW+HzstrAmdC2GTHCGdCtYwa4FTJXcM9O+elDOJcc/sixw+9hq1J5a6R7jvT8ya709lm2mpsemIkHP1j2HG8GS+WH/o3JXZFI/Tcg9BDZBIbLVYTYCGszQfUPjunXlvF1uh4BkTJZPQAciOd9GuauI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGrJI5a/; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGrJI5a/"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad8435f46so4779316d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 06:58:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771426714; cv=none;
        d=google.com; s=arc-20240605;
        b=OmIk+2e6VniCN/cGktlBhN898nbrPurBMwEmzjA2hacRxtSlrAAkLozUDycUUA3jtr
         ip53D6ywESQ5YtbZJBUYT6Ptowm/idpEuymZ8w+3bcHVKFSjH4ArPJkXL+2HUeoeHtiE
         GkVIklI2YoRgZ3/BshsiKjrC2YJKqO9eu4Fo5rCVJW8RTrm0ftdMOZS04/ZxYInvFWSh
         +Hy3Mzor9f3emLit/BO/Yrl4K6uUBUpfq7GeAVl116YxL3LoHngESuEPga/fz6U1RN/P
         809tAekZFPAPcoJknQSu/QOyn6i64dJN3edOpmsfMzI4Gqf4bo65DRtbvSd8a6wsDAH7
         jlAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/IfMDde9dDIIwPlDAxAw309wIcuv6P/jjBcPOVgbj7s=;
        fh=rmteJgQOrgLpzpZaGd/VFvWTOpwsG1FBlQ5jhGNsQFM=;
        b=aC3l6NTpOYtw7NGhvcCoHc0wW9+Dca4ilYeF9az2gSyT0CST3UFt2i0+pOipkuhM6P
         Z1FPOVFbXMW4QMiM0y7XQUmsVdc1kydt52bwS0DmHQuKrwTq4PWFDNtXap+buS68i56H
         H773rIy1riVvT/ZhJnhCLHu3JDxRY7SKC6Ia6Ifj6HjxK1ctXQJNuxJoJQLlSJF4z3LE
         lVrVxPgTUmQ+9973lxHn+Arp7TgJLS2q7OewoV88i+SagcnVp2fxmNu+lYsT/aENrAyb
         t5lBIACK8EQv6bXO21QzsAHed8xz7H+C1wadPN17BYRiKNEF2MKdP0BFhm2BbUnsQ+kk
         VyNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771426714; x=1772031514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IfMDde9dDIIwPlDAxAw309wIcuv6P/jjBcPOVgbj7s=;
        b=fGrJI5a/R9/kic61UDKuKlCm2qyam5ScjjxW1bm9xEq3Y7RJSETueSuJjkrDlHvvcB
         /rrZo303jwz6nmijQUImp6W4XBIpU/PGkNvdiKqbK3CvkL6j45NNrqJYnLgaD80uNiAs
         mBYdT6TcvhCUqmS7YRulEZpwUxSllI26LcdN7qdL7MqLTaucCVQlzF+2n3IYnVA9wJuG
         nKumW+SLFNoCgCiNS/noM3wqHGs3sk1UH3VXk1/aw+ogdwyzsCYRI4YY2N0wEuTUFHXC
         mezSa+beXcFudc9NogCGsAR+2d70VD7+NXqoxIpGYtBMetA2eIzylV3ZXkpZZARJnEz1
         cBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771426714; x=1772031514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/IfMDde9dDIIwPlDAxAw309wIcuv6P/jjBcPOVgbj7s=;
        b=r+oHDsthyecnAEPOjuipNRK0qgVQY4AKMlFQTh4EIjfur8oMG2PXkZsg8lRmmgm7OY
         dleRFxUic4VQHiqkrfV5D1KiuLX5/8CWrFVlfbwFPthnJVVJpjjt41y+VK2J46YlrXMR
         FQHAVxZ7yUqkAg7HlD78si8Gf586Ae1NJLFfgHE8i6C4WvPhUdxe5C8B0PXZjL44gSII
         50LCkSmxVnksbtCyKJ1jJJtiObOmfL3FpgZTVEAc4SXcqTX1052OqRMrwsYyOShXpTRM
         NImUBRxxmARpeT7ct0gwTx/sl1CVzLLteHCzwDN3yOX1aiJ2W3Jso9jAaNP7t2MvAZpH
         t0Vw==
X-Gm-Message-State: AOJu0Yy8NE95qlqSh33zDCz1M1wzuGx+jpNfIxTy4/Pdh86vNKzFpSJp
	dSQKA9zs3qdlJAjn/H63KqpXn1z4PoKeptXduJAs5hrFD13p8j153Jhmnu/AL+oqCbx/3lzGVeW
	+y5Xk8Cs15d4DcfYExdPHTVxWoMoP0h3eow7nru0=
X-Gm-Gg: AZuq6aJVBxL2jRcx9kIZEx14O6L5hWKk9nC9k7a3hZnYQz0U8y3ZvM9YDrfp1mcMjaM
	d9qUArKLMxcQ3pyCz9Qt385hMcghCcoUhhX3irCYgGEg+/FMERMdjiejWsRv29zrlRx3jAs2NcW
	OFMyalOu/xPDyD8YRk/LM6z9m1lbP1CKsOwB3ZYnzHlesIrHPl9BYYUscXvNRTGdQ8T06sR1Oq6
	MF3MfXF/Hzosqf8Xe364eDq34S1Ro62ekf2rqsBV8QoFwLbMspkM+ka82iGUWskAHlDwbldJi5j
	SrnemtEZ9S9GnVdtvdeG9hChXP4IbjmbX+CXdENVX/XMzmgjLdfyfxcdlYmScCJmtL4=
X-Received: by 2002:a05:690e:1409:b0:649:603f:7026 with SMTP id
 956f58d0204a3-64c21a42109mr12442866d50.15.1771426714036; Wed, 18 Feb 2026
 06:58:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218024605.70890-1-ronan@rjp.ie> <20260218024605.70890-3-ronan@rjp.ie>
In-Reply-To: <20260218024605.70890-3-ronan@rjp.ie>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Feb 2026 09:58:23 -0500
X-Gm-Features: AZwV_QjGStPTO6CMvvQGLAXiNgWRBp0qJ0FRApfZAVaHAWQGL4DK4TZFF913USA
Message-ID: <CABBYNZJqjaDJmkEy0yvyqLXP6kFH-dVjnzcCVknAkpu39zspaA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] shared/shell: gracefully recover from failed
 input initialization
To: Ronan Pigott <ronan@rjp.ie>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ronan,

On Tue, Feb 17, 2026 at 9:46=E2=80=AFPM Ronan Pigott <ronan@rjp.ie> wrote:
>
> If input initialization fails, back out before waiting on events that
> will not come. In turn, we can go back to initializing inputs for
> non-interactive invocations, which fixes printing for non-interactive
> commands and the zsh completions that rely on it.
>
> This effectively reverts commit e73bf582dae60356641a32fc27ae03d359ec4c47.

Yeah, the revert part doesn't really fly since
e73bf582dae60356641a32fc27ae03d359ec4c47 does fixes a valid issue,
that said we do have another proposal under discussion:

https://patchwork.kernel.org/project/bluetooth/patch/20260217222954.432676-=
1-larsch@belunktum.dk/

> ---
>  src/shared/shell.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index 873a14176af9..b9fcc665fcae 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -1640,15 +1640,22 @@ static bool shell_quit(void *data)
>
>  bool bt_shell_attach(int fd)
>  {
> +       struct input *input;
> +
> +       input =3D input_new(fd);
> +       if (!input)
> +               return false;
> +
>         if (data.mode =3D=3D MODE_INTERACTIVE) {
> -               struct input *input;
> -
> -               input =3D input_new(fd);
> -               if (!input)
> +               if (!io_set_read_handler(input->io, input_read, input, NU=
LL)) {
> +                       input_destroy(input->io);
>                         return false;
> +               }
>
> -               io_set_read_handler(input->io, input_read, input, NULL);
> -               io_set_disconnect_handler(input->io, input_hup, input, NU=
LL);
> +               if (!io_set_disconnect_handler(input->io, input_hup, inpu=
t, NULL)) {
> +                       input_destroy(input->io);
> +                       return false;
> +               }
>
>                 if (data.init_fd >=3D 0) {
>                         int fd =3D data.init_fd;
> --
> 2.53.0
>
>


--=20
Luiz Augusto von Dentz
