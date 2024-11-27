Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FBE1DFDE
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715583; cv=none; b=F4JePYX2jmZ9c+yemMvi+GWdxWGEX883Scsxv+7PMitUGEIWK6jy5q3aoygkJ6YCj7sRLR0sbIW/zF1uZOeAc3Y4ytYjAeBssezhQOCbdxlhvo2JKNDOKQ5Jx35VJTOMz0bl6t+cHrDV3Bk9sFMg5NNUhXTaZt6AxJDgqnI/NuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715583; c=relaxed/simple;
	bh=4Cw79OlSsmeWvc5FvG9UqEOqdIJZu1hBHoIJTBQ2WY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gk/gP+jFI5qIMRzl3OrJ2tx4PVKPQgKoUMGb7H39b40nZCFNoR9Syt/i8jUKVQzSnZEUAf2u/QzL5J2HHK8cTZ3GHLCrNfDoxs31L4numo+FiQ2DnRbmT2DtZ+UWd48bvO9je9wpIUJ7VJk4bT7b01m2snCd1vhqE4zRyy+rqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jjlTojNI; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjlTojNI"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53df31ca44eso292597e87.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 05:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732715579; x=1733320379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C4TAQTX45KjbD07bV+ebD3Bm2L1TSD7dI4Xlh2Tdxk8=;
        b=jjlTojNIO+qNFCKQKQSqC/qDcfYbUDzhnbbmLIs5+NDriUQn5HY4m9ILS1SKSlqBvE
         qH2m8BHLwzfzVH7JFBcClX08/3LfpwnbdoOK4YlFGXgUHfdFE6oYVgmrGYmbk6kdvrTb
         po3gk8fYwpPUScdISpxnJpNmxhJuBfLLssN9ighsBtJHIv4ZaDxHk4WiQr2Me0vD2NXq
         ZQwqejJ3C2soZDSerXVr0fE2z18fAoC4JPgplL6M2P59fiToSLkzsc8kqCsP0u2F2b78
         Dj2D4FoP90w4TzJpSB2p9UA9jK9+kHKs8n4ToAUsCm8WZ6fvrtOu05tBhLdUaEyg34h4
         ZYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732715579; x=1733320379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4TAQTX45KjbD07bV+ebD3Bm2L1TSD7dI4Xlh2Tdxk8=;
        b=mByG9qb3F8vxQpN9sztuJt5Sf8uXg5Eug9yC78Cs2+z2OWKV/zervPuj4Q+32WUvZ6
         Oecash1YVGiicKyBfeWNxVAyB9MzdkYzi+D3seUsgwsDGABOLRLGxSE3+KgcERslnoE8
         kiqpyOUi6DlLzPoZ6EObwXfyriXudFW4iV51mZtiO4Us5053V2ZLGikD3MlKnJ3RUxMZ
         yZLnqbR+o3UTNGPeG+mkozY+2gAinWKIttTefQPJy/543bwOLWtowpbJ8sMc18g5iVJk
         KpJ7X322jgcLhCLAmv4IHLWXga6JNxcW0naI7nsdU49vabJOxbvVQLMUI/3EsJNp2mVw
         sUjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUVzg/mfGbygaIxsWzs69Jijpmx8N8GUrhEc6QLg8Z45rZp2YeXfsWA1e30KXJ3adgdmQRLtrjvsgmK471fPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL/pJ3C12TQUFgm2tqFLnTTZOn940+1Au8jbIvYdoBdtP1bQAN
	/YvAVfOtDUf0HRpWIvQoTtuAwMjaPj7II1vXzvyS5o/o8JFR9Q9ZexWnEBkkm/Y=
X-Gm-Gg: ASbGncsLslzsE1mbapsaZCYYNQs+2bzF8daTY4CN5jYYR8sMsyuHzJtDbv5xQgHRyJD
	bUBJb+REnbnYogzj/N5H8/311YCCQj7IQW2u9WGzxw5Lqvn3mF/hh3Cg7dFBswIuPWN/g7dV4N6
	4w+Ml+b3ijPnqKjXflCuN2MpeYr6NqczDpQ5nii++MgvAB+b8tbwqShktnw2DVd7iSyQvFNa2PU
	bZhquoAdIc2aMvO9TLtuEirPE0SR4Yph3KACyDU5GRGRtFFn7XS8goVr2gA9+vhB9ebErKp9jOJ
	ciiLYsxH4mzv2aHBaPEs0FQ5dmFMjw==
X-Google-Smtp-Source: AGHT+IGYADuFA26pMJrHLMzO1jvXPbYIAXbhv0Ob6Xw8c8Ir7HGjlq9gt3AUm5PCW3k8fSZi76WMOQ==
X-Received: by 2002:a05:6512:3c89:b0:53d:a2cb:349e with SMTP id 2adb3069b0e04-53df00c5ebamr1944019e87.4.1732715579361;
        Wed, 27 Nov 2024 05:52:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24518d7sm2314321e87.80.2024.11.27.05.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:52:59 -0800 (PST)
Date: Wed, 27 Nov 2024 15:52:56 +0200
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
Subject: Re: [PATCH v4 0/2] Enable Bluetooth on qcs6490-rb3gen2 board
Message-ID: <sntzr75d3by7ignomcrcsmzqdtbikonyuwj5niccuenoxndaxb@vhu5en6hetqx>
References: <20241127115107.11549-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127115107.11549-1-quic_janathot@quicinc.com>

On Wed, Nov 27, 2024 at 05:21:05PM +0530, Janaki Ramaiah Thota wrote:
> - Patch 1/2 enable WCN6750 Bluetooth node for qcs6490-rb3gen2 board 
>   along with onchip PMU.
> - Patch 2/2 add qcom,wcn6750-pmu bindings.

- Bindings come before DT changes
- Driver changes should be separate, one patch per subtree (so one for
  BT, one for pwrseq).

> 
> Janaki Ramaiah Thota (2):
>   arm64: dts: qcom: qcs6490-rb3gen2: enable Bluetooth
>   regulator: dt-bindings: qcom,qca6390-pmu: document WCN6750
> 
>  .../bindings/regulator/qcom,qca6390-pmu.yaml  |  27 +++
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  | 174 +++++++++++++++++-
>  drivers/bluetooth/hci_qca.c                   |   2 +-
>  drivers/power/sequencing/pwrseq-qcom-wcn.c    |  22 +++
>  4 files changed, 223 insertions(+), 2 deletions(-)
> 
> -- 

-- 
With best wishes
Dmitry
