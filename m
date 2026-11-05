Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896334;
	b=2j001K8ayAyj2pVnip4nUuYmbN8kWBaLmhfAYRtIddqy++PDvUGjojual3Kh0kz847G3
	 ewV9dIPFuGp5fSNIykaC16TP5IUylRDRVh1uZ7ZJKMz9KEEJT7c+oc+yvateDco4WRooY
	 HrlgDlu5Ooo73Uhf83ps+LFVCz3qQTIMUx0WkeyDsIIbhJ7EtKQc1aDvk5PgzYwk1EU+0
	 73Mk1TVCORbypKUZ7a45l8SmxmwrFaLEFsHwVXUoszZ16JNSQtXXksL/2AKy9ccqLNLz4
	 KE8UEpI9HWgFEqFzYeDBx2eEVuOeyoFBYaCHiYkRvGYfJwJUkfMCoEiNXKeLyc9rHCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896334;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=fo4PMdOFg30qC0TjoVY0NWXy42OB9DCI70/PSOM+Vu4=;
	b=oBkC5QuGwyVYIPwDZi7u/lyVaVKlvSwbTUYT5LOFqmZRtk/dmVYsT2pvbf2R4Ho6bYWF
	 L7kqPaV8SYcp5rf6IVxCroNvtn1SZ9DlqGyGC+7lKMY9TAbNjpaCyzFS5FEd6U43UzoY+
	 0SG09ILQbNYCXFSrEo6sH1k/s2bfDABZWhpnbHcvN2badAGD3o6GubyNsl/N+f4v3tWAV
	 jm8P8tcUKqEZJhcua2Jxp2Kbw/wf81mpw4/dlEvFE7VAzNwMAgbbH1/CuhXxHzjeZknkb
	 HrO0+WVpmd/dPk6Hx75t+dY9SZ1nRJZo5dIphygixj0+n2P/X4I3kMbkVlLC0tBUigg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5YGtVW7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4E606A921
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5YGtVW7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D351F000C1;
	Thu,  5 Nov 2026 16:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896333;
	bh=fo4PMdOFg30qC0TjoVY0NWXy42OB9DCI70/PSOM+Vu4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W5YGtVW7qDiwRR6OEC3hsqNVdSiowAbMmIJ/S8wWRIif0xYLBeTTQFO0RQGOyOQ1f
	 HAOiKAq4zDK+qWZXp0Bj71RqIyupLBCLWRzZZ7drxd7JH8rM47hSmAXY9dJIje2PIJ
	 l9ww9+vowAiePYymWseVPQXWkhVyna26kc4Meute1Wj0VUmcSECCvCg/y1Va+8clCp
	 svebhkcoofm1pNFhxCFsKvZoLJhOjo6xw+DcuOaxgUMLg+HM5cXl0huzIv+xNPE9v4
	 9rh+sxWL+6nKPUB0dKrw2Xr8rDA0eQ1bjc6cSOIMiU7lEcyCjdqpcgpCw7a+dCUDaz
	 RjSzCDOc3ma9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA23F391B173;
	Thu,  5 Nov 2026 16:32:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: Fix not updating of hdev->commands[] after
 reset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179389633229.103975.4552218809952719575.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 16:32:12 +0000
References: <20261104221956.1207025-1-luiz.dentz@gmail.com>
In-Reply-To: <20261104221956.1207025-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  4 Nov 2026 17:19:56 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Read Local Supported Commands was only read once during the INIT/SETUP
> flow, but the supported commands bits may change at runtime, for
> example after a firmware change applied with vendor commands, so update
> hdev->commands[] every time the response is received.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: Fix not updating of hdev->commands[] after reset
    https://git.kernel.org/bluetooth/bluetooth-next/c/e00aa1a33f81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


