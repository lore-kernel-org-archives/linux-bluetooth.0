Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61D219D8A0
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099417; cv=none; b=cYP5xbRD2YihXfZ+S7ALnJFc+LZp+1db98wHUr9zElIbKVwc1SUvC/wnxGp8jcJ3kPNe72nfPUYM8A1iBJiAuqG3zz3JV1V8+Ar4AZcGQpNyh19/duhO1ONJWS2+V2jJ2fW7mWA2pu3in/4+bhvm60M84sai3/sDZ7/Sht0wg0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099417; c=relaxed/simple;
	bh=V+/MEtn3nVo+kVuLjA7VUTnQYml1jSRYhfqMcSBxIZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0T553tL2PyPwYHFsh/+TVUWswvbYWbonxYscd/Sc5PlzbAX1h45oJ20tUMuYtlDfun3iv+cAibjmhOFmkGxa3ciwq7G4PmBXPT5V+3BlrPfpotR3uN6v2NPEIe2Oz1aypiWLONaBXtY70kyB3Ft9GmT2TAfJ59MbVl08wIjoiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CuDE3e9Y; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CuDE3e9Y"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53a007743e7so5985225e87.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 02:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732099414; x=1732704214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=56B0s+ajZzOmTEonufappGobLQWqg2YeuA0usKhiLy0=;
        b=CuDE3e9YmDLFvB4b78HezQWYQgjoIEJUDiOI1eFpq0Of5RRzfuHMmqy3/gmMBOvObB
         phpGUN4uacvXFAzahZ15G5pplfB8U7mx/hUaYWK5qMSeAZjs7MROkea+ZvKGRqb2+P4Q
         boD1G96ooU8+pOACU5TSjgANjDbFSNwD+Yi1zxeGGeloocY7g/461XYB+S2Q4i9lEP+C
         pbXI2rTD6VdaKwOerlXndK6dfUilLd9eeKTj14M3Tszt8Xf+BNDA0jw4Ipawvyta8L1o
         47xuYv/7RxL79aI1Bw2/w2PhfDgNPrFnaJNJgQjtSjMKJbBxpRXDNXe/nRLrcNoBq8Ym
         a5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732099414; x=1732704214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56B0s+ajZzOmTEonufappGobLQWqg2YeuA0usKhiLy0=;
        b=SEivUS/ihU2baYlHrPqWbUsRAxUp1Awre2uebn939+FN1JwM5/tDxgLUqqAdJPYztp
         DUdSK1z2Bn+N3rWqPQZLbsxvrvO6XiycwXkbm0m+KDtwWZqcbTnBfJGna/0fAcwWIhUB
         yWXFdElNgutFvOMfUb4IduRnEh+2HirPBNmLL/NypCteLwYFhgQWp+i2DGgTYnQaRZ9d
         PPQdYykYTNAyWtVl/X7eeISYYzzJKTU4fJiP/5Z2CVh5xLCiZa21I9vTomdfFV9c33Lx
         07e5/12o7IqChfF6bwU5NOgpXA20h3AyA7TYdrW3EGR85uTMCxNTL91moQDIgqJHxn4f
         VhcA==
X-Forwarded-Encrypted: i=1; AJvYcCUBfq6fb010XWu7YqcTfRDicYHYr/RkrIjGFHmFs2Jjra6C8u8dZjLkPihAXgKlpHBTMdSFgZZwjnDrYayrrxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcsY54Zwxxo4krKQUfzDoC/P5gWwbRYkCMcoq1BfMjesnj9y6R
	l9ebOwJ2gqbnhMDWKfz7GRBru0L/DcLGRdWUHe2LfhJ8liKfXWnyBqgbFZC9wS8=
X-Google-Smtp-Source: AGHT+IFtz95KHAingBu4+6JxpvwiZFXOgLDbTsR4XQYWIXQ/wmYoEfAj4pt85XX8+TRQgbgS5MkOKA==
X-Received: by 2002:a19:8c02:0:b0:533:4689:973c with SMTP id 2adb3069b0e04-53dc13343ddmr608112e87.23.1732099414065;
        Wed, 20 Nov 2024 02:43:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd3edca6sm591093e87.27.2024.11.20.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 02:43:33 -0800 (PST)
Date: Wed, 20 Nov 2024 12:43:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, quic_zijuhu@quicinc.com, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_mohamull@quicinc.com
Subject: Re: [PATCH v2 1/4] dt-bindings: bluetooth: add 'qcom,product-variant'
Message-ID: <454tdpuglu23nmxfqqesv42h5rk3vqiji7spo3naf2djqwojqt@6x3ram3lnlkq>
References: <20241120095428.1122935-1-quic_chejiang@quicinc.com>
 <20241120095428.1122935-2-quic_chejiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120095428.1122935-2-quic_chejiang@quicinc.com>

On Wed, Nov 20, 2024 at 05:54:25PM +0800, Cheng Jiang wrote:
> Several Qualcomm projects will use the same Bluetooth chip, each
> focusing on different features. For instance, consumer projects
> prioritize the A2DP SRC feature, while IoT projects focus on the A2DP
> SINK feature, which may have more optimizations for coexistence when
> acting as a SINK. Due to the patch size, it is not feasible to include
> all features in a single firmware.
> 
> Therefore, the 'product-variant' devicetree property is used to provide
> product information for the Bluetooth driver to load the appropriate
> firmware.
> 
> If this property is not defined, the default firmware will be loaded,
> ensuring there are no backward compatibility issues with older
> devicetrees.
> 
> The product-variant defines like this:
>   0 - 15 (16 bits) are product line specific definitions
>   16 - 23 (8 bits) are for the product line.
>   24 - 31 (8 bits) are reserved for future use, 0 currently

Please use text strings instead of encoding this information into random
integers and then using just 3 bits out of 32.

> 
> |---------------------------------------------------------------------|
> |                       32 Bits                                       |
> |---------------------------------------------------------------------|
> |  31 - 24 (bits)   |    23 - 16 (bits)   | 15 - 0 (16 bits)          |
> |---------------------------------------------------------------------|
> |   Reserved        |    0: default       | 0: default                |
> |                   |    1: CE            |                           |
> |                   |    2: IoT           |                           |
> |                   |    3: Auto          |                           |
> |                   |    4: Reserved      |                           |
> |---------------------------------------------------------------------|
> 
> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> ---
>  .../bindings/net/bluetooth/qualcomm-bluetooth.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> index 7bb68311c609..9019fe7bcdc6 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> @@ -110,6 +110,12 @@ properties:
>      description:
>        boot firmware is incorrectly passing the address in big-endian order
>  
> +  qcom,product-variant:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      specify the product information for driver to load the appropriate firmware

DT describes hardware. Is this a hardware property?

> +
> +
>  required:
>    - compatible
>  
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry
