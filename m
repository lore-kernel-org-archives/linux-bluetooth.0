Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6CA1DC9B3
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205332; cv=none; b=KbTT38qY8/vdgs8IA+07EVDIzdaEjbTWOCM4W+cpKsmtxu2HD3bUX/bMfrRwFuT6T1cn2Zx/GxFqG4omxWLve8H/cWuP3RyaFCYUOrvn45/5I80ltI2U/60w15aCpxN64BIR+tOwidIia5TOk7deC96eL3rG/rLdTQLJWjOuOz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205332; c=relaxed/simple;
	bh=1OjlgbHQMpbVV+RRAzlJB/hfT5HKL/E+E7OuwegV8QE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QiNaeUFAJ6flHalNpFuKZtej6bB9YQ9LqDeo7dwk+D41chmPmbxWhByMIXOMD+OmiqvJ+WaiF6fIrVmKIEvp6mQLDWfNakAPWtIsIpZeIq2u6D22PMaJcAOdgtqwZnr0jHYlxQcgYsTIYfZqxNonv+QfBEMtYNRX8lRx+fUlOPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCqCXgjP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCqCXgjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2681F00A3D
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 09:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205329;
	bh=1OjlgbHQMpbVV+RRAzlJB/hfT5HKL/E+E7OuwegV8QE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=OCqCXgjPxattivM31l4vsEkHa2uiOucYP7PfVSz2oontg+kq7L8hSczZxvFV/6ufb
	 1gOfGIvdbmWzDcKgLgnFyim3jpSr3F2EvLiyZIsL+Cze80ondL6QjGgywWMHYz5hjM
	 qNJ6UDfCuU+aaQa8jyzcQ2loN1ni9/ws/PDenMvvHkHNMkxzbSKiTh3+tpC3Uc1znZ
	 7yJvDGxLXCUGvNyv0otZq2qozIk11Jo/ZaD9mUSnCd3sKcoS1y0L4XZJphDRiAKJWJ
	 I2cnV1pJfChqVBHcDPiX/9Z/PmChwk5zgPFAqUOKws/javXhtCS/EDFHK0zpUv8hyy
	 x021Iw4+hJkJA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3967725a77fso60841601fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 02:02:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8EdUvZYddbF3qcnaJyNFEz79/pQ3hYxwyyuC26KEXaVFu7P+O4FcYhKB3+9DW62htJ8bklbTrAcb8X+3zDfE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjK/JRN3MBa+cPO6ggzQU9RhfyjU9B8Lzo5iTK1TRn9p88gM13
	3d/2hX9LGQu+QBWn/Io8Oedz/SOsx+/8ToIpwBZ1+uKuthmWbFaQHwzagjjHMcRHH2YBNaP8Fv5
	Bj+Y/1YaJ5EL/9uzuapD8Rw1PsMW0M6EAqgoEECDL5Q==
X-Received: by 2002:a05:651c:b25:b0:399:8e6f:408d with SMTP id
 38308e7fff4ca-399989f71cemr37883471fa.13.1782205328165; Tue, 23 Jun 2026
 02:02:08 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 05:02:06 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 05:02:06 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260622-bt_bugfix-v1-11-11f936d84e72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com> <20260622-bt_bugfix-v1-11-11f936d84e72@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 05:02:06 -0400
X-Gmail-Original-Message-ID: <CAMRc=McmkN=Oho2A+XWgvrRG3QfF61HaPkeCperSaiCzqOc1Dw@mail.gmail.com>
X-Gm-Features: AVVi8CcSTbByqSdZAEXODdVz0OKEiC4XEODVjFqFYlT72jGmB2Vkm4nav_d8T6c
Message-ID: <CAMRc=McmkN=Oho2A+XWgvrRG3QfF61HaPkeCperSaiCzqOc1Dw@mail.gmail.com>
Subject: Re: [PATCH 11/13] Bluetooth: btusb: Move struct btusb_data and macros
 into btusb.h
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-arm-msm@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Ben Young Tae Kim <ytkim@qca.qualcomm.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 16:52:24 +0200, Zijun Hu <zijun.hu@oss.qualcomm.com> said:
> btusb.c is growing large as vendor-specific code accumulates. Ideally,
> btusb.c contains only the default implementation while vendor-specific
> code lives in separate files for easier maintenance.
>
> The newly added btusb.h also reduces unnecessary data copies in hooks
> like btusb_mtk_setup().
>
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---

I would be ok with this if you added a user of this new header in the subsequent
patches but I don't see these so I'll hold off my R-b until you can show the
need for one.

Bart
