Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C57178CEC;
	Mon, 19 Aug 2024 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079638; cv=none; b=P+UsbKzjdANb3uWLIEtvtWVe0XSZjLPJYtTh5hdFLfwFhOb7kaGHQrrFZJrx1ccYVOw9vq8VrAEqUkr4Wo4NYtt8x5hxro4HwmcQkSBF4xNp7tEMZakQWAkaZUnInAQ4fGNn5hCrueAZfy4p4/1Mua18y3rkk6rXwGDirwmTWoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079638; c=relaxed/simple;
	bh=CRqAJgzh7/6BKRHBG5yVgY8389jP2496Eb7VbqMtWbE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f8nyZ02Djn1D0yBGZeKWuw9erc4UIxYufhTVVNgEm1hFd+42RwJstJ1g7TAaV7rhWM5xPkZOu8iL8S/GRM/0Je5p638+DYAQTYlNxj1yqU3YfvxakZyFoiskFrmJx3Chtg/j+uVDnED38Q/H2IhzU9FL9zubRYnNupzADPzjAQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blSko4Lv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blSko4Lv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86270C4AF11;
	Mon, 19 Aug 2024 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724079637;
	bh=CRqAJgzh7/6BKRHBG5yVgY8389jP2496Eb7VbqMtWbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=blSko4LvsyV7kvnnXtLUmpXiZ4Yfp3GgP6HRo7jlZGJQvmzoPfzR6LEMhVVGJGo9v
	 yxDmry7e7G+FT3cHoCsBz8tOnRYSSIaXb8vwDgQiVtztjp6F+Nqxm4kJyNB53YL9Pg
	 BPmG3yCPbof7lvlgqL5S9/kk35xbOjLxn509G7nolj69JPChzzvoguqgouibLGX25w
	 Bpq41uOU0R8GagMHp4qnKLYqgYN004QVMOGujjZjFD9+1EgX3GaQGNAV/wkt9r3H1i
	 t21y2hOg8OCMEsSTVlfi+39ZSB3xDjgVCa9NjbYw7xGsLGTHJXQVZj/j0xDyJA+EC9
	 4K3kR+A8wQF+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C9E3823097;
	Mon, 19 Aug 2024 15:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek RTL8852C support ID
 0x0489:0xe122
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172407963700.558835.2379699311999131246.git-patchwork-notify@kernel.org>
Date: Mon, 19 Aug 2024 15:00:37 +0000
References: <20240816085822.432767-1-hildawu@realtek.com>
In-Reply-To: <20240816085822.432767-1-hildawu@realtek.com>
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex_lu@realsil.com.cn, max.chou@realtek.com, kidman@realtek.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 Aug 2024 16:58:22 +0800 you wrote:
> Add the support ID (0x0489, 0xe122) to usb_device_id table for
> Realtek RTL8852C.
> 
> The device info from /sys/kernel/debug/usb/devices as below.
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e122 Rev= 0.00
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
  - Bluetooth: btusb: Add Realtek RTL8852C support ID 0x0489:0xe122
    https://git.kernel.org/bluetooth/bluetooth-next/c/30ee59d289eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


