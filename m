Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348009;
	b=Lg2ePtVtdKu/sbR6+cHngi/E30+LuucFuGnbAL9ypli8DKjO1a1pk6ErOW7escDYamR0
	 YQCfoixk7DwuN2DxsaZcJXizRuxs9a2oNFiPPryTuj4jarhOUziQF2mXie6ZGXklyE8es
	 sYrP9VEY2oJYiXtaYQRe2Mws7TLQ2X6paJxnIZp31FK30hvFnJEmymI6L9ttGA+QvQEM/
	 p1CAvX4IdEwJ7o05M2qu7WqkoEgBkB/ViKo1tf1Yfp9rW9Z12cvsDc9aF3qNl3EcQ72x9
	 mVmVJfc6ROWzRBOUgr+4AfIBA3q4abFNp+pDKob789SNbNTFV+rvJgR19zRRfWuNMaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348009;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=5RSmde0zxXDdRGWf5Q/i3X5J0VvjyKZrx9ZczAHQDMo=;
	b=G4JweJXXJjAvO7sTgDsANS7lSls5/714ErLBwY3ehytD8CV+IhqJgt84ndatIfrxXs8E
	 tU+zwlryujvA9CcZa/J2nAzWvJjgslGphE9A9sPWFku3wpZF9ahU8IPufihf9yVF/ocK5
	 QPi9kcnyNTrnJmB+bddp9W9c/dW8sWSeeqGiHauTE1NrQCb9IV3eRYfRIpSuHejp6xLHb
	 E5IDOZU8EY5ABG+fvctYy4YHbfG6N/8Vd1p0/Av3DeAGJZuBWT0qmVgblpJ0ubPDbf+M7
	 KyrUtow+NMoC9poSrsYW/r2DUZMsQlMqvvz2fVIn7Shz+Gbv5bobt2IXTkM7U1vu1LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CC9Xb4iM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B593606A339
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CC9Xb4iM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2531F0089F;
	Tue, 10 Nov 2026 22:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348009;
	bh=5RSmde0zxXDdRGWf5Q/i3X5J0VvjyKZrx9ZczAHQDMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CC9Xb4iMiRfxof+xPR+UU/4bdciA2TUY1rHgnvBfWAKEOmt8MCX+rtc34rKj7EFeM
	 Y94C0hHyEQKJEyYp6PXThea0rzKcfIgBE8yrBwfQqAj7/HUgODVi/D0SyPDakn8p+8
	 nKfq4DuUMQO0zSMcQ67GM3Znu7Vn/W/xKbbmIMFY1gmTGoCVjtOQ+yMdSsGYVawtzG
	 QHtG4rWe+2CCmdJLA1xDTu4UYI0TTJ/YF1xPEzrCJFPvGRxGMuYVmBFmf3Fc76T3tS
	 gj07cHQmdz44DNZwHUY/ATGpvb55q3rVOadRIjc69x0/MWWn/RokBysLNJwoRcRMyg
	 yqFD2RfLRBEcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20F1E39E8A40;
	Tue, 10 Nov 2026 22:00:09 +0000 (UTC)
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
Subject: Re: [PATCH v2] shared/asha: prime volume before starting audio
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179434800767.80411.13470774413251516410.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 22:00:07 +0000
References: <20261107010019.1162372-1-cochcoder@proton.me>
In-Reply-To: <20261107010019.1162372-1-cochcoder@proton.me>
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.von.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 07 Nov 2026 01:01:13 +0000 you wrote:
> Prime the Volume characteristic with the cached volume before START so
> both volume inputs are initialized when audio starts. Keep the write
> best effort so a rejected volume write does not prevent START.
> 
> Assisted-by: OpenCode:gpt-6.1-sol
> Assisted-by: Codex:gpt-6
> 
> [...]

Here is the summary with links:
  - [v2] shared/asha: prime volume before starting audio
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4287b3addc20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


