Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851433;
	b=Uv6G/b+O7es5NAtyzccQFs006HC0t7LjO8C5yg8FlqdJt7d08jpijnD1X1jIQiBzI8bz
	 mLx1D6Y2WPSM4NkjhE4vG5ps2s8S6MoEFMnKJ/orTYKIvwFkBV1w8mQJForvgTJvTkXaV
	 0w4L2BFb9QPSbFIxqoA4PtDT3j/JKLOWnn2Ja3a4iklwZQeMVhbqRok03Z8LrBI0xnA8H
	 gAk8Hi2apO+PIYRx3jiNvbyspRHIY8/kDMyOemGuQMvt113wYkisn01RnHWfXheGp4tnQ
	 DFR8qzOkG/LgFE/ecRoit37wf6dlzz5LG6FQglJV1NQme8Ed9OrJFIprFNjyRD6B4Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851433;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=l5w8MCAYQPOITdAxA6npCP3nzq1z1MLI1KV2ZDUKit4=;
	b=2ligw1rzGGc2K/uaZCNvXhSaLpiKra9VZtrAhQJiBbMzHNrSjvWaxsgew0ToFKVy30AZ
	 MaKBypEAYax0YwOvTBoCdeCYNw9Jz8mBfXpqn/GU0E7RCI00NJ4HOa0m9NlXnlL3E/4k7
	 wP+dbPoUm0z0gLpE622Dp5jF/qY7qSi1Dkc7sMAUhBHtJg/atyA95CWBB447ifUhl0v97
	 DKj+HbKlUsJZoYuKPGu7TjzaSyExv8xN7piE784UWQd3MQLA7q3CiCdQc/4rfgN0V8DcL
	 /9TdxEOIhfr9vf9uTfBcGatzTgxHROpFm6JAAd/IWsF0OlM2Y3eh+ETXU4dcL5u6R8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uv0PdVjw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B3606A886
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uv0PdVjw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820FD1F000C4;
	Mon, 16 Nov 2026 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851433;
	bh=l5w8MCAYQPOITdAxA6npCP3nzq1z1MLI1KV2ZDUKit4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Uv0PdVjwBmbQOCPPqqgxlJLR2yMx4oGwExYCDVFRlQADRJES6a7qmAKuitQUlAdgs
	 Fi953/hBNG5Rd4FT3JmVhZK03iIarpW8s6Ule8xbaCtmqahnQo4V+eAj9OgDBFFPrZ
	 nU9hyJkSvwCZMXj2wY77L+7vwralGpZ3Vu+t/S+BfXF1gbeb94fytJGZMv/icfa4Ot
	 TXH1byimDz/HrsLTXNy/9xx7p6wuyNzAAo8kM7Xpd9C2C/RsaEdAEGOkVxuy9HzKfT
	 mSo8u5V9PjEVn+YprLA5fIY+kLlD5jxF0EltC1GWKAJpSYLL5APp1ihgIMDhbND5NE
	 uTmm4ENgYVUsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77278391AFAF;
	Mon, 16 Nov 2026 17:50:33 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v2 3/8] transport: Clear the owner of desynchronized
 links when removing it
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485143202.3796096.9801443737268204948.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:32 +0000
References: 
 <486839102182279ed024915e601dde34581ddaf5.1794414122.git.luiz.von.dentz@intel.com>
In-Reply-To: 
 <486839102182279ed024915e601dde34581ddaf5.1794414122.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 11:25:26 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The links of a transport are given its owner when it is acquired while
> synchronized, but removing the owner only cleared them if the transport
> was still synchronized. Setting Desynchronized in between left the links
> with a pointer to the owner that was freed, which is used when the link
> is freed in turn:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,3/8] transport: Clear the owner of desynchronized links when removing it
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=25a3e73a2197

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


