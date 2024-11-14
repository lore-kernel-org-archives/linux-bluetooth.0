Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D81E9089;
	Thu, 14 Nov 2024 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731572882; cv=none; b=BBbji3mjMY0/kGjNGe/IoaTmXBijDYGF9V00Qr2c8mH4vjbA1c1y9X+4aycUiyraZHl5KezJMvGeEaP8dDvCuN9cgdaDKfMhUNRHk4uA/Z3Jv7e9h0VvNFL5Mxal02nCzJqoomPI8wjJ9DMrk8AfffLfBhnIBuy5XLYepnETti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731572882; c=relaxed/simple;
	bh=dxfrB2xn9UyZVCIqytZozBiAIlJtxFFbmfcKj4Ke898=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ea8lySdeRxnC05OUY3R5esfvEhOdMeCf1eg02vDMuzN1+n4+G+n2R0IxfhBbMSNwlgZRGEZE414HR1e5W6BWu3/nnhuyZzTuwQmmSN0FDDm6dKC+ijpsFUeWVoKVqP7W1AOOlvMO2Ix+DybrqAkChyQ8C7S+UqqISASqV9JQM4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af533.dynamic.kabel-deutschland.de [95.90.245.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D198961E5FE05;
	Thu, 14 Nov 2024 09:27:47 +0100 (CET)
Message-ID: <c23fe4b8-04ae-41fb-a166-0b8a84e2ef70@molgen.mpg.de>
Date: Thu, 14 Nov 2024 09:27:46 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA NVM file for the X13s (WCN6855)
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Tim Jiang <quic_tjiang@quicinc.com>,
 Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZjNxfFJmCgIyq8J6@hovoldconsulting.com>
 <5aea3149-ba44-400f-acc6-1a3eca8a7e72@quicinc.com>
 <ZjOUWqor4q1Efy0W@hovoldconsulting.com>
 <f1b45d7d-27e0-4ad7-976c-670a0e0d136b@quicinc.com>
 <ZjOfdK41yLwkH25T@hovoldconsulting.com>
 <5549d7e4-06cb-4305-8cec-10e93e5fbbff@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <5549d7e4-06cb-4305-8cec-10e93e5fbbff@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Zijun,


Am 14.11.24 um 07:57 schrieb quic_zijuhu:
> On 5/2/2024 10:13 PM, Johan Hovold wrote:
>> On Thu, May 02, 2024 at 09:46:38PM +0800, quic_zijuhu wrote:
>>> On 5/2/2024 9:25 PM, Johan Hovold wrote:
>>>> On Thu, May 02, 2024 at 08:56:12PM +0800, quic_zijuhu wrote:
>>>>> On 5/2/2024 6:57 PM, Johan Hovold wrote:
>>
>>>> It's WCN6855 but the Linux driver currently uses the firmware you pushed
>>>> for QCA2066.
>>>>
>>>>>> The current Linux driver is using the generic NVM file (hpnv21.bin) for
>>>>>> WCN6855, but connectivity is quite bad and I only get 2-3 meters of
>>>>>> range.
>>>>
>>>>>>> Switching to the board-specific NVM configuration (hpnv21b.b8c) that
>>>>> it seems hpnv21b.b8c is a wrong NVM name.
>>>>> is it hpnv21g.b8c?
>>>>
>>> hpnv21g.b8c is the right NVM for the machine.
>>
>> Ok, thanks. I'll try to find some time to test with this one as well.
>>
>>>> What is the difference between those two?
>>
>>> i am afraid that i can't answer your question due to company CCI policy
>>
>> I understand.
>>
>>>> Exactly. It's a Lenovo machine that comes with Windows pre-installed and
>>>> we're working on enabling Linux on it with some help from Lenovo.
>>>>
>>>>> need customer to make a request for their requirements if the answer is
>>>>> yes for above question.
>>>>
>>>> Lenovo has made requests for X13s firmware from Qualcomm and pushed it
>>>> to linux-firmware [1], but they have not yet been able to get Qualcomm
>>>> to provide an NVM configuration file for Bluetooth (I think the problem
>>>> may be finding the right person to talk to inside Qualcomm).
>>>>
>>>> So I was hoping maybe you could help us with this since the difference
>>>> between 'hpnv21.bin' that you pushed to linux-firmware and what came
>>>> with Windows appears to be really small (e.g. just a few bytes).
>>>>
>>> let me try to find out the right person who will push this task at next monday.
>>> there are some other internal procedures before we can push BT firmware
>>> into linux-firmware.
> 
> have up-streamed 22 NVM files which come from WOS into linux-firmware as
> shown by below link, both hpnv21g.b8c and hpnv21.b8c are also contained.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=77a11ffc5a0aaaadc870793d02f6c6781ee9f598
> 
> (^^)(^^).

Thank you. Could you please enlighten me, what WOS is?


Kind regards,

Paul
