Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDF55664;
	Fri, 19 Jul 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401835; cv=none; b=JZkc3UculPRbM9lrUiiDhjFLZMND/ddsHGDUBk20yyo8+86DwP2L+C82ZFFfuvqA81QK8kdj6/83JTGjVFDnOX5+Q3scJZ/j7zb9cHI/uF9z+XBvdbosFl076zHS+psDUQb0pZDZSBzJjCPDumR8n3SZbU2TOAU7QdWYnbgSIYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401835; c=relaxed/simple;
	bh=fgRsB4Q2xXb4zPEviS99iTSMsB0c3TTBmRkQMXlyO/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E4vuWpIGy9JLEF3OqvBmFR4+SxOmUlUZY17pPXypqijcvpBLvZa2z8DAHSo3R4bxftFYAYmyjqaRLBLj444l/RxxwNY13ei+UOgDW7Ahrp8XetNs8SkgCfxfSVhE/H11MfK6VhZLOiStw3kjEA7fFzyN7/JQR1JqJ5lkuX1k8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyLN5vAU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyLN5vAU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EC1DC32782;
	Fri, 19 Jul 2024 15:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721401834;
	bh=fgRsB4Q2xXb4zPEviS99iTSMsB0c3TTBmRkQMXlyO/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pyLN5vAU0E5zezTC2iqHAxDFPRKr8Jn0lD6sGTzcxSmyJi+kaqAKH4qBfKK7/pYEH
	 lHU/dEFgRx0VjL7TouFiAd2+tZ/IB7enUtO3SAstCH782o1VUPlhW5HTxLCuNEgPjq
	 oERrxQaiQh5hlNvkTsdSCzC3S9Jo3NY0t2thGYyGeXkAygiSRxRlNECcQ58uqfkdtU
	 uAlEOqJJi2lcEIp9cl7qrwFTVfOxqa2iJxobksRZy8YK6AvX+5o1ozacxi42LMrPHK
	 RAUsSkUJvpGwZXXagdVoXBmhvUgcvucQ4um93Py0xtuMI/k0QsWuyT6v4gJhksR6Dr
	 /hBGsMCJAzNbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E1F1C4333D;
	Fri, 19 Jul 2024 15:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: btmtk: Fix btmtk.c undefined reference build
 error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172140183431.18849.13794056510473088684.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jul 2024 15:10:34 +0000
References: <20240719033019.26767-1-chris.lu@mediatek.com>
In-Reply-To: <20240719033019.26767-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, aaron.hou@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 19 Jul 2024 11:30:19 +0800 you wrote:
> MediaTek moved some usb interface related function to btmtk.c which
> may cause build failed if BT USB Kconfig wasn't enabled.
> Fix undefined reference by adding config check.
> 
> btmtk.c:(.text+0x89c): undefined reference to `usb_alloc_urb'
> btmtk.c:(.text+0x8e3): undefined reference to `usb_free_urb'
> btmtk.c:(.text+0x956): undefined reference to `usb_free_urb'
> btmtk.c:(.text+0xa0e): undefined reference to `usb_anchor_urb'
> btmtk.c:(.text+0xb43): undefined reference to `usb_autopm_get_interface'
> btmtk.c:(.text+0xb7e): undefined reference to `usb_autopm_put_interface'
> btmtk.c:(.text+0xf70): undefined reference to `usb_disable_autosuspend'
> btmtk.c:(.text+0x133a): undefined reference to `usb_control_msg'
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: btmtk: Fix btmtk.c undefined reference build error
    https://git.kernel.org/bluetooth/bluetooth-next/c/52828ea60dfd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


