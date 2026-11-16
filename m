Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851432;
	b=BGM0KplJK+oSdgZc//PDr0siBvAXXxjfsUNN6D6jMu3xalg9cixxxU900l3go+AL5nhq
	 0mTohIiOW0V+mpcZCvU1hraHGhY1sF97E997dEUVwGKmDXddQxXb/6WzbRpsry0uYTWYt
	 2sfIzIsCnClHHquzdwrgSS1m9UlQeFYhXufjqEiqDw3nYrTHTLE5yfSILVIzWVQX+GtsC
	 RpEzwDcUj0dTENC7HRH7lQ4mimeoFKYWsqvktiFH5oNpjtkbpNVYjBILXnrYuHXdRPNRP
	 qQQnQk63NdTXIYDK6YPiFaExPFStpol8ntiNxQ/S6NRnYvdGpFL2tnwxIMcE21A7p/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851432;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=l/17D9lSUVaM6RwAmX4bfIVg67uT+sBDn0CeCcJ/Q28=;
	b=VtrFDwnVl0ltnc9EqD4cZ4Q/+Kr6jPN2iMuiM+D0ENStUoV3scvIFIE1CPolNh/rFlkd
	 qV0fJgQlduSaQlUFjY19kYtwP+Rdsqje1mkicBLN8dsGf5jdxwkhUIp88cSeI2k948cjP
	 XPpm2wpIVVUzaQD+PkkXOo2W4bJMU1tKdqsJ3JJ4axTyea1fyrZ9BaZXjipE8NesdfGzt
	 kSDI3zDgv4CvI+18bE4Vh2n31Hx/+z79wT5oX62XG2B6fuutZKvK3xCbeGpuAFeZwvX25
	 rkEJrpQkk5QLrRtRbJQYX4uT+XiiXDiq/PLEKv9re1r5s6FpjQUrIUvOSwVYFWHMtaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CY6Z2T9o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C048606A33B
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CY6Z2T9o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061CF1F000C4;
	Mon, 16 Nov 2026 17:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851432;
	bh=l/17D9lSUVaM6RwAmX4bfIVg67uT+sBDn0CeCcJ/Q28=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CY6Z2T9oMNDdPbrJOKoa2Kb4Tdhgua9yYBQIG8/C6gSh+DuYnt5N+DwD7g8C9bVUV
	 3zwIPK1kf9AiYAA8+uquTrZ27Y/4aW2LxlOa0jOEdWQVj98tE/nPkl2b2TdaNys+Qm
	 cpnnhVsFgLNlmjBuPCPgA1QYEVdVYouVs4Om5zRp1FWcslHOqp5PSrW+olQmJhDnB6
	 DVGBuhY4cD2K5X82ptNLxuBlPEl0H0y6bIQXlVVr/DKZ96pce4phQ1Z17bmSJj6zBq
	 9ulk71mTDe4P7jDUNBxbt/1q2nBU9CBgiLkgdZ0Ftuow+YM6ie7gqr1ACfpRz6XiYP
	 OJWbTxZzhtSCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13F7391AFAF;
	Mon, 16 Nov 2026 17:50:31 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v3 5/8] doc/functional-bap: Document disabling one
 ASE
 of a shared owner
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485143052.3796096.84984069655467234.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:30 +0000
References: 
 <9b4196abbefc8e5284c6b48ed457a695f1d457c2.1794428234.git.luiz.von.dentz@intel.com>
In-Reply-To: 
 <9b4196abbefc8e5284c6b48ed457a695f1d457c2.1794428234.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 15:37:39 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Describe the test where the audio server of the acceptor acquires one
> transport of a bidirectional CIS, its link sharing the owner, and the
> initiator then disables only the Source ASE.
> 
> Assisted-by: Claude:claude-opus-5-5
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,5/8] doc/functional-bap: Document disabling one ASE of a shared owner
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a8d6348fceb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


