Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F137BAF4
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427772; cv=none; b=bgjpG5g/E0ygJpiavNik8XO/B9iZBawhgfwZnwFbQZEqeFUdvORjVE4mUSKSV3AJ3QENJsdPyxnkS3YU9LM5EECq6hK0C4zZ9QBAglAvCQ17+g41Ye3RR3gjHY4fKc4+5wxP2mNNvYHgqQYOPoJ6fJHRcUr5YU2cNo1UV8VtdT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427772; c=relaxed/simple;
	bh=4h/S/0hbha+hAjJ8pRm9+Nkz13tVMUCkxr5fxW7OIuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wtr0z5idfDLIvmLiQhpAHAy7ZVkRuhxMUtLCa5ucvSRpVL/NXldH6VW75iXWdLt7jyuBeSZhhzcw4p9MFaItSM1o2FVLJ/0U6s24bo+mrE8L3qZ2Qg+ObostEFSfHD5zTXI7SgMtclwzMaenNg8ydDnxYHqXSMWiWZx4KkAbxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=lqQwOQe6; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="lqQwOQe6"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so316584a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 01:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713427768; x=1714032568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L20C97P5fJarZ9nPtYE/pbP4mUWC7Yr/sTMBVTRINIs=;
        b=lqQwOQe60mDJ6Jmc4hsLVA/VxFZ3WLnaE+q0nMaLyj7+Iu2HFuITOZbjCGHmxxCd98
         bIcdsLK8V1JoHI0/lzuYKYtZeX1arELhAu74QgQNKt/VGD2foEqjC4230sBLXaHvDPqD
         H533s9A89duoTWNGI9WiAZqisv9RfCEL348gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713427768; x=1714032568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L20C97P5fJarZ9nPtYE/pbP4mUWC7Yr/sTMBVTRINIs=;
        b=bsrvYNPNB4E9e8kWYvogRrbY0PPhByRQizQHxnkPiFTAreLiA7vgzG+6u9CSol7hOd
         5zgtTFLt2NXL6OC6cxsKRnzVO1YMqxvZINdLByyFT/NYwS9lhAaNWyBPxatfDeL305Vd
         OoFC7yWIg2VKYjRklxukRCRDkRnvuThpKUwC90xuGvdTkmqIWXxnIr/ZghKV3h0HsZI/
         hU1/vFtfLBDqeqFT/FnEdIcROI6LcxFiCVYFesK5yXbmwR9m5AgHvcEH+tSiu7O9HO4M
         0/ffyc1rXqui2g0zClqiZUZU7M5L9luPEOtwPja8Ilh3R7KtVT3awIbQ/4qYn1O1nqXr
         D2cA==
X-Forwarded-Encrypted: i=1; AJvYcCUUANjjObpidpiPcgcydNE911L0ZL3qHwYcZs76UmdPLpcbXAmtgCRV7Y83R/vsRokRaLSSEv7lxijW+4eh9pPGb0FIyfUrnsjgPgcJGnm9
X-Gm-Message-State: AOJu0YwJ8/yBCUrRU++5O4cqefNOPEwRphGS4YU3iRUS7ewhuaED8MZM
	mbFU197IuR3iAkmGHH7M/5Xes1B/W4iGmviXYz3H09lkd9wiFr4uWuH4EBiC/g==
X-Google-Smtp-Source: AGHT+IHYOgfdDC/f9EZ3dM0gYIGBfOEks3BQHAWEWjTarhf8ANGR6YHGDY4HWqJtwmctiDxEsB151A==
X-Received: by 2002:a17:90a:a610:b0:2ab:6c4e:de45 with SMTP id c16-20020a17090aa61000b002ab6c4ede45mr1793294pjq.40.1713427767508;
        Thu, 18 Apr 2024 01:09:27 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id cn19-20020a17090af09300b002a2b06ce909sm2562701pjb.17.2024.04.18.01.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 01:09:26 -0700 (PDT)
Message-ID: <2a887d94-d5fc-4317-afc8-641d331e35c2@penguintechs.org>
Date: Thu, 18 Apr 2024 01:09:24 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
 with gpiod_get_optional()"
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org
References: <1713354823-17826-1-git-send-email-quic_zijuhu@quicinc.com>
 <CACMJSeuQMz-JCK7tqiQCmt7z37L1UncNK0un28JHAa8qRhnp-g@mail.gmail.com>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CACMJSeuQMz-JCK7tqiQCmt7z37L1UncNK0un28JHAa8qRhnp-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/24 11:59 AM, Bartosz Golaszewski wrote:
> On Wed, 17 Apr 2024 at 13:53, Zijun Hu <quic_zijuhu@quicinc.com> wrote:
>>
>> This reverts commit 56d074d26c5828773b00b2185dd7e1d08273b8e8.
>>
>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>> with gpiod_get_optional()") will cause serious regression issue for
>> several QCA controllers such as QCA_WCN6750,QCA_WCN6855,QCA_ROME,
>> QCA_QCA6390 and QCA_QCA2066, the regression issue is that BT can't be
>> enabled any more once BT is disabled if BT reset pin is not configured
>> by DT or ACPI.
>>
>> if BT reset pin is not configured, devm_gpiod_get_optional() will return
>> NULL, and we should NOT set quirk HCI_QUIRK_NON_PERSISTENT_SETUP, but the
>> reverted commit SET the quirk since NULL is not a error case, and cause
>> qca_setup() call failure triggered by the 2nd and later BT enable
>> operations since there are no available BT reset pin to clear BT firmware
>> downloaded by the 1st enable operation, fixed by reverting the commit.
>>
> 
> Then you just go back to bad usage of the GPIO API. Please see my
> suggestion below.

This revert fixes all the issues I have seen with QCA6390 hardware 
recently. I use a bluetooth mouse, and the hardware hasn't been working 
well for sometime, but really fully broke sometime during the last few 
months. It made my laptop unusable without shutting it down every time I 
wanted to just put it to sleep.

I frankly would prefer the bad usage to live another dev cycle if that's 
what it takes to find a proper solution that doesn't re-break my hardware.

>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>   drivers/bluetooth/hci_qca.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 92fa20f5ac7d..160175a23a49 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2323,7 +2323,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>
>>                  qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>                                                 GPIOD_OUT_LOW);
>> -               if (IS_ERR(qcadev->bt_en) &&
>> +               if (IS_ERR_OR_NULL(qcadev->bt_en) &&
>>                      (data->soc_type == QCA_WCN6750 ||
>>                       data->soc_type == QCA_WCN6855)) {
>>                          dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
>> @@ -2332,7 +2332,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>
>>                  qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
>>                                                 GPIOD_IN);
>> -               if (IS_ERR(qcadev->sw_ctrl) &&
>> +               if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
>>                      (data->soc_type == QCA_WCN6750 ||
>>                       data->soc_type == QCA_WCN6855 ||
>>                       data->soc_type == QCA_WCN7850))
>> @@ -2354,7 +2354,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>          default:
>>                  qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>                                                 GPIOD_OUT_LOW);
>> -               if (IS_ERR(qcadev->bt_en)) {
>> +               if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>                          dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>                          power_ctrl_enabled = false;
> 
> Can you just move this out of this block? Or just simply check the
> presence of the GPIO descriptor in the if block setting the quirk bit?
> Warning on a missing *optional* GPIO is wrong. It's not an unexpected
> situation, it's normal.

Do you have a proposed patch? I am happy to help test it if that helps 
get to a conclusion.

> 
> Bartosz
> 
>>                  }
>> --
>> 2.7.4
>>

-- 
You're more amazing than you think!
