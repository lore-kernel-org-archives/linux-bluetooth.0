Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE22224AFC
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jan 2025 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439400; cv=none; b=e5jxnyQomvG1hrARcu2Unq2DrDA0QVFCpnorD3udp19fk9IzV9skHanegz3XVF5+Sw69qWZyQPnp4WCNBrs41MOaY/TOXv68fEovmnRb54MDBHcOGju7GoHDGs8WL7tXwoXSIIBymPS5Vec4YxJkHIqY6TGCB5f4ZSm9xvVCCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439400; c=relaxed/simple;
	bh=VjEA4Ec4to+aazVoeIE0b7tsZmvFFPOShG3djaCtS4k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GylYUR+Qu/TGNSIj+99Oe2UZzJ4scmve6LLqXP6JOGQFJ+gu45ZrDQHOKLzbgdIDxTW6Pg1i4Ur1eM+BHwHBMJwzNVIKJSuW5ZyiEri7qDDbwLu+/rM7xSCiGZakH01ZaO9FTk+/BqpVkO9928ksFDhn79OfEe7CHC8PD+5NdMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+8u25jc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+8u25jc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50DAC4CED2;
	Thu,  9 Jan 2025 16:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439399;
	bh=VjEA4Ec4to+aazVoeIE0b7tsZmvFFPOShG3djaCtS4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s+8u25jcF7585XmpwnbepDq7wU1JJ/V1sM594SO/IvN0qvuuHm2SN504ohv+vQoBu
	 VhSEdgbo3A3tDMyMEeXGZ563mdajhxhVtZccKy5fNTozCYDFPvQ3yK7Uxk8KYabNRV
	 yISH7p6Rsm6GCzujnklwDHobCYu9wv2dI7TFGJENKfeCOftMJ8i7giPQkdVtTYWLos
	 Vu4t4Zyd7tW0lIC0BKHZP67VKTxMVuOPUghcbQafOEwitftVNzTZ7NpGQTf/k1KIeO
	 SUAJ6RiSmBkrG0u2QRSdWVjZ1e2xl22nzXVqM+4eS7s3C7vwxioGQ4R+uQxnx8crp5
	 JnsXuGatGHn7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE100380A97D;
	Thu,  9 Jan 2025 16:17:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add MT7921e device 13d3:3576
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173643942124.1375203.6642647476579278683.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 16:17:01 +0000
References: <20250108200140.29719-1-tcrawford@system76.com>
In-Reply-To: <20250108200140.29719-1-tcrawford@system76.com>
To: Tim Crawford <tcrawford@system76.com>
Cc: linux-bluetooth@vger.kernel.org, productdev@system76.com,
 garrett@system76.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  8 Jan 2025 13:01:40 -0700 you wrote:
> From: Garrett Wilke <garrett@system76.com>
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=03 Dev#=  4 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3576 Rev= 1.00
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
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
> I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add MT7921e device 13d3:3576
    https://git.kernel.org/bluetooth/bluetooth-next/c/2c925c3ae55b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


