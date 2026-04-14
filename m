Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA91377563;
	Tue, 14 Apr 2026 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776200436; cv=none; b=T1IbUq6QXNSNzcSfh9HeFXPlzNBcy4cBApQIQlr7RsTqfuGbU1brzZxoI7a9b0tgkyrEHNKzRdVxJHF2V34IEMQ7UHdpkPcC7IGLT6d5J1Vba7v8uEdkcXEtWvijb0ApzNGdx7uzazLNNMW6Ad5ajfG4gRVeBS04xb4kVbjIsbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776200436; c=relaxed/simple;
	bh=6g0P2jYp8BQllTknzWCy2u2MiitXnxdF1aRmQTkSYwY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CnAwxZpL/UF18FLjPa0UVorbV6q8ggnDD1GWw2OSdiWEZM3/uHyZBtf3h25cboUrQi4/O0TJHUWNQ78xKSC0TceG30F53U1+KwLwPjyqNCuEGgrVnWc33uLwnxJ5TR0ZsPp4l2zqXB/Xx1ty4X3shfS3tPcMX+RyThGTiw5PqBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNzjAUC1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNzjAUC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3942CC19425;
	Tue, 14 Apr 2026 21:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776200436;
	bh=6g0P2jYp8BQllTknzWCy2u2MiitXnxdF1aRmQTkSYwY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hNzjAUC1k9twayaWsqA1yGROCWWm1dKcZXT2rkzaPHiG/KmiqPwBiLPWMhZ4ThJFg
	 QOTrA3IxSQv3QyQKOWkZ+fTkuJoNP0T56GeK3sldx4zXRqShTyIT9xQu6iuUkuTIdA
	 u+jlORyw8N+QzxkJei+IiGQwCs0S0oEpxaVK4hdMvNzqUbQe5q5I+4gm7AD2DR93NS
	 BBd3fdwNYiB+gLGcpp5O4g0s7KEb2g1XGjme8yFNKhMCdqWkRUhRjzJbAhmE/6HMoV
	 le2XjC4f0/f2SMpQi5f/yKnz7eu/D1bEz8K1i58ZGsmAjCllr4iR/evUKL0fNjgefg
	 mJRWJuBMJ8oKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2323809A0D;
	Tue, 14 Apr 2026 21:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v1] Bluetooth: btusb: MT7925: Add VID/PID 0e8d/8c38
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177620040629.1468596.9025066166850277075.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 21:00:06 +0000
References: <20260407065110.3037135-1-chris.lu@mediatek.com>
In-Reply-To: <20260407065110.3037135-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, will-cy.Lee@mediatek.com, ss.wu@mediatek.com,
 steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 7 Apr 2026 14:51:10 +0800 you wrote:
> Add VID 0e8d & PID 8c38 for MediaTek MT7925 USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> T:  Bus=06 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0e8d ProdID=8c38 Rev= 1.00
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
  - [RESEND,v1] Bluetooth: btusb: MT7925: Add VID/PID 0e8d/8c38
    https://git.kernel.org/bluetooth/bluetooth-next/c/41388deeb990

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


