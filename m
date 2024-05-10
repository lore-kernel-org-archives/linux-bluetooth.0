Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9A13D24E
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715383990; cv=none; b=YHCfsehDzbHkjuik0b50TEbd9+hktGiHx4WF6o1HJ/PPKv0Ukn+DHOrYg6v4O/Bntv/ZTuXQqMnvj1MbMd/uS3/aj1UiyKhBNWv3AF5KyXYzOBDMe6p7vxxRT6KE6M4einLJdl4YTJ13XMQYF1/GS1pHuUkGcoZg1szan0cLiao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715383990; c=relaxed/simple;
	bh=+slKx8UFQCV/5Rb4nyPR0zl/iZhibDqJ41OsaEGig4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhevtvJiD17QR2MaW7WvE9cIrH/0QykkZbEgE8a+R8IpyEC1fB46OHMUrdvPpTI4NsITLSFYC7ojh/U0yRuSbszafaMsV2KBGUqMsUiF2t5PrX5VBw88FuDkwjBrckgW1ZVWAIurzJNCJKKMMdwxNqehYYPHgyn6XkXVL/HZYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=dr1sOjTs; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="dr1sOjTs"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b6208c88dcso2059548a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1715383987; x=1715988787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q6/RI9nh09p9I1uu5nuPZNZuLt/wGbnPy7qrN1L7l8c=;
        b=dr1sOjTsCtonvm0J/3rg5zCq4cJ4qq1En/qc85mnzYCt6sjUpAsXdPjCchuTelAyIe
         4pzlSlzi70ONMYzrEDgCi56GSuUDhTyIi9hbHQKzw2eO8ZUqosNYnivl477IJxVQFDGO
         jHbqrzXLnaHJLCQIK9vM/f9ekcgJat9C2KNhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715383987; x=1715988787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6/RI9nh09p9I1uu5nuPZNZuLt/wGbnPy7qrN1L7l8c=;
        b=f+BVP0hIMagE8Yz5NnIvTdMscuY+riGRaZY/JTbbTpjIToI7Yi/QUmtWqAbbAj4caS
         JnAx60pmuqvx/gpfpQu9JYs9bc+k0LEOQiDNSrSVbkAlbR47Fv/XCtamuNinhou93+qo
         2jQkWokaWeSCm1vE04hVHiBeD16u23/APq8lIl2KuB5330OlYTHhod3kVA63x6l0qsGg
         OmhtYj+rq8g0ZKhgPfmwOdFUg0iZ35zZr9wWv4adCBsI9JuL31W3ewqbt2bABNj/9tci
         sLmeDL8yMRxmlo9eP9Cjmocyn9yb/XXbKYvSjO627G+P3u7hVvkuae6+5zFA0xkl9Uj6
         mehw==
X-Gm-Message-State: AOJu0Yzzk4lJeSK2KXCFTobXo5A8SLS1emGge/dg2tnrpKq9MkebVcOR
	8uGGSCMTltBRWdfagsfAPKLaudhiuA4efg19/AocbMHWWPVpzaRDt0wfuiT8+EMX3DrD4WLHpYX
	pxA==
X-Google-Smtp-Source: AGHT+IEJ+V09KLL6jBKSnmmg7ihWz5acBadtJPtIDV+CGtawFB2fgbOOcVzHEtAsZVMqdb+BJjvvQw==
X-Received: by 2002:a17:90a:e38d:b0:2b2:b1c7:5fd7 with SMTP id 98e67ed59e1d1-2b6ccd6b930mr3645573a91.30.1715383987011;
        Fri, 10 May 2024 16:33:07 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b671166f4dsm3760986a91.24.2024.05.10.16.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 16:33:06 -0700 (PDT)
Message-ID: <9cf1f313-c236-43d0-bd98-299478630869@penguintechs.org>
Date: Fri, 10 May 2024 16:33:05 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: path to landing patch to fix warm boot issue for qca6390
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <3475f0dd-6a0f-4319-9590-379eee33f504@penguintechs.org>
 <CABBYNZ+FBwFtrqg1Hj72Q7_6f8hDSwVTNtkofP0XgEd98DRf9A@mail.gmail.com>
 <560c5c03-563a-4f1c-abc1-1372ca73c421@penguintechs.org>
 <CABBYNZK+FGe75VJ4YqsxxyGj-Ac+voeMb3CR9qRD+yz7d=d7oQ@mail.gmail.com>
 <44b75302-1349-445d-90ac-8df8a1fb91e2@penguintechs.org>
 <CABBYNZ+KTV7y-UxWE_6jaHT0wDiMN-xReHW8zLT0WEPHCsyXQQ@mail.gmail.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CABBYNZ+KTV7y-UxWE_6jaHT0wDiMN-xReHW8zLT0WEPHCsyXQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/10/24 2:25 PM, Luiz Augusto von Dentz wrote:
> Hi Wren,
> 
> On Fri, May 10, 2024 at 4:54 PM Wren Turkal <wt@penguintechs.org> wrote:
>>
>> On 5/10/24 12:48 PM, Luiz Augusto von Dentz wrote:
>>> Hi Wren,
>>>
>>> On Fri, May 10, 2024 at 3:14 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>>
>>>> On 5/6/24 12:49 PM, Luiz Augusto von Dentz wrote:
>>>>> Hi Wren,
>>>>>
>>>>> On Mon, May 6, 2024 at 3:24 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>>>>
>>>>>> Krzysztof,
>>>>>>
>>>>>> I am reaching out to you as you had the most important objections to the
>>>>>> change to fix qca6390 for the warm boot/module reload bug that I am
>>>>>> experiencing.
>>>>>>
>>>>>> For context, the problem is that the hci_uart module will send specific
>>>>>> vendor specfic commands during shutdown of the hardware under most
>>>>>> situations. These VSCs put the bluetooth device into a non-working state
>>>>>> on my Dell XPS 13 9310 with qca6390 bluetooth hardware.
>>>>>>
>>>>>> Zijun's proposed fix is to not send these commands when it's not
>>>>>> appropriate for the hardware. The vendor commands should be avoided when
>>>>>> the hardware does not have persistent configuration or when the device
>>>>>> is in setup state (indicating that is has never been setup and should
>>>>>> not be sent the VSCs on the shutdown path). This is what Zijun's patch
>>>>>> implements.
>>>>>>
>>>>>> In addition, Zijun's change removes the influence of both
>>>>>> the QCA_BT_OFF qca flag and and HCI_RUNNING hdev flag. Zijun asserts
>>>>>> that those flags should not influence the sending of the VSCs in the
>>>>>> shutdown path. If I understand KK's objections properly, this is where
>>>>>> his objection is stemming from. KK, is this correct?
>>>>>>
>>>>>> Zijun's proposed fix can be seen here:
>>>>>> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19619-3-git-send-email-quic_zijuhu@quicinc.com/
>>>>>>
>>>>>> I'm wondering if we can resolve this impasse by splitting the change
>>>>>> into two changes, as follows:
>>>>>>
>>>>>> 1. Change that removes the influence of the QCA_BT_OFF and HCI_RUNNING
>>>>>> flags in the shutdown path.
>>>>>> 2. Add the quirk from Zijun's patch that fixes my hardward configuration.
>>>>>>
>>>>>> I'm hoping that better clearer descriptions for #1 can help get that
>>>>>> landed since the logic current appears to be at odds with how the
>>>>>> hardware works.
>>>>>>
>>>>>> Also, I am happy to split the patches into the two patches, or (maybe
>>>>>> more ideally) just modify the commit message to better indicate the
>>>>>> reason the change. I just need guidance from maintainers so that
>>>>>> whatever work I do leads to something acceptable for y'all.
>>>>>>
>>>>>> So, please help me get this done. I am just a user with broken hardware
>>>>>> and a fondness for Linux. I would love to help do what's needed to get
>>>>>> this fix landed.
>>>>>
>>>>> Ive also objected to that change, in fact the whole shutdown sequence
>>>>> is sort of bogus in my opinion and the driver shall really have some
>>>>> means to find out what mode it is in when it reboots, regardless if
>>>>> cold or warm boot, since otherwise we are in trouble if the user is
>>>>> booting from another OS that doesn't do the expected shutdown
>>>>> sequence.
>>>>
>>>> This criticism makes a ton of sense. I'm sorry I missed it before. There
>>>> were a lot of threads moving in parallel. However, I am curious. Given
>>>> that the patch improves the situation for users (like me). Is there any
>>>> way we can separate the redesign of the shutdown sequence and the UX
>>>> improvement that comes with this patch?
>>>>
>>>> Here's my concern. I am happy to do the work to redesign this. However,
>>>> I don't think I have the information needed to do this since I don't
>>>> have access to the technical docs for the qca6390. I am worried that not
>>>> accepting some form of this patch is letting perfect be the enemy of the
>>>> good. And I am not sure how I personally can help with that. If you
>>>> think it's possible for me to do this without the docs for the hardware,
>>>> I am willing to give it a shot if I can get some guidance. Honestly, I
>>>> wish I had the skill to be confident about a change like this, but I don't.
>>>>
>>>> Any ideas on how to move forward would be greatly appreciated.
>>>>
>>>> And just to be perfectly clear, I have tested this patch on my laptop.
>>>> It greatly enhances my ability to use my hardware since I can reboot the
>>>> machine without having to make sure to power cycle the laptop. This is
>>>> not a theoretical improvement.
>>>
>>> I would really love some explanation why can't the driver know under
>>> what mode the controller is when it gets probed, because to me we
>>> cannot accept a driver that only works under certain condition after
>>> the boot and in case it is really impossible, can't even power cycle
>>> it to get it back to cold boot stage???
>>
>> This is a great technical criticism of the driver, and I think you
>> deserve that explanation.
>>
>> However, with the driver already in the kernel, shouldn't the bias be
>> toward mitigating the extremely bad UX and not hold users hostage for
>> the bad design which has already been approved and landed in the kernel?
>>
>>> Also the criticism here should be directed to the vendor, how long
>>> have we been discussing problems in the QCA driver? And the only thing
>>> I see coming our way are work-arounds of the problems, the address not
>>> being unique coming from the firmware itself and when provided via DT
>>> the address is in the wrong byteorder and now that the driver must
>>> communicate the firmware on shutdown in order to get it working
>>> properly on the next boot.
>>
>> I agree that Qualcomm should get flack for this, however, the UX problem
>> can be mitigated with a logic fix that doesn't make the init/shutdown
>> design problem any worse than it currently seems to be. I mean, wouldn't
>> this logic have to exist somewhere even if it weren't the shutdown path?
>>
>> If you are trying to use this as leverage to get Qualcomm to do a bigger
>> thing (redesign the init/shutdown logic), I do think that tactic
>> needlessly puts users in the crossfire. I can totally understand why
>> you'd do it. I am just suffering the crossfire in the meantime, and it
>> doesn't feel great.
> 
> So you prefer to risk getting a kernel crash due to UAF over Bluetooth
> not working? Really? Because I haven't seen any configuration that
> those changes you tested don't reintroduce the UAF, which is why I
> haven't applied that change to begin with, so no I'm not holding back
> to pressure Qualcomm to redesign the shutdown logic, it just these
> things got entangled because I just realized the shutdown thingy is
> really out of place, imo, but I'd be fine if there is a temporary fix
> until someone finally decide to spend some time to really fix the
> shutdown logic.

Luiz, I'm sorry. I do not want a crash instead. I didn't understand that 
the solution I proposed (i.e. adding Zijun's logic without removing KK's 
logic) would introduce a new crash opportunity. I previously thought you 
were saying one of the following things:
1. The crash opportunity already existed due the init/shudown sequences.
2. The crash opportunity already existed due the init/shudown sequences 
when removing KK's logic.

If it was #1, I was hoping that adding the logic would make the risk no 
worse.

If it was #2, I was hoping that my suggestion of adding Zijun's logic 
without removing KK's logic might represent an acceptable middleground 
for a temporary fix that would "correct" the logic without introducing a 
new crash opportunity.

I feel like I may not be clear about what I mean by adding Zijun's logic 
and not removing KK's logic. Maybe something like this diff:

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 2f7ae38d85eb..fcac44ae7898 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2456,6 +2456,10 @@ static void qca_serdev_shutdown(struct device *dev)
                      !test_bit(HCI_RUNNING, &hdev->flags))
                          return;

+               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP,
&hdev->quirks) ||
+                   hci_dev_test_flag(hdev, HCI_SETUP))
+                       return;
+
                  serdev_device_write_flush(serdev);
                  ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
                                                sizeof(ibs_wake_cmd));

I think this diff is mangled due to using Thunderbird, but I hope this 
helps convey what I was asking about.

If I am understanding you correctly now, you are saying that simply 
introducing Zijun's logic (without removing KK's logic) will introduce a 
new crash opportunity. Is that correct?

Thanks,
wt
-- 
You're more amazing than you think!
