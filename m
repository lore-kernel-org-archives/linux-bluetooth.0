Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E73CE4AC;
	Wed, 17 Jun 2026 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686201; cv=none; b=t40rENTlVpNqYa46YXTtEwt+J19AMN01g2icoVVxEJDeTTLv3RxNDYJLBHb37Iaw/ZIVKCJ0rCTwt8nAOVO+KsslajUXYFztEDLaodBWB+K82xUc1/6Pjywgs0381w7cKVwVSLUJU0qL5TStZgpynlsj5gMq2z0V6vzkbEPFULQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686201; c=relaxed/simple;
	bh=cv950APeKD0DB+iuERkSO8FBZ3KsMnzQGLfM7kA4Tpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUrTdty8PXW18WvK87kXHO6yCjVLg5AGtBAdn/0z8/BooAA/DLF5LOnQqnfGF2TYu+i3JusTloJEyPrVXdf6YufjyCPA99NvVomzeWArXYlEnq+9kFElvwlKLr3xtfsvezVsz74sHCKf9SdWi02iMcpl6nN4uOFkDeKwFsRAb94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7D3744C2C37F03;
	Wed, 17 Jun 2026 10:49:41 +0200 (CEST)
Message-ID: <42de470f-21a7-464e-876f-254a60ac3637@molgen.mpg.de>
Date: Wed, 17 Jun 2026 10:49:40 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btmtk: Add MT7928 support
To: =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
Cc: =?UTF-8?B?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
 =?UTF-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
 luiz.dentz@gmail.com, marcel@holtmann.org, =?UTF-8?B?U1MgV3UgKOW3q+aGsg==?=
 =?UTF-8?B?5qyjKQ==?= <ss.wu@mediatek.com>, linux-kernel@vger.kernel.org,
 johan.hedberg@gmail.com, Sean Wang <Sean.Wang@mediatek.com>,
 linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20260616030132.532184-1-chris.lu@mediatek.com>
 <6b29b553-d703-448d-9275-62912a62e356@molgen.mpg.de>
 <03e0a6787272a445448a3189b4b575aa85396fb0.camel@mediatek.com>
 <4501985d-c8df-4121-89fd-0b4eb09273c6@molgen.mpg.de>
 <c983c544a39606e1468158a7b6fdc77b6ca5c8a2.camel@mediatek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <c983c544a39606e1468158a7b6fdc77b6ca5c8a2.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chris,


Thank you for your reply.

Am 17.06.26 um 10:34 schrieb Chris Lu (陸稚泓):

> On Wed, 2026-06-17 at 08:53 +0200, Paul Menzel wrote:
>>
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.

>> Am 17.06.26 um 04:16 schrieb Chris Lu (陸稚泓):
>>
>>> On Tue, 2026-06-16 at 12:24 +0200, Paul Menzel wrote:
>>
>>>> Am 16.06.26 um 05:01 schrieb Chris Lu:
>>>>> Add support for MT7928 (device ID 0x7935) which requires
>>>>> additional
>>>>> firmware (CBMCU firmware) loading before Bluetooth firmware.
>>>>
>>>> Please detail what CBMCU firmware is.
>>>
>>> CBMCU is a new component on MT7928 to handle common part shared across
>>> the combo chip (Wi-Fi/Bluetooth's subsystem), providing a better user
>>> experience through improved coordination between subsystems.
>>
>> Thank you, but please add it to the commit message.
>>
>>>>> Implement two-phase CBMCU firmware download: Phase 1 loads
>>>>> section with type 0x5 containing global descriptor,
>>>>> section maps and signature data; Phase 2 loads remaining
>>>>> firmware sections. Add retry mechanism for concurrent download
>>>>> protection.
>>>>
>>>> What is type 0x5? How big is the firmware, and how long does it
>>>> take?
>>>>
>>>>> After CBMCU firmware loads successfully, the driver continues
>>>>> to load corresponding BT firmware based on device ID through
>>>>> fallthrough to case 0x7922/0x7925.
>>>>
>>>> Please add the new log message to the commit message.
>>
>> Thank you for adding those. Please also mention, where to find the
>> new firmware.
>>
>> […]
> 
> Since MT7928 hasn't been deployed in any commercially available
> products yet, MediaTek currently plans to send driver patch first and
> upload firmware part after done a series of internal test to make sure
> the quality.

Understood. Also something for the commit message. ;-)

I wonder, if this should only be put into Linus’ master branch, once the 
firmware is available.


Kind regards,

Paul


>> PS: Also, Pauli’s question should be answered in the commit message
>> (internal/external name). (If questions show up during review, it’s a
>> good indicator to amend the commit message answering these
>> questions.)
