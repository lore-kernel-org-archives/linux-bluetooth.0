Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C59E34A781;
	Wed, 22 Oct 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141031; cv=none; b=i+fMdICEQE1IYhqFw042w0sikCemQtP/kW/WU0oy+emr1WsNm9utcLBf7GyE7OX7nrMoaM7TrDB8V/NjblLFG7SZBh7oHk9YYrRO5X0buanQxh06XhQ8G2x9Ya5InDaGMT4Jj8iGB0a3VnXX+3E6Vpc5HUCegYiEDuDYx6j//Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141031; c=relaxed/simple;
	bh=yR4QhepfDm1tpuRaTKak6V+6k9BrgzLnsAOajKYDbMw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T9elrzng944rc+jobzvN7UniBNU8+peeO0dz1vrEVRPOJjPRKnl6tpfzZTMYA8zUrnAi+QJWs1JO3vtaDME5S6douv8TSKCzgzLOX/0y9MzzY5EAGgIIFYmTeo/+q8MbESOtuxU+gxtfnOBZnDsSrtujpV4QJJJUJUq3FdIY4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcGDhePn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcGDhePn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC009C4CEF5;
	Wed, 22 Oct 2025 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761141031;
	bh=yR4QhepfDm1tpuRaTKak6V+6k9BrgzLnsAOajKYDbMw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YcGDhePnAHppfE1Kq8bxB9Ll6lwUkKSEgujxZ7U5D8kBvl7OqroqDZ6VaFVvA6nZh
	 j+y2SSHCvigKUjeqYX2aTnHuTdz+qSebSjzMobu0mvyfZbj40//ISB1llF8W8lF6uv
	 TZYVllSfsEsvoYM9zUV9OC369FDqeHLsosxxN1wFPMco3DbtJqDhCoUeKYZqm4M8NP
	 KXeWIMZBf49jOoKI+zj2mowfHNMW4ClEgygCtE8Ij/tVuV5wQ8oR3nWRw9BCblKHm2
	 Ospzup9R6vG8VxgiFSGluGaR3szk8kH7M2nmgz7j65w0AqzVpiaqyunTbLEa3tKQ74
	 7tSlv1ZWUAvzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D573A78A5D;
	Wed, 22 Oct 2025 13:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] Bluetooth: btusb: Add new VID/PID 2b89/6275 for
 RTL8761BUV
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176114101199.1909224.4793353503702509453.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 13:50:11 +0000
References: <20251006084647.19902-1-liqb365@163.com>
In-Reply-To: <20251006084647.19902-1-liqb365@163.com>
To: Chingbin Li <liqb365@163.com>
Cc: pmenzel@molgen.mpg.de, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  6 Oct 2025 16:46:47 +0800 you wrote:
> Add VID 2b89 & PID 6275 for Realtek RTL8761BUV USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  6 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2b89 ProdID=6275 Rev= 2.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00E04C239987
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
  - [1/1] Bluetooth: btusb: Add new VID/PID 2b89/6275 for RTL8761BUV
    https://git.kernel.org/bluetooth/bluetooth-next/c/1a5264d0c46e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


