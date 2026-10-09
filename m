Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C49C4E50A6;
	Fri,  9 Oct 2026 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555621; cv=none; b=H8FZ7PyW3+lxWqwVe9xmj6qBSbBqcniVIFaRn7fiTjnq7GGmDymhGgXCAZPWe7mcZNu0xkgkMpTxeF3E7qaUTYdSpX4ZKyPJtoJiVLgeFPKC8CM7fVWZuL83NnydSlB6O0pTBwAdzvHdQiNPOofu71gA34g0QZMrDMbj5tRBy6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555621; c=relaxed/simple;
	bh=Xlgs0IJiBMFCNQVxHGLhO7WuxzDrLoOfPb3HJcAu4Y8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UC9ZX0bLrZGt6R8kDR4PPt7S8rzG+9XiMuIhglrn2jQLgF0y+3HDZx3mKWLyY+6r/dncczrEtA+tODI2FQnzy8bnrV8ubUf4vTMVXS4e2MS1jr8SpeNIuVq3iUCknqWybqpV3SY7mEcE+nOMx7neHy+CPMe6qgW6gC7i5RP92Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmSl4kCb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmSl4kCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F0D1F0089E;
	Fri,  9 Oct 2026 14:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791555615;
	bh=pPNLtS9iupuASeopcLWI+wDb0dPJyEh2B/4OvQxYMcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CmSl4kCbEYbRPvmlFVXBaE8HG6NETxHiiHzmIJ2aavgtEGHTGI9Jvi4oc3ET3WDiQ
	 398pyi7aB0eyWG4FTzL2EtwPfxNiUc8AI7tUFzKFJ1+0Ay9aOOVFxSwYDePu2RggGm
	 oiGH/lTLAj+fF3kXuiT2P74tMHA7Cc+BarUdZB81fRIYJJQfACInBdFIggGgFk3Xbl
	 87aGocodxKesKRx9+hbMt2jS9nByP+KXjWgMs+s0X/I6YbdVp0SP/W20OP524lNKrO
	 urqYY4gSS5z0RyojBJmvfvO+yfmtcRD/9Z9KjgIzW2B2JG1LSgmTAgec5t1LTAGgY7
	 1lJg7MxrqmdRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F137039253CC;
	Fri,  9 Oct 2026 14:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Protect IRK identity reads with RCU
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179155561351.812174.8832870892083391062.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 14:20:13 +0000
References: 
 <pm-bluetooth-objects-candidate-0130-v4-50db5732ff5e26d28412@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0130-v4-50db5732ff5e26d28412@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 Oct 2026 12:18:50 +0800 you wrote:
> hci_le_set_privacy_mode_sync() needs the IRK returned by
> hci_find_irk_by_addr() to remain allocated until its identity address
> and type have been copied into the command. The finder drops its RCU
> read lock before returning this borrowed pointer, leaving the later
> field reads unprotected.
> 
> When a privacy-capable controller has a pending peer with address
> resolution and device privacy enabled, accept-list programming can
> reach this helper while management reloads the IRKs. The request
> worker holds hdev->req_lock, whereas load_irks() takes hdev->lock,
> allowing the following ordering:
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Protect IRK identity reads with RCU
    https://git.kernel.org/bluetooth/bluetooth-next/c/9cbb87f8951d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


