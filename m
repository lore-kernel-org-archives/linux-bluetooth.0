Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE4C4A13A1;
	Wed, 13 May 2026 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693461; cv=none; b=MOwwLabHTHLpszyTYUO9nku3Bl8qMUuJcgtQrMDH2PNZxnLGS85tHI0TLFq+RMkseTVQhCFdm+3CeXct6CniRGLvGdaeBn67ZY9+Z1F8Ob2yLEiVJ36hMjzOfc6vJ0Nn9kS17BeP1AqkKg07r9JfEs5MZsipRnW8EWoujOy2HDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693461; c=relaxed/simple;
	bh=RmE4wt/Tmt+LaAybBAxwh1aVz4et2PnHjNOeyvyDLFY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sRagZ+g36To8Z1USyncpXGXcLGg2esZhdUyOx+I5mWKmaHkG+WdouC/v0Ln8dyJdATnvvpXJBKYXL4vDA2Y+5/jFjicroXcyih3PIs8vAugBa6/LOSD4USCp2oZ9q2fTD/4rMH5ekJlK9Ax6myWvK+YttQfkFEE8UqA7Xfk4PKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4TyrxK+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4TyrxK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A922CC19425;
	Wed, 13 May 2026 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778693461;
	bh=RmE4wt/Tmt+LaAybBAxwh1aVz4et2PnHjNOeyvyDLFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O4TyrxK+LWGKRN1CoBpdf7IIa8yDj1oQ15OsO3knyResGVvPUtsFgz1Q7lfj6BS4v
	 0qLxfE7a1K7aGwUNlKlKxxtPX5+5yAIzGeUq0UEtHMAqfH2bfZ6GMFFpQBu1w6AAKx
	 T/NLoCVGkHtDfu6yXq4nZIPyAev+fM9Ck27p2dsUKOO3ohjFQAFBB70tvue3d2voau
	 R23v2NG0wYPi6aF11wf4sVeGJ5ylsJsLJKpU52bC0k5wvhYWkR4211N/tVQjoG7cl4
	 +JvXSBHbrstbx8M4xnMasEVKR7mytetyGJ924rsg3aPa/YqkN8ElfLUctpbKkyq+sy
	 fFhI8NtaMv+vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD04393023E;
	Wed, 13 May 2026 17:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btusb: MT7925: Add VID/PID 13d3/3609 Add
 VID
 13d3 & PID 3609 for MediaTek MT7925 USB Bluetooth chip.
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177869340680.3749256.1506634677633894169.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 17:30:06 +0000
References: <20260512033422.3242781-1-luke-yj.chen@mediatek.com>
In-Reply-To: <20260512033422.3242781-1-luke-yj.chen@mediatek.com>
To: Luke-yj Chen <luke-yj.chen@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, chris.lu@mediatek.com, will-cy.lee@mediatek.com,
 ss.wu@mediatek.com, steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 May 2026 11:34:21 +0800 you wrote:
> From: "luke-yj.chen" <luke-yj.chen@mediatek.com>
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> T:  Bus=06 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3609 Rev= 1.00
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
  - [v1] Bluetooth: btusb: MT7925: Add VID/PID 13d3/3609 Add VID 13d3 & PID 3609 for MediaTek MT7925 USB Bluetooth chip.
    https://git.kernel.org/bluetooth/bluetooth-next/c/ae3ff17c6240

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


