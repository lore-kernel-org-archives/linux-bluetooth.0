Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FDE46C4AA;
	Mon, 24 Aug 2026 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590261; cv=none; b=rTsTDFE4Xx3QPGdri/GBwVhxub6Vv5H/Ox86P6fi+8OUzovStSDkowrq3dY92aZ+hv07nHqtBBPxJmGhxiu42Cyf83x5KXIp9vFUvcQ9rxw8uKyg7hAkRlxTo7kd4/NY9xcBJdI1xjHfUs19mu4kGn0giLksvdTEZAwI6KUbs0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590261; c=relaxed/simple;
	bh=+NLH8jEthLKzluoGAfaBPYkO4cdHsofd+gSHQDeK3oQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nbLsLCN1gw8vuaEGWuw/t94+FGjX10PpWg1WxMcc4M9ayQeuOmPiJzdxpl1AdSzeXavGyUxMGJ67N4ino6ujZFkh8GXyikh8iwrJBQAsOruD+m0tC9e2Fj/rRaRsJTTr438IB6KUypgGuV8UKKScrdGv83VKRhEzMftsxy+WS68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0DL4FCb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0DL4FCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35441F000E9;
	Mon, 24 Aug 2026 16:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590259;
	bh=eXKHE1qCTaJ7shptPlDePx4OdOX+ubkzpIW3w20JDpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Y0DL4FCb6NOHJbAYTTJJ2+H34+9owmZI1tTXNsLX1Dp3cs9zW6hGsFHzSvHcYJlSa
	 QC1XZ+RA/6BTxoGXvmixWzMm6OpDXt7o2tsaZGIBXjRVQxOQHIibqZILAxC1jj2T79
	 0QgzY0uWGVMzEMrr0Qh/salr+m0v3jEPI6wHObDDNTqoAwOdJoolfR1vb/N1JWPWHK
	 moAG2xD75YvzZPC615BZHULv5Kv6EGvP2U4A9ddiAp6t/hNobRRx/wgef03RwhS97T
	 j+pAK/2OFkzSCVAp/IU/r1i5qZ/rsfeV4AgxvHS6Un9m/3dzYkC7zjcr8/gP2Z8uCz
	 9otSei/YMDzyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9393C3924478;
	Mon, 24 Aug 2026 16:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: serialize session teardown
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178759020713.3014491.3447283705707254634.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 16:50:07 +0000
References: <20260822150619.3684599-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260822150619.3684599-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, kees@kernel.org,
 kuba@kernel.org, pengpeng@iscas.ac.cn, yaojiale02@163.com,
 suunj1331@gmail.com, ali@iusegentoo.com, tim.bird@sony.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, pav@iki.fi

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 22 Aug 2026 23:06:19 +0800 you wrote:
> rfcomm_kill_listener() walks session_list and deletes every session
> without holding rfcomm_mutex, unlike the normal session processing and
> connect error paths.
> 
> Under normal operation, an open RFCOMM socket pins rfcomm.ko, so
> rfcomm_kill_listener() does not run concurrently with rfcomm_dlc_open().
> However, forced module unload via delete_module(O_TRUNC) can stop
> krfcommd while a failed connect is still unwinding.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: RFCOMM: serialize session teardown
    https://git.kernel.org/bluetooth/bluetooth-next/c/fe3897b4ab57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


