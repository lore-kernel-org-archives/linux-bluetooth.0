Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7667199231
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680197; cv=none; b=ot6lk//ThThvmt0LQqZFpkTTIfz8snR/yN4ywx5eUGyvSr8/q52h73eNalNMUcZiI3lrL9ff841pUkqDn4kYDsVDbeyFPA/IdQbkDJUoRbO4BvANRBe3ReRwVneQ8sYdt8HqTXvbOcUuqpKKJpHMpLKHzu6NYcjJxMcnG70lXHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680197; c=relaxed/simple;
	bh=InUQ1xCuWBMPd1en11ojZZjgGRXsJC15i3XNyAo1buw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2lRcEXWs+qruc81jCoD0zaaoenL8dhba3roDPw/bHx2SL5eNkohuhxm0BKSWrxcGdZ1A8OmImZJEjnJDfGbahIvdhgvG4K1ZKKi26w2NtNtnYzishHvq+srlHscYyvW+RxQ0fkVqaver0N8oCHaQb2zFRZ7WUhTzzJsgbGE3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF+h9NBh; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF+h9NBh"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2facf40737eso26433031fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 13:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728680194; x=1729284994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LoD7MlR38yZkTFjp8t3SrLKDJdwyTQ09cwufWBy+wB8=;
        b=fF+h9NBhfKIkNjiggKRfnO1oHm5EQRKM6eUESfknDnuIbN94M7yuUncAwPw2LtN8bK
         RRdHxjMjUwSOH7FRilcZLMoA8/vz3ChZ9G0b6Np72ivf6bxYxUVXvD26BiZMQVflHL15
         kT890Fn6jf+V2/oCgxXbNzE4IJnzz7FTVhFmdcLjY2fe571jkXXVRpqqBayeZgQIr0ju
         QDmXwOh3DjHW/XUyh7opKNIYOot9WbfzAVvaZZnQPGEqnMim7Enpltkl2T3HJ0nAMY9f
         sn/5t6drRP4AvZujEfnUhQl1+EJYSybZCNG/fISnvkNOETYuogwtqacseciG6sF5+vlA
         5BHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728680194; x=1729284994;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoD7MlR38yZkTFjp8t3SrLKDJdwyTQ09cwufWBy+wB8=;
        b=qFppNzuvJ/NWMoV1cOuMBXZrcOpXc7Hc8j2FgW7VngQFPN3Jx2zgm8PZefxmgmeKOR
         XFUvN/TpeeSyRURR/t0ztIj/1u9sPYWvqG4Tj5keDCVi2dXmhbQN+cVPkz/6ge46axfH
         8B42ZfON91ZNb9Sm4HY/ynod23eQfECU+sV8XuL2tD3nEz2fNQ0GbUO1c42jwZfWaep4
         Q41O/PJIe68FBw8gau1sqjzMF/NdTz28Rxn1Tw/FEPjNT3qHD71DFJwZ1P9v1k1fZtw3
         xH0Kod0n3Hspe6oPvmM50bYamnqf3g/glCvGIDtiMHQIcFGynE2fp/PUyJZL5ePmdx9Y
         n6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDZC4cAgGuNz2hs+vymQnccN3peY7CCYD/S9ngi9Meelu3dOz++bPP3GW3Zi+fE/nhSMhibDIjx8PN4d9u8t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwitP5MFy05+jvNjMk1L9uof9ag6bK4QkI6D4ONkd6GRcqBPeCk
	hi9FkN70r/dZoITaqN+rYRPe4uwkwb00RskrEKf5h0gWH5t6Pdc8
X-Google-Smtp-Source: AGHT+IHtQaF5OyYly+Y1ZNY7VbggksDtkDPXenIlCk/BJlJkqg/hQsqLKvFdJHY3dNz/je6BlyPuew==
X-Received: by 2002:a2e:be2c:0:b0:2fa:c9eb:53ce with SMTP id 38308e7fff4ca-2fb3f246ef8mr5009081fa.26.1728680193812;
        Fri, 11 Oct 2024 13:56:33 -0700 (PDT)
Received: from ?IPV6:2a02:3100:afd7:9a00:94ac:542a:1cd2:c9ce? (dynamic-2a02-3100-afd7-9a00-94ac-542a-1cd2-c9ce.310.pool.telefonica.de. [2a02:3100:afd7:9a00:94ac:542a:1cd2:c9ce])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c93726096fsm2348073a12.71.2024.10.11.13.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:56:32 -0700 (PDT)
Message-ID: <4492450a-aa01-49ae-9ff4-ef3641a6b6f2@gmail.com>
Date: Fri, 11 Oct 2024 22:56:32 +0200
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
 <d85205ed-dd47-4690-99a3-8f20ea7ab237@gmail.com>
 <CABBYNZL7BJq57iJEm8y6D1JWikymC-gSP-N6jHXpgBjgWC_B6A@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CABBYNZL7BJq57iJEm8y6D1JWikymC-gSP-N6jHXpgBjgWC_B6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11.10.2024 22:06, Luiz Augusto von Dentz wrote:
> Hi Heiner,
> 
> On Fri, Oct 11, 2024 at 3:44 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 11.10.2024 21:26, Luiz Augusto von Dentz wrote:
>>> Hi Heiner,
>>>
>>> On Fri, Oct 11, 2024 at 3:05 PM Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>>
>>>> Hi Heiner,
>>>>
>>>> On Fri, Oct 11, 2024 at 2:52 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>>
>>>>> On 11.10.2024 18:36, Luiz Augusto von Dentz wrote:
>>>>>> Hi Heiner,
>>>>>>
>>>>>> On Fri, Oct 11, 2024 at 6:49 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>>>>
>>>>>>> Since linux-next from Oct 4th my bt speaker fails to connect if I switch it on.
>>>>>>> It just hangs trying. Manually connecting it via bluetoothctl works though.
>>>>>>> With this patch reverted it auto-connects again.
>>>>>>> If you need additional details, please let me know.
>>>>>>
>>>>>> I suspect something is trying to suspend the controller then, it
>>>>>> shouldn't be USB auto-suspend since that should behave as it
>>>>>> previously but if there is something externally (aka. userspace)
>>>>>> trying to suspend then it will force it to suspend.
>>>>>>
>>>>> On the host side it's a combined WiFi/BT PCIe adapter (RTL8822CE).
>>>>> Runtime PM is enabled, so this may kick in. I'm not aware of any
>>>>> userspace tool which may try to suspend the WiFi/BT adapter.
>>>>> Disabling Runtime PM may be a workaround, but I don't think that's
>>>>> the actual solution.
>>>>>
>>>>
>>>> Well I assume it still using USB as transport, not PCIe, otherwise it
>>>> wouldn't be using btusb. Regarding runtime PM, I assume it still means
>>>> PMSG_IS_AUTO Documentation/driver-api/usb/power-management.rst:
>>>>
>>>>      'External suspend calls should never be allowed to fail in this way,
>>>>      only autosuspend calls.  The driver can tell them apart by applying
>>>>      the :c:func:`PMSG_IS_AUTO` macro to the message argument to the
>>>>      ``suspend`` method; it will return True for internal PM events'
>>>>
>>>> --
>>>> Luiz Augusto von Dentz
>>>
>>> Perhaps there is a double call to the likes of hci_suspend_dev due to
>>> system suspend and device suspend acting together, so maybe we need
>>> something like the following:
>>>
>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>> index 779c4aeaef22..c257759ae2f4 100644
>>> --- a/net/bluetooth/hci_core.c
>>> +++ b/net/bluetooth/hci_core.c
>>> @@ -2812,7 +2812,7 @@ int hci_suspend_dev(struct hci_dev *hdev)
>>>
>>>         /* Suspend should only act on when powered. */
>>>         if (!hdev_is_powered(hdev) ||
>>> -           hci_dev_test_flag(hdev, HCI_UNREGISTER))
>>> +           hci_dev_test_flag(hdev, HCI_UNREGISTER) || hdev->suspended)
>>>                 return 0;
>>>
>>>         /* If powering down don't attempt to suspend */
>>> @@ -2843,7 +2843,7 @@ int hci_resume_dev(struct hci_dev *hdev)
>>>
>>>         /* Resume should only act on when powered. */
>>>         if (!hdev_is_powered(hdev) ||
>>> -           hci_dev_test_flag(hdev, HCI_UNREGISTER))
>>> +           hci_dev_test_flag(hdev, HCI_UNREGISTER) || !hdev->suspended)
>>>                 return 0;
>>>
>>>         /* If powering down don't attempt to resume */
>>>
>>>
>> No change in behavior with this change.
> 
> Ok, I guess we can rule out system suspend then, does commenting out
> the call to hci_suspend_dev makes it works again? If it does it means
> the device is suspending and it appears the likes of
> HCI_FLT_CONN_SETUP either doesn't work or is not being set to the
> controller to allow incoming connections, since it is an Audio device
> I think the problem is that we don't set HCI_CONN_FLAG_REMOTE_WAKEUP,
> only input device do set it, so we may need to treat device suspend
> and system suspend differently.
> 

The following makes it work again.

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7860750ec..33fd65d49 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2808,6 +2808,8 @@ int hci_suspend_dev(struct hci_dev *hdev)
 {
 	int ret;
 
+	return 0;
+
 	bt_dev_dbg(hdev, "");
 
 	/* Suspend should only act on when powered. */

