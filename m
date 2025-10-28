Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258393446A4
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666199; cv=none; b=ZOP20SuByQSUr59PKqFdoKneSWZi8n2jAcmQbAQ/s3Begfp8ohm6nGh1bhYXtIGBIjAiURTuUlAgEOHEpVINa777PKp+RoD4Brl7kBNryL5Zb8aAFYhGqz6wk+aVipmihfgoqJDmjObuMhwh7qmzGhxkM9w1o/S27Onrmqen3CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666199; c=relaxed/simple;
	bh=p8N0VHY2XpMh/L81W8FzKQHWHJk+NmZNjv7GuBCqyQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThSWXSmR1fMb/5saxN2aj+Qyn0EP+IUIlJxa8IUhoKQj0NOKyAkoJpFz/rU/HIUnxaCOUJvt4Cb9h/lNKsofrVf/LhUC6lW5dT1eH/05JyBnkdrPeCjwIAYj2xZFiqHltvuEnTCL1loW03OyZRyGcoFQV6CVAL3Lw6+ud/rS3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QAo1aAxZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QAo1aAxZ"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59303607a3aso4195147e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761666195; x=1762270995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=do7MuCP88nOM3eMBQKiSZ63kBzTalMH1rd1ZJUZo3vk=;
        b=QAo1aAxZSd6Ks+bc9pHitZsx/AWtU6w8sCK6tFgNQzQ8xXmb5yWpSCSOHbwEulpVfR
         NOGg+s3J9gx2rEi7Q7HWnTA8+JaFQ7bG0bQnk1Cq5OaZeMQcAU2obYscnNveDe8s+GTq
         2VMoZyOiqfyXLbZL1xADOxFnnC46fwjo8A4dm1O3b9niBk/cxiqQGTitv6jYi8blzMK3
         mpsTWT943/vPdpdz0qJNG6xp20Dl6/X+eyzL/Zuh5NS15ENTy20oj/IjcyLLezG30XQm
         C1cTTTgpA34A8R+NxHE19j2zvNwnXgNmTKosToawguqlzlXHKlNt/hz1gSSUU2USY4HQ
         x9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666195; x=1762270995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=do7MuCP88nOM3eMBQKiSZ63kBzTalMH1rd1ZJUZo3vk=;
        b=iL6joj4rowwXRDB3AxQoHj2MhCeSgbBdmvAC8dhJWc16iM0ARYHbHo2d7N07ZIIOkv
         PDQH5shqU2pSZmnrL+6MrmRriguPHwAIqD4xG4x311BW8sR94P3ec8sx14yUDVtbzCh4
         KAlGYYMzRQkLxhVFl/0BuKAXkfVyg6HNGWAUVT/tFHrF3OUELKrCZjMTIeMTm0Hb2UFi
         wbEpK8mRK/3cYizjA+6+6OqEsETrO0h0ThAM/Q7+bcA5IfxEftABO3nUwP6y4LxZDsfq
         a7cLr3fJ7omAaK2FXg8KhII8d0Lh9kQiL2ZIE71sDS5TzYZDXN1tirX9Dzi367qrRr/C
         b9Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWB6inbYVXRZukMMj0uMofmz+J70cH9d0492FSeiQJlv8KjYEoVy39Lp4hyuo9APUcXCMb5fhBVHqveymLf7Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFtLvJqUOFGkQp+2XHAQ8eXDH3oLqVjYBQHfEnf7ePO6GrymEi
	dqyB935nL4i7/X4kdXTDQZ6bYYiW3tdACMKByGL95scE1vDpSv33WGucadoYpI0h58dbfmlJIya
	z7wkwGal4LlGwZSHERYhjW69fmewHlaIYuwNj/pwiiQ==
X-Gm-Gg: ASbGncsNvRqYf6krZtWk4gs+QWzkN+ouATj20y455YDnys4LVOhh4WRz3Zyp7c2WVYp
	K9f0HkhTYXNQ0JkkkJMaoFNtZ4xOZ/uyHlVX3/4Ml0t6Zajk8e1pUfwakJZ7Z55NQsElhvV7dze
	sxxvyKJKaw9DHkiro7k7DN+7QT/RCPWlq2A7kTRhWajdzZpoIDQ9M/1qyHDytwbQjlU3xAUGz00
	SFNe5oeLYzMl0crRzBeqNYmuFVqJ/hTdwaDdQWLd0MbJ/x/V8a8jvSR7QLYvcFtIQVLgBed8Gll
	bt1hwpAJWlIb9xhU
X-Google-Smtp-Source: AGHT+IFTRBGcYDkiyCueyH65DwGrBfpjtYBktHnpsdJL9xh5HvsW1ijkB+8miiiXsCQ87IK4j3035BwnwPw7l+jO6Uc=
X-Received: by 2002:a05:6512:4027:b0:592:f766:a49c with SMTP id
 2adb3069b0e04-5930e997932mr1316517e87.15.1761666194042; Tue, 28 Oct 2025
 08:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org> <20251028-dt-bindings-qcom-bluetooth-v1-1-524a978e3cda@linaro.org>
In-Reply-To: <20251028-dt-bindings-qcom-bluetooth-v1-1-524a978e3cda@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 Oct 2025 16:43:01 +0100
X-Gm-Features: AWmQ_bmGdgwF3B9dB_VDDUnDofSCXpuNVCFm0vFH9VJDj6OZrO0qPdBbjuGlM8k
Message-ID: <CAMRc=MdqAATOcDPhd=u0vOb8nLxSRd7N8rLGLO8F5Ywq3+=JCw@mail.gmail.com>
Subject: Re: [PATCH 01/12] Bluetooth: MAINTAINERS: Orphan Qualcomm hci_qca
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:33=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> There are no maintainers of Qualcomm hci_qca Bluetooth driver, so make
> it explicit that driver was orphaned and no one cares to keep it
> maintained.  That's also indication for future removal from the Linux
> kernel.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8abdc0e50699..be637b9dc7c0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21146,7 +21146,7 @@ F:      drivers/net/wwan/qcom_bam_dmux.c
>
>  QUALCOMM BLUETOOTH DRIVER
>  L:     linux-arm-msm@vger.kernel.org
> -S:     Maintained
> +S:     Orphan
>  F:     drivers/bluetooth/btqca.[ch]
>  F:     drivers/bluetooth/btqcomsmd.c
>  F:     drivers/bluetooth/hci_qca.c
>
> --
> 2.48.1
>
>

Actually, I added that entry so that the arm-msm list can get Cc'ed on
patches. The fact it didn't use to, caused some regressions. I have
done some work on it, so I can take it over as maintainer.

Bart
