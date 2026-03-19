Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D322AE65
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929439; cv=none; b=EujqZqNG3ddbLyVPaZGpeFtN97a1MH6YP9F/xBZ2b6G4XXU+6rOYAp8c4sLFevomc3D1UsILeiUy3yhKjyVLqdMSggyczG4B7WL+Hjw08rS4vxwrAsrJbbU7v6DMfBr2EfwHo9d6EpS7kAj5GVl7S8/zxva++3vo6J9/mKanvLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929439; c=relaxed/simple;
	bh=dqfX9DI6TXHosFkaluEWg5tDG9gMWcAHTcpSUtnH0WQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zboa8pExZJ0yGVBUd9qbaDP+VumBRNyyU1uhBpCj02U+4s5O1qb1FmdlXG32qwpgEl2G5qlw3Vi3HYNBddOQvkEh9wZY2QZjqaSqFLEfFLU1LpPUP8S+K1b1wH0YiTbGcpFvGPY2DxcUAV/XpAIGEL85gjPpd8NvObutnXJjufU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xesxen.nl; spf=pass smtp.mailfrom=xesxen.nl; dkim=pass (1024-bit key) header.d=xesxen.nl header.i=@xesxen.nl header.b=FjD0gpKB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xesxen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xesxen.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xesxen.nl header.i=@xesxen.nl header.b="FjD0gpKB"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so1580227a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xesxen.nl; s=google; t=1773929436; x=1774534236; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqfX9DI6TXHosFkaluEWg5tDG9gMWcAHTcpSUtnH0WQ=;
        b=FjD0gpKBf6zDNsXYnkN5Y1//7sqlTIF3yqfT0UBl7Ojyx16rPc7JT0SQiTz+QEpvYc
         ElSCzNBvY3OCC9ST+FYC6CqegOR+JR47LsaQWM7C2Bc2r2wUuEKKN/xM0/Ucs9125P8v
         suGLazjo5J3YE2OVCyHKKvw7q/pAOLxqbppSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773929436; x=1774534236;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqfX9DI6TXHosFkaluEWg5tDG9gMWcAHTcpSUtnH0WQ=;
        b=oe4jwa6630vNTFlFiqDF+0TZihCqHyFXiCiGHNgnN0+eTEgUeB+PN4N90AePm0bGzg
         MsuVvGXISUuQOMs/CTy0tYCYYA5VKnX3+1K41gASm3ALRMwnJnkH/6haDykDwk+lrBfP
         EQS94afrp6TOW3xK0sR1LfNynFHBenL91nAv3FWeARGbmP+kadQA0AezCGh+fxP/Jl2f
         G7P0G9eaSzT+fcI7i7hLaGyhJ8ZzGL2kCRNeG1IYXDaWPaQgJtNO8xXm0sLq//KZybPv
         d/+dFMIk+1syPZ4KBU0wu+e+jhTKxkgkkapgrno7aWy8X0KKmbaR+G5fHMZeLjTSAM+v
         7mVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUdhCyxRgyE9f9aUYxb+CDG4x4/XJ00TnM9HlVXxIsIH7IwjGiFSiG3aBV/RKC15/eaIIi+VtuzYC0DOqght0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXWB0ja7qivfU6XLifhI0mzisxKH4BYcPyzW1ve0vGMNCl/gbt
	jzUJi1bo5W8z8vIxYzRyiunEqlSCQKaHiK3DwBADbekb3UJW3mCEigOdEABa/ne4Y1EBkGTtJAq
	4BEqp76k=
X-Gm-Gg: ATEYQzz908hdyPTByDRq0eewQAsxth6j8xALC2SEHiRgFEVZUvO0ZQQ/t5A52cIpDyT
	EHis7vy6SQZNSGeaKv5N8QnO5VE7l8IOEOB50T78U4ss2jjEV8GhIyLZHhHOUigeDkSquKqt1ir
	qeEiZyATWfrEWBbe0V53Qs8K5OTIXLcU+Ghfm1A+YUNjioxAbxV4zAyWyKmymjdodIbd5ofRoEX
	PhNfCoo37UpQtksqJmejhR8tgstu5sKfgzLKeB9v9o+K9vTEYAq/d+fDygvv+aQYyKjq8QT7iNW
	cxuVZKaGpcCOiqtPA8OX1iOqeUKas3O2otdPfjikkuXzUetr1A5l6j1C0oxu/Rbg8uUjtsvkN+X
	iCiuv02kq9GlCO60n+50PSHZxsEOO4bPc3H9OL9joesmgpRmjkfKX1BkpW29SK0/kn9ZfpaSn1k
	TaPkpEJUfBy0wF9kS7ELwy+h5EdVQRuEG3jbGBzy9wV7Br5LyOJWqahZPM0jjL3CU=
X-Received: by 2002:a05:6402:2712:b0:666:d724:2f34 with SMTP id 4fb4d7f45d1cf-667b33e808dmr5085826a12.28.1773929435959;
        Thu, 19 Mar 2026 07:10:35 -0700 (PDT)
Received: from 2a10-3781-4903.connected.by.freedominter.net ([2a10:3781:4903:0:eca5:f23c:3275:af25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-667af38d891sm3751306a12.9.2026.03.19.07.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:10:35 -0700 (PDT)
Message-ID: <d7464a29ca67afa5da0f6978f54cb682da06eea0.camel@xesxen.nl>
Subject: Re: [PATCH BlueZ 1/1] shared/shell: Fix SIGSEGV on invalid input
From: Wouter <wouter@xesxen.nl>
To: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Date: Thu, 19 Mar 2026 15:10:35 +0100
In-Reply-To: <1b00ec2d4091980aac843f65a72c40752436aed9.camel@hadess.net>
References: <20260319021645.2137513-1-wouter@xesxen.nl>
			 <20260319021645.2137513-2-wouter@xesxen.nl>
		 <d0395481e127f9a9324ae515c94e3bf869eb4fe6.camel@hadess.net>
	 <1b00ec2d4091980aac843f65a72c40752436aed9.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

I'll send in a v2. I had shell_completion changed instead as it's the
sole caller of those methods, and would mean it bails early rather than
further down the callstack. Your suggestions are cleaner though, so
i'll adjust and re-submit.

- Wouter

On Thu, 2026-03-19 at 12:15 +0100, Bastien Nocera wrote:
> On Thu, 2026-03-19 at 12:08 +0100, Bastien Nocera wrote:
> > On Thu, 2026-03-19 at 03:16 +0100, Wouter wrote:
> > > This fixes a crash when handling "<space><tab>"
> >=20
> > That looks good to me, but is there any chance you could add the
> > valgrind output when reproducing this crash?
> >=20
> > This should show the exact line where the problem is.
> >=20
> > I would also add an explanation to the commit message like:
> > "Make sure to check w.we_wordc (word count) before accessing
> > w.we_wordv
> > (word array)"
>=20
> Actually, looking at the valgrind output:
> =3D=3D1430873=3D=3D Invalid read of size 1
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 at 0x484BC77: strcmp (vg_replace_st=
rmem.c:941)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x435063: menu_completion (shell=
.c:1126)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4352F0: shell_completion (shel=
l.c:1177)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4A2542B: gen_completion_matche=
s (complete.c:1282)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4A2E9CD: rl_complete_internal =
(complete.c:2104)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4A257C2: _rl_dispatch_subseq (=
readline.c:944)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4A26ADF: readline_internal_cha=
r (readline.c:693)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4A46CE4: rl_callback_read_char=
 (callback.c:275)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x435E54: bt_shell_input_line (s=
hell.c:309)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x436A34: watch_callback (io-gli=
b.c:173)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x490A322: g_main_dispatch (gmai=
n.c:3565)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x490A322:
> g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4425)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4913277: g_main_context_iterat=
e_unlocked.isra.0
> (gmain.c:4490)
> =3D=3D1430873=3D=3D=C2=A0 Address 0x0 is not stack'd, malloc'd or (recent=
ly)
> free'd
>=20
> I think that a check in src/shared/shell.c might be better (and would
> avoid having to fix the bug in 6 other places). Something like this?
>=20
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -1122,6 +1122,9 @@ static char **menu_completion(const struct
> bt_shell_menu_entry *entry,
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char **matches =3D NULL;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (argc =3D=3D 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return NULL;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (; entry->cmd; entry++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (strcmp(entry->cmd, input_cmd))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue=
;
> @@ -1146,6 +1149,8 @@ static char **submenu_completion(const char
> *text, int argc, char *input_cmd)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data.main !=3D data.menu)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return NULL;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!input_cmd)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return NULL;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D strrchr(input_cmd, '.'=
);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cmd)
>=20
> Let me know if you want to send a v2 with the mentioned changes
> instead.
>=20
> >=20
> > Cheers
> >=20
> > > ---
> > > =C2=A0src/shared/shell.c | 18 ++++++++++--------
> > > =C2=A01 file changed, 10 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/src/shared/shell.c b/src/shared/shell.c
> > > index b061f8001..57bba0977 100644
> > > --- a/src/shared/shell.c
> > > +++ b/src/shared/shell.c
> > > @@ -1174,15 +1174,17 @@ static char **shell_completion(const char
> > > *text, int start, int end)
> > > =C2=A0 if (wordexp(rl_line_buffer, &w, WRDE_NOCMD))
> > > =C2=A0 return NULL;
> > > =C2=A0
> > > - matches =3D menu_completion(default_menu.entries,
> > > text,
> > > - w.we_wordc,
> > > w.we_wordv[0]);
> > > - if (!matches) {
> > > - matches =3D menu_completion(data.menu-
> > > > entries, text,
> > > -
> > > =C2=A0w.we_wordc,
> > > -
> > > =C2=A0w.we_wordv
> > > [0]);
> > > - if (!matches)
> > > - matches =3D submenu_completion(text,
> > > w.we_wordc,
> > > + if (w.we_wordc !=3D 0) {
> > > + matches =3D
> > > menu_completion(default_menu.entries, text,
> > > + w.we_wordc
> > > ,
> > > w.we_wordv[0]);
> > > + if (!matches) {
> > > + matches =3D
> > > menu_completion(data.menu-
> > > > entries, text,
> > > + w.
> > > we
> > > _wordc,
> > > =C2=A0 w.
> > > we
> > > _wordv[0]);
> > > + if (!matches)
> > > + matches =3D
> > > submenu_completion(text, w.we_wordc,
> > > +=20
> > > =C2=A0w.we_wordv[0]);
> > > + }
> > > =C2=A0 }
> > > =C2=A0
> > > =C2=A0 wordfree(&w);
