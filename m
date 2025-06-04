Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2CF18E1F
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Jun 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749049197; cv=none; b=VYo3XZgv/vXF+Nsj4VpYgm9B+FyK8qHeYdXap+b/JR7jQ2RliJ0brnnYki9tBc88QKNLo2guRPVOYMGcDvIic120sl/9SgtB0DBEmAgastdrv7EPPhP3gh0boOpaXRfPqdHQkHLM4/neyZRYpAJ4UflMCcx4mnbBjaCcoXRK7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749049197; c=relaxed/simple;
	bh=yV9VEQThKhCYrq4zVC1jydhuexeG7aHwmdkuhL8PQFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cmVD6GfH+CLCCTwr4+RA6lVdOaI0BQT/JPA71+r0RLAM0h1T7zffS8Es+8q+hhexj34crv4FePPUNv2X6OXpMSNIO31KJDEwSs5svhRx8ksSNL/SyBNuvL5KgLDTVdi9MWidtuI5MREYSjdHNLyZZehm7g6TLjU9zkzoIKIWA+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWaAukwY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWaAukwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B87EC4CEE4;
	Wed,  4 Jun 2025 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749049197;
	bh=yV9VEQThKhCYrq4zVC1jydhuexeG7aHwmdkuhL8PQFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FWaAukwYYgxUFVMRCSBxrNEPmKkhgRsDxXQ1zESrCCA+Qc7BBJUNBrD+T2/XH9RtQ
	 JVQU6zbH6qDx/CaJbEss70OmELiiKhI3W8SQXdQiS9+4Vu4aoUC/QgtgBwqFwFjDXb
	 6zgaStCiP/P1NQk+1nsDJZQhg85AH16dQmiHyiOj9zUI6YO0zuy143I/X6Mhnc35Ea
	 NvpxJq4wiwgcGyxQhVwBa5qBOXtPVZAXk9oa3+JFAjVs/I6w3K1lAuVJRDHm7kS3Gu
	 UChmAyGlolOrFVmVGtdmo1ZyikED2KvspeUYKkuQ0Ujf7eXkn/G/Q52MQvv1Ul/Q31
	 uMoSf2k8ZhjgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEF238111E5;
	Wed,  4 Jun 2025 15:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/2] Bluetooth: MGMT: Fix UAF on
 mgmt_remove_adv_monitor_complete
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174904922923.2320923.17814377626102914152.git-patchwork-notify@kernel.org>
Date: Wed, 04 Jun 2025 15:00:29 +0000
References: <20250603202921.267083-1-luiz.dentz@gmail.com>
In-Reply-To: <20250603202921.267083-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  3 Jun 2025 16:29:20 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This reworks MGMT_OP_REMOVE_ADV_MONITOR to not use mgmt_pending_add to
> avoid crashes like bellow:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_complete+0xe5/0x540 net/bluetooth/mgmt.c:5406
> Read of size 8 at addr ffff88801c53f318 by task kworker/u5:5/5341
> 
> [...]

Here is the summary with links:
  - [v4,1/2] Bluetooth: MGMT: Fix UAF on mgmt_remove_adv_monitor_complete
    https://git.kernel.org/bluetooth/bluetooth-next/c/5db6a9a0d444
  - [v4,2/2] Bluetooth: MGMT: Protect mgmt_pending list with its own lock
    https://git.kernel.org/bluetooth/bluetooth-next/c/f60dca4b11df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


