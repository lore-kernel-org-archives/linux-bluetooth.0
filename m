Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD5A503BC5;
	Thu,  3 Sep 2026 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465679; cv=none; b=giNuYVrCNGgv9QD1J1m24ckhWWSuyOvUdZzWmRSK4xSMRt62F95ER+I6e3M2fLpnJa8Di6bMnCmkWh/EHWbeq9UU4ZQljIOe45rMs3eZB3xDojgdl45/1OfUVVMsHJETDnUaEMCPn0wfZPHPjUHdAUkRxFC72eu1iQBYBFktqNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465679; c=relaxed/simple;
	bh=jbHQVQmBfsPu5Voa32/5goWSzWLy8R6ZNaE1JzL9vZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V+dXX9yS57UgIEBV/8Cp5hYV8fkA+vbAa4srPaLIzihLm+GFLr9nrLzavBqH9fT7+SHYrYNSknhVukj1Df8Y+nKb+M3ir2Fdl6xYPYkQb2LGbNFcZ8G9VLpwQ1NOqY8wXFFN/YKP/WdYJM0KxoQeYsf6NB8b6oflXO3kgf3/P9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZaeoxnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZaeoxnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ABC1F000E9;
	Thu,  3 Sep 2026 20:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788465667;
	bh=HrIN1g9RQWu66pARwKA+JlXyDuD58YzFwLwHxsW+xTY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NZaeoxnXbFaHdvS+hpH8Tqvk/LKCBao2RLzd2ncw2pIISfDeGQaVy54KVFHknp1fa
	 3opFzZs6ctqlQyCwox3HAMpRCG/Wm4VyNLdf/Rs3BuYWr8wCX6zaq6v7JrcwDUuWGT
	 sJ8859NGUdYL8u49Tvg1Ak6UWemwj440FBihvOoOhN9Lap5Bekp9dFWprFPkKoWRyC
	 QPwsedBuxaDmoeuJVhE2dWAXtcXJVR4srTXHidf5cHnBcUEyhauA6T0JB64I/mN0zN
	 F3ZpxpNNGEwnZEeoQ19osWYsD3oDvX3qanUsU8x6pGrxRlLuIzGa7DEpFUo3Jpy2eY
	 SycKKD6VCuP6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9395A38119DE;
	Thu,  3 Sep 2026 20:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support for Intel Otter Peak2
 (OrP2)
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178846560815.3994681.18219348101549358962.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 20:00:08 +0000
References: <20260902190037.259487-1-catherine.l@intel.com>
In-Reply-To: <20260902190037.259487-1-catherine.l@intel.com>
To: Catherine L <catherine.l@intel.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kiran.k@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  2 Sep 2026 19:00:37 +0000 you wrote:
> $ lsusb
> Bus 003 Device 003: ID 8087:0043 Intel Corp.
> 
> $ cat /sys/kernel/debug/usb/devices
> T:  Bus=03 Lev=01 Prnt=01 Port=09 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
> D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=8087 ProdID=0043 Rev= 0.00
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Add support for Intel Otter Peak2 (OrP2)
    https://git.kernel.org/bluetooth/bluetooth-next/c/fe87a0e402c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


