Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF60B192B79;
	Mon,  6 Jan 2025 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736187013; cv=none; b=Ca5u5fRpJ8NylcG/A/MpLdS6aQGztRXk/wJl+J2yAO7AzQFciyqX4TGJ8EyCG2x+DMNcewfBLmTEcgPL6zPisw2+4pbiMwnP5FF1atvdfG9SGVBTZ/tcAXS5YAjX0JfrfrGovWIY/b4/ZkTJ0BnqfHXEaj/MY2hzSr3AgRSsVuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736187013; c=relaxed/simple;
	bh=3+P7uW3efrV13RngJiot9oEC9H+FWw5Pgb+Lbbe3JVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k+ky2eJzmOXzworUub/uh6IguhlyX/f2/AeLiXMbElOtTUqhOyvD2xevW5HeKCus5WmFH9EZvMu6d+9Ueukp+DKgLYpLY3zkAsCQ2C2vSMzK2b+UvhThaNvG/HFVJ4u3iQR7sMp5MAahOPa+s3Y0lAJFBo7hEGZCKAPHTwR9wM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL7Sa7eu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL7Sa7eu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5360CC4CED6;
	Mon,  6 Jan 2025 18:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736187013;
	bh=3+P7uW3efrV13RngJiot9oEC9H+FWw5Pgb+Lbbe3JVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OL7Sa7eukan9dlQDuHzuzN+KblLlVv7onwt11/olpHNG4s/elZpEwqhWa1B+UHNU2
	 OIrWGVKtaJdw5iST7upWoKZMPvfh0TQRZEMBu0ory6eOephwiV6iz8e0FRPAVwas+H
	 rfPheNw5nZQnVzgDmd4V+NMgZD2+n8BO/jjoJmI9IubeZ42DbHGNjiGTNbRUgRGQdX
	 ZTAjbJBy8BysepcQRLx5yrXdo4KYidFY7ecfXPZjqNH9zq5Nry7qNKX1CS5OJnVJWo
	 ppGcukgCenJRbhQHOQDihRuW0j66WDT4SCAq2nA86NrHYwenfzedMBSh4ekEHQTAoU
	 GgEcv4E5KRYQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2C8380A97E;
	Mon,  6 Jan 2025 18:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH Resend] Bluetooth: btusb: Add ID 0x2c7c:0x0130 for Qualcomm
 WCN785x
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173618703451.3577621.6424068053479999223.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jan 2025 18:10:34 +0000
References: <b9a5c3cb-d3d4-4fae-8171-5b8c2ab9744a@app.fastmail.com>
In-Reply-To: <b9a5c3cb-d3d4-4fae-8171-5b8c2ab9744a@app.fastmail.com>
To: Mark Dietzer <git@doridian.net>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Dec 2024 16:02:55 -0800 you wrote:
> Adds a new entry with VID 0x2c7c and PID 0x0130 to the btusb quirks table as it uses a Qualcomm WCN785x chipset
> 
> The device information from /sys/kernel/debug/usb/devices is provided below:
> T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=05 Dev#=  7 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=0130 Rev= 0.01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
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
> I:  If#= 1 Alt= 7 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  65 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  65 Ivl=1ms
> 
> [...]

Here is the summary with links:
  - [Resend] Bluetooth: btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x
    https://git.kernel.org/bluetooth/bluetooth-next/c/94382af338f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


