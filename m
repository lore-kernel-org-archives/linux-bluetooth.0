Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00872600
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943417; cv=none; b=cTKvqO9ys7rqsKaE9XoU1CIuWutkJ6Csk6WqO7Fe8eZkx4SnryDMTWA0+F9XnGw2M08JX3fuOVxiAN7Uk888KCpi0PVYwjdM7S2jLis1bjiPiHG34E3Xpnl7WBo7ihlpKGjIHgOGaL84z+eYfY6XtLwrg/KWujVYSWsV9wPVLE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943417; c=relaxed/simple;
	bh=Y59pMHOpT9NXE57Li4Pzywp0hVVBQR5jhPVCpLBeqN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eF170JTXEh1RrgD7FJHOey5iq0nGGSscdFHJu3/kDtEshdmApRQmx/NkNt6+cywy7D6vwNyt540I9IjmxtSIrKuenSDPiivwjYxBHnXpkw2IU0lOxgbOArdlH/ZtMJnLx7nKjkh1wygPkZPzGe8IB8noIWSxce/xUD+qfAYsCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xze6FvCL; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xze6FvCL"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-332426c78a2so38192481fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 13:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754943414; x=1755548214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IT36CG/EVkPvPtKV0jJ06nfLPLWq05pjU7Nsll/eHIM=;
        b=Xze6FvCLSx2f8QnsOlu8pyUkxZS063i1ycxkb5Op4j6N+xx8P87oM78dry+4bOTw4A
         TTY/oqAAGfky2dABjbPqY8J3FX/e1QBkBOl67XHBK+bHjTUzZ4o1AdzR/6YZYjJaMV0l
         ASEQg5DK61mz8UzadvBaCtiZ9nBChCVfoyyyV861oY5cAwzQSGQN851kYBO74DI+7Bc1
         lukNo5E3X3PCufbMmvZG/2K+9cwv3TAfbboi1yYqC2sDQHJcpNQHRbpsf/wdzd2URYAi
         hnND9W+ZdhSO542DLuCTUsl0iJ9Ok+MZsNVH0nBJLGL9NGo1VilAMJ4cxQYLiu6DU5vz
         GPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754943414; x=1755548214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IT36CG/EVkPvPtKV0jJ06nfLPLWq05pjU7Nsll/eHIM=;
        b=YfiMjBwf9BBPWCj9e5sxUlqONT/3gpdx715K4K2vG3QKgxS4ZUa3cG5sOhFOgES8fd
         bdoFsfWIYmefqXsI0BacrDaERQU27VJ6a/H7esobbxOMZHZ/b5Zao13WGKgtArncioPu
         2DBaV2aD+Z3IXzxx8O2cXuIE1XAgfuenaNvg5Ahi/UEYTQ2KGrRh7Zv1dtSEcblKZ1c8
         YuOfgOZEYRkV8evrQRxSu1/eaK5B1RPYDUGxKemQ7l2T5nSlTHKEtOKaFXLQ3XlLT01n
         +uTre6tlnXOMKKeoOfM0m7RCA221KvajkabA+YSnDjKtKsAe1Bn/F++NFw3fMEOYnwfE
         hvyQ==
X-Gm-Message-State: AOJu0YymJ74ouRybncALC4oxxQSgnrlsVdAJAwQkceGJFc78YGk1G9ub
	fqafFgT7B/gePG9evepDSugiq7XXSEQY2bE8+l7JAwUCSpbGpLQZTS0p0KR5d/DS4j088Pe44nT
	4Rp6lvNlJNKAar1kmmiPV3nYkuLWMhgORln4R
X-Gm-Gg: ASbGncsOslxqeABHGBXJ9+iykeKM9Qdzq+cEm0S/oWS1L3+TIwvSDzdLgYZOqiBTLkR
	7M9Dgq87LLUvWQjoG2C0E7cgl3imGgs5WGs4CMAk+3bG7SYFov8Z0NtbUaBa6WkeFx01EV8w1hO
	3TDVL65O9REo1nrzJ0IQSA53ggI2NHdFjmCpFlyrDOWs7tkeWGi6/IVvXg1F/uWdWyeWN8zOqAe
	O2QsQ==
X-Google-Smtp-Source: AGHT+IFmT3g0m7sGKq8di4j63fNpIKAviNTVXP42NecIfcqbESIOrBOI5LXex9c5xDFZ6vMo8jJrEWTYNmv1Ve4+ejs=
X-Received: by 2002:a05:651c:553:b0:327:e0ac:bd8c with SMTP id
 38308e7fff4ca-333a22bf104mr38826811fa.37.1754943413621; Mon, 11 Aug 2025
 13:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811195850.1775759-1-hadess@hadess.net> <20250811195850.1775759-2-hadess@hadess.net>
In-Reply-To: <20250811195850.1775759-2-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 Aug 2025 16:16:41 -0400
X-Gm-Features: Ac12FXwI2g5LncSui08QgVLUuE_aJSo_f0-PHnP4R6l7uXCCHI88IHnntY4HQLQ
Message-ID: <CABBYNZK4W=ExFThcES1_vu_0a7aQnzMtX54CYV+8LDinXkyELw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/8] build: Add ell subproject
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Mon, Aug 11, 2025 at 3:59=E2=80=AFPM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> Add the ell library as a subproject. Rather than doing like autotools
> and relying on users checking out ell in a particular location, or
> install ell as a system shared library, use meson subprojects to build
> our own internal copy of ell if the user hasn't installed it
> system-wide.
>
> Note that this currently points to a fork of ell with meson support
> added, this should be switched to the upstream repo when that support is
> merged. See:
> https://lore.kernel.org/ell/20250807134859.930870-1-hadess@hadess.net/T/

Ok, well then we will depend on ell switching to meson first, have you
received any feedback if that is going to be accepted? Perhaps we
could just turn it into a regular dependency instead of requiring to
copy its source code since that was done due to distro not packaging
libell back when it was introduced, but maybe that has changed since
then.

Anyway I do agree it is quite ugly what we are doing, requiring ell on
a specific to build and the usage of submodule is probably the right
thing to do if we don't want to deal with a system dependency.

> ---
>  .gitignore      | 1 -
>  .gitmodules     | 3 +++
>  subprojects/ell | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
>  create mode 100644 .gitmodules
>  create mode 160000 subprojects/ell
>
> diff --git a/.gitignore b/.gitignore
> index d23a06af4b53..3da0ac680152 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -35,7 +35,6 @@ test-driver
>  test-suite.log
>  coverage.info
>  coverage
> -ell
>
>  lib/bluez.pc
>  src/builtin.h
> diff --git a/.gitmodules b/.gitmodules
> new file mode 100644
> index 000000000000..53881e4d8e3f
> --- /dev/null
> +++ b/.gitmodules
> @@ -0,0 +1,3 @@
> +[submodule "subprojects/ell"]
> +       path =3D subprojects/ell
> +       url =3D https://github.com/hadess/ell.git
> diff --git a/subprojects/ell b/subprojects/ell
> new file mode 160000
> index 000000000000..08bc5f26f210
> --- /dev/null
> +++ b/subprojects/ell
> @@ -0,0 +1 @@
> +Subproject commit 08bc5f26f2108a778a25222fdc60b931310ad68d
> --
> 2.50.0
>
>


--=20
Luiz Augusto von Dentz
