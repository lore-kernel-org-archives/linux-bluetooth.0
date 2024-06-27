Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8B613C3D7
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513207; cv=none; b=J4J381gFI4HZVTmwdDb2Ml1KID+YZZZDN9PCP61gDq/ED/4u2Ni4haufveUhc94QbMk8lpdvCZYKeckxPpiU4VcK2nf7RveFyd4C7QG5BzoL7H2zwxH4vdOID5p1kYmdvGaKO6vFu0qv067MHnheB0HI688V5FdaIEnNqQJXgos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513207; c=relaxed/simple;
	bh=PaiDuqYH7FQkHk5ZR9Ae7QnMexaA7cZaAf4yxcTq/oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaZfT1ndH4rVeEJA1N/7Y0k8cMhzJM3qa3fVACjk9HzKTww7ZtFjrUP7UP5ZdiKyDRGMBk6msImVh+fem78b/YLCgMD76RKGidiWpZfbwnZFggjv5Ex7O1SmrMIJoVyVPYD8FVDkMShYTFHFC82M/PFY2kjTwRYyYEgdyRf9m0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqmXFtOU; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqmXFtOU"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so10259091fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719513204; x=1720118004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwOrWK3cFkoMNu6Qwr65W7zjOj8enD5bXx7Ny38Iu8g=;
        b=aqmXFtOULf9Pu6tTffl3Mw/LN6vK5RwxxlD4bvIpLBMz6qtZ3iYs8IJL8xfaolNnm8
         CJKMV4+f+vXluu7jtcHoORNH1a5GzqUSUhqD6DOPWT+kM6Pifw1wdSvPLQtkw7JNqTiL
         BCVIxcQZq9/cg20Qs1TxajJOgC4RTz5N3nxoIam5bcjoeJY/tiyq1h+WBZL6f0uNpSmQ
         LMp4ZG0yB5opO1gTEf4qHRV2NBRVAu/YCkqPz+UM/fHquUgUWDmlQJaUt2BkUzYw0n6o
         32ajMroiHDE29IcPuaeokLJuaNGgaxUXFlnAcd5N+ix4muToN9TG3IgZE4/AvH/0YYmX
         oIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719513204; x=1720118004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwOrWK3cFkoMNu6Qwr65W7zjOj8enD5bXx7Ny38Iu8g=;
        b=k0fD/Newv6uWwOn+iOgcTGjXpyaC6fViWiAKLGoL5LX07hQugB/ZVy8kKsKmlWtOvX
         aZ4oeI1JdAnRw6IN3CLVf/Gh18k7eZ0himIf6kh+rb5/LyXj7nNKYLL2V9zNs37cxtVG
         jpXIHseJXIdBhy3gv+N/2E5Bqgsyu78JXaq85AFgj5UTNe0FFOB82r9WfhBDldzEKk/f
         8IoiJ9Dt/JflRQXiBy+shYVaNRavbeKk0AgrBtoTMTIoyTJ52jYqavrdciwGPTS5B4od
         ndt/EH+WjSvav9a6/yBh2rzHqORa5FPpeNYQnOv9fxjY5OhDvkVrBaMyZkWg/0bQyuRb
         74xQ==
X-Gm-Message-State: AOJu0YzkvfS1azEN2n/iUhzP1ztvBBVAw4uB6G7HOE0xhhcK+UbOLZHB
	0Hzi7teMxBaEgnouJ24WHJglZeZh25lAT+P39YZnAzUDZZ+USNmJyY0lzlZKbF5htx6GvfEzY0M
	si+o01kj0QkhseIgKyyR6W03ieUQ=
X-Google-Smtp-Source: AGHT+IH/rmV1EDFS3ITMbBn5hwm1F6PkkszrnhE8LlG6iknadSU29Egl22lkR3pjTopb9gN6HLjdv6IDUdNPDyucMpM=
X-Received: by 2002:a05:651c:4cd:b0:2ec:6756:e3e7 with SMTP id
 38308e7fff4ca-2ec6756e51bmr100265551fa.40.1719513204113; Thu, 27 Jun 2024
 11:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627091628.46304-1-r.smirnov@omp.ru>
In-Reply-To: <20240627091628.46304-1-r.smirnov@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 27 Jun 2024 14:33:11 -0400
Message-ID: <CABBYNZKL7JP3rJsnjkRFTeOjrSyKnfmeoOHXXSoptFFM48DNnQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] profile: add NULL check to ext_remove_records()
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman,

On Thu, Jun 27, 2024 at 5:17=E2=80=AFAM Roman Smirnov <r.smirnov@omp.ru> wr=
ote:
>
> Add a NULL check to prevent dereferencing a null pointer in
> case the adapter is NULL
> ---
>  src/profile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/src/profile.c b/src/profile.c
> index c62224af9..bb988e8cb 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -1507,7 +1507,8 @@ static void ext_remove_records(struct ext_profile *=
ext,
>
>                 ext->records =3D g_slist_remove(ext->records, r);
>
> -               adapter_service_remove(adapter, r->handle);
> +               if (adapter)
> +                       adapter_service_remove(adapter, r->handle);

I'd move this check inside adapter_service_remove to make it safe to
pass NULL pointers as adapter.

>                 btd_adapter_unref(r->adapter);
>                 g_free(r);
>         }
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
