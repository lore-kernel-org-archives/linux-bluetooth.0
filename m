Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDAA163
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Aug 2024 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057783; cv=none; b=sz3HSpIqEKfNZDeaL95Kr05lCb9wsbvMHmv6TFFgZclzZ+Dl0VlRiF9dpHg6vU4z6fKzEwMrxJ1moU+bWrn26QjHFc2O3KEB7R3vuj9EhGh2FKiLVL5PaeMzOi+W+LjBHfK2kupLB6EwWxNZtr0edNUdw1pNpJFKPnUnamqbjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057783; c=relaxed/simple;
	bh=665V6GpuKcYosGxkSGgs5JFtAN6ecNLGWm3yl28vOjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0Mzc7cbkTUUnr0Kl3P9+qm0IjI7eozhdNpw9EUTuMtKS+12N6l/1NWpUXR5eTgUhTZTTunBGHLh8m0pBFA/bSRvl7JnXOUBLj8/knMLkSTYt5YE4Wtfa7qIeScFlcUf8zeviohlmebbM+z2tJ4NBj1Ur+9nPCl4iXzgMgc+pGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=KWvGPu+T; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="KWvGPu+T"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7104f939aaaso191621b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Aug 2024 12:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1723057781; x=1723662581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNFT4KC4ST1CTLnmvPUzLWyegQdM89SKEORmSJFJTX4=;
        b=KWvGPu+TS5vmmAj2iQa7fYl+qaIWuGrQIZkiM2nBfemNzK9y3sS2qmYOpagATt6hjx
         DlGfxMGZ3EcZ8xfK282vpjbsRzTfzOfSx+ANr2xb9QBWoto8oBr1qjMz2sCI5bAGXWmn
         5r7QyJTLpsFC2XYtiv9qD28txCt4ayaIQ00QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057781; x=1723662581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNFT4KC4ST1CTLnmvPUzLWyegQdM89SKEORmSJFJTX4=;
        b=AirO60mQUP//gQvNviKrxBIEl1zRPc+LHCpG07HsM3TOljd2WL71y27ONHHwPygkdg
         EhAi08MGVhKHKfGZNTGZUdFFtcnaCadN42zblBJPvxEzEDWnE8QIx+BRMW328oFXbPFV
         4dSJQsKE25aj0wO0Z6MNkZ+3f9K4H5y7JXNdMWaMIPn2gXqDHrbjAxQ099lPGeubawus
         ZbI2L4bUHDxANVHmOTjQBV1nK6NtU08Fnqe0oWxuuCdilxJErs32WLW5ihxS69jvx+9m
         ef12buU/CrBfKm2IuiZHR8xwtGuOVYdXgsl+9UNB6igzhBmgRMF1+1+d6FrtoRrC0al1
         GFjw==
X-Forwarded-Encrypted: i=1; AJvYcCUIHKKGBxZRR6UXrXZ+oAu+zpyEzfgNHcVE8DusJC4DZBrzXdTevmRGr6d4ZYYq292VnJvi4qjPBN6qhq/6rC/spW3hu0x7hlGRPMiN6X/I
X-Gm-Message-State: AOJu0Yx/FbyhsD6nfml18b7lzkkROpbCoEcBpjOeY3z7gVdleUE0siQ9
	u50pvbEmmAtVIayM9hpxW0ijdT3MjBQLliGjjHRzfUuPw/VHfNososMNpTwFKqoHagI6ofZveh3
	nBlbV
X-Google-Smtp-Source: AGHT+IFHaj5wmHCRYIyICHWw2PDkOtSbvnqBki+fv41wkCuVHTFqZ+Xbandv0IN2SZchWx+iyQTZbA==
X-Received: by 2002:a05:6a21:3989:b0:1c4:9f31:ac9e with SMTP id adf61e73a8af0-1c69960e243mr15826576637.42.1723057780573;
        Wed, 07 Aug 2024 12:09:40 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfc35csm8989130b3a.149.2024.08.07.12.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 12:09:39 -0700 (PDT)
Message-ID: <a3bd82fa-eb27-4a71-96d8-c768b9866bf1@penguintechs.org>
Date: Wed, 7 Aug 2024 12:09:38 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: fix QCA6390 support on non-DT
 platforms
To: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <20240731-hci_qca_fixes-v1-2-59dad830b243@linaro.org>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <20240731-hci_qca_fixes-v1-2-59dad830b243@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 8:20 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> QCA6390 can albo be used on non-DT systems so we must not make the power
> sequencing the only option. Check if the serdev device consumes an OF
> node. If so: honor the new contract as per the DT bindings. If not: fall
> back to the previous behavior by falling through to the existing
> default label.
> 
> Fixes: 9a15ce685706 ("Bluetooth: qca: use the power sequencer for QCA6390")
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Closes: https://lore.kernel.org/linux-bluetooth/27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Was this commit supposed to have a Tested-by: footer for me?

> ---
>   drivers/bluetooth/hci_qca.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index a20dd5015346..2baed7d0f479 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2412,11 +2412,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>   		break;
>   
>   	case QCA_QCA6390:
> -		qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
> -							   "bluetooth");
> -		if (IS_ERR(qcadev->bt_power->pwrseq))
> -			return PTR_ERR(qcadev->bt_power->pwrseq);
> -		break;
> +		if (dev_of_node(&serdev->dev)) {
> +			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
> +								   "bluetooth");
> +			if (IS_ERR(qcadev->bt_power->pwrseq))
> +				return PTR_ERR(qcadev->bt_power->pwrseq);
> +			break;
> +		}
> +		fallthrough;
>   
>   	default:
>   		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
> 

-- 
You're more amazing than you think!

