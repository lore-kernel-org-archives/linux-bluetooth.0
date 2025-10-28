Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8A22258C;
	Tue, 28 Oct 2025 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612635; cv=none; b=BfSeN8A7sOV8BCgiej1mEzmItWdL3i/s1nHBRB0qDc9e+KNd3Pas1JU7GnlFpRvJtm4lo6D8/zlJnX8YBZRJyYal/7fBWENO9Q2ogGrBWn9iUBv/JJLsYSU1+4OL7U9RL9f4cmnc2EsArUeOiHPmpQZ6sfjYqA4FCHOId6+aMnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612635; c=relaxed/simple;
	bh=VvjB3cbC/xhQYBDmLjvIuRyrFoT1gHXtj6/qUJRJyWs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uFcdtO0G5+CKoK3Ik9xVZrH2xIGstwQfkbbn5z/yqbD5FxwoeHPxE8+yAq5ZiI95Bcj8xUdneXmMmdJffqmVuIvFWLvk4BYIwG7YhSq+iEP5xZzKnPaa7YBawdylnzVhBLvnUT/FIi/A03MyOfyHGbstL075pwtD+eb1JnxQBbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8CLtIso; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8CLtIso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63790C4CEF1;
	Tue, 28 Oct 2025 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761612634;
	bh=VvjB3cbC/xhQYBDmLjvIuRyrFoT1gHXtj6/qUJRJyWs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D8CLtIsod264G9NxvVsQDaI2fKao5wfZTEnA3dnDu2FuNJynS37NtRaRo/q+AQIlR
	 AzMbT7om3UEjHWbpCm1++Pra9oyxLZ6+2qrw6TuoveNpJI6Kx3ZgkfbUMkqXmtsXTU
	 m5naJdYkQeNUIKmZG+ogRtRV+q/wLllxSkgROMaG4zrX9xH2BPGN+czp5bidiqmt8+
	 mPFG6/+2Vlpy0sA94SrLkaZOeYfMhFKhaXlzcCT8825q5WTtmF2SMzB69LSFrzOEwU
	 6mbTXC53vysCMOp7NbE8zV+6xffJDPJczXiWE7aBzljvAlbQR+HiO0sLaLuYT0GQvN
	 qaJgRrlQcmcfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCD439D60BB;
	Tue, 28 Oct 2025 00:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-10-24
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161261251.1638595.2656449907453982783.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 00:50:12 +0000
References: <20251024144033.355820-1-luiz.dentz@gmail.com>
In-Reply-To: <20251024144033.355820-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Oct 2025 10:40:32 -0400 you wrote:
> The following changes since commit 1ab665817448c31f4758dce43c455bd4c5e460aa:
> 
>   virtio-net: drop the multi-buffer XDP packet in zerocopy (2025-10-23 17:30:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-10-24
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-10-24
    https://git.kernel.org/netdev/net/c/b3cf2d14cff5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


