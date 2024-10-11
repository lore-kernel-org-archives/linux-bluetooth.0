Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D01D0E3E
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675884; cv=none; b=hBcWu+Mkja4iQdd3liDuVhAJMCY3U9FpJXH9eFjUWO7vnGxA7elKHw51T542cDWXy8EZHY9vKbPBqEAsdjgEj+4w/g16XJ7xCHj+pOgcaO2YQJUN1fmbNcIJ8zdvy0gQhHA+GVGa7CDalsAjQksK+y1gHp2m0VOtKRlU1JnWj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675884; c=relaxed/simple;
	bh=kFcEgB2CJz1FrrqLKgnOJDaEQEuUwWWISZ0wGWciTZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzk87gaxtojTL1cCTazhaFXW2cIsPWAmLRSTIrDUD0MgjO3nguiGmPdzBY69v49usTcBGexwPj0XJXOaVEsYcspBqgl7ANC5aT2Hs1Rz9IIOsFmAyX7W/h95OaNJ4OOvBaYCB0glJB9aNcxJ2ON616y0DSfa4ETCsDCA96/u7OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOSRNjA6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOSRNjA6"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso3039582a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728675881; x=1729280681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jJvDHt4YK6Cs4sDBMvCrEy0TKVBA6CD4Wb+UBS13S9Q=;
        b=MOSRNjA6MqGVBUalc1yLxC2MAWrJeILeydoySQzI2ge6x0Fxx5k1IcJuyzsP4Ts5Fr
         1kTggoGiMzswDgZMiudSXkNwliSsJS/R5QmT+D/27X4eleMeTjF3/qzxka8xgGU9/28y
         Y2zPu4SFRTGVKiIvMiGEXvX4FKZhNQBjgX6Fvpdjwn3EA4iEENENhnhG/xAV7gi3VnUW
         lY68PR3cvjL8Pya2FOaGlGQv0XTV5f8D7GgfTo4a5HhAEae8n6vJ0orLLbGU9ZexcfDz
         5FYNie86SD8KomSkPrPGKOJe4Dz0kIl27mlWelL6FtzYf5Kp1nixqO717ovQF6r4Jnrg
         GdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675881; x=1729280681;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJvDHt4YK6Cs4sDBMvCrEy0TKVBA6CD4Wb+UBS13S9Q=;
        b=o2lYpcYQmBoH1WeqALRogRW5x8G/1Ke5hgBtMAFAxy0D0Edqrxfp2BNzL6RreWfkPJ
         rOLJN6CM4sm3o3PA742uevhL7Iw7NBAYQJ8H3Qv8oYXibWHmZokvtiDjIdiCMG3wOqGb
         AKInpx4iHUHt0ZAD2loV7wVc4DnwdkmM9EcjsiGIHrDlriVogtG8S0FTdj6zvAB7+gzw
         mep4Q3+VsF/dUne7rqG2cqu3lp2hHKN26VRfyeFwxdc0o7XltK4L3vlRvnouxonaS+Md
         tYxu91Lnj5CVFWv+dMG9KGzWYdSsyBGH4VlXDACF88+eaqW6qno9tK7tsBQN8Npih/24
         WOTA==
X-Forwarded-Encrypted: i=1; AJvYcCUZrMKlh2d456IkotRggjk1R9MrbS1bQo8VF2OE6fcXsP4vwvq4DL6e/u6gbMx5gE/tJQyThO62eYm0A/iKgAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh3uOc1YjjZvxmkocJ3AdFhdgp3TFKg6sZOaOTCCfHi5ncmw+x
	JmvUQ+4puE6pYhyYc7SES+YdUh6EvffRW1/hfXxkyG+dkpfzzRwi
X-Google-Smtp-Source: AGHT+IHov9pO7rlIARUSE2FKkpxlxralWHqkeoj+Grm53dE0BP/HM9mQqALvj7zluyOczNVV79gvOg==
X-Received: by 2002:a05:6402:5ca:b0:5c4:aea:5833 with SMTP id 4fb4d7f45d1cf-5c9475942d2mr3274813a12.18.1728675880608;
        Fri, 11 Oct 2024 12:44:40 -0700 (PDT)
Received: from ?IPV6:2a02:3100:afd7:9a00:94ac:542a:1cd2:c9ce? (dynamic-2a02-3100-afd7-9a00-94ac-542a-1cd2-c9ce.310.pool.telefonica.de. [2a02:3100:afd7:9a00:94ac:542a:1cd2:c9ce])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c937260c5esm2207067a12.76.2024.10.11.12.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 12:44:39 -0700 (PDT)
Message-ID: <d85205ed-dd47-4690-99a3-8f20ea7ab237@gmail.com>
Date: Fri, 11 Oct 2024 21:44:38 +0200
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
 <c8b5c842-463e-4c30-b7e0-f41bf1d59305@gmail.com>
 <CABBYNZ+kcwgPvCNFZHZZok_a6ZNXEPNABNefb4iaSNDNm4wPVA@mail.gmail.com>
 <CABBYNZKbXE4unZi3MPP2LPzYcv0OLHoaqqey02N1qUzSR=4PhQ@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CABBYNZKbXE4unZi3MPP2LPzYcv0OLHoaqqey02N1qUzSR=4PhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11.10.2024 21:26, Luiz Augusto von Dentz wrote:
> Hi Heiner,
> 
> On Fri, Oct 11, 2024 at 3:05 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Heiner,
>>
>> On Fri, Oct 11, 2024 at 2:52 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>
>>> On 11.10.2024 18:36, Luiz Augusto von Dentz wrote:
>>>> Hi Heiner,
>>>>
>>>> On Fri, Oct 11, 2024 at 6:49 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>>
>>>>> Since linux-next from Oct 4th my bt speaker fails to connect if I switch it on.
>>>>> It just hangs trying. Manually connecting it via bluetoothctl works though.
>>>>> With this patch reverted it auto-connects again.
>>>>> If you need additional details, please let me know.
>>>>
>>>> I suspect something is trying to suspend the controller then, it
>>>> shouldn't be USB auto-suspend since that should behave as it
>>>> previously but if there is something externally (aka. userspace)
>>>> trying to suspend then it will force it to suspend.
>>>>
>>> On the host side it's a combined WiFi/BT PCIe adapter (RTL8822CE).
>>> Runtime PM is enabled, so this may kick in. I'm not aware of any
>>> userspace tool which may try to suspend the WiFi/BT adapter.
>>> Disabling Runtime PM may be a workaround, but I don't think that's
>>> the actual solution.
>>>
>>
>> Well I assume it still using USB as transport, not PCIe, otherwise it
>> wouldn't be using btusb. Regarding runtime PM, I assume it still means
>> PMSG_IS_AUTO Documentation/driver-api/usb/power-management.rst:
>>
>>      'External suspend calls should never be allowed to fail in this way,
>>      only autosuspend calls.  The driver can tell them apart by applying
>>      the :c:func:`PMSG_IS_AUTO` macro to the message argument to the
>>      ``suspend`` method; it will return True for internal PM events'
>>
>> --
>> Luiz Augusto von Dentz
> 
> Perhaps there is a double call to the likes of hci_suspend_dev due to
> system suspend and device suspend acting together, so maybe we need
> something like the following:
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 779c4aeaef22..c257759ae2f4 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2812,7 +2812,7 @@ int hci_suspend_dev(struct hci_dev *hdev)
> 
>         /* Suspend should only act on when powered. */
>         if (!hdev_is_powered(hdev) ||
> -           hci_dev_test_flag(hdev, HCI_UNREGISTER))
> +           hci_dev_test_flag(hdev, HCI_UNREGISTER) || hdev->suspended)
>                 return 0;
> 
>         /* If powering down don't attempt to suspend */
> @@ -2843,7 +2843,7 @@ int hci_resume_dev(struct hci_dev *hdev)
> 
>         /* Resume should only act on when powered. */
>         if (!hdev_is_powered(hdev) ||
> -           hci_dev_test_flag(hdev, HCI_UNREGISTER))
> +           hci_dev_test_flag(hdev, HCI_UNREGISTER) || !hdev->suspended)
>                 return 0;
> 
>         /* If powering down don't attempt to resume */
> 
> 
No change in behavior with this change.

