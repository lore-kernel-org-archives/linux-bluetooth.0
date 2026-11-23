Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461020;
	b=Wq5kTomZMelDLx6Pq3RV8l6EA6dW+R4MHOPd6Bm9fN/irrOkWLtDDhAhdAtrNbMKOL+8
	 N35IpFk2gicPCbCre19cRwPMzz5SCi+KC5KY3/SG/84b9xEr+U3tX1N/QiHCdhz9QZVbk
	 gtvdIK+hp0FJxFZYl+1PitdmyZMd3XdpOi6lntJAKpEoBwpV1uAyqR0+XdiH3/mqX8dDa
	 BwLzGmVmuKuN0WoKQuqH2R0nDGYK9KMiV6qbaoOheoPoFaw3vO0ae1kOGATC9pZJ34ANJ
	 x+onRmY//1IpuJlfpoHnrBztpPFjPMZ0jj9eaSPM6inoOkHi7t5yt9MGcL2WsfBmGcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461020;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=lOcYzGvDjwBXBprHGxDzOW54Eicdmu4H7ygeOXl4xOA=;
	b=UQLNoSYhqf3Z6MQMdnOqklwZWOv+w8dQHsivp5DZE5AwbVpanOepDtwcSZUyn0JmkGid
	 tY+3XnVzcGVPsDBtNF8Ooi9rfRFUGlSVjuButmkjTtEzrkhibACKnd+lo9P3fBk5uUUsu
	 QcwixKQRbMl8XuJUVdDdvah6Hkzgemjho6dijspYSOmLeBjdSfe9p1ZHHhSI3LuaCEopi
	 Z2ugOsW661btvJb8A1ENzsf6QR3ky5ScAUYZYwYJHodt/yFI8qa0T6zxKP8BvyW5X8fy4
	 /WlZmAfiAx9tL1uwNXKg/gSYu4iXqMViPczPgDt+A47jIL7otdgrl69EXvESGDcoldQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXhnHLtR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BCF606A31F
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXhnHLtR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4F01F000EE;
	Mon, 23 Nov 2026 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461019;
	bh=lOcYzGvDjwBXBprHGxDzOW54Eicdmu4H7ygeOXl4xOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AXhnHLtR7np5Z2nqPp0xoK71pail2Z4cdDaja5c/34AeRuwz8Zwh+hqeHk0jofXe6
	 ukIMtsOXJKeT0Nb8p5RhnUB1rpFxResG76yjG27I0iiwu7t2Qx85o6Lm+B+AyCwCiz
	 DqyCEIvPOiS7FL8V01nleAxrKVHQ6z4MuBJrjQJeEdbyEokv2l3uBM84iQS2n98vYP
	 CVisPryVaeFxtZ5Hh6I+UV6d1wGIoYGCvRf+QtF62HWu8DS78sOLDenf6jCAyTD1wN
	 lAFBHzgG0i3VtgkmRaBJ92TbPzIGrwVxOode6QfdlGfAtj30bEIBA39zBEtAo1bhmz
	 JTrDPLmBGrr0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4464392EE35;
	Mon, 23 Nov 2026 19:10:19 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: SMP: Check the key size against
 le_min_key_size
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546101826.3063022.15655460068815072023.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:10:18 +0000
References: <20261122153336.1527432-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261122153336.1527432-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Nov 2026 16:33:36 +0100 you wrote:
> The minimum LE encryption key size can be raised through the
> le_min_key_size debugfs entry, but pairing still checks the peer's
> maximum key size against SMP_MIN_ENC_KEY_SIZE, so the setting has no
> effect and a shorter key is accepted.
> 
> Check against le_min_key_size. PTS test GAP/SEC/SEM/BI-10-C needs the
> minimum raised this way.
> 
> [...]

Here is the summary with links:
  - Bluetooth: SMP: Check the key size against le_min_key_size
    https://git.kernel.org/bluetooth/bluetooth-next/c/770318402e35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


