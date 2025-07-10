Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D62F1999;
	Thu, 10 Jul 2025 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168747; cv=none; b=YWVVU3Oe2s5ghXfMtdeCdhcyarefvj9ne1IrR+ZpPQf4Vc3Cydpu+3jpxWN/NMoa5KrbWjqMG4lYU85m4081gnUKfPi7ALTDGUAusCPIAUnLR9qJ5EnUxPgeOTEX9UCw/hn24C2fath78euY8DeRxEQ0t9c78s1VXsKGMp/3Yjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168747; c=relaxed/simple;
	bh=D91ad0Eo/iUUOJaTQYy56RP8Urj/5YuWyfsNxyzFk0w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=beNz5i5t9lQp+xUPVfd4DvAaavB5t2KmPHxON8JrRAsWBnoBr859zPSegFn37SS9YS5cNBxzh6+kb6xAycyepWELwDjCd1+vUnsvAZfZn5+QgG2D/wQAOcPk4aw00ymKFxfO2ZSAqkifOM5zyeaeD16frw0kq/LNBquu5O855S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jb0KhvYU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jb0KhvYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41788C4CEF1;
	Thu, 10 Jul 2025 17:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752168747;
	bh=D91ad0Eo/iUUOJaTQYy56RP8Urj/5YuWyfsNxyzFk0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jb0KhvYUV88wI3iKgZyvUzYTrdXWZksrcT6XpCfc4MUQ9CvHNbXwYO9sEub3R3RvK
	 Y0tjfNxJjrnlFDpwxrsxAHnghdEoi4rSfGMU/5roNiUteQuBZxHBB4pPMNjzDQNS/w
	 DaIHpGWQfzevt0zGfSpp6kHTjzbBinGOHK21bEQAvZHJGL+CxEayns0KG+ckc360MV
	 +T7ryvp/5N6Qq4i0xM9F6b/KO50uAJA1VfdPNjyRZHHPKx3JcznXMPQYWIiiOirADG
	 hc5Xg7FvRv/3+r7WftasV6SOVS2jImI4TaWDLknAtRugmWZBWwMGcHuCSagXwSF1c2
	 psXRU7ZkrUY2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF39383B266;
	Thu, 10 Jul 2025 17:32:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add RTL8852BE device 0x13d3:0x3618
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175216876934.1607762.3724196588807141344.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 17:32:49 +0000
References: <43D87E237D082F39+20250710080548.180268-1-wangyuli@uniontech.com>
In-Reply-To: <43D87E237D082F39+20250710080548.180268-1-wangyuli@uniontech.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhanjun@uniontech.com, niecheng1@uniontech.com, guanwentao@uniontech.com,
 lihao1@uniontech.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 10 Jul 2025 16:05:48 +0800 you wrote:
> From: Hao Li <lihao1@uniontech.com>
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below:
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3618 Rev= 0.00
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
  - Bluetooth: btusb: Add RTL8852BE device 0x13d3:0x3618
    https://git.kernel.org/bluetooth/bluetooth-next/c/4e8c8afb1eef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


