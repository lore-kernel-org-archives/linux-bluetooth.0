Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299E519AD48;
	Thu, 31 Oct 2024 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730374878; cv=none; b=h5sFfVM1pTvOi7XFJK9RBM1uZOFvT35FTcDOMfAMQWSKy6VmverL9xcOJVkuaGMoXCNt4fKE7nBSSul1WCPGmgqZJLm4lhrZA9BWVhZvHvCDYfCzqLblpCMz8OQi4ah397+rshD03XJSKiy9PYhuhB0yKf0MIdfVR9FvHQ8GoSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730374878; c=relaxed/simple;
	bh=qs/vs5euDjjwFioyX5BytC1xNzDzmT8fgcVHapa7FPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJt4XcOLRH6o7N+ULsom9illlSoEDdK2Td0FSEXKj6QAzBDeJ/WNkIqj0PNBUurEN+ankFAV3i1Ov9+83f24y7c83FWKPU0fmTvSTyTMuSt2yG3aFL38LCuydW7w74h/Bf/Kex0B9lop+wW40Dd+gKioS3Kdu4W35R21W3cnkFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7MJdVaG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7MJdVaG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so7238195e9.1;
        Thu, 31 Oct 2024 04:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730374873; x=1730979673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3aW+8vTh8hvIzvALduxjp4emnARDKQVvsl7R/XJ6jc=;
        b=Y7MJdVaGIRPibTxhf9roOiu/61hJg4RWiWmsQ96QOv8rEeeU0X7MyMdrXp/8M7rbyc
         lDWW5PZqYTfSFtUPNTpvhUDZqOMoeB2GGSdbI4y9xYF2Jc70kQWWCcP118SwKcdcJup0
         iC/vHCHcaRR8j+F/o4/W9L+eYtAwIpCaq+pVrMSKlK4/zr0N/SzVSeEnzgamJ9XHsij3
         fKtExCMPNq1yTF9oNr7hCH0OhGdJr/GXMkE2+T2e0os9AvqVXC5OZU5hRWWHFHyT/ZMR
         YqLszApYEt8XOh+HxxN39x4EEooErgvCFHJBQ5OivjWRhurM3lYV5WL9gAkP4Au6U8eS
         6NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730374873; x=1730979673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3aW+8vTh8hvIzvALduxjp4emnARDKQVvsl7R/XJ6jc=;
        b=rD7TSY1pWHYZAxoJSAh/aaeZ8zu1+FZrMjAOribyvduWbX4SdGJH/BAexdPIJoluym
         zYeWLARrNQZ61GMZIhfkyoedHv/1fvar8k47URRx54GbuPY+YTeXOQsJDmetB0MHtPH0
         HDNZKd/Dkx+gS/t+MJ4MFIlVayKc8UI0oPAayE3E3rcfZFtMZmdy104z+Yuh8ErWMsYl
         FWdr/I/alsnb5EBLGTrAxzLHeIMTcFqFpIlQJPSt1A+k1DXp6omf3V17D88CmATq5G+I
         BNpF4TLuS35SYP1WehWCydYuzzFeDdAA5eNfz15U9YtVdNrHlNBsArXiaNDvC4MV4t8s
         aXgw==
X-Forwarded-Encrypted: i=1; AJvYcCWBcz5NRc6PEoGrI2osSRZfPHwROGfAwSZR6nVaFXHQdjBZcOxl7Ok0tlwdLuavkHFzZ+oUNhUWWxbHmpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySS3fgKTSpkC5CgzUhFRfYTopfAcEsC8yWg2ibr7zK/fiZuzZS
	c5VexpYcJ1O5RUcrAxchQenkWGtr2cdsvmovR1TITgCwHjGICy4n
X-Google-Smtp-Source: AGHT+IGaRIRBbPwnci1Swwg5WnBbqpRcOMc4XvyHwk+XAykUgcn+Y3pEyVzuQJOxBp4tmJAFEafoEw==
X-Received: by 2002:a05:600c:3b9c:b0:42c:bb10:7292 with SMTP id 5b1f17b1804b1-4319ac70754mr182575115e9.1.1730374872840;
        Thu, 31 Oct 2024 04:41:12 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:d7b9:afdb:c541:d023? (2a02-8389-41cf-e200-d7b9-afdb-c541-d023.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d7b9:afdb:c541:d023])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9aa83asm53718265e9.31.2024.10.31.04.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 04:41:12 -0700 (PDT)
Message-ID: <26d090ef-5630-4afd-8e77-e20019cd018a@gmail.com>
Date: Thu, 31 Oct 2024 12:41:11 +0100
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
 <d9fcd228-8198-4e4c-8752-e950ab598013@kernel.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <d9fcd228-8198-4e4c-8752-e950ab598013@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/10/2024 12:30, Krzysztof Kozlowski wrote:
> On 31/10/2024 12:14, Krzysztof Kozlowski wrote:
>> On 31/10/2024 12:10, Javier Carrasco wrote:
>>> On 31/10/2024 12:08, Krzysztof Kozlowski wrote:
>>>> On 30/10/2024 16:46, Javier Carrasco wrote:
>>>>> Switch to a more robust approach by automating the node release when it
>>>>> goes out of scope, removing the need for explicit calls to
>>>>> of_node_put().
>>>>>
>>>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>>>> ---
>>>>>  drivers/bluetooth/btbcm.c | 8 ++------
>>>>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>>>>> index 400c2663d6b0..a1153ada74d2 100644
>>>>> --- a/drivers/bluetooth/btbcm.c
>>>>> +++ b/drivers/bluetooth/btbcm.c
>>>>> @@ -541,23 +541,19 @@ static const struct bcm_subver_table bcm_usb_subver_table[] = {
>>>>>  static const char *btbcm_get_board_name(struct device *dev)
>>>>>  {
>>>>>  #ifdef CONFIG_OF
>>>>> -	struct device_node *root;
>>>>> +	struct device_node *root __free(device_node) = of_find_node_by_path("/");
>>>>>  	char *board_type;
>>>>>  	const char *tmp;
>>>>>  
>>>>> -	root = of_find_node_by_path("/");
>>>>>  	if (!root)
>>>>>  		return NULL;
>>>>>  
>>>>> -	if (of_property_read_string_index(root, "compatible", 0, &tmp)) {
>>>>> -		of_node_put(root);
>>>>
>>>> You just added this. Don't add code which is immediately removed. It's a
>>>> noop or wrong code.
>>>>
>>>>
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> Exactly, I added that code to fix the issue in stable kernels that don't
>>
>> Then send backport for stable.
>>
>>> support the __free() macro, and then I removed it to use a safer
>>> approach from now on.
>>
>> This is not correct approach. We work here on mainline and in mainline
>> this is one logical change: fixing issue. Whether you fix issue with
>> of_node_put or cleanup or by removing of_find_node_by_path() call, it
>> does not matter. All of these are fixing the same, one issue.
>>
>> If you think about stable kernels, then work on backports, not inflate
>> mainline kernel with multiple commits doing the same, creating
>> artificial history.
>>
> 
> And to clarify even more: these stable backports are close to useless,
> because it does not matter for them. No impact, not much benefits,
> nothing improved for users/developers. There is no need to backport
> them, although of course there is no loss by doing so. Therefore entire
> dance affects mainline kernel without any real benefits for stable.
> 
> Your split suggests you don't really know what this dropping reference
> is for.

Such splits were suggested in other threads, and they came exactly for
those reasons: they could not be applied to stable. That was not my
first approach, which was just using __free() to fix the issue. I am not
looking forward to inflating any history, as that's in the end more work
for me.

If a simple patch that adds the cleanup attribute is enough, that's
awesome. I will go for that approach for all cases then, and use your
explanation as a reference if I am asked to split the fix again.

> Best regards,
> Krzysztof
> 

Thanks for your feedback and best regards,
Javier Carrasco
