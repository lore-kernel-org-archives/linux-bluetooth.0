Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA28188CD7
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Aug 2024 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103385; cv=none; b=Su6Fd76CVhK7Gppbt6cUnoUXGu3REGpdClKmmXnU7bpbNp+gg5xtEBmlK+xBCx8OWaK22FIRK2Lzc1wljd5/DmUlOdxhGhvzC6/PflXY1qP11iIivO6lcV7PLDzU6lXuNhehQPKf5LtdeCWwORgWrH+hWtdYdqG1dJAsb3X0eAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103385; c=relaxed/simple;
	bh=eRMCGQGyPMzEKe5DbxrFRJMmi8rj1jlg7tNTvlTUMvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4oRWNl2qH9UIUQlGgsCW6Ab9JwlmAHCIz4vJAh7XCeex/hSTQB84P5KOkwHYsU7SdZizwDwAOayowcMa80Ehhf53flsfAdx4uAP4Ro86c6tgU9Vp+6dANVmJxUIcGKmRj3Wf+46s3ePLDvg+RBx6+k0929pOf/GL5Xi0pmpHsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B8jdPorz; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8jdPorz"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-65f7bd30546so4988757b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Aug 2024 00:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723103383; x=1723708183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eRMCGQGyPMzEKe5DbxrFRJMmi8rj1jlg7tNTvlTUMvU=;
        b=B8jdPorzRd0y5M5KeAXF+/5QB6w3Lat0e1lvMTyhSnkJYoNc6jFN7huQbpaNf39kpk
         Zc8jNR6RRVm3QP/JnmyQElHVxPA2/FG7LpbwLPSeLshqI/Hz8MI6+TGEoEEIQ/IelRS6
         muWj8/liweI2PrYwRkik3KEPEliyqGlCNTVNdUY3SRuxb75OydqrdfOAODXdMaaV+Zsk
         yf0u7OVmhgQUkk4Q7rvip/mJ7I2fa/yfPFAfiowMYnowbcOlUBFAT01uTUHHXA2anikm
         FkEiDt0YkkIyRkQID5p9cF70lmoutjaWQFzUDyKDP/QLJ/3yF3r0xu50PZL+M8GmL/Ey
         vLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723103383; x=1723708183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRMCGQGyPMzEKe5DbxrFRJMmi8rj1jlg7tNTvlTUMvU=;
        b=nXTNIOvjvogQ1igtlxe1DWhkPoK0LZnu99IlSHtSd1OBtbB566ueBzP/ieFe9wGQrP
         v4c3JmyRnIYWXEDtTqDB1jV2Xg5PvbkUW4FZ+qp+/AENl+qpx9PIPXn16C7GAK+YF3sX
         HIIWOvEza88r+KblAbf4qMk6MDlLmfler84bpelJG7kyY5xrOqIVExcRl71pAJMAZkWO
         3B0BaHpeEzGxNiEJG5Cra2BB273MjCGKF5KChxfWZwGpqV/SUyFPbOT4zUur3pHrHTDw
         eROeRxb18fuCDO5TlVm6v45wUb3AKjpPtOldMe9+z6G8gNaVmSd8isM7k9XG4OpT+ubT
         SqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaFVZSOx25EgUhf/6A5xSqAXt5R2TUwTSRhRPf5YGtgO49loe8LpR6gcwmMw7GAhEVADZmZrii/KOUnuev9OIGVElJfIhKD5y5+n3wXycg
X-Gm-Message-State: AOJu0YyU3Ri50EXefBzpAxSBhJ9D2LgYB5qEQrYcKuWOTFE1rXMFUDg+
	5aeD59kOodw28uq8N16Xvn3OpUwvNATUcVMuIWx1jh50MIVu7SzfYgNuoVdA1IIVlRwOapi3dnl
	vt4uUG9jSMeUEjZ51yXBP+8AvbM8jYAGm/Uf6fA==
X-Google-Smtp-Source: AGHT+IFyIUiLZyMQe48633h5dRgjuSDZTU0zmncfIpnawrCmNKHGxrVkYgirf7pL6TeuoZ7Ea4yE3VCGND/RcnmcpDw=
X-Received: by 2002:a05:690c:650d:b0:651:4b29:403c with SMTP id
 00721157ae682-69c0d6c32b1mr5818397b3.2.1723103382998; Thu, 08 Aug 2024
 00:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <20240731-hci_qca_fixes-v1-2-59dad830b243@linaro.org> <a3bd82fa-eb27-4a71-96d8-c768b9866bf1@penguintechs.org>
In-Reply-To: <a3bd82fa-eb27-4a71-96d8-c768b9866bf1@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 8 Aug 2024 09:49:32 +0200
Message-ID: <CACMJSet78P5ix7QM=uz2jH21MSNmJ0nVCaeaJFKA6S8T+0R-Eg@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms
To: Wren Turkal <wt@penguintechs.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Aug 2024 at 21:09, Wren Turkal <wt@penguintechs.org> wrote:
>
> On 7/31/24 8:20 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > QCA6390 can albo be used on non-DT systems so we must not make the power
> > sequencing the only option. Check if the serdev device consumes an OF
> > node. If so: honor the new contract as per the DT bindings. If not: fall
> > back to the previous behavior by falling through to the existing
> > default label.
> >
> > Fixes: 9a15ce685706 ("Bluetooth: qca: use the power sequencer for QCA6390")
> > Reported-by: Wren Turkal <wt@penguintechs.org>
> > Closes: https://lore.kernel.org/linux-bluetooth/27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org/
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Was this commit supposed to have a Tested-by: footer for me?
>

Yes, I sent you an offlist message about it. You added:

+Tested-by: (...)

The leading `+` caused patchwork to omit the tag. Just do:

Tested-by: (...)

next time.

Thanks,
Bartosz
