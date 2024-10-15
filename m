Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20921E3DB
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729031250; cv=none; b=IMJkIGlFybND5vusfQuxX5+WcGHtlhdwKyF9j1OlIUdcnqeHfUMGmeznth/EvhNbVcVF+tZ6kP1ysm/da0gkFuL8MaY4JbdI1N7v0cM7d7U6rD5lb+/N6A+U+WL1Jk8DVpImgmmLkyNFHuRI/l97c7F0qEuQhX+PBDHLqQGf1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729031250; c=relaxed/simple;
	bh=xVhvvC5KYY4SRqxAEOGfcTdYI8AtS4CtPdx9l9AtehY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUcVyBVqh8RIqNg6gayDFBAVdvYAKqxqwam5RmrFFk1TkNUeGqHRaX99to6xJNqKIpjajuad31m9aESjvBO4piPUAQWyKCd5LdJlZDN0Do3LmXJzY6twiWSnsuEsQh0w/iWsVAlZ5LtNxtDNCtArXyO7Fj+AEjPdRm+D13d1Ypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UaxgXqsd; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UaxgXqsd"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3bb6a01eeso16307395ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 15:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729031248; x=1729636048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbqYbvbPHC7jsWcXXkq+myvuos/TZJsUv956mH28u+g=;
        b=UaxgXqsdceQ6joCiLq8pO5hN9qUlKClgJ5UgVX5qWYbQM4pZDD5+j7e7d9fQP5S6ER
         T3QVe0IdHg3HW73r24LR9eYlUFv7ck6b9nKxumZ/YhMZNsVb96RQtakdh7Zs3L4Luwxp
         3Gnq+6hgqC9u1/yuttSgj3zSGEJukEh7/mkoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729031248; x=1729636048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbqYbvbPHC7jsWcXXkq+myvuos/TZJsUv956mH28u+g=;
        b=aamo/yA7ycP5o8+cslzgcFGGpVq85EyoX0k2VXrAlGN3thT5kUYbkeppJiz9XiFpXI
         EFN3YWrUiP2I8wXyx9gM+aNwnK8zSAMGBGu0N5HOkJJJH1BkduyBMB5sOuFmf1h4uQFC
         EFUwtuvNGGVTsGJZHSes7tK8uHirrMi8hTPPTWAlD4CmLSD9SSaTBuVXEs2tO5fEiPc3
         dbe6YvbmfsIeQFK1LTtroETpbvyd2NSAp/dPrlPlj/YYiZCLjM3ZwG8kIBzB+MSCgj7j
         zVVijLW00w1zfogJtO9Q/tuWnvq0KzFZbDMAbxLe/yGydZzl8RfKX7uPtGr3T+hwkXrb
         rrig==
X-Forwarded-Encrypted: i=1; AJvYcCWw32RqX7vHPDv8ApY1qfgE/sO1JhnhRXQgH6F4if3PNGckCL/SUUKlK/KHFvqg2nU43eCN5wwahN5zvrzBdsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOW29OFKmk940LvmJbvmfyrCoNW5f8oF6cab1N99F4EyMXHnEA
	9hdm9KsUCq2XlIn+JEam/IL2lqE0wA9JDGFIwEfoRaC5ekrJ0wAl8vIOvIj+kC4=
X-Google-Smtp-Source: AGHT+IE5if0ZnJaMCA5ubjPTpbcHWlT2DX0oWEry1+1YMZ0iEPhjqRzrVg9N4kV0pU85MnDBXLpQPg==
X-Received: by 2002:a05:6e02:160e:b0:396:e8b8:88d with SMTP id e9e14a558f8ab-3a3b5f61a5emr157523925ab.11.1729031248033;
        Tue, 15 Oct 2024 15:27:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecb38cb5sm515234173.114.2024.10.15.15.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 15:27:27 -0700 (PDT)
Message-ID: <f7c92929-dcda-43f5-a163-9a167abf0de6@linuxfoundation.org>
Date: Tue, 15 Oct 2024 16:27:26 -0600
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3][next] Bluetooth: btintel_pcie: Remove structually
 deadcode
To: "Everest K.C." <everestkc@everestkc.com.np>, marcel@holtmann.org,
 luiz.dentz@gmail.com, Dan Carpenter <dan.carpenter@linaro.org>
Cc: kernel-janitors@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241015193013.16790-1-everestkc@everestkc.com.np>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241015193013.16790-1-everestkc@everestkc.com.np>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 13:30, Everest K.C. wrote:
> The switch case statement has a default branch. Thus, the return
> statement at the end of the function can never be reached.
> Fix it by removing the return statement at the end of the
> function.
> 
> This issue was reported by Coverity Scan.

You forgot to fix the typo Dan pointed out in the short log.
Don't forget to include reviewers when you send new version
based on their comments.

+ Adding Dan
> 
> Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
> V2 -> V3: - Removed that the change was successfully built
> 	  - Removed the link to Coverity Scan report
> V1 -> V2: - Changed "Fixing" to "Fix" in the changelog
>            - Added that the change was successfully built
>            - Added kernel-janitors mailing list to CC
>   
>   drivers/bluetooth/btintel_pcie.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index e4ae8c898dfd..660496e55276 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -391,7 +391,6 @@ static inline char *btintel_pcie_alivectxt_state2str(u32 alive_intr_ctxt)
>   	default:
>   		return "unknown";
>   	}
> -	return "null";
>   }
>   
>   /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in

With the typo fixed:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
