Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050813;
	b=wnkx5IgHKDO21zRH4AKlVKD4l/QgHm2WzZaktEROZANz8VBUpopBUaC6K+dfzmxPlU2e
	 YVzUrsaTpuF30aT72e4mXxUO9fPW5EvdZdOFHv0rlfYRsuV6F2IRYxZJkfKH4gNN7Kicl
	 4WRTsLGeUyELY2wSYVu6IUXuG3i12rL6ZVFtUskFPkK5/EJywMGAi5YBaExcA9hZrbNGv
	 pY0AxvqwbMpFx/y72ce36L+1oSaX4srGsjVKbAy9yfoAQ3jVd1IeW2qtMSHLTmvqHrFrK
	 h+zRUeCLuYJ4gNfJQkF3uX8ewRvMNGBq9etXbO5maKD+aS3ZR5L+sMQNsK0lTliSPTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050813;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=jybjVITDNoG5vk2GuEVGf5hOCiMgxTtTuknwSLngsS8=;
	b=RkT8RBbaFYLrn2/IAKebKpzA/+aG8K7IWJOUAK7FEhzPwBxBXVQN6ZfScMPtZFCR9Ykh
	 z8kxKvPP1pcuFQEPQ6FSB9pfwppElkjixi2Y3jx5qUgUjxybCeP1qvzXivQk/8tYyUlLg
	 RbkI0dNkcnBw+lKsJ9dcuuuRhqv+4otBQXH8qH+xyAfUOX0zoIuzQibwn143NDxdBFk2V
	 Bpr5GKjCwKzUp/Z5doUvX4lufOVtyJbsoPFlZ2aFRd03fFHKJmtXeeQECJlYKhiSzuvr2
	 lpxQT+gJyljXD4h5FyZnPgo1M0SWu4GyurFeIPUXykn5E92AWyfkgxnJtpzLnjySmCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PbWIhqCt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D951606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PbWIhqCt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3051F01825;
	Mon, 26 Oct 2026 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793050813;
	bh=jybjVITDNoG5vk2GuEVGf5hOCiMgxTtTuknwSLngsS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PbWIhqCtGHYM1Glbp3Oe7MleF9aHPKKoSBxCh0ohX4+O/b+HQxWyqulVm5ZYhm5hn
	 /jWjOmtyopmVcB+jOstUbUjBjrdfWCk9jRexz/V7zD1Llob5CCDseFdwZm7Qj1xsrY
	 BMLENQQYhomdosWWxkiRvbCq9tsEPoOKrJLvH3rxfNDUKoQF1/15SIjE4h2GbmI7V5
	 ba/5nhV/KZhkRl8kx+GgqV9oqugttx/mOKZG4oGFeI+aZNaXs0f4KBaxjdP26j4cI2
	 43n/mR+rG1QPk/N4LuxwBZQglMvacqjyIaqPxICuE1v2s24PfnLYzx57wq8ElH3DqE
	 3wLx8RQhQR+Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 073BB3AA80E9;
	Mon, 26 Oct 2026 21:40:13 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ] adapter: Don't power on while blocked by rfkill
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179305081156.3403508.3916224596739406026.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 21:40:11 +0000
References: <20261024103255.81769-1-tooangel@tooangel.de>
In-Reply-To: <20261024103255.81769-1-tooangel@tooangel.de>
To: Tobias Wilken <tooangel@tooangel.de>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 24 Oct 2026 12:32:55 +0200 you wrote:
> btd_adapter_new() reads the rfkill state and sets PowerState to
> off-blocked when the adapter is blocked. With AutoEnable, the default
> since commit 180cf09933b2 ("policy: Change AutoEnable default to
> true"), the policy plugin then calls btd_adapter_restore_powered(),
> which sends Set Powered anyway. It can only fail, so every start with
> Bluetooth turned off logs an error:
> 
> [...]

Here is the summary with links:
  - [BlueZ] adapter: Don't power on while blocked by rfkill
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aa3d6c761cb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


