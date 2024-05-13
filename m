Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1877D40D
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715631231; cv=none; b=ayTqnq1Uicif/BrZ6mYyuRhNFlARW4xA+mxbJYRgSO7HwDgR0FFfpO6PYB5QhoAYnfZCKe9E3LPdQFN9oONp8CWu0VeDH7wfxOSfk2MrmsQmOafF0vczXpBPpyMXxmQY9pyHYEJkixB+h8lhBSQ/Ifkef6V6dvU7Ga/qR7nk3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715631231; c=relaxed/simple;
	bh=IjvyXK/UAQvDzQAubbZC+l4Ofw3C+DfTMiTRjNWW4Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptQ+RkwNYdIbW2pzfK3MKlg6y6iSfs7FYOXTLqA8aTvidJwL9GoM3tFKeXa96/gMJhaCRG7OG5JYac8Y+wzgOq1lw/GmxR917J0iicfhOY26DrKpNJgaE+yhxl2yRa60jtRaI3/qxHWkB7K5nbWHLzA8WMKABlRq84ZjMQKRTGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=Amz+s+IB; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="Amz+s+IB"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f1027cf826so1040485a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1715631227; x=1716236027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z+n6EbPlfw7KI7Z9AbnQx9pnJTiWRObGJWS50VOpgK4=;
        b=Amz+s+IBH7ixew4IEX2A7GFwxfkU+VpN0bj4KB1Eu12KYz6HeE5W8wtUE4IiINtvAN
         AN7pjDlgAwaxyy/g9vDgU7Q2h555XzNeqIo7NM8YEL5IEiQeR92fGnxnIkVsn4xcu8+3
         MDgdr5beIl0pb14+qkxGUJJ8thFD8Re5K3H6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715631227; x=1716236027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+n6EbPlfw7KI7Z9AbnQx9pnJTiWRObGJWS50VOpgK4=;
        b=nVx7bNmmqq0WvUoLXUOaZX0R8SxtfTwJhHFaIkRDsboPG04vWJ1o+KIUqInLAqSPvq
         hn32Na7jYuhJid5oMaz0iNijYhFLWGanMulmIviQZP8pAeqS99DED3aO0ix+sXD1tc9A
         ScLPwXefM5clhCsIVVGFkY6i25EgRaB6u+jFjraBdsVPH+6uOP6msnJ5CDL+L/xUOtxA
         pkb1SgTFRAcP3E6BgL7CVR2a06GDC8ryHQwirwnEPOTKf7lFv+zgKyTNT6RqOZXPRK1m
         SKjKS89NTzOC1Xu/zYos51a5zeFzr2c7srYIKwJ/NP2z9Nmx6ZlYBjDVmI8jVTbcICXm
         UMIQ==
X-Gm-Message-State: AOJu0YwosSi00hBe9tqFdxEi+6gIOE8y0jnASFMZszeL2hUNMzlP6c0Q
	R4o5hWitx/dHex4EZCP83QcRl3w2LaMLqMd1cjte1ip/Ei2ODdz/XRGdTEiLPw==
X-Google-Smtp-Source: AGHT+IGM+9dz8fBOR3OG7ucDKLupwL1Bn22Cdj+YLKalByn7OSL/DfB2d5P4UPCnHI8VyLmjnZoNFQ==
X-Received: by 2002:a05:6871:520a:b0:23c:58e5:9d7d with SMTP id 586e51a60fabf-24172c2acdbmr13431392fac.32.1715631227395;
        Mon, 13 May 2024 13:13:47 -0700 (PDT)
Received: from [10.21.160.242] ([146.74.94.63])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412acfa1b1sm2232426fac.56.2024.05.13.13.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 13:13:46 -0700 (PDT)
Message-ID: <4104e918-7e8f-4494-93c5-8f606c13d61b@penguintechs.org>
Date: Mon, 13 May 2024 13:13:39 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: path to landing patch to fix warm boot issue for qca6390
To: Lk Sii <lk_sii@163.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
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
 <9cf1f313-c236-43d0-bd98-299478630869@penguintechs.org>
 <8de52d0c-ed3f-47b3-a318-b1942c193978@163.com>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <8de52d0c-ed3f-47b3-a318-b1942c193978@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/10/24 11:25 PM, Lk Sii wrote:
> On 2024/5/11 07:33, Wren Turkal wrote:
>> On 5/10/24 2:25 PM, Luiz Augusto von Dentz wrote:
>>> Hi Wren,
>>>
>>> On Fri, May 10, 2024 at 4:54 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>>
>>>> On 5/10/24 12:48 PM, Luiz Augusto von Dentz wrote:
>>>>> Hi Wren,
>>>>>
>>>>> On Fri, May 10, 2024 at 3:14 PM Wren Turkal <wt@penguintechs.org>
>>>>> wrote:
>>>>>>
>>>>>> On 5/6/24 12:49 PM, Luiz Augusto von Dentz wrote:
>>>>>>> Hi Wren,
>>>>>>>
>>>>>>> On Mon, May 6, 2024 at 3:24 PM Wren Turkal <wt@penguintechs.org>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> Krzysztof,
>>>>>>>>
>>>>>>>> I am reaching out to you as you had the most important objections
>>>>>>>> to the
>>>>>>>> change to fix qca6390 for the warm boot/module reload bug that I am
>>>>>>>> experiencing.
>>>>>>>>
>>>>>>>> For context, the problem is that the hci_uart module will send
>>>>>>>> specific
>>>>>>>> vendor specfic commands during shutdown of the hardware under most
>>>>>>>> situations. These VSCs put the bluetooth device into a
>>>>>>>> non-working state
>>>>>>>> on my Dell XPS 13 9310 with qca6390 bluetooth hardware.
>>>>>>>>
>>>>>>>> Zijun's proposed fix is to not send these commands when it's not
>>>>>>>> appropriate for the hardware. The vendor commands should be
>>>>>>>> avoided when
>>>>>>>> the hardware does not have persistent configuration or when the
>>>>>>>> device
>>>>>>>> is in setup state (indicating that is has never been setup and
>>>>>>>> should
>>>>>>>> not be sent the VSCs on the shutdown path). This is what Zijun's
>>>>>>>> patch
>>>>>>>> implements.
>>>>>>>>
>>>>>>>> In addition, Zijun's change removes the influence of both
>>>>>>>> the QCA_BT_OFF qca flag and and HCI_RUNNING hdev flag. Zijun asserts
>>>>>>>> that those flags should not influence the sending of the VSCs in the
>>>>>>>> shutdown path. If I understand KK's objections properly, this is
>>>>>>>> where
>>>>>>>> his objection is stemming from. KK, is this correct?
>>>>>>>>
>>>>>>>> Zijun's proposed fix can be seen here:
>>>>>>>> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19619-3-git-send-email-quic_zijuhu@quicinc.com/
>>>>>>>>
>>>>>>>> I'm wondering if we can resolve this impasse by splitting the change
>>>>>>>> into two changes, as follows:
>>>>>>>>
>>>>>>>> 1. Change that removes the influence of the QCA_BT_OFF and
>>>>>>>> HCI_RUNNING
>>>>>>>> flags in the shutdown path.
>>>>>>>> 2. Add the quirk from Zijun's patch that fixes my hardward
>>>>>>>> configuration.
>>>>>>>>
>>>>>>>> I'm hoping that better clearer descriptions for #1 can help get that
>>>>>>>> landed since the logic current appears to be at odds with how the
>>>>>>>> hardware works.
>>>>>>>>
>>>>>>>> Also, I am happy to split the patches into the two patches, or
>>>>>>>> (maybe
>>>>>>>> more ideally) just modify the commit message to better indicate the
>>>>>>>> reason the change. I just need guidance from maintainers so that
>>>>>>>> whatever work I do leads to something acceptable for y'all.
>>>>>>>>
>>>>>>>> So, please help me get this done. I am just a user with broken
>>>>>>>> hardware
>>>>>>>> and a fondness for Linux. I would love to help do what's needed
>>>>>>>> to get
>>>>>>>> this fix landed.
>>>>>>>
>>>>>>> Ive also objected to that change, in fact the whole shutdown sequence
>>>>>>> is sort of bogus in my opinion and the driver shall really have some
>>>>>>> means to find out what mode it is in when it reboots, regardless if
>>>>>>> cold or warm boot, since otherwise we are in trouble if the user is
>>>>>>> booting from another OS that doesn't do the expected shutdown
>>>>>>> sequence.
>>>>>>
>>>>>> This criticism makes a ton of sense. I'm sorry I missed it before.
>>>>>> There
>>>>>> were a lot of threads moving in parallel. However, I am curious. Given
>>>>>> that the patch improves the situation for users (like me). Is there
>>>>>> any
>>>>>> way we can separate the redesign of the shutdown sequence and the UX
>>>>>> improvement that comes with this patch?
>>>>>>
>>>>>> Here's my concern. I am happy to do the work to redesign this.
>>>>>> However,
>>>>>> I don't think I have the information needed to do this since I don't
>>>>>> have access to the technical docs for the qca6390. I am worried
>>>>>> that not
>>>>>> accepting some form of this patch is letting perfect be the enemy
>>>>>> of the
>>>>>> good. And I am not sure how I personally can help with that. If you
>>>>>> think it's possible for me to do this without the docs for the
>>>>>> hardware,
>>>>>> I am willing to give it a shot if I can get some guidance. Honestly, I
>>>>>> wish I had the skill to be confident about a change like this, but
>>>>>> I don't.
>>>>>>
>>>>>> Any ideas on how to move forward would be greatly appreciated.
>>>>>>
>>>>>> And just to be perfectly clear, I have tested this patch on my laptop.
>>>>>> It greatly enhances my ability to use my hardware since I can
>>>>>> reboot the
>>>>>> machine without having to make sure to power cycle the laptop. This is
>>>>>> not a theoretical improvement.
>>>>>
>>>>> I would really love some explanation why can't the driver know under
>>>>> what mode the controller is when it gets probed, because to me we
>>>>> cannot accept a driver that only works under certain condition after
>>>>> the boot and in case it is really impossible, can't even power cycle
>>>>> it to get it back to cold boot stage???
>>>>
>>>> This is a great technical criticism of the driver, and I think you
>>>> deserve that explanation.
>>>>
>>>> However, with the driver already in the kernel, shouldn't the bias be
>>>> toward mitigating the extremely bad UX and not hold users hostage for
>>>> the bad design which has already been approved and landed in the kernel?
>>>>
>>>>> Also the criticism here should be directed to the vendor, how long
>>>>> have we been discussing problems in the QCA driver? And the only thing
>>>>> I see coming our way are work-arounds of the problems, the address not
>>>>> being unique coming from the firmware itself and when provided via DT
>>>>> the address is in the wrong byteorder and now that the driver must
>>>>> communicate the firmware on shutdown in order to get it working
>>>>> properly on the next boot.
>>>>
>>>> I agree that Qualcomm should get flack for this, however, the UX problem
>>>> can be mitigated with a logic fix that doesn't make the init/shutdown
>>>> design problem any worse than it currently seems to be. I mean, wouldn't
>>>> this logic have to exist somewhere even if it weren't the shutdown path?
>>>>
>>>> If you are trying to use this as leverage to get Qualcomm to do a bigger
>>>> thing (redesign the init/shutdown logic), I do think that tactic
>>>> needlessly puts users in the crossfire. I can totally understand why
>>>> you'd do it. I am just suffering the crossfire in the meantime, and it
>>>> doesn't feel great.
>>>
>>> So you prefer to risk getting a kernel crash due to UAF over Bluetooth
>>> not working? Really? Because I haven't seen any configuration that
>>> those changes you tested don't reintroduce the UAF, which is why I
>>> haven't applied that change to begin with, so no I'm not holding back
>>> to pressure Qualcomm to redesign the shutdown logic, it just these
>>> things got entangled because I just realized the shutdown thingy is
>>> really out of place, imo, but I'd be fine if there is a temporary fix
>>> until someone finally decide to spend some time to really fix the
>>> shutdown logic.
>>
>> Luiz, I'm sorry. I do not want a crash instead. I didn't understand that
>> the solution I proposed (i.e. adding Zijun's logic without removing KK's
>> logic) would introduce a new crash opportunity. I previously thought you
>> were saying one of the following things:
>> 1. The crash opportunity already existed due the init/shudown sequences.
>> 2. The crash opportunity already existed due the init/shudown sequences
>> when removing KK's logic.
>>
>> If it was #1, I was hoping that adding the logic would make the risk no
>> worse.
>>
>> If it was #2, I was hoping that my suggestion of adding Zijun's logic
>> without removing KK's logic might represent an acceptable middleground
>> for a temporary fix that would "correct" the logic without introducing a
>> new crash opportunity.
>>
>> I feel like I may not be clear about what I mean by adding Zijun's logic
>> and not removing KK's logic. Maybe something like this diff:
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 2f7ae38d85eb..fcac44ae7898 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2456,6 +2456,10 @@ static void qca_serdev_shutdown(struct device *dev)
>>                       !test_bit(HCI_RUNNING, &hdev->flags))
>>                           return;
>>
>> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP,
>> &hdev->quirks) ||
>> +                   hci_dev_test_flag(hdev, HCI_SETUP))
>> +                       return;
>> +
>>                   serdev_device_write_flush(serdev);
>>                   ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
>>                                                 sizeof(ibs_wake_cmd));
>>
>> I think this diff is mangled due to using Thunderbird, but I hope this
>> helps convey what I was asking about.
>>
>> If I am understanding you correctly now, you are saying that simply
>> introducing Zijun's logic (without removing KK's logic) will introduce a
>> new crash opportunity. Is that correct?
>>
> 
> as Zijun declared. i believe Zijun's change will solve both this
> reported regression issue and the use-after-free(crash) issue.

I did see Zijun's claim of that. However, I think that both KK and Luiz 
are not convinced by the explanation. Also, if that explanation does 
convince KK and Luiz, I think that the explanation needs to be added to 
the commit message.

I'm hoping that Luiz will at least respond to the middleground I 
proposed as a workaround.

Luiz and KK, I also want y'all to know that I really appreciate your 
striving to make this work well and taking the time to explain some of 
it to me. I know I must seem like a pest at this point, and I am sorry 
for that. I do wish I had more ability to propose a workable fix, both 
for the reason that I am personally being hurt by this problem and the 
fact that I think it reflects badly on Linux to have an issue like this 
exposed to users.

wt
-- 
You're more amazing than you think!
