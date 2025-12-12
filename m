Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932525A33A
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553262; cv=none; b=M0U7KvZjdLGAWg1kM1vVBh6omnGzCnHwrtw2mAdBvHU9vf7q7LjFMYvRn8p40JQUUEkwF9vdX0KPGNuhKCfTRv4W545dStIL9nXDzwcteDml0LNLLBm/sNVs2Q71C+xJkoQlKV1COTq2mCXeGAY3DitAVVwXUKDGfE+iWkuPFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553262; c=relaxed/simple;
	bh=sGLR8oa1wST0NBu3qo/ah5Ge3iLy1O0Brb7bC4eQAHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzVWT/pQqyhZWgWHxVVewe3LmrLE/MAFOea1zTiBkupXcWT3yxalD392gSa0kQ/PTtTtS/kPskxI2uGfLePhpIVVh++K1UIGfIJAtvjYp+GcTFlNVGNjaNuYzK3sxtfHr71gGY4m+gzxLdmW5liVvVsGytHlG5oELXtfVRpjgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7xnvo5B; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7xnvo5B"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37ce27af365so12553561fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765553259; x=1766158059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSprAmGQg53lcEJu0LGOuvGmI5ChoeYHCNbIXcAlyQg=;
        b=m7xnvo5Bamyzu6EJORkW51Lg2O+OZAiXoog71bU2FN0rVHG0Rd8iAqpgMkT4uVQaey
         njQvh5MsgcPu6ElWA7+GHCy2D3x8rd3DJSxjcMTTFYqQtVtmnJqPpdpUpqrvnDefBt89
         ajumh5tcXab0GoLLNjwa2Yi3NLaWXVJedQiNqDW+w+V2++AhnF8z9PGs2e2kYBpGwcdx
         4ZDNrhmxqouHf3O9iu/BcuA2xkVIvw13BUtQipzP9wfo0jQqYAWQT4Q3ND4Yd5luaWnd
         1il23V1kvv7BGU3SIUSw+0+haBeJ+oyhQ4z1KtZi12LyTCpZJWYUuPvPrJew+17lw/CD
         LeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553259; x=1766158059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DSprAmGQg53lcEJu0LGOuvGmI5ChoeYHCNbIXcAlyQg=;
        b=S42/EwgHljE90DKrlhUu4Cr7rCtgHtkXr3OSquFxbcSCefYhRZjWWUaJdeFCUuanrN
         Nbnvd4AyqL6VaaP3hMGPJOn+TfeSzNa5IT0V78WPYCP5dgc10gWNMzEsPGOVQNf4+mDn
         huV10VHyAkrZ6CZ7GFoyrbkHdZENsssO684dViIT8gkzdJEGkNC20JjvxE+08RbCuEHG
         HkhmfQvW2bQhYZ9ZyUGpzZeAYhwvzQMdkT449jVHlvnBvLK66suGfzo4qhkZbb8TYEU6
         snstZ8xgGZZc3U7W4+P91uLOm7+6wnJeKIcXHkJtZJIN5lnkS0AHnjC99p8Xsrx9qnLW
         kfRA==
X-Gm-Message-State: AOJu0YxQdyroSMbcXQtIOtSCaWeBreo0d/qCapJ6mP446ip7MLpPdE2w
	vOJCkp2XZB2arfBBX0gtL4eyv7u0PqqfO5pEqucuO47pwY70qNUSjceYiEL8ezqp71KktsLtF6m
	uol3guAHc6McW4F31Kw4TtlQp6BegNYB92dhz
X-Gm-Gg: AY/fxX6ld7rpLLCZggUxZbW2mJjAl4lvI4STa+Ru9NeH5Owlz/LvY11NA1bWXIG43UL
	bx2UpiGm4gq81AEfxemcVjOpkSayozUzvOYVUYt3nf7k64E7ynXP0p9Ljp4T3o0HPR2eyLbYEor
	v3XlrJr8tU2D0c6q2/GdybJhb/hQJQIkkmyNOOYLyzsSSMhRquNbROCNE2s4NPhvXM/AXAK6LA+
	JmI/v08vk55LOtUqfDPObbI/En9FWxYggcOlK8T0CViPdQA5KPNDJLphDZpUOEBMkr0Aw==
X-Google-Smtp-Source: AGHT+IEiNj6kYr8uoqdLNFn8SOtbYcE4F5Du66Go5co9NdbclVImpzSyeaGMkss7UbTCOsaZQC0bnFM9uaYedCM2obs=
X-Received: by 2002:a2e:ab83:0:b0:37e:8881:d2e3 with SMTP id
 38308e7fff4ca-37fd087e851mr6867221fa.24.1765553258549; Fri, 12 Dec 2025
 07:27:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211211356.3842264-1-mafm@igalia.com> <20251211211356.3842264-2-mafm@igalia.com>
 <CABBYNZKPn27zfKdRDSD2uChTB7eVaWiCKMdvbvvPGDwfBZmADg@mail.gmail.com> <5b33a4b7-378d-42e9-83a4-fe5062a04eff@igalia.com>
In-Reply-To: <5b33a4b7-378d-42e9-83a4-fe5062a04eff@igalia.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 Dec 2025 10:27:26 -0500
X-Gm-Features: AQt7F2pEQhsc92LgRtijahUWsfUQ-seCufA2ytEFiyLDFeKCm5wP0yKs2LcKgiE
Message-ID: <CABBYNZ+StSv0QpLpRcnf5vt0kWQKb6kd4k5ba38A5yBZkDzVTg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] Support for config fragments (conf.d style dirs)
To: "Manuel A. Fernandez Montecelo" <mafm@igalia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manuel,

On Fri, Dec 12, 2025 at 8:18=E2=80=AFAM Manuel A. Fernandez Montecelo
<mafm@igalia.com> wrote:
>
> Hi Luiz,
>
> On 11/12/2025 23:15, Luiz Augusto von Dentz wrote:
> > [...]
> > Great work on the commit message, really helpful.
>
> You're welcome, and thanks for the review.
>
> The intention was, first of all, to highlight and explain the benefits
> of this feature in the case that some people are not familiar.  My main
> worry was if you would find this feature useful, or not at all and
> wanted to drop it.
>
>
> >> diff --git a/acinclude.m4 b/acinclude.m4
> >> index 8046c9a7d..560a5d44b 100644
> >> --- a/acinclude.m4
> >> +++ b/acinclude.m4
> >> @@ -63,8 +63,8 @@ AC_DEFUN([COMPILER_FLAGS], [
> >>                  with_cflags=3D"$with_cflags -Wformat -Wformat-securit=
y"
> >>                  with_cflags=3D"$with_cflags -Wstringop-overflow"
> >>                  with_cflags=3D"$with_cflags -DG_DISABLE_DEPRECATED"
> >> -               with_cflags=3D"$with_cflags -DGLIB_VERSION_MIN_REQUIRE=
D=3DGLIB_VERSION_2_36"
> >> -               with_cflags=3D"$with_cflags -DGLIB_VERSION_MAX_ALLOWED=
=3DGLIB_VERSION_2_36"
> >> +               with_cflags=3D"$with_cflags -DGLIB_VERSION_MIN_REQUIRE=
D=3DGLIB_VERSION_2_76"
> >> +               with_cflags=3D"$with_cflags -DGLIB_VERSION_MAX_ALLOWED=
=3DGLIB_VERSION_2_76"
> >
> > Hmm, I'd like to avoid upping the dependency if possible, what is the
> > new function(s) that required such update?
>
> There are two cases:
>
> 1) G_REGEX_DEFAULT and G_REGEX_MATCH_DEFAULT
>
> src/conf_d.c:29:9: error: =E2=80=98G_REGEX_DEFAULT=E2=80=99 is deprecated=
: Not available
> before 2.74 [-Werror=3Ddeprecated-declarations]
>     29 |         regex =3D g_regex_new(regex_pattern, G_REGEX_DEFAULT,
> G_REGEX_MATCH_DEFAULT, &error);
>
> This can be easily substituted with constants (zero in both cases, IIRC.
>
>
> 2) g_ptr_array_sort_values()
>
> src/conf_d.c:61:17: error: =E2=80=98g_ptr_array_sort_values=E2=80=99 is d=
eprecated: Not
> available before 2.76 [-Werror=3Ddeprecated-declarations]
>
> Sorting can be done more manually, I suppose.  Some kind of sorting is
> needed to sort the files in conf.d alphabetically, to have control over
> what-overrides-what.
>
>
> Do you want me to iterate over these two things and provide a version
> that works on 2_36?

Yes, if that is not too complicated I'd like to stay with a version
that works without introducing new dependencies.

>
> >> +static void confd_override_config(GKeyFile *keyfile, const gchar *new=
_conf_file_path, gboolean accept_new_groups, gboolean accept_new_keys)
>  >
>  > Pretty sure the above is over 80 columns.
>
> Yes, sorry, this one and other lines go way over the limit, I'll review
> that in the next review.
>
>
> Cheers.
> --
> Manuel A. Fernandez Montecelo <mafm@igalia.com>



--=20
Luiz Augusto von Dentz
