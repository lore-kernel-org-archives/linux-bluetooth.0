Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA079C2
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 06:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718085714; cv=none; b=iCwZyiaf+ngOSZTtV1NCmtT3RKFKtg+BR47VR4D8Bl83kQ75QbJU7bUtK2ivMHKA+Qq+8pFxGF3RMHNmUlwykEhTe9w65jMT03jpIDSRkTfjs6PruaHhUcpoIR5AXPlrvqwRZXZFzqS0DesXpnOb7//AjJTseHXzzRvw22Ud52I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718085714; c=relaxed/simple;
	bh=PDDN3Ssn6/hBbjK46au6vVgn9EwgrjHBpjTQx3yqNfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNGK63WGknR+l4xDZIp4OSTCe4Dw18cBstbF+Cei1CumfbJvtvfKhEWwqjr+M7myX3tJu0hbysoqZgr+VTL5ciBkb0fbmx2u6sxorBIJqJ9M3i3aMOtrO2BWNw2wh+Z5uZVV+rMwzr8a3u09e9RePLb2o1Aw6Jyea7iBHdCUID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af516.dynamic.kabel-deutschland.de [95.90.245.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4E55E61E646D9;
	Tue, 11 Jun 2024 08:01:44 +0200 (CEST)
Message-ID: <add06ad4-314f-4f50-a400-09960d3c0350@molgen.mpg.de>
Date: Tue, 11 Jun 2024 08:01:43 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth for hearing aids support (ASHA)
To: Stefnotch <brandmairstefan@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Arun Raghavan <arun@asymptotic.io>, linux-bluetooth@vger.kernel.org
References: <CAAvW=MyYArpr-bpiHkHjrqmkGsiSpMqyAivbMCLepV1HajyAzA@mail.gmail.com>
 <CABBYNZ+Keecvkfzf4+m+e3M5ohc6rGHrFs_wYEYzSV9fSt-aZA@mail.gmail.com>
 <CAAvW=MzR_h2sYxz-wRWeBoP1QoQGaP11sm+TrGxq5Drat7-uXg@mail.gmail.com>
 <CABBYNZ+Rs8XLy9=BSJfTUPeJe69Fw0bVCpb1KQmNw305ATH-0w@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CABBYNZ+Rs8XLy9=BSJfTUPeJe69Fw0bVCpb1KQmNw305ATH-0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Stefnotch,


Am 27.07.23 um 19:31 schrieb Luiz Augusto von Dentz:
> Hi Stefnotch,
> 
> On Wed, Jul 26, 2023 at 6:13 AM Stefnotch wrote:

>> On Tue, Jul 25, 2023 at 8:07 PM Luiz Augusto von Dentz wrote:

>>> On Tue, Jul 25, 2023 at 6:49 AM Stefnotch wrote:

>>>> I have hearing aids, which can be connected to devices that support
>>>> the Bluetooth ASHA protocol.
>>>> https://source.android.com/docs/core/connect/bluetooth/asha
>>>> That protocol is open and somewhat well documented. However, it is
>>>> only supported on Android devices at the moment. BlueZ on Linux does
>>>> not appear to support it.
>>>>
>>>> The idea is with Bluetooth ASHA, one can stream audio from a computer
>>>> directly to a pair of hearing aids. Without Bluetooth ASHA, I'm
>>>> limited to using a battery powered, clumsy accessory from Cochlear.
>>>>
>>>> I was wondering if it would be worthwhile to support that in BlueZ.
>>>>
>>>> For the record, this has been requested in the past, but hasn't
>>>> progressed any further.
>>>> https://www.reddit.com/r/linuxquestions/comments/l54zku/accessibility_for_the_deaf/
>>>> https://github.com/bluez/bluez/issues/481
>>>
>>> Don't think there is any objection to having support for ASHA, the
>>> problem is that most of the companies contributing to BlueZ are
>>> focusing on LE Audio which supersedes ASHA, so the challenge is to
>>> find someone to support this feature.

>> Glad to hear that I found the right place to ask about this. Do you
>> think it would be worthwhile to try to find someone to support this
>> feature, or is the Bluetooth team usually very short staffed?
> 
> There are not so many people dedicated to upstream full time, besides
> normally for big features like this we normally rely on companies
> interested in the feature to support the work upstream.
> 
>>  From a user-perspective, I think that a number of existing hearing
>> aids support ASHA, and might never receive a firmware update for any
>> newer Bluetooth Audio Standards. For example, the Cochlear Nucleus 7
>> supports ASHA, however it has been superseded by the Cochlear Nucleus
>> 8. I really don't know if companies have much incentive to update old
>> devices that many people rely on.
>> Considering the price tag on some of those hearing aids, I fear that
>> this ASHA support request might still be relevant in 10 years.
> 
> Well you could consider asking the manufacturer, or google, to support
> Linux in general, but I'm afraid they might push back saying they
> support just the major OSes.
> 
>> If it is indeed worthwhile to try and find someone to support this
>> feature, is there anything I could do to support this?

Just for the archive, as you probably know already from the issue [1] 
referenced in your message starting the thread, Arun is working on this 
[2], and it is currently reviewed on this list.


Kind regards,

Paul


[1]: https://github.com/bluez/bluez/issues/481
[2]: https://github.com/bluez/bluez/pull/836
