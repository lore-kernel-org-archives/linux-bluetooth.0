Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2854E50255
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 06:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715408850; cv=none; b=O02adMd377hUaZa8gijqgjKbkT6+zvfbEmcyct4cAOSXyYVURQw+WEeaE4kOZ9XGt82raLckqIPzFIW1tlqbP2o7gL8Tg4ovz8lcec1hZIwGf0LWqIe/yp65TiKUB2hJ3x7N2NNN2uqsEt9ILSxBdactRcXCeML1f+aa/2Pm/Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715408850; c=relaxed/simple;
	bh=Rp6BEYe1kFo2Fj9NIt3FZ2pRR0ZZbxBqxkrdRTYfsOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4+Z2AlbHsnPH7lQo4d74WhzaFq3z6iIGjhfUCQhP7FB9Z4FlmxbrOngFfsGeRuJ+5oBgJtR9Eadcbzotrhd8gzF9uXOQnHXtoL0ncYc5rLDhtUmmc4aFy0LUqgNQdFVdoYr6vo6oJXQveTPuDEmhtQK4lZTXnGS5oURI0jQTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=c9f2qbRJ; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c9f2qbRJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=i0g0jCk3xehJRPHIxMh3RKhW3BAvjOrD0NFBpK9mfE8=;
	b=c9f2qbRJSMommHCQ4khGhh4g5AVomAwCNNPCd/akQqsW53LD/Lrzy6Bm5NKnA0
	YFfVHuZnI7CdbPQIsRP640RM8pHt5HTn6ZOTdUMgTyqAcmrm7ktcWhCc9869WYY6
	ALG9Bwuc+Jx04zZ+DLE7ZNakZnln94p6Y2H/+XnKahOAo=
Received: from [192.168.1.14] (unknown [183.195.4.13])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wDn7853Dz9mofhnEA--.38629S2;
	Sat, 11 May 2024 14:26:00 +0800 (CST)
Message-ID: <8de52d0c-ed3f-47b3-a318-b1942c193978@163.com>
Date: Sat, 11 May 2024 14:25:59 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: path to landing patch to fix warm boot issue for qca6390
To: Wren Turkal <wt@penguintechs.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
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
Content-Language: en-US
From: Lk Sii <lk_sii@163.com>
In-Reply-To: <9cf1f313-c236-43d0-bd98-299478630869@penguintechs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7853Dz9mofhnEA--.38629S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr1UAr18uF4DKr4UurWUXFb_yoWfZryrpF
	W5GFWYyrsrJry2yrnFyw48Xa4jyw1fJrWUWFn8JryUArn0vF13tr47try5CFyDWrs3Gw4j
	qrW5Jr9rW3WDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jvg4fUUUUU=
X-CM-SenderInfo: 5onb2xrl6rljoofrz/1tbiExLbNWXAlF3t3AABsz



On 2024/5/11 07:33, Wren Turkal wrote:
> On 5/10/24 2:25 PM, Luiz Augusto von Dentz wrote:
>> Hi Wren,
>>
>> On Fri, May 10, 2024 at 4:54 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>
>>> On 5/10/24 12:48 PM, Luiz Augusto von Dentz wrote:
>>>> Hi Wren,
>>>>
>>>> On Fri, May 10, 2024 at 3:14 PM Wren Turkal <wt@penguintechs.org>
>>>> wrote:
>>>>>
>>>>> On 5/6/24 12:49 PM, Luiz Augusto von Dentz wrote:
>>>>>> Hi Wren,
>>>>>>
>>>>>> On Mon, May 6, 2024 at 3:24 PM Wren Turkal <wt@penguintechs.org>
>>>>>> wrote:
>>>>>>>
>>>>>>> Krzysztof,
>>>>>>>
>>>>>>> I am reaching out to you as you had the most important objections
>>>>>>> to the
>>>>>>> change to fix qca6390 for the warm boot/module reload bug that I am
>>>>>>> experiencing.
>>>>>>>
>>>>>>> For context, the problem is that the hci_uart module will send
>>>>>>> specific
>>>>>>> vendor specfic commands during shutdown of the hardware under most
>>>>>>> situations. These VSCs put the bluetooth device into a
>>>>>>> non-working state
>>>>>>> on my Dell XPS 13 9310 with qca6390 bluetooth hardware.
>>>>>>>
>>>>>>> Zijun's proposed fix is to not send these commands when it's not
>>>>>>> appropriate for the hardware. The vendor commands should be
>>>>>>> avoided when
>>>>>>> the hardware does not have persistent configuration or when the
>>>>>>> device
>>>>>>> is in setup state (indicating that is has never been setup and
>>>>>>> should
>>>>>>> not be sent the VSCs on the shutdown path). This is what Zijun's
>>>>>>> patch
>>>>>>> implements.
>>>>>>>
>>>>>>> In addition, Zijun's change removes the influence of both
>>>>>>> the QCA_BT_OFF qca flag and and HCI_RUNNING hdev flag. Zijun asserts
>>>>>>> that those flags should not influence the sending of the VSCs in the
>>>>>>> shutdown path. If I understand KK's objections properly, this is
>>>>>>> where
>>>>>>> his objection is stemming from. KK, is this correct?
>>>>>>>
>>>>>>> Zijun's proposed fix can be seen here:
>>>>>>> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19619-3-git-send-email-quic_zijuhu@quicinc.com/
>>>>>>>
>>>>>>> I'm wondering if we can resolve this impasse by splitting the change
>>>>>>> into two changes, as follows:
>>>>>>>
>>>>>>> 1. Change that removes the influence of the QCA_BT_OFF and
>>>>>>> HCI_RUNNING
>>>>>>> flags in the shutdown path.
>>>>>>> 2. Add the quirk from Zijun's patch that fixes my hardward
>>>>>>> configuration.
>>>>>>>
>>>>>>> I'm hoping that better clearer descriptions for #1 can help get that
>>>>>>> landed since the logic current appears to be at odds with how the
>>>>>>> hardware works.
>>>>>>>
>>>>>>> Also, I am happy to split the patches into the two patches, or
>>>>>>> (maybe
>>>>>>> more ideally) just modify the commit message to better indicate the
>>>>>>> reason the change. I just need guidance from maintainers so that
>>>>>>> whatever work I do leads to something acceptable for y'all.
>>>>>>>
>>>>>>> So, please help me get this done. I am just a user with broken
>>>>>>> hardware
>>>>>>> and a fondness for Linux. I would love to help do what's needed
>>>>>>> to get
>>>>>>> this fix landed.
>>>>>>
>>>>>> Ive also objected to that change, in fact the whole shutdown sequence
>>>>>> is sort of bogus in my opinion and the driver shall really have some
>>>>>> means to find out what mode it is in when it reboots, regardless if
>>>>>> cold or warm boot, since otherwise we are in trouble if the user is
>>>>>> booting from another OS that doesn't do the expected shutdown
>>>>>> sequence.
>>>>>
>>>>> This criticism makes a ton of sense. I'm sorry I missed it before.
>>>>> There
>>>>> were a lot of threads moving in parallel. However, I am curious. Given
>>>>> that the patch improves the situation for users (like me). Is there
>>>>> any
>>>>> way we can separate the redesign of the shutdown sequence and the UX
>>>>> improvement that comes with this patch?
>>>>>
>>>>> Here's my concern. I am happy to do the work to redesign this.
>>>>> However,
>>>>> I don't think I have the information needed to do this since I don't
>>>>> have access to the technical docs for the qca6390. I am worried
>>>>> that not
>>>>> accepting some form of this patch is letting perfect be the enemy
>>>>> of the
>>>>> good. And I am not sure how I personally can help with that. If you
>>>>> think it's possible for me to do this without the docs for the
>>>>> hardware,
>>>>> I am willing to give it a shot if I can get some guidance. Honestly, I
>>>>> wish I had the skill to be confident about a change like this, but
>>>>> I don't.
>>>>>
>>>>> Any ideas on how to move forward would be greatly appreciated.
>>>>>
>>>>> And just to be perfectly clear, I have tested this patch on my laptop.
>>>>> It greatly enhances my ability to use my hardware since I can
>>>>> reboot the
>>>>> machine without having to make sure to power cycle the laptop. This is
>>>>> not a theoretical improvement.
>>>>
>>>> I would really love some explanation why can't the driver know under
>>>> what mode the controller is when it gets probed, because to me we
>>>> cannot accept a driver that only works under certain condition after
>>>> the boot and in case it is really impossible, can't even power cycle
>>>> it to get it back to cold boot stage???
>>>
>>> This is a great technical criticism of the driver, and I think you
>>> deserve that explanation.
>>>
>>> However, with the driver already in the kernel, shouldn't the bias be
>>> toward mitigating the extremely bad UX and not hold users hostage for
>>> the bad design which has already been approved and landed in the kernel?
>>>
>>>> Also the criticism here should be directed to the vendor, how long
>>>> have we been discussing problems in the QCA driver? And the only thing
>>>> I see coming our way are work-arounds of the problems, the address not
>>>> being unique coming from the firmware itself and when provided via DT
>>>> the address is in the wrong byteorder and now that the driver must
>>>> communicate the firmware on shutdown in order to get it working
>>>> properly on the next boot.
>>>
>>> I agree that Qualcomm should get flack for this, however, the UX problem
>>> can be mitigated with a logic fix that doesn't make the init/shutdown
>>> design problem any worse than it currently seems to be. I mean, wouldn't
>>> this logic have to exist somewhere even if it weren't the shutdown path?
>>>
>>> If you are trying to use this as leverage to get Qualcomm to do a bigger
>>> thing (redesign the init/shutdown logic), I do think that tactic
>>> needlessly puts users in the crossfire. I can totally understand why
>>> you'd do it. I am just suffering the crossfire in the meantime, and it
>>> doesn't feel great.
>>
>> So you prefer to risk getting a kernel crash due to UAF over Bluetooth
>> not working? Really? Because I haven't seen any configuration that
>> those changes you tested don't reintroduce the UAF, which is why I
>> haven't applied that change to begin with, so no I'm not holding back
>> to pressure Qualcomm to redesign the shutdown logic, it just these
>> things got entangled because I just realized the shutdown thingy is
>> really out of place, imo, but I'd be fine if there is a temporary fix
>> until someone finally decide to spend some time to really fix the
>> shutdown logic.
> 
> Luiz, I'm sorry. I do not want a crash instead. I didn't understand that
> the solution I proposed (i.e. adding Zijun's logic without removing KK's
> logic) would introduce a new crash opportunity. I previously thought you
> were saying one of the following things:
> 1. The crash opportunity already existed due the init/shudown sequences.
> 2. The crash opportunity already existed due the init/shudown sequences
> when removing KK's logic.
> 
> If it was #1, I was hoping that adding the logic would make the risk no
> worse.
> 
> If it was #2, I was hoping that my suggestion of adding Zijun's logic
> without removing KK's logic might represent an acceptable middleground
> for a temporary fix that would "correct" the logic without introducing a
> new crash opportunity.
> 
> I feel like I may not be clear about what I mean by adding Zijun's logic
> and not removing KK's logic. Maybe something like this diff:
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 2f7ae38d85eb..fcac44ae7898 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2456,6 +2456,10 @@ static void qca_serdev_shutdown(struct device *dev)
>                      !test_bit(HCI_RUNNING, &hdev->flags))
>                          return;
> 
> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP,
> &hdev->quirks) ||
> +                   hci_dev_test_flag(hdev, HCI_SETUP))
> +                       return;
> +
>                  serdev_device_write_flush(serdev);
>                  ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
>                                                sizeof(ibs_wake_cmd));
> 
> I think this diff is mangled due to using Thunderbird, but I hope this
> helps convey what I was asking about.
> 
> If I am understanding you correctly now, you are saying that simply
> introducing Zijun's logic (without removing KK's logic) will introduce a
> new crash opportunity. Is that correct?
> 

as Zijun declared. i believe Zijun's change will solve both this
reported regression issue and the use-after-free(crash) issue.

> Thanks,
> wt

