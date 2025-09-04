Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6860A246BD2;
	Thu,  4 Sep 2025 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003405; cv=none; b=J5+sgNZKZCfEOJa/bOoTeFt5ZQjKKGAvUr3GBB2P3lcIDHfDoAsHf2VTUo/KRDNc+gwX40d1fQwB5gDFMsCNUfh2vGnYmkPaBeSsWV83K2lAJPIoHUeAB9aT+bkUQPfVCCACxQOzQ7jMGRmbJEAPHpr5SLOUyUMnjKj8yhhrFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003405; c=relaxed/simple;
	bh=4ehfi8+Lv59X0i+iJrRIOdokVSqi9hA1hvm7g7eoTKE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jh7NIj69jKWQbRAU/CSavB4ewV6C1pLwmgXKLnYtktXuF142G+50kIVihCNAzBLAgVn9QW0EZloCwwqosEbyO7RZewWnlaUwMkZa+TOJaQMBxEzPfUrobanQPedF2K3Fv1uw5FeLa5Zvffosmq7uYxX0Yf9hddB5Dj2MdfANjSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1FEaiEd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1FEaiEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EAEC4CEF0;
	Thu,  4 Sep 2025 16:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003404;
	bh=4ehfi8+Lv59X0i+iJrRIOdokVSqi9hA1hvm7g7eoTKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E1FEaiEdijJ/qVYMN0hgZPGv9b66QndjSeallMhxDv+a/Tcq4Vk0Yc2Lk6QZwi3GJ
	 /Z98DuNYBKHyeXuSLO+Q9qi4+/TkP+Wkzl8VZkXP4zPkaMyVLXdRHlq8he5yVt8sWx
	 ySIMApJDdaDNwfmtknUdqUCEYVLOwpCFicOLic5eWQxeaGpM7QMt7f3zdVnmuaRKjD
	 gWRVZE+T9nCssjaz8YlQt7VGD7LdyT8jjqHgNsPtqaqzbL/Ho0lhAYZFvmGQv/mV7F
	 3uetM9g4apZWYNmhkcwvLVLcJ7pDtuu/JQhxkt6U7lkZo1/uT0VRhq7gXUL+Im8qvT
	 KSS0HT0lalBYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADBB383BF69;
	Thu,  4 Sep 2025 16:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btusb: Add new VID/PID 13d3/3633 for MT7922
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175700340974.1874432.5518448218414871531.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 16:30:09 +0000
References: <20250904114611.762004-1-chris.lu@mediatek.com>
In-Reply-To: <20250904114611.762004-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, jiande.lu@mediatek.com, will-cy.Lee@mediatek.com,
 ss.wu@mediatek.com, steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 4 Sep 2025 19:46:11 +0800 you wrote:
> Add VID 13d3 & PID 3633 for MediaTek MT7922 USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> T:  Bus=06 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3633 Rev= 1.00
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
  - [v1] Bluetooth: btusb: Add new VID/PID 13d3/3633 for MT7922
    https://git.kernel.org/bluetooth/bluetooth-next/c/24fca13e2eb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


