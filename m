Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB57E1DA62E
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 May 2025 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626213; cv=none; b=W7+pZktWfzr9f4wBeElQpqSRGyfgpbfO2hrJLgWJOVWFE+LN7HjC9xdeIosdHM8u5lQc1lIEFZhQOU6rMeozsuJ+L2WcrWG4p7tS2KZA8omMifnv3GyQhDwcJa5cZjnvwEYtVQEIBb1faEboGfnR3btDZoocK6QnjGJIZ5+oUyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626213; c=relaxed/simple;
	bh=sVGlxkyrz6VopIYLOrZR+DWy3EjEIvY7wDNSaYlLhtY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MiM7q3l2UFPAdZLpnfcRvfEwFUJUS7LRBVzBdUF87ibGlKz0++ShkUwTp9dJ81sKUBMyEYHcZby+4ZRpM+Zlw+JSa4r3BkBkYOEkU2ZieHtzXQtUVh+CXH9VO+/sYTW2scS3HwgmLP1KOGfcQIulQ11ywWPyjHBA20PR7lBcnW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gB9K7Sa2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB9K7Sa2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F54C4CEE9;
	Fri, 30 May 2025 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748626213;
	bh=sVGlxkyrz6VopIYLOrZR+DWy3EjEIvY7wDNSaYlLhtY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gB9K7Sa2yEH0sPIGilz/LhHKH5lYbhm/5gk2B69XlAoKKk/QoHtv7T+y4gNAjUp8c
	 UqmuBUd1SWioDeMdcQUMjOfl2P7BAoxwZXVWCSsPVEaUc9j8xZ5H1BaQXqzzWOBXi0
	 m9mXbw3ofH+UDI86XxGoOJoMMslpVyIAIeQfUkxn9S9GN5L+8Ca/bM0qdrreprgj7d
	 Rqmfmt9AHUG8aTRgwDfzjDb/Lz4SxdlMjTDvMj3zOJx0PrU2sUhq2YTCD3yPXkWSFS
	 hMuiAxDHpjfY13FUGFXz6Cg9BwLyUX0i7g+iaEMwl7HITteT8L20CNWBLEiV7MP6L0
	 k7BlQ8itMxK+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFD139F1DF2;
	Fri, 30 May 2025 17:30:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add support for variant of RTL8851BE
 (USB
 ID 13d3:3601)
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174862624649.4035476.14008075520567733659.git-patchwork-notify@kernel.org>
Date: Fri, 30 May 2025 17:30:46 +0000
References: <20250529162333.462753-2-ukleinek@debian.org>
In-Reply-To: <20250529162333.462753-2-ukleinek@debian.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cukleinek=40debian=2Eorg=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, 1106386@bugs.debian.org,
 shdeb3000000@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 May 2025 18:23:32 +0200 you wrote:
> Teach the btusb driver to recognize another variant of the RTL8851BE
> bluetooth radio.
> 
> /sys/kernel/debug/usb/devices reports for that device:
> 
> 	T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> 	D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> 	P:  Vendor=13d3 ProdID=3601 Rev= 0.00
> 	S:  Manufacturer=Realtek
> 	S:  Product=Bluetooth Radio
> 	S:  SerialNumber=00e04c000001
> 	C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> 	I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 	E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> 	E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> 	E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> 	I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 	E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> 	E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> 	I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 	E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> 	E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> 	I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 	E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> 	E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> 	I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 	E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> 	E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> 	I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 	E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> 	E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> 	I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 	E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 	E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 	I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 	E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> 	E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add support for variant of RTL8851BE (USB ID 13d3:3601)
    https://git.kernel.org/bluetooth/bluetooth-next/c/995f1fd6ac0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


