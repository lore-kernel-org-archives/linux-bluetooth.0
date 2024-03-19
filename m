Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34004085B
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710826921; cv=none; b=kdXEX875eFoCcP4v9ohYJMIxa4jFagpGW6Qbl/vGWYcguI1zsPbt90hw6YCNqFrKkGXnMDaQI45XjwoMA6THFilPpvF8XwW+MVKUaAZaxM04p3ZavZYSVS2/+rCbydyPDwxy13fhx+x1zldPhzoTqe+TW75UN1MOcRUvDp1H2q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710826921; c=relaxed/simple;
	bh=w92aU9nzDJvbswofHlp0wPznG691YDWd5c5XMUjZ6cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjGgapFK8/xSB5aw1PBv6KT/EadY8bc75Aclk9tEDYUyZ0roEY/J5Vym2jEfwjCfIoqkNbMv4IFy38B3YuAWr/cYWzUxhtptx3nzdUn7la8i+IdNmgxzkz4OT4xWRqYkKR6rgJ/rfetNKi43oXPRulfxc++ks1Oi1ArQ8k+flVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Us4B3Rd1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Us4B3Rd1"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46ba938de0so263574066b.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 22:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710826918; x=1711431718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ie3Z4Qm/raSpZh91B3REFPg2FqghVKIUu65GHuxup64=;
        b=Us4B3Rd1bYphFwzpufgy2XZ1/tJ9pzg6RD89wmmkLL5pDhKawL/10rw/aAyUGIcBIn
         aykR55+tD0liROrW84cE490326Ac7Vg8zXTg1/mqOf4a6+IPdiYp6X6n9t7a2qU0zbYV
         htO5ynkeoZYWJHUUlHPpDoZABdWCaxveeLmKrve+t6esDTlL4HNY+vVWI5jGDMIe/1S6
         cSFd2bP4RkmElwy9qcvoXRURSYF9YftnEscCJ9NIFyOJXY9vR1D1p9BPlk7rzFprh1vw
         plhzRPZqzYYjVcONmW5CfymX1PhtwEXArjvIDe/kYDfbXZ9Ak5m21hq8JSq4tapyjXlX
         N+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710826918; x=1711431718;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ie3Z4Qm/raSpZh91B3REFPg2FqghVKIUu65GHuxup64=;
        b=e54TEMwJJF0POVRJSBeTGQXCUmF0uNZttp9emjH03IxVKB52uArxI4RW3OIyWqm1zx
         3C7nAlN6zlh+TsBBdggmY6nGGPc1MhRkO5jBhZvgOKBQ3eZAq6n+VAm5R9bHjBEDk67W
         qXe1WYsg0qnJkAZRFWEKWB8qZM5x0Ejg/mxBbBJ7EsMZseFBmlEsK2Aga0U9fXTfpz7o
         YfiMbIsHDEqCOGFn0lK6SfREPLMhW4Ul/fVgaODSWHTF1WZq/z2nwTu5aOUweGzE0ct3
         RAhTOvtWx2GJhTLfd9JX9xYVxxuM/5d9lBAH+sfmnTD7S9UX1JNuCus/oboU2Q19CZ+u
         D5Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXBCAXB43S9ycGlIu6D6Fvg3H3vjWAp6SRHll0Dwf5TskDat59/eq9pufP3xledAqcUjWiTkrLy2F7y5m067NzBXAVEGdy8Gz1q8dS2psuX
X-Gm-Message-State: AOJu0Yxu3Ran+SGhwf1Xxrrm7weSgymhVgX+/hS3rvK3qa794P+KwoOI
	sI8BPVwFoD0Is9t+4WIEz4lYALSxAC9etFD/C/5uZvmznJpJWc7XaB+Am2yoNgc=
X-Google-Smtp-Source: AGHT+IHKpU0t9duPevXb3cdz776i2ohsJaEngFW6R0lR53HhyzpC02sChGFgun/2aqbWUSNJ610gtA==
X-Received: by 2002:a17:906:4554:b0:a46:b8ed:8a9 with SMTP id s20-20020a170906455400b00a46b8ed08a9mr3980058ejq.55.1710826918354;
        Mon, 18 Mar 2024 22:41:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906845900b00a449026672esm5637429ejy.81.2024.03.18.22.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 22:41:57 -0700 (PDT)
Message-ID: <97eeb05d-9fb4-4c78-8d7b-610629ed76b3@linaro.org>
Date: Tue, 19 Mar 2024 06:41:55 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT
 binding
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, linux-bluetooth@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240319042058.133885-1-marex@denx.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240319042058.133885-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 05:20, Marek Vasut wrote:
> CYW43439 is a Wi-Fi + Bluetooth combo device from Infineon.
> The Bluetooth part is capable of Bluetooth 5.2 BR/EDR/LE .
> This chip is present e.g. on muRata 1YN module.
> 
> Extend the binding with its DT compatible using fallback
> compatible string to "brcm,bcm4329-bt" which seems to be
> the oldest compatible device. This should also prevent the
> growth of compatible string tables in drivers. The existing
> block of compatible strings is retained.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

