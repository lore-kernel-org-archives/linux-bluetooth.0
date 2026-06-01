Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23337D11C
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341009; cv=none; b=WEKtxIAMnV+unLHjEbSX9WFlxQ3QdHvqNYAx9Z/9l5m2duSVMwhO7mZT/b1M2H/KQZPZFHPV20hAMHR+DLbYltDdV/ZLRF7sCAsEQL7N65OMxHBi7u5l6ra1syXZYQcoQpUtDRazv7GfVBF8BlHeBCps/+4dNayFihY754d870Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341009; c=relaxed/simple;
	bh=pihmTcIKj0pRmCEZ8nYbJx7tZAW+ZJ+0CPCFXPBSE0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nEGfn+C/fYez4wMkHNN4eMKCOY/6Jy4neHj1/vTZpAYl3dQmvQ2DaJVWDQVVwXQ9K8VZtygQ/MTShP5GuwnUlYHy9FEqjRb1ck93WANqLDkuv1MxehMRa5N308KcA02hhazZQBioEdw72md1gsyqaMJk8jpjITM2we64LszuD1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2PYwqdM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2PYwqdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F661F00893;
	Mon,  1 Jun 2026 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780341007;
	bh=lE40VMULsfWhGIyZlG7j7YDdO/+e2LqhvTDaQCM9R+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L2PYwqdMdEr89OogCjpIwegySR/6nWTlp4QYmfFcpYNEorEvFiVeycF9b4s7wDwYL
	 +eeW3RWq9vTAPiuGZZP20K0WVKi7FvpYGtuxHedCnybCpzWUNFlReJDKqdWyQkjZ7V
	 wfS4PaLqQQHkm84qbG144REVUsNRH4PnPj+GLOuPQeDQjhyXpQxhoKW29EM7V4V3uk
	 8DWXGcn40DNKuxxFCYqt6l2xwjctyfHsIHJlLeCXTekR8C/bYFc7m4dYrF9+K/ur3z
	 +/rdABXHr4l6Zltwa/eR21+y0PdQz3lDiQEtVvma/s91URmmMAOJ1b2cfA88wdEFv8
	 U5YSJMvMZk78Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5682038119F4;
	Mon,  1 Jun 2026 19:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btusb: Add TP-Link UB600 for Realtek
 8761BUV
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178034100989.57646.131798545923088031.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jun 2026 19:10:09 +0000
References: <20260530123934.4583-1-nils.helmig@web.de>
In-Reply-To: <20260530123934.4583-1-nils.helmig@web.de>
To: Nils Helmig <nils.helmig@web.de>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 30 May 2026 14:39:34 +0200 you wrote:
> Add the vendor/product ID (0x37ad, 0x0600) to usb_device_id table
> for Realtek 8761BUV.
> 
> The device info from /sys/kernel/debug/usb/devices as below.
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  4 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=37ad ProdID=0600 Rev= 2.00
> S:  Manufacturer=
> S:  Product=TP-Link Bluetooth USB Adapter
> S:  SerialNumber=ACA7F14FD2A5
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
  - [v3] Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV
    https://git.kernel.org/bluetooth/bluetooth-next/c/b2aa1661149c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


