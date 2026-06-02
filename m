Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E2A2C029D
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387125; cv=none; b=L8rFBj+vK75zj8LNzJbfjoQ+x5dA5F4htU4ucWUMA7p9WupA9BO8kOkYppdY/2h0IdmDuQgQUYmBCpZM+2HLqwOoyvvlAaM6kzBksE41T9zV9iHb7OGgjB+wyEdUfOsGcJU1U6RlVREv24WhOpke7H6bG3N9D4vJL0gRXFfLHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387125; c=relaxed/simple;
	bh=XYy3V5eZVklfkWl8JgnpZ2HUfddY5d0AG93Z+sOiyhY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4yz54Ae5dKYGRVzOEhQIhnFCcoqZv2Vjg0fChP37rPz3djwxCf12BYuZP5trCDK8lSb2bXbb8rdMy3V9PEX2yZ1tsK7Evr75DLk352muFPC0ZDwLRPYHMzjmX/5JxhwX/Mvh26URrA2qoCzSMrjY3qvq37n/ABfITNO1DhZxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR1cMO9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR1cMO9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4EE1F00898
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 07:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780387124;
	bh=Y+nB6IjclCObNAHhbLPlcvSO9M8DxxTvdwCzmJ5QJZg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=XR1cMO9XH2dQQ1a5oyTqYlnwZJSyzZlzzN5+ZM1bQ/evfwf/DSSGzrRzS0/dlTIMI
	 v763saQB4XMG0vVIgZhKVRHMeTbL/FqYo8tTy+IR32DEh13e+4IFSswqd+8KiMfxbs
	 SPMqid4GMRsrXBltONYi4ysuMLn0AVmkIOg0YYPP8mpFK6IzmOaYbwIWjItnFT/iOj
	 Q8Tz3CTQAG1pO5QezAkJPWXVLp4WVAAiotB/IVRtSdbi5/A5COBw8h7yAUhRVywJcG
	 PgUKyqirozeCDZrCo5VwROdcP9dVXj4cLGJwYPROvs+EbTQ8R4Yk/dkfqBv63njhqA
	 P+GfMOzgrrcAw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39666f49929so26938951fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 00:58:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9t8YFRJ3eYaghTDpYAoOtT3O3T7u5zP+bNAysj3RyDE9IQt8KDyt3FrpMAQ9Pe/Pxy3r4i6nihvM8lHuRv/Co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5fN54Yn8aWEVAGAANb5F6fvQXBpqqJBTEZH4m58NOaDWZ+1kq
	nTOYEzYkG5qi0zbQn4I+Z1Kbfdsjx9GEHDxn8vyrfqS2JH10wsQiSENoy2qPHjHd5Zrt9TevmFK
	p2HCGcFe06EWMtJaAODRBYBn2XyrWyNnOfvs4je99PQ==
X-Received: by 2002:a2e:984d:0:b0:393:c6b5:993b with SMTP id
 38308e7fff4ca-39664f1631cmr31958381fa.24.1780387122616; Tue, 02 Jun 2026
 00:58:42 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 02:58:40 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 02:58:40 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260601-sm8350-wifi-v1-5-242917d88031@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com> <20260601-sm8350-wifi-v1-5-242917d88031@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 02:58:40 -0500
X-Gmail-Original-Message-ID: <CAMRc=MeDtwzBN2Hb7tZ9DLXRy9XjVnZpRCp4NZUNB8Ads6S_cw@mail.gmail.com>
X-Gm-Features: AVHnY4JkGrXXY2Io5k3AOPxVnoFnOn_nu0dA5WLYX-xPYi8QVC5JYyOfCFzeixs
Message-ID: <CAMRc=MeDtwzBN2Hb7tZ9DLXRy9XjVnZpRCp4NZUNB8Ads6S_cw@mail.gmail.com>
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sm8350: expand UART18 to 4 pins config
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, devicetree@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Qiang Yu <qiang.yu@oss.qualcomm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jun 2026 11:46:53 +0200, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> said:
> On SM8350 platforms the primary use of UART18 is a 4-pin UART (targeting
> Bluetooth or other similar applications). Add all 4 pins to the default
> pinctrl entry for the UART.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index c830953156ec..eb2a795d8edb 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -3309,7 +3309,7 @@ qup_uart6_default: qup-uart6-default-state {
>  			};
>
>  			qup_uart18_default: qup-uart18-default-state {
> -				pins = "gpio68", "gpio69";
> +				pins = "gpio68", "gpio69", "gpio70", "gpio71";
>  				function = "qup18";
>  				drive-strength = <2>;
>  				bias-disable;
>
> --
> 2.47.3
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
