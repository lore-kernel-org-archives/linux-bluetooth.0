Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602D8299A8E
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251247; cv=none; b=VWfnhXmTzJX/C2LtDlmpq7MUEudchekWYEbNvJS7eoR0VTGKFDG5i0pTrKRNplu4qXwner6jkLGh7XRSLL5dWQrIMrp8TUclRIMjgizsEvURNh6ywwF7tEATHH0lsa13AQbN9Clsb+H00YqygVf+hthF7MAT1V2XN23u2hKx58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251247; c=relaxed/simple;
	bh=27yd/l6012XaQH/g8Ixa+D6cMcVdfn8d9/IVn2JOVCI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dm6KFixQnxaDe7yxwqjmykf6mBkIQR9d4wX5UZotPqN6NhdEtv0uUah8EDjMYHykr0qwkRaDeCmQeTsYF6wUPnKm1b/Ge8y7hackMtqnlQNLakToamx+bqk0DiFwLt9qi8KiGLA5ZC84QuYBctlzdWSZesUjd1VM32RBhILhIRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Mqi7wt8o; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Mqi7wt8o"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5943b62c47dso816030e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 05:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764251243; x=1764856043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27yd/l6012XaQH/g8Ixa+D6cMcVdfn8d9/IVn2JOVCI=;
        b=Mqi7wt8oNrr+2+e4XNhQBFHjbbJlNk2prXtZZdeiWDpubDuSNPjtqVuc6fFI7gQTNW
         vlhDRF8Ikv07ZhquMqzkqlRbUqUBvhhznOF0yf+VzMxYMKnOLOCd6txDRXhkTGnAwFfn
         9q/AFxkcnrl71n9rhoZuu/08jdMh/RFnG0Cl63G8H+FblB9m8ujHai9LfGR+WngJj2Dd
         TjMLWQA1KgMyWpako1U/QHpPDjlp8y4V15h620/0cvt4YsBCRXEygHzP/Lbbhj6NIsYB
         DsZitljR6hDpZnbRH3U5UlgO5Ha0pWvDDCPBmOt/Z+Dos4I7Or/n2AinAFdgzuAfJvVY
         hiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764251243; x=1764856043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27yd/l6012XaQH/g8Ixa+D6cMcVdfn8d9/IVn2JOVCI=;
        b=SMBHrny2/cWKJSvo95Y6ga4Go6xOOBSIBMitsKSnPQ49UcanAf016s9++A3lJ7MeKY
         BpKXubX5uLgrhVb6UKxqx8qFg4jEGSoNPyubnPrvtsi3HkT6emCznVf3o4aV0NQ9E7Gi
         w7jodDdfBpPojUGTi1a+Be3XLXGNIp0o4Nc55fIOR+apkrglHpgdQTaY41cBMlI9ADwa
         xnQ0chZbm8Nl0SdUMgvI4v7QIUjOHysZBZz0h2psA2g4N+QzFvSr9y9gUCiVJaGK5Vlc
         Gw7rG2/sIAeBI7EIk+pbnLheqTOow/uQ01rpOgiODpRVdP3IQXghMh4yBa+2L5RYbT0Z
         9yOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFM3BJN6RXIsGlOf6fdQcgh3T0yEfG6lk73RPJKbcj+Y0vw0VuwsATHxrsyLoDrfU7Q+CSqqc79kci+IVpPlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypNeuXAclOHGdBa/oowQb7+6nF+NrUNdN1JpCeDr4VS/S8x/s5
	JcCDjmN5JxzZjITO+X+ozwEh6w0MhmX+XDaHsk3HuHaSBXI09xj7KSc6PIyv8JCim2lV7tt+gFT
	E0nyCbCqNqdgNP1RVOdF/WOgi6KTd1WBVKszGnrXTbg==
X-Gm-Gg: ASbGncs4tUVGl1cO+1K2eokoRi6y59LmuFdwpbBq4JZVnzgjlCGlhWc1oiwarek8HEL
	t5QA2txwu5Frv4dUvLzTCWVizYsD/8u8Fe8hbEjoyZC4WeM+ms4EwxBk8tx3uvXbNZDPgu+d4Re
	jZ3nHO/0DX1yXb6BOuLHvDPgXXGVdHoOsFvlA9mZfiHvYUGmnCblVuj9/HJhOOTHYEOXSm38S6a
	jQNUdZNuDGCAzV6FtmETxl3hoMApTnTjFFJszq4OguGwar0rylAEw9lEDrMiC1kwW0iMwyrhU9/
	HkfcY1Hi3KyAIxt28HP0L1QeUg0=
X-Google-Smtp-Source: AGHT+IHIByvzTN9XhwquV0dZ7CSOzT2wtZW2aRAexw9uGkGjWx9uXnsQQnkc0lHm6G8MnJ63g3o+AbKWIIpqZ/ETI6E=
X-Received: by 2002:a05:6512:2354:b0:594:36b3:d1f9 with SMTP id
 2adb3069b0e04-596a3ec4221mr8118131e87.25.1764251243268; Thu, 27 Nov 2025
 05:47:23 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 08:47:21 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 08:47:21 -0500
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251125-pci-m2-e-v2-1-32826de07cc5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com> <20251125-pci-m2-e-v2-1-32826de07cc5@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 08:47:21 -0500
X-Gm-Features: AWmQ_blvAAM2uq578ciPVCG4M9rg3fVM1qAGhRvJTTtDZYm9qOnYz1mkG_i5iVY
Message-ID: <CAMRc=Me+mWYaa4ZKTmch-NtuvP-2ifbY1Zwi9E9KMyUgFSt0fA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] serdev: Convert to_serdev_*() helpers to macros
 and use container_of_const()
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Nov 2025 15:45:05 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> If these helpers receive the 'const struct device' pointer, then the cons=
t
> qualifier will get dropped, leading to below warning:
>
> warning: passing argument 1 of =E2=80=98to_serdev_device_driver=E2=80=99 =
discards 'const'
> qualifier from pointer target type [-Wdiscarded-qualifiers]
>
> This is not an issue as of now, but with the future commits adding serdev
> device based driver matching, this warning will get triggered. Hence,
> convert these helpers to macros so that the qualifier get preserved and
> also use container_of_const() as container_of() is deprecated.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
