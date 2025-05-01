Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3455215191;
	Thu,  1 May 2025 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126589; cv=none; b=myiPfMQEUs9ZW3gYyLK++rtjYa1rNdfq9N0F06hD0Wr1sDq98/E5zwo9hH66ggsxo039NJDVpN+n8n10GHQutvrlfPY87BadKDI6nkHcJIstIanDpeibmRC+Q2JBBgAp7ZosR1st3E+DCfphNwnOPhA99yqk455s1YakXYTmZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126589; c=relaxed/simple;
	bh=w5oQGsL5WVbxAnOLzbr4QxMJ0KAY+AvOJhyFU9NztRs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QhBaMPBCE7DjVA1ckHE+jMzTv3ScYg3L5KhVOtJBXnsU/1W/qQ5+hjC71mmEtvWpIL39Z/iJ11u/qXjThiH834Qj3+TJChwMTOZYzlpjQFJhEKWUU+ruTmxjtpsC2V4Nx7oC7sEYgd0YUecwaOVYIM6L3iA/CxUkL6nmMIEI8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV04T+3Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV04T+3Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3F8C4CEE3;
	Thu,  1 May 2025 19:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126589;
	bh=w5oQGsL5WVbxAnOLzbr4QxMJ0KAY+AvOJhyFU9NztRs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TV04T+3ZCAfB/UqTFExArQJ7o8xyrRomHxpy8WMkw5I7VbO9aBYp4SRpRSvZBfr9r
	 cAqR8IdWhQ1oywXI0Bb/EXZFVijKhnbglCiFAmKz4JJeOnO/Z/qfyLScOZfJtf1+HW
	 jCRUohUUx3dtzbJ0dR0iy+PY09slNgGdSpOtsMzpoEC78Ocf/GqTQTDYzljBfWaAJJ
	 CRdllFluIyFSZ0rKK8YICn2V/gJymgUNVwFbYve7ucHu4spzpmqutOp9l5eamTbVU0
	 NtsG902OSLPY6EoodGMzOAhX7Z+5BG57AglvkjETPJR3wKa1MuBj13vZVsuL8znq97
	 34Tp75blb+bVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BD13822D59;
	Thu,  1 May 2025 19:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btusb: Add new VID/PID 13d3/3630 for MT7925
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174612662826.3052720.2548130502833643921.git-patchwork-notify@kernel.org>
Date: Thu, 01 May 2025 19:10:28 +0000
References: <20250429101605.2862004-1-jiande.lu@mediatek.com>
In-Reply-To: <20250429101605.2862004-1-jiande.lu@mediatek.com>
To: Jiande Lu <jiande.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, chris.lu@mediatek.com, will-cy.lee@mediatek.com,
 ss.wu@mediatek.com, steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Apr 2025 18:16:05 +0800 you wrote:
> Add VID 13d3 & PID 3630 for MediaTek MT7925 USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> T:  Bus=07 Lev=01 Prnt=01 Port=10 Cnt=02 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3630 Rev= 1.00
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
  - [v1] Bluetooth: btusb: Add new VID/PID 13d3/3630 for MT7925
    https://git.kernel.org/bluetooth/bluetooth-next/c/c03e896217f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


