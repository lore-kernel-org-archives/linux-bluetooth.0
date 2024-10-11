Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A201CF7A4
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672739; cv=none; b=rjhl5cDYWvSFBG7cA4i/1Uat1tzvDr03wm5jYrgDCR9yROn1i2stniDxeYiRM5YYNW0VkLGS+TveA0PUb0cFNZrR44Lz2eWNtm50EAr19zCYgkE1jgxwrIQksrWpHlHgwxjlFCjmAnjXAn+SaSoFm05QOyd/4Ge5xxuGhGgcz0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672739; c=relaxed/simple;
	bh=DSch+Tk0aDu4RJCTyLVP+SKax0FiTm5ccZhhYNLC/F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMdCNj2JmnZHpouH5QKXSOy+Yb8Pxdlx43mR8obKWy26ynRS/C/f5JYcJR2Rrwy8VYnXOMKKacseUc/8nBvk+nFYQP73TgB6YbgDAux+CxD8Nie46neazKNEwMaxrdhvG1Ign0skJNcMUJ6RBC9pQu+F2I5osgi1S/dnUdaYg2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIPJenM2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIPJenM2"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398df2c871so3216303e87.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728672735; x=1729277535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=77xwcjOONnOdUbFiGW9x0HvxV51ouN8iyGezjc2Q4TA=;
        b=cIPJenM2fqF6Vp5nDvr5XIAvUQF/ilRc/6VZqOV+Gax85uJenpvNlix8uoVAMatA+L
         rVyDvdpBuO9vb0J8Z5yprKRbNvdl+Fz4MVxlzq3NU0rbpcQi0Mw+ozIwL/KrD52K+QKP
         7a7NVC/5nrm1K+QwCcnfkhcGT1VPfCsQMQL6TGgohwbA914EMjthQhx1SIfFBBbe3qGd
         xkzwKRgFE+5gHUnPpCCNk+yr8JYraOUlUGhrjp0SmoypViYRnL21hFU51eHbKl1L0vfy
         GshacUMNCZsERpGBne3pUVpm6W9qwiEoHJ221apiwr6uGzI+aCJOdXpsx4C0wMsomxp6
         FZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672735; x=1729277535;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77xwcjOONnOdUbFiGW9x0HvxV51ouN8iyGezjc2Q4TA=;
        b=EiV5OV34TCrFOur0LsYth3DmOKRtZNA5cDG152O1obXhejZ4tn4T3S7MjtlOLlomiC
         yXpFcuNISEntGFDkoW13eyD/C9WAIyahiyIF6ah0pl2K0NWgHi6Wej5xxc4cFMmuQjr0
         HZ2kk9I6qquoyCAhbwXdoOQxSBpq776hyETtPK1OC9a1MMxC4xWDjN+klkP6if+nWcg8
         hTjop0enzsRrWTkqZ7MnoVMNq0H4AyM5X7f5Vm/a7/tN+5/7376J9YDkXTUxHFUselVE
         S4HOgoZ9WhgQAd7PbLPGwl8boejMrpODQ+5dGUvjiMZHQHn2afCWVKHWcp2eZIkv0HO6
         tqzA==
X-Forwarded-Encrypted: i=1; AJvYcCXK/C0B5tavKTvfZm/1K2CQ1OxSu5euaGreGM8N7JzgoOewk5yv5RI/Hex/9eoFgtUp0lf9ilZ0YybpEGhhKng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7WvXJLCfm0e9fbki0r8rrgCUJxs+MUB3sACOdJ38rMGRsj1D
	/rUDv4Xak1w0rCicfbsZeNVCS2ZfEfn653Eyp1GAj19tm2qkDp0N
X-Google-Smtp-Source: AGHT+IG6qgDOa07Hwg9c4f7a1C2GUwVODdnlFGQiCsHjNCu1TxFHTXDRCMndo0JQA9yYx0H0BWS9Ig==
X-Received: by 2002:a05:6512:6402:b0:539:e1c6:9d7f with SMTP id 2adb3069b0e04-539e1c69ec4mr1901680e87.25.1728672735188;
        Fri, 11 Oct 2024 11:52:15 -0700 (PDT)
Received: from ?IPV6:2a02:3100:afd7:9a00:94ac:542a:1cd2:c9ce? (dynamic-2a02-3100-afd7-9a00-94ac-542a-1cd2-c9ce.310.pool.telefonica.de. [2a02:3100:afd7:9a00:94ac:542a:1cd2:c9ce])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c93726051esm2165503a12.59.2024.10.11.11.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 11:52:14 -0700 (PDT)
Message-ID: <c8b5c842-463e-4c30-b7e0-f41bf1d59305@gmail.com>
Date: Fri, 11 Oct 2024 20:52:12 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Connection issue since 81b3e33bb054 ("Bluetooth: btusb: Don't
 fail external suspend requests")
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 BlueZ development <linux-bluetooth@vger.kernel.org>,
 Kiran K <kiran.k@intel.com>
References: <595efd8b-e0fe-4a87-90b1-4b579f3cc876@gmail.com>
 <CABBYNZJMWni33VQ2sX9EDcNbsFbX7pjAFj4QLri9N7jyLY0HvQ@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CABBYNZJMWni33VQ2sX9EDcNbsFbX7pjAFj4QLri9N7jyLY0HvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11.10.2024 18:36, Luiz Augusto von Dentz wrote:
> Hi Heiner,
> 
> On Fri, Oct 11, 2024 at 6:49 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> Since linux-next from Oct 4th my bt speaker fails to connect if I switch it on.
>> It just hangs trying. Manually connecting it via bluetoothctl works though.
>> With this patch reverted it auto-connects again.
>> If you need additional details, please let me know.
> 
> I suspect something is trying to suspend the controller then, it
> shouldn't be USB auto-suspend since that should behave as it
> previously but if there is something externally (aka. userspace)
> trying to suspend then it will force it to suspend.
> 
On the host side it's a combined WiFi/BT PCIe adapter (RTL8822CE).
Runtime PM is enabled, so this may kick in. I'm not aware of any
userspace tool which may try to suspend the WiFi/BT adapter.
Disabling Runtime PM may be a workaround, but I don't think that's
the actual solution.

