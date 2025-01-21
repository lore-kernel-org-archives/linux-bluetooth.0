Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918701F543E
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477614; cv=none; b=VxvvDuSFXl2q2oWQNIp99g1KX0tMTsh26QY8ZqMCOfKPP6E4DXHbDq4/MtdFEEXbPSSDQyrlbtVOomtKu35UiqHjLSlrkLFwbVFfo+iDH0R/UDZFDP+3+n0MXSpo/dt9w/dBcFI3rLKBFXbB6FIIxN8oj65z9gCfV3RZnk/1udo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477614; c=relaxed/simple;
	bh=MnYLCDDlAGAg9+/kO5bz2+gDs7GVTprNX2e/Tyz5Lj0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QaKT34uVeuyJ02x0U8MA7zqAZxyu0Vcj2iWFIdKPPafXigOXd+cnUuRJaIkmVHSirdiTH32T5A3e989EJSv08kprUkn9c3JgVD3MgTL4aca74Ipta4PFZu738Dw74TIb46GVpmzZVVEtkgv1WrtnMH/xx7PMMWlvDTTcSSpb17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG+VqFPp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG+VqFPp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095A9C4CEE0;
	Tue, 21 Jan 2025 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737477614;
	bh=MnYLCDDlAGAg9+/kO5bz2+gDs7GVTprNX2e/Tyz5Lj0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fG+VqFPpLH49sNS6Qaa4h/gzL5brahPBbEvrtz1aj9QcDDXETeiNHsfE6/kQTitaq
	 2nWAl2hZGeeyPDMlZOcr/HQhM0kyosYTmQqF909z1aqXMPvM9siptmtjI6ebgyCZE8
	 u7W84uadN6wpLDjaaqL1G1EPg66Aug1ncuPYaRwhl10+c5LBwB9Gxj6E6OMkHRGO9X
	 Z4TEVqYHiXQlO7MNmQ6bC5541BIkcSJdQy4rDCLrT3NLyAbO3VuSMnL454f8I4rRA9
	 BUJxNDWEU06bJ4QHrwChQ2qahM3s8IkX+2avljrvAZT+jLnxZJCjUlYW+J64jkCwPq
	 TUZ8NpexBsoHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7174C380AA75;
	Tue, 21 Jan 2025 16:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add new VID/PID for WCN785x
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173747763799.49514.13655221505942926807.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jan 2025 16:40:37 +0000
References: <20250115233449.59046-1-doriancruveiller@gmail.com>
In-Reply-To: <20250115233449.59046-1-doriancruveiller@gmail.com>
To: Dorian Cruveiller <doriancruveiller@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Jan 2025 00:34:31 +0100 you wrote:
> Add VID 0489 & PID e10d for Qualcomm WCN785x USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=03 Dev#=  4 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e10d Rev= 0.01
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
  - Bluetooth: btusb: Add new VID/PID for WCN785x
    https://git.kernel.org/bluetooth/bluetooth-next/c/3b9f41078507

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


