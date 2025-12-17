Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC062D5410;
	Wed, 17 Dec 2025 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766008396; cv=none; b=FmyIePp4EYB+OGjR8hWu9NzhVMv7OVL2JEw7vFXOWVB0z2FIuECGUDqi+Vfy0SCjmYbdxrGm7QV1x32Xvsvc6X2oOezp7ErFcuM+fKmBfVmVpWwJTeTXuIa6XSnNaVtuc3v6tbyrWe+mPuqZgELrFTMvovfylDURCn5+Yo01dR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766008396; c=relaxed/simple;
	bh=2YyjBI1L1UGkKsINAWOdv+Yh+rJ0NYTlxw/F1vGoeSg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pG81QVhjKZHHdbDsXq9eXa/Aunx+KtLm66ayDSbvXpRHfwaF1vES1bS8fG2YIvgMPeRBM+GLbpkSZyGdfx9vhK3oa5XhWiPUsu2KPZNRPYQOtpuRmqd8WMDqLOznVFz3jcvuldXLiS6jaaGmHOh7T+1wEYg0VeZlOX4fUMXxtmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn7LqRmC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn7LqRmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24550C4CEF5;
	Wed, 17 Dec 2025 21:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766008396;
	bh=2YyjBI1L1UGkKsINAWOdv+Yh+rJ0NYTlxw/F1vGoeSg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fn7LqRmCD1M2A5tqhRCC0nIoQebsZwaITc+PuRoJBry8HaHQ43k1FpUPSr+qW7Qk2
	 P2LZC8KwGsZbQn9eORdUowY4xXtmo/qTSHSAzvMkI4cV0u2f5znjZ5iExQcf+MZOqE
	 TO8M7wu2EYy4aK3ONFgZ7BxpRiLjdQgSskeo5DrNQPZ3orH3JpvcsIAJGpv54ZW2cR
	 5abCHwIj56M4sDqrWKQ6x90AZy1qcGEWDcNZfYnUWvCr3xWohM9g5e6SFx92E7z9Ig
	 MR1H6wae9E6jSrbeHZlyXRz2UH7pSyVrYv1/NOAfKvC04Ie3s8+hNKk810CeOsU2Vx
	 k6jU5MAvmt5eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BB993809A34;
	Wed, 17 Dec 2025 21:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add support for MediaTek7920 0489:e158
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176600820604.2253459.4940975042978079354.git-patchwork-notify@kernel.org>
Date: Wed, 17 Dec 2025 21:50:06 +0000
References: <20251210202225.135637-1-elantsew.andrew@gmail.com>
In-Reply-To: <20251210202225.135637-1-elantsew.andrew@gmail.com>
To: Bluecross <elantsew.andrew@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 Dec 2025 23:22:25 +0300 you wrote:
> Add support for MediaTek7920 0489:e158
> 
> /sys/kernel/debug/usb/devices reports for that device:
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=03 Dev#=  5 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e158 Rev= 1.00
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
  - Bluetooth: btusb: Add support for MediaTek7920 0489:e158
    https://git.kernel.org/bluetooth/bluetooth-next/c/b96a6fd8cb4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


