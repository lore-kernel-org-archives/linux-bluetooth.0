Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF4258CE5
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986777; cv=none; b=Me9qGi01shMtTn4YAdVg8ros0xxUp7hWX1SSU415g7/cs1+N8gFnaeV88uPlEknagiR9jZHmsftjzr05bNt75bp4hH989OyzCovwge0n1TYG+zcwnbbXWj/wl9rFPx+xKXElQ/BhKVcaqaIx5ibiqA2IgbiizrXso9L47KFsCvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986777; c=relaxed/simple;
	bh=E1l4Z9amdQMWYcbg4lSfwrRpkLs514Ia4SyMu4JVrjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7lJQQikW7SZxP4VPbb7wFKeVhwYwMRon5ffMmhzM4BbnGZ3aNrg4pVA5x7aHabIz6OibbvDapv2oqgUMs9+3R8cCvDao1hR9lf53zpLLg505rIpVKX7u1lLKAqU5qF+9Vs9LE0hMPPLqKxt9O2yvesT6mGmkuTdwXG5iB/rV5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0YYFHil; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0YYFHil"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so3389219a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751986775; x=1752591575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2I4ULWa465J1Xdwi7M9CZ2G9YjObdn2beAuQ2uqhUY=;
        b=H0YYFHil4HMsiwO6WV0MbafSaWZbnRT/WMZQ88VNaJ0PCxYBrYie3cNzLmDe3/rSqF
         6LJy0isIK9XRBwsqXNF/ZblSYkuuZrvos5VufR2L9oq0vtM6J+EemlGYACwcFChb8HP7
         aaEvS7sky/mK2P/sdhkYv5ZakSxhYGJtkpTQBhkAW3TjVHfQWtR2J19FQIk+2LAGHtBv
         i7GpHcc3nnSYYqxu2c//JKwAW56/df1P+p3hBfxkd46GOaaU7r0nWgDAWAEa7DaLSX6H
         h2FhvvSsGYQa9g3iNeSZu+vfaiDwP6p7B6XmiSwJGgDoZgQM6KReCWBXjoTfOKf5uIXj
         iwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986775; x=1752591575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2I4ULWa465J1Xdwi7M9CZ2G9YjObdn2beAuQ2uqhUY=;
        b=YqulLjCNwPlBJI4bFEV+LTc3U50iL5wEcJ1AnCCEEPflrBmMF80eNr1IAhI35iTF6s
         YKgHEfRLfwaimuWz6IChWLexKeytHmcilb/QkizD7T42+TR1ur8vm93gsQKa24liTehs
         cAt/5N/yEo5Rgu1+8wfCVroWmCiHEJDYDyWKcZ3dcUUMB/55any6D8Zz8IOCj4AxNAiP
         odmNsinSMmSAcYtvJ5TJlR8baohh9sbGXiJeVm+abnnWC4laedIie6lRzOT3VcNq4bIs
         S+eYzX6mzqT6Dlj8+piBfoEbqv+Q0X2xn7CHGAiMKPoGDfdiZMno9p1xU7G8Vxvmzu1p
         HMiQ==
X-Gm-Message-State: AOJu0YwjA6nj62PyXXhsSQbMFkp0EzvuYAQj6HYVmnhiufK30hLC7QR2
	MT5EU3/ul1Z7qiuKUKWTa60FEPagnCqk9yLqHZkNboL5K6F9m25Ehluxv14Lk/3EcWfoVMQOBhY
	zwFzJ6GpgTJ+ys5BjE00BGFov64aeV5Sesg==
X-Gm-Gg: ASbGnctWZoAIfNG2DZ31Xlj8/lAhiGg4mCic7wWByKdKgi6FhHR4+GuR2BEqEayZvrE
	QK+2CL8WuGSgbweHN5O5FhS2Z6G6RCIrhakfYSq+LWdtRzev/hPJOYUt/BB+QbGhmWv+G4ZQ9lt
	OqcbbZaNX2jQfP6KuZEHLyhiu7AvTVlLopEDv7IYfR2dK+9TRss8Jf
X-Google-Smtp-Source: AGHT+IGhWYVoPE2ppDWDpyYB2qlgrz5HYsF6mJ5sFqIBTU3il7CrWVjd6d5ON3HUYkqg5AaZXz5ROLM/mXle0E1c+aY=
X-Received: by 2002:a17:90b:3804:b0:312:da0d:3d85 with SMTP id
 98e67ed59e1d1-31aac438684mr23454678a91.6.1751986774900; Tue, 08 Jul 2025
 07:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708125947.11988-1-ceggers@arri.de>
In-Reply-To: <20250708125947.11988-1-ceggers@arri.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Jul 2025 10:59:20 -0400
X-Gm-Features: Ac12FXwdLIKFKygyKuv3Ho3pF3r-VnYqGftDgIH0Zs6gM67py2dLLYl8BjthyG8
Message-ID: <CABBYNZ+FuqRN7v_bjjHTnJNvj1FM-m7d9BvyVKpsgNrmAAydxA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/15] mesh: crypto: remove dead function declaration
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Tue, Jul 8, 2025 at 9:15=E2=80=AFAM Christian Eggers <ceggers@arri.de> w=
rote:
>
> The implementation of mesh_aes_ecb_one() has been removed in commit
> dfed4839463f ("mesh: Convert crypto to use ELL wrappers").
> ---
>  mesh/crypto.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/mesh/crypto.h b/mesh/crypto.h
> index 55789886eb0e..3d85785f174c 100644
> --- a/mesh/crypto.h
> +++ b/mesh/crypto.h
> @@ -22,8 +22,6 @@ bool mesh_crypto_aes_ccm_decrypt(const uint8_t nonce[13=
], const uint8_t key[16],
>                                 const void *enc_msg, uint16_t enc_msg_len=
,
>                                 void *out_msg,
>                                 void *out_mic, size_t mic_size);
> -bool mesh_aes_ecb_one(const uint8_t key[16],
> -                       const uint8_t plaintext[16], uint8_t encrypted[16=
]);
>  bool mesh_crypto_nkik(const uint8_t network_key[16], uint8_t identity_ke=
y[16]);
>  bool mesh_crypto_nkbk(const uint8_t network_key[16], uint8_t beacon_key[=
16]);
>  bool mesh_crypto_nkpk(const uint8_t network_key[16], uint8_t private_key=
[16]);
> --
> 2.43.0

Is this set just a cleanup, no logical changes were made? In that case
I can probably go ahead and push it myself, otherwise I may ask Brian
to step in to review.

>


--=20
Luiz Augusto von Dentz
