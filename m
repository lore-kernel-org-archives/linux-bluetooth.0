Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34FA635
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715381914; cv=none; b=HpAsTkIbrGAFPg5YTVUnmj31+zUggrmksRm9xqeAqUIttRjL7nsCdIpgSo7URSWbQiL5+xrqGmt50bHS4/jSdvh6wBWzkjtW3DOZ7Yyq5iIxIXP9Z0orojcOSlEuSe5FGKzbTvTOCnTMq/S7LY3VmM+QwucIt/C1q9bQ5glaC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715381914; c=relaxed/simple;
	bh=/8etuUcI7knW62d55PGqeGzz6BiztlxwKKleursxrRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQkTxu3jvCyjU7WsvSWOLYAO63wGKRJO9a4QaYwiU2ZKUiTflKs07pNhDrjxX4bPsAzXusq3ac+nBDZKJZuLJSgKP58cnLS+zphNwSRe86A+dld8pCZrZKxCp3UM4TD6QX/NveMeXI3g7T+udnr0UoKjdRHz/64OWwo36jwv+F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.1.184] (91-206-144-85.ftth.glasoperator.nl [85.144.206.91])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D174861E5FE01;
	Sat, 11 May 2024 00:57:48 +0200 (CEST)
Message-ID: <089e57db-e2c5-4e42-b52e-c9e052c69efa@molgen.mpg.de>
Date: Sat, 11 May 2024 00:57:44 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: path to landing patch to fix warm boot issue for qca6390
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Wren Turkal <wt@penguintechs.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 regressions@lists.linux.dev
References: <3475f0dd-6a0f-4319-9590-379eee33f504@penguintechs.org>
 <CABBYNZ+FBwFtrqg1Hj72Q7_6f8hDSwVTNtkofP0XgEd98DRf9A@mail.gmail.com>
 <560c5c03-563a-4f1c-abc1-1372ca73c421@penguintechs.org>
 <CABBYNZK+FGe75VJ4YqsxxyGj-Ac+voeMb3CR9qRD+yz7d=d7oQ@mail.gmail.com>
 <44b75302-1349-445d-90ac-8df8a1fb91e2@penguintechs.org>
 <CABBYNZ+KTV7y-UxWE_6jaHT0wDiMN-xReHW8zLT0WEPHCsyXQQ@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CABBYNZ+KTV7y-UxWE_6jaHT0wDiMN-xReHW8zLT0WEPHCsyXQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Luiz,


Am 10.05.24 um 23:25 schrieb Luiz Augusto von Dentz:

> On Fri, May 10, 2024 at 4:54 PM Wren Turkal <wt@penguintechs.org> wrote:
>>
>> On 5/10/24 12:48 PM, Luiz Augusto von Dentz wrote:

>>> On Fri, May 10, 2024 at 3:14 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>>
>>>> On 5/6/24 12:49 PM, Luiz Augusto von Dentz wrote:

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

The no-regression policy is clear to not cause regressions for users. 
Even if we had crash reports from before, fixing one bug and causing 
another is unwanted to my understanding.


Kind regards,

Paul
