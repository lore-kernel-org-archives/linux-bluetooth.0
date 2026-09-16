Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840424DAFAC
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580478; cv=none; b=lVkXg+DrQ4+28gdSo9J7WaL354bljqE1618xiQM27BF4xarRxySowRnmmrp1BM3+WHXV6eB1WmGuW2AKi+g6hX1fPjb7MPItqf2GN5KY/Adrrl521JhQF6Bfc1qswG1VsGvHhCSoYB0zoIKV5qryFwC6v1qLdMFv31kX0PBxxfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580478; c=relaxed/simple;
	bh=4Ei4ZMGXcq1HLkxohs1tK7BBU60+IEqQHXpL7UMhQRA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nJCcy23rFCOHwoUY70CEeWElsC/rUgmYqHNcc8er1sgJOVM7S4jesDZF59kNOUoXWMFt92esLWAl8+CfkxDiZTH75hWQiY48lEXrnNWEzIjLZYBhT/GFJgAkfhRmDqfa1PRW6wpdCavGYcQyLayE8eph2UhcDzKe3rWqBV9WF7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWZDZVBd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWZDZVBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0711F00893;
	Wed, 16 Sep 2026 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580470;
	bh=N+ojLGuwTKcM/cwytGo/sLoHUtwh13VYlLQpzAFBSoY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kWZDZVBdLHve2YdEUOz4v3aU5nISESXeeVYz4Z24vSWWyEwNqKY9ktJ7vGJ5pwZYv
	 0xxilcc1CKMdfpqF6Rl6b2IkwZFW1PwDBmp3tQqH4kGqtIX9TGydNIP5Lfhw2kYETx
	 HM48k7aHTuaEq6Pzf77CAWUZKa/yDma0v4KPuSrckx22j33XuE/a47z0yLni8azqk0
	 Om5M9FI37vfrkG45ut0swMK5oaZJcJzYGF5/w4afxyU82UzKQC1/2UcSTpvvN0gNHQ
	 NzHazzEvfP3fZeKIpfhXFKa1ZkVf8SAwp2HZmKvVdEs/sED3yq/WyYHFzA2ilbZ8XI
	 5dV3kH7JBXGgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4239E8A4C;
	Wed, 16 Sep 2026 17:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: SMP: reject Security Request over BR/EDR
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178958040438.2768284.4792194760789694555.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 17:40:04 +0000
References: <20260916134622.519192-1-christiano.amora@gmail.com>
In-Reply-To: <20260916134622.519192-1-christiano.amora@gmail.com>
To: Christiano Amora <christiano.amora@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 16 Sep 2026 10:46:22 -0300 you wrote:
> Bose QC Ultra Headphones (dual-mode, same public address on both
> transports) occasionally send an SMP Security Request on the BR/EDR
> SMP fixed channel right after the ACL link is encrypted. The kernel
> handles it as if it were an LE link: smp_cmd_security_req() has no
> transport check, smp_ltk_encrypt() looks up an LTK with the ACL
> connection's dst_type, and hci_find_ltk() matches the peer's LE LTK
> because the LE public address type is stored as ADDR_LE_DEV_PUBLIC (0),
> the same value as BDADDR_BREDR. HCI_OP_LE_START_ENC is then issued on
> the ACL handle, the controller rejects it with Invalid HCI Command
> Parameters, and hci_cs_le_start_enc() disconnects the link with
> HCI_ERROR_AUTH_FAILURE. The headphones drop within a second of
> connecting, before any profile is up; a manual reconnect works.
> 
> [...]

Here is the summary with links:
  - Bluetooth: SMP: reject Security Request over BR/EDR
    https://git.kernel.org/bluetooth/bluetooth-next/c/f033482d76a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


