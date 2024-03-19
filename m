Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED088174B
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864633; cv=none; b=KYOvMp9/dJ5w0g+7z7pQXxFd1VsPrfVXpyKR470ooLX29Z8vnJkA9UQqKuHJbboE6Sfmv0TDWDZtXQI1S2qDCU4xa7zcjOPth4yf7g60WuIHotSiVQ/v/jd/MuIhrso7nwzADbtb4mscYzmaMoZGkN3TIpfiZjjJPFUEMFrhzng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864633; c=relaxed/simple;
	bh=FWs6LFKM/xcvvgakZ39skUFNVfNPQgC7Bo//2KPJp+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vaqd+RUuY9YsjOgj11nzAQnbVGNiEzpcDjJR01cEhkyO7HMTHnkCWUdRE4eXyMo2lTed6p9S4PKdVjXSxUnLOTO8ffCPWq1GJ2S2C6w4CMh0WyFaiMyb3h5T5eOvzIE1RUsN8ITfRkjsjd+OxThVu4hU7v7hmtKz3IJG4fby/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eM3YBj9/; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eM3YBj9/"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78822adc835so264958585a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710864628; x=1711469428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Suh5QCHeNsdbI/6JZV91e5lppTR9YIcMyoALsn6PjZc=;
        b=eM3YBj9/wWnwAYlxSdq7Ro9SqQiiENW4Nz4K9XerJQ7A0RGjQ2Sm0caYDn18+OopHo
         9GYvo4NeXVSTzrGdHSeR2vfy9hDO9BMJnSRoWTsjEZKlhjJGiZYf36jTEI0mLaDUEru8
         15B/Fbg4Ew9P1I0M8f8LwMHDeMVa4bHtk+mTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864628; x=1711469428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Suh5QCHeNsdbI/6JZV91e5lppTR9YIcMyoALsn6PjZc=;
        b=nifU0mbW2/DfqUu9VRzqPiSxOZAqfoOcXqIjjgat3F1csZpT9QSHmNDOg/jwx9yHuv
         5JCP18VBaYuaQQP/T8eRDW836e0QPNZfsUwhaAVSK4JI56+Vpzbo2FMNtlscbrSAJoTv
         gfsgK3JS7PGc1NQ/no1D+Cu5YsB6DHPpt7Gc5IJF4Bx2atx+iRRh0WjaGpwhfmJ25Gd0
         MN6rfW9URwYFY+2Zw104/Ig/P3urGW/cCT1/eB7jxALlPjWt0JoF5t2JfCOANyG8lZqr
         nzOE7+JMDRRLWgniuvNgLeRd5vCX2d9C06xCImwDI00ItZGf3whwRFze5fEsdnWzXSNh
         FzDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxYER2eXWrM21mdv2PXF3rM86sE2tjDnYzRjs4ECKy0DtUimTK7jOjkBL78zy6fnzbwTE6J4SEzpmwLn1U6JCuGBfrnGcnYjdPegWZORQ8
X-Gm-Message-State: AOJu0YyTflrNEipd8/RllgV8ecjRwp7X8LgobGh0XpaEUCLKd7di7+TY
	2Ccr2+Mh5XNoegIaDgOtTKGkHoAvX2ecQnLiFWM39Z6KILhoeTFaAZAtdSkyNmIdcQweNkzYgmk
	=
X-Google-Smtp-Source: AGHT+IHEdLBA6QQWKEJbcW9Tqdda6N9mgWs8suRtK5lwMp4qcTTLgmWSpBlFjdQy8ZKLKXvGIO8ppA==
X-Received: by 2002:a05:620a:240a:b0:789:f39e:ad4 with SMTP id d10-20020a05620a240a00b00789f39e0ad4mr11552962qkn.48.1710864627866;
        Tue, 19 Mar 2024 09:10:27 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id l26-20020a05620a0c1a00b00789fac3a517sm2327051qki.57.2024.03.19.09.10.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:10:26 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-428405a0205so373821cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 09:10:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyc7IAx5DGBrsU/PsYVcJ4XNAa+SeJi8MnNUjdDwkmFSDvOfk04QfPtYHHvNFqPQHMeUMeZZIIWb9A9KTwi4bvPMI7/iv8tjXMYrbc7z0B
X-Received: by 2002:ac8:5991:0:b0:430:eb3e:d599 with SMTP id
 e17-20020ac85991000000b00430eb3ed599mr197066qte.28.1710864626281; Tue, 19 Mar
 2024 09:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org> <20240319152926.1288-2-johan+linaro@kernel.org>
In-Reply-To: <20240319152926.1288-2-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 09:10:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJ+yAvDn5NyfCSJdg+DujPrWO+DZu=BmcqbJS-ugEGMg@mail.gmail.com>
Message-ID: <CAD=FV=XJ+yAvDn5NyfCSJdg+DujPrWO+DZu=BmcqbJS-ugEGMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 8:29=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Several Qualcomm Bluetooth controllers lack persistent storage for the
> device address and instead one can be provided by the boot firmware
> using the 'local-bd-address' devicetree property.
>
> The Bluetooth bindings clearly states that the address should be
> specified in little-endian order, but due to a long-standing bug in the
> Qualcomm driver which reversed the address some boot firmware has been
> providing the address in big-endian order instead.
>
> The only device out there that should be affected by this is the WCN3991
> used in some Chromebooks.
>
> Add a 'qcom,local-bd-address-broken' property which can be set on these
> platforms to indicate that the boot firmware is using the wrong byte
> order.
>
> Note that ChromeOS always updates the kernel and devicetree in lockstep
> so that there is no need to handle backwards compatibility with older
> devicetrees.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml  | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-blu=
etooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-blue=
tooth.yaml
> index eba2f3026ab0..e099ef83e7b1 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.=
yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.=
yaml
> @@ -94,6 +94,9 @@ properties:
>
>    local-bd-address: true
>
> +  qcom,local-bd-address-broken: true
> +    description: >
> +      boot firmware is incorrectly passing the address in big-endian ord=
er

Personally, I feel like "qcom,local-bd-address-backwards" or
"qcom,local-bd-address-swapped" would be more documenting but I don't
feel super strongly about it. I guess "broken" makes it more obvious
that this is not just a normal variant that someone should use. If DT
binding folks are happy, I'm happy enough with this solution.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
