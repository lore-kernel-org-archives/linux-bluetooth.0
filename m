Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8EC2E041C
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984302; cv=none; b=Yk0pDKpjru4QUwjYsUTFgRwKu3CitaWveQPEI8zCh9gOosCCEmq5/UfHjuowyTf5cjbl5WrFy7gVY8SsSAsVTqXgY2GmNLPUxAfqtZ1A2v2qm2pJNEl+Aaf5zao195F39TN651493c1DHbUfrgncGGaEDC5Z6mktwl+XZT5tZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984302; c=relaxed/simple;
	bh=aInJlA5ITRKIPcrYdFwwhJE4lxQnOEo8TYNhctukigI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSjJorrctD3MREr9MZMoR42AeyhpynH6lli0A3Sv7tr9IjryxpYQGySkiaUcXESk7WFqOd6ItAkd7YIjTSkJ+zVcR3JbQhCbczD0O79ZO/lxhi8pzZ569Dx57NIHuzSxCW/EVpQrzelqyqSYacTQHF9VtBcA1zdRSOWHYQ1u74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7J4JZf1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7J4JZf1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso3996726a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 07:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751984300; x=1752589100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUsZdi/Ic/TpLADi++riELfsoxiev6KNHSb8HqaIma4=;
        b=l7J4JZf1QdXBmZlpXcApm54Ju7gKwAApTz+17UpuRvVCjMweCx+hmDqufpsrh0TmYF
         KIitQdu3wZc80xY5SLpR+6Ck0GhCsfU8cKLKr99f6rU9OCL3CsFUTykHe8VnhqSm7aJz
         H52BzKbsxnOkhyKWupeyRxeYsXREMAdCvBaMvmoItWOdzizMCM0BBe1CfYcjq5kKSpza
         CpLWYSfi/UOu2hDRPl9VSshCpIIHG6mhzfnRxQk3yQbTIs7R7gHeAphTM7ZnCjrnbu3R
         oGxIBVGCBW2D972QdIZSJSV7km/6iQiPMXdiY4rhkH16kAv12OmmKcmQtyf7ZTN2vraT
         u5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984300; x=1752589100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUsZdi/Ic/TpLADi++riELfsoxiev6KNHSb8HqaIma4=;
        b=lIx92FW/QbCnG/nTHzpm9uqxI+xFjU7kufzCQfx1daAJYCEnl8R3EJRSIw6rrwTWDF
         7blmGnm5oeicOVSRwB/vwZ+pGx7xK1uSRSfINFdj/oZpy0yXJZ03CTT3hScle5M3SrZ3
         ISSxz0JCgm5A0NDkWGjrlyJk4y0WyjFuEIvs2DfyaoZacGPbwNHWbUS26Ct7xORhnan1
         H02byOmGG1yrTEt9uVi1P1awDaf00gRpaMdQnXQ2UmEuQ2GuCFBD1CqYBwlhjXbfXG+W
         hyVJWR+Tvo3ZcYLfSD4O3jrCsdRkWZ1zKR2SbvTTqSKgXQBfhmptgWJuOuKaj8sAOA7A
         73yA==
X-Gm-Message-State: AOJu0YyGBlwjxP8q+vOwhjNwikqCYPUplzniJILHk9pbYNMyM3U85Bga
	P+yJieZYeSbrVFGuBogUCAW/R9p0DgrFRJpLLud/d81BByZWD2tW1MmGZGlYb2g/8sKwG8xYX04
	RZy5uiAVdajj3TPszBJCqzFdIO9psoqH/LddS
X-Gm-Gg: ASbGnctjkySdJSuKXF+ES5p4HNaamzlLUhdfhmLy1qwfcD0xicWRuuMZwHlPn/9v/dG
	HHxsXyfs3OGfrLOnD7e7RKAMMUAj6pnS/jiZOO6EkHmFRfZG+kF6HbYAFX38HZpjHQ9iSVoXGzT
	LYrbxR59czTY7CEhtC7EbII4Q2P1L7T+dd4HAdUUI/JQ==
X-Google-Smtp-Source: AGHT+IEAQX1BfK/xQuRRYUF4uZF3ixyqr57HfVsonRBNgq9TTPj9iXablhHchCP0Lmd+vVk3aHQk57+nta6U09oECxA=
X-Received: by 2002:a17:90b:510a:b0:312:1ae9:152b with SMTP id
 98e67ed59e1d1-31c21dac882mr3733030a91.23.1751984299483; Tue, 08 Jul 2025
 07:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708110909.2626286-1-i.iskakov@omp.ru> <20250708110909.2626286-2-i.iskakov@omp.ru>
In-Reply-To: <20250708110909.2626286-2-i.iskakov@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Jul 2025 10:18:04 -0400
X-Gm-Features: Ac12FXwodhiyVvkbHX7j1K-TaGvp_scCQW4EhRdnM3h-E6Xhvt6Q0nPo01kIVes
Message-ID: <CABBYNZK0YV=4Z3sX5AN8kHtSw0A_d9+iPaR6A-wg1svQysiuag@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 01/11] btio: fix range validation of security level
To: Ismagil Iskakov <i.iskakov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ismagil,

On Tue, Jul 8, 2025 at 7:13=E2=80=AFAM Ismagil Iskakov <i.iskakov@omp.ru> w=
rote:
>
> Arrays inside l2cap_set_lm/rfcomm_set_lm functions are of size 4,
> but the bounds check allows the value 4 for 'level'.
> ---
>  btio/btio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/btio/btio.c b/btio/btio.c
> index b8afe0580..14f2b700e 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -455,7 +455,7 @@ static gboolean set_sec_level(int sock, BtIOType type=
, int level, GError **err)
>         struct bt_security sec;
>         int ret;
>
> -       if (level < BT_SECURITY_LOW || level > BT_SECURITY_FIPS) {
> +       if (level < BT_SECURITY_LOW || level > BT_SECURITY_HIGH) {
>                 g_set_error(err, BT_IO_ERROR, EINVAL,
>                                 "Valid security level range is %d-%d",
>                                 BT_SECURITY_LOW, BT_SECURITY_HIGH);
> --
> 2.34.1

Yeah, while this handles the likes of l2cap_set_lm/rfcomm_set_lm this
also would disallow FIPS (level 4) security, the right fix here is to
probably bail out with an error after attempting BT_SECURITY if
BT_SECURITY_FIPS has been given.


--=20
Luiz Augusto von Dentz
