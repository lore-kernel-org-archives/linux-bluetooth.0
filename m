Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F076748E;
	Fri, 17 May 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956834; cv=none; b=V5eEWMwgVrv4uH6MrCw0uXGRB3cC/oDFWFzqZWCK64SQga6/gv5baEigxMUfQleKfyDAb35JnU+vop6OrPm90SpbWgvLEI6A62YteFfxO2B8O62vonJCl9KAg1aGYlb1mnq3ewDU1wx5dZizGZksSHuhCQh5jV1Nw6HKAw4HmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956834; c=relaxed/simple;
	bh=WcnDMWC5m0Qf3HEHyWs/JC3uDjcP2QIwCvwotQ5JlEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IdT6V/vvEvBYWRv4nHZzX4HL/yNFmJZlhqUyxfvczseHFmFwbhen3ew9Y8KJlPYJLBBLj8zLfcv6XWm3xRuJTNBhJhuUzEwFMc3sGCxM//haFjMAgxASGpKCay/X1qfH/5dkgv3uV16z/PykkSEMJT7vuvke3wkhAF9nQ+xV0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXFw+nJY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXFw+nJY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7A1FC32789;
	Fri, 17 May 2024 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715956833;
	bh=WcnDMWC5m0Qf3HEHyWs/JC3uDjcP2QIwCvwotQ5JlEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RXFw+nJYPQYnASuWo6jyxiEqP1yqqxziusrnrvlwQ5ez+852or9YlH/nigC95Sx13
	 +ONpKFgHPtXpRxtVdEPHfru4l54k7dfSOAWoTYuHUO0sqsaFwROdU4BNo/D5GJOErs
	 z8K/7d0BbLtMmc/3SEMPutAnBD2p3FyJ/Mr2weAkhw+CO/dEkrcurYi6tdKhUfClIV
	 HM+dI25qt12o+XcNSg7GcCFA21qFKYouYkkDG7D2xRzXTuxOBMD/fTCfy6XHGFiGqz
	 khj5vA1nQ9jI4AGOQbrtwI+NKQNi15zHC/QHShhxGPXYgDtX909M9/dalMKk2Pab+j
	 Rz5ZZvoEcFkdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1613C54BD4;
	Fri, 17 May 2024 14:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btnxpuart: Shutdown timer and prevent rearming
 when driver unloading
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171595683378.30517.9280094714253637646.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 14:40:33 +0000
References: <20240517111535.856723-1-ziniu.wang_1@nxp.com>
In-Reply-To: <20240517111535.856723-1-ziniu.wang_1@nxp.com>
To: None <ziniu.wang_1@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, rohit.fule@nxp.com, neeraj.sanjaykale@nxp.com,
 sherry.sun@nxp.com, haibo.chen@nxp.com, jun.li@nxp.com,
 guillaume.legoupil@nxp.com, salim.chebbo@nxp.com, imx@lists.linux.dev

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 17 May 2024 19:15:35 +0800 you wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> When unload the btnxpuart driver, its associated timer will be deleted.
> If the timer happens to be modified at this moment, it leads to the
> kernel call this timer even after the driver unloaded, resulting in
> kernel panic.
> Use timer_shutdown_sync() instead of del_timer_sync() to prevent rearming.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btnxpuart: Shutdown timer and prevent rearming when driver unloading
    https://git.kernel.org/bluetooth/bluetooth-next/c/3afc41cbec84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


