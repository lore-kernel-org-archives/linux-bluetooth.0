Received: from mail.schildbach.de (mail.schildbach.de [162.55.211.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A553101D0
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.211.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007493; cv=none; b=Ynn8GzA4H+zqUTKdT0GSzZnuIDdjJ0jCpZ4u5FHBM/EULyktHRqR4c1EjcgHVrmUEeGdQSF/U9HkCZy6SPTK9rvp+480Ogtuv/uKfamu3BWfgvoY9GnMQvZp0GpqQsSCh6zmFYkLsufXyNHW25a4HJ7PLQNttIflqO7E5t9vYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007493; c=relaxed/simple;
	bh=uyvj4UXa/74nX/7Rc1AfqhJIFZPrHxy+mSWNFR/wLHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cUTM8y6WnYmuaOyydKv8frSQ5qgskXn/glLvEoCN5HuMAuUqu0yyok4PltQrKz4wKeAVex3oCIT3XIj7ZNeilbut7Qw+ZNq/HhMH5beB/eVoTnbTZNBLOQvXWAiY1PefNyB04rLwG8HymOHuepepxfZjiSdGqBVQBVWiIhQr5U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schildbach.de; spf=pass smtp.mailfrom=schildbach.de; dkim=pass (2048-bit key) header.d=schildbach.de header.i=@schildbach.de header.b=gg+bvFz0; arc=none smtp.client-ip=162.55.211.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schildbach.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schildbach.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schildbach.de header.i=@schildbach.de header.b="gg+bvFz0"
Received: from [IPV6:2a02:3100:2e46:4400:e04d:e52e:cd9a:2ba7] (dynamic-2a02-3100-2e46-4400-e04d-e52e-cd9a-2ba7.310.pool.telefonica.de [IPv6:2a02:3100:2e46:4400:e04d:e52e:cd9a:2ba7])
	by mail.schildbach.de (Postfix) with ESMTPSA id 3D7963A84992
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 08:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schildbach.de;
	s=default; t=1772007488;
	bh=uyvj4UXa/74nX/7Rc1AfqhJIFZPrHxy+mSWNFR/wLHo=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=gg+bvFz0XWc0gPm4Bisex6XyyWp4K8lAOqSi0fHfehlMwzBBlzpBCL2vRzoLlK6sR
	 wTIlp8EbZ20tD/uvLPhidAboebhqkWBWaTzx6NDpZhhxy98ijwdjuU6/q5iIs+R1sO
	 4RA7Uk0Ox4fKoa3Z2fJLnVPBJ0VPjrTD1/4RGmYsogbcNUIW7yxqymKcYi4rXCKzS9
	 lZZU8u3ruXQgQhWggAp0U4egjXvjtzYReUokCakLg7CpzpcEVjmUj/b/cSvQETww8T
	 gXNJdxPM1MdhghJGGm1oTZYKd5IupSsZ7NFwbyKXzvogGGKtrGWzye42Y7ivCoFf1I
	 wnr0f4VcNiiGw==
Message-ID: <2f31dea0-205e-4e1b-a85e-276658535493@schildbach.de>
Date: Wed, 25 Feb 2026 09:18:07 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: minimal permissions for BLE operations?
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
References: <1c887efa-9722-4e24-b49a-da21eadc2ce0@schildbach.de>
 <CABBYNZLyBD2uJZpMEiu6NZYzivwnQprsAHW7Dfqr4L4ydcmaOw@mail.gmail.com>
From: Andreas Schildbach <kernel.org@schildbach.de>
Autocrypt: addr=andreas@schildbach.de; keydata=
 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
 69yjlFa2b6oZFE5Xd5Ba2O/1TbXtog==
In-Reply-To: <CABBYNZLyBD2uJZpMEiu6NZYzivwnQprsAHW7Dfqr4L4ydcmaOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

> On Tue, Feb 24, 2026 at 11:57 AM Andreas Schildbach
> <kernel.org@schildbach.de> wrote:
>>
>> I wonder what kernel capabilities or permissions are needed to use HCI for
>>
>> 1. passive BLE scan on channels 37, 38, 39,
>> 2. (read) access to a BLE GAP (for Thread/Matter device commissioning)
>> 3. hciconfig hci0 up/down
> 
> If really want to do low level access to HCI then you probably need to
> use HCI_CHANNEL_USER and take full ownership of HCI state machine…

Sorry, for I should have made this clearer: the software is already 
written (by others) and works, given root privileges. Now I want to 
allow it to run under an unprivileged user and grant just the 
right/minimal set of permissions/capabilities.

Let's take the probably easiest example from above (because it's part of 
Bluez): hciconfig hci0 up/down

What kernel capability does hciconfig need in oder to open and close HCI 
devices (and not print "Operation not permitted" when trying)? It's not 
mentioned in its man page.

> If you don't want to take ownership of HCI, …

Yes, I assume the software already takes ownership of the HCI.

> in the worst case, you will need a socket for GAP (is that an L2CAP channel that is used as transport for> Thread/Matter?).

It's just one small data packet that gets "broadcasted" via a GAP by the 
commissionee (the device being commissioned) and needs to be received by 
the commissioner (the "device" I'm trying to harden). After that, 
"device discovery" is finished and BLE isn't used again by the Matter 
protocol.

So I assume (but don't know for sure) no BLE channel is needed, I would 
expect more like a characteristic/beacon.

