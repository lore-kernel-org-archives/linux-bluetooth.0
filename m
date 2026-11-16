Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851429;
	b=g7+7I23RCu2MBl9U9Xrg5XUUGCXluJjvT0NKS6bFre1dqXxs4gsY9F1EbMWgUILN/bWy
	 /bfNfIP8w+tCE+lkn2u9ue2OogfC7dATxa/5990x2vn6EQ3CUXQONzK7qqKJ0+L6j9MYJ
	 3QOzvmoL3+IwOgjGLcbePtgufnLDSX7irTkurJMPdR1I37vidtu8/pgLiG6iZei8UmEDZ
	 YwovPAz/ndvwXZWgDs5D69uGMaHiY8+3z6WUrX3CfXg/hX/7agoNYFBsdxKsv9mUK6rL1
	 /eNavZHk15iqMwArcy1ntgi2BWOG6zSvZ5NYqgIIJzXlynuNdVrmS8MiyALu/LmfHmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851429;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=pEKD6HIcNgPLeKxw2epwJ+FVy8aWcz0QZGGEXf4zKXQ=;
	b=DjtmNMC88CzBXJms/hQ9Fn7omJXN7JNvzVckKbjLsLMX+tTInnXRMdpow9hovs8PNGBH
	 LhjTEaVKTxGz3HyOL5VCoM4cAAhi1e1eORab7AGb0HYNYPHdBmhBtasNaQTbKCr/lGzQ0
	 4RH/uN05US4iv52mmK4jeuiHjH/xqIdq2jw0arf6YB8svuTdskofZT3tdLRt5Zzf6IYp9
	 1PJsXXZ2rk27xheyb00nfeaigJZppaUiYcKCy4kA+O72/tv+/D4k7BjpNT5MNTxq1dUNX
	 UDjUVukadsTysyNC+lBoKxY0ZNI6bYe1HHPHKwVqEuL4gyS4XsYxXxT2RSMfou7H2cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rjij1fnJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE2606A894
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rjij1fnJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072DA1F000C4;
	Mon, 16 Nov 2026 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851429;
	bh=pEKD6HIcNgPLeKxw2epwJ+FVy8aWcz0QZGGEXf4zKXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Rjij1fnJzX6WRP4KhQMTZkIHHEzGbNBrsyYNVGwt3lf//4XzCHV13OgvXXBsf1Evq
	 uRW/oAB3wiRS5HpFWxKImZ4wIPaFTF6eOf88TOwRACu+t/Igl/2980Mi7wSuMekW3K
	 Gs/5Yp03v6NzwF2D7IMbBCEzzkOpAnIZyoMXKddFOb2Qs1HPJxo2+P2CFvXDmtQOVV
	 RidvJtd5ctAhaBfuZ61qryG9UrCieAGilllzbh2/8+SAKEBWDKsIBUzjDH5ulVzZSM
	 LMTAzX6AMpASRT0jyocFmQheqSeuVGbsYkDP9LCTffHOMXnyCWobGuH5SAfkeeCLkR
	 RcKlM8McyeDIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13D5391AFAF;
	Mon, 16 Nov 2026 17:50:28 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v3 5/6] doc/functional-bap: Document clearing a
 cached
 configuration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485142752.3796096.1712472411872637670.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:27 +0000
References: 
 <e1e4f723d0a169b2703c626bc03a925491007e7f.1794428234.git.luiz.von.dentz@intel.com>
In-Reply-To: 
 <e1e4f723d0a169b2703c626bc03a925491007e7f.1794428234.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 15:37:32 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Describe the test where the initiator clears an endpoint twice, the
> second time releasing the ASE whose codec configuration the acceptor
> cached.
> 
> Assisted-by: Claude:claude-opus-5-5
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,5/6] doc/functional-bap: Document clearing a cached configuration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aae21a5e6d50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


