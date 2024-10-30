Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8391CCEC2;
	Wed, 30 Oct 2024 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730280098; cv=none; b=or4MnFKj8AGrtRi0hQBkPAkRJpxjI90ZSxfa0JdSu97oxwKh69oWi4yptOzqJ8i3+shdHRi9YHqQIB9VQJ8C3DLLtOdeAb4VkHJOH+CNg8OcSn1MKw18pxzdkXurNEn8RRnJaAXDOs6CxyFT8rQZ3849B2bxa/9rAsfMYVboQQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730280098; c=relaxed/simple;
	bh=70tMDv49mQQjzweTGiK5PaokWjLpZ+/2+rBKiIwJMo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kh5nSRlYTasK6e6dCZrRla3+NF1hwZgl4PpsXuGf05CVfUC6VbKEVKVarAF3og8iZZJLisMr3Zkqem0QlNf7Ty6K41/sG211aVXtSupu0J08qvI9AtYx1oRLdKBc+rKOBlWMkXSc4qs7VqZfoBLo6OqYnYfBgqCaJu2Vcv6Y3lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=iKerIc9h; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="iKerIc9h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=nXB58CuEgVXls1f+iMFYqhB7nNGt0EfBseEbWcPVD0k=; t=1730280095;
	x=1730712095; b=iKerIc9h/4TCbx+IgaBSL08J8KwC956EtM5befWSQGWM/jYS/NRbYY98zreO8
	22Ps/ENumEkjbPShmGV42yYRy6jRxjwsmU3Ky4KjAr1m9QnTCHaHY60dNV8zHWy4rdgPhOLR6rOmY
	tKxmFxxTgJ/B+n9mzek2qXIfocmdtV2Fckg3W9FfggW6DSz9sCjsWtmLN1ETxy0bnTaiLkccofM7A
	5Hs9Foc5mklsOZOVbzmNyurPPT+BHKnyZK3JIhykQCD1E+hFr8qCslZbiixPsVLJ17WiYwaYpUhaK
	uR9zjQS64sS0LRbPN/xHaCpVzHLjjUKhxIed4hybxewXby2MTg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t64tK-0006fj-Q4; Wed, 30 Oct 2024 10:21:26 +0100
Message-ID: <75f671b6-ce2a-4404-b662-2c9c7d28a598@leemhuis.info>
Date: Wed, 30 Oct 2024 10:21:25 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before
 downloading the fw
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
 =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
 =?UTF-8?B?SGFvIFFpbiAo56em5rWpKQ==?= <Hao.Qin@mediatek.com>
Cc: "marc.payne@mdpsys.co.uk" <marc.payne@mdpsys.co.uk>,
 "marcel@holtmann.org" <marcel@holtmann.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 =?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
 "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
 =?UTF-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
 Sean Wang <Sean.Wang@mediatek.com>, =?UTF-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?=
 <Aaron.Hou@mediatek.com>, Takashi Iwai <tiwai@suse.de>,
 Linux regressions mailing list <regressions@lists.linux.dev>
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
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <87iktk4d9l.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1730280095;14c4c226;
X-HE-SMSGID: 1t64tK-0006fj-Q4

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

I'm a bit lost here, but maybe I'm missing something.

Luiz, can you help out here? Is there a reason why this patch is not
making any process?

Chris Lu and/or Hao Qin: Can you maybe help out as well as well and help
with resolving some open questions that might or might not be relevant
(see below).

From Takashi reply, the bugzilla ticket he linked to, and the mail from
the MediaTek folks
(https://lore.kernel.org/lkml/12a344e25b31ec00fe8b57814d43fcb166e71be5.camel@mediatek.com/
) it from the outside looks like this patch should really be merged
rather sooner that later as it fixes regressions for some people.
Afaics it should get a "Fixes: ccfc8948d7e4d9 ("Bluetooth: btusb:
mediatek: reset the controller before downloading the fw")" tag, as it's
afaics that commit that causes the regression that is known since more
than three months now
(https://lore.kernel.org/all/ZsTh7Jyug7MbZsLE@mdpsys.co.uk/ ).

But note, it seems it does not fix the regression completely according
to Marc's testing.
https://lore.kernel.org/all/ZuCB98DSdtKCgxaL@mdpsys.co.uk/

Marc: Is that still how things are with current mainline?

Ciao, Thorsten


On 22.10.24 12:56, Takashi Iwai wrote:
> On Mon, 14 Oct 2024 11:29:40 +0200,
> Linux regression tracking (Thorsten Leemhuis) wrote:
>>
>> On 20.09.24 08:27, Chris Lu (陸稚泓) wrote:
>>> On Thu, 2024-09-19 at 23:25 +0100, marc.payne@mdpsys.co.uk wrote:
>>>>  	 
>>>> External email : Please do not click links or open attachments until
>>>> you have verified the sender or the content.
>>>>  Hi Chris and Luiz,
>>>>
>>>> What were your thoughts on the findings in my email dated 18th
>>>> September?
>>>
>>> Thanks for your suggestion.
>>>
>>> I've prepared the same environment (Kernel v6.11 + MT7921AUN dongle) to
>>> reproduce the issue, collected necessary logs locally and also
>>> initiated an internal discussion to clarify the root cause of this
>>> symptom. We'll review the changes between two firmware
>>> (20230526/20231109) if it's a bug or not.
>>>
>>> It may take some time to investigate. I'll let you know if there is any
>>> progress.
>>
>> Just wondering: Chris Lu, and Marc, what's the status here? From here it
>> looks like there was no progress to fix this regression for a while, but
>> it's easy to miss something, that's why I ask.
>>
>> Ciao, Thorsten
> 
> FWIW, the similar bug was reported for the recent 6.11.x kernel on
> openSUSE Tumbleweed, and this patch was confirmed to work around the
> crash at boot:
>   https://bugzilla.suse.com/show_bug.cgi?id=1231599
> 
> It'd be great if you can go ahead and merge the proper fix to the
> upstream.
> 
> Let me know if you have another patch to test.  Then I can create a
> test kernel package and ask the bug reporter for testing.
> 
> 
> thanks,
> 
> Takashi
> 

