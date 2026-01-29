Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1602E9748;
	Thu, 29 Jan 2026 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710811; cv=none; b=ozR6lmukROw77I/3KHG8syAArXSeSBYfdN8oGEXB1E84ewCghhinkl7Pp8YU2BLbXNtaAMfBWDREJBapNtfqBEXmv9CksWRJCey93DvgDoyuI5HoYGZ6DsxbS5TCr4m4PO/M/ig4rHlmmQ9pug7h0wouC9Wcjnrk80z6cbI77X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710811; c=relaxed/simple;
	bh=nu6Psmus/zs940W7BZv2wFjzqrKmHw9sje6imO8sgm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TD8i137R/CQ2TTjYuNwkt9jdAEH+fm0/TsVZGzvev4cJRm0qFxD5lnojYt7NGQV3s7dA1XQ9+PoaqFNLIoMhRdm4CfdRkDcq0mJzY6SCEO/efuwVRGir9QFlnTjeQGvgqfE8brKP0M/YN/AN6SuTy1YCoqsBMlQF67CM64KBcMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScCWEDNg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScCWEDNg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7116AC4CEF7;
	Thu, 29 Jan 2026 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769710811;
	bh=nu6Psmus/zs940W7BZv2wFjzqrKmHw9sje6imO8sgm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ScCWEDNg4Z0UhDZjAT+dbdqY7KhEqaqjkPjydJr0LXVtVjZ9Gzz4yIs7MHgeCDnnI
	 maUUzj1y5emYI02Zxlwm2FnWeLUgfa7sKbfpplQVnAyH8Po018u6ASCX/gAtys9G2/
	 Zl/8LtMZqR3jrS0i44RH5B4F4KOGuTnNTCAFoqZElRUuiS9ShZCi3Eu4zZuKxZTMB3
	 AWgriO3kMjtzNaKp0GVFcCcUwvfyeoUHCzgVqyS7SS6ZFXB1tpzYBXHBPxYgkYkswR
	 6dUqf6TseuXOrFPdWeIW1lew4zgpavf3GQLv2GHEi7jOr6kgFqNIQlTYOoE7l/3VE6
	 dF5Xsu4us1UQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBBF380CED4;
	Thu, 29 Jan 2026 18:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add USB ID 7392:e611 for Edimax
 EW-7611UXB
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176971080436.2988967.17049686908610022835.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 18:20:04 +0000
References: <20260129022819.61290-1-zenmchen@gmail.com>
In-Reply-To: <20260129022819.61290-1-zenmchen@gmail.com>
To: Zenm Chen <zenmchen@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 pkshih@realtek.com, max.chou@realtek.com, hildawu@realtek.com,
 rtl8821cerfe2@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Jan 2026 10:28:19 +0800 you wrote:
> Add USB ID 7392:e611 for Edimax EW-7611UXB which is RTL8851BU-based
> Wi-Fi + Bluetooth adapter.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below:
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  6 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=7392 ProdID=e611 Rev= 0.00
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
> I:* If#= 2 Alt= 0 #EPs= 8 Cls=ff(vend.) Sub=ff Prot=ff Driver=rtw89_8851bu_git
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
  - Bluetooth: btusb: Add USB ID 7392:e611 for Edimax EW-7611UXB
    https://git.kernel.org/bluetooth/bluetooth-next/c/12e51dc3bb68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


