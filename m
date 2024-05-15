Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669CE39ACD
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715749721; cv=none; b=GVX0pVPY95Lykv6TNSPcPXC0PGNLnoreHIXPceGz5YhE++zOsd1Zfo1C+Ed1sxvxBHazjkLdTDrFpyi8fXFjJdfj4kVwTZ/mzcWpfG8FB0UkAkbJQb8AFxjmahLKZrPOSxgh31zzypFvo8DueBe8pdTyqLGbp11S4Itzl+q4R0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715749721; c=relaxed/simple;
	bh=AjOO6nBj9mY+mnyVk2ovg4A1ZUweRCNyKCa0RLUetY0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aXwLhNhpke+Bza8v+FQTm2FtjrLM9uek8rWKbabqAiaGdyZk9IzRBC1RSz8FqOSi/af9BgiCEPKKwA3LDWCXBbNY1VWNLFg+l0lGfY+73y40oYBRcy54tr9YTrOOcUsF2ogu2cec7cM6xs+fM4Cz45liZ7Q1MfV98CgPfrxSv+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=CWGeURG2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="CWGeURG2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1eecc71311eso53587645ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 22:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1715749717; x=1716354517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=irlyo/ceigW/C5WdJCvCZ0dyBCtZrfqb0gEvCAVTXS0=;
        b=CWGeURG2DS9e9TL8/pnanECqn+XgLsg6bNS/21sgRBqdoqnR3Tthx7ELgk3mLc5YYc
         HXnpvZZKsgr4jL4j/4ptYJQSfS0rIFd+QoPbX6oxtIdylCnSmylNh+AHOeOvzTvL5Tiw
         ymHJiXeuKRYSV9TNm0P4AwkVNTW7iXvZnM9pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715749717; x=1716354517;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irlyo/ceigW/C5WdJCvCZ0dyBCtZrfqb0gEvCAVTXS0=;
        b=mhIl3HAsn7JZrHREHLxE1JBQFTlwDFVGcdA8i3ZOH10ZmyslKSh4qQLGd28r59O/4H
         6VU3808s3fpD0ZFX5+U175HjZ1/BaBKnP2uqEpm6UpElzNvSj+8umv5w7JgjZcOKoWHe
         bBT3w1nkLd9YB+mU2B9LmPedxjO67O0xAVo2067rpGMvIrIfaHvIlS4OeiJpBPK/h3wV
         Y+omQR6iqb/zNSUZRGmp2HGGHQ3P6q1QGYiKUh+RZlKuIJUuWIuDIw40HcZpAyJYJw75
         GhF4pQvXq6nWJz42Mt8pIaBRDXzjBhbLUyZTtzdl7zsmJdq9OV6Yz3kph1QTfikgUTwM
         VOXg==
X-Forwarded-Encrypted: i=1; AJvYcCWwkB0srkc7vv03UTMgWPfTZgm92zVFRWiNSQHvpQJVHzg18nubdBBCoJC2VnxMlSYOQuehumqpg+tG94FXA4N6MlXVe5YHNSrjMdXw6Q1W
X-Gm-Message-State: AOJu0YyUEmb8ECCqkAYU8haifTaiH3bhPVUHnX0967bdTsMjw+czweVX
	CgFjq6cyDFvOOZ6+A08l4+qahmRTbZStbQssRYYQoa7mr2P7Ji7razZNl//ukA==
X-Google-Smtp-Source: AGHT+IHX41idLVd0Hxl3QghXN1EHQFGZ+fEj5Z3ht/SPDNxOsjIQle1wW6MQePj+sxlrXMRbYyxV/g==
X-Received: by 2002:a17:902:daca:b0:1ec:8607:5f11 with SMTP id d9443c01a7336-1ef43c095e5mr256069275ad.14.1715749717375;
        Tue, 14 May 2024 22:08:37 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2567ccsm107748755ad.301.2024.05.14.22.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 22:08:36 -0700 (PDT)
Message-ID: <452ec12b-b6bc-483e-a766-e5a1a09b8b3a@penguintechs.org>
Date: Tue, 14 May 2024 22:08:34 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: path to landing patch to fix warm boot issue for qca6390
From: Wren Turkal <wt@penguintechs.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Lk Sii <lk_sii@163.com>, linux-bluetooth@vger.kernel.org,
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
 <4104e918-7e8f-4494-93c5-8f606c13d61b@penguintechs.org>
 <CABBYNZJ6-Ht=6p9wkmOqQopv7n769tBhjpxbzDhp=R5ovSDBog@mail.gmail.com>
 <8ad37b23-df40-4d3e-ac7d-6dbaf92249e7@penguintechs.org>
Content-Language: en-US
In-Reply-To: <8ad37b23-df40-4d3e-ac7d-6dbaf92249e7@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Luiz,

On 5/14/24 3:17 PM, Wren Turkal wrote:
> Hey Luiz,
> 
> On 5/13/24 1:46 PM, Luiz Augusto von Dentz wrote:
>> Hi Wren,
>>
>> On Mon, May 13, 2024 at 4:13 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>
>>> On 5/10/24 11:25 PM, Lk Sii wrote:
>>>> On 2024/5/11 07:33, Wren Turkal wrote:
>>>>> On 5/10/24 2:25 PM, Luiz Augusto von Dentz wrote:
>>>>>> Hi Wren,
>>>>>>
>>>>>> On Fri, May 10, 2024 at 4:54 PM Wren Turkal <wt@penguintechs.org> 
>>>>>> wrote:
>>>>>>>
>>>>>>> On 5/10/24 12:48 PM, Luiz Augusto von Dentz wrote:
>>>>>>>> Hi Wren,
>>>>>>>>
>>>>>>>> On Fri, May 10, 2024 at 3:14 PM Wren Turkal <wt@penguintechs.org>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> On 5/6/24 12:49 PM, Luiz Augusto von Dentz wrote:
>>>>>>>>>> Hi Wren,
>>>>>>>>>>
>>>>>>>>>> On Mon, May 6, 2024 at 3:24 PM Wren Turkal <wt@penguintechs.org>
>>>>>>>>>> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Krzysztof,
>>>>>>>>>>>
>>>>>>>>>>> I am reaching out to you as you had the most important 
>>>>>>>>>>> objections
>>>>>>>>>>> to the
>>>>>>>>>>> change to fix qca6390 for the warm boot/module reload bug 
>>>>>>>>>>> that I am
>>>>>>>>>>> experiencing.
>>>>>>>>>>>
>>>>>>>>>>> For context, the problem is that the hci_uart module will send
>>>>>>>>>>> specific
>>>>>>>>>>> vendor specfic commands during shutdown of the hardware under 
>>>>>>>>>>> most
>>>>>>>>>>> situations. These VSCs put the bluetooth device into a
>>>>>>>>>>> non-working state
>>>>>>>>>>> on my Dell XPS 13 9310 with qca6390 bluetooth hardware.
>>>>>>>>>>>
>>>>>>>>>>> Zijun's proposed fix is to not send these commands when it's not
>>>>>>>>>>> appropriate for the hardware. The vendor commands should be
>>>>>>>>>>> avoided when
>>>>>>>>>>> the hardware does not have persistent configuration or when the
>>>>>>>>>>> device
>>>>>>>>>>> is in setup state (indicating that is has never been setup and
>>>>>>>>>>> should
>>>>>>>>>>> not be sent the VSCs on the shutdown path). This is what Zijun's
>>>>>>>>>>> patch
>>>>>>>>>>> implements.
>>>>>>>>>>>
>>>>>>>>>>> In addition, Zijun's change removes the influence of both
>>>>>>>>>>> the QCA_BT_OFF qca flag and and HCI_RUNNING hdev flag. Zijun 
>>>>>>>>>>> asserts
>>>>>>>>>>> that those flags should not influence the sending of the VSCs 
>>>>>>>>>>> in the
>>>>>>>>>>> shutdown path. If I understand KK's objections properly, this is
>>>>>>>>>>> where
>>>>>>>>>>> his objection is stemming from. KK, is this correct?
>>>>>>>>>>>
>>>>>>>>>>> Zijun's proposed fix can be seen here:
>>>>>>>>>>> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19619-3-git-send-email-quic_zijuhu@quicinc.com/
>>>>>>>>>>>
>>>>>>>>>>> I'm wondering if we can resolve this impasse by splitting the 
>>>>>>>>>>> change
>>>>>>>>>>> into two changes, as follows:
>>>>>>>>>>>
>>>>>>>>>>> 1. Change that removes the influence of the QCA_BT_OFF and
>>>>>>>>>>> HCI_RUNNING
>>>>>>>>>>> flags in the shutdown path.
>>>>>>>>>>> 2. Add the quirk from Zijun's patch that fixes my hardward
>>>>>>>>>>> configuration.
>>>>>>>>>>>
>>>>>>>>>>> I'm hoping that better clearer descriptions for #1 can help 
>>>>>>>>>>> get that
>>>>>>>>>>> landed since the logic current appears to be at odds with how 
>>>>>>>>>>> the
>>>>>>>>>>> hardware works.
>>>>>>>>>>>
>>>>>>>>>>> Also, I am happy to split the patches into the two patches, or
>>>>>>>>>>> (maybe
>>>>>>>>>>> more ideally) just modify the commit message to better 
>>>>>>>>>>> indicate the
>>>>>>>>>>> reason the change. I just need guidance from maintainers so that
>>>>>>>>>>> whatever work I do leads to something acceptable for y'all.
>>>>>>>>>>>
>>>>>>>>>>> So, please help me get this done. I am just a user with broken
>>>>>>>>>>> hardware
>>>>>>>>>>> and a fondness for Linux. I would love to help do what's needed
>>>>>>>>>>> to get
>>>>>>>>>>> this fix landed.
>>>>>>>>>>
>>>>>>>>>> Ive also objected to that change, in fact the whole shutdown 
>>>>>>>>>> sequence
>>>>>>>>>> is sort of bogus in my opinion and the driver shall really 
>>>>>>>>>> have some
>>>>>>>>>> means to find out what mode it is in when it reboots, 
>>>>>>>>>> regardless if
>>>>>>>>>> cold or warm boot, since otherwise we are in trouble if the 
>>>>>>>>>> user is
>>>>>>>>>> booting from another OS that doesn't do the expected shutdown
>>>>>>>>>> sequence.
>>>>>>>>>
>>>>>>>>> This criticism makes a ton of sense. I'm sorry I missed it before.
>>>>>>>>> There
>>>>>>>>> were a lot of threads moving in parallel. However, I am 
>>>>>>>>> curious. Given
>>>>>>>>> that the patch improves the situation for users (like me). Is 
>>>>>>>>> there
>>>>>>>>> any
>>>>>>>>> way we can separate the redesign of the shutdown sequence and 
>>>>>>>>> the UX
>>>>>>>>> improvement that comes with this patch?
>>>>>>>>>
>>>>>>>>> Here's my concern. I am happy to do the work to redesign this.
>>>>>>>>> However,
>>>>>>>>> I don't think I have the information needed to do this since I 
>>>>>>>>> don't
>>>>>>>>> have access to the technical docs for the qca6390. I am worried
>>>>>>>>> that not
>>>>>>>>> accepting some form of this patch is letting perfect be the enemy
>>>>>>>>> of the
>>>>>>>>> good. And I am not sure how I personally can help with that. If 
>>>>>>>>> you
>>>>>>>>> think it's possible for me to do this without the docs for the
>>>>>>>>> hardware,
>>>>>>>>> I am willing to give it a shot if I can get some guidance. 
>>>>>>>>> Honestly, I
>>>>>>>>> wish I had the skill to be confident about a change like this, but
>>>>>>>>> I don't.
>>>>>>>>>
>>>>>>>>> Any ideas on how to move forward would be greatly appreciated.
>>>>>>>>>
>>>>>>>>> And just to be perfectly clear, I have tested this patch on my 
>>>>>>>>> laptop.
>>>>>>>>> It greatly enhances my ability to use my hardware since I can
>>>>>>>>> reboot the
>>>>>>>>> machine without having to make sure to power cycle the laptop. 
>>>>>>>>> This is
>>>>>>>>> not a theoretical improvement.
>>>>>>>>
>>>>>>>> I would really love some explanation why can't the driver know 
>>>>>>>> under
>>>>>>>> what mode the controller is when it gets probed, because to me we
>>>>>>>> cannot accept a driver that only works under certain condition 
>>>>>>>> after
>>>>>>>> the boot and in case it is really impossible, can't even power 
>>>>>>>> cycle
>>>>>>>> it to get it back to cold boot stage???
>>>>>>>
>>>>>>> This is a great technical criticism of the driver, and I think you
>>>>>>> deserve that explanation.
>>>>>>>
>>>>>>> However, with the driver already in the kernel, shouldn't the 
>>>>>>> bias be
>>>>>>> toward mitigating the extremely bad UX and not hold users hostage 
>>>>>>> for
>>>>>>> the bad design which has already been approved and landed in the 
>>>>>>> kernel?
>>>>>>>
>>>>>>>> Also the criticism here should be directed to the vendor, how long
>>>>>>>> have we been discussing problems in the QCA driver? And the only 
>>>>>>>> thing
>>>>>>>> I see coming our way are work-arounds of the problems, the 
>>>>>>>> address not
>>>>>>>> being unique coming from the firmware itself and when provided 
>>>>>>>> via DT
>>>>>>>> the address is in the wrong byteorder and now that the driver must
>>>>>>>> communicate the firmware on shutdown in order to get it working
>>>>>>>> properly on the next boot.
>>>>>>>
>>>>>>> I agree that Qualcomm should get flack for this, however, the UX 
>>>>>>> problem
>>>>>>> can be mitigated with a logic fix that doesn't make the 
>>>>>>> init/shutdown
>>>>>>> design problem any worse than it currently seems to be. I mean, 
>>>>>>> wouldn't
>>>>>>> this logic have to exist somewhere even if it weren't the 
>>>>>>> shutdown path?
>>>>>>>
>>>>>>> If you are trying to use this as leverage to get Qualcomm to do a 
>>>>>>> bigger
>>>>>>> thing (redesign the init/shutdown logic), I do think that tactic
>>>>>>> needlessly puts users in the crossfire. I can totally understand why
>>>>>>> you'd do it. I am just suffering the crossfire in the meantime, 
>>>>>>> and it
>>>>>>> doesn't feel great.
>>>>>>
>>>>>> So you prefer to risk getting a kernel crash due to UAF over 
>>>>>> Bluetooth
>>>>>> not working? Really? Because I haven't seen any configuration that
>>>>>> those changes you tested don't reintroduce the UAF, which is why I
>>>>>> haven't applied that change to begin with, so no I'm not holding back
>>>>>> to pressure Qualcomm to redesign the shutdown logic, it just these
>>>>>> things got entangled because I just realized the shutdown thingy is
>>>>>> really out of place, imo, but I'd be fine if there is a temporary fix
>>>>>> until someone finally decide to spend some time to really fix the
>>>>>> shutdown logic.
>>>>>
>>>>> Luiz, I'm sorry. I do not want a crash instead. I didn't understand 
>>>>> that
>>>>> the solution I proposed (i.e. adding Zijun's logic without removing 
>>>>> KK's
>>>>> logic) would introduce a new crash opportunity. I previously 
>>>>> thought you
>>>>> were saying one of the following things:
>>>>> 1. The crash opportunity already existed due the init/shudown 
>>>>> sequences.
>>>>> 2. The crash opportunity already existed due the init/shudown 
>>>>> sequences
>>>>> when removing KK's logic.
>>>>>
>>>>> If it was #1, I was hoping that adding the logic would make the 
>>>>> risk no
>>>>> worse.
>>>>>
>>>>> If it was #2, I was hoping that my suggestion of adding Zijun's logic
>>>>> without removing KK's logic might represent an acceptable middleground
>>>>> for a temporary fix that would "correct" the logic without 
>>>>> introducing a
>>>>> new crash opportunity.
>>>>>
>>>>> I feel like I may not be clear about what I mean by adding Zijun's 
>>>>> logic
>>>>> and not removing KK's logic. Maybe something like this diff:
>>>>>
>>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>>>> index 2f7ae38d85eb..fcac44ae7898 100644
>>>>> --- a/drivers/bluetooth/hci_qca.c
>>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>>> @@ -2456,6 +2456,10 @@ static void qca_serdev_shutdown(struct 
>>>>> device *dev)
>>>>>                        !test_bit(HCI_RUNNING, &hdev->flags))
>>>>>                            return;
>>>>>
>>>>> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP,
>>>>> &hdev->quirks) ||
>>>>> +                   hci_dev_test_flag(hdev, HCI_SETUP))
>>>>> +                       return;
>>>>> +
>>>>>                    serdev_device_write_flush(serdev);
>>>>>                    ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
>>>>>                                                  
>>>>> sizeof(ibs_wake_cmd));
>>>>>
>>>>> I think this diff is mangled due to using Thunderbird, but I hope this
>>>>> helps convey what I was asking about.
>>>>>
>>>>> If I am understanding you correctly now, you are saying that simply
>>>>> introducing Zijun's logic (without removing KK's logic) will 
>>>>> introduce a
>>>>> new crash opportunity. Is that correct?
>>>>>
>>>>
>>>> as Zijun declared. i believe Zijun's change will solve both this
>>>> reported regression issue and the use-after-free(crash) issue.
>>>
>>> I did see Zijun's claim of that. However, I think that both KK and Luiz
>>> are not convinced by the explanation. Also, if that explanation does
>>> convince KK and Luiz, I think that the explanation needs to be added to
>>> the commit message.
>>>
>>> I'm hoping that Luiz will at least respond to the middleground I
>>> proposed as a workaround.
>>
>> I recall suggesting using HCI_UART_PROTO_READY instead since that
>> tells when serdev_device_close has been run:
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 0c9c9ee56592..bbbc86d4932a 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2455,8 +2455,8 @@ static void qca_serdev_shutdown(struct device *dev)
>>          const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
>>
>>          if (qcadev->btsoc_type == QCA_QCA6390) {
>> -               if (test_bit(QCA_BT_OFF, &qca->flags) ||
>> -                   !test_bit(HCI_RUNNING, &hdev->flags))
>> +               /* Check if serdev_device_close() has already been 
>> called. */
>> +               if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
>>                          return;
>>
>>                  serdev_device_write_flush(serdev);
> 
> I am testing this right now. I will let you know how it goes.

I applied your patch and tested a number of scenarios. Here are the 
results. Apologies for any bad line wraps. I guess I haven't managed to 
tame Thunderbird yet:

warm boot:
   unpatched kernel to patched kernel : doesn't work
   patched kernel to patched kernel   : works

patched kernel tests:
   starting from cold boot:
     works
   disable/re-enable bt by plasma UI:
     works
   restart bluetooth service:
     works
   unload/re-load hci_uart and bluetooth service:
     doesn't work after reload; can't enable BT
     I think this worked with Zijun's commit, but I'm not 100% sure.
   disable bluetooth service, warm boot, start bluetooth service:
     fails to connect to devices

What follows are logs for the non-working cases that only involve the 
patched kernel:

logs for unload/re-load hci_uart and bluetooth service test when 
reloading the module:
May 14 21:42:34 braindead.localdomain kernel: Bluetooth: HCI UART driver 
ver 2.3
May 14 21:42:34 braindead.localdomain kernel: Bluetooth: HCI UART 
protocol H4 registered
May 14 21:42:34 braindead.localdomain kernel: Bluetooth: HCI UART 
protocol QCA registered
May 14 21:42:34 braindead.localdomain kernel: Bluetooth: hci0: setting 
up ROME/QCA6390
May 14 21:42:34 braindead.localdomain kernel: Bluetooth: hci0: QCA 
Product ID   :0x00000010
May 14 21:42:34 braindead.localdomain kernel: Bluetooth: hci0: QCA SOC 
Version  :0x400a0200
May 14 21:42:34 braindead.localdomain kernel: Bluetooth: hci0: QCA ROM 
Version  :0x00000200
May 14 21:42:34 braindead.localdomain kernel: Bluetooth: hci0: QCA Patch 
Version:0x00003ac0
May 14 21:42:34 braindead.localdomain kernel: Bluetooth: hci0: QCA 
controller version 0x02000200
May 14 21:42:34 braindead.localdomain kernel: Bluetooth: hci0: QCA 
Downloading qca/htbtfw20.tlv
May 14 21:42:34 braindead.localdomain kernel: Bluetooth: hci0: QCA 
Failed to send TLV segment (-110)
May 14 21:42:34 braindead.localdomain kernel: Bluetooth: hci0: QCA 
Failed to download patch (-110)
May 14 21:42:34 braindead.localdomain kernel: Bluetooth: hci0: Retry BT 
power ON:0
May 14 21:42:37 braindead.localdomain kernel: Bluetooth: hci0: command 
0xfc00 tx timeout
May 14 21:42:37 braindead.localdomain kernel: Bluetooth: hci0: Reading 
QCA version information failed (-110)
May 14 21:42:37 braindead.localdomain kernel: Bluetooth: hci0: Retry BT 
power ON:1
May 14 21:42:39 braindead.localdomain kernel: Bluetooth: hci0: command 
0xfc00 tx timeout
May 14 21:42:39 braindead.localdomain kernel: Bluetooth: hci0: Reading 
QCA version information failed (-110)
May 14 21:42:39 braindead.localdomain kernel: Bluetooth: hci0: Retry BT 
power ON:2
May 14 21:42:41 braindead.localdomain kernel: Bluetooth: hci0: command 
0xfc00 tx timeout
May 14 21:42:41 braindead.localdomain kernel: Bluetooth: hci0: Reading 
QCA version information failed (-110)


logs for disable bluetooth service, warm boot, start bluetooth service 
manually test starting at the point of starting bluetooth service:
May 14 21:45:53 braindead.localdomain kernel: Bluetooth: hci0: 
hci_devcd_init Return:-95
May 14 21:46:59 braindead.localdomain kernel: Bluetooth: BNEP (Ethernet 
Emulation) ver 1.3
May 14 21:46:59 braindead.localdomain kernel: Bluetooth: BNEP filters: 
protocol multicast
May 14 21:46:59 braindead.localdomain kernel: Bluetooth: BNEP socket 
layer initialized
May 14 21:46:59 braindead.localdomain kernel: Bluetooth: MGMT ver 1.22
May 14 21:46:59 braindead.localdomain kernel: Bluetooth: RFCOMM TTY 
layer initialized
May 14 21:46:59 braindead.localdomain kernel: Bluetooth: RFCOMM socket 
layer initialized
May 14 21:46:59 braindead.localdomain kernel: Bluetooth: RFCOMM ver 1.11
May 14 21:47:01 braindead.localdomain kernel: Bluetooth: hci0: Opcode 
0x0c03 failed: -110
May 14 21:47:01 braindead.localdomain kernel: Bluetooth: hci0: 
mem_dump_status: 2
May 14 21:47:03 braindead.localdomain kernel: Bluetooth: hci0: Opcode 
0x0c03 failed: -110
May 14 21:47:13 braindead.localdomain kernel: Bluetooth: hci0: Opcode 
0x0c03 failed: -110

So, I noticed that your patch doesn't include the quirk conditional from 
Zijun's commit. I am assuming that that was intentional. However, I 
wanted to point it out in case that was somehow material to the results.

Please let me know what else I can do to help. And again, I really 
appreciate your effort on this.

wt
-- 
You're more amazing than you think!
