Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699D15623B;
	Tue, 18 Jun 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722232; cv=none; b=FsI50XVieoulWHxGbYGfdWiV3UC9GlMEkNpLpzYWHUSo7R8z4ulvdO/NPoYBDJoKBEOnd6XBmpjtu8IhoMMJyoiMrkQ/3lF28JS8rCCbeQSEmMa8k2bztHYT521ORWqpnhxc8oh6MztroieTu0dvElbS5A1Gfy0SHj3P9x/M5nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722232; c=relaxed/simple;
	bh=1aJu4gzP+6qRFGjmKsiszYNo8UrJ18EAQQCBEzbAfL8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nt/GNgdfAeKo+yK2xj5X2kb1CUXZHZAPwnPhGa+8R5I0qZGankAbxD1pCFnyLrx9SHT3ueWlYluXl7mmnkaVVyvYkG9djR5zVlOI+YZLJ2exWhNgxZ981miZBOZaEcc/HTGXRUYYaG7a/8kVuXXMJspWXqBW6eqkr00d/kTn6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBK236Wa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBK236Wa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B77FC3277B;
	Tue, 18 Jun 2024 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718722231;
	bh=1aJu4gzP+6qRFGjmKsiszYNo8UrJ18EAQQCBEzbAfL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EBK236WaHkbw+y8k1pGkP9KRay2OvIVFDTZIlOvxyKGrnGfTgLetMHW8J/a2PE7/W
	 k16tQmX8IvcbKZ+/AVPfemI3gJdnYhI6BOAwuyDkEjmckZ8ALwWDnu9WXNFDjzBJN4
	 RS/4xf6r49/Upte2JHspwwGVaorBwcPwSZIGiLuJ3ldoWZbMyP3w4fzToxza16eTEI
	 MtALGVbTBkZF6Cr1ZzFwP0A3fjJfwq3aA+Q7WaMF6ryQTltnwxYM4f87RrvunJfQlV
	 B2lVExja2VdK1XXlUYNLYfrBF0SdcHsYoVbmuIOT/VdWJmGDlEOrKjtmZPGwZjnMXN
	 AGwkasbCtQSGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4ADF5C39563;
	Tue, 18 Jun 2024 14:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Add RTL8852BE device 0489:e125 to device
 tables
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171872223129.2471.16979094399869238103.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 14:50:31 +0000
References: <20240617090518.3237642-1-hildawu@realtek.com>
In-Reply-To: <20240617090518.3237642-1-hildawu@realtek.com>
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex_lu@realsil.com.cn, max.chou@realtek.com, kidman@realtek.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Jun 2024 17:05:18 +0800 you wrote:
> Add the support ID 0489:e125 to usb_device_id table for
> Realtek RTL8852B chip.
> 
> The device info from /sys/kernel/debug/usb/devices as below.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=07 Cnt=03 Dev#=  5 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e125 Rev= 0.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00e04c000001
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Add RTL8852BE device 0489:e125 to device tables
    https://git.kernel.org/bluetooth/bluetooth-next/c/9360c2da682f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


