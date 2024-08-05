Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF91547D9
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852287; cv=none; b=PEsGOt/umzALND/Q8JPdk9+d3vd3e0qdgAdJdlTMVLEMwNOleBth643a9nMrUIaR1BLhmtZa/lj42Y2B9Q31ZSh0hppDHxH0vG2pCuXgwQUhLX/RMPzzO553OLdnP4YpQT+Nkr2489hdZM7q91DQmUmQM0e4mNWU+I6x55V+CAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852287; c=relaxed/simple;
	bh=NrP89VFBY7rsx7EbXcSXKLeYzXolWV8BMUaTDdNiuIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r49LSYb/7KS3q4UBRKVKh3UvUVFJYRNZjtDXbSvxRUs4WwF27YqE83Zdpp1P9LCxk7eOaT7t0/OqMkNO94+z4GgdIs4azZ2CFjeS8UYK7pamFKYadBtodHlWE6fw/5ShyhtigCzaZC7BH/hUxKWFg/hxbGI8NT7ocUtS05lPGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O3TTsa+D; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3TTsa+D"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e08a538bf7bso4047291276.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Aug 2024 03:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722852284; x=1723457084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hSYGTPrpLH+BuhVL/Q/2E8uLKhl1KfRAsEdIshJ8Sjg=;
        b=O3TTsa+DOEhyRzwzJxdy1IBqByszFg6gCQwqgUQD/YS+eunwj3Okal63tnHQD3gFzS
         mklCASjot+6W+j97Q9xgl+oMyXSXffRPE8CpBS1WTM+6tDBfIZtqdT/xazSIL7wGnYi1
         z/lmgqcTj2hExLsPZ2dWUEHuNUmiVHEG1MlLjr0hxpxldcYNbiO+ACcjROcraZAdg8Av
         yEItCOtmHBCJCIez6ao8zHGxGWnbKuWU0un2VLkYOIVqKmybvzwzrIW6SvPANNZvR1v0
         Bn+AEWvutwS8jgZmVCDuKX0NDvqLA+PLLQDqsqk0KYPRn+J13KxhyrK/KuKNSL//s/tU
         kMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722852284; x=1723457084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSYGTPrpLH+BuhVL/Q/2E8uLKhl1KfRAsEdIshJ8Sjg=;
        b=RXi6ltkYsWxVodKNb6m+kEGLWuuJoYMm5qroQOAooeaN9I8JAlUW9ndyG01Cgioevx
         WKmIWcz0PjQxMHAILD/LF4u0w8yxqYWe4NPfRPla5G+YHVeETd7+wxH51mvqPMPlAKYE
         vPZkIAwGrtK+ZRZE9nW6yAm6LyvMgNJjR2IQrnzRn5GRFOrDFEUBejTQeIituoPKomJ8
         aEsVY5buShWhyTw6trM/O5gwqxljRMQHzAe7lziHCoycDzQD6a9UPAtkG15Sycg1swE1
         oqo+6qAc5nL2OwMmwJWdncJY+qKOvJxCBFnx2iyr+8tl8MhyTL7A2FSy7RsJqFAI9O9T
         7rpA==
X-Forwarded-Encrypted: i=1; AJvYcCWBmrpJ2DNjwys2KKMRtc/DRBymcN+C2RV+2s2QCnzjS3na4HuSKLe84thzySjJLsabaP8pg6AxJbp1ZF/Jy5Mx3mAORl/Y+SJB5NSjce+d
X-Gm-Message-State: AOJu0YwLpxYL8iVX8ECq8cbfGtlhi6za8d7/SFaMAaw0SRYQIF4KASMm
	PPBeHpgnoYLvPVe79RxzZ72IB5rw4sqZf8ZAcazPSB9ZXXDaXH8W3Am2YGSFbYxG1cM1TpRihSt
	IIqUJiBKrGDbLyTavqra0quh0/2PwnjXwGsRy+w==
X-Google-Smtp-Source: AGHT+IE28QvjYWO5xF3nlYl96xgvVqGoKpL4LpWlRu2pROebD4A3WQjuKfY14W5cvKLlfjChMzAEUCdDmxnejwKRHho=
X-Received: by 2002:a05:6902:2b0d:b0:e0b:bf20:4fdd with SMTP id
 3f1490d57ef6-e0bde8ee6f3mr10631170276.1.1722852284031; Mon, 05 Aug 2024
 03:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805040131.450412-1-felix@kaechele.ca> <20240805040131.450412-2-felix@kaechele.ca>
In-Reply-To: <20240805040131.450412-2-felix@kaechele.ca>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Aug 2024 12:04:07 +0200
Message-ID: <CAPDyKFqyRevbmPy6h8BsiTLBi6=J+9uRmSib43bzzZHFEmDSVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: sdio: add Qualcomm QCA9379-3 SDIO id
To: Felix Kaechele <felix@kaechele.ca>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 06:01, Felix Kaechele <felix@kaechele.ca> wrote:
>
> Adds the id for Qualcomm QCA9379-3 SDIO based cards such as
> the LITEON WCBN3510A and Silex SX-SDMAC2.
>
> Signed-off-by: Felix Kaechele <felix@kaechele.ca>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  include/linux/mmc/sdio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 7cddfdac2f57..63000a8f4b13 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -52,6 +52,7 @@
>  #define SDIO_DEVICE_ID_ATHEROS_AR6004_19       0x0419
>  #define SDIO_DEVICE_ID_ATHEROS_AR6005          0x050A
>  #define SDIO_DEVICE_ID_ATHEROS_QCA9377         0x0701
> +#define SDIO_DEVICE_ID_ATHEROS_QCA9379         0x0801
>
>  #define SDIO_VENDOR_ID_BROADCOM                        0x02d0
>  #define SDIO_DEVICE_ID_BROADCOM_NINTENDO_WII   0x044b
> --
> 2.45.2
>
