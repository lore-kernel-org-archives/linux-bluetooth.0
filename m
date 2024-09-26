Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A566133C9
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Sep 2024 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727382628; cv=none; b=dyAKbJ1Q598h3zb1X1161vJt6rzG0aFHn8e6CLpXntsi7V/RfcaLZ7ar8tNWeGlU3Wa5tjA+P8Y4EQ3ePuc5CHURhPLuaVeDZA0MJWXCooMXTwKxxtuhDU2Ae3+SLyMxpOjGyCwyhTsvn7mqR8BswfI1Un5wdnqgZcnHlkZfBaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727382628; c=relaxed/simple;
	bh=3VEY+Wxi8abQKMWxePqiKhcX/jrHI1kBpkUx45LNWUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FwC9RHyS9fAPYyUh3kKuLA4gK/LTBlQCLEm1cg/1+xhmMLmPgZb18BTdzAEyJWXds91fnmPVQeaLiJSh1c919kBV9Z/XeB2Wh85r71DnoIzK489Hv7IBhgre326a7y+1/5fyAAlZv8Me9lLNex+Bre24FB4+NNS9KCGnDLAXDpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVsF8S9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVsF8S9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF2AC4CEC5;
	Thu, 26 Sep 2024 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727382628;
	bh=3VEY+Wxi8abQKMWxePqiKhcX/jrHI1kBpkUx45LNWUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KVsF8S9gWXu+nQsrU+OrN0LDBl2voqOvsu9UjMfvu07tlIL+OZin1esla7Ls4pfEI
	 6IftgIfKhczRRztBTeJzBjqHD2Xbq+/8jhkejBCLIx0CV2SNDRBAKvvtZHrfx++Kv8
	 hMPzODUwNOjWKnfXhPy7rEVFWkHRE1vq2daoQwIWLgc6Qdexf1N9owgUvM4KYfl8nz
	 QGT9JdGB0q+fkKtBwxZe55LhAGs0nw4BT/erKuUgV1S8MvE89lk5AEUAjiJoAgHQ5g
	 dpGxifqL9Vz5Wc+/UsjJF7z+ONGQPLkca3KWYJy9Gfa0AL6ACM3LsqQW0jLt+fh9jJ
	 UtSbIivzZndnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB54439EFB74;
	Thu, 26 Sep 2024 20:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add one more ID 0x13d3:0x3623 for
 Qualcomm WCN785x
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172738263079.1385049.4886169675284627212.git-patchwork-notify@kernel.org>
Date: Thu, 26 Sep 2024 20:30:30 +0000
References: <20240926-btusb_2nd_id-v1-1-790189305e12@quicinc.com>
In-Reply-To: <20240926-btusb_2nd_id-v1-1-790189305e12@quicinc.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 26 Sep 2024 04:08:49 -0700 you wrote:
> Add one more part with ID (0x13d3, 0x3623) to usb_device_id table for
> Qualcomm WCN785x, and its device info from /sys/kernel/debug/usb/devices
> is shown below:
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3623 Rev= 0.01
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
  - Bluetooth: btusb: Add one more ID 0x13d3:0x3623 for Qualcomm WCN785x
    https://git.kernel.org/bluetooth/bluetooth-next/c/9cab394d601b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


