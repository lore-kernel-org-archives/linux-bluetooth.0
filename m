Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA931FA251
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 22:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353167; cv=none; b=gAvrsjuVF3eWhziRH/5SelphwskVRK+fymKx2B1fzvcYCAbkoWPwIqmw3FMqVVPqt+ripLArh+GQkputKmnxbmRt9Pu1taUuWwQaGg9of3ffzpUfbCjL+pQkIFAkcM8TYOv8tdkKWdzR00SIg/bwvmHnkQ8bv/zbiKwtKkzk7Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353167; c=relaxed/simple;
	bh=zu2zn/CG8LATXGnamKjYNIPIAQAZIUfMCZnfMDljbJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaqQFYCeQVWIQOulbmD+BYo2c32ORZEy9Th/Dey6SaHU6n1ejZDwcLAA3TcBfni8bsB5iKfJ4dInaQ5u57A84SG2wU05UBUvXr3T/UGdezmBMAdnTrgWhvT90MsXDW1pLzi7D0FkAGX6qpzGypWjf4ude2y1RjZoFd58mPPJmXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IXiSUX49; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXiSUX49"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53dde5262fdso400857e87.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 14:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733353163; x=1733957963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTycC8k0POiTYVULvZ4XnFfri7Upa5YgerEMaIs+Jd8=;
        b=IXiSUX49C5EBU55+Vp5Lm6WBVLlKpOw12VSzXQiQ9BctKqBt2mNbFdy4bApo0/hCL6
         y/1P++taUn1sfQz75tL3k466L2ZAbQXHbOXbRkbMQ8lp+FjfM9HTWkO/7BM2j4yKfZ6S
         XJnL2Mc1oJaj3iEzTBGlpjCS+IbsqQcWckJWcvM7qQ5WRGSB8pr0GT/1aRJzELYvB1u4
         717qhqxcVAKjrFo8pWSqOhcYn+MjtR3MHrn1d4ABUjMe15DpzGI8+A/4Kb4Zf7DMBgqi
         eM4sUPSErrJ8SO4gOlICgpUtTXcp4cLqlmxuzaEiyHEH4ms1PTjQq3aBi1pO89Ie94ve
         uzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733353163; x=1733957963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTycC8k0POiTYVULvZ4XnFfri7Upa5YgerEMaIs+Jd8=;
        b=W2NXM6NlO+cH3bEtx4Pu5vxJBmGR1op2y2je961ZsrDeS3m1GuiE3u9J4PlFmXQ3ZI
         rBO9idMO2ZvIDOCtJCW9ur2QwhT3AivNiLivNGu0eSUzj/kUsRwodYvKeVpoht1DdD0p
         THIVUrR9ss78wQInna02j+PN5cAHsBSqsnrwSchOesCEXWXneZ6pOtFmexa3/F3wWWEg
         xFLE6A3Fiw7vmmAlqqbIrZVujv3zjXpR5yJje314xWGF2VgRGwpL1RPFpQV5ri1iS5iA
         dafPQMSf/O+TPAeEeRrDIRVzrNhv1mYEqx1yVOlZzRPhs6LNn33vImyfkMSvZs7XVzLP
         lbsA==
X-Forwarded-Encrypted: i=1; AJvYcCUdqBdoqdNRXiFuUp1XE+WXhro8qgdqsLsngR3NMC332r6XaipX7+Ghe+F0kSG6hCz8kW0KoHCyTFQHcJM7KF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1rPoM7PKe+2pmwKevcRkXaTQkdxyVprAqufqW44Puabt7QNug
	4XRhtrl2qiCyVRQOFAVS4AYjMQmW9e2koQ+yNGQJc+8tAvD3452VtVijYjVz5WY=
X-Gm-Gg: ASbGncsCl9E33nMbCprz1Gvnlxjt7imXwSUfRVeI2TKPy7Idg3HrLf2qS9ljL7OyVak
	10rAEZRrYK43i799DICFFKzxo9Ex4P/bv3ukgVkLsGly7eTGOwfajJGcdqXvNtp4GCochVDoiw5
	x7X9kGGXhPkS74x6Enmohtqp5lxiTh5wWf9K41oGRCEgIJ01cfvbs82mHYT7dvNpOR/a7Iakwq6
	xPMGIZnrU+NaB7jckVl9xpaM9z52qvUGHl+EcGI5gcFXAmqIb1fYQKJx2b+wbq+4hnrsTgsIn//
	wGBAkh1dgXV+jPivF00SFr0f7mFZrA==
X-Google-Smtp-Source: AGHT+IFRjL/KhmDcGC8MucpwxgwNr0ZNRoGoJL7sxAYkJFIl0HN1ssgHjTDj9GY1umPdAlN+l8LS0A==
X-Received: by 2002:a05:6512:2252:b0:53d:d3ff:77f6 with SMTP id 2adb3069b0e04-53e12a22f22mr5085713e87.46.1733353163247;
        Wed, 04 Dec 2024 14:59:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e22947a16sm29976e87.33.2024.12.04.14.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 14:59:21 -0800 (PST)
Date: Thu, 5 Dec 2024 00:59:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: qcs6490-rb3gen: add and enable
 BT node
Message-ID: <pzkijkdswskaq6232uldapz3b6v6zplif7uah24iwq3ymlezft@skbcy2vod3c5>
References: <20241204131706.20791-1-quic_janathot@quicinc.com>
 <20241204131706.20791-3-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204131706.20791-3-quic_janathot@quicinc.com>

On Wed, Dec 04, 2024 at 06:47:04PM +0530, Janaki Ramaiah Thota wrote:
> Add a node for the PMU module of the WCN6750 present on the
> qcs6490-rb3gen board and assign its power outputs to the Bluetooth
> module.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 165 ++++++++++++++++++-
>  1 file changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 27695bd54220..07650648214e 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: BSD-3-Clause
>  /*
> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  /dts-v1/;
> @@ -33,6 +33,7 @@
>  
>  	aliases {
>  		serial0 = &uart5;
> +		serial1 = &uart7;
>  	};
>  
>  	chosen {
> @@ -217,6 +218,63 @@
>  		regulator-min-microvolt = <3700000>;
>  		regulator-max-microvolt = <3700000>;
>  	};
> +
> +	wcn6750-pmu {
> +		compatible = "qcom,wcn6750-pmu";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_en>;
> +		vddaon-supply = <&vreg_s7b_0p972>;
> +		vddasd-supply = <&vreg_l11c_2p8>;
> +		vddpmu-supply = <&vreg_s7b_0p972>;
> +		vddrfa0p8-supply = <&vreg_s7b_0p972>;
> +		vddrfa1p2-supply = <&vreg_s8b_1p272>;
> +		vddrfa1p7-supply = <&vreg_s1b_1p872>;
> +		vddrfa2p2-supply = <&vreg_s1c_2p19>;
> +
> +		bt-enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;

Doesn't WCN6750 also have SW_CTRL and wifi-enable pins?

> +

-- 
With best wishes
Dmitry
