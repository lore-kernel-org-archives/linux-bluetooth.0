Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099B15E96;
	Wed, 31 Jul 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443567; cv=none; b=nVMh41aYC/Ec6ybD6LIQ/5Pi8LwhfGuG5Pv6kh0Rz3ybHKYqv6a0Sn7pa7CWPjkJSBz6Bhu48LoYMbf/+v8fHk6eTYUuKiLUEzap2CHv5ThrLoIqg8Ur7tqbfJmjLA6jyQIG+kPnQbgv4PtPlvI/XMfiJ4nnjzD5icc1NsNTc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443567; c=relaxed/simple;
	bh=aFIDWBq4Nmy0FWXw+JYhaJRwtgoDGGvlMCLfC7m1N+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oim7+89YHWzPFucsG97aSuP83AJgq3WFNJyKqIA2flnekcafB1Dc6M8XnK1V953DigdQFsybKtxkneOob6rMcMonbqGL5dgHgknhFTU/dNQok6x4Txouj4JAbv7dxX50ChmOuUZ2GQcS+fuF/+1ZdKFncepCQz5BClE90CuOyT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+j02xlg; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+j02xlg"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso71150561fa.3;
        Wed, 31 Jul 2024 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722443563; x=1723048363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIefGprQjQzzRl+XymqNxAaIt5Yc30PGPqqfK1kTf5o=;
        b=g+j02xlgMjojwGlz9vDhFa2rf/qLOpvmXHkIwS1mUB6hBAQRcJrARYSiirvXkNLOKU
         +Ma0u1Fx/RTgIY0XCTXESWzeRbkNvZoxoeqP+Nvm/ZA7eP1cVPLuBSiXOzK4M9dNXRjc
         ewkTY5X3qM1RaS+w8HGk9SRnJEJ6YAkgikRLmZsVZYSc9hP2RijeEAJGOAAiMGd17Blq
         0u4ha0bKjWTJsmuQm6vG6iEbiVP6xfVMMe44FjBJyq7d2ciaVjmMyLNdpA7Si+beTe0s
         HGX5hcEBIOiq+Qh5Voy03yZbGv+Okq0qsPd868Wgui2GPWfkdHl6EZeyz2Zihnzk7UEz
         pYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722443563; x=1723048363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIefGprQjQzzRl+XymqNxAaIt5Yc30PGPqqfK1kTf5o=;
        b=Q2SdP8rNymOcUXXfxzbj6JnYbiQK8jkS4drVr31r4bQwuudlBxipxeYb7fnbGCJDAH
         3Cto+c7wCXUwby2UkeGJIIA6hqtbpN0cKaOVcGw8TwtlQae4yoICMMJ2m5mVttLPvw3Y
         lahiv+67jaqGfudqfu5nt57Zm4Fb8u5JYpCqfXl74bnvEQS4nOTa+r4VzU2xVFdmSOWR
         uuobtLsB33yuO1+BMCg/OpHQBJaAdMCu59OjAwtQc/mzqutnGp386uh/Eyp9Kc1M8jDz
         VDUTCddt6HMqpcVVVYsMo4L8aFJYmRpBurTFxFTdtKvnyv9p7cntXEoHDVttJZmPzuqk
         ICaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBW2608Wsz5G64j1Hw1uXjq1XAIJkGJKuT/kVk28yg/9ZVZ7FDuZKX2J8Zj7iPABf2y7dwTYESLxaxEpcZKtWHoFACQvVBcqKNcHg7PcDRQGWn8b+n3lcT9oTRASVuKSL6UhR4P8s4SAmXRntV
X-Gm-Message-State: AOJu0YybcYhfCNo4997mXI3ApLLQy7D7858cNDcRshzgnIwqzISRY0cY
	Ya5pDKGGwsDB92hLsIviirRhtW0/uy61YmhXJevk56c+OXmqzflhpjDCRthLmYPVjETAaKoyRJN
	JzhJTBWHeglawG/7uqkaNL/tCKz4=
X-Google-Smtp-Source: AGHT+IFc9t3k6Dm47Ha58j7yx2K2/CRo4wNoeikNws55HD+Vm14k5JDII7jSv6PofGp4s0NZed1po0DtWbnoaMvuxjo=
X-Received: by 2002:a2e:740d:0:b0:2ef:2203:5dbf with SMTP id
 38308e7fff4ca-2f12ee1992amr91540701fa.27.1722443563178; Wed, 31 Jul 2024
 09:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
In-Reply-To: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 31 Jul 2024 12:32:31 -0400
Message-ID: <CABBYNZ+dvLGos9oLi6euFkmiU9OReJ5F3qsA6WrhW29yeZ-jWQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Bluetooth: hci_qca: fix post merge window regressions
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Wren Turkal <wt@penguintechs.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wren,

On Wed, Jul 31, 2024 at 11:21=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> Here are the fixes for regressions reported by Wren and Dmitry. I could
> reproduce the crash on db820c and so I was able to test it but patch 2/3
> could use a Tested-by from Wren on QCA6390.

Can you give this set a try and report back?

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Bartosz Golaszewski (3):
>       Bluetooth: hci_qca: don't call pwrseq_power_off() twice for QCA6390
>       Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms
>       Bluetooth: hci_qca: fix a NULL-pointer derefence at shutdown
>
>  drivers/bluetooth/hci_qca.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> ---
> base-commit: cd19ac2f903276b820f5d0d89de0c896c27036ed
> change-id: 20240731-hci_qca_fixes-8e7a8ed3ad83
>
> Best regards,
> --
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>


--=20
Luiz Augusto von Dentz
