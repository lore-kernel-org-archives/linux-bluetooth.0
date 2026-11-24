Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540809;
	b=SkN69vMfJGQ6imgWK7RGc/i2BqoZIxOQaAgmeSnAY/sH4CMNl0hcRF6qIqAZBI1lyGGc
	 z43cfxjoSq2N/O9+7BoiYHwiT70gQ90jSAZZzCHuvgY0MnWIZClZmuZMR/4Mu39RQvQzz
	 rzhHLeuVCoctVGPC4JF8RhENtYO4XV0xCPtYsq8v4ftbhxQNN8oySWwPTRsd/sUWcG7TP
	 NSGYsPO2nr2aOuHDh5C3W9//EOeYOMs65CS3+yIYYCAA1YL2HXqc2P0AqnDyFHozTchM5
	 aMf1d2TA+5FWXtiOAPk/CT1qcJGApKn+uQjW+ju+tha9IzDWHIA2E42VE6F9Kr1PJmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=piyMwJR6rBW30kFd2H6lW70gdy5i6sNbjvYZVDM3H2s=;
	b=Z9cnqlI+C0d3YFC0i7ygQm8Iwdf7ShjfGIV6o4TskLIq8DKJCKXmBSYMzKogMT3WbZMC
	 PYu+auRd1V3Lz70QGun/ohitNZuPQ4Qt69aLYAVlwNJykx7txbVcG2geiqTwhOx0tvR01
	 MbBnicpdprwMY8Y9mLSEJKx+p3dtBABTbZffiXDFSVrGdPzqfp3air8tSjpbVkQVepFd7
	 rqHnWZgAliZmMqR0sBnzzYpNKEPQYZNAdvtkr+uJeOufp1j3i88TmU3986l2kIUzVgtAa
	 1id5H+B8/N3uF671Fe51Ub/X7Z6sPqD3v0dUcXhANItVM4k6P10/JjL2pmv0PDJWiHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eaS5OaXU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C552A606A327
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eaS5OaXU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E0C1F000CA;
	Tue, 24 Nov 2026 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540809;
	bh=piyMwJR6rBW30kFd2H6lW70gdy5i6sNbjvYZVDM3H2s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eaS5OaXUsJY9iVZzntfaPTfuuGsoQPs/CGky+/du+6W9LJC/xNtizXczlotwSp62Y
	 R+4L4nkwkScAkn67Lln3FmBpx98O0Yc50rKooccC0fZJSWbyU5Z5zk+xhQnE63xLjr
	 eHQIL4Fm2Uvb0wl5ycrviMbI2G3uVk9r3ydHOLZTUDC3LwSEwVRKZ4q8slzkdp5mqp
	 5mOxOwelrVDk/c+3wDOwQTXo7gEknBnHIqHqjC4cnW21euqBrIo95EPicm7RuXYCRO
	 jQB9ADttODTkxoktQKawhg50O6pIWOpqghMB2yqTR+5NXRPc+SWF47frzade5PfxyO
	 9nqvX/nwz3w5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F163D3938FA7;
	Tue, 24 Nov 2026 17:20:08 +0000 (UTC)
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
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: serialize RFCOMM_CONNINFO
 dlc->session
 dereference
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179554080777.3669449.2938682800558673060.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 17:20:07 +0000
References: <179550683515.38654.13328780695859519079@gmail.com>
In-Reply-To: <179550683515.38654.13328780695859519079@gmail.com>
To: Qican Ma <goonsomeway@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Nov 2026 15:53:55 +0800 you wrote:
> rfcomm_sock_getsockopt_old() checks rfcomm_pi(sk)->dlc->session and then
> dereferences dlc->session->sock->sk while holding only lock_sock(sk).
> rfcomm_dlc_unlink() clears d->session and rfcomm_session_del() frees the
> session under rfcomm_mutex without taking the socket lock, leaving a
> check-then-dereference race against concurrent session teardown.
> 
> Commit 46f8ffd0a1f1 ("Bluetooth: RFCOMM: fix NULL dereference of
> dlc->session in RFCOMM_CONNINFO") added the NULL check for the
> post-disconnect case on deferred-setup sockets, but did not serialize
> the dereference against concurrent unlink and kfree().
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: RFCOMM: serialize RFCOMM_CONNINFO dlc->session dereference
    https://git.kernel.org/bluetooth/bluetooth-next/c/77bc0f253ff9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


