Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB80B45025;
	Thu, 31 Oct 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373051; cv=none; b=bq29ZDn/20c6sPRBVThuqS9LMkpzZPggUSzuuQ/Tr14N/izOqk1rDglsoSO0wnXmHZN1m1kPT9fr2Aqpt2q9tckeKL7zUGR5G13lFsEOprUBcaK0mlbStm3QUGSlmeW/0F5Aj0ZkwhohzPYseznT2Su4au/itrClT+cke3DBROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373051; c=relaxed/simple;
	bh=DypDPi2O1oYkBPB//Sf7af1xQGJD1ezj3+YPEJaCD3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jiZ0r05vbicY1aLEPBtetXk253OonvZDBDJl6812ybWgmKSi4eNN4Z76FqqD3riGtwBS0qBCHQAGV9S5Ma/GWXD9kyQjQ1rskryATAcD1F6HNt2HYpYL/Tc7O8zKZmhrNZIh5JhzULX957Ti3B+u8NYytEyObwYqHZ4hXz1xF80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miJl0+wh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miJl0+wh"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d495d217bso696104f8f.0;
        Thu, 31 Oct 2024 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730373047; x=1730977847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SfVCXyUt2CwrDlWVitQ9PFnr4+D/I8wZCkVAHI5ljXk=;
        b=miJl0+whsT8J8X03sb+92z4Kl0vaImJPNXu5oPUUGu2eNAifyoDKGfxlgtPVif7lEU
         6D+hpeD5KFrG+sw5HTMGwO+VnCWWnoSqPDm7H6/YANDFIcE5M2cN1mkJwM4fSGCoa3w/
         wWpzirUFtXH2J3rEYn70iMUtwSyBzbIFpoYRa4W6jOtNMH2x1oKuu/19s0HjppyH0ICv
         63vNkuSY8NjmraCObIwgch1IwGJqv6EQ0Gikfv6pHy3A47VqKMFplO2UAvtf5mfRyhVe
         1e5yzRIWk7RIzfZKKdIwSPsj4rrsqt8ViZfaSx6TmalKoMrktW1fPboHKPr2K4jUHfvL
         zBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730373047; x=1730977847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfVCXyUt2CwrDlWVitQ9PFnr4+D/I8wZCkVAHI5ljXk=;
        b=Ooc/jd/nefkgepwxiqFgKb/ieXSVmCUn02hyFZ/ByuFUKa2f9CCwGokV47vRbMl2dJ
         87awOUE+Lu3Nc5xU8ZUQ40WCrjcEQ7HnkdN8eZxc4Z7P9XivJN/wx/F9Qotw/rbU3cJs
         EuHrbSbeZGH9iHORs/aZxn6NwDPMplCXgoZJrD5JOVDSkTNLLjydM/lrkQ8sZ+wcq9Tf
         Ftr5TQaO/8m7OanXtHDNPX/JC7M/yzAirUK/prlXlAa/QLloWivU4Cu2ggBe9c9Sinpz
         +udkDKFtD4+hSQY6SLpj0CxruCGZbGhQyB/sIzmf0N5gGRi7OAVdApohXtfM2CAy2Qz0
         UmTg==
X-Forwarded-Encrypted: i=1; AJvYcCUVBdtQCkCNGvPRd/uqOvkKm2u1oaBUJZrKTtRGMF7czHzWXeve559t2QoGVybbMzW1aNQm2dYEF0lzmTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA7VDteCtM8qaFFnTwsx54Q+9et4SbHTUanA4Kqc9F59Qvk/Fs
	6uXG9bB808R2IY7DcELYWReVddLtBB/MZhdixfuX4cI2ooNUqRtr
X-Google-Smtp-Source: AGHT+IGqGmkeeFXLOieMD56rvRfSwTwbhYqc+WHgMtskMDBpUkuQwJjqWl1C4RALxYbry2w6FC5tJg==
X-Received: by 2002:adf:fd44:0:b0:37c:cfa4:d998 with SMTP id ffacd0b85a97d-3806123f1e5mr14932613f8f.49.1730373046985;
        Thu, 31 Oct 2024 04:10:46 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:d7b9:afdb:c541:d023? (2a02-8389-41cf-e200-d7b9-afdb-c541-d023.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d7b9:afdb:c541:d023])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113de0esm1791215f8f.85.2024.10.31.04.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 04:10:46 -0700 (PDT)
Message-ID: <07eef877-622a-4651-8a15-9e507146642c@gmail.com>
Date: Thu, 31 Oct 2024 12:10:44 +0100
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
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <aab34ae4-0f6b-4720-b14e-69add0355daa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/10/2024 12:08, Krzysztof Kozlowski wrote:
> On 30/10/2024 16:46, Javier Carrasco wrote:
>> Switch to a more robust approach by automating the node release when it
>> goes out of scope, removing the need for explicit calls to
>> of_node_put().
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  drivers/bluetooth/btbcm.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>> index 400c2663d6b0..a1153ada74d2 100644
>> --- a/drivers/bluetooth/btbcm.c
>> +++ b/drivers/bluetooth/btbcm.c
>> @@ -541,23 +541,19 @@ static const struct bcm_subver_table bcm_usb_subver_table[] = {
>>  static const char *btbcm_get_board_name(struct device *dev)
>>  {
>>  #ifdef CONFIG_OF
>> -	struct device_node *root;
>> +	struct device_node *root __free(device_node) = of_find_node_by_path("/");
>>  	char *board_type;
>>  	const char *tmp;
>>  
>> -	root = of_find_node_by_path("/");
>>  	if (!root)
>>  		return NULL;
>>  
>> -	if (of_property_read_string_index(root, "compatible", 0, &tmp)) {
>> -		of_node_put(root);
> 
> You just added this. Don't add code which is immediately removed. It's a
> noop or wrong code.
> 
> 
> 
> Best regards,
> Krzysztof
> 

Exactly, I added that code to fix the issue in stable kernels that don't
support the __free() macro, and then I removed it to use a safer
approach from now on.

Best regards,
Javier Carrasco
