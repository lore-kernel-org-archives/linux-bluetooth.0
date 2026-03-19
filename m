Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E085038B157;
	Thu, 19 Mar 2026 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943816; cv=none; b=P9SEl+d38pMHCco2mScBFVp5jNpmcXhYvTJ4lKJDpEWMsvkJxLswpOlevDrHIwcp+XHL0TISe/gbici0vGmU+2gB1xV7upCRG7CS8OE1GTTzlenrMR/atSL7uCTGqzwyz2lXd26MocHiNUyU+U1ei1ST1/dZ+Q8rrQeLFWq6VZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943816; c=relaxed/simple;
	bh=sZiTmYrsUk3RUBvFsAAi3lyghGzQyivIt5Xa9sQA0w0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tmE2kLPL/gyAel+uUFiE5p0SZ6hfvZgeIgiiIhb3xymHaijITOulbGnyA7qpNP7asCTT0dRyOPUR1gl8zJuxYV/2VKfhIYPZ2qgStw7VZOCo1MRChu8tz79B/+EC/teaQe035w7m3ex7+tRyDvDcCC4uiFFSUitmpQzNz8VUAhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrUjU9eW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrUjU9eW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3FDC19425;
	Thu, 19 Mar 2026 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773943815;
	bh=sZiTmYrsUk3RUBvFsAAi3lyghGzQyivIt5Xa9sQA0w0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XrUjU9eWB2CmormeHBPILWeJtReOLMP3805sfI1GQU2UHsJlzfqQepN7zeb+K2PZJ
	 iTdzfALjlgFNmpy7eq+vTsiFrkGdTlFyJfDZ6d7I7q6yckPFuAtfexpWmJWR6qwAat
	 SXS9ias7Z5SjzDLrTPzx1u6b2GSNJhwbKd+el1O6kjKrpv4CImWDM0yxYedO4UjYB5
	 QKmeV86WOBLE/BEDyTrjG6142jtHRNTyvDHYgKyQ29y2/qdMCTMnhCY/u78jQ5Wra4
	 34G2jpc/Dx7fRBryhF1s+V2VT+6ax8J3aGDRADl198YKsn8A0KZlSsAnEQeADCZEiw
	 0rB5Tz1uh2oXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FD239302E2;
	Thu, 19 Mar 2026 18:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix null-ptr-deref on
 l2cap_sock_ready_cb
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177394380653.1743613.2960784486260115087.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 18:10:06 +0000
References: <20260319115804.2160822-1-koike@igalia.com>
In-Reply-To: <20260319115804.2160822-1-koike@igalia.com>
To: Helen Koike <koike@igalia.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 19 Mar 2026 08:58:01 -0300 you wrote:
> Before using sk pointer, check if it is null.
> 
> Fix the following:
> 
>  KASAN: null-ptr-deref in range [0x0000000000000260-0x0000000000000267]
>  CPU: 0 UID: 0 PID: 5985 Comm: kworker/0:5 Not tainted 7.0.0-rc4-00029-ga989fde763f4 #1 PREEMPT(full)
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-9.fc43 06/10/2025
>  Workqueue: events l2cap_info_timeout
>  RIP: 0010:kasan_byte_accessible+0x12/0x30
>  Code: 79 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 c3 cc cce
>  veth0_macvtap: entered promiscuous mode
>  RSP: 0018:ffffc90006e0f808 EFLAGS: 00010202
>  RAX: dffffc0000000000 RBX: ffffffff89746018 RCX: 0000000080000001
>  RDX: 0000000000000000 RSI: ffffffff89746018 RDI: 000000000000004c
>  RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
>  R10: dffffc0000000000 R11: ffffffff8aae3e70 R12: 0000000000000000
>  R13: 0000000000000260 R14: 0000000000000260 R15: 0000000000000001
>  FS:  0000000000000000(0000) GS:ffff8880983c2000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00005582615a5008 CR3: 000000007007e000 CR4: 0000000000752ef0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   __kasan_check_byte+0x12/0x40
>   lock_acquire+0x79/0x2e0
>   lock_sock_nested+0x48/0x100
>   ? l2cap_sock_ready_cb+0x46/0x160
>   l2cap_sock_ready_cb+0x46/0x160
>   l2cap_conn_start+0x779/0xff0
>   ? __pfx_l2cap_conn_start+0x10/0x10
>   ? l2cap_info_timeout+0x60/0xa0
>   ? __pfx___mutex_lock+0x10/0x10
>   l2cap_info_timeout+0x68/0xa0
>   ? process_scheduled_works+0xa8d/0x18c0
>   process_scheduled_works+0xb6e/0x18c0
>   ? __pfx_process_scheduled_works+0x10/0x10
>   ? assign_work+0x3d5/0x5e0
>   worker_thread+0xa53/0xfc0
>   kthread+0x388/0x470
>   ? __pfx_worker_thread+0x10/0x10
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x51e/0xb90
>   ? __pfx_ret_from_fork+0x10/0x10
>  veth1_macvtap: entered promiscuous mode
>   ? __switch_to+0xc7d/0x1450
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Modules linked in:
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: Fix null-ptr-deref on l2cap_sock_ready_cb
    https://git.kernel.org/bluetooth/bluetooth-next/c/bc280a5ed9ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


