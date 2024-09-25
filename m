Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3303F172BAE
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277635; cv=none; b=YqOSom13MWnhPovvUdy4oI0KwEyVPeHYKBk4Qlv/1IVwcBkoj3/K4LP1uk5NPnX4X0c6Go3/q3x78/V8fVaBBTSWg/VKvEh9ZRy9g3fuMGXB8vMmu8hZM9gJ+OxQyfPt11t+q+PFdFvcPLaJ5tfgX8HQEClFBL+4FL8Wn7xvwoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277635; c=relaxed/simple;
	bh=yy27AXw0IrQyNnFIjkdTZB6FxSwhs14p9tsUHx/7cwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uRz85wMhmHlf8y38vW9NQPxFBl9lGkaJh0uOE5IgMkaSxeLm7qAj2gW1jC0MzlQGjAhFfapsT2Xz7H8WXnely+q/rvjwPmAUYrlfjNMts3SV3mO879rAGsWSSq2OAiMv3M4fozporCS7peyw08+hr0l3xhG6xRTneEpS+/Jb9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNYDwLwe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNYDwLwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6F0C4CEC6;
	Wed, 25 Sep 2024 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727277634;
	bh=yy27AXw0IrQyNnFIjkdTZB6FxSwhs14p9tsUHx/7cwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tNYDwLweRVISHWxTRezeJ2bkE3jgBvOWONpB3DEnz+mHx4KKpg4+b+cHmgC67QNkv
	 4XIc+QRUklvR37yFF6QTS8A7Xn0JuZXv07Gn58yGwpyCxjDAS2i9ixVwFHCVTTCtyu
	 a7M6ro/Auj4HENGhcFKxALl6dKwaaZaXXc8ddlAT98QeV/lbnBLv+2D8UIuzUd/sNF
	 IivFaoZ7WkULvi2GECjGga7ZfFIZ3JrHWHki2SHH84ODUsWQDB3g5p7osy5bRmKq38
	 k2YIXAJh7KBsxVD3XfMQArebcGIaWjt8edI7x2rBKGe8WWSMaFofUpGQ9X6/TNKusB
	 BaFw1RlOVkKcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C953809A8F;
	Wed, 25 Sep 2024 15:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix uaf in l2cap_connect
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172727763699.630403.15935443908419707597.git-patchwork-notify@kernel.org>
Date: Wed, 25 Sep 2024 15:20:36 +0000
References: <20240924153237.1727485-1-luiz.dentz@gmail.com>
In-Reply-To: <20240924153237.1727485-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Sep 2024 11:32:37 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [Syzbot reported]
> BUG: KASAN: slab-use-after-free in l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
> Read of size 8 at addr ffff8880241e9800 by task kworker/u9:0/54
> 
> CPU: 0 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-syzkaller-00268-g788220eee30d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> Workqueue: hci2 hci_rx_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0xc3/0x620 mm/kasan/report.c:488
>  kasan_report+0xd9/0x110 mm/kasan/report.c:601
>  l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
>  l2cap_connect_req net/bluetooth/l2cap_core.c:4080 [inline]
>  l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
>  l2cap_sig_channel net/bluetooth/l2cap_core.c:5543 [inline]
>  l2cap_recv_frame+0xf0b/0x8eb0 net/bluetooth/l2cap_core.c:6825
>  l2cap_recv_acldata+0x9b4/0xb70 net/bluetooth/l2cap_core.c:7514
>  hci_acldata_packet net/bluetooth/hci_core.c:3791 [inline]
>  hci_rx_work+0xaab/0x1610 net/bluetooth/hci_core.c:4028
>  process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
>  process_scheduled_works kernel/workqueue.c:3312 [inline]
>  worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> ...
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: L2CAP: Fix uaf in l2cap_connect
    https://git.kernel.org/bluetooth/bluetooth-next/c/d93544ba0cd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


