Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938238DEC
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990607; cv=none; b=lWUFChcf7yX+zq2lJoQe0zccI8FCD0RnAwXdnN6pp3E2NKqFmnuzrxHZP2g+d/pwFb4XxhNe+/A0Vin/6q+TmpT9qBJs+JZ/t6wvE0B/ZZPXAARSAfNduUHi/NXKE+2BJBrzMM1NXYAV8CZMFZ1dAGv4y3b8YbsHhbF9RrLzV64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990607; c=relaxed/simple;
	bh=pc+HEeeqrHMFbpo0RU1mzLdFEWI4TTtHqSsCtIoarx4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=muEWHz3hfZ46D47wr8LzhM0HJDntzAHldZw3remUqqsZQ5p8+MWMawH3aBNIZz4ICOsfjxLJfOGUOELGKwo3Ble261OxE3EPuLwyQPo6tVzq6VNsEfJ9rO/SeFRdn0+QUaRPVV1kHAMO3iCLHLWRcMgJT29xpCMjS9RyMu7hi58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGghX5nq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGghX5nq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB114C4CEE1;
	Mon, 27 Jan 2025 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737990606;
	bh=pc+HEeeqrHMFbpo0RU1mzLdFEWI4TTtHqSsCtIoarx4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eGghX5nqedKjOjtWVzBJs2Hypqb1GA+u23vUedB1CVhjbWFsp8KpcBXftnfZe4PHJ
	 nUEdZun4yecOxfkCUyuBDC2/SJGs2MJuxYu8bliqLwx8yXk5bfCWNqQ1+7C8cFIDMc
	 cUuapJdBV4OctVkokimjsOTEQuiSnJm3ihS2EXwozCMWz7RBk5gPPV0J3/k7t/oFlW
	 g6hluYeSj1q8WFZrku8gssJ+kJHjMn1FDHUtvJlaLBY6WQjNQ54A1XMZbzkTlFcL0f
	 GazvtMOn7P8CAf05FQjVjGAg3LrV8tc4kk+efaBYnT+MgNJvJsyMCUnxGcQeJngYqP
	 MzWzeR5U8i/yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB7380AA63;
	Mon, 27 Jan 2025 15:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] gatt-client: Fix warnings when reconnecting
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173799063223.3128680.7407953154936283393.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 15:10:32 +0000
References: <20250124205700.511446-1-luiz.dentz@gmail.com>
In-Reply-To: <20250124205700.511446-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Jan 2025 15:57:00 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When reconnecting warnings could be seen due to services already
> existing which is a new behavior introduced by dbd6591bd1d0
> ("main.conf: Add GATT.ExportClaimedServices").
> ---
>  src/gatt-client.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] gatt-client: Fix warnings when reconnecting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=29f0bdb545a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


