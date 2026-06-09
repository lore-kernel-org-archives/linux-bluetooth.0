Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65601402427
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023575; cv=none; b=Q5rEzp+IoA7NHftvuOfIzWW2NnSqJ2awKbaXAQcMOQtNlGFfHT86NoVp2sZr4buOGszp18RmVCHwgSOOQFNULpafNLvn4Cyyk5SYVxAnUVKANJueGIPqFsQsy6lYmLL5yQFgYqtAr/i1sOOQkIa27JdFzEDQGO4lRJybb/8YAVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023575; c=relaxed/simple;
	bh=Zc34Hx/PDSXt4WNhEiIH0lZbEy80YtJqxW2o6N6H3K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxUFKaA3oBGOMj4QC0L2qDJ1lIsPjITuQbOfTDGnvSduLc4Amjnb1YBDc8UMPOSVWBs7yuuFTc1nnZvqVeGz531VHb1hfgR0jpyZVo2TZxpCIBDu2s3cklp4vvXGqqEt0AozU2N9VJzakaCDwS5mGMM1hte2DzhygLPVS+E0oME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=ZU4n1AWJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="ZU4n1AWJ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45fe59255beso3030854f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 09:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781023572; x=1781628372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DqnoSYFlILaCE9eSqUSzCTh6H2iDs1VW3pd9F5jD+GU=;
        b=ZU4n1AWJTrWtOpkPr47UUwV4K/CqXnMqC1SfJjaBJbY6UETORzJ0wszvn7sNzIM3kC
         UGWfKx325KjFiHlPkryKmQqxUOon2Rx7zqZCUJizalMeLvzvagBfc1e1mSGGoFt0Wf0l
         H0oe8EoyVRQoDf//xfaAdzz6KmU55qNM8Oo4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023572; x=1781628372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqnoSYFlILaCE9eSqUSzCTh6H2iDs1VW3pd9F5jD+GU=;
        b=QhX7oI71SRkySlwDrDdsaaeclxvk32uYM+KScvVDbzijd6S3k2FUZVu2PWkLMlleo8
         VQFFzBLTB24AriRGEpid77QjBCSN0dghtcbk6fhrSZ6Kf7hr806wDSEs6BGa7XYYu0gP
         4jzE58ijX1AgCib79brhqPrrKPyT2zeshaaR8t+irv+POV/P2s0Yxp62dT8CvOkaRMsg
         hsatz66H8YgtvG9YxcWwIGF/LJ5JlsrBLexTxqr1SomjIc6VVr8RWfTx+mxRjevIzqfy
         bns0X4pJyocGFwbIbboBnTlVJGk7mKWgoUHT3gDOQjGC+b6h6fQ+i+iwJpzrGL0LuNYL
         A4XA==
X-Gm-Message-State: AOJu0YyQycIQP8Yy6Pw56mpkefAoWRU72X1/ZAk/xwPVvIccZDQQSuUG
	g2mfvn0D2pOsutdwyYfqRcYqdAP9xvo8dooMEsk630JYSm01OX8n2O8iuJozXkyoMLo=
X-Gm-Gg: Acq92OG3Fa+6hP4WiWYaH0tAHvSccJTL7YzJVqbzgl/OnCTSaBbP1GZTXmhM6Yh+p8L
	LSs+sD8xsy4EWHfpsc17V/gAicVBpNAbHSmmcVI/bAAFUHuSewHH9X0wBcNzvRB3yReFBILo5Mc
	IgmOooFy41InadXRPk4BiAi5AwHQq7Gdyd9/BrmbUY9mRrHUSI/HYGen9vch6BNplJEiZJv5TBz
	L8lVJvVADMUNw+oPgi9YqJ277cpCNgo9EhoMqWOLtNpSx3nE0X9J5UPZLZIlPBxUqUxowLEDJGT
	KykvOxrxrtEBiNzSwJMzmU+EqQ0Lg1/6KJFlblTQy+82XF4ySbbfye9d9gb6n+TzSl5hJd+LFgc
	kGTBITd6ShnQnTRx2XClEI5zNfixu4IbxIVfuIJ9yDiCenCYng4H1HDLs0XxBPrnqFD7Jmp7xsL
	YhbXBE63EkefxqV8cAwpeRodVFaEVszWeRz4JuBYXrFfAU1db2q71h+jQPB0Z01mbF
X-Received: by 2002:a05:6000:bc9:b0:45e:9417:556f with SMTP id ffacd0b85a97d-460306413bemr22985242f8f.39.1781023571873;
        Tue, 09 Jun 2026 09:46:11 -0700 (PDT)
Received: from [10.122.244.41] ([84.245.120.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35eae5sm64272662f8f.33.2026.06.09.09.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 09:46:11 -0700 (PDT)
Message-ID: <09a91e18-46f6-409a-8d91-521c1d657797@streamunlimited.com>
Date: Tue, 9 Jun 2026 18:46:10 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] hog: Fix starting encryption on some BLE remotes
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20260608091140.3606008-1-simon.mikuda@streamunlimited.com>
 <CABBYNZLRz2iqR-eQNjXsJnyeZ8aONnjgaQDO6bRWVqfVy8SbbQ@mail.gmail.com>
 <11d03be6-8f9c-4b8c-8bd7-0b7d9c9d87b4@streamunlimited.com>
 <CABBYNZLomccRxaXOMDxbJ2ksks-2C30h9+oSn1ZRn1cKohThfA@mail.gmail.com>
Content-Language: en-US
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
In-Reply-To: <CABBYNZLomccRxaXOMDxbJ2ksks-2C30h9+oSn1ZRn1cKohThfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ahh. We have this modified in our codebase - we have a change that you 
will not increase security yourself you leave it to remote device (in 
case user has removed LTK on remote device and you still have one, you 
will not trigger authentication error).

So you're right, if this is in place it would have increase the 
security. We will squash those commits together internally.

Thanks!

On 6/9/26 18:35, Luiz Augusto von Dentz wrote:
> Hi Simon,
>
> On Tue, Jun 9, 2026 at 12:25 PM Simon Mikuda
> <simon.mikuda@streamunlimited.com> wrote:
>> Hi Luiz.
>> I don't think it forces encryption without bonding.
>> The diff is:
>>            if (!device_is_bonded(device,
>> btd_device_get_bdaddr_type(device))) {
>>       ........
>> +        } else if (auto_sec) {
>> +  bt_gatt_client_set_security(btd_device_get_gatt_client(device),
>> +                                BT_ATT_SECURITY_MEDIUM);
>>            }
>>
>> so it means device IS bonded and auto_sec is enabled
> Hmm, but in that case doesn't the following code trigger first:
>
> https://github.com/bluez/bluez/blob/master/src/device.c#L6469
>
> So either there is a bug or the code you are adding is just a NOP
> because the security has already been set to BT_ATT_SECURITY_MEDIUM.
>
>> On 6/8/26 16:23, Luiz Augusto von Dentz wrote:
>>> Hi Simon,
>>>
>>> On Mon, Jun 8, 2026 at 5:20 AM Simon Mikuda
>>> <simon.mikuda@streamunlimited.com> wrote:
>>>> When BLE remote doesn't reply with Insufficient Authentication Error
>>>> encryption is not started.
>>>>
>>>> Good remote:
>>>> < ACL Data TX: Handle 64 flags 0x00 dlen 7
>>>>         ATT: Read Request (0x0a) len 2
>>>>           Handle: 0x0021 Type: HID Information (0x2a4a)
>>>>> ACL Data RX: Handle 64 flags 0x02 dlen 9
>>>>         ATT: Error Response (0x01) len 4
>>>>           Read Request (0x0a)
>>>>           Handle: 0x0000
>>>>           Error: Insufficient Authentication (0x05)
>>>> < HCI Command: LE Start Encryption (0x08|0x0019) plen 28
>>>>           Handle: 64 Address: xx:xx:xx:xx:xx:xx (OUI xx-xx-xx)
>>>>           Random number: ...
>>>>           Encrypted diversifier: ...
>>>>           Long term key: ...
>>>>
>>>> Bad remote:
>>>> < ACL Data TX: Handle 64 flags 0x00 dlen 7
>>>>         ATT: Read Request (0x0a) len 2
>>>>           Handle: 0x001e Type: HID Information (0x2a4a)
>>>>> ACL Data RX: Handle 64 flags 0x02 dlen 9
>>>>         ATT: Read Response (0x0b) len 4
>>>> ---
>>>>    profiles/input/hog.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
>>>> index f50a0f217..845087c9d 100644
>>>> --- a/profiles/input/hog.c
>>>> +++ b/profiles/input/hog.c
>>>> @@ -189,6 +189,9 @@ static int hog_accept(struct btd_service *service)
>>>>                   if (!bt_gatt_client_set_security(client,
>>>>                                                   BT_ATT_SECURITY_MEDIUM))
>>>>                           return -ECONNREFUSED;
>>>> +       } else if (auto_sec) {
>>>> +               bt_gatt_client_set_security(btd_device_get_gatt_client(device),
>>>> +                               BT_ATT_SECURITY_MEDIUM);
>>> So this forces encryption even without bonding; why?
>>>
>>>>           }
>>>>
>>>>           /* TODO: Replace GAttrib with bt_gatt_client */
>>>> --
>>>> 2.43.0
>>>>
>>>>
>
>
