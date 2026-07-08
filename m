Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD0E40D57B;
	Wed,  8 Jul 2026 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502440; cv=none; b=IaOfraTNokwDxf8IHQ/nBopwvivtYQ+9jMl7jS+nk4cO+1+AKn+207PxfqvDDKe/Kp9Uh1kM2gvdTkUAfVDNxh/S0w6SUxuVi7nFnWecXJmR0spkrO4siKA3wBBK3fAerRruFkFBLm18T83u/VXpal2L3ZV+Anl7QritejgT5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502440; c=relaxed/simple;
	bh=j7UoS4lwrnoX+kuyxL/qrhVWMI7DPlDHHYIsm/qmsD8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qzGS7OcxtGXcA3W7h4DlJkhJRwq6O2mf3mL+GyoVBm4Q+0LC7Y+H8ti8jgjiTD3a8GDvjcc7LLlKoe4MTmFnSciB/pUroBcLgNmUlGJafzdtI10bsiRst4zFDjwKFdrq+d17OQ+/0w+5XTkLPw0AcIqFpR7oML93ZIDZJwdZXkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzLOz7m3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzLOz7m3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A801F000E9;
	Wed,  8 Jul 2026 09:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783502438;
	bh=tXqGWPfoQ+ZRhEnZJt1TKq/zShgWFPQynjsi+EAWS8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EzLOz7m3u6TgeBETiBoAHVKklCBttNW/HIbU6SYqCuoKk9c3RnqQW7w5U2C6I9QAw
	 jAZnzp+HW3au1M9ilaMZCDLmEAKKVmwpSiis01QrvYRFJHdEwTmrayzKAt7PibY8cW
	 K+qOSdYfzRAgnuyFp+5MK0wVAGDK9P1KQ2a6j8Z7F2XUdTRo2jZBAsgVVpYCVH01Vy
	 LmwPmbqsmKvoFD1vt3E10C2e/+lFW2CEAUXLwHKfmbsR4LXufUr4b79pl+3doiNIL1
	 6vG6e25nNBpmlJWYZsdrcmi/R5LGYndSlCYM7QZ+6bwPS0p1My32hMTx5e+/veNWtx
	 2SVQEAXu4FnkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C003926394;
	Wed,  8 Jul 2026 09:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-07-06
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178350241764.2394281.1836557969772284025.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 09:20:17 +0000
References: <20260706145229.728127-1-luiz.dentz@gmail.com>
In-Reply-To: <20260706145229.728127-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  6 Jul 2026 10:52:29 -0400 you wrote:
> The following changes since commit 9e05e91a9a847ed57926414bd7c2c5e54d6c56c6:
> 
>   amt: fix size calculation in amt_get_size() (2026-07-06 13:01:24 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-07-06
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-07-06
    https://git.kernel.org/netdev/net/c/5258b4fdae44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


