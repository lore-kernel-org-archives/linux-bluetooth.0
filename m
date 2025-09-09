Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7A26158C;
	Tue,  9 Sep 2025 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451605; cv=none; b=YD1CcWJuCAXsKWYYFyeguj6ipCUuXH7dZFe8WxymMW8mdhikSTMLFhhFFTi64ZbdfidhjxQc3tSM1fzvFO6Z8+7fom1SNvn2Gvg4aMTOlcuLGeSvI3mPpmx3e5nFrQKVQddpIyeootP1k+xIw9ViIlvZU+VHCnl7QwzhKSsYNqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451605; c=relaxed/simple;
	bh=DmT6TAnU5o7Mz3+aKVn3N2cbvOSTQaGKFU9aQ/7Z3IE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IBvJ6F5soqDnyy2YNskB8nTUERaNg1ZVtbW2hGiobYUGwZzt7AYy9l5rB16TSbaqaRlKuD5Wc8di9Ljw6QKhxy5sNQmUuWIZVwxkjfOuoRmTPdXy0ZQMzDGLnXO3SiU+P64//ISF18f6/bc4HJ4vyCFwvlJGSPxVDOB9pI4H8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyBHWsDt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyBHWsDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2050C4CEF4;
	Tue,  9 Sep 2025 21:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757451604;
	bh=DmT6TAnU5o7Mz3+aKVn3N2cbvOSTQaGKFU9aQ/7Z3IE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OyBHWsDth0JMWWD7a7fXc0DpZYkNpOKRdW1EdsQNVIt4Lfi5FO9awyEwm+3bm5p4T
	 fj/qDBFQBjUiK4BfK+OZn5hCNkKH3P4joKr1D6Eyp25P/+qhEzXC8WhUUXV4fi7V04
	 xO+nlY5bL3ehhAYwqWMHBaFYhDdbEmDJILFuC2CTw0txVuoIZQU+e4mm01fOunJPSQ
	 VFxZ32t/N1KB9QKAGX9XW3yyx6q9494nmXO6DAAxkC7+xj49bG5w4wwsvFvbjK4iRv
	 U1OP52zb9rZwWeILGLOM2DIKq1JZuvKSUeoqf0Ez9TUF0KYU+Z5xAQFX0JpWnJ9GoV
	 dlO3raKwtL3UQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341DC383BF6C;
	Tue,  9 Sep 2025 21:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluetooth-next] Bluetooth: bcsp: receive data only if
 registered
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175745160701.815420.2318120410651085608.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 21:00:07 +0000
References: <20250830200339.36429-2-ipravdin.official@gmail.com>
In-Reply-To: <20250830200339.36429-2-ipravdin.official@gmail.com>
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, mmandlik@google.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 30 Aug 2025 16:03:40 -0400 you wrote:
> Currently, bcsp_recv() can be called even when the BCSP protocol has not
> been registered. This leads to a NULL pointer dereference, as shown in
> the following stack trace:
> 
>     KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
>     RIP: 0010:bcsp_recv+0x13d/0x1740 drivers/bluetooth/hci_bcsp.c:590
>     Call Trace:
>      <TASK>
>      hci_uart_tty_receive+0x194/0x220 drivers/bluetooth/hci_ldisc.c:627
>      tiocsti+0x23c/0x2c0 drivers/tty/tty_io.c:2290
>      tty_ioctl+0x626/0xde0 drivers/tty/tty_io.c:2706
>      vfs_ioctl fs/ioctl.c:51 [inline]
>      __do_sys_ioctl fs/ioctl.c:907 [inline]
>      __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>      do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [bluetooth-next] Bluetooth: bcsp: receive data only if registered
    https://git.kernel.org/bluetooth/bluetooth-next/c/6c7e4432e56e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


