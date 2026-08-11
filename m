Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDE93FB042;
	Tue, 11 Aug 2026 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479071; cv=none; b=SodB1NOTbRGBB5RPxlmAcvX7zo9dIl4dMBO82izbPCYVJGONvmkbsyXpt7yarU/gzu/Am3AK9rxDliMXo7t3h9RtfGHQberUZ4ebFP4DFvJyQ5cOh5XiyCJ92XTvjw/xt95q+A1MHFd3odKJ+6xV9PAOfWcdw0DQuGKVJ2/cPik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479071; c=relaxed/simple;
	bh=6Dy/OS86gSpvZMA5tCLmFQ86giF+rTsvPulpYOp4kCM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fHz7CoDKymeOY8FVbV2dDoY/p6VIeehLhfTnMK/OLL2bxpQ5XMrQs4DkSAI6m+oRZ6X5q99xDUERyuAmuCI76tP5U2B36exTDv7V6l1HXFd+SeZgys3iPjPOUdBaVNP5Zj4JirA3DPCd0XrqyuKmUOdh7dEiE6H9+srhI+3UiEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JC9MSUYg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JC9MSUYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01B21F000E9;
	Tue, 11 Aug 2026 20:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479065;
	bh=jfR76n9X1g0cgadpwIjGW675t6sVNVPHiz7Lm/jz1cs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JC9MSUYgS8gUoeIKmy3FHDGT59uDMjV/7BsePhU7NDOaIGQIyvJ3o7UrO5r2scfXn
	 F6QqNsOlZkkqOSogstrjCWcoZ+pB3cnukUIyTQ95fvj2zp1lnK4C6qB1fAZLLx7Se4
	 ImhEKYS15ReY0M9jz7pA2+yFT4HiWh6brzfCMCIGNeacWy+LAFgy2IHBhrxYTnPKal
	 z9POYC9Tq57AfLAzCZVH/gYG22KxjHe8n/jJJdlbmTjq/G7UgwRzxhEPGRKVX8q8lw
	 1Swz5f6Wgmalu/2i3JELBJt+BHUiaWmDZtd86qpqbwU3a5wwJicEyv2u55VTI48vgd
	 8braFHm+ZFfjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09CD3809A0A;
	Tue, 11 Aug 2026 20:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: mgmt: fix 'hdev->discovery.uuids' NULL
 dereference
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647902138.1134064.3407354756099050470.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:10:21 +0000
References: <20260808163128.288740-1-pashpakovskii@salutedevices.com>
In-Reply-To: <20260808163128.288740-1-pashpakovskii@salutedevices.com>
To: Pavel Shpakovskiy <pashpakovskii@salutedevices.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 avkrasnov@salutedevices.com, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@salutedevices.com, rulkc@linuxtesting.org,
 linux-amlogic@lists.landau.one

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 8 Aug 2026 19:31:11 +0300 you wrote:
> 'uuid_count' member of struct 'discovery_state' is assigned and read
> without any locks, so there is a chance of situation when
> uuid_count != 0, but uuids is NULL and there will be NULL pointer
> dereference.
> 
> Possible race:
> 'hci_update_passive_scan_sync'
>   'hci_discovery_filter_clear'
>     hdev->discovery.uuid_count = 0;
>       <----------------------preempted----------------------------->
>                         'start_service_discovery'
>                           // Set uuid_count to value != 0
>                           hdev->discovery.uuid_count = uuid_count;
>                           hdev->discovery.uuids = kmemdup(...);
>       <----------------------preempted----------------------------->
>     spin_lock(&hdev->discovery.lock);
>     kfree(hdev->discovery.uuids);
>     hdev->discovery.uuids = NULL;
>     spin_unlock(&hdev->discovery.lock);
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: mgmt: fix 'hdev->discovery.uuids' NULL dereference
    https://git.kernel.org/bluetooth/bluetooth-next/c/99672791e9c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


