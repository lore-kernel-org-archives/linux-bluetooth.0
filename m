Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BC7410D37;
	Tue, 26 May 2026 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817812; cv=none; b=A+LGtTx+6VJJ0Jlva7vZzdxu4VkoFYpx1D1q2z9IrxIqdGXB3ZC2ISKONTIcXKBoCWMTCVs7x2ODU08fQJL/w7Sb+bncmHhUC6kTRZpPll1HTcZscBane26GkuYgkgFZ/yXyrrD+7D62jfN/G/xtRHSwDom5GSwqvB+GHQYHMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817812; c=relaxed/simple;
	bh=griJzk4Wkl97TCBWd0EcpJ87v0rNihzy6DXUtza/P1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LMqnQX2cqWyh4SVh3Qbzz3JNtKBtfhMUUdqiUgJxqtp0YTbD8xFba/F145HNSM3qR4V4kLMdvPPFkdDl+WhSMVxo4/7R4Ut6ZAg6k6gyfov17S6r1lTfgGlJDgcrw89lqKPMtSZ0FLCNUDbeos2w06JlOvpCf9/sdyKkEcWb0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq+qe9if; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq+qe9if"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6C71F000E9;
	Tue, 26 May 2026 17:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779817811;
	bh=Xe0CEMUR+DzmlkGQTQEz+v3IBLqXQklj0HlrURYU8bU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yq+qe9ifeSkxJzlf0krrKJX2Ds2ijTYQ9Yt54OVyIm7TvsqIQeXZrFAX2DA45hh4h
	 2JjmxKpLf1t9WDUvcRO0zkuMgRKf3l2Z0hBnpEWYr9ct66r41L81CC/oge17egsLfd
	 TYZnPpSMpF6ixSuVHBznachN80eoyHm/GtctZVhnsxo7bAeglhJuhsyZ02M087ReVe
	 KzkSWgIlMsthXc3+SmJ87agzk53BPI8Zbs43zNDnJZ0G8B7B/dbVkLsegwblE57krb
	 xwWbItEeHBFQgO5SeyPgr6D43usSKJkzkjnGUw9Za+OOn0tYS3WdIHcrDLzJkRYekP
	 f4mDPVKHZHa/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AF8380CEE6;
	Tue, 26 May 2026 17:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add USB ID 2c4e:0128 for Mercusys
 MA60XNB
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177981781684.3917724.4396187093136502203.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 17:50:16 +0000
References: <20260525161942.5206-1-zenmchen@gmail.com>
In-Reply-To: <20260525161942.5206-1-zenmchen@gmail.com>
To: Zenm Chen <zenmchen@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 pkshih@realtek.com, max.chou@realtek.com, hildawu@realtek.com,
 rtl8821cerfe2@gmail.com, guillem@gservera.com, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 May 2026 00:19:42 +0800 you wrote:
> Add USB ID 2c4e:0128 for Mercusys MA60XNB, an RTL8851BU-based
> Wi-Fi + Bluetooth adapter.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below:
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2c4e ProdID=0128 Rev= 0.00
> S:  Manufacturer=Realtek
> S:  Product=802.11ax WLAN Adapter
> S:  SerialNumber=00e04c000001
> C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=500mA
> A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
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
> I:* If#= 2 Alt= 0 #EPs= 8 Cls=ff(vend.) Sub=ff Prot=ff Driver=rtw89_8851bu
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=0b(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=0c(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add USB ID 2c4e:0128 for Mercusys MA60XNB
    https://git.kernel.org/bluetooth/bluetooth-next/c/29289e705913

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


