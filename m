Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426019;
	b=yom7XJuLXORjbmQCz9oeSVEm0TiMsbpG7amusP7IK2114KqfSpb9Fv7MC+Uf6vCZ8G1x
	 Lc8w3WK57MDkG98ExRB7lFpi9ZfBjr0vC9RxriPE9KWgOPAZy7UwPH2G2AzVzHYFuGStt
	 SEow8Gl9VTkq7McuFjRsrk4J/+Mxfd6W2LIelX1QpIEjLB8+LTHtPw+Wgx65RTYrw8GeU
	 kWuknBwy8MuJyQHylp5nwEXiQox/bK/AvCWw+x6LSRBfzb3SLYgAEj1dQW/jXotHMvpOw
	 q4Gi+sAVnjdoQ89IhU1bTei3CmhJgYn+hieFms1+e145jMT4tjxjeBd9OeJsgoa27iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426019;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=WXrjfOZ4gvp3OJDwPgDdVpkcS64EwyB9cy66b0IxTFs=;
	b=aC+QXuOpE3/SoJoB6IoKV5w/c4dMC3E2hhvzI4+0xIzTA/KZGI5kl0lYRnfiWmvyo/xa
	 tOLnu5bw4J0Z5OBjbdoMu1sLUsZ6gyYNRYUv4Sfka5hpLlhMg0WPeTZcgq5BCbcQBMpwI
	 Owpyyucsp3CYAjHVrjMpDEaR+sjku4yBRuo2UTBIkibvvm9wtksgGhNf1OUaPyrkNxnal
	 Br7d+qq28zhKEctHWTTFoCZtjuK+ePwI432PmrhoT19i5t9zuWwjrSNPMzCRGN+X1BrUm
	 UJmjFV010Kl/Q+Xgi4D+OTACzrUuBfLVplOhjeCanZTq3jrCO4eqpYzym1uulP/Vclg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJ36mWcE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E6C606A335;
	Wed, 11 Nov 2026 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJ36mWcE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD7E1F00A05;
	Wed, 11 Nov 2026 19:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426019;
	bh=WXrjfOZ4gvp3OJDwPgDdVpkcS64EwyB9cy66b0IxTFs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SJ36mWcEMXVH0JYNMl9AizIREo7Z1QQxNFLaxAGkTl2AbXMgjAKzdBAY0qqzkGMhR
	 yoQk1t3a/CQmp/Y+a5E9MsKu13mDny5vj05C6lc8iYrZTvzQk0L+ohc5UXB0/iymG+
	 kWmC9aYhI+HtkgNtiiADlIm/fhIE4LSC1TBD+BiR2rmwr9hJVopnFnuGAnMztcdYb+
	 raEX+3hPpaIqy2/cZGaF9YqGInzuv5ZZXFpczzcjMnmxI7y8+0BU7Yz54RZtdUVdPP
	 NEZuJFlflI6DSSHRte0ozs1j08jwFINydc08SGF5zedsW2m6hk/NXZemhio3Htzt3k
	 bEntExIZ+bOag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 210BA38003BF;
	Wed, 11 Nov 2026 19:40:19 +0000 (UTC)
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
Subject: Re: [PATCH 0/2] Use platform Bluetooth addresses on Broadcom UART
 controllers
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179442601766.1604530.10253398492524205694.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 19:40:17 +0000
References: <20261110-brcm-bcmbt-mac-v1-0-c68003a06f64@kernel.org>
In-Reply-To: <20261110-brcm-bcmbt-mac-v1-0-c68003a06f64@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Nov 2026 11:45:25 +0100 you wrote:
> Allow local-bd-address through the common Bluetooth controller binding,
> including its six-byte little-endian representation.
> 
> Enable the existing HCI core property.
> 
> Absent, unreadable and all-zero properties preserve the existing setup
> path.
> 
> [...]

Here is the summary with links:
  - [1/2] dt-bindings: bluetooth: brcm: Allow a platform BD address
    https://git.kernel.org/bluetooth/bluetooth-next/c/05ad7f2dee07
  - [2/2] Bluetooth: hci_bcm: Prefer a valid platform BD address
    https://git.kernel.org/bluetooth/bluetooth-next/c/afafcb373fd0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


