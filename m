Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321B51EEA2A
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931820; cv=none; b=RsakIl2+nHkGIJrlz2iTGJlUxPsvGkcLRZ0DwEaN8L8bNEhFw2fokjipiVQ0E0bQbYFbIM1/f1MIO4l0ysEdmPSQJALkpxzAn4Ygca1HqGK3bV2ucf5VBF8wUrcNY7Sz1yRTUcQAJU5sP0ORTspckcVMbp9aiTl7EPhF+N/LF1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931820; c=relaxed/simple;
	bh=G6M/ClFzJNA7y80Q5RYdhX+DjQI4JZs+dKWUNZCVixY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyVFYel095+OlKJHSs+GW0JhhDr0GwKo00uNeIpbb06rBOGNWuGBbG5OMDl5DGTvp+R49/njGrvTLVppcsEWln4ozFLuBoABaaYx3MsDby3td8T2z7a7d3QCzTYETs0w05f/qA974kIuULtHRRAGZyyotWJA4q24z9mQzD1uhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMVVCne+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMVVCne+"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so61525551fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 12:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742931817; x=1743536617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vt2+afo5fPyg0HOfQva2C9Vb25E/nJRc6jDEb+ryV2I=;
        b=kMVVCne+KYEyINMuTBpMIrW8zq54x4GFkRwwot/JoMc6MEz3wu8bzfLR40rBv3oMtu
         ppQ8WlXVCT6PhTGinsvdGAZ4/Qs5n5EKU+AShgKFgt1rR1coCYtQM4CM10rKZjLYQQFi
         sbRxY3RNxGaAsrpQMxVdwR2rk6oyIHVnk3WtlB96UfF4GuxeVoFZX1uHwQ6Dzx6rpJtS
         2LWPRvOXS4TuRFxb6g8YUt2GVkfVAPMiZivodwnrWqylLhEF3PTLOzvmo/teXoMcwrTb
         rkYT8PMoW0Bu8dTmHFwZddXGG+AFslJqtWMlvpwQjFvJDqEZk0XXfcHnhAFAgvdx+MaO
         Mx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742931817; x=1743536617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vt2+afo5fPyg0HOfQva2C9Vb25E/nJRc6jDEb+ryV2I=;
        b=cFQh4xVNhu1ekf7zvFuNzWSLHQ2tYBpbc1C/njue0o8QZ/TM6GBmHL0AGofXIVFN1z
         5drJbK+CybB8OUuXyUlXvHqjeqj4GjOu5iL83x09dZ00zEqGfa2wWkRCzsMMOfzQro6S
         70+affhkkorrms5EpTpVQGOhtnUEH5DrXrWX93oEZR/8ECt8E0CBQYLri3p0mjWw1+WF
         mtxIg9dxxs9Fh2ffYb8Yf6fIhDDFDLrzmKytfFQp7uqSoQrovmMJOlKFXW2Lu2RKQedB
         EQMts41U5+NWzBOKl7+inn2+W4ZQGI2Bs0olIHQUFCil9YSayspeaEtDJiB+J10IlLyb
         pKgA==
X-Gm-Message-State: AOJu0YyBmHyv6UWddoegmKMtapG+iEhxzAye5m09STvn0o2HTn/ikB1y
	GcSwRbD1al8AspugECyy0OkWcQ5gTIRWE1ctQGUSlA9dkhctr9ccMT/P4Xd2DL10fIWKGMWHEar
	EyvlWBQmLmY78zHrTaNBjYb83zBr4DPK/
X-Gm-Gg: ASbGncuubSnTm6/tNS/j/0/qJzexSXMc/3w6Rw9SJcY/vMua7tCn89fCdv2Uy6uRfLo
	+bPDoR8GFSnLP2wSElbK0cAXFZQR+NbqpFoIb+q5V4hofuzMY3Z/mIa9mf4xJU62EOL+yyxEv97
	IJcSnkEBTHng/bAQOiujebSXxb
X-Google-Smtp-Source: AGHT+IHpUiKErcnESD34y9+qSRG7Q//ARVZ/h1PRVkb6owEDZi6dfFXHmqwsTwKaRuxUPNC9++Ea3EVxsL3A24YFHtc=
X-Received: by 2002:a2e:be0b:0:b0:30b:f274:d1e2 with SMTP id
 38308e7fff4ca-30d7e206838mr74727081fa.1.1742931816919; Tue, 25 Mar 2025
 12:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325162548.149495-1-frederic.danis@collabora.com>
In-Reply-To: <20250325162548.149495-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Mar 2025 15:43:24 -0400
X-Gm-Features: AQ5f1JqTSoTv9vYgaBVghBsX2_E_bv2Z6rIMIKEX-ly-FFOjjmQphmFbQJnp-aw
Message-ID: <CABBYNZK_jRJMONY93Owf3oDWcr-wM3q8onOMNS0nj0T3xmYvKw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] profiles/avdtp: Fix reply for bad media transport format
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Tue, Mar 25, 2025 at 12:29=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Currently the avdtp_setconf_cmd() fails to check the capability length
> of the Media Transport Service Category, which should be 0, because
> caps_to_list() doesn't add it to the list of services as it should
> be bigger than packet boundary.
>
> This commit add a fake Media Transport capability with invalid length
> of 1, so avdtp_setconf_cmd() can check it and send reject error
> AVDTP_BAD_MEDIA_TRANSPORT_FORMAT.
>
> This is required for passing AVDTP/SNK/ACP/TRA/BTR/BI-01-C PTS test
> case:
> To verify that the IUT (ACP) is able to issue a set configuration
> reject response to the INT if the format of the media transport is
> incorrect.
> ---
>  profiles/audio/avdtp.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 80fbe847e..67d32278f 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -1328,6 +1328,17 @@ static GSList *caps_to_list(uint8_t *data, size_t =
size,
>
>                 cap =3D (struct avdtp_service_capability *)data;
>
> +               if (cap->category =3D=3D AVDTP_MEDIA_TRANSPORT &&
> +                                       cap->length !=3D 0) {
> +                       error("Invalid media transport in getcap resp");
> +                       cpy =3D util_malloc(sizeof(*cpy) + 1);
> +                       memcpy(cpy, cap, sizeof(*cap));
> +                       cpy->length =3D 1;
> +                       cpy->data[0] =3D 0;
> +                       caps =3D g_slist_append(caps, cpy);
> +                       break;
> +               }

Hmm, instead of fabricating the capability, how about we pass the &err
as parameter to caps_to_list so it can be set directly?

> +
>                 if (sizeof(*cap) + cap->length > size) {
>                         error("Invalid capability data in getcap resp");
>                         break;
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
