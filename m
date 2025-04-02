Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21191F3BBF;
	Wed,  2 Apr 2025 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628204; cv=none; b=NnvhVLdCKQXNZGc30kRBnDEQpu/GF4+PHnNJIzbpcLh8TJzvGv75WPJrNiO5IaXgVcD2hqAXonjpbbKZPCKbDlcFTHaV2YQ5zIrINAj3V6Spl70XG9IW7MS4kKaPKEC/+WaHqGO0FOKXvMXqojiLUmUl/Ltbc1J39G7fcH6odkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628204; c=relaxed/simple;
	bh=FBNTlGNNsRm01fVfSRNG6bUBmnCrE7gjx+gJO/WY9pY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K70mTxkrAa1U1GQrHU66hC3ohveWMGeVJuOWBrzkr8QsVhZ799BTgGxw820FnkXo/jx/yaA1DFGqTnc4J9Kc1zwVeB8sQ1nRL+oaaZYAW3ertB3vNlncNnhxvL5z/5hBiIZp89tKGofF+rtXcAwnqDvQgQQoi+q12cbxwGQy0pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWq1gLoE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWq1gLoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EA9C4CEDD;
	Wed,  2 Apr 2025 21:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743628204;
	bh=FBNTlGNNsRm01fVfSRNG6bUBmnCrE7gjx+gJO/WY9pY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mWq1gLoEsSJc2bCa0FBlL1cHu+nuzJ46OPEZt7R8d5KEjGXCIVO1FzQ5ywH2E3sUs
	 pOG5MGWp5FljvvXKvpLW3DsWNgISHpfnjN+AeJ7oIPlt8lBFinatRGRTHj82GxOW7V
	 towTAm8idpRAMZBjuAEZmdW0G4PcrYB1kwRcLjB32Ny64idbwK2y284/uE6qOAkyMt
	 uoFGJHERvvbsRrz1rH5TNbpLcI2HBVYRNVfGDkCHzSU9uKsVI7aA2jVCSIulPrck2p
	 /SpRl0MTQnxUi3UH2WULlRTqzVbV8PEUEM3vJ9LTmQhNcL+YpxMo5b17rv6qF5pwZc
	 Wp/SH59G/GVqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341DB380665A;
	Wed,  2 Apr 2025 21:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add new VID/PID 13d3/3613 for MT7925
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174362824074.1678044.1440179296394282108.git-patchwork-notify@kernel.org>
Date: Wed, 02 Apr 2025 21:10:40 +0000
References: <TV5EwAth53CPjyEfnDT-hesfQb45wew-qCxhVuZeUL6oUcviiJ9nz83ctko6izmh6X1-O0pphWqltS2XToK2Pj2skYkWLPJ5a210TtQbYJ8=@melois.dev>
In-Reply-To: <TV5EwAth53CPjyEfnDT-hesfQb45wew-qCxhVuZeUL6oUcviiJ9nz83ctko6izmh6X1-O0pphWqltS2XToK2Pj2skYkWLPJ5a210TtQbYJ8=@melois.dev>
To: =?utf-8?b?WW91biBNw4lMT0lTIDx5b3VuQG1lbG9pcy5kZXY+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 01 Apr 2025 12:24:35 +0000 you wrote:
> Add VID 13d3 & PID 3613 for MediaTek MT7925 USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#=  4 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3613 Rev= 1.00
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
  - Bluetooth: btusb: Add new VID/PID 13d3/3613 for MT7925
    https://git.kernel.org/bluetooth/bluetooth-next/c/faf3e02d3240

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


