Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4827D33CDC
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARZ/ym95"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF6DEC433C9;
	Fri, 17 Nov 2023 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700238023;
	bh=I4XpBTySvhzHxZn8SvCxlHLKBMiFYF/DtzvPGPKJPHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ARZ/ym95zCIHaXOrd2L4SYrX/XDvOfcRnGzvMS1Zhrh1nTCbL8ZuGi/GpWN+RqRuL
	 ipw679dDIxongC3kv63vnUreqTLnnQNS+JLco69uAuPY3CN4lPo405WGt9CiW8nKHN
	 6TkMhVZnzKAa0k9PhaEYOiwz7Ok7DxnE6dTkeZKlqmDOlHJo9ga7ebp4vKqFO7yNQk
	 rowD5SydwKaXjXDaNGp91aBE87oIO0BSCqlajB//uKEbUMv9V530JDAXiQyebKqAtA
	 KtmJSXKJgWGKcLfATdO5YTXYC7AWARCTQOywmPO8JyoXJm0P58XMt7QBxFkMdErKz8
	 ZoMonxv2RHZGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3F28C4316B;
	Fri, 17 Nov 2023 16:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] Bluetooth: Fix deadlock in vhci_send_frame
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170023802373.26338.14180238759984531392.git-patchwork-notify@kernel.org>
Date: Fri, 17 Nov 2023 16:20:23 +0000
References: <20231110014605.2068231-1-yinghsu@chromium.org>
In-Reply-To: <20231110014605.2068231-1-yinghsu@chromium.org>
To: Ying Hsu <yinghsu@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 linux-kernel@vger.kernel.org, chromeos-bluetooth-upstreaming@chromium.org,
 arkadiusz.bokowy@gmail.com, johan.hedberg@gmail.com, marcel@holtmann.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Nov 2023 01:46:05 +0000 you wrote:
> syzbot found a potential circular dependency leading to a deadlock:
>     -> #3 (&hdev->req_lock){+.+.}-{3:3}:
>     __mutex_lock_common+0x1b6/0x1bc2 kernel/locking/mutex.c:599
>     __mutex_lock kernel/locking/mutex.c:732 [inline]
>     mutex_lock_nested+0x17/0x1c kernel/locking/mutex.c:784
>     hci_dev_do_close+0x3f/0x9f net/bluetooth/hci_core.c:551
>     hci_rfkill_set_block+0x130/0x1ac net/bluetooth/hci_core.c:935
>     rfkill_set_block+0x1e6/0x3b8 net/rfkill/core.c:345
>     rfkill_fop_write+0x2d8/0x672 net/rfkill/core.c:1274
>     vfs_write+0x277/0xcf5 fs/read_write.c:594
>     ksys_write+0x19b/0x2bd fs/read_write.c:650
>     do_syscall_x64 arch/x86/entry/common.c:55 [inline]
>     do_syscall_64+0x51/0xba arch/x86/entry/common.c:93
>     entry_SYSCALL_64_after_hwframe+0x61/0xcb
> 
> [...]

Here is the summary with links:
  - [RESEND] Bluetooth: Fix deadlock in vhci_send_frame
    https://git.kernel.org/bluetooth/bluetooth-next/c/0be46f8900b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


