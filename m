Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA914B950
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277633; cv=none; b=PnZkSKgdJff9corWS6ooLey3zpylZ+35YEfhw8Z7cKWrmyTxTDU1btP3ZupAlI4qs+aMDqxAplN+XiFsV/XPQ7d3E4s63u/YzfZc2SonDFVdHRYUKqvyupMm/D4FISel84BENuFhUpP3wBoakXDffA0UYK3Xy/JjavW7wEN/GyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277633; c=relaxed/simple;
	bh=A5G3XvvhpQExCs8fInX2CRrrvtROWXuuUxDZQX8xjMc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WwsDsk4BIgIPBlcwDyLVyFYUu0QZITmUmfR7cHj2BKR6D9GvHmbgNgd5sKzW1kNgDc3ap21b0KhaFaOySxcc2qBXPpvIjB9+bnpEbO32omz7PrNXQu/KRU99UEtKni7PhdrAnEwVnHkD+qP5B9mxnHNYWbMj2B7a8r1sEhDrPJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u48sMXmL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u48sMXmL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4489CC4CEC6;
	Wed, 25 Sep 2024 15:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727277633;
	bh=A5G3XvvhpQExCs8fInX2CRrrvtROWXuuUxDZQX8xjMc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u48sMXmLPaPJxh6lUKJ1zkZZVzKLgH8A6VIosyZcojj5dvZJGj2gJDwNXv06YilAd
	 H7/XYqIazBq2YYtqt+kjXHGvnIEDiuLRTNktQL6D8KYqAO7zVy/KGj77JbA196qbIO
	 c+P0WzOrLBm6TJOBqncnqDJL8rxBmyqZ8i9cgz7TseuQadERfwY1aDrcplI6pElJFV
	 OF4QWD1+FU+g1hEXek/5fGkfg0QwiwWgegrizsE/4vrQB5vO//y/og7KXYV+j+GukO
	 tUThQ1adLzUHLWL6McCnfx7VGLFu7KV4XIUTZbPfiKybinUgRbvFAu1Nu3MC/bNUNk
	 QPM0fdluaQr2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD853809A8F;
	Wed, 25 Sep 2024 15:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth/L2CAP: Fix uaf in l2cap_connect
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172727763545.630403.8450411112997127998.git-patchwork-notify@kernel.org>
Date: Wed, 25 Sep 2024 15:20:35 +0000
References: <20240923165116.1540227-1-luiz.dentz@gmail.com>
In-Reply-To: <20240923165116.1540227-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 23 Sep 2024 12:51:16 -0400 you wrote:
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
  - [v1] Bluetooth/L2CAP: Fix uaf in l2cap_connect
    https://git.kernel.org/bluetooth/bluetooth-next/c/d93544ba0cd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


