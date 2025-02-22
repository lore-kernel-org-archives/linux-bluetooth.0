Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD23132103
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Feb 2025 01:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740186422; cv=none; b=qJ0oWgH92KY9i3HG+N0YQUgpVnZ67ZD8hzDZDMVBwcGZOkBw7IczdFCLlNOD4vpYTpVBWNT7Ei68/nZblBJWUT2bBpM2dJNNdCEjHmUXk4jtiBq9E3Kod96hOj0heHnfNRByIgHzZj5MFMxAlPXtACwOFooD3htmlQRq2ro3Ja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740186422; c=relaxed/simple;
	bh=oWNjA4iAb86TL9euhzKXI+ikt4IOF7STMLKlY2f/5Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEHTDN/FfhZ4Vb7gc4+ivhUHU9f7xKVcM2YPYi2KIpR8C/EOUclJOpR0MUNlDyswLLJHzoU7Orrnw51uaoNETkI64SVf0YOX2CX0P/jWNaDt8cHjaGRnFBGCsUJ6D8o24Kfo+AdSExEObpZ3P5CNeK52w3CDPU5eAC7fSrc8y30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T2M1WL+O; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2M1WL+O"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5452efeb87aso2696374e87.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 17:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740186417; x=1740791217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SXPIaDT705xuetNhhFasT7VZfBwG839I1ETVy1U9JU0=;
        b=T2M1WL+OQCezs9X6uQsXyfVuar8bbfB7qZLDjwJVCs6wCdR0EMJXi8sZ2/8Yz2QUwO
         C3KLTupYXVyK5T0abivr+XyEFWP5DYgRTD41HVkYT7bHIm+d1vKGoa5smSrKSg9/ab4y
         VgrlwqxWy1pOqZhgdPiGqvAept+ngle5rYLR9GN5CDnnhdGHyPgC5D3PKogKoQiibpL4
         gs/+sjsntGsEfxewj3+6lXzh0u94TIGk92Qc9eAYmXemSf2j/hIpkZaWCav/tEUoBz28
         qezxudzzIutHPyiisII9hryeotOBL2XVn/CaH+jqWOR+AQa44nHMFAwDJZT9K5s3z+l3
         4tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740186417; x=1740791217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXPIaDT705xuetNhhFasT7VZfBwG839I1ETVy1U9JU0=;
        b=tZvLruTRo09TLhy5Hr18eLUxfiTJ4A7iyAhbLpvjNvnpf/HirLHpN8rNf4y2PbI8Bv
         62tC6j4Phpfo+NGZJNlcoKUa98ziG6shSTBCuunP0DRn3UmhJ9H4dToNB8XSlw0WUqgB
         3qK31O3MONaC/j9AYw/ImiGLMychpzgTM5/5Q1fp/SznS75+gi2whQfizvmiZJwRvU96
         0XQHSp0oVhw+xP7muL41gqXb8lbrFE2t8N1QnDz5oM2vbKCrhLeaav6lO8EggsH34/LQ
         SgHw22MW41FdE60xv9XNCZ9FXoG+Kf7E1Qzoq3NrfS1Hhg10QABJWjB0ZPm3PhqRmsq1
         vQIg==
X-Gm-Message-State: AOJu0YwkednHz12qSyHYcXMCHB4uWtGujk/yTpbfoCGFyfbF0BFWhmnM
	nInfzNRk0uDXaM74oeLDhT1zOqbEvnMcR2XCfJ8Tyk/p+sl3eJVLo6lLoFGbK4l9Ng9zuhD4Q3p
	u
X-Gm-Gg: ASbGncsvfwfoOXTNcZFxuOV/VIDxwKx/PuyhmiY1GtktAt7RMHTyS4koUzJYkqDD9PK
	Y+QNjgdLkOVRZQijv/mqOSep3xU9A/sFHEZSm712nklyO2nT0XO2ee1xa75JzF0+dVuTrUN9zns
	w7zhLQOszWPIoi6cWIxJDNjcnkhNMb9EQb9ZG/wekiZN0ArkKiV+DEFvTaugkFayuHiEqqJQ6Lz
	N0RiC5BdOfw3X7Y5TPg+b2FloNAxkhs0NvWHL14RaemTaSRO3j5d4dKZAlWlEp3TutpMNuGzfap
	0rjYYoJwFwQOci6RtafvV8b6abZxvhhMjQPoPwCvKa8dl1ZqOBVq841flDOw1o3uCRJeWbrfX1Q
	xahvtEA==
X-Google-Smtp-Source: AGHT+IHi+ordHXE50By3g3XEuMDzRdPKjNWp+dXW81whZVyJYjc5ubTtNYsiZV1PtpJnAOhMKIvswQ==
X-Received: by 2002:a05:6512:3c87:b0:545:d54:2ec6 with SMTP id 2adb3069b0e04-54838ee2884mr1658130e87.2.1740186417340;
        Fri, 21 Feb 2025 17:06:57 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54527b7961dsm2518317e87.46.2025.02.21.17.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 17:06:55 -0800 (PST)
Date: Sat, 22 Feb 2025 03:06:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/6] Bluetooth: qca: add Qualcomm WCN3950 BT/WiFi chip
 support
Message-ID: <3s36j75eoqszm5hiftia543h2a6nxaa74wubrr6nq4akzq4hta@wyuwa5onjauz>
References: <20250207-rb1-bt-v4-0-d810fc8c94a9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-rb1-bt-v4-0-d810fc8c94a9@linaro.org>

On Fri, Feb 07, 2025 at 10:41:14PM +0200, Dmitry Baryshkov wrote:
> Qualcomm Robotics RB1 platform uses a new member of the WCN39xx family
> of BT/WiFi chips. Add support for this member of the family and enable
> it to be used on the RB1 board.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v4:
> - Added empty line before status property (Konrad)
> - Reword Bluetooth commit message to follow linux-firmware changes
>   (cmnv13t.bin and cmnv13s.bin were merged).
> - Link to v3: https://lore.kernel.org/r/20250202-rb1-bt-v3-0-6797a4467ced@linaro.org
> 
> Changes in v3:
> - Mention new firmware files.
> - Link to v2: https://lore.kernel.org/r/20250201-rb1-bt-v2-0-fd44011749bb@linaro.org
> 
> Changes in v2:
> - Corrected QUP interconnects (Konrad)
> - Added /delete-property/ interrupts and an empty line before status
>   (Konrad)
> - Enabled downloading of different NVMs as required for v1.3 of the chip.
> - Link to v1: https://lore.kernel.org/r/20250201-rb1-bt-v1-0-ae896c4923d8@linaro.org
> 
> ---
> Dmitry Baryshkov (6):
>       dt-bindings: net: bluetooth: qualcomm: document WCN3950
>       Bluetooth: qca: simplify WCN399x NVM loading
>       Bluetooth: qca: add WCN3950 support

Gracious ping, these patches have been sent two weeks ago.

>       arm64: dts: qcom: qcm2290: fix (some) of QUP interconnects
>       arm64: dts: qcom: qcm2290: add UART3 device
>       arm64: dts: qcom: qrb2210-rb1: add Bluetooth support
> 
>  .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  2 +
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi              | 31 +++++---
>  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           | 83 ++++++++++++++++++++++
>  drivers/bluetooth/btqca.c                          | 27 +++++--
>  drivers/bluetooth/btqca.h                          |  4 ++
>  drivers/bluetooth/hci_qca.c                        | 25 +++++++
>  6 files changed, 157 insertions(+), 15 deletions(-)
> ---
> base-commit: a1d1e1f2fae5fcb5f2e43b81afa9596c606e683d
> change-id: 20250201-rb1-bt-cec7a314991d
> 
> Best regards,
> -- 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry
