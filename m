Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B738F80
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwbKpQ8z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B173BC433C9;
	Tue, 19 Dec 2023 18:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703010537;
	bh=5yCHOTeqW/reseOlV30ghSbRWSrLBOR6sHdBOI61hKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WwbKpQ8zlSk0aFwVSPrO+Z+FmTZCkP5iL6agG03PxZ8DPwAhwqh/pYRTwfllAZQMO
	 fNciqtOq6cX9oPwQuSlAx7IUx3XfqKzV1oQgFQckqm+vDM6RLJp5Tb6e41l/RCoGzh
	 xJSnrQL4Xko0Faffe5Lbb7O44RH24Hs6JxCJjtdu8g7XIboYdq/6qL3zSKp9EDFOGM
	 3TVTw6tg3/tcWgrRWKQPai8lopcMNChj4cmnLYwEHkZziR7/20vCpJH9pRmivBJ9cR
	 ksVwp2nsvBGhRW9U1heBHraa7z+MpzJYlzcVOgw09NKIfZ8rl57VxAJBHqgjEWwSfv
	 GU4BwQA3n6FRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A44CD8C988;
	Tue, 19 Dec 2023 18:28:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: Add device 13d3:3572 IMC Networks Bluetooth
 Radio
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170301053762.15177.13373310124701633454.git-patchwork-notify@kernel.org>
Date: Tue, 19 Dec 2023 18:28:57 +0000
References: <20231219173547.337962-1-jagan@edgeble.ai>
In-Reply-To: <20231219173547.337962-1-jagan@edgeble.ai>
To: Jagan Teki <jagan@edgeble.ai>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 19 Dec 2023 23:05:47 +0530 you wrote:
> This 13d3:3572 is part of  Realtek RTW8852BE chip.
> 
> The device table is:
> T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3572 Rev= 0.00
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
  - [v2] Bluetooth: Add device 13d3:3572 IMC Networks Bluetooth Radio
    https://git.kernel.org/bluetooth/bluetooth-next/c/8f0ca5ae0b42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


