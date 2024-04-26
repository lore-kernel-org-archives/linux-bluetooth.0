Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5123E1DFFC
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142251; cv=none; b=izE2WLyPDO63C1IvcISsNi03LsUlObKF4CqUDLL125mp9AFp+E4hU6cHQI2HEkStA2GLuWumLAeTE8SiHkYJRd8ad+nOGAMTdb3kfvteJ4bMec7fgHZAaFDeD2RIqEmyUOc2YDt+lUPhKQhnJG/RHBWY9a7urORUS3PgZyNA7mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142251; c=relaxed/simple;
	bh=RWkXe7sRC3RxM96qd474TAOzOp5sMO+lDyyEXYj/lek=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0DRMP46UZIOuQ65Yb06mOUN0FcA18S6HSym5zsat7F3j+/F9D6ZmoVQE1o7Msw2FFJBPyzinuPTTUTYKd4cmmsxJ+ghUDMmsGdN2K4mUcW3blHGanh2wfKNFmGs8YwgkgISZk7nabfCvfuSIQ6rxOTXxHKXGcIVDckdxAXOo9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BGl4rSA9; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BGl4rSA9"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2dd7e56009cso28722441fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1714142247; x=1714747047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iyn8nuvs6hv5iFPafXpvUxP0UCsY1jeaxaf4MXYmLH4=;
        b=BGl4rSA9xihLx1c9X6ysaGOHI6/IMSUCXiKFz9iNvKxUzu9hfEw7fDFafUJF4ossaX
         Qp311eEWOGyCZ7cvmD8/h8I8jwB3r6gDAijEU/V8hBXvjBabmbknNphil22zTJxXvSG6
         QTzzOaAeSBoC5Y+s7DWB0ZqCuX7teL1D2SMdXyr2r0+Rbd6wclLfmJbe0KOKddAUfIbM
         Osb0Z/aE2dl3WqFOUIm3QA2uGAYTgUt0cbPM/p6F5/pyPpSC81BKsQ+cSLbR0QuT+BcR
         r0oatVlvHS3eairkbZhK0RHIb9Sq498p7c/3jrIaNrWEC4KShzf58bUDcfHHFc4Ltoa7
         YPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714142247; x=1714747047;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iyn8nuvs6hv5iFPafXpvUxP0UCsY1jeaxaf4MXYmLH4=;
        b=IEM3El2mTDHTfMa9z6g599zG39RrG/uzHDCjjjnEoIVeMZy26cKtPe2xKYbWsCNmJm
         KVUPUeWGHP/ub5zYJMEhK6iRJyIJUrWF93Upkue9DLr9ajqpTTwu2+cjMLoKfd02vqKs
         I7fkqzAnS3emSlWIwDO9E3MP0GEm+pQLqfglqC8eP9cpPvfpR97wf3ChDhoGg/vPnT+A
         4VQHlQ+LAuJHKosv7OQbjB4mhFhbG8fdAr9F2oRw3LZlYfxsfoNWRfqQm26gMl/ayFUp
         pzh3OldzFy+0a47ioQyCTO6wu+S8AjtZ3psy1j9CApWx5ZzXfNkdZRBz+oWaAyHRcd9T
         RzzA==
X-Forwarded-Encrypted: i=1; AJvYcCURpLAHSLloQzpBu8ywXsV4Yr0JGA2D/pyqk7UntLE69gwDyP3qr/eQPtnPSioOzwP5c5wYtWDYsobufZwrVYToRCkwycxOAtEw1sjr62KG
X-Gm-Message-State: AOJu0Yyo3TfMVcu06l16HDbmJzRjTr3JUGj4jWD5S9kpd8uKhk/rKT0H
	5SFO/A0xCFoFzAplYn/H9qD8ix/OnD06uAfCroU+Oflm9/nYXXsw2osn/lXpgQPAgd+oOdZEZu0
	XPPc/84OPa6vDve+vEtYAsuNVZ3c9zGcTfk3H6g==
X-Google-Smtp-Source: AGHT+IHrCKfFiPfM30khK14cA/XfmpqBoVCAT8s/zXaG67su5ZKd1ltCu9z1MZd3xSUsZNELz+XLCluNtJmaqkz6rOs=
X-Received: by 2002:a05:6512:1086:b0:51b:5c9f:992e with SMTP id
 j6-20020a056512108600b0051b5c9f992emr2424256lfg.14.1714142247112; Fri, 26 Apr
 2024 07:37:27 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Apr 2024 07:37:26 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <171397322792.12898.8815870206676100532.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424122932.79120-1-brgl@bgdev.pl> <171397322792.12898.8815870206676100532.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 07:37:26 -0700
Message-ID: <CAMRc=McMMtRid6OaYsc0PO0qsS6z+Ny127YxwNcjbo7R2Mze2Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: luiz.dentz@gmail.com
Cc: marcel@holtmann.org, krzysztof.kozlowski@linaro.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bartosz.golaszewski@linaro.org, wt@penguintechs.org, quic_zijuhu@quicinc.com, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 17:40:27 +0200, patchwork-bot+bluetooth@kernel.org said:
> Hello:
>
> This patch was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Wed, 24 Apr 2024 14:29:32 +0200 you wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> Any return value from gpiod_get_optional() other than a pointer to a
>> GPIO descriptor or a NULL-pointer is an error and the driver should
>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>> power_ctrl_enabled on NULL-pointer returned by
>> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
>> While at it: also bail-out on error returned when trying to get the
>> "swctrl" GPIO.
>>
>> [...]
>
> Here is the summary with links:
>   - [v2] Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()
>     https://git.kernel.org/bluetooth/bluetooth-next/c/48a9e64a533b
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>

Luiz,

I think patchwork borked when picking up this one, here's what the commit
trailer looks like in next:

    Reported-by: Wren Turkal <wt@penguintechs.org>
    Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
    Closes: https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
    Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use
IS_ERR_OR_NULL() with gpiod_get_optional()")
    Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    Tested-by: Wren Turkal" <wt@penguintechs.org>
    Reported-by: Wren Turkal <wt@penguintechs.org>
    Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
    Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
    Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Reported-by and Reviewed-by tags are duplicated. One of the RB tags is missing
a space.

Bartosz
