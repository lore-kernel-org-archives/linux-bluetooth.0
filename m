Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348008;
	b=IrAzblafHN1x1+KCnyisnbiuFlS/ptCgzn1T4A944tYwE34CQfQ/QDmBVST2ZhUsZcFl
	 vn9c40f7eJzJHvXaQQO/2mG0RuMVQw3fGdp1iACCyzPV75NDNSxQR0lPEZgqMXs083bzM
	 AlRNWgeenWWaBMzwdzFNmgANvl0RGtPu/JCeA09YQd3cOHKP9ID2q4xWzIN0eGXS6tE+H
	 iNmj6bXFttY+ShNGU70Gbyzz9QjAEHmxAkcb/CZKuBqIY33401fuB7tDOZ4nd7+lRLM0q
	 Rgmikny9mJc7UCTO7o3uG/p85VkYbh4szOrRT8KyZUD7oLvvTsUj3Hn132FY3qcnulA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=bmUuv62LRSLsVY78+TJnCpgkOEmrytfrT6iTJntt6hQ=;
	b=ObvMqYiGDipK58gboLMRESO1YLDI2iT3MAc0Jjka31+N0fKqahUr5N8OLuZWnw/EEl09
	 +UMVvaCPksIdn973yTd8hbO03FVfS3JzTtrxQ8vvFX5ElkMMG2iBTw3joFsc5MOajoKNh
	 9ZKY7kBZJHxP9QhIJr0BDHtlctjKkPOiPJUc6+v21puQ3G7//IKb4h0qLzJRsE1sMSTyZ
	 lgvg1QdIaVjutEUksFrFqibn4C9X0VJIYYridIVcoDOHSlZRknFnb65Jq6a2m5w/1kbrf
	 4s5EKfuqWYEQMqhBsIh4MtB6i8d+jtX3eA1M3HBnetcMY2Bdp/SuHtoH/ZGETERy63A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Hdz/5F4T";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF3F606A326
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hdz/5F4T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EED1F0089F;
	Tue, 10 Nov 2026 22:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348007;
	bh=bmUuv62LRSLsVY78+TJnCpgkOEmrytfrT6iTJntt6hQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hdz/5F4TDjGEP/LWfK6mG7OrENQ/ScysBNsFKCSn3xyX2yQLWfayZA1hO1+sS7+1D
	 XuR1IjuKotq0iS34qzXqPQwG8Eo4REXG8D0l03F5gtohlzKyEAy2+PAr+9/lahIkMv
	 01UBTds4xXKwXQ6W11AkhiGq5k8FESjyGArOiYLq8N6VivErTUgBrAq+Rhqm2nIeBY
	 EKoZM1X53BcV0H5/tLgwjX/FVbIHIxrH5GAxj07PSMetHB8QX9ldAlKxl0hvxqNnQN
	 OCniNm+JVm49nBn3+Xt7xohJ0z96Y0rD1zixmFVeF6Le+OCd1/Y7qPEJKws37nA0tD
	 snT5w4S6LSrOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B0CF39E8A40;
	Tue, 10 Nov 2026 22:00:07 +0000 (UTC)
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
Subject: Re: [PATCH v3] asha: allow LE 2M PHY on the audio channel
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179434800644.80411.18152097439079968356.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 22:00:06 +0000
References: <20261029030037.1300725-1-cochcoder@proton.me>
In-Reply-To: <20261029030037.1300725-1-cochcoder@proton.me>
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Oct 2026 03:00:53 +0000 you wrote:
> Allow LE 2M alongside LE 1M on the connected audio socket before starting
> ASHA. Keep streaming if the kernel cannot set the PHY preference.
> 
> Assisted-by: OpenCode:gpt-6.1-sol
> Assisted-by: Codex:GPT-6
> ---
> Changes since v2:
> - Drop the standalone PHY unit test and its build/ignore entries.
> - Reuse the existing test/simple-asha playback script.
> 
> [...]

Here is the summary with links:
  - [v3] asha: allow LE 2M PHY on the audio channel
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9659adb6819d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


