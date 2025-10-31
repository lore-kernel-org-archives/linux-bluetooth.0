Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92812EAB72
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Oct 2025 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926905; cv=none; b=U+by5Yl22oIwIcz+utCONmVQsCh+tVGv7kQYACoYxyxJaHhhvgPzZacgMLaunCU8Gd4eDPW1yEnjezuNns5IX9QCd+vJRDFQibNdtu2iwkJRecu/EJuL2dC/KbbUlDW2UfFHqLsHI3ymGc8+4Uj/7lMzdIoUmiD/dyC650eGY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926905; c=relaxed/simple;
	bh=9S83cxENoSg5DqHt9oZQfABCQ+/GK6ZJ0dcm2YB75cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/wP8HgrWUMdPjYH6EyRsd2qr/p1KYNXCmvp0hqM/i+YwHP1XJQ5a04ZaQ5ERJr7mwhPeMig6RHHYiCAmNBImksNrG5RBssfjxDF4RUEZD43cxSueBHdZYHy6Iq0ZLqUGUnZ7+hywR11VJBepPnV08qJV6cyMTwGrhmiyTH8BSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw9vfiQv; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw9vfiQv"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-378d246f0f1so26465261fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Oct 2025 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761926902; x=1762531702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuQfm13FYmOEv89BUfqWjxtiS9rNIpVkW05BjM+oP5Y=;
        b=cw9vfiQvYYRMMsqqrWnwSQ+wMliV1qCeOZlCq7vPCdXtDZwE6GbwM3T2LLZnQJ6mbx
         oytRXVgE0js1UhpF9WCfY36IzwjzVZprugLw/QGvPeN2+59SUGQyKPGv/Dc7ehAzJluF
         UE89CRvqIaKZe6rRQ42alQUP9CS8QCFWCylPwCq6N/5HFYZL+LB1WqU9TK65ptYEH4cx
         xJtNhy630BPHNRFdgMk4UuTgbU/689jWZmt8aw9QPXOvz7b6ZYW98VYTfazgTBFdSz+7
         UclpLOn15x7L8YfOgImjKsqIm8xXTQY8ghNYhpTObs8+7KrbXd/qEH2SXDAgq1YJaZjE
         7jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761926902; x=1762531702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuQfm13FYmOEv89BUfqWjxtiS9rNIpVkW05BjM+oP5Y=;
        b=mXu11nPiEPMmeI3Zx5tQ/5ewf1qOfO/j/34rHh7Ifayb/cz23k8rdffABFDskptXCY
         DaRAOUHHL3fW8lF9lhcE769pwoWO7Nr9e2NOmRzFuhxhkxj5oLZ+Fha07OzksH76MisI
         baeN6ufJ03IO7vZHi9cSD8ujzLLf4u+Y4IRc5Fn1/v4ulW1CP7AhpVJ89AWKlwu8Uhsq
         L0OPIjUmsmiJ1V9v/wBT1ZqxOH83nPY9jju1sKBWNAM1ToBEPZPHvsOLL+fgWzKA6+T9
         CmGaYZq18V3z5gABAUDTWyg7kw+RaZo1EDvOOH7inC+/FiStgp4C9TwcBCNFX0xvHtG5
         kWzQ==
X-Gm-Message-State: AOJu0YySLXtbzkTwusOg/JrCQLxpC0wRPK49KZ68r5xT65lIaIDgPFCS
	iPdQuT9/jYL2ZsWqRhI3CDeJMYfgfWa8Dk4hto4IoMz3KNaCGjbbHmtEKPEUICdarl7bvGznhd/
	QjbS2VXOBw/l3XrzXItU0FeeEtptdfQIJ41Eqw/s=
X-Gm-Gg: ASbGnctRWm2ubANtpS0v4E74Xs6sTSZd+pbZxpP3PeK0bM4ziX4O+bGxfUlM8KZAkGd
	w2aTszaE3VdCDi3xiQYbMm9XYzwbX5Nm+RfJMGttg3Uo69LDUOtDVQyPyPz2RoRseRfuJEb4qso
	eXGxMBArdrulmR9DFMxkdRldiDbhnVLnu+koz3QiuFG/Z/5anwqqaGbozrvOn1nbIzurZWv4kbi
	KQuNev9w7/0GcmCciLLyWiWjZXrLSPcT4HWCo6wn7hHNvTxBd3C7wJ3kn1HIADCRM2hNA==
X-Google-Smtp-Source: AGHT+IG2ebjvrdDH6+dtExQq+K0SF0gS9eDJF+zaVe/MDnpqGMWnJ6prL0tT7SXp+housU2mkizE+/EtWqw9ITUaAiU=
X-Received: by 2002:a05:651c:4019:b0:375:d1e4:21d4 with SMTP id
 38308e7fff4ca-37a18de3f8fmr11978201fa.44.1761926901453; Fri, 31 Oct 2025
 09:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <-w4Tz-HGOFe81IvBNIZkrOtGaZ6VR30rkdG0gO1KgjhxcPPSli_0wT7tBXmJ1aUbSXQrBj7g0sEEfolp4FhC5d2WJwwICWVE0oNlVa1sp_w=@protonmail.com>
 <DjjfVohXbHW1CnEWPzTVKg1cI0hNqpQsr4lcGCQSp7bGEd94UnW_Ym8lFlBbpOznvDA_7oEcg_txeiG9WbWlIg8Uhh2GpLtkfB6pqZIIVGY=@protonmail.com>
 <fmoulYbI3lrfCDbEomCGSFXsrYe7um4WSROyh7TBdV1WaBxBOgW8oYysZuVADOm_YiDbhKitNXHgHp9Y8BPvi1aHTov_8HHSc0PH_Tm7oYE=@protonmail.com>
In-Reply-To: <fmoulYbI3lrfCDbEomCGSFXsrYe7um4WSROyh7TBdV1WaBxBOgW8oYysZuVADOm_YiDbhKitNXHgHp9Y8BPvi1aHTov_8HHSc0PH_Tm7oYE=@protonmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 Oct 2025 12:08:07 -0400
X-Gm-Features: AWmQ_blTCU9vlBBq8srloFYl4mA1KfXpYRP1XtnZpFXEyyxc-Z9lxPq38BpeZg8
Message-ID: <CABBYNZLGwgwPdU1rq8i8d-TuYSn2TZphzZn8m=4PdzB+NR_s7A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] build: Fix distcheck by hardcoding non absolute paths
To: Alfred Wingate <parona@protonmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alfred,

On Thu, Oct 23, 2025 at 1:06=E2=80=AFAM Alfred Wingate <parona@protonmail.c=
om> wrote:
>
> To make sure it doesn't fail lets hardcode every path that could come
> from pkg-config.
> (I managed to hit issues from dbus **and** cups as I have them installed)

Well if we hardcode the paths then what is the point of checking them
to begin with? I assume we are retrieving them from pkg-config because
they are configurable, and if they are configurable then we cannot
hardcode them. Maybe the point is to make these paths available even
when systemd is not? In that case AM_DISTCHECK_CONFIGURE_FLAGS should
be conditional to not having systemd, or perhaps it just the prefix
being used, in that case can you just do
$${dc_install_base}/$(<original_path>)?


> You can learn more about this type of issue here.
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1123963
>
> See-Also: 9cc8b97b8 ("build: obexd: Fix make distcheck")
> Signed-off-by: Alfred Wingate <parona@protonmail.com>
> ---
>  Makefile.am | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Makefile.am b/Makefile.am
> index 94f625db4..3e25c01dc 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -2,6 +2,14 @@
>  AM_MAKEFLAGS =3D --no-print-directory
>  AM_CPPFLAGS =3D
>
> +# pkg-config gives absolute paths that do not work with distcheck that w=
ants to use its own $(prefix)
> +AM_DISTCHECK_CONFIGURE_FLAGS =3D --with-dbusconfdir=3D$${dc_install_base=
}/usr/share \
> +                              --with-dbussystembusdir=3D$${dc_install_ba=
se}/usr/share/dbus-1/system-services \
> +                              --with-dbussessionbusdir=3D$${dc_install_b=
ase}/usr/share/dbus-1/services \
> +                              --with-systemdsystemunitdir=3D$${dc_instal=
l_base}/usr/lib/systemd/system \
> +                              --with-systemduserunitdir=3D$${dc_install_=
base}/usr/lib/systemd/user \
> +                              --with-cups_serverbin=3D$${dc_install_base=
}/usr/libexec/cups
> +
>  lib_LTLIBRARIES =3D
>
>  noinst_LIBRARIES =3D
> --
> 2.51.1
>
>


--
Luiz Augusto von Dentz
