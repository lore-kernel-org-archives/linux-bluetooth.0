Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268BD3C3445;
	Wed,  3 Jun 2026 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509011; cv=none; b=pa1DK1xmJS0XchdFYu3xpCJLjVX2G2S5KIhNpMKUSVnai5dgXN3zB2LIfyEKV2PDIS600QVSZvTc/p6CNxjSQpSfnW+yIPQzKkrbEVeYCk4M8YjC52P4/lfB1nG6yzEaXEv5K143qn/ZZB+jjVp+0GCZnNyodeWbbURRP4vfKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509011; c=relaxed/simple;
	bh=nIS9kzjECTdTJN5fyT+F8xRBB6UWZF9ZRaWT6epPSaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qv7AvoW6gj3XY7zNJlz8wxDMFq3ecnPuxoOcyElLHa9jIEBd+6gD+mh27EjXFnGAbk2HeK3CgAgCqRCA04GOa5rvWk2/VmIwhpu7qdnAvD0H5Fts5kJWJI5ASNKgmksfnE/FRwX/WxHvgXnURe0LCacWXA/opFulwZ9M/hVBIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8NKvgJo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8NKvgJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62CF1F00893;
	Wed,  3 Jun 2026 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780509009;
	bh=wEsXRuniu7E3vt7vkmYum5JVgqtkt/DKxf6rgO1ZqYM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q8NKvgJoRanuoqE34fd/PcF41IptrAQ2Phi1mtgkD+iEiP1KRZFjxg/S4gfnr8/Qi
	 E1gKvSQmS7xM/2lV9mWJ7SVW5ipwv7hhpRL44W5mUt/7gEubgbSxMSDOCUnFGakapl
	 IOCBPoUTdQNo4d0CY+2RKiHdG49ib/MVntfcIOyL/zgXkjDvKdap+JiVPDy86uspih
	 CFnjvvDrET2V49fcK+obah07HXid23zItuQjnlA2rDkOzx90Fbx3j5ScYgQLCblhuI
	 GrCqwT7TvfjEKsK5nTzdOdos8Svjw73ZUjujniRoOKwiwf1fNmKodYwsDelRjcz4ut
	 9uJAJWthb5ScQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5684B39308BE;
	Wed,  3 Jun 2026 17:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: hci_core: Fix UAF in hci_unregister_dev()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178050901088.1520440.5455772548360225875.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jun 2026 17:50:10 +0000
References: <20260603085047.256779-1-jaggyaur@gmail.com>
In-Reply-To: <20260603085047.256779-1-jaggyaur@gmail.com>
To: Jordan Walters <jaggyaur@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  3 Jun 2026 04:50:47 -0400 you wrote:
> hci_unregister_dev() does not disable cmd_timer and ncmd_timer
> before the hci_dev structure is freed. If a timeout fires
> during device teardown, the callback dereferences freed memory
> (including the hdev->reset function pointer), leading to a
> use-after-free.
> 
> Add disable_delayed_work_sync() calls alongside the existing
> disable_work_sync() calls to ensure both timers are fully
> quiesced before teardown proceeds.
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: hci_core: Fix UAF in hci_unregister_dev()
    https://git.kernel.org/bluetooth/bluetooth-next/c/eec3deaeaafe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


