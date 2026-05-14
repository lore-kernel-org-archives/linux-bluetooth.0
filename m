Received: from vii.li (mail.vii.li [37.27.246.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084B937EFEA
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.246.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753105; cv=none; b=rsPbFZMlAV+LWKDv5hR35568ggPeWVluuZfPuAx6ozEqew8Igo5d31G06VZxnwON0pcVAsrQNcUmXfXdPtrlJpkhXND5u9sN+7NGprwVkxSzAksIx5WxypRoh9L08KL9ouiw8jv+0dix/svLEb8hILcK0YAguSkMZegd3cuVxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753105; c=relaxed/simple;
	bh=3plPWMYnMhd94HUlTtmPr3nmq65p5rQa74mpQ+f3JCg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Gb0HDsOFC8WNFU5DDAzdeFYUiMy4T5Zvpx0UzY44K3u66nWPfPpgZa3hnQKqnaMh2SlBYb5yprjFLhF5Lv9KlHJJk35QOUH4H3T5JLc+GYXNbl1m3FJ6CXplyRlSWjEfOQtjBVtAEv1i3u6CNAeovaqxAKRrJfL8e/aKULk6u8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vii.li; spf=pass smtp.mailfrom=vii.li; arc=none smtp.client-ip=37.27.246.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vii.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vii.li
Received: from [172.21.22.126] (87-95-113-24.bb.dnainternet.fi [87.95.113.24])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vii.li (Postfix) with ESMTPSA id 4F4A13EFAC
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 09:57:29 +0000 (UTC)
Message-ID: <46f7ee10-3fa8-490c-bb17-5929229206fa@vii.li>
Date: Thu, 14 May 2026 12:57:28 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
From: =?UTF-8?Q?Taneli_V=C3=A4h=C3=A4kangas?= <taneli@vii.li>
Subject: MT7922 does not work in 7.1-rc3, works ok in 7.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey, this might be also a mishap on my side, not yet familiar enough 
with pacman to say with certainty I didn't mess up something (like 
firmware loading), but here goes anyway.

Bluetooth is provided by:
Bus 001 Device 003: ID 0e8d:0616 MediaTek Inc. Wireless_Device
I believe. This is a gmktec nucbox k8 plus by dmi information.

With distribution's 7.0 kernel bluetooth shows up fine in Gnome and I 
can connect my headphones and get audio. Using "linux-git" package, 
which built 7.1-rc3 (+ some commits on top in torvalds tree). Booting to 
it, bluetooth can't be enabled in Gnome, everything stays grayed out and 
no devices are shown. (I tried 7.1-rc1 earlier, which also didn't work, 
but I didn't take any notes back then.)

The difference in dmesg is that on 7.0:
[    6.152649] Bluetooth: hci0: Device setup in 173263 usecs
[    6.152661] Bluetooth: hci0: HCI Enhanced Setup Synchronous 
Connection command is advertised, but not supported.
[    6.216582] Bluetooth: hci0: AOSP extensions version v1.00
[    6.216593] Bluetooth: hci0: AOSP quality report is supported
8<-- 8<--

And on 7.1-rc3:
[    6.270455] Bluetooth: hci0: Failed to send wmt func ctrl (-22)
[    6.270466] Bluetooth: hci0: HCI Enhanced Setup Synchronous 
Connection command is advertised, but not supported.
8<-- 8<--

There are some changes in btmtk.c between these versions, but can't see 
on glance anything wrong with them, only adding support for MT6639.

I'm not on the list, please Cc: if I can provide more info.

Cheers,

	Taneli

