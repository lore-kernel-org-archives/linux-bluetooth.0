Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A8357D15
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917442; cv=none; b=mUpNY36OWFC8+NeDvgoyZbAXmCJrZW3LaoaC64qv/bvJJWBNyDjnSR21IT1jORxngstTDh0cw7NnTaBRCskidBTSu1OWOwPUBo1KChL5voKiqfAFuXGnpykNU1NoUUzUU4HE9sSkZM73h+s23Qi6kQSFNXPFnV9a4Oq5xhBvCKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917442; c=relaxed/simple;
	bh=COGUDabHVcqXHpcJkYlZm/XV5Ldx2uNyBygMmkWnTdE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1cNfu+bwFy1ql+nriR9B0iU2c4z5PjBJCiJuCip99I3mL7r56Z3nLa8YSYZCn2iH8XTuPYm29gWEQfnV1soRLqrfTtyjfgq6MdLsCJXs/8Os4gGNy5+nJadk7NZGmwupK8kp8y0sf+uRPKpxOABJ9qXuEj9sDHCpBmLteOr6T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA+ykTYg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA+ykTYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD871F00A07
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917440;
	bh=ad7d5mr4CwYQO8iltfUUgJ+AAb4ROP3d+z77mZ0aNzU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=SA+ykTYg2FGHFGXDTW96O+0oJN2T39LKOCvP/a9mVkcYo9EuhSugk8zd7wMz/KYIu
	 vRgRAgJ4mSmrU742iRt4tJQJXNOA3zJ6SIvAE27AeLEu1WgQNrqMfghsMvRCFeSkBC
	 HMXQ8l1LN5U1eGW0xfgqTg2a03Zno6ALDmjtIsEgb6gEsIC5yKYw3pf0UqcIqgcTB4
	 usBsWS6UgaFUr1KmQrE0uYcm0g2quObfR9Kn+SiJZmxY8bakLmCfAiCkNgrGmdbHIE
	 1+4LASfTOXhMG+Z8AwRk95hILKkQMjpSDVvHl0H/DzglyhaRUYco1OVFKiB3oIqdx7
	 IgRhW/g6BX2Dg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-396bed274b9so34528111fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 04:17:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+rxmxv4JeRzQWA4kr/TJ0TkbbM5CYdj+JrmFaKH2gUkJg7jM21GGiakspRVgatdKRzcIVrBSvkRYKCuVGf5EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1o8wuYJ+KFqANnHopwr+b8JL8auM+QDFsMBOOMdFwYNlBviz+
	DLX3llpVKgRUmn6p9hrmVZKTRwOr3K+DwzbBJV4QLD6rOWE6ZbUT8z08PK3BNmyS88dq6gY02+F
	ex2grpUWnJrK2xcPUXVeLoXcebCUye4klj4yTamLe7Q==
X-Received: by 2002:a05:6512:6482:b0:5aa:7078:49ee with SMTP id
 2adb3069b0e04-5aa87bf444cmr3733378e87.43.1780917438653; Mon, 08 Jun 2026
 04:17:18 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 04:17:17 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 04:17:17 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260608-block-as-nvmem-v3-3-82681f50aa35@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com> <20260608-block-as-nvmem-v3-3-82681f50aa35@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 04:17:17 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mc46R=VqCp-eQcy8DP1yvyco=E43eup6NpkZjAR+rY=OQ@mail.gmail.com>
X-Gm-Features: AVVi8CdkJtXpApBPRw2hv_xTVbemR0DzCSGvL77XwK4W0RDjW4XvcGcsiQ8sLHk
Message-ID: <CAMRc=Mc46R=VqCp-eQcy8DP1yvyco=E43eup6NpkZjAR+rY=OQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] dt-bindings: bluetooth: qcom: Add NVMEM BD address cell
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@makrotopia.org, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jun 2026 12:50:40 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> Add support for an NVMEM cell provider for "local-bd-address",
> allowing the Bluetooth stack to retrieve controller's BD address
> from non-volatile storage such as an EEPROM or an eMMC partition.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
> index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
> @@ -22,4 +22,13 @@ properties:
>      description:
>        boot firmware is incorrectly passing the address in big-endian order
>
> +  nvmem-cells:
> +    maxItems: 1
> +    description:
> +      Nvmem data cell that contains a 6 byte BD address with the most
> +      significant byte first (big-endian).
> +
> +  nvmem-cell-names:
> +    const: local-bd-address
> +
>  additionalProperties: true
>
> --
> 2.34.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
