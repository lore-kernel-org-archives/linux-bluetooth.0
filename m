Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD971C8FD6;
	Tue,  1 Oct 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796033; cv=none; b=dz5ZzLS5PtJ7zfo56FlsKPdko8EyeBQWkRcjyTQofitGTAs1XFDQK1G6BTGoIgmPfDwlGCRRC1+5dp+WMEPYGmLKodtlxplL+B7zwZMyeqdZendMIugnTY3nYM8F6ig5q/Hpune3CdFCsjXUjGG4plE3BMAz7t+SZI56EZPoByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796033; c=relaxed/simple;
	bh=5oquNB0X9zIl9l8GLFXqd/pyvhFwFXcOnUGPDhdL8T4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JFw8pxy4/Furm3g6Acn0eEfPcWmP7taRXubYOVPGF2tdkuVpX9v+wJH3YZ2TtNdhe+r5fujugnQeptkntzOEb4ZNVNhZFqFdZG7CAEuDhslvN25KARyfR3HNauDW8j0vwb9XkBDOh8RwIFIL/qDpycOpbQoCr3uykAesVtJ5Qws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDS7WYob; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDS7WYob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E70C4CEC6;
	Tue,  1 Oct 2024 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727796032;
	bh=5oquNB0X9zIl9l8GLFXqd/pyvhFwFXcOnUGPDhdL8T4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uDS7WYobpXGCRqTcqO/ymiNiUlqfjwOFbTfTP+ooAWqJyCdxRA4C3uGrwFwbm376H
	 EGTtoBXQaXBmpLfWA39gjNprKIQMYUbp7QnbGm26Ri9SwuHrIAoK78t+uw6fMYwNHQ
	 g4SqrJlXkG9Wi2WkvhFMoJ2ClKlyJNFHamhgD9J5SFfyA0xjkFE9SmcTKuwZQsB2/w
	 nQ1lsyALi19tHkMFMyl/CnWlWIkyz8pchSjlNM54jV2YtCXc6DEmjPztwKdXG6Swbu
	 zveKUZn6nciM0qOYh5WXxBlX5RrMsxv9Q7fKA/Mbe1O1Aon3w0YyjFxmdxY3zjUXWL
	 AWt8H8FfmfoQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F83380DBF7;
	Tue,  1 Oct 2024 15:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V1 RESEND] Bluetooth: btusb: Add RTL8852BE device 0489:e123 to
 device tables
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172779603574.424883.13664449790396657733.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 15:20:35 +0000
References: <20241001083729.1162206-1-hildawu@realtek.com>
In-Reply-To: <20241001083729.1162206-1-hildawu@realtek.com>
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex_lu@realsil.com.cn, max.chou@realtek.com, kidman@realtek.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 1 Oct 2024 16:37:29 +0800 you wrote:
> Add the support ID 0489:e123 to usb_device_id table for
> Realtek RTL8852B chip.
> 
> The device info from /sys/kernel/debug/usb/devices as below.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=07 Cnt=04 Dev#=  7 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e123 Rev= 0.00
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
> 
> [...]

Here is the summary with links:
  - [V1,RESEND] Bluetooth: btusb: Add RTL8852BE device 0489:e123 to device tables
    https://git.kernel.org/bluetooth/bluetooth-next/c/1a4744e3dbc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


