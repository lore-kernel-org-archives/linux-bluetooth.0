Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC011A5B84
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Feb 2026 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769977400; cv=none; b=OJ3xnWAbzBHk0SYxG0NUzZcrJYII5t4Mef8LKtm881Mmq5Q5NgY/K6rRRmuekqzBEJcYUCA9n+y7vMIDqdKmqSWKuBtQGeb8S+6u+//TKQhnzMtxSoK37glgKtaG2jqkoYk3+gbS7ZcLwvH2zCG3VMsttu/fQf65tGR0+zAtrkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769977400; c=relaxed/simple;
	bh=iY0YsJPZGr4IiLX1bzN+qewgmc7RHVyE/hDJ4Yqx3Z0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=SRjdMJ7QR5eYIxoWFF1NKPZxxDJKbccSYcXsAKQTb3Iv6bh+5V0JvvHa2P8pQMr8VTOITHjl1wDt2b9lyIhsdEk4vfKgM1ESaZHsAVEeldNdOEucfpiWaQK3kzDjPpJ7pihJuqpdeVNTbWvSdHqEl1rXM84aohcu9lM1L1s7lF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Xwmrprb/; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Xwmrprb/"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id DD5C6240103
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Feb 2026 21:23:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1769977396; bh=IrRTQvv0UHpaqmqoJDqmp/YpvHQqwn6K9FcA18NfsDU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:From;
	b=Xwmrprb/cIER+HW7yWqoER8mEuT9nZnbC0Lgg4Q2kJ9/dzOgXWroWYlyTZHNofEZT
	 6lQLqKnBrLWQ5hLoiGcz6lVohBYxinFXqcQqsjllWc21IdhDoB3mTU5qCUaph4XV2I
	 yjZEisN6cYyiNIZDOvTzhGh6C/DA5yLGzcwRzGTOuT1fXr9H0JO4Ajhx619EBUt1qQ
	 rY58Fl4Kxtx5KtWeg4CY7CPyW0lAaWL3mgF+fFydl38kjBU4tVylCKl02oJnpt3Jdj
	 q4LLaOLxFNu5gjwPjsEJ+TDkqwgoj1kwC2rpwQzdpNTnTTrC8flrNbIj/VnxNPWd0r
	 qoj5O3HD4jf2g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4f41Qr40HQz9rxF
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Feb 2026 21:23:16 +0100 (CET)
Message-ID: <8b1720fe-cff1-4ce0-8367-65ae9c2c96f8@posteo.de>
Date: Sun, 01 Feb 2026 20:23:16 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Content-Language: en-US
From: Theodor Senf <theodor.senf@posteo.de>
Subject: btusb: Add Mercusys MA530 (USB 2c4e:0115) to RTL8761BUV device list
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The Mercusys MA530 Bluetooth 5.3 adapter (USB ID 2c4e:0115) uses the 
RTL8761BU chipset but isn't in btusb's device table.

The device initializes but scanning fails - Realtek firmware is never 
loaded despite rtl8761bu_fw.bin being present. Works on Windows.

Other RTL8761BUV devices are already listed with BTUSB_REALTEK | 
BTUSB_WIDEBAND_SPEECH.

Verified info: lsusb: Bus 007 Device 003: ID 2c4e:0115 Mercucys INC 
Mercusys MA530 Adapter Manufacturer ID: 93 (0x5D) = Realtek 
Semiconductor Corporation Firmware present: rtl8761bu_fw.bin.xz, 
rtl8761bu_config.bin.xz Kernel: 6.17.7

Could 2c4e:0115 be added alongside the other 8761BUV entries?

[Disclaimer]: This Issue was diagnosed with Claude Code, as I am not 
familiar enough with the matter to do so myself. I double checked all 
specifications but can't guarantee correctness of the provided Information.

Thanks and Kind Regards
Theodor Senf


