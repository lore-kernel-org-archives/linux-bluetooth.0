Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91D2264B0;
	Thu, 26 Mar 2026 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774529421; cv=none; b=B+AAeTdrCbAh3d5tueVHDnklGsao3ZPQFem/w7mJTxzb1Y21G4FvLOZTXABZJ3reWsaKU7gYudViZHLkNJQ/mVaRlgRLIAO2dea4N0kV4cibuBQkJq01uZ4XHI97lblNsaM08oZEYsh46Y1jP4aXjXr4Q40qYPYHUZMNwZljLKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774529421; c=relaxed/simple;
	bh=nz8zSkm/QwG9xuSPLcqGNPh0yy+Xxb6YSgHtYiiKX/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hykDIooSKTM1+M5x7BMe2nhUgYwcjzt5+5F7LQV5d/U+onQhe8i0o6VjPzB+ER7nA1IrASoaw14jhr3ZEUqJ502s3MvR3ds/vCX4Y66PiNB/MV3zunv0yT56tuUVRf4H2AhnrAozXYw49xao7xPMsptuMFLRr5HU55imFDLkz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBX16vSK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBX16vSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8804C116C6;
	Thu, 26 Mar 2026 12:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774529420;
	bh=nz8zSkm/QwG9xuSPLcqGNPh0yy+Xxb6YSgHtYiiKX/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bBX16vSKk2RJ442v4X1RROZTV29ed+azP20KL7akyCDrncKW8ujNBZI3BpEQH0BNp
	 7XZg5Lwq4VGkfYM+KmzsrAWyy0VJeQcI+hGLdSqNJPdCZMg5ZIx9vDG06fEhrr7ob/
	 Z8JnEAqSlnOTktXHPzlPbUQQBgfix/IqUsGfqVDcUXAp6aY/7elenM7zdvtevDPkRo
	 X9brYbViiv9/HL7E/coeTSJxuD10+mSjWdZuAx5zCI1rQ7E/9wR1mcWOR3jpT8QhNH
	 cjkjTcYrFPChsNKR4yP4GWJNsUyj6CjjfFfgJOypVZv1CyMkFUTNJiL3X0iq/bhrxX
	 Ie53GJyg6ObQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA09139EFA65;
	Thu, 26 Mar 2026 12:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-03-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177452940754.2540696.16802163481653825797.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 12:50:07 +0000
References: <20260325194358.618892-1-luiz.dentz@gmail.com>
In-Reply-To: <20260325194358.618892-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 25 Mar 2026 15:43:58 -0400 you wrote:
> The following changes since commit c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f:
> 
>   net: mana: fix use-after-free in add_adev() error path (2026-03-24 21:07:58 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-03-25
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-03-25
    https://git.kernel.org/netdev/net/c/aa637b2cf303

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


