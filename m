Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F9839A057;
	Thu,  4 Jun 2026 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588348; cv=none; b=keCEHTH7scmkP+12ogg+7CB3cS4+b9inLsZxKmNtv6LyXjpSmB/I3OaNL4+C0gbEiaeENkN1lLUZVSm1iitrcRY2FDx3Fp4VvK3K/Jc7g769qcLYssvQDGFMwAZ/kHNKFSflGaqxgYqBBJUVekTNuI/ZKfNWX8t/9Oyf2MYiwbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588348; c=relaxed/simple;
	bh=P8MHPSZPmrH6q0qIWHnZmDhQixQ2ut4kEWLKjDmmFUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aNuMCnBTGR5QoLTR+FQFI+a8YDc/6vElnqFNOkkeNjKEvpwCFOMFtQ8p1LWQvuddt+O9zQzWxJ/+F+QLF+WNS/ml0nmixqIsANZDACdw5Kj1kBQTTcuVkUbo+Ru4ISVCWczQeyQqVz4746yOx1IHcg1xiKWYv3LEM9vNIavjaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itmRtSBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itmRtSBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CF41F00893;
	Thu,  4 Jun 2026 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780588343;
	bh=AE0pxkh+mJNJpXmQyhoZ8PL1FjYDrw39nD0gpqQBxXY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=itmRtSBmNRhFH5iwEV/nfCPXEbFGcc0i+3KIVTtlcL3xPT37VP/F4U92+2x8fBO2o
	 zvVBEpxnQ+67qs85+7OyYQM15PgfQYbZP8Y+gnQHoMXphN7sYgMixJgEA1gLRIyyxs
	 wEz7C4yVb5OUKqJhZNZuw5SgRNPLaf99guLt0MiGI6A2S4yVjzEK7JixTxP38moL9i
	 D6BYogCMwhyvonngjzmJ6FIpWbT9YBGXEZacfmfVDhsF+Hby/JpBCFwrNDlorH1lfx
	 wKHZEo1iq1TcqeZKXWNPjVqbHS4PrlwVWm2esfhGK8QY+znOqK5aR6ZHLE/uTqQqQ1
	 yXWaxTM9ajVfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939ED39309B7;
	Thu,  4 Jun 2026 15:52:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/5] Bluetooth: btusb: fix wakeup irq devres lifetime
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178058834413.2488052.9198416432295112289.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 15:52:24 +0000
References: <20260604063740.2595260-1-johan@kernel.org>
In-Reply-To: <20260604063740.2595260-1-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Jun 2026 08:37:35 +0200 you wrote:
> This series fixes a couple of use-after-free issues and a wakeup source
> leak on probe failure and a (currently benign) OOB wakeup interrupt
> devres lifetime issue.
> 
> Included is also a related cleanup.
> 
> Johan
> 
> [...]

Here is the summary with links:
  - [v4,1/5] Bluetooth: btusb: fix use-after-free on registration failure
    https://git.kernel.org/bluetooth/bluetooth-next/c/5cb8a65f22ed
  - [v4,2/5] Bluetooth: btusb: fix use-after-free on marvell probe failure
    https://git.kernel.org/bluetooth/bluetooth-next/c/71b6d1520ffe
  - [v4,3/5] Bluetooth: btusb: fix wakeup source leak on probe failure
    https://git.kernel.org/bluetooth/bluetooth-next/c/8c23d7dd662d
  - [v4,4/5] Bluetooth: btusb: fix wakeup irq devres lifetime
    https://git.kernel.org/bluetooth/bluetooth-next/c/4415cdce0ba4
  - [v4,5/5] Bluetooth: btusb: clean up probe error handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/e8b3e4c62d8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


