Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72CD224AF6
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jan 2025 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439402; cv=none; b=I/j0wQrs4I6AP02LywWIMHkKYZ505q2kNEwiTyGA7cXXT095cSfjQp9vpbtOG53luc1TZ38k5mtATNCBKXcCpx5OOW4myOyaDOev1rd/BjvdKCFXLHkW77jfHq/2QN8Exr4nbrUcqOto1IL9W9hsPwOP4wKOvsMeMXhYJLSj7p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439402; c=relaxed/simple;
	bh=JbIAz6PpeduGJqIcwW4ejAAg4Hxn8RhzSrtUNQb8zws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uulKwksDb6BfnQVhx3Lc12wTDsiaylQbdfnRQK+5fbt6NTw1+JPrOdlOx2cMZQ2WdHgIqXz+HTUk3JhB1VeE1oplEGAF5nhXUadKeUG4NBevbXTblNTiMZCAzyVhoX3C4S2he8fLV++FlUCb3cnr9uXazGzaXD/FUBWmu+zP+sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/Nxy12Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/Nxy12Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6A0C4CED3;
	Thu,  9 Jan 2025 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439401;
	bh=JbIAz6PpeduGJqIcwW4ejAAg4Hxn8RhzSrtUNQb8zws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B/Nxy12YX2YBHl+VtcFpHLx3yz6kvuNVd0fPyq6ecrBU0uY2I2MVjrkg2Dk1an5Xq
	 2866sk23wMm2Iral1Z40MEm5ZUTZTWLqoAQ+Pmo2nvEPj04TFOnarxzpm0HpQtYO/Y
	 hbtwTNiXDEKJ4t323JEeO+whMS6+pNeE8WtuS/xEZfZEnxQFO9oRILGE/9fSmtecGV
	 aBrXcK0lLyJUCvDjR8xPzGTvtXRgn1gyDPJDyCszlug91mvXLRoH4GzBn7sRtDr/2/
	 70T3JxusTnjEoVP5nm0x8UVLgRgz/0EygiXjHAaubQmPjRVxOUzyJhPhmwLYKQBboS
	 QaVkPSiuejBjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E8B380A97D;
	Thu,  9 Jan 2025 16:17:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Add RTL8851BE device 13d3:3600
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173643942274.1375203.8928448996857563714.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 16:17:02 +0000
References: <20250108182213.23326-1-tcrawford@system76.com>
In-Reply-To: <20250108182213.23326-1-tcrawford@system76.com>
To: Tim Crawford <tcrawford@system76.com>
Cc: linux-bluetooth@vger.kernel.org, productdev@system76.com,
 garrett@system76.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  8 Jan 2025 11:22:13 -0700 you wrote:
> From: Garrett Wilke <garrett@system76.com>
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> T:  Bus=07 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3600 Rev= 0.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00e04c000001
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
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Add RTL8851BE device 13d3:3600
    https://git.kernel.org/bluetooth/bluetooth-next/c/4801a84ea658

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


