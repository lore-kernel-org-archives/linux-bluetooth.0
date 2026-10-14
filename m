Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFED5650EB
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998415; cv=none; b=raVafH6k4+c1wdRIj030ga+L3GFlyrq8G/+00OBMVWrfEqHyPxaWh6q6KQODASdD9+4n3BekJHYXeU6eAVzJF42RywCVFKgm377PCJig7HA7NYLeW/7yW8EwEy3YrFTiNcnMDvwP1TPaVnCDnmPONNC2THFoTxAq398VNtSU3Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998415; c=relaxed/simple;
	bh=0Nzf3ztPsAJi79Kemu/WJVTNMGN3/KEwP+h9TQIS5x8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kQPdxDIkZwie8ruuFelIZnuch726Xrc2uB1TpaCW8IknjaZESANdwZxFmxeELFxpKUIl6303jLDCO5wDo5t42t79D0ogS3OHsEXVHVntGBHIFxPgTsRcNYigedtHcUnPY4vat2tJzVOf/k5obS2qA8gTYzb13N9js0hKyUgAfH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmvdYN9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmvdYN9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA261F000C5;
	Wed, 14 Oct 2026 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998409;
	bh=9f9vX0LX31CJazOHVo5gbjc9WKnFqlOVnIUM/Qw/uFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OmvdYN9xhHqeYpGMCeTGDIdG58XNhr1IZapUEXIwhuVc22ilN0lLv2x5qoawbfYLD
	 0ug1Haf8Fx06k5yHs9r31MJtZMJCk7/r+qoxSsTTEFpHUOlHsViM+b7ZVY2qbmFYhU
	 GsH204g9gBZ33W7kFxHgG0na9TrLLwNJC4wlVFfFokP2AAIEzp9A8Jx2FPkD6xFM+R
	 fowD7hIrQb1p8hE12AWBhiScbRu2aHeZG0Li5kAfqB6lqA+kkIXbUUH61SnFlGVZSc
	 gKBOKXkIAESaX8+eHOddZuseHUqXv0kIcx/2LEO3kBVjmxUI5lqiOGnzsJiV6pXfw5
	 autxJRGp7htag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7738839FD335;
	Wed, 14 Oct 2026 17:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/6] Bluetooth: L2CAP: Reject mode changes on connected
 channels
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179199840801.2868755.12692933554278230678.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 17:20:08 +0000
References: <20261013153720.2635387-1-oss@fourdim.xyz>
In-Reply-To: <20261013153720.2635387-1-oss@fourdim.xyz>
To: Siwei Zhang <oss@fourdim.xyz>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Oct 2026 11:36:33 -0400 you wrote:
> A peer can send a configuration response with an RFC
> option for another mode to a connected channel, for
> example to switch it from Streaming to ERTM mode.
> l2cap_parse_conf_rsp() then changes chan->mode, but
> l2cap_ertm_init() is not called again, so the ERTM
> sequence lists are never allocated. The next
> out-of-sequence I-frame makes l2cap_seq_list_clear()
> write through the NULL srej_list.list.
> 
> [...]

Here is the summary with links:
  - [v4,1/6] Bluetooth: L2CAP: Reject mode changes on connected channels
    https://git.kernel.org/bluetooth/bluetooth-next/c/0ac766c5ed8b
  - [v4,2/6] Bluetooth: L2CAP: Reject signalling responses in invalid states
    https://git.kernel.org/bluetooth/bluetooth-next/c/0ff5a6d955bd
  - [v4,3/6] Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests
    https://git.kernel.org/bluetooth/bluetooth-next/c/2c5c3688eb61
  - [v4,4/6] Bluetooth: L2CAP: Use default TxWindow for zero socket option
    https://git.kernel.org/bluetooth/bluetooth-next/c/da927e6e6bf5
  - [v4,5/6] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
    https://git.kernel.org/bluetooth/bluetooth-next/c/c3412d73414a
  - [v4,6/6] Bluetooth: L2CAP: Remove dead configuration state code
    https://git.kernel.org/bluetooth/bluetooth-next/c/734dbeb9338d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


