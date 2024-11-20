Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F49198A2F
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099465; cv=none; b=NxsusaLinWun741GOaraBkTPb5zo5vFideCZFA0sy+h5dDkq/2caxaf4TUyZSgblTcJhIVCrmfnrVhzCVpIUMNxxQnvVRqlI3Lujyum1NJnL8hliK+uZJYl2ypulq50GNuFIe8ovIFeNF/YsdU3YoaESRsRjo8c5EPAgvAZDqjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099465; c=relaxed/simple;
	bh=PSIEIjCkwowMwP6F7pDyJxkqxSzIMP8yegjUBuV121M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9P+fCd3apNyRJ0m5d3XwEMRMgharL7QnhjSOmeNJcgWAJxLvEjFtQp8Yhu3pDYtzh/AaAK6EhuEikL6Jpi53/+5Yul4CcttvPLPlul0U1bkNVcyasZrvAiRZD0sG25VHn0oUxXAKk2Mcj1q3vhg16/BzOmpzVydEF32PimnPYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gj3kZyzU; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gj3kZyzU"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53a097aa3daso3927904e87.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 02:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732099462; x=1732704262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IFaQOAwXecsZliPvhtGOW3UP08yIdA2VUxO/uHYIpGw=;
        b=Gj3kZyzUvdISMeJznKEZzABPkwPtVvzpwABXWl2QGjhivcNkBYFiTVpDHqCegbA7KS
         9QEDQ993eLbm6GYOqYD39xjB7bkEB/9h3peK1KHwFJqm2jvWYJoFeFtBj7NzWy/F/WVd
         GsmOB6KktOuADd87oft6mbMNotL9jSFxwuRvTaEjR02guj8Fw2ByfVH+XnULtjxGysaw
         YLlxtXtX4nhxM7/s/435v/gGrGVQMENWGCiocz2WqyMixpNFCBGajK+sX707K/LSax4y
         rirMHxwGgbzPa1NiDWFFIsAih4pWwLfaytRPIF7PCb0I9Jqgv6QyWh8vfUzuq0ypvCYE
         toUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732099462; x=1732704262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFaQOAwXecsZliPvhtGOW3UP08yIdA2VUxO/uHYIpGw=;
        b=uOXZ45arqyAHw5YwqsMUoFnxAsEz9+B6TMli/6OVQ9/3rGKKKiu4US7P16OywHVrQn
         nt+ymdI2zTE+foaaLzaE7lp85OBhkLG9KCebv7965OZhVi/sOqIN1HxEsfjrMlX1zvet
         N2aU6y3rQ7zjk9WMonDk7lc21s1TZ5kz+qQQSAUwItOo3DK70+QzGpfccrEVdW1kiZwa
         p7Su70H3sUtVFGXfgUnrxFhEip8WMBmxcl5CLqdxSxhyuqxFoMLmoObB1AYq35v3LZi4
         ISHEyr2W1i7wwKukduNw2Bb6gs14nGLEUsr2T1GeTWDV+JLU+q/tkHKDjOz/e+y7H1U2
         henA==
X-Forwarded-Encrypted: i=1; AJvYcCV56OAEHeWBUpu5/lzbptJ3xMC4mpZGlLFgfNT8TlAfyIvRJbmANFX50STq10nJsUID0PfQeB1kI1GJaxHnm/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjVGwlzoXLCj1FajclnSNRPyjTyX6QmvH+/YsdjP763Oat0VVR
	TXNc4eydjrPU6v0tSncpgncCYMHdOYco59SKC2nyDZgC4Q6JSNbdANXLHKVFyjE=
X-Google-Smtp-Source: AGHT+IHk2JJ5HGmR+YoqQPmq7AYyvFw1Gvq+fbJdIJLuypkzijPRXqlaQ7jAEGqpbVN1Hm4GPboeXA==
X-Received: by 2002:a05:6512:1c7:b0:52e:987f:cfc6 with SMTP id 2adb3069b0e04-53dc136f9aamr844707e87.51.1732099462301;
        Wed, 20 Nov 2024 02:44:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd3fc552sm591462e87.64.2024.11.20.02.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 02:44:21 -0800 (PST)
Date: Wed, 20 Nov 2024 12:44:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, quic_zijuhu@quicinc.com, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_mohamull@quicinc.com
Subject: Re: [PATCH v2 2/4] dt-bindings: bluetooth: Add qca6698 compatible
 string
Message-ID: <smwxrjvdvyxw6tknucl6fb5jpjau2q4jcyjxpunbtt5ep6xsr4@ztuyfkrwgxoo>
References: <20241120095428.1122935-1-quic_chejiang@quicinc.com>
 <20241120095428.1122935-3-quic_chejiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120095428.1122935-3-quic_chejiang@quicinc.com>

On Wed, Nov 20, 2024 at 05:54:26PM +0800, Cheng Jiang wrote:
> Add QCA6698 qcom,qca6698-bt compatible strings.

Why? Is it the same chip as WCN6855 or a different chip? Is it
completely compatible?

> 
> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> ---
>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml   | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> index 9019fe7bcdc6..527f947289af 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> @@ -18,6 +18,7 @@ properties:
>      enum:
>        - qcom,qca2066-bt
>        - qcom,qca6174-bt
> +      - qcom,qca6698-bt
>        - qcom,qca9377-bt
>        - qcom,wcn3988-bt
>        - qcom,wcn3990-bt
> @@ -175,6 +176,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,qca6698-bt
>                - qcom,wcn6855-bt
>      then:
>        required:
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry
