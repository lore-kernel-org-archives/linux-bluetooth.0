Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A678F8F7D;
	Fri,  7 Nov 2025 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542636; cv=none; b=ptip2wOLEGrWTgFkCyntboqCng2EpXr1ogF/EnIziyuFtvAzWKSQmWakinpEHenmiUvomKFxsgvNVZe+aLGATtDtP5ByslGKvWU9uQUwQn3YPBN46qNV2Rn3rNs9BRQt0MV9BMrmo2BNpCA4xRY8BPBx9NMSwA8XyPAUhNyo41M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542636; c=relaxed/simple;
	bh=8qHn8+UQeIk9f/F1IbujgP2G6FPbz+JtMSg9BBac8wM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QDBlZ9oplyFAZEOhWMJxLhDsWxHrip5QDlLZ/7qmskavYaXMy82B9LKBbkY56oN7wPADiDCAtqsbs4Pt3GsUSoGJULaAuyvju/5eEUZvqa+gH0KzMFd0y/ia1LMgy2SpdcJyplQ3qFAD5ht3DDEPRMovy5+veYypt6Gt9KYoLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYvRmFu3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYvRmFu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B3EC4CEF5;
	Fri,  7 Nov 2025 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762542636;
	bh=8qHn8+UQeIk9f/F1IbujgP2G6FPbz+JtMSg9BBac8wM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eYvRmFu3U47ztgsKcePCbN703bi9algtBCqXOVUQZ5CYQzLC+bMluR3X3BynZrzQQ
	 7ycUSEJm1dr1fDYxjLTA6yvcxru+C/t77UMgj1lzSCsIlyhKmy5+R28JEdl0jqiuT4
	 FRpFAiMfoOtWLoIwACTV7VXWcey2Bh5l//rtJNL80CGunuBuGEowGYM/nu3Pxn9FCG
	 xd6qw+DiPMfzarzD8qBeyTcVtRhP8cgQqTskCw8YrTzTfsRat1Ck+i1rhMv/8qUy2Y
	 LHEYHz5Qcyf3QPIvyzPyqEu35lpzxvT3SRaaZ06/Wu/WkuoJ7bziB/Fxy+foMYKk6J
	 hAik583Lf2thA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE37339FEB7D;
	Fri,  7 Nov 2025 19:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/5] Bluetooth: 6lowpan: reset link-local header on
 ipv6
 recv path
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176254260850.1132280.1139292633245300172.git-patchwork-notify@kernel.org>
Date: Fri, 07 Nov 2025 19:10:08 +0000
References: 
 <467024bf1ba60184bff304d23de33abb0ed2384f.1762194056.git.pav@iki.fi>
In-Reply-To: 
 <467024bf1ba60184bff304d23de33abb0ed2384f.1762194056.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 johan.hedberg@gmail.com, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org,
 pmenzel@molgen.mpg.de

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Nov 2025 20:29:46 +0200 you wrote:
> Bluetooth 6lowpan.c netdev has header_ops, so it must set link-local
> header for RX skb, otherwise things crash, eg. with AF_PACKET SOCK_RAW
> 
> Add missing skb_reset_mac_header() for uncompressed ipv6 RX path.
> 
> For the compressed one, it is done in lowpan_header_decompress().
> 
> [...]

Here is the summary with links:
  - [v2,1/5] Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
    https://git.kernel.org/bluetooth/bluetooth-next/c/7de8dc9b760c
  - [v2,2/5] Bluetooth: 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
    https://git.kernel.org/bluetooth/bluetooth-next/c/c7409a88d204
  - [v2,3/5] Bluetooth: L2CAP: export l2cap_chan_hold for modules
    https://git.kernel.org/bluetooth/bluetooth-next/c/35d11c1cf51d
  - [v2,4/5] Bluetooth: 6lowpan: Don't hold spin lock over sleeping functions
    https://git.kernel.org/bluetooth/bluetooth-next/c/e1cd2d7db0bf
  - [v2,5/5] Bluetooth: 6lowpan: add missing l2cap_chan_lock()
    https://git.kernel.org/bluetooth/bluetooth-next/c/fde5b271c88f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


