Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC91119A
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601352; cv=none; b=sy7TvzOWmKtqNLVQv1XRIMep4zbFjRckNEI/AFyLE9zeiiuV45bUTJtjQmOoHiAkBSSXfww+0heNdv48CArauDlPfW53tb92i3hFwD2CbwQF5hXvXqgWX52GoeGiCT53wmpFluEK7O2xE9f2px6ZDf6YD8wcPKf+wGkVyYf39bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601352; c=relaxed/simple;
	bh=fsr82+X0HB4nrPlRbD7u+9xerOPWF4UuOixB9nbtbxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlfrGBA3y7cVEH2wE6XSGpjfXpu8E+wjJyz96BBOLnqi/8bcB+VA4Ncu3ShWVdbeKnvNVvCD7EjlRQphtFmc3XTjpAwQww/KSFrrh5ZL2hjKY38RkR+zPKpQSGC4poV+F7ozmu/G0ucIb94CfTGasW/5PifLVSYsGqewDKDJdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=fd3w8MP2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="fd3w8MP2"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3ca546d40so23102115ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 11:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712601350; x=1713206150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nm8t/x2uwmSp1PQu1GfRMMntuaVcapxgFKyhLMy4YmY=;
        b=fd3w8MP2LXW5XQ2dYj4rk8JWQsTZGK1f30btAzsZplAIqY8Yz0pHjSyf8Rg8nwk8Ac
         IVRAHxUrfASAqLsV0lM5ZYK4aIwTGrvSVIrXxFieZSHyrTv4VYCmJWRDvRikkMiIzhwC
         qcNUVyh9as4ZWXG5OFspIWN+/w/dKKesapNrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712601350; x=1713206150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nm8t/x2uwmSp1PQu1GfRMMntuaVcapxgFKyhLMy4YmY=;
        b=cL4ivAsBpLUxJ1ZzTdHG2S95I2GKRnoBIGqisnqze1uRU8Qy+fglyufmRJ0iuYARZh
         pm7Ly+nesyXBby3iAn0zk8ws8wgrA7Dwbv+7LB57WhQhs3yKo9hweravc1zojQeHQ+it
         HAAgfajjmfl5MbMixFwfxJSh/JHXp3YSwdcwcD/WkU8zXaRSWeShYMIx0f+C8Y2P7klQ
         ugt/Qq/2Bk4amWGFUAiUh2VxZUtzWwQYwBIdIU8nfG8EOntZX4KBb4WbT5F5iDcxCg7C
         kHy7hRbnlfaS2Z/atW4wi2H0kT91AAMBvyhoe+qD3AauUmw0vqyXxFROaR3tYARBS2Z5
         Z1uA==
X-Forwarded-Encrypted: i=1; AJvYcCUJpvSrS5xxJc/4HEAb+hKu1sr1YBZluuNEQF/xMLPRHcjDhHgOv0IrqiUemYf2tx/pv5ifufnoc5H17d9UX0V/C3eGlcgkhH7+emV7syib
X-Gm-Message-State: AOJu0YwxslId0ucB0mi8vDdy8quLcnsrgeuBAf3NwFwii4htstolIMsa
	/WWzwh+RwjWkOj6csHgblTybuzf7MI+QgNPWYm5MgxctitOGTAWvLgDmQ6fdDQ==
X-Google-Smtp-Source: AGHT+IFfnkAR7C9SXUsEI1m9SG5HvTsx7iGg0BYwfHhXYsFcaNk5AN/AUuIyVkavDJsczeKsWxqukg==
X-Received: by 2002:a17:902:a386:b0:1e3:dfdd:21c0 with SMTP id x6-20020a170902a38600b001e3dfdd21c0mr5723950pla.27.1712601349724;
        Mon, 08 Apr 2024 11:35:49 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id kj8-20020a17090306c800b001dd69aca213sm7340841plb.270.2024.04.08.11.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 11:35:48 -0700 (PDT)
Message-ID: <99e404ee-81ca-4dcc-811f-9c55fc52c551@penguintechs.org>
Date: Mon, 8 Apr 2024 11:35:47 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 bluetooth doesn't work after warm boot or
 disable/reenable
To: Kalle Valo <kvalo@kernel.org>
Cc: ath11k@lists.infradead.org, linux-bluetooth@vger.kernel.org
References: <a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org>
 <31bb6e18-ecee-49b3-87d7-50ab53e07447@penguintechs.org>
 <1b3d3937-6679-491e-a5c6-818ae8ac639a@penguintechs.org>
 <87sezwjums.fsf@kernel.org>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <87sezwjums.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for letting me know. The wifi is working great. Thank you for 
your work on that.

I doubt you will have time, but if you do have a chance to test it, that 
would be amazing. I would love to make sure that I am not the only 
person having this issue, if possible.

Thanks,
wt

On 4/7/24 10:22 PM, Kalle Valo wrote:
> Yes, I still have that laptop and I use it as my daily driver. But I
> don't use Bluetooth and I don't even have the Bluetooth enabled in my
> .config.
> 
> BTW ath11k is a Wi-Fi driver so most likely it isn't affecting your
> problem.

-- 
You're more amazing than you think!
