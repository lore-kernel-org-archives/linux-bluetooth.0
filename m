Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B8F3C1994
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918509; cv=none; b=seqHH/ILQSmlVx7AWd4Cm2f1Y2STLxNH73BJBPYjh4zDCIa6GUMBqPw4bxrdN9+7S3csRzLd2edxP+VFeuPexMFdbYCSdE0z0lJtKlHBpKRg+x0jwHGiakHrvzLf1vihlX78NKyuf6k+VXUk90wzHiFQuSIzd9i1F+wvPmL+a5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918509; c=relaxed/simple;
	bh=3CjVAAy2Pf43s5RUXTCp4KmX0yKxC+dBy77QytmHkJg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H/un0Qm9MfhKuHRQj6YuOpLTejpftWfsHt8EXx5T8q6F3o7xj3B1SdXedy6+6uOl+yspNqZavm6Gt1Ue4Tb3vA1t3sJLFSrtGvm4IjKEHO2w/5eDIHWMSZHrkrMUuMFs40i500DYmuc6U89JcvaJLt0GLTOkoooQytJFQ9pkXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 45A083EBC2;
	Thu, 19 Mar 2026 11:08:24 +0000 (UTC)
Message-ID: <d0395481e127f9a9324ae515c94e3bf869eb4fe6.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/1] shared/shell: Fix SIGSEGV on invalid input
From: Bastien Nocera <hadess@hadess.net>
To: Wouter <wouter@xesxen.nl>, linux-bluetooth@vger.kernel.org
Date: Thu, 19 Mar 2026 12:08:24 +0100
In-Reply-To: <20260319021645.2137513-2-wouter@xesxen.nl>
References: <20260319021645.2137513-1-wouter@xesxen.nl>
	 <20260319021645.2137513-2-wouter@xesxen.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeikeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepueeviedvteekkefgfefffeethfejieekteffvdetjeehfeeileettddvueeludelnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepgeehtedtkeefgfeuvedvpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeifohhuthgvrhesgigvshigvghnrdhnlhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg

On Thu, 2026-03-19 at 03:16 +0100, Wouter wrote:
> This fixes a crash when handling "<space><tab>"

That looks good to me, but is there any chance you could add the
valgrind output when reproducing this crash?

This should show the exact line where the problem is.

I would also add an explanation to the commit message like:
"Make sure to check w.we_wordc (word count) before accessing w.we_wordv
(word array)"

Cheers

> ---
> =C2=A0src/shared/shell.c | 18 ++++++++++--------
> =C2=A01 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index b061f8001..57bba0977 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -1174,15 +1174,17 @@ static char **shell_completion(const char
> *text, int start, int end)
> =C2=A0		if (wordexp(rl_line_buffer, &w, WRDE_NOCMD))
> =C2=A0			return NULL;
> =C2=A0
> -		matches =3D menu_completion(default_menu.entries,
> text,
> -						w.we_wordc,
> w.we_wordv[0]);
> -		if (!matches) {
> -			matches =3D menu_completion(data.menu-
> >entries, text,
> -							w.we_wordc,
> -
> 							w.we_wordv[0]);
> -			if (!matches)
> -				matches =3D submenu_completion(text,
> w.we_wordc,
> +		if (w.we_wordc !=3D 0) {
> +			matches =3D
> menu_completion(default_menu.entries, text,
> +							w.we_wordc,
> w.we_wordv[0]);
> +			if (!matches) {
> +				matches =3D menu_completion(data.menu-
> >entries, text,
> +								w.we
> _wordc,
> =C2=A0								w.we
> _wordv[0]);
> +				if (!matches)
> +					matches =3D
> submenu_completion(text, w.we_wordc,
> +							=09
> 	w.we_wordv[0]);
> +			}
> =C2=A0		}
> =C2=A0
> =C2=A0		wordfree(&w);
