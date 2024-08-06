Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF10173320;
	Tue,  6 Aug 2024 20:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976141; cv=none; b=qeGsvAp6AnYTTFzRNJKVv7SNu07FqzSHCmlB9ExXgiEwtOlRvDBvaCKMGGSl0iOBPREOXHGsL7euM334rU+rYGKsz5xvsl4sHAdBG4biZ2FGtMby3/3mjo2dAgZxqzrjdAPmT22jCA1daQ3SvFI+CWKfhJ8UcD4uCOui5kV699E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976141; c=relaxed/simple;
	bh=FZoUlgEi7TQjc/rGaTa2w5yicNDrDb5G52CLp1jSvXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JFTOt/Gwc/LaItGJEueQ7DAKP3asypqb2Lg7TP8HjQX6oHQ9hgrsN0lHAgFbpect9ZYImatwbrMHHVGSGPTmcJU3wnwGBcr4JyWCW6nBIjabxbSh5B1Zrdz2YUxq+41idFlEpb+D1hRohTQUruZWUs/hkJ29/gXb4iJTrlRNYZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRg07HPh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRg07HPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2786C4AF0F;
	Tue,  6 Aug 2024 20:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976140;
	bh=FZoUlgEi7TQjc/rGaTa2w5yicNDrDb5G52CLp1jSvXM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GRg07HPhYyFhGm1Ul/pstYS9bXroYNgqIWLMyJ4uyuLpEwCAufabaXRMwFu9dpffd
	 0q9AxPIAbhENB/fM9+6uBTivAdfu7HHiOYNWrIPfnxzVb4dttx4bQFWNeOxrzxauuH
	 0HtWC4EeObtnlR4SLkd4birChU/80dxJR1uoM6YuFVPQh7ceoROro1Z6ew/EprD/2A
	 lH+8rwfLogOM5WWAxe+ztb07SeiJxHGslXiO0kGwo6X1i8jhsAQFomqx4fhPyUfKCB
	 UB+imJztpuMySeqGWzJaW2DQ3fBu/BC74WiKeoAzAGjsHqPTw15Q1mG1ruEh4mRB5T
	 Bm4ElBV33BHGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE21039EF94A;
	Tue,  6 Aug 2024 20:29:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] Bluetooth: btusb: Add MediaTek MT7925-B22M support ID
 0x13d3:0x3604
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172297613929.1692635.4928483453574929041.git-patchwork-notify@kernel.org>
Date: Tue, 06 Aug 2024 20:28:59 +0000
References: <20240730220824.224298-3-bearodark@gmail.com>
In-Reply-To: <20240730220824.224298-3-bearodark@gmail.com>
To: Alex Hall <bearodark@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Jul 2024 15:08:25 -0700 you wrote:
> This patch fixes bluetooth support on the MediaTek MT7925 WiFi 7 +
> BT 5.3 M.2 chipset that I purchased from aliexpress (and which
> arrived today). The PCB states that it is an MT7925B22M.
> 
> Device from /sys/kernel/debug/usb/devices:
> 
> T:  Bus=03 Lev=02 Prnt=03 Port=02 Cnt=01 Dev#=  4 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3604 Rev= 1.00
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
  - [v5] Bluetooth: btusb: Add MediaTek MT7925-B22M support ID 0x13d3:0x3604
    https://git.kernel.org/bluetooth/bluetooth-next/c/bd0b4dae74b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


