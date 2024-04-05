Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63839160865
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309960; cv=none; b=BM71d9tCJJENH+B+jZebyxmkahI+uPH+WMe2bYlXE9FdmVStVW00Ag+1taS6otiXNWUTUk+R0vWxYt3OjgVgUQ0fbakpjyjsZlLElh1Sw8oqEHSo10tPWL3Bu4GnvV6Co3X7jFgEqyeh8U/40pYXj9pLrgWWfI3UXPnowCrkrTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309960; c=relaxed/simple;
	bh=zmndCcYKR9wkId2+6XojaBfbuykMPOBN0hPpSrc94lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iW3QBdnlZ7rDRsraUpWWXgowuqKkwILcwYpKYwYgpcsYHjEk+2e7I/u980WdIqq+MZvdBQ28Fke0JUgvzEe0zPQAgOKB5hjVSpYlin4x3/MOeuIhtJWGwaujwEK4CkINykvDt5fbctoH4fY4ek6NERBQMrEzQ+ReudTzyyFV30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dzcibRbS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dzcibRbS"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso2337306a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 02:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712309957; x=1712914757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vOtuMlTk2m3YNZ5+uB4sYTifNH5+qhYv4NhFn5r3qQg=;
        b=dzcibRbSpDrmeoco+H/zL83NFWNfBfsgZlITs+Wuf2NcM2vqsKaMWABaXMk2MZxoA0
         Z+KsAWm/hQx0b8OXJsUALxTsi3AlA9RDbdgZZdc34HuOZPejH4Xen16CqsMQm3TBdDl9
         Ix6D6KyuE1L2CRVh+flY3ITWhF4rspwmaqSqVP9Ve25om3bk/CC2XuFDU/EOPDgXerKD
         pOMX44axJpKh6S6B5WZnyab5ULM7mY3CyS3cNBmJIF5ugrAtzY3djL5eIB1tiXBrUMaD
         n2NtRY037yTTlA05yAkAp6xPsflf2vtBoSB+PBh/YO39C/Rd9j6YgisJ3C9qm4dSpKFP
         PrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712309957; x=1712914757;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOtuMlTk2m3YNZ5+uB4sYTifNH5+qhYv4NhFn5r3qQg=;
        b=Cpjj2ca4tktDtdFRVxZLWgmq3m7sQOLL/OGFinc540rocTcHEOr39LlQQ44xhPlohq
         R6AAqwx0x/SyA1o3JVa8zm9BScpyJpIdeKS6kVf2/9nil7MEqI11yLttwF0MfqJRqpg4
         9By3wCgV/YFEAZo7lJh/kcTZksypyuWpEnUyhd0sr5VPmObDI85sRivhI4quUyufwRFm
         0rbH5Gld5Md/wGdeE4L1zVcr9gmzI3BGiqrdAcfkEKZysa/5amcRefmswA70yRbZFbHA
         d3uXEff4DxN2WHK4+udRyqoFtNg+FdgtWbTA4/4h8AcWjYm1NkKXgEMrEuZbgaKmr66y
         0E3Q==
X-Gm-Message-State: AOJu0YzdrLaGwgtj13yqifAe2jMk2j8opOZOJyldGdfzpx0DK9YaBxEu
	mp7pveqJJ1wOqYSWL7oocRdCGRFspf8GhGkv633vj7BwicKlMPYgxmIpJX+pI+Q=
X-Google-Smtp-Source: AGHT+IGQ2XybYMZzpX18d1hysEX9de282AhfXEgp81k7S5Zoi3kly1NvF5Qmy1EVfeHG3MBTngIxDQ==
X-Received: by 2002:a17:906:f909:b0:a47:3651:a302 with SMTP id lc9-20020a170906f90900b00a473651a302mr565941ejb.42.1712309956654;
        Fri, 05 Apr 2024 02:39:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id dp13-20020a170906c14d00b00a4a3580b215sm630272ejc.80.2024.04.05.02.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 02:39:16 -0700 (PDT)
Message-ID: <610f5770-b34a-4c93-b9a7-ca224aa91089@linaro.org>
Date: Fri, 5 Apr 2024 11:39:14 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: net: bluetooth: btnxpuart: Add
 firmware-name property
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
 luiz.dentz@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
 ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com
References: <20240405090118.582310-1-neeraj.sanjaykale@nxp.com>
 <20240405090118.582310-2-neeraj.sanjaykale@nxp.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240405090118.582310-2-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 11:01, Neeraj Sanjay Kale wrote:
> This adds a new optional device tree property called firware-name.
> If this property is specified, the driver overrides the firmware
> name hardcoded in the driver source code.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>  .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> index f01a3988538c..25c258212bcd 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> @@ -31,6 +31,13 @@ properties:
>        This property depends on the module vendor's
>        configuration.
>  
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string

drop, missing maxItems. Look at recent code.

> +    description:
> +      Specify firmware file name, prepended with nxp/.

Why with nxp? What if firmware is stored somewhere else?


> +      This property overrides the firmware names hardcoded
> +      in the driver source code.

Drop, you now describe current OS policy. What if U-boot treats it
differently?

Best regards,
Krzysztof

