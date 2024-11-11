Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970B9146A6B;
	Mon, 11 Nov 2024 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316912; cv=none; b=k9rnc1geVKmqToNgeXV4kC3bPiBy222ICOMuK6JpVZNMGzy3+YgMs83a/OsfVk99UEFahyG+m+bF4WT61MzrHDvoXnILO2bnBzQxrcSnPIaP3xIH7K4G1qVO9DfQtmtge1C1tKXj93qRSsLSUNPPcir+hPHg/UIzF0EPU0ZfAro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316912; c=relaxed/simple;
	bh=PlxCJVj6PTtrdq/SJmlCME2Ll1MEtVi7ALvlNjXOsZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OK0JSXQPYoOa2RPNwea5OI3xNzWi+wReob0oZeURbLnrVjwjPmS2PcLZ8tTsc53NPJ+zsi8fIL2m5Zn6C5MFn3xk6BMDvdCsJfaNzFq5E+xPnBLEUQer2vsq31rVobVXeNl1sjS8IVwc9r1+UCncqDG+1IlXF43sC+70mSfUAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=b6ZZidlY; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="b6ZZidlY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=G1NHMjoXKjtbg5sRxyu6N/9CkX3GVAUgbgcVP3E+wC4=;
	t=1731316909; x=1731748909; b=b6ZZidlY8LOdMIm15Z+V1sEfwvpEy/SRFuORw8HW11YooVU
	Pp6Ss29UmN9Kps607+n1vgUsOv2UKOzGJsC87NhLJEFTEcI1ZWCkhLOD/jqVEdgW2BvubTCIHAuFY
	DGwbZpaJsWqsNcZ8LVETZcXQicLDlspBYTOfXfyCBaNPAFPZv7R86GTkN+fG2b/0kUNLcpXlA4NWU
	wNGwEZJOQT7rWSO3wm6MrZpowZbNZLbjEFOk0vDPMlOhIOTyekQFtMevUPiXs7iaTvTC2blZnCIch
	ULrps8ZzIKRRUqGYrWMfpoFmZQVFMr6IawrognPNaMSnJUbrI2wRRplkH4UejNNQ==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1tAQc6-0007Mx-TH; Mon, 11 Nov 2024 10:21:38 +0100
Message-ID: <746e7fa8-41ba-483f-a674-2121fa0ea2d8@leemhuis.info>
Date: Mon, 11 Nov 2024 10:21:38 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before
 downloading the fw
To: Takashi Iwai <tiwai@suse.de>
Cc: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
 "marcel@holtmann.org" <marcel@holtmann.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 =?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
 =?UTF-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
 "marc.payne@mdpsys.co.uk" <marc.payne@mdpsys.co.uk>,
 Sean Wang <Sean.Wang@mediatek.com>, =?UTF-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?=
 <Aaron.Hou@mediatek.com>, =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?=
 <Chris.Lu@mediatek.com>, =?UTF-8?B?SGFvIFFpbiAo56em5rWpKQ==?=
 <Hao.Qin@mediatek.com>
References: <20240822052310.25220-1-hao.qin@mediatek.com>
 <ZuB3omUkdUHLggYu@mdpsys.co.uk>
 <790e542aa9d08c7efeee6ef298fce2a87d8035e4.camel@mediatek.com>
 <ZuneSM4SvyUFX86j@mdpsys.co.uk>
 <9bfbbf24ac2480d94d3455f7e33e4b5502b38ced.camel@mediatek.com>
 <CABBYNZKYsL9jcF2n9TsA1BjU-CjXOdXu7MDLP9Sz_Ly8hBAf1w@mail.gmail.com>
 <c01e6dfa730dd10a7d4dba60fe31e82b9c296b37.camel@mediatek.com>
 <Zuyk1c6Gkxx3G0PB@mdpsys.co.uk>
 <f9e8688ebe559e10c019d0cbab4e8b1f5a7d2339.camel@mediatek.com>
 <ff502f63-2d87-4dee-a893-cce53353df8b@leemhuis.info>
 <87iktk4d9l.wl-tiwai@suse.de>
 <75f671b6-ce2a-4404-b662-2c9c7d28a598@leemhuis.info>
 <d0f70e662f5e9329cff43f92a5c191601cc599f1.camel@mediatek.com>
 <0a988691-8c18-4dca-ac78-94e36a9b8b37@leemhuis.info>
 <f3c6f6f857d19c867941c86c644042fa195621ac.camel@mediatek.com>
 <643d8055-5a9f-4f5b-865b-830d33651dfe@leemhuis.info>
 <87ttcqt0hx.wl-tiwai@suse.de>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-MW
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <87ttcqt0hx.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1731316909;e73cfbee;
X-HE-SMSGID: 1tAQc6-0007Mx-TH

On 02.11.24 11:04, Takashi Iwai wrote:
> On Fri, 01 Nov 2024 15:22:13 +0100,
> Thorsten Leemhuis wrote:
>>
>> Thx for the insights, but it feels like this is not the complete story.
>> From Takashi's mail earlier in the thread it appears to me that there is
>> a regression that the patch at the start of the thread fixes:
>> https://lore.kernel.org/all/87iktk4d9l.wl-tiwai@suse.de/
>>
>> So it appears to me (please correct me if I'm wrong, which I might be)
>> there is some regression that must be fixed independently of any
>> firmware changes; not sure, maybe it's a different regression that the
>> one Marc saw.
> 
> That's hard to judge, unfortunately.  The only fact is that 6.11 and
> 6.12-rc are still buggy and fail to boot due to the kernel Oops from
> Mediatek BT stuff.  The patch
>   https://lore.kernel.org/all/20240822052310.25220-1-hao.qin@mediatek.com/
> seems working around it, but it doesn't mean that this is the right
> fix, either.
> 
> My wild guess is that there are substantial problems at btmtk stuff
> about the firmware management.  It blocks unbinding if something goes
> wrong, and this bug surfaced casually due to another change.
> 
>> I just don't know what's the best way forward to resolve the regresson.
>> A revert of the culprit? The patch at the start of this thread?
>> Something else?
> 
> Either a revert of the firmware or the patch that triggered the issue
> would be helpful as a temporary workaround, yes.  We need a quick
> duct-tape coverage, then fix the fundamental failure.

I agree, but seems everybody else sees it differently or does not care
enough to do anything about it.

Or is some firmware update that fixes things within reach by now?
Assuming here that the firmware is the only problem here (not sure at
all if that is the case), as users never should be expected to update
the firmware to fix a regression caused by a kernel change.

>> Takashi, Luiz, can you help me out here? I guess I otherwise soon will
>> have to involve higher level maintainers to sort this out (e.g. the -net
>> maintainers and/or Linus).
> I can build a test kernel and ask the reporter for testing if once
> something is provided, of course.  Just ping me.

Hmmm. Given the above I wonder if it would be good if you could make the
reporter test a kernel with the revert and see if that helps -- and if
it does then consider submitting that (with Linus and the -net
maintainers in CC) to see if that gets anybody into action.

Ciao, Thorsten

>> On 01.11.24 08:11, Chris Lu (陸稚泓) wrote:
>>> Hi Thorsten,
>>>
>>> On Wed, 2024-10-30 at 12:29 +0100, Thorsten Leemhuis wrote:
>>>> External email : Please do not click links or open attachments until
>>>> you have verified the sender or the content.
>>>>
>>>>
>>>> On 30.10.24 12:03, Chris Lu (陸稚泓) wrote:
>>>>>
>>>>> Let me recap and update the status of this problem.
>>>>
>>>> Many thx!
>>>>
>>>>> Marc feedback that he has some problem with MT7921AUN usb module.
>>>>> Originally, we thought it was caused by the change "Fixes:
>>>>> ccfc8948d7e4d9 ("Bluetooth: btusb: mediatek: reset the controller
>>>>> before downloading the fw")". The change is mainly for MT7922, we
>>>>> found some problem with MT7921 on specific platform internally. As
>>>>> a result, Hao sent another patch to remove MT7921 from that
>>>>> rule(Bluetooth: btmtk: Remove resetting mt7921 before downloading
>>>>> the fw).
>>>>>
>>>>> However, Marc also mentioned that BT is able to work if changing
>>>>> back
>>>>> to an old firmware bin. Based on the clue, we found it was caused
>>>>> by a
>>>>> firmware change that specific MT7921 model will not able to setup
>>>>> successfully. (In fact, we didn't expect that MT7921AUN can be get
>>>>> by
>>>>> normal user.)
>>>>>
>>>>> Since we can't predict which model user use and Luiz also suggests
>>>>> MediaTek to fix it if that model can work before, we have prepared
>>>>> a
>>>>> solution. I've verified the solution locally that MT7921AUN model
>>>>> can
>>>>> work normally on Ubuntu PC. It will be a firmware modification. We
>>>>> plan
>>>>> to submit new firmware with this modification in 2024 Nov.
>>>>
>>>> Great, but due to the kernel's "no regressions" rule this is mostly
>>>> irrelevant, as the regression must be fixed in a way that does not
>>>> require users to change their firmware.
>>>>
>>>
>>> Marc's module(MT7921AUN) is not working is due to a change in specific
>>> firmware uploaded last year and we plan to revert that in the next
>>> firmware release. Since it's related to controller's behavior, it's
>>> quite hard to cover in software side.
>>> Additionally, MT7921AUN is an external usb dongle. MediaTek official PC
>>> project doesn't use this type of MT7921 model. We uses another type for
>>> PC projects that it can be guaranteed bluetooth works normally with any
>>> firmware we upload to Kernel. As a result, we believe the impact is
>>> minimal to general user.
>>>
>>>> So is any such solution in sight? Or should we just revert
>>>> ccfc8948d7e4d9 and any related follow up patches for now? Or would
>>>> that
>>>> just cause regressions for other users?
>>>>
>>>
>>> Actually, it's not related to ccfc8948d7e4d9 which make bluetooth can't
>>> setup normally if using MT7921AUN model + mismatched firmware. We
>>> thought it was the same issue in the beginning, but it's not eventually
>>> after getting more and more clue/logs.
>>> I think we can keep the change because it's necessary to the change
>>> submitter-Hao's project.
>>>
>>> Chris Lu
>>>
>>>> Ciao, Thorsten
>>>>
>>>>> On Wed, 2024-10-30 at 10:21 +0100, Thorsten Leemhuis wrote:
>>>>>> External email : Please do not click links or open attachments
>>>>>> until
>>>>>> you have verified the sender or the content.
>>>>>>
>>>>>>
>>>>>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-
>>>>>> posting
>>>>>> for once, to make this easily accessible to everyone.
>>>>>>
>>>>>> I'm a bit lost here, but maybe I'm missing something.
>>>>>>
>>>>>> Luiz, can you help out here? Is there a reason why this patch is
>>>>>> not
>>>>>> making any process?
>>>>>>
>>>>>> Chris Lu and/or Hao Qin: Can you maybe help out as well as well
>>>>>> and
>>>>>> help
>>>>>> with resolving some open questions that might or might not be
>>>>>> relevant
>>>>>> (see below).
>>>>>>
>>>>>> From Takashi reply, the bugzilla ticket he linked to, and the
>>>>>> mail
>>>>>> from
>>>>>> the MediaTek folks
>>>>>> (
>>>>>>
>>> https://lore.kernel.org/lkml/12a344e25b31ec00fe8b57814d43fcb166e71be5.camel@mediatek.com/
>>>>>> ) it from the outside looks like this patch should really be
>>>>>> merged
>>>>>> rather sooner that later as it fixes regressions for some people.
>>>>>> Afaics it should get a "Fixes: ccfc8948d7e4d9 ("Bluetooth: btusb:
>>>>>> mediatek: reset the controller before downloading the fw")" tag,
>>>>>> as
>>>>>> it's
>>>>>> afaics that commit that causes the regression that is known since
>>>>>> more
>>>>>> than three months now
>>>>>> (https://lore.kernel.org/all/ZsTh7Jyug7MbZsLE@mdpsys.co.uk/ ).
>>>>>>
>>>>>> But note, it seems it does not fix the regression completely
>>>>>> according
>>>>>> to Marc's testing.
>>>>>> https://lore.kernel.org/all/ZuCB98DSdtKCgxaL@mdpsys.co.uk/
>>>>>>
>>>>>> Marc: Is that still how things are with current mainline?
>>>>>>
>>>>>> Ciao, Thorsten
>>>>>>
>>>>>>
>>>>>> On 22.10.24 12:56, Takashi Iwai wrote:
>>>>>>> On Mon, 14 Oct 2024 11:29:40 +0200,
>>>>>>> Linux regression tracking (Thorsten Leemhuis) wrote:
>>>>>>>>
>>>>>>>> On 20.09.24 08:27, Chris Lu (陸稚泓) wrote:
>>>>>>>>> On Thu, 2024-09-19 at 23:25 +0100, marc.payne@mdpsys.co.uk
>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> External email : Please do not click links or open
>>>>>>>>>> attachments until
>>>>>>>>>> you have verified the sender or the content.
>>>>>>>>>>  Hi Chris and Luiz,
>>>>>>>>>>
>>>>>>>>>> What were your thoughts on the findings in my email dated
>>>>>>>>>> 18th
>>>>>>>>>> September?
>>>>>>>>>
>>>>>>>>> Thanks for your suggestion.
>>>>>>>>>
>>>>>>>>> I've prepared the same environment (Kernel v6.11 +
>>>>>>>>> MT7921AUN
>>>>>>>>> dongle) to
>>>>>>>>> reproduce the issue, collected necessary logs locally and
>>>>>>>>> also
>>>>>>>>> initiated an internal discussion to clarify the root cause
>>>>>>>>> of
>>>>>>>>> this
>>>>>>>>> symptom. We'll review the changes between two firmware
>>>>>>>>> (20230526/20231109) if it's a bug or not.
>>>>>>>>>
>>>>>>>>> It may take some time to investigate. I'll let you know if
>>>>>>>>> there is any
>>>>>>>>> progress.
>>>>>>>>
>>>>>>>> Just wondering: Chris Lu, and Marc, what's the status here?
>>>>>>>> From
>>>>>>>> here it
>>>>>>>> looks like there was no progress to fix this regression for a
>>>>>>>> while, but
>>>>>>>> it's easy to miss something, that's why I ask.
>>>>>>>>
>>>>>>>> Ciao, Thorsten
>>>>>>>
>>>>>>> FWIW, the similar bug was reported for the recent 6.11.x kernel
>>>>>>> on
>>>>>>> openSUSE Tumbleweed, and this patch was confirmed to work
>>>>>>> around
>>>>>>> the
>>>>>>> crash at boot:
>>>>>>>
>>>>>>>
>>> https://urldefense.com/v3/__https://bugzilla.suse.com/show_bug.cgi?id=1231599__;!!CTRNKA9wMg0ARbw!jYyH2oubBEtIKXmKl9cI2rrmK-7kSdaiIJQ8xH4NZa5i5YCTQDHaoOxCBhMgdAAY6ROIPAoPwbOV-LNeMRJBlR6u-As$
>>>>>>>
>>>>>>> It'd be great if you can go ahead and merge the proper fix to
>>>>>>> the
>>>>>>> upstream.
>>>>>>>
>>>>>>> Let me know if you have another patch to test.  Then I can
>>>>>>> create a
>>>>>>> test kernel package and ask the bug reporter for testing.
>>>>>>>
>>>>>>>
>>>>>>> thanks,
>>>>>>>
>>>>>>> Takashi
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>> ************* MEDIATEK Confidentiality Notice ********************
>>>>> The information contained in this e-mail message (including any
>>>>> attachments) may be confidential, proprietary, privileged, or
>>>>> otherwise
>>>>> exempt from disclosure under applicable laws. It is intended to be
>>>>> conveyed only to the designated recipient(s). Any use,
>>>>> dissemination,
>>>>> distribution, printing, retaining or copying of this e-mail
>>>>> (including its
>>>>> attachments) by unintended recipient(s) is strictly prohibited and
>>>>> may
>>>>> be unlawful. If you are not an intended recipient of this e-mail,
>>>>> or believe
>>>>> that you have received this e-mail in error, please notify the
>>>>> sender
>>>>> immediately (by replying to this e-mail), delete any and all copies
>>>>> of
>>>>> this e-mail (including any attachments) from your system, and do
>>>>> not
>>>>> disclose the content of this e-mail to any other person. Thank you!
>>>>>
>>>>
>>>>
>>>
>>> ************* MEDIATEK Confidentiality Notice
>>>  ********************
>>> The information contained in this e-mail message (including any 
>>> attachments) may be confidential, proprietary, privileged, or otherwise
>>> exempt from disclosure under applicable laws. It is intended to be 
>>> conveyed only to the designated recipient(s). Any use, dissemination, 
>>> distribution, printing, retaining or copying of this e-mail (including its 
>>> attachments) by unintended recipient(s) is strictly prohibited and may 
>>> be unlawful. If you are not an intended recipient of this e-mail, or believe
>>>  
>>> that you have received this e-mail in error, please notify the sender 
>>> immediately (by replying to this e-mail), delete any and all copies of 
>>> this e-mail (including any attachments) from your system, and do not
>>> disclose the content of this e-mail to any other person. Thank you!
>>>
>>
> 
> 

