Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860D2C026C
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743645; cv=none; b=jrzm1uWQVg+PDYlT1Q0SyEawo7p2AMkwOWJHoH7YiLasF8Za68k+9O1/+DW2zOx8z+ZUs1W9lHwxDEo0h/869DlABkQSxvEC0hbwQvPMDcmFFgUAnW8/NUErMbJcf+ZxTZ1D6pwPmhgzoi75MiFUWI38ZhThpfFlDc3Jkq3GqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743645; c=relaxed/simple;
	bh=HXh8XVhftIlOuBLfg8NVk9leceRLV9HU/K4pAv4S7GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UG9lvFvxmObEgR/OZ9AtsAIMM9T9tA+sSPK47+W30/1YHU5u0BSh9Q0YeEqE5DxvjWaA8nRMCJp1ZV8x/ALIF1OyzhXGFTFpbRLxEP4MIOyYFYiGNDnflzgJhqRmjFiQQ889nz+Uj46s+ow4MqNLcVi/IBBr+DzDV35Tbn9eisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hlOtlWVn; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hlOtlWVn"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-378d50e1c82so71002681fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761743641; x=1762348441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqA6GSygQlCbGGE92uS1aB1PWjkaAYd841Sg4SieyII=;
        b=hlOtlWVnpwS3XHlygstKeC9HQVK9qNA2JkqB1DjoDbBqjJI28RY8aBgzwcu5zobn6v
         sjQKZ51sZzwj9Yo3JpjAfR/gZAs04ZPoLxvUkc0MZf4YpTU9O0erq77GdSZybw37WnP7
         IfJ5EgphNSGdC4Kr55/1gLYQkQ2fb+iRbNM4z7fVFcxL5D0bt72gcgGRbSX1tc4Pz0He
         f4lSbcZRI3eg6XPKLdtuJiQ+PJAuk5eTwYBfPhc8LP4zZtl2al59/lFALKr+pI86Jqow
         isqLqslnToa664tkOsZ4Texuq9tE6N7j0k/gFF8LE/O0HEo88CCre1sa+lOpNVE/vQ9A
         rZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743641; x=1762348441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqA6GSygQlCbGGE92uS1aB1PWjkaAYd841Sg4SieyII=;
        b=RrWzS5hRXMi+mmfCQCTD2iYH2nYE8xuKH20N11/ctFxhv6fDaGNMTw1zWZF+7/KedN
         F6XemJv6OQPO2JYkEmHwzj8Tu5etQQe5dTYy3s+yFC7ZPy1FJaZB1k/MxjJeB7ZcPvWq
         yoCcJWXQN5st6hgbeI+UFvUhaFSv4tFiKWAIis1SRB/90TPuzvbZzKXGkbErop1j56bR
         /yh+gkJyvWcPhULp9VXMHqfZ3H9acP4jbzYFBIvTaobXCWawp1TUr46L+/fSGMnRg0Mg
         QeaTvV0Zimh4vGHvQZOu/yNjrx9JIheAT5yymrLDDItyCP3L9cRUX9Xve1Lgn5sbhi/L
         f+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaoYqE30IJuBZvOiG7qRlv/dX/vVDdhCSgnCGzEJIsLeekn8718QRQl9Wf1z4Q84jrlx7+H3octb1CZotcjOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+DzxosqM05Y0OQTN1BemgmUyhRLTAxo0iYkF59hL/i+vIuuM9
	xYr7N8IQ2x+sPVH2N0W28hsZe0EfRym8Cn/mlzAaZRZ3SJA4DIprWtkDiyziI11tFEqlCSU3ttZ
	dIreAgCuLX6nll0LJ1kTCeOZz7wvfJuKCIIKP5v5N8g==
X-Gm-Gg: ASbGncsgU0Pxeb9ovosKBlNk6nodMMWJ5uXXiVivHrUHBeOiYGK8H5e98e7WwsEdY90
	nswmE6ZYdqVJ+mlWq+SQBh2wMNdBMa1OVJ9E2NpaZQbDAZ41HPUY8LEzAHGjKpEcQr6U+VwHbWb
	oGc+K9CLYjGkazY/Afja2PM59yaE2IA+C3kYpy3eVBirLq0UF0vK+5Ztdn2UQLVzama/4wQkW/f
	WZz13lAQ8S/tgZSrGg7QTtglqe1lRCGWxs4nW6DgIWsiEWDRvhkA13diM5IcOf5lhj2zpxIOl/I
	G/FFH1wAMTURPOty0N9l3OJqTiQ=
X-Google-Smtp-Source: AGHT+IEDeO7pOWXIiKISaidNbH4GhhTTnet358H+WU8HbsJA+qhtiRiRxFILoq29B6HEL7w4GKQI73DKFNYwKm/mQwI=
X-Received: by 2002:a05:651c:1107:10b0:36f:4c94:b583 with SMTP id
 38308e7fff4ca-37a052cfe5emr7976601fa.16.1761743640602; Wed, 29 Oct 2025
 06:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-dt-bindings-qcom-bluetooth-v2-0-dd8709501ea1@linaro.org>
In-Reply-To: <20251029-dt-bindings-qcom-bluetooth-v2-0-dd8709501ea1@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 14:13:47 +0100
X-Gm-Features: AWmQ_bm2G7-iNhdxoXC19qDeGT6XRmVTZTDbAiHUQ68hSenSjedNVmrrWyCNe44
Message-ID: <CAMRc=MeGLUvyM5GGv=eFpKd8_KCcSOnfKXCtZqJwpTGuRTixxA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Bluetooth: dt-bindings: qualcomm: Split binding
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:44=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Changes in v2:
> - Drop in few commits the properties (supplies) from
>   qualcomm-bluetooth.yaml which are not used by devices left there,
>   instead of removing them in final patch (qcom,wcn7850-bt).
> - Fix dt_binding_check error - missing gpio.h header in the example.
> - Drop maintainers update - split into separate patch.
> - Add also Bartosz as maintainer of two bindings because he was working
>   with these in the past.
> - Link to v1: https://patch.msgid.link/20251028-dt-bindings-qcom-bluetoot=
h-v1-0-524a978e3cda@linaro.org
>
> One big Qualcomm Bluetooth schema is hardly manageable: it lists all
> possible properties (19 supplies).  Split qcom,qca6390-bt to separate
> bindings, so device schema will be easier to read/maintain and list only
> relevant properties.
>
> What's more it messes up old (pre-PMU) and new (post-PMU) description in
> one place adding to the total mess.
>
> Best regards,
> Krzysztof
>

Thanks for doing this. I would argue that the deprecation of the
legacy supplies could happen before the split but that's not really
important and would probably be harder to read.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
