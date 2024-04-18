Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53417AD95
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459142; cv=none; b=G6tSQlipqUwLDDgJa8uMEP+3jEXxmSCNsu7C5EDLqyYtALv/vW4ww5eYV6V5//vUEu7UiWL8ka+7hsl/eCUFmnugrXGcZmTCOTgkNhXQ0ime9YfPMf+8kroCNdKCV9Po2lI8IulpOy1ePSj8ie/3g3fAO2MkGHJF4L3eF45nU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459142; c=relaxed/simple;
	bh=p+f5BqsCuyuXdH8CWxH0s6s1SYlRe++XzL/gBaHOyQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5o6atfrVi+ofbACVq0w4VS3b3tWt9OdnJnwrOxK1t2OeYA8cf33GWsZTpMb2B9zfHQ3LWAlx1gDfbk3IYvP3nAPoBTPBnWJBNkyz/s8zRxQtBng+kFNBrCbdNGpDYIc/8r4EzbceP4vL11V0MpVbV/qURIpGJv39H7wbdRRVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qlldj5dL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qlldj5dL"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3f6f03594so9358345ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 09:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713459140; x=1714063940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MaoNg39aIbOmp4V/POj2ywIBvg+Z3cRq2fCUNinDFCk=;
        b=qlldj5dL9UGBebynArWyK2hS4kwFJcLfkrCvGTpAwpR3aNXJ9FUCPc9zliSArLTXLB
         eK6fkZF8PgVtbkbqa3NRp6XNhfcYmymc3BMKT+O3UlF8ZKI+4vTAYOEp8JXf7y7JQFtp
         fDOimdlLiNt1ukARwmGNN34RzNW71SHnjuTlpwiWswe26hHaJK5SoHId7T42bZykAM8L
         2zLd4vczoAMm+1mGd7sdHlg3KZ4Z58nHnsm3++1ZIqjrnjWgvIBl97IOfACX12FelaR+
         loOeeF6qCgFJm/nDjH1ua4B05DDLtj4SFvA0SKRDR/bXGQVFEJfQmObeAJS4I2v7FPmn
         Mlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713459140; x=1714063940;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaoNg39aIbOmp4V/POj2ywIBvg+Z3cRq2fCUNinDFCk=;
        b=lFaPuDIyxaN9bXLgapdbGUeIcYuPZA9SYTZXoLfnwj/UqNWERMiKjMSSzh8r+9AZQH
         Wys6XmmFraspBMCGXOP0u7e2x3OZLQQN+max3Iq+7/G2PoD5DwmYwPymjPkvxW9/inNK
         RqcdPfxw/sl9YSDO+Gyv1dOkuxI3BHIUcvwkGa2v+4TDWHep+ODvOtQuPUfh8dlbT4Hw
         /ZCHQENLEsbzlNGDrGoSHw6BTlekxfjo34T4c1eJFhQYYI+syPOXWWYEJT6PGqvFiFAd
         GFiHJEsLcyGMWW1QhCeVSJu5zsIIWjIOO45KhsCKPXXJJoiiORwhecQIyzSI1pJpX2Vw
         M8Qg==
X-Gm-Message-State: AOJu0YyRwJaoFgsJJ/0untJqYOZ7TmGEnnlmNPhgCTmQBbX0ZLdUkVhX
	o7XW03HNeA8VG3ZmKYJQ2vm3999wFCC/tLT9v1BmohxLweAy9gZ4PSFooSE+xeoEwziBYIYYfyh
	pleY=
X-Google-Smtp-Source: AGHT+IFphVchPcnKYOJhEM0kJwf4Edh2fPKM0Wi0zFJkqHfw7EpNuFxj4ZqcGe2U8ACbUoKOcKCS9w==
X-Received: by 2002:a17:902:760d:b0:1e4:8870:7758 with SMTP id k13-20020a170902760d00b001e488707758mr3034473pll.39.1713459140199;
        Thu, 18 Apr 2024 09:52:20 -0700 (PDT)
Received: from [10.36.51.174] ([24.75.208.147])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b001e0b5eeee41sm1748445pla.38.2024.04.18.09.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 09:52:19 -0700 (PDT)
Message-ID: <83a1c837-e403-4da2-83c6-ee3dedbc1fe0@linaro.org>
Date: Thu, 18 Apr 2024 18:52:19 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
To: Zijun Hu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, wt@penguintechs.org,
 bartosz.golaszewski@linaro.org
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/04/2024 16:06, Zijun Hu wrote:
> This reverts commit 56d074d26c5828773b00b2185dd7e1d08273b8e8.
> 
> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
> with gpiod_get_optional()") will cause serious regression issue for
> several QCA controllers such as QCA_WCN6750,QCA_WCN6855,QCA_ROME,

The pin is required on 6750, 6855 and maybe others. You cannot not have
the GPIO.

This is no correct fix. You provide wrong DTS and, instead fixing it,
try to revert kernel code.

No, fix your DTS first.

Best regards,
Krzysztof

