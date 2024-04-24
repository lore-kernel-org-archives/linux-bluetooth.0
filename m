Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D715B150
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964226; cv=none; b=J8Lplb3WpQBKBW2KRb7X5P8BzSvrgNORSNf4W3QzUfmCOBjGbEUEeCspP0TiY7NRbNvwk/7k3OL/NBVV/6/aFAknuz/3/c6IuEuPaSWIpj8g+RryROukC5CmrzJwNkeTDTsjPn3fT6tM3R+K0rbJz6NBReZEF5sfVgfaSmEzcHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964226; c=relaxed/simple;
	bh=OefCvQ2x2IZXcgNdABhPCAcs1PW3cTeYzxWmJEpDiw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvDjKoHvjhuxUP8SLGpQY16M8EVA97IV4v06SyFTJWo3eeepuXgkexbNvOSmR59pwuk0+wo3ADgxxNsY/+v2G6ZOb06V8PQO5gOdsjuLcm6DFauIEo3pTkkCqaRdrngUpsXEJuqi+yIJG6CxpGy7CbJUhUTjhfeDk/kExMVwXQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=PRM3mWPy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="PRM3mWPy"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e4f341330fso57727605ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713964223; x=1714569023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sydl+4yFYinKXmdPTE5nn5HGpzz6QFMBENvh2i5loOE=;
        b=PRM3mWPy+3RVNeSsfGkMdvomu9dVjir3bEAaNWBpOxmRpHfR9XKZnX6qlKGvRTevTj
         6BXvzPBAdbrNa7QfMoBDzico67O3DRUvT+Z/mr8gwSYObHgDuFjoPBCR9UrExEAxLmQW
         pdZmfex7QDQ7/o7vhgUoYJqKaiJDqqpD/PItY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713964223; x=1714569023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sydl+4yFYinKXmdPTE5nn5HGpzz6QFMBENvh2i5loOE=;
        b=HwjnnYQ69thg1PM7kMBREyRpadNOaJTCgKMblIXgdUYmu0Ie2AYnnU0wb95QWG2PKf
         E5mlLe41cxja+McSfN1HKra7O6crM9T+JwR5NngoA1EKeNNA9wIBQOR3Si9Fi2SDJb1c
         0kGBSAx+UL+XhvhPo9sE24dx/p8tAOC6K33GSRz8ZVHDAMg8tPn/8OmtsTRhC1+2a1K2
         B2VVzI+lzp9ycBjepXt48TJ/XQBk3ogFJ9F1cCWb15WNLBgtCrhp9gkecsFsKLbWSgVs
         VZUJUkMbkOVzPaw/Mc/g0p4Bpt6mN8VZ3smXdh9x7s/0ZgdHgd9es+CbReAhdthGaBcG
         /rmQ==
X-Gm-Message-State: AOJu0YxU5aPyRH74ki1VF8H5smHTTlEg44CnALfCKflQmX8NZSJZ1RSi
	vPiV3fFVC4hVfOeZeQIZtgKVrr/2I6ApymzDGK2XG9CAqDSMA3XcKYerqSWJzQ==
X-Google-Smtp-Source: AGHT+IENMZx7a5JN5bQLy2lo1eJGSELBdY0Fm2u/7eAZkB+kc4140yF/vjh6YqzxR99qe6U0lTo0vQ==
X-Received: by 2002:a17:902:ecc6:b0:1e9:214a:4175 with SMTP id a6-20020a170902ecc600b001e9214a4175mr2782600plh.22.1713964223368;
        Wed, 24 Apr 2024 06:10:23 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170903048100b001e2526a5cc3sm11830928plb.307.2024.04.24.06.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:10:22 -0700 (PDT)
Message-ID: <ba9b0e6e-3601-4460-ab5c-a02eb7708a4f@penguintechs.org>
Date: Wed, 24 Apr 2024 06:10:21 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240424122932.79120-1-brgl@bgdev.pl>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <20240424122932.79120-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 5:29 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
> 
> Any return value from gpiod_get_optional() other than a pointer to a
> GPIO descriptor or a NULL-pointer is an error and the driver should
> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
> power_ctrl_enabled on NULL-pointer returned by
> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
> While at it: also bail-out on error returned when trying to get the
> "swctrl" GPIO.
> 
> Reported-by: Wren Turkal<wt@penguintechs.org>
> Reported-by: Zijun Hu<quic_zijuhu@quicinc.com>
> Closes:https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>

Tested-by: "Wren Turkal" <wt@penguintechs.org>


Like this?
wt
-- 
You're more amazing than you think!
