Received: from vii.li (mail.vii.li [37.27.246.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D952DA74A
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.246.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762631; cv=none; b=KBRxmpVhbD8Tii66jdYC8H6Y/tt87/5vlCXnzbN1msBUeI2hWtLgvxiBDZf9ttJb/x8iVf3Qr0NqsGXlO+z0m58S3x2DoLmRmjVK3bvH71y6EEk3TeY9af+KzfUAZQEOWMtprc4fBlECFbXSYjS1R37ugn/W1f5Bbro2Jom6pYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762631; c=relaxed/simple;
	bh=Em8YhomOWsPvrswerz8qOAruKpI+LmyO/ww3gJbLqKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ldu813EYti24a4k2Qwb+5rwZSAquJ/HSdexnGMRFqI3dGj/NCfWGEH6rNyrNTKqwEA/2YSSrPR85IBcI7Jz9Kdy9/d0Hcq3BpK+p4GqPt8QfaKYHmNwM4ha7spBFNpI6hGeoekQjQ4RO7XLZCGDnqIG1GPYOHpQyo8N4FwpD8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vii.li; spf=pass smtp.mailfrom=vii.li; arc=none smtp.client-ip=37.27.246.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vii.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vii.li
Received: from [172.21.22.126] (87-95-113-24.bb.dnainternet.fi [87.95.113.24])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vii.li (Postfix) with ESMTPSA id 5F6E03EFA7
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 12:43:48 +0000 (UTC)
Message-ID: <d3404852-1bc1-4dc2-b4fe-1715fe8e9d94@vii.li>
Date: Thu, 14 May 2026 15:43:47 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MT7922 does not work in 7.1-rc3, works ok in 7.0
To: linux-bluetooth@vger.kernel.org
References: <46f7ee10-3fa8-490c-bb17-5929229206fa@vii.li>
 <3da9180c46e0b3651a3ee4d552bb5cf5f8b70186.camel@iki.fi>
Content-Language: en-US
From: =?UTF-8?Q?Taneli_V=C3=A4h=C3=A4kangas?= <taneli@vii.li>
In-Reply-To: <3da9180c46e0b3651a3ee4d552bb5cf5f8b70186.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ohh, ok, thanks! Confirmed working, hopefully it gets merged soon.

Cheers,

	Taneli

On 14/05/2026 14:31, Pauli Virtanen wrote:
> Hi,
> 
> to, 2026-05-14 kello 12:57 +0300, Taneli Vähäkangas kirjoitti:
>> Hey, this might be also a mishap on my side, not yet familiar enough
>> with pacman to say with certainty I didn't mess up something (like
>> firmware loading), but here goes anyway.
>>
>> Bluetooth is provided by:
>> Bus 001 Device 003: ID 0e8d:0616 MediaTek Inc. Wireless_Device
>> I believe. This is a gmktec nucbox k8 plus by dmi information.
>>
>> With distribution's 7.0 kernel bluetooth shows up fine in Gnome and I
>> can connect my headphones and get audio. Using "linux-git" package,
>> which built 7.1-rc3 (+ some commits on top in torvalds tree). Booting to
>> it, bluetooth can't be enabled in Gnome, everything stays grayed out and
>> no devices are shown. (I tried 7.1-rc1 earlier, which also didn't work,
>> but I didn't take any notes back then.)
>>
>> The difference in dmesg is that on 7.0:
>> [    6.152649] Bluetooth: hci0: Device setup in 173263 usecs
>> [    6.152661] Bluetooth: hci0: HCI Enhanced Setup Synchronous
>> Connection command is advertised, but not supported.
>> [    6.216582] Bluetooth: hci0: AOSP extensions version v1.00
>> [    6.216593] Bluetooth: hci0: AOSP quality report is supported
>> 8<-- 8<--
>>
>> And on 7.1-rc3:
>> [    6.270455] Bluetooth: hci0: Failed to send wmt func ctrl (-22)
>> [    6.270466] Bluetooth: hci0: HCI Enhanced Setup Synchronous
>> Connection command is advertised, but not supported.
>> 8<-- 8<--
> 
> This has fix pending
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=162b1adeb057d28ad84fd8a03f3c50cf08db5c62
> 
>>
>> There are some changes in btmtk.c between these versions, but can't see
>> on glance anything wrong with them, only adding support for MT6639.
>>
>> I'm not on the list, please Cc: if I can provide more info.
>>
>> Cheers,
>>
>> 	Taneli
> 

