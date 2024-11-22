Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97027082F
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732300219; cv=none; b=Gsyhz+aOeODzFoRdyJ6AIO4ih5jnBL8uybVtW38RxBXd7MWXFuXW/zHxNsmHyCdzW+VPi++mo+wfrpkiHCKCoYDBSOWcqV/M5VCzLEPlqeHCsZ7CrvQBl5NADGj7qOXU0JESbRrwdJV3wBYD7cB8Sjy5pb6Y6E8a663CesFHWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732300219; c=relaxed/simple;
	bh=iEUwTDqWLceTabGvFBeiLYcLjfQZXZuwQk1KHHIYZyQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UT+qOPZHM2cWJWDiFNu1or/kjFHCxeIq3DeP0MENmhC+HOBqg5QUAHyJXVOq7BadzYVfINI9SZYo5KLuymL55Mu4N/liaZg9LtCNhr6LvjCTqd8L+FcOWfKvhV30PIUwpkz8xOLzwi7x76X00wAPlsMu1VSiYQm2O86KyjYCOqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdPKoiGj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdPKoiGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DF3C4CECE;
	Fri, 22 Nov 2024 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732300219;
	bh=iEUwTDqWLceTabGvFBeiLYcLjfQZXZuwQk1KHHIYZyQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QdPKoiGjuV7H16DNQF4xdlY8U2MNiQCcjlBluDnf4R9CtYYdqxUD8EdDqrKTsZ2Jk
	 13MKtXgfkq/263+vGTQinqURHCek4SzWOZXwykfRAk595XvMwHscvIEGNKBRGdSifB
	 i4SDZUuVfFY7iqTSFEbwfxA4Tft8/A+B0gJqN9udUzjJe00+WNg7FrXxdGjJp0qAYf
	 emQsQh/k8mlNzRcMfl7VEcBgFpczNr/5kDjwMx9Mp3hwE9tuFo8+b6z9GnXmO5UX+F
	 zXDXUfNNwZZgi+QuQ2D8BlQd4yzK0kgMyiQd92at+w/o/O4X0UWf9VJuXa84PqzT3n
	 lx78R7EzAJI6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB32F3809A00;
	Fri, 22 Nov 2024 18:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: MGMT: Fix possible deadlocks
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173230023177.2761600.67535148027454591.git-patchwork-notify@kernel.org>
Date: Fri, 22 Nov 2024 18:30:31 +0000
References: <20241121164335.3848135-1-luiz.dentz@gmail.com>
In-Reply-To: <20241121164335.3848135-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 21 Nov 2024 11:43:35 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes possible deadlocks like the following caused by
> hci_cmd_sync_dequeue causing the destroy function to run:
> 
>  INFO: task kworker/u19:0:143 blocked for more than 120 seconds.
>        Tainted: G        W  O        6.8.0-2024-03-19-intel-next-iLS-24ww14 #1
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  task:kworker/u19:0   state:D stack:0     pid:143   tgid:143   ppid:2      flags:0x00004000
>  Workqueue: hci0 hci_cmd_sync_work [bluetooth]
>  Call Trace:
>   <TASK>
>   __schedule+0x374/0xaf0
>   schedule+0x3c/0xf0
>   schedule_preempt_disabled+0x1c/0x30
>   __mutex_lock.constprop.0+0x3ef/0x7a0
>   __mutex_lock_slowpath+0x13/0x20
>   mutex_lock+0x3c/0x50
>   mgmt_set_connectable_complete+0xa4/0x150 [bluetooth]
>   ? kfree+0x211/0x2a0
>   hci_cmd_sync_dequeue+0xae/0x130 [bluetooth]
>   ? __pfx_cmd_complete_rsp+0x10/0x10 [bluetooth]
>   cmd_complete_rsp+0x26/0x80 [bluetooth]
>   mgmt_pending_foreach+0x4d/0x70 [bluetooth]
>   __mgmt_power_off+0x8d/0x180 [bluetooth]
>   ? _raw_spin_unlock_irq+0x23/0x40
>   hci_dev_close_sync+0x445/0x5b0 [bluetooth]
>   hci_set_powered_sync+0x149/0x250 [bluetooth]
>   set_powered_sync+0x24/0x60 [bluetooth]
>   hci_cmd_sync_work+0x90/0x150 [bluetooth]
>   process_one_work+0x13e/0x300
>   worker_thread+0x2f7/0x420
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0x107/0x140
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x3d/0x60
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1b/0x30
>   </TASK>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: MGMT: Fix possible deadlocks
    https://git.kernel.org/bluetooth/bluetooth-next/c/4ae007fdffc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


