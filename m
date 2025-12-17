Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B621D3CA
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766004946; cv=none; b=hd4YahshOnnnPtQhgcF/g8UxVe8e2YH0U15wqaZuB/K9wIjNwpL0HxgIwjNNTh28ihEvYs7zNh9K14FksP364EJK6gYaEozLpWUdbfTojU1mkZrjJKx9CNx+Yk9UBUl5ztfvLhSg7e+bZSrQ3cqOXLg5PTKIPi8Vpf8N8FnrTy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766004946; c=relaxed/simple;
	bh=ARzw0yhG7JrLJ4AFPc5X/qyfW4X/XK1qB7LsLWxi9KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEdfkHA/HYrvjP1Uhmq52GENjgKrVM2cycY/tpAyF4lvsnkg7karn/NMCli6vrzTMBYj50qKXqhilWTKONhAp33dvix2QYvQxZqDru7MiBWJ6ACeE6mhBnVg9HQePU2u/hzhs2J7NF0RFMhkC/RG8disfBJXaoU6Kz5Al5gEtR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEc5WoYx; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEc5WoYx"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a33b06028so51183351fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 12:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766004943; x=1766609743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1L3Te7+u2ZCHeXINj7bW4b1SmgCljgQ5w64c+/UCLQ=;
        b=cEc5WoYxWqwb2vOgBJdj4YLFXyWMsHdG/I88FZprNTo/8jH1MkXvy34hqgVueTNmQF
         lRpMcmFVzYxMLaw0Fjx0YSsC/3y7kqegmfjqvwQazNjLN8bm0G+c6nJfZguzmgjzcCSw
         ofT1NBIAB/8ajNGnPIuCR998ryIxRLUIZruCQBCjYk6D5Fzt3N25pDwGJ0EFSvpo3q6L
         T5nroT6DoOwlsIvWvnhlHWhxadzvxKQPIQu/T1oAMX/Fqp3onXOmxnXQlaGVbg0F/mHk
         yD/N4otv/xmiQQArWQxWjfvazXUKGuZpFJHpexMaJXFPu9qBIvdBOZN3RsscbrOpTqmk
         C0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766004943; x=1766609743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u1L3Te7+u2ZCHeXINj7bW4b1SmgCljgQ5w64c+/UCLQ=;
        b=fQjVybW2AduD8GaOpO1hprJx3LAMThe9y7obWzpIII+IkY1bcpeD6lAsjYnaWnM+C9
         2PQxbQ0CTOV4gWmVEahVBy7gQnVBsUjKAH7wRr5ztsB+kg/tJ7Fv9NQQiH4ccr5wu+Uu
         6kBeMU8F824jVV1ZlbgZogW388qZOPpZ0mZfNYvB0e7FQyRNeb7O5Xxw+Aw/8Hhnxj4g
         dK1qB+qb5EU3J5mjdC+yAelxG1CRx4fCuKYzKPflJBQDMzUQ+JEuQPRUrUZxW2fbCRpI
         5V18tABWyIEFmnAwfi6NVqkYy30wciSzDGmQVQgb/xdz2ZW4SLaign9vtDcqIbbEHG3P
         /y8w==
X-Gm-Message-State: AOJu0YzFt/UCsLKue1fMmBmfET5UVq90Xl/f9rULOxgAq2kCzeuHVi/K
	2BX5/EfPzRO7Lh7HE7jQyKV8CxWCNuNVIHu9L4A/irQD650+auRSzMAKZ92FFStvp5vcfyZVLnQ
	1WBndZ1bnC5S3PIJgDzrvlNEB7/M7s8A=
X-Gm-Gg: AY/fxX4PuMRE+zrKDjmBem2XqvUrH1L/CfSacfVbSq7zVWsG9YBnAmQJWMWv8EUx/3R
	UIODQEyfwq3b4cfe5AhSzH7hxikJ+cbivDUs19amCWBwmXXkZ7qtae47W21VW86sByw2bdgEGNo
	AD1QB82PDAiXKFmpBK1wMu7mREU4q4mR/AuhfE9KJ9MevY22752zh6sFUamJy8uB4172V903fk8
	5mTVCTHOOJQo/A2wMaN8PCdhk6hDHjF0ExaAaMniCBOtYnM67JKoZZ9cROKONYuTNjqZQ==
X-Google-Smtp-Source: AGHT+IEsMRhSdbTBEy57zOkAaA3skRPfwWDFigM5/8VJ55UP/dCJMlTr5Sq0feik8TPkLee4qTyZXoNVX9wJw6jXP/c=
X-Received: by 2002:a2e:bc12:0:b0:37a:45fb:d42f with SMTP id
 38308e7fff4ca-37fd07adb19mr50964281fa.19.1766004942610; Wed, 17 Dec 2025
 12:55:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217160256.441737-1-ssorensen@roku.com>
In-Reply-To: <20251217160256.441737-1-ssorensen@roku.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 17 Dec 2025 15:55:30 -0500
X-Gm-Features: AQt7F2oMCc8GflaJaBMeN1s4iTpc8R0WVX532HZCvMKepZ2KCjXg0uFWclor2FI
Message-ID: <CABBYNZLxp1aWRQp8cVMZjE-GgcTdMQPO6-eThcOiPG62A=geCQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/4] Decode system parameters and add BR/EDR idle timeout
To: =?UTF-8?Q?Stefan_S=C3=B8rensen?= <ssorensen@roku.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Wed, Dec 17, 2025 at 3:38=E2=80=AFPM Stefan S=C3=B8rensen <ssorensen@rok=
u.com> wrote:
>
> This series adds support for setting the BR/EDR system default
> connection idle timeout, documents some previously added default
> system configuration parameters and adds decoding of read/set default
> system parameters.
>
> Stefan S=C3=B8rensen (4):
>   doc: Sync default system parameter list with kernel
>   adapter: Do not send empty default system parameter list
>   monitor: Decode MGMT read/set default system parameters
>   main: Add BR.IdleTimeout option

Looks like the last 2 were not sent to list, or they were blocked:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D1034329

>  doc/mgmt.rst      |   4 ++
>  monitor/packet.c  | 117 +++++++++++++++++++++++++++++++++++++++++++---
>  src/adapter.c     |   9 ++++
>  src/btd.h         |   1 +
>  src/main.c        |  10 +++-
>  src/main.conf     |   3 ++
>  src/shared/mgmt.c |   5 ++
>  src/shared/mgmt.h |   1 +
>  8 files changed, 142 insertions(+), 8 deletions(-)
>
> --
> 2.52.0
>
>


--=20
Luiz Augusto von Dentz
