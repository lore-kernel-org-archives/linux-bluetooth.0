Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E6E21A4CE
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870830; cv=none; b=oW2XUQGAEyiTXzTEFP3R8sc41BTq4a+yqQWwhAiKuxu/xG1X5ENaGGK4bQpGcKMA8tpNqlAkBhBh7WJdR6Ux5vI5sL1CVTn6QqBoMRWRyXbJQM1YYzCvyDP5/KOIP1Pv3H4eBWHpWXx3p9TOipP2Cvn4pqEgqC5kigxqmo0p/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870830; c=relaxed/simple;
	bh=kdNZe/x/N3eEj+GaMsh3MhMCViKSPDH3i2X0I36HPpY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AU0GMeTyJe0D1UB6qaEqpTrLATlfQQptGHK3Tz0alqyvP/RMml4JW3i9/x1vxAXxwwtUlEeA46DL+c6FwA4bZz+h2CToUNCVBfl+wLGKBZl6u3FJxOd+AWS5kIP3JMkqbFpCqSv13+i/Ud29qdPvGd9QOwowmXQHNnnZAxQxW8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUoRkrP0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUoRkrP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BBBC4CEC3;
	Fri, 25 Oct 2024 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729870830;
	bh=kdNZe/x/N3eEj+GaMsh3MhMCViKSPDH3i2X0I36HPpY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cUoRkrP0dZnxVSWRdH3yT8X4FRIuwnsTMRGaA5bhlQ+p+X1BT+4SSIqX44nbtNVYU
	 OtS0BC87uKPiwRROa4cgmIMwCnorsqN3EJFe7eZ3o/03kKzrbHpT3JSWh6NCMgh+Cv
	 L7RdCVVsoYZm6MGTdaSOo1am4PZFt2VjIO2NzBqGH3xyxGVaYu3nxZjl8fYAqG6Yo3
	 0caefgtWQwfuq+GheiUWECtvB2hFh5o1nut4HqerNi7VF2T/1yHP485E2ls2L1IgoU
	 5pOygm1fLe07493HXVCjV7IKCygV/BlDZbPmXj/mei+OA4H0O1AhaOR35c9kPeO3Ix
	 Zyj7SyydE2jbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710483809A8A;
	Fri, 25 Oct 2024 15:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: fix use-after-free in device_for_each_child()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172987083728.2948690.3177661864670393367.git-patchwork-notify@kernel.org>
Date: Fri, 25 Oct 2024 15:40:37 +0000
References: <20241025114018.574041-1-dmantipov@yandex.ru>
In-Reply-To: <20241025114018.574041-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 25 Oct 2024 14:40:18 +0300 you wrote:
> Syzbot has reported the following KASAN splat:
> 
> BUG: KASAN: slab-use-after-free in device_for_each_child+0x18f/0x1a0
> Read of size 8 at addr ffff88801f605308 by task kbnepd bnep0/4980
> 
> CPU: 0 UID: 0 PID: 4980 Comm: kbnepd bnep0 Not tainted 6.12.0-rc4-00161-gae90f6a6170d #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x100/0x190
>  ? device_for_each_child+0x18f/0x1a0
>  print_report+0x13a/0x4cb
>  ? __virt_addr_valid+0x5e/0x590
>  ? __phys_addr+0xc6/0x150
>  ? device_for_each_child+0x18f/0x1a0
>  kasan_report+0xda/0x110
>  ? device_for_each_child+0x18f/0x1a0
>  ? __pfx_dev_memalloc_noio+0x10/0x10
>  device_for_each_child+0x18f/0x1a0
>  ? __pfx_device_for_each_child+0x10/0x10
>  pm_runtime_set_memalloc_noio+0xf2/0x180
>  netdev_unregister_kobject+0x1ed/0x270
>  unregister_netdevice_many_notify+0x123c/0x1d80
>  ? __mutex_trylock_common+0xde/0x250
>  ? __pfx_unregister_netdevice_many_notify+0x10/0x10
>  ? trace_contention_end+0xe6/0x140
>  ? __mutex_lock+0x4e7/0x8f0
>  ? __pfx_lock_acquire.part.0+0x10/0x10
>  ? rcu_is_watching+0x12/0xc0
>  ? unregister_netdev+0x12/0x30
>  unregister_netdevice_queue+0x30d/0x3f0
>  ? __pfx_unregister_netdevice_queue+0x10/0x10
>  ? __pfx_down_write+0x10/0x10
>  unregister_netdev+0x1c/0x30
>  bnep_session+0x1fb3/0x2ab0
>  ? __pfx_bnep_session+0x10/0x10
>  ? __pfx_lock_release+0x10/0x10
>  ? __pfx_woken_wake_function+0x10/0x10
>  ? __kthread_parkme+0x132/0x200
>  ? __pfx_bnep_session+0x10/0x10
>  ? kthread+0x13a/0x370
>  ? __pfx_bnep_session+0x10/0x10
>  kthread+0x2b7/0x370
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x48/0x80
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> [...]

Here is the summary with links:
  - Bluetooth: fix use-after-free in device_for_each_child()
    https://git.kernel.org/bluetooth/bluetooth-next/c/b6379ce226a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


