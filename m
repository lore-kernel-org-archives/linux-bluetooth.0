Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D474625
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Sep 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028839; cv=none; b=TEp6H7EPzE8zqVlOL9R1FrpRKr6OVivBnyAbtijM0L/NrUCiNHrcB0Msy0FtigAytEpVOe7wB01s2VotQKtekux9ocyuXgo18Y2EdIaTJW0gtx84nSH6wFs2VV1G+ku3/InHYWpvw0CG9M5bFclhb+KOA3PhGcsgafZRsse0UMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028839; c=relaxed/simple;
	bh=Bw4xx3YMBQcovwoSKh9k19qzqbALpahv3Sc2SGJQjcc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sSaB+FXl5V6lNkCNW5U/5BcUqnlFTO2CfNQnIne9MkBMQD9KZVM6wEbUwl2Hbc4o5tEu+9jPIo6vSqhYL/i6mg7/SF879SZcMiTKEcMRJKPJoNXgO47QbOtM2W23xgKrhnbOwL7l5VkptdRsamZaIEmbvgZyjQwn3kGAoOjycDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VceldVX7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VceldVX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEA8C4CEEB;
	Tue, 16 Sep 2025 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758028839;
	bh=Bw4xx3YMBQcovwoSKh9k19qzqbALpahv3Sc2SGJQjcc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VceldVX7jIVm7n5s0UKxmKuvNSCi1uED9x5uqvTrc0+5hUm7D1GeVvnrtJ3+g3L8b
	 kTR63g64Fo4XlE6gGowMTeEndrS2h2lhMTNFql0i0AdzvrkgV2iXc8NB5by//2HlDR
	 3X9dFEG6c5tuv8ocZV27n9Z6inaibrrzyo1Mwxc02qPvU+Gn0v+61ABE6hWJGJ+te2
	 +hIqSUBDgmcFsLAgx9dWezbPNJze1GB5/3k8qqJcLOJj4q8szCvcFbSaZVW/olXWdn
	 UlIpSnTUiyFdqx8NaMw0OLPKTpGdVGriRbodp1Ieo8o2SdEd8kfAA08apeW1dyFLbI
	 UmrnIIyXf/eFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711F939D0C1A;
	Tue, 16 Sep 2025 13:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/3] Bluetooth: MGMT: Fix possible UAF on
 mgmt_add_adv_patterns_monitor_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175802883998.749893.8453495738437304933.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 13:20:39 +0000
References: <20250909220327.1771815-1-luiz.dentz@gmail.com>
In-Reply-To: <20250909220327.1771815-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 Sep 2025 18:03:25 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> BUG: KASAN: slab-use-after-free in mgmt_add_adv_patterns_monitor_sync+0x35/0x50 net/bluetooth/mgmt.c:5223
> Read of size 8 at addr ffff8880709d4dc0 by task kworker/u11:0/55
> 
> CPU: 0 UID: 0 PID: 55 Comm: kworker/u11:0 Not tainted 6.16.4 #2 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> Workqueue: hci0 hci_cmd_sync_work
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xca/0x240 mm/kasan/report.c:482
>  kasan_report+0x118/0x150 mm/kasan/report.c:595
>  mgmt_add_adv_patterns_monitor_sync+0x35/0x50 net/bluetooth/mgmt.c:5223
>  hci_cmd_sync_work+0x210/0x3a0 net/bluetooth/hci_sync.c:332
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
>  kthread+0x711/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan/linux-6.16.4/arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> [...]

Here is the summary with links:
  - [v3,1/3] Bluetooth: MGMT: Fix possible UAF on mgmt_add_adv_patterns_monitor_sync
    (no matching commit)
  - [v3,2/3] Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue
    https://git.kernel.org/bluetooth/bluetooth-next/c/6b74ce021062
  - [v3,3/3] Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/b6018d6825ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


