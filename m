Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859209;
	b=H37BQr7TAmNnNNQAsqnB6m8oxbKh+GWKccvMrCdr3wx8yW/H7iXeLo/p8rTagdVSMPnj
	 R/I2lVLYxn+ELHughxF4cmaOG51ZMzLz1LtxJBIjIu0usd7vSraoWaJucd1zhEQ8cyd2j
	 xb4PhUuZcLvwwB/SAHvN78N/DWQPqcAunD6mzpYDwgScqbHZ9uvwZWZ9l1HbA+E8ZUCAE
	 ZQpHJB7LSmW/iig/Ars8yelqVJynyIb21ITJVc6bPM90G5YZyOBX3kiG1xde3cnhkGcsm
	 LKL29xbRd8Zw8am3yHWSu7a1WPc/59Z4sQ3h1SuMYwFuTxeKtOgzx6mpi6lOgBqFIPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859209;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=91OfgRam5ZFGTEbGd79c2jIxwPemL9VGCSHHN/+oxag=;
	b=C9pwGMME/RN4mIoRrjwe5HozskbCC1xRtaP+Xmfybc8uQfvutoleFGgmOzBIT34cs5Gb
	 ZV/QgNYPa6dh2MsX0rLPfPoPTprnAQKTT2oHujXQGePKTHktof938htA6kwM/b7MEPzQ5
	 6q+4HSAsNyK1ffB8JP3LTcfj9oPyKHmyBxjmBooZGWQbJByn2hs83ySowUz+KQJSANpMF
	 sGLKE1HW+02F/4vAEe2TdL6pxSjkgvDcF0dNe8UzvTSvMvLD6HGlpv8ykqcZfBeNEd2YN
	 QLYl2fVOZ1WLC16t2owduKO59R+i509C6HjpxyiNFyahSYU7NOfqm6ERhV3fm67zA0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzSkjNmd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42277606A323
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzSkjNmd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091821F000C4;
	Mon, 16 Nov 2026 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794859209;
	bh=91OfgRam5ZFGTEbGd79c2jIxwPemL9VGCSHHN/+oxag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jzSkjNmdrTcILQTxfPQbfYiY5NBUTedk42s+VAhOIOJUTfDVJWRPdSudg5xib5EoZ
	 XwQHboYqwlP3ZYM1VCbtyIU7SUasSkE/iO6Ggo1oOaWWc000uP/OxfLe2pW00n3T3G
	 yD1nFcibR+Tcz7ei8LK1XgeVqMoXQXHIWMgNQiAy7yCtcCDf0o1mfc7zwtR4mwFLgx
	 WYbxy0g8yd4PVC5R4xsNpKQ0OuTDaN2yI0qATKjWIwLPZlpyln9I4UAweSLUrPZZeq
	 G+W6Il0JIEic5aUO+Z9gF6bQEMYgnO6pvKD/vNqb18K61fQBVgJ52CTQguramFV2MR
	 NRSLBgAD2Kl8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1452391AFCC;
	Mon, 16 Nov 2026 20:00:08 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ] bearer: Fix LE Disconnect for devices with a random
 address
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485920752.3860040.6706283991399325723.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 20:00:07 +0000
References: <20261113042744.55832-1-kevin@simpleble.org>
In-Reply-To: <20261113042744.55832-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Nov 2026 20:27:44 -0800 you wrote:
> Disconnect passes bearer->type to btd_adapter_disconnect_device(), and
> the LE bearer is always created with BDADDR_LE_PUBLIC. The kernel looks
> up LE links by address type, so for a device with a random address it
> finds no link and bluetoothd logs "Disconnecting failed: already
> disconnected". The link stays up, and the Disconnect call is not
> answered until the link drops some other way.
> 
> [...]

Here is the summary with links:
  - [BlueZ] bearer: Fix LE Disconnect for devices with a random address
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f9f3a6eca27a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


