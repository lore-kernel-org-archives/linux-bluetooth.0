Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B87343AD5
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569829; cv=none; b=JbGOB+iRIRgNsuvgvh6J24DiIbSQ7l6FWt1gTu2qugtbMoV4lTm/LwG1StpYjqprsiNJCLRhGP/hrb95vQ70a8gVWjRr59oROA8r8GN+AOYgVFmCtqHOpRhG0rFHKgng83K+vr7r5DYAl2bdECOAo/AlNc/rVEh/HjAKxa+bM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569829; c=relaxed/simple;
	bh=lHREuSZmFEcJgqNM/hJAPfZexX9jerU28oELH2ngdbc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hocWd9/ZBMiaX460oEKvKAmlnZXCqgTp3/Rs8BRE2IQNkWunkX7u9v7oMWsnv/Ya+miJXsfETcYFXa3RzIZZwU0jhw4VvX6qvxNuhBnB3tcZvmjXFYV6Jh4SYX4d8V6Sz6V4Pudb8/sCCiHSRdyvEoDfLMnZMr2TuDI8jlD3zl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6s1SkAD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6s1SkAD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECF93C43394;
	Mon,  4 Mar 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709569829;
	bh=lHREuSZmFEcJgqNM/hJAPfZexX9jerU28oELH2ngdbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M6s1SkADMsulLZK5j4XIkZN4T1AkUVX2+p/RopcBz4yoUpLmW2WsJIzzLjo/t94M8
	 EAWp0bBwVKg1qCLBPQzwKK023lksDBtjvx0Zb1QDqMHXH693Sg6MVLhouupH3H7/TM
	 hYqMb0xzIxTuMqyozRx1/sdtVoI4BMJcmvS/ckggGzOKp1E/z2IPh9JKNeb5Dmzcjl
	 29K3WrK/XHVnPVEeQk2aVByaEbOLhUbpqMHL0RWbij3zrEME21OheShPVXLtiQX5b7
	 Vu88XCiqTMtuRJiebSjl/QWwuopyvqVjUh7GkgIkoN50JLQFbsplVH0Jqh9iE49KbR
	 VV+E95YaMpqyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D97E4D9A4BB;
	Mon,  4 Mar 2024 16:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: af_bluetooth: Fix deadlock
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170956982888.9053.11683995132686615918.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 16:30:28 +0000
References: <20240301185034.2756103-1-luiz.dentz@gmail.com>
In-Reply-To: <20240301185034.2756103-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  1 Mar 2024 13:50:34 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Attemting to do sock_lock on .recvmsg may cause a deadlock as shown
> bellow, so instead of using sock_sock this uses sk_receive_queue.lock
> on bt_sock_ioctl to avoid the UAF:
> 
> INFO: task kworker/u9:1:121 blocked for more than 30 seconds.
>       Not tainted 6.7.6-lemon #183
> Workqueue: hci0 hci_rx_work
> Call Trace:
>  <TASK>
>  __schedule+0x37d/0xa00
>  schedule+0x32/0xe0
>  __lock_sock+0x68/0xa0
>  ? __pfx_autoremove_wake_function+0x10/0x10
>  lock_sock_nested+0x43/0x50
>  l2cap_sock_recv_cb+0x21/0xa0
>  l2cap_recv_frame+0x55b/0x30a0
>  ? psi_task_switch+0xeb/0x270
>  ? finish_task_switch.isra.0+0x93/0x2a0
>  hci_rx_work+0x33a/0x3f0
>  process_one_work+0x13a/0x2f0
>  worker_thread+0x2f0/0x410
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xe0/0x110
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2c/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: af_bluetooth: Fix deadlock
    https://git.kernel.org/bluetooth/bluetooth-next/c/40245851528a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


