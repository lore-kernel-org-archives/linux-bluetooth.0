Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07FF19AD70;
	Thu, 31 Oct 2024 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730374187; cv=none; b=ZJ4l6tdti8ZNe/sTmNXdO9IEpm0LbK2+Bomv8dhZnqUYPrPb6wEEpNyrY1YseSvsCWbYCF5irFAOkIYTsqQXcB0zVRubEa15lOM1uaugIhZVQiujAEaYk3EqnstZ5VjxFckhETizGm4+uqS8SsihHoyJE3nijxXkq3VmMi4/+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730374187; c=relaxed/simple;
	bh=B0JB86s98lQ+cJR4Gpwowc37GEMmYoAKERoTXvld/wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNwDLkt9/lRS1LXf+ZccOTmv0g3xpGC1V+waZqsnU9/ds76P3ozgio8L5fYoGy9Biu2YEBo7Ciqb7ydw09MYSxwaLRUMURR7bBpGhe/nGGuHWg0ig5CzFw7TgG5qctlADNRPam5pLdNWKst1Lnv13FQo+QPqOb7XBEfvtmaq06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8bAUQQ0; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8bAUQQ0"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539d9fffea1so797888e87.2;
        Thu, 31 Oct 2024 04:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730374183; x=1730978983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kwaPOaIySBot2eY0KmsQ+rZy8Kteyr9TxlITcMFJes0=;
        b=k8bAUQQ0FiqATxXTGnZQhAMMx5jI4rHxJgKsK3X0JSLPqWXjkuaPDV48VrCiWrewcc
         U6Ho5+b/n3jRDrF4IH1ir6TGUwM/VrFBvufMMf+lK0Bg0/JER1ha1PSqO8pcSNe3nbdO
         FpAdpuMdUonA/M1jZ32u9rRbtJ5Y0089AmP6sK3zxOWmq4h4pUcBKoFqKe9Z9wEBKwAG
         +spEHy8vR5+uh0n0swQEg0o6MJ8RNiVzHlcjJqZDUMo00u0/+s+C1U2JGK+dVF0FzO5K
         HIlKC7GAdZ0ywMWmJLyk7MDeZrluWOfb84fYPknj94NlFwD8VNCJcvt2m1lxdok7jA2o
         bFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730374183; x=1730978983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwaPOaIySBot2eY0KmsQ+rZy8Kteyr9TxlITcMFJes0=;
        b=DKhbyxmNs9wSgYky/VkhwIBQqekyfJqsNA3Q/2OnpzeF9VhqsOCFtfjx1690KKe8Vg
         UhVvjpBkkUrmtvAiy9M+GGlIExglgD+8r1yMcuxTrlMyiK8vYlbM5TU+1llJtl4OpY0V
         5mIfxp4SAPyUEL1oA2hd4/Z7XDMxIT9UpOiGycP/GNOuhSgWzU6GOvD5uJ7TLyxgGrHJ
         L6LFLhmSOwnnBM5GyOiTm0cZsl3wMvQ7j1aEanMTR8abEZaDZxcK0KWiZASmm4ZG+jM/
         9HU1iIo+HMaNX8Rw5NH9JxPCt4yQLqAqVo9YNgw8j2Ovo5EiH/pUgYlQNYL8WaaTnxr5
         AvpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqj6GQXJvYFezLeLfDz3ye6nbyId9PsGqfrv1tlLI9KDEM+WFec2rXi2t1r7jJShGQWtOMn7uV+RXqm00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQ8eqhhScFbNUqiSdp71tZcEkEAj4nqLeGsR2mCJznOXR0FkC
	3pp0iDhZ2MIFTGrKGk6QpfvnKyGjuXf2cqt1UGQR7VX3svYcJHKM
X-Google-Smtp-Source: AGHT+IE7XwYpzopsAQRjU4EsoFnvBkoZC7x8uo55CLSvGT3LH1++BjecMjUumZd5Y4XBDFlPGmcu4w==
X-Received: by 2002:a05:6512:3b08:b0:539:e97c:cb10 with SMTP id 2adb3069b0e04-53b34c5f73fmr10612333e87.40.1730374182674;
        Thu, 31 Oct 2024 04:29:42 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:d7b9:afdb:c541:d023? (2a02-8389-41cf-e200-d7b9-afdb-c541-d023.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d7b9:afdb:c541:d023])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf4fdsm22806345e9.17.2024.10.31.04.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 04:29:42 -0700 (PDT)
Message-ID: <f5663347-d15b-4400-b81d-e4d156d9e918@gmail.com>
Date: Thu, 31 Oct 2024 12:29:40 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Bluetooth: btbcm: automate node cleanup in
 btbcm_get_board_name()
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241030-bluetooth-btbcm-node-cleanup-v1-0-fdc4b9df9fe3@gmail.com>
 <20241030-bluetooth-btbcm-node-cleanup-v1-2-fdc4b9df9fe3@gmail.com>
 <aab34ae4-0f6b-4720-b14e-69add0355daa@kernel.org>
 <07eef877-622a-4651-8a15-9e507146642c@gmail.com>
 <79c00d2c-8062-4c65-9bdf-1a87e7624e8b@kernel.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <79c00d2c-8062-4c65-9bdf-1a87e7624e8b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/10/2024 12:14, Krzysztof Kozlowski wrote:
> On 31/10/2024 12:10, Javier Carrasco wrote:
>> On 31/10/2024 12:08, Krzysztof Kozlowski wrote:
>>> On 30/10/2024 16:46, Javier Carrasco wrote:
>>>> Switch to a more robust approach by automating the node release when it
>>>> goes out of scope, removing the need for explicit calls to
>>>> of_node_put().
>>>>
>>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>>> ---
>>>>  drivers/bluetooth/btbcm.c | 8 ++------
>>>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>>>> index 400c2663d6b0..a1153ada74d2 100644
>>>> --- a/drivers/bluetooth/btbcm.c
>>>> +++ b/drivers/bluetooth/btbcm.c
>>>> @@ -541,23 +541,19 @@ static const struct bcm_subver_table bcm_usb_subver_table[] = {
>>>>  static const char *btbcm_get_board_name(struct device *dev)
>>>>  {
>>>>  #ifdef CONFIG_OF
>>>> -	struct device_node *root;
>>>> +	struct device_node *root __free(device_node) = of_find_node_by_path("/");
>>>>  	char *board_type;
>>>>  	const char *tmp;
>>>>  
>>>> -	root = of_find_node_by_path("/");
>>>>  	if (!root)
>>>>  		return NULL;
>>>>  
>>>> -	if (of_property_read_string_index(root, "compatible", 0, &tmp)) {
>>>> -		of_node_put(root);
>>>
>>> You just added this. Don't add code which is immediately removed. It's a
>>> noop or wrong code.
>>>
>>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Exactly, I added that code to fix the issue in stable kernels that don't
> 
> Then send backport for stable.
> 
>> support the __free() macro, and then I removed it to use a safer
>> approach from now on.
> 
> This is not correct approach. We work here on mainline and in mainline
> this is one logical change: fixing issue. Whether you fix issue with
> of_node_put or cleanup or by removing of_find_node_by_path() call, it
> does not matter. All of these are fixing the same, one issue.
>

I fixed an issue as one logical change, and tagged it for stable kernels
so it can be automatically applied. Then a second logical change
switched to the new approach, removing the old solution. If that
happened with a few weeks in between, it would be ok, right? And no one
would have to choose the fixes to backport for a given stable kernel.

I have also had cases where the maintainer preferred my approach instead
of fixing an old bug with a new facility, and the suggestion was
splitting into two patches.

But in the end I want to fix the issue in mainline kernel, so I will
squash the patches and leave the backporting for the ones who might be
interested in it, removing the stable tag.


> If you think about stable kernels, then work on backports, not inflate
> mainline kernel with multiple commits doing the same, creating
> artificial history.
> 
> Best regards,
> Krzysztof
> 

Thanks for your feedback and best regards,
Javier Carrasco
