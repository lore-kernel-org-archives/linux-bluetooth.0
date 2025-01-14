Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A520B1F5;
	Tue, 14 Jan 2025 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878215; cv=none; b=lKKata3EDuVoPRYKuzPjgdo8rXnDnF9tOSkssxibOiIIbTeyg2j7SAS/9AWiGlrGzGy8EwddHxsWZyXRk5YtpWG0p55KcAPxvRn3Etg32OZeFsfeOQhz52Teuqz3aHmZ9A4B9ya8rJmZtnRplfMEWxn899EoXt9IBtxqB8/O0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878215; c=relaxed/simple;
	bh=tnAJvd3arROMboTmvfzIgdjdZmSlrNrYXxLTXGZ6V9s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eQRpVbTRj1aPsp1xSvc+PQMI1AbogJKo4HD4naHtYoDkBQZqY99tvnhecyXcbzTrhuviHANHoI7rnu/+s5YKXW/2vmvywRWIhhOR0GylFH+tSHs05NshNPwp3FPE31b3mkvbahO+e+JXAydFrZjFcYB7CqnFwLbkyloDQWhX0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJI+Q7Qn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJI+Q7Qn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463CFC4CEDD;
	Tue, 14 Jan 2025 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736878215;
	bh=tnAJvd3arROMboTmvfzIgdjdZmSlrNrYXxLTXGZ6V9s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pJI+Q7QnnhzalcmbZ4Oz1kKNP+msfa7bxVqErQM9umNZpCfGU99jotKcNuZw1fmEx
	 KvWZG0ygtSLoUkF/w/v+6Twx8SDgkYxxVKV2iCa/5bL2RuvpVUwDwVuS77GFsuGUcG
	 PuJyEgw/4sZf5RTXJeHLJNz2+L/SziKYDsIKseA1k+pAJNSxyziOkZJJiiHHe4R+9A
	 EEfhbVOmo0zuGXc6zFxmx8UNq9ynbUcCLIKQG24wxv/dOOxR5l1Ljh5Ds5qwAr6Iaj
	 puNRlZaZqydkf6sJHwU0EBAI/wDdQV3WcDC2i54c/rQY80dDzOTb/uKjoAaGJmZ97A
	 1t+SRJwA8n/3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341BB380AA5F;
	Tue, 14 Jan 2025 18:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: Fix slab-use-after-free Read in
 mgmt_remove_adv_monitor_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173687823803.85489.9643212113679660119.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 18:10:38 +0000
References: <20241224020616.10885-1-mazin@getstate.dev>
In-Reply-To: <20241224020616.10885-1-mazin@getstate.dev>
To: Mazin Al Haddad <mazin@getstate.dev>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Dec 2024 05:06:16 +0300 you wrote:
> This fixes the following crash:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_sync+0x3a/0xd0 net/bluetooth/mgmt.c:5543
> Read of size 8 at addr ffff88814128f898 by task kworker/u9:4/5961
> 
> CPU: 1 UID: 0 PID: 5961 Comm: kworker/u9:4 Not tainted 6.12.0-syzkaller-10684-gf1cd565ce577 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: hci0 hci_cmd_sync_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:489
>  kasan_report+0x143/0x180 mm/kasan/report.c:602
>  mgmt_remove_adv_monitor_sync+0x3a/0xd0 net/bluetooth/mgmt.c:5543
>  hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt_remove_adv_monitor_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/1f2ae3fb1cdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


