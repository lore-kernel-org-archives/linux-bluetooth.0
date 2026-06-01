Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D037436A000;
	Mon,  1 Jun 2026 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341005; cv=none; b=MgNGXYLab9TVsy1Br/KcYgvnEo57aOBeI7crv9bEFqG+jKPJ8fJCLsVcxz99uHtCpLyZtmuDtPfanBcJzEhkKE7OLgDECOZhLwA4M6tukmUUgk1vLMYnuO6aLtnCaPNo8E+IIfcoNMHpIDkPqnzEmY0Su8iOTYCs7Blrc0GywaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341005; c=relaxed/simple;
	bh=j9UFCS8LPGV9BjMmAYlivuF43WOG91jPQR/KLpEyvBo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rxEEgYe+wRCDx/nqq3W6PQqVJdiyk9uk8CudvJandKfixuel/mkCFKHpBLZtCMDEwn89Pm4SN8MbG2Wp6SpEGvV06zLtl1AF2uMnq/BKVZF95ZpwDHH49zawREsr0KEnoJwBbRm5NL0l4qFqMKmmW1YZO1jfWEI7G2LCSkm2xfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjHH51ls; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjHH51ls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C801F00898;
	Mon,  1 Jun 2026 19:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780341004;
	bh=W/2LSBQaJFcFsT8kbBFhvAJrJfpKiU3ht2fXzVJxDwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VjHH51lsvkY7wir4jr4uy6XFScby+plWDsl+UaurGobPwzcCwhac3BujKTmYrJ+So
	 k35sKVpop6PhgpdzQhe5HbEMK1K/dtIU1xbwOgi2vh/KnaGibTS2nWvpQt4KyaCFOH
	 VLUhXbJQrTyr5CU0vJy4N4DZqfViYmygj346UZBgDWdF/5o45yhAJpvD8rfsmrZaGQ
	 ++AoT5qY+FzSyDu8MIe/+lFvsyZpQWnN+HSn0zH5ESUvG/BqISS4F4ya07BUZMEfzI
	 QZN/RJ/hWNtCjevJyLu2ORWxapYa2Hi2x/cHXJ6EiKwvWaBJr2oYBfDOmh/WHjibZN
	 wRcgTqP+K0lWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D338119F4;
	Mon,  1 Jun 2026 19:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] Bluetooth: fix memory leak in error path of
 hci_alloc_dev()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178034100713.57646.870172727099680394.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jun 2026 19:10:07 +0000
References: <20260601032426.119034-1-kbreddy.rpbc@gmail.com>
In-Reply-To: <20260601032426.119034-1-kbreddy.rpbc@gmail.com>
To: Bharath Reddy <kbreddy.rpbc@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  1 Jun 2026 08:54:26 +0530 you wrote:
> Early failures in Bluetooth HCI UART configuration leak SRCU percpu
> memory.
> 
> When device initialization fails before hci_register_dev() completes,
> the HCI_UNREGISTER flag is never set. As a result, when the device
> reference count reaches zero, bt_host_release() evaluates this flag as
> false and falls back to a direct kfree(hdev).
> 
> [...]

Here is the summary with links:
  - [v5] Bluetooth: fix memory leak in error path of hci_alloc_dev()
    https://git.kernel.org/bluetooth/bluetooth-next/c/cf767a2d88f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


