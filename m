Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC716EB53;
	Tue,  6 Aug 2024 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976139; cv=none; b=scToRGERGnQwWXhJIZ2YBTIkOKZwlXTvz0q5n/Rc8uboP6TgOICtRYpGRuGm2mv1vGRQ46624wy5+FTiTa7pXPAHzcHjm4/vixSPxb6/pvJuZSxBJ6WE60W92QaTAceP6mT/PQdwnwimyz0hTTuy8yNgiRH51SPcjcUPEv4L7F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976139; c=relaxed/simple;
	bh=+L1mds7XdZNr2tLDXx7FUINDaM3YND1xEBDwsLW6GKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p+7TVYJKnUlv/VHbNMPYPRFvogYhLmQjVtNT4OTiQ75jUTRKiUDjIApD4/WopU9ktqaH89Tc0FrjWdwsxIe4chL9JjKx0AhYi70yiSp9TiXe9+939otL7FsX2JRPiSuNdSg6LXXbzLroa4cvbu8ylb1e6eIOYAyy+hwQMymHlx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ3Gu0zp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ3Gu0zp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA41C32786;
	Tue,  6 Aug 2024 20:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976139;
	bh=+L1mds7XdZNr2tLDXx7FUINDaM3YND1xEBDwsLW6GKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eJ3Gu0zpS8fS/uM5YLvs+JxVtosZFExcaB9DjfT/JAiZk3HVAtXYV03oWCpIrbVWt
	 Du3fTltzirTeiPRYZSG6X5ZSrtUB4D0p7Mh/6UoJHLM0UdG9WV89BzmmNocL8f/dbd
	 2x+BguWfDXKrSxlZJoaL2QSYThIt43WHHqdaiwsafvvCaXGbG03B+q6B0gwbyC+PuE
	 jmfHMhoJEu9/r7HopPf2zHKQnO0ACeobrhK41ZJvboVthM1zDiIzJeDjgWjIJ9jVO7
	 NHhZxpIW3E67a5/N2GX7+N2YuASj2RNCATBLwsijz/2ykNBMgk92s4PA5QP3bkkROF
	 IyeD9nX24Bw8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB60239EF94A;
	Tue,  6 Aug 2024 20:28:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: btusb: Add new VID/PID 0489/e139 for MT7925
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172297613766.1692635.8217339619604849343.git-patchwork-notify@kernel.org>
Date: Tue, 06 Aug 2024 20:28:57 +0000
References: <20240715061508.14077-1-jiande.lu@mediatek.com>
In-Reply-To: <20240715061508.14077-1-jiande.lu@mediatek.com>
To: Jiande Lu <jiande.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, chris.lu@mediatek.com, deren.Wu@mediatek.com,
 aaron.hou@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Jul 2024 14:15:07 +0800 you wrote:
> Add VID 0489 & PID e139 for Mediatek MT7925 USB Bluetooth chip.
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below
> 
> T:  Bus=07 Lev=01 Prnt=01 Port=10 Cnt=02 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e139 Rev= 1.00
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
  - [1/2] Bluetooth: btusb: Add new VID/PID 0489/e139 for MT7925
    (no matching commit)
  - [2/2] Bluetooth: btusb: Add new VID/PID 13d3/3604 for MT7925
    https://git.kernel.org/bluetooth/bluetooth-next/c/bd0b4dae74b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


