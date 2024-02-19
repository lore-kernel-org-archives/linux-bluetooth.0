Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2222024A0F
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Feb 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708329430; cv=none; b=vGo9Tj5t6oEUuGEKt/y9zVf7udtEj88bX3SSnBeS3QRUpYl2MRKfDff0EWuj4tjoQ+rGHicOxWriWwgQzA5OiKCX3sJzaoEgO2G1IpeiWAt+lNCRVbhNXr2HpV1bjVlH/sDx5+VPShpfi421CaLnS0GiNPNYb6obXqxhRJ/XiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708329430; c=relaxed/simple;
	bh=Oey3ZN4EIWUJzNAo3Boteeg+KwnzJ3oRelbiZ+NcSGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfNKy8caznDmOlZ2dB6/hS5kuB66ExcSehxAERxfVm4Cm4s1JID7wyJxt3IROZR71eJVYU7w2W8mU3p5kZuAP8+u/aUulvn7ySOl89ynXvRQJ53QL6xsEV/QD+mYiyHfDn3425RjigexYamJObvb21K2BdHMeO3r8HCG7xRWsWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VVl8JQpi; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VVl8JQpi"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d6a85586e3so1791944241.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Feb 2024 23:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708329428; x=1708934228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oey3ZN4EIWUJzNAo3Boteeg+KwnzJ3oRelbiZ+NcSGs=;
        b=VVl8JQpietD6ymCw8P666kr9JYEJOP/6jeXxWYk9wcv7MiDlOZHDq7j78X8ip5RtIL
         oGOg9zYfQV0Sd4wVp+AvOhyd1zR/usG2RKVc8dc9MV8tXFrH2CeZQ0YWWa9evUyQJQ/s
         drcPWv7qhkki+1T1yyXOIwpaLakGZoChRSfvzccCuQY3XjVtz7jCXViDDBb1vrPa2K8Y
         +EcJXvaxSF6pM2Uk9/oetGyr/zPuk4PGPok/1+mdFuioVNYGLnilS9zjbbOY1YFcZHCB
         B15hP2Ev/V3gsUF7j4dhNYeKiiKrTNge27kTORfRqqI7x30iJgnGqpsogtpL9MH66rbC
         tBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708329428; x=1708934228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oey3ZN4EIWUJzNAo3Boteeg+KwnzJ3oRelbiZ+NcSGs=;
        b=K+pjNOzXIgOC2q4SFrHFDhcVJ5eLlq6m3wEVv91z3jqhkucD1vUpc3tJbaPIzV6G57
         WjJcE6mbdBRdMf9CIj7r3rIub/f/pDorXIt5DL/+irG6fuaLUy41/8CtLm0g3zXOP2ZJ
         GO8TeaBL9x/8NDCYsKfj7boSZUOMH1gv7eEAHQgOFSysXVZ1gWdpDI+/O4Vt5cp5ER92
         fPU76U/V7qqThqzLnyJcyxm2UdNsjZyHOmIMJNUVgnVaeoXyFllNibP6J9rNfpU4xTa5
         nI9CEID/uCbanUR30YNk8yGlV+0T0KGVgkFYmrjtJuTv9wMSKazI+/yqQ9H44BQ8yc/R
         sZXw==
X-Forwarded-Encrypted: i=1; AJvYcCUwjuZjkds/hR/gYmBsJb5MI6rgetdAwscYFFLJMByNGDRf2aCud+jJKAR2zBKM7FwcoOviyc01Ek9G5TiJdDO3hAANAqs7AELLwGUO6UIk
X-Gm-Message-State: AOJu0YwPcFyqYHB8yvi+EgKvZbxtVO+f1wKBpGCiR1+ogqONuzPUxOym
	66i5wGorFuiLiKT31YBRgS/NcjYEleKQpuimGk7v0fBvsE4ryyAXWNjvIJa545xSTS/RuTCAgjy
	gkML4MOoZ7eO+2bak0yoojTomBDD8lKOneRMnNQ==
X-Google-Smtp-Source: AGHT+IGkQijUvXHSNfPb2HxhHlZq4HKDdG92W7zvsTAzBpVd1PSmvpJBFeiTOYN7sqVAKs/Q5f+Y2wj1Qp78qPvhlpQ=
X-Received: by 2002:a05:6102:409:b0:470:4cfa:c814 with SMTP id
 d9-20020a056102040900b004704cfac814mr2022895vsq.24.1708329428140; Sun, 18 Feb
 2024 23:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-3-brgl@bgdev.pl>
 <71e9a57e-8be3-4213-9822-45dfc5eb7ceb@linaro.org>
In-Reply-To: <71e9a57e-8be3-4213-9822-45dfc5eb7ceb@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 08:56:57 +0100
Message-ID: <CAMRc=Md1PzoZFDWHWRufktmMiBE0Dp7eYhecpwuaS3AW-Y_g=w@mail.gmail.com>
Subject: Re: [PATCH v5 02/18] arm64: defconfig: enable ath12k as a module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 8:31=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/02/2024 21:31, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Build the ath12k driver as a module for arm64 default config.
>
> This we see from the diff. Please tell us "why", e.g. "Board foo with
> Qualcomm baz uses it."
>
> Also this should not be in these series. It only makes the
> power-sequencing patchset bigger, without any real reason.
>
>
> Best regards,
> Krzysztof
>

Got it, I will resend it separately.

Bart
