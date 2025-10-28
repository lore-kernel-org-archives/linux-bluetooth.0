Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2D934A768
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673223; cv=none; b=sctK3WKN57l6bGxweLkFmaof+m2yvrAupxAYFKkf4A1WhNqxirAvBQDmV2mZPbtT1Xxs2dwYuNNJFWczdCPUFCfmibUkm6R/sNInk+RPrNLFSp1onpVtCzGNd3EMMtf++RrqdV5tvlNV0lVdSulH75ilGlsuhLEWtDVW7bEc944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673223; c=relaxed/simple;
	bh=aXUMeXzMr7+pu8Yf59D4UfcQD82Ccm+D67e+43HI4bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxo0ICrkdWvSLHTLwxJiW2Ek+wVvqvrC8+2DWoq46vBVlcO/i2uFqb4IhcpSA8EleNC/B9nfse8Enl+TDHMsVSr119JxAfN/BcqqHWQqdZ+sjrD9FXsxHMm5BJ2lXW9ykldMs3bFHRUoTpmVcXylmWCQclJkcF4gSkGV8S2kM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Jb7YK/tX; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Jb7YK/tX"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-378ddb31efaso74623391fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761673218; x=1762278018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1dDT+Kuo18gW/vAs5pcbkOprB45nObDwGH/xrxPOiA=;
        b=Jb7YK/tX/NExrWrnnfEsvBKPDaXpc/KVGXJh1wkHCo4Zfs/c/o0rSwNvp11ctUHn0m
         Y2c/NFQCsQQpy7HyA24SMs5VAkyjRHaVj6cx52it3B5UwRa5FwpvqMmGjS+BCtlukMfG
         Um6dQl8jszRUVksnp6ZuaksjsS0ApRauEtN2aUIeeXDFbsCz16g/8ARsSTZyfFQvQm0k
         rkNZxp7xYTscP6u9+d9+7qs1ITpxYc1tf60x/tHJHk6omM8I9vkni4qVhyOx/zWpj4cR
         w7GLMo1m8WVXIC720BeQ9aH/dSvIrJ7qvIjqHLbQPOL4qD4/C65l5N1hFAF8ScwUn8O2
         ApfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673218; x=1762278018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1dDT+Kuo18gW/vAs5pcbkOprB45nObDwGH/xrxPOiA=;
        b=uDjc5YC38M6e2QvUK1MaDinaqLGkkoweWWCt2V3AGK/8V775YHZyqATnE5qDZ8Sdyh
         kRqPXP936e4xrNc7hBVACy7fBnmrLFvnRtVDdckbl6O4RQV/8b24mKTHIJ7G1y+v/snT
         93RIXuPKWO422+YcrfRlpyN6LXtuajTMp+6bBXv5XzeX+0MjAK+CibLn3X51wgzYXl+z
         xtv5eL60UZlC+Pt59fG8myjlUXFuZfMBdijgeStati/ECvY1ABPY966w8Z4OsI1KHLhD
         E9huBr0ujAejuoUcyyRtDaWOixKJQA435zki+Y8UeRw9HEPzc9HtfGbpXIeid5FVViqa
         9g6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlG2D3adpkrX3IeYb6ZvrrIZCZW3DZlsLfaeTpnclr+j+/YYUZUxuiTvfBUMiaVm8tUwmOxutjvswVOOBN4EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3yWZWlpQbfpLff8Mbiv53+XAvQenfdQg5W9CKtK9O2oV3WBe
	AgJ1eDZX2EVGJp73bfQMktK0yZmBMv/KW839CLpZlzbGIUyeUoKQhJzSM0nSJT064cbIRs4vMbH
	AtdP1y/12LscKKpZZqbHXgFiASFoX0iQrW5gWmQGaTA==
X-Gm-Gg: ASbGncvy0e2s8b8CIhGTnBnG9B4n0nhOi6ta4y3GcCqTywU180HSdnI5Jyh9XrOzku+
	13EXmDObyBI0rUElc/UMblsjCUtopd0VNdFSKzL5HEAyINEptJtXBa0Tast38e71zTXQniEVH7y
	P0sk4yaEcOQ3WLowEOZereflcMD5eqc8ZB621fduXj3w8dxQfPVBbVzUXRENg/SN9BMNaGWyQGo
	KgZk/+qySIVUQjhJWG7SGr/FbcBnC3JNkq8VK9qrgTn15gR9zgvqvkpPCaeEXaNBBUmjowRbZTy
	01QE6vsb8o04Ujy0Z2H4Zan/AYI=
X-Google-Smtp-Source: AGHT+IFNOY7fS5NXoOFhyNJtmea1wSytgnH4oBkJVvZ9r27nhCdq6OSaGfOh73lSEWuOWGB7Asbt73QW9CvKZgTz/nE=
X-Received: by 2002:a05:651c:4347:10b0:338:10c9:5871 with SMTP id
 38308e7fff4ca-37a052c83admr689201fa.34.1761673218316; Tue, 28 Oct 2025
 10:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028155320.135347-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20251028155320.135347-3-krzysztof.kozlowski@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 Oct 2025 18:40:06 +0100
X-Gm-Features: AWmQ_bkhwYP_3u9-JoVziAs2Bk2afMmvyoh0mwlsnq_68htCAVlTBlNvVkP6s1g
Message-ID: <CAMRc=MewE_wRrKsbo94GuwrO2D=1L==3ceJBKXQXvLgiqhd7Dw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: MAINTAINERS: Add Bartosz Golaszewski as
 Qualcomm hci_qca maintainer
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:53=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> There are no dedicated maintainers of Qualcomm hci_qca Bluetooth
> drivers, but there should be, because these are actively used on many
> old and new platforms.  Bartosz Golaszewski agreed to take care of this
> code.
>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Link: https://lore.kernel.org/r/CAMRc=3DMdqAATOcDPhd=3Du0vOb8nLxSRd7N8rLG=
LO8F5Ywq3+=3DJCw@mail.gmail.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Changes in v2:
> Don't orphan, add Bartosz.
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8abdc0e50699..8a2c5fb0ba55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21145,6 +21145,7 @@ F:      Documentation/devicetree/bindings/net/qco=
m,bam-dmux.yaml
>  F:     drivers/net/wwan/qcom_bam_dmux.c
>
>  QUALCOMM BLUETOOTH DRIVER
> +M:     Bartosz Golaszewski <brgl@bgdev.pl>
>  L:     linux-arm-msm@vger.kernel.org
>  S:     Maintained
>  F:     drivers/bluetooth/btqca.[ch]
> --
> 2.48.1
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
