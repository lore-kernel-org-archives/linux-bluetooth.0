Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25012364D6;
	Wed, 21 Aug 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251836; cv=none; b=jpUx+uBuBKSxUyHEnSS6Pf82+gyioue9coX/xVzqTAgD8yVaJuUa0hByGGLmmPxW3It490AgDpay0wQS9GSMlJh6QoM8oRNZJLejwBq8UZU5DrD6793X0VpbzrueTdLmw3aDPnhqRf+SJSpsdvz88KoTLgQ9xK123g0O8lgxPCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251836; c=relaxed/simple;
	bh=Tty7mC7lA8+daTa3tKwGN+LTrHFKZG9Q+zFBh2xA6no=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CLpgrjDfj8kU8gMd8lRgBB/LX2KftgIzquiUkV9eDq+4QX8JD/3H8y86v80blCHt8a453AN3NC/p4zhQ6FK92TVtBXF6Y/bpknQDvrmcqruH2/V8ikLFlR+rdL8e04XrPKXgx42TGqVWnhNK+RhQwowISyEWsrihM6HKqmcFo4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gR69QCt7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gR69QCt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE58C32781;
	Wed, 21 Aug 2024 14:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724251835;
	bh=Tty7mC7lA8+daTa3tKwGN+LTrHFKZG9Q+zFBh2xA6no=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gR69QCt7BGdpSDheSE+Ws+oPCqYmJa5N2g5LLzEjTqXa1Zy7h4ZpUeWetJynXl5KI
	 ai6n/20PXE6s7IGUKM6tVrJAMryW98Ak4c3zv7tAm+amKnKDof4ZIuyczeCYyITikU
	 LeI7GxxX1sDaxmvDzjcB7o63NBdSeQSJJVO/RkEtGYMKe6ZLXKIHZu7k/2eriboS27
	 egdvv/cDEVNKVPgznVeN5L577vhOyTbBvPVv4raY7L1wFSvQpgpqoMHKXefppWqfAU
	 xrh+R5ssV+h8j8zU1xhTpKiQIGlR/7L3syksw6ox9eQLUI/q+pvtkiw7ZJztq7w5Z/
	 l6HV2lbCKvwNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713CC3809ABF;
	Wed, 21 Aug 2024 14:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek MT7925 support ID 0x13d3:0x3608
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172425183524.1745569.14519368466745692015.git-patchwork-notify@kernel.org>
Date: Wed, 21 Aug 2024 14:50:35 +0000
References: <20240821110856.22552-1-pavel@noa-labs.com>
In-Reply-To: <20240821110856.22552-1-pavel@noa-labs.com>
To: Pavel Nikulin <pavel@noa-labs.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Aug 2024 15:08:56 +0400 you wrote:
> Add the support ID (0x13d3, 0x3608) to usb_device_id table for
> Realtek MT7925B14L found on AW-EM637 WiFi+BT modules in 2024 Asus laptops.
> 
> The device info from /sys/kernel/debug/usb/devices as below.
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3608 Rev= 1.00
> S:  Manufacturer=MediaTek Inc.
> S:  Product=Wireless_Device
> S:  SerialNumber=000000000
> C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
> A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
> I:* If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add Realtek MT7925 support ID 0x13d3:0x3608
    https://git.kernel.org/bluetooth/bluetooth-next/c/595d19e827a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


