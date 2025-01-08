Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39021FF1AC;
	Wed,  8 Jan 2025 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352615; cv=none; b=UULCHxrM2dD2llTMI7vlh+L2E4H5z+/6P2/8QnoQ1M91D6atFW5DhvY8B/gLvRI8aFel1ovd6o9kySmQDkeyHmDCWT1B/vw7lpmTam0LIeG/SnEoD4DmpuKmcUZdUlNDVi7NYdoWlKY1OfK4cHxr4PHZGAE76/6p9o2xaJJfems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352615; c=relaxed/simple;
	bh=6asiGBuEpRAem8Tr2mFt3guSmqHe3/2V2m68uF1082I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eBucNfLaUKLeD1gYwDNKQP8iPR9mBQ4VluqbVxA1vrwWmURWqt8BKi720nCBPIuewkaoEh6j26cM9Dt/ProB4xbIHivvZWgZa+uWftdapXCOYVD3cst95MqiVjE5P6ITPAjU86uQjPPdsK6+1T4rJF1gD35kSU/frRN5GfZecjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKSAYFOI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKSAYFOI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCE3C4CED3;
	Wed,  8 Jan 2025 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736352615;
	bh=6asiGBuEpRAem8Tr2mFt3guSmqHe3/2V2m68uF1082I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VKSAYFOInAIhZVsxmkPX2g8Se8mMI6tujY9DplaAOQ+4m6tLBi8bWzCdMiH+sgY8/
	 eWQngFWYVLSe3rENqShXxU9fdpKt2JIFpLjHNMHHcwzaqEeDGbKkAOUpahxC1hPfNZ
	 bkQdhhBlKrDkyIrHcqXOPVTCXTu9tFxnJvTYRKT99GoqRu9QkBdG114qw/RvmBi4GR
	 mnkv7So5pQj0QQZe7rg3XUHXcXmChDyMTi9xavFyh0gqOQadTrsEyomDFZBE9+Ignu
	 B/x7nhofFfiG7cg4virY8+c4sNAPqrraGaLhGRhZjG/V4VpG3+ZyNOIt54JCD2wcV2
	 V4JYPCN8rq0Nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F32380A965;
	Wed,  8 Jan 2025 16:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add new VID/PID 13d3/3628 for MT7925
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173635263698.697160.15088028616752528689.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 16:10:36 +0000
References: <20241224063522.82004-1-en-wei.wu@canonical.com>
In-Reply-To: <20241224063522.82004-1-en-wei.wu@canonical.com>
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Dec 2024 14:35:22 +0800 you wrote:
> Add VID 13d3 & PID 3628 for MediaTek MT7925 USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=03 Dev#=  4 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3628 Rev= 1.00
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
  - Bluetooth: btusb: Add new VID/PID 13d3/3628 for MT7925
    https://git.kernel.org/bluetooth/bluetooth-next/c/f597b8982d51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


