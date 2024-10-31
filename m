Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF5149C53;
	Thu, 31 Oct 2024 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730374247; cv=none; b=knMbTsMveOMDWkyM1a5M9itkkLx0VyMTcFQ3tTduR/6Z0EjU4qmoJKqj9K8OToRmRIEMnXen2kwyxmNQcpEmkzOxngieg+CQcOhR7svePVLvtVMT6UoDIZJMkJUjt6FlvKPbLnTA+BNR2mPDPKjWZIcHvUTqi4bC1oGtpSAq6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730374247; c=relaxed/simple;
	bh=vwPPB+ueKcC0Lnyzo4SRH73J3QIczij2tT2+C0nU8uc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=X3LZuBZI97s89aUpOtVOUxDEGOhgp8nLyWqK1a0xAHwJENJ0sKubE48LAD4sQIwkuXaBDQeKiUQ0JFyIICT9FhJ210gIh/r0X2ACn4TPeG3oP26PVqtDhX0F7HgOUxw00LLd/M6TYGVpwPVYDg3Nihm1vFbgCJ56XPuZMUBZ90w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMNfiyF0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMNfiyF0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6B0C4DE1B;
	Thu, 31 Oct 2024 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730374246;
	bh=vwPPB+ueKcC0Lnyzo4SRH73J3QIczij2tT2+C0nU8uc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=sMNfiyF0uDW8Bkjau0L+QDBpsoemQuUg56s+73drSvvDaPnMA8A3PIJ1Ir9VkFP8X
	 zYeYKuWES9BYZCjR0hli7es1STxHzmFy9vUDtYZcM9Zt7CzsbJz86IVvDtp91+6CwA
	 4N2EY5VBRsZTmI6j/ei/RzV9RiNsgU2xkydiaLYePeEP3gWuTJMDrZqFYN76Lmrcos
	 lUQ8oNsFPpYrTdfR1vHn+zQ/i8eHEZK5GZmxC3TAy9oXtiyZCqzZJbt0IMstaqdkhY
	 0J+qjorExP7oAtj88nxy8zwQqVxSdXlIvsrlgr6dfSoe81VLNNJqCECsoyf8B0egy0
	 24kECFACXu4SA==
Message-ID: <d9fcd228-8198-4e4c-8752-e950ab598013@kernel.org>
Date: Thu, 31 Oct 2024 12:30:42 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Bluetooth: btbcm: automate node cleanup in
 btbcm_get_board_name()
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241030-bluetooth-btbcm-node-cleanup-v1-0-fdc4b9df9fe3@gmail.com>
 <20241030-bluetooth-btbcm-node-cleanup-v1-2-fdc4b9df9fe3@gmail.com>
 <aab34ae4-0f6b-4720-b14e-69add0355daa@kernel.org>
 <07eef877-622a-4651-8a15-9e507146642c@gmail.com>
 <79c00d2c-8062-4c65-9bdf-1a87e7624e8b@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
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
> If you think about stable kernels, then work on backports, not inflate
> mainline kernel with multiple commits doing the same, creating
> artificial history.
> 

And to clarify even more: these stable backports are close to useless,
because it does not matter for them. No impact, not much benefits,
nothing improved for users/developers. There is no need to backport
them, although of course there is no loss by doing so. Therefore entire
dance affects mainline kernel without any real benefits for stable.

Your split suggests you don't really know what this dropping reference
is for.

Best regards,
Krzysztof

