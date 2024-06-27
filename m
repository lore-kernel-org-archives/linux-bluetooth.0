Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFCC18645
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513090; cv=none; b=qZ2xWHqa+G37STWN/j17PBdCA69aHKZ5inn3q96DvQueEgKO6LQLMUCvvYKX1MmaRyl/fqpj0QexnMB1oBHwhGMt3AX9WbHOWdnrY34uyZEmthOEPRbbIb1vhX9TyOXxNvK+WRzN9grQud+Gi7i5BJdkdpEAWroMe5MnqI6EbBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513090; c=relaxed/simple;
	bh=OAa5cMviopIyv2O2OtfVTJetDwS1M0V2ZGnwQzI9FVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuLOpeu15Az9cmZ/drpAbzMfgEOSShDhJIRb5djLdbs9B7Eip+CrjZFspTJCf73UXzlCAPmA7TCrYVzG7J0RRUqV05hyta5U0XbYkBmWzB+d1YFybN0/kei9/CaKaFX/bGZwSYsIdx340f0Wt7VuXE3mvsojVR2cySIQ6nXtfHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKQm7TAC; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKQm7TAC"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so94232691fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719513085; x=1720117885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sow1OqzwzF/RgrQxjhMG1G0nmpP4gRQjykTqKXmr/Kw=;
        b=gKQm7TACIG5mzfvMWbJZCA6yFtioHj/27F47fLxl/GuX6dlgbA8PTUGxAiMgfnxuIA
         xKSoE30YnRNFSyCEBe6CYdBUhxAxkdTpOPCEEPdLsxEdLeqtigU60BXc0Ku8beXQtPuw
         X/aCRh0P1feiUqHUbVbq5Mh4FV87p3l9uzmJ3kAV2K5K5QTnhB5X003ZcA+hzt6q06X/
         uWml3gTvJZuEBqkxYk0+JJ7bVaGjD1IskrLrjIlAKMAulALc1jWrpigG0oL+b4sUid8L
         NINWx6tFPNFNBtfBO5PR5prHvHuyRSXr50AkyhJUte8OZgFGSo7Eyci9BDejwtlNFYuo
         +bFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719513085; x=1720117885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sow1OqzwzF/RgrQxjhMG1G0nmpP4gRQjykTqKXmr/Kw=;
        b=FJEaZLk5CvrUwStcVBaBWRTNc+M61Mr9lVSijeNucgl4D6G2126tUQXjQ3HUHpVA0Q
         hFLzhH0s2V3lhyrDtRl/ps/nixhIM9T54buctXa+iBJIC3IQAiu3Qqk3cYR0nQ4BEJoa
         Dp736RDXhd2Gbr/YmVVG54qQKaMEqHNmoAW+UHyyhJBuo5cWSXzmHXHW1+9IZo3XKBQ1
         XqOTi9V83a7rNe7dsyY8cM+X0JxyjtkRYLiftY2DJb6vg6MJJltyPs3k/qxGL7kYR2t1
         eG1Qeosorkon5SCjEC7tIzJf976lSXNkPKgI8LZLRJHda7VNdW6umSfAePIJNh5CzCpK
         gUow==
X-Gm-Message-State: AOJu0Yz8ruDEomdOlHgX+nFOoGas+nbVI7c77cUqyeJEEZUcCEDcYqdT
	agyojGgHhDa/Pk+d00PRmLlUj7nZzK8myiVgmS88OgeqNai63nPQSOuc2OrYarw22Ww8FtO9Brp
	nRrn+U7UaKt0xNdioKEijax4rMZcY3Q==
X-Google-Smtp-Source: AGHT+IHP0UgjTlMM/TtvktD6e9MOy4dCWgVTexpCOXqm3S9uO1pE/0uXEE+axZ/8Ypfz6TPgrnerO537e3mzCen/boU=
X-Received: by 2002:a2e:9350:0:b0:2ec:18e5:e686 with SMTP id
 38308e7fff4ca-2ec5936fb1bmr108070901fa.33.1719513084339; Thu, 27 Jun 2024
 11:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627150917.85755-1-r.smirnov@omp.ru>
In-Reply-To: <20240627150917.85755-1-r.smirnov@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 27 Jun 2024 14:31:12 -0400
Message-ID: <CABBYNZLbs5HE5aEPgPC4NCcEUWrCXrodN4q=3rc5FjGgHAdnBg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] gatt-server: fix memory leak in bt_gatt_server_send_notification()
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman,

On Thu, Jun 27, 2024 at 11:11=E2=80=AFAM Roman Smirnov <r.smirnov@omp.ru> w=
rote:
>
> data-pdu is allocated but not released when an error occurs.
>
> Add data-pdu release before exiting the function in case of an error.
>
> Found by Linux Verification Center (linuxtesting.org) with the SVACE
> static analysis tool.
> ---
>  src/shared/gatt-server.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 0e399ceb1..fb8819c70 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -1822,6 +1822,7 @@ bool bt_gatt_server_send_notification(struct bt_gat=
t_server *server,
>         return result;
>
>  error:
> +       free(data->pdu);
>         if (data)
>                 free(data);

This should probably be inside if (data) block though.

>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
