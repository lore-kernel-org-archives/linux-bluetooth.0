Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36A1E0E10;
	Fri,  8 Nov 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059661; cv=none; b=h4UB5/bGg05gytj0OnEpx+R20W0suDfjL5V1d4zSL38q1VR/W8tlfSFyoaTZCw5yUtDJK4oSVKRdOI/GWuBd92E9PpJRJC4S5DpgpzqXe0mg+en8Y9EBv3iRTWzwalD+9nD5jlmGUYGjPCaqRJgv7y7wlzAt+cxyYVcfx48YSuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059661; c=relaxed/simple;
	bh=OLdGdgqVzPX1C/I75gF+hdI/YIe5aZRlPACuVhCHDho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=be5sZgBbE28SAlNxW/27YzatYoHD5M4qFHl39QdGzsqXTEBB0pSG8yMcrSjRObb/L6+0MfZ14LLo1PJYhWrjJOGEjBUlTC+fwq6OFBsTFlIl0U/o7e1WExZPhbfUk8COkv8yUCuwRMaJHwHLLycFEcyJfa8daOeNINvY3vqREJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (unknown [95.90.242.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id DCDD5600AA6A1;
	Fri, 08 Nov 2024 10:53:47 +0100 (CET)
Message-ID: <c81aa403-499b-4639-88a0-887575731d39@molgen.mpg.de>
Date: Fri, 8 Nov 2024 10:53:46 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] linux-firmware: update firmware for mediatek bluetooth
 chip (MT7920)
To: =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org,
 =?UTF-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
 linux-bluetooth@vger.kernel.org, ben@decadent.org.uk,
 linux-firmware@kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
 =?UTF-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
 Sean Wang <Sean.Wang@mediatek.com>, =?UTF-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?=
 <Aaron.Hou@mediatek.com>, jwboyer@kernel.org, dwmw2@infradead.org
References: <20241108082515.19817-1-chris.lu@mediatek.com>
 <46444b60-2d1a-45c2-9a96-8352d1879516@molgen.mpg.de>
 <024285d0deb37c1444b1aaa4cba64542fe4ac844.camel@mediatek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <024285d0deb37c1444b1aaa4cba64542fe4ac844.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chris,


Thank you for your quick reply

Am 08.11.24 um 10:25 schrieb Chris Lu (陸稚泓):

> I'll send a v2 to update commit message based on your suggestions.

You are quick, and I got it already.

> On Fri, 2024-11-08 at 09:37 +0100, Paul Menzel wrote:

[…]

>> It’d be great if you added a change-log.
>>
> We'll updates the firmware with Wi-Fi module at the same time if either
> of modules has any fix need to be upstream.
> 
> It's a routine update to MT7920 Bluetooth side.

So, this time, there are no Bluetooth fixes, only for Wi-Fi?

>>> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
>>> ---
>>>    WHENCE                                   |   2 +-
>>>    mediatek/BT_RAM_CODE_MT7961_1a_2_hdr.bin | Bin 493809 -> 493809 bytes
>>>    2 files changed, 1 insertion(+), 1 deletion(-)

Kind regards,

Paul
