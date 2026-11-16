Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851422;
	b=g6Nxl7rD0iIPEBQ9K0D9ZktIUTq/12cuoHbKJY9cdzQqT87W6nT2dTVitkBrDaIbPcrw
	 qw6U1Gl+0hFNU3i6t8Xj1YO4G8HhcCCFA9rMusf5hMqCsPoQ8pTdmudZ12gQJtrKg6ItZ
	 BE7jQkFYJGUirI1Sjlt7ZjRgBccgot8F65ltCS2fypjPd3eKo4paPQVDLjzFP/Gy7EJsa
	 Hrn3+mWCm81C64LdJoHad5una19hkRfNOsNPaO8veUnXiMJ9T5EgKeObLLdWoCjivU3wV
	 PZjlJwoi3AboOnew3UQqpBh/L3Pra1VLzxu2m7H+kwtnlSjjO5u7NmgpchVV0UbamGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851422;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Adq0k1FJEIAXTzZOZYDnypYWVrau0w7XidkDVX3jipc=;
	b=mEAcaSnuz2flsZZ5OKZhAw2xGpf8Ppxt7VPG5LzbyUvyFJadF+9h5AyTccFcjwhgJrjF
	 Txri3newSdoo53zkE2PGzZ11B0bk+Uf1rO6/3v/AIZw8Q+AjglqFSIZUyUuU4mi32j7xF
	 xCbGJaMfr/etNW60WEYmUTYulJGPPepxzYdWEkwAhxfviqmjMn2V95tJg/E7dQFhD0x/k
	 TU0S7NetCJJGZtbBpInVduYGUwye7y2uzCySyFaAcYE+x12fwCyKmfNAPWPXMZDoxbJe2
	 ydJX7lG8YM5soclU0bcn4Rkmj5jGJE4rQlstjoBOWlFSEoyLTvpUOm8P+1NEMKWY5GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ht8Z8n10;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073BD606A31C
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ht8Z8n10
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36C51F000C4;
	Mon, 16 Nov 2026 17:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851421;
	bh=Adq0k1FJEIAXTzZOZYDnypYWVrau0w7XidkDVX3jipc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ht8Z8n10bmkt0hKBOwgaWXFCc65GQ33Nw6Hh6eCgENtA6NraZdxFnzlAnZQndwuKG
	 tVJwMj9qrfHJq4mjvm8z5YPSwiL5hoRlYyWHnFHPSG5VfqfhRyDf3DmBvTAEOlexFp
	 SJXg+Ilz1CQcHsw3qBwf2DCR8fx+nTU63teChdxkls45nuKrlgWh9q0n069kgeQWw5
	 QTGLqeB3sR39HUGJkguNjCxstDl/JCGF3jQ8xOd1Kmj/D1r48SDO95hZrE1WsUE2tu
	 /RLsq9CVQApoxJm+WWPhe18sd4KQ390Q8ocZ/IU7ume/qOaos6F/kvVWyhmyOWk4dF
	 gUEbKtBh5f6kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9BAB1391AFAF;
	Mon, 16 Nov 2026 17:50:21 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v3 4/6] client/player: Add endpoint.clear command
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485142027.3796096.5711904589172896494.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:20 +0000
References: 
 <231c6e7909673a62925ebf13cef9d7e537ee9da6.1794428234.git.luiz.von.dentz@intel.com>
In-Reply-To: 
 <231c6e7909673a62925ebf13cef9d7e537ee9da6.1794428234.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 15:37:31 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Add a command calling ClearConfiguration on a remote endpoint, to close
> the stream of a given transport or all the streams of the endpoint.
> 
> Assisted-by: Claude:claude-opus-5-5
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,4/6] client/player: Add endpoint.clear command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4d6b6de326ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


