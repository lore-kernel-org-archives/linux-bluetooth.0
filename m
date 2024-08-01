Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126BC13C8F6
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497994; cv=none; b=JMtr5xN0CamnUerUg5vabXZf/b8gIkjlXLiNegVLHBurPz2w7HiMuCJ+53S6kh2ZeCC05Lz/qiCeJdQlg25FUUWTZsJIc0cLLZScAJdpijtvFLu2mndcWEyC7rs2vprwDQ1seR4ur6YoKFG5v4IkgyxyMAkij9CxPucC/Dj5bgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497994; c=relaxed/simple;
	bh=gIcMjbI6VaWGNnrJ7Y5PhRPoOIc4c0LKQ9pr6msR5bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ulhe+In+lx2t3rbaaZtLxueAgYR4zVgKRtRIALeVNxCrQ7Ea/TZ0+CqAt0hYjPxRjhosJodMmojAHidF4BMa7wfKXTz4hnv45ff8VHksWSbMtOSRt/36Tc7Cph0EkU2Ws8hajcHno9KmtUKNA1WGK6xo2UH2EbqLDoQEkAbcE9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=r1slnntt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="r1slnntt"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so9734844e87.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Aug 2024 00:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722497990; x=1723102790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIcMjbI6VaWGNnrJ7Y5PhRPoOIc4c0LKQ9pr6msR5bE=;
        b=r1slnnttOhiEgMvH3qPcPxvnBJd8THdcNDevn8YoTvuJfBFYDvNcip6NW7JPsks8+s
         UcHk/jtaSgNd3CEcvB9HUrd0qmUxHIoxDP7mjb8pk1AH9+nnGHpwjC5ewYMrdC8MP0en
         X2AwsHObu9pYAf7o1Poo+4Pjggs+RxVnm6MiYekdR9QemPl5/eFwR/K8OmO75L9FNRvV
         tRAaK/B913sjFZCSgLUiZc8SwIB0BaPX4xZ/06IsN1WLLYViyFUtDzI8HwQAIvQ4qAVV
         cbf8iw8OoBI4hoqZ1zDaFa35sIUZ2mMqFyBMQPjb6XxCuqunQxsFFZKpz7OgQSWNhPiQ
         CWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722497990; x=1723102790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIcMjbI6VaWGNnrJ7Y5PhRPoOIc4c0LKQ9pr6msR5bE=;
        b=jKA4W96IKmh7mQLIz5U/8SlrnpW4FFCQVUrk09NzY4rlZOZrrz5MHES5M+oigjen9D
         pnrp7xp+U+Cld+VI92xAJ0X0b8LKsx8zNlN2hDcllwk7Rf18y3/CE1Uuye0Pk3W36h1I
         WmpaJBmIDjUn4cmV8LDcfQq5/QLqJrLKLqYhcL8vD/rKGVITmaGR0XGqQElSb4O/MXHT
         ZjzQhghKqXnZBDZedXPkmG9ksJikM6GSO2j+6WSxWMMsvHNp6gHxBi1zVy35vwELAQZL
         o9KL0+mQ51bfL8h8QqWQRFBKaJquO4AvmDXMwOTJZPdU7CLPmuXALgbEt1BUXJ054jv9
         Y4Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUl3tvEtvp5lUmRvLtRq+0fsqbVVXQ1LygI1kN3FpVqxYMqv4Uo0L2t3QP61P4MC4QcpOR+/NUYvmcTU114pYACx2YB7pkHMTbWOKbAYxGa
X-Gm-Message-State: AOJu0Ywfwg5vq/rgPZj8TeJs/z1amM1YV3VbN2n+Eo2kUGH9u8tK+VZG
	WGBExjksQn9QaqB4WwN0T4OsrS3Jc6KOBNkXH9Y2IMU/0qFgOk6MOyxFBppARjXm6vkxB0VVAlZ
	yO7/HVYIpDtu7jZvC6aZnnBPDx/26FgEpqboUnQ==
X-Google-Smtp-Source: AGHT+IHo/b0qGpAtmfn+vlvLftSjw0v2BkRvO2zL+jmTStPZf1kPbAEkaUkfp3TLtsxLE8UjVR/ASTzdNGhVwxjsZDA=
X-Received: by 2002:a05:6512:239d:b0:52c:cc2e:1c45 with SMTP id
 2adb3069b0e04-530b61af38dmr1012927e87.15.1722497989787; Thu, 01 Aug 2024
 00:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <20240731-hci_qca_fixes-v1-2-59dad830b243@linaro.org> <07a6df7e-b1f6-4de6-bb54-a18966efc26c@molgen.mpg.de>
In-Reply-To: <07a6df7e-b1f6-4de6-bb54-a18966efc26c@molgen.mpg.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 1 Aug 2024 09:39:38 +0200
Message-ID: <CAMRc=McCjv_2Ap+yb7gDOO5b1pqjRrNNegXH_mDH5Ao2VbVqJQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Wren Turkal <wt@penguintechs.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 9:29=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> Dear Bartosz,
>
>
> Thank you for the patch.
>
> Am 31.07.24 um 17:20 schrieb Bartosz Golaszewski:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > QCA6390 can albo be used on non-DT systems so we must not make the powe=
r
>
> al*s*o
>

Luiz: Can you fix this when applying?

Bart
