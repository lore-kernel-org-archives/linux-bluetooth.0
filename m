Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C487B4756A0;
	Fri,  7 Aug 2026 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120255; cv=none; b=UjtEyffOH8x/9qXB9b27Jx1bGOlkeIk2qFZcjaX1Une3crK5by114rn/cAum+T3gEv7QP17XsrGRrXORz69AVNJJup/H76jDNmXlD9smPUYy3wjzpcKW/dLUj7+CowXHwCTpQQ/xBYTul+TJXh0HoOprPLkveaKSoCnWwyonX4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120255; c=relaxed/simple;
	bh=XxAS22pXMPRE8/XnyDylYK9Twzk0N0MySl2fRiH5X9E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kfOR6bE1pGBf6Z/nSHzfDHQ1kyLFDgm2C+KqMPo40miV6S4M7Ut8x+o34lbEbJDZX6DipIvVp91noP45KMGf5fwmmG05Gc7Uejny7uKdKMS3vwrIU+i66Mozb5msRXhCYcBQWt2On2ppi1ps5lLwIH+ifMjDohwJVux/L6ghqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK3eXO1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK3eXO1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEEC1F000E9;
	Fri,  7 Aug 2026 16:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786120254;
	bh=kaVrTc+sa8/nAU81KZuP8UMHYiMz2IaW9U7Z7a/uKLs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PK3eXO1ZNO2cgeG5W6vmFtFO+JxU3N2sakvAjPydvI4UCeUbdIwq1j9ZHL6mxBio3
	 ByNVChoj7VBRxhC3n6Ha2kKwChGuQIZOc3XyV+eauBrzcHLW56z2CQhCv/KiyioeHj
	 qQfC0DaGthxVZaarROW59I0gx0HODZTV5+KVZzu4V6IXW0APjAsQ2OiDswVbhcWYD5
	 /OdlBEQ5+9cyIEldp9cKKau6HcnbzJE/wNPp5OZrJvEGQr1gJ3/VZhftWJ9yzCbYAI
	 Lfdk15Zghoxm3NfCsRSXSTco+7AuXZGM4wXU4MbzzTQoNGubZZrBRHfWqZrTzm9V0H
	 VrUOgKidPVBtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A9F380CEE3;
	Fri,  7 Aug 2026 16:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtksdio: fix usage_count leak when
 autosuspend_delay is negative
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178612021313.1887768.17053811482206662967.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 16:30:13 +0000
References: <20260807151447.2530075-1-lgs201920130244@gmail.com>
In-Reply-To: <20260807151447.2530075-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, sean.wang@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Aug 2026 23:14:47 +0800 you wrote:
> btmtksdio_setup() calls pm_runtime_use_autosuspend() when runtime PM
> is supported, but btmtksdio_remove() does not call the matching
> pm_runtime_dont_use_autosuspend() when removing the device.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during driver teardown, this reference is not dropped and usage_count
> remains unbalanced.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmtksdio: fix usage_count leak when autosuspend_delay is negative
    https://git.kernel.org/bluetooth/bluetooth-next/c/1e4acc44552b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


