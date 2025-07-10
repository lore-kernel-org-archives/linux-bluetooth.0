Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F8264FB3;
	Thu, 10 Jul 2025 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168743; cv=none; b=pnSFjM/3ksbiWwhv6BH4EuFd4/sk32dGEdvyc1oNeAQ1T9TfHeDNyuhKryLC/4csE0Bd+m2zBN8dzxpkcRqIMz2UjBROUhx+GJSFm0nKabWylEmmLscSxbZiVWjTLvCP0NBfokQLtGlHboAdSTJMyF3BiOUW08sbpzbJycLlMaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168743; c=relaxed/simple;
	bh=c7oheQVC5hWj6OnaZx2PsISt0VpYPnvy54JLInoA3eY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WXnt0YQmkSVmd3CsZvEbc3OAi28NFzNvIZpccX7lmft38TIBmtLb9pZyE5l7jlERGy6bs8HFshYZfl79F2+n0hJ+YctwB650zWIeQFg7LQPkmBkn+kAFf964KudnKcyrm6xmP/xZGfuKoHXxqPD0gL/kkRcEYFcv/8T5kOQYPT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4npnKFz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4npnKFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40E1C4CEE3;
	Thu, 10 Jul 2025 17:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752168742;
	bh=c7oheQVC5hWj6OnaZx2PsISt0VpYPnvy54JLInoA3eY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i4npnKFzOrjsll5Je1eMWMP193e/K/XbrTKUQEf/dd7VDm93AEWAFp8C29oqr68La
	 cx6WE3rCgEAI93fwxC0ZB+L4tVFOJS4FhKKo0lMVygb63s/PHr25DQoHj9wcFMttkO
	 bnyj5gGCw7KV1CIZFCwJgA/wxQdHhrnUH42/BhnyhN+wMcquFOj1HyVcrdn6SndfsN
	 RgydcXHwpNFLOP+BNA3BXsztgWiPKD7GB7Saw7jF94knyXFlMr+Ifexntg+jkeFGqK
	 lignNgAQgXfJ0n8PhLafLYzjFI7s5hvrzS1FRqF7wHsOPa26bXBBfKHOk1MclPz2Jz
	 eD801fdsAHJEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E81383B266;
	Thu, 10 Jul 2025 17:32:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] Bluetooth: btusb: Add new VID/PID 0489/e14e for
 MT7925
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175216876500.1607762.391638520128748254.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 17:32:45 +0000
References: <20250709063606.25806-1-en-wei.wu@canonical.com>
In-Reply-To: <20250709063606.25806-1-en-wei.wu@canonical.com>
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 cegolf@ugholf.net

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  9 Jul 2025 14:36:06 +0800 you wrote:
> Add VID 0489 & PID e14e for MediaTek MT7925 USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=03 Dev#=  4 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e14e Rev= 1.00
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
  - [RESEND] Bluetooth: btusb: Add new VID/PID 0489/e14e for MT7925
    https://git.kernel.org/bluetooth/bluetooth-next/c/5ad198510b20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


