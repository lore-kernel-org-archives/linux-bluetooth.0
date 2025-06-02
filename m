Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843704400
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Jun 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878200; cv=none; b=AQvFTNOKmwiXUz3vygVrVI9zAZqhQLpuqEd6UWba27BU8DEOjyMZQ0EM0JntGxMaSq0EQ0bd2AXCwX/Rfd9eOdf0kPIJgq7N+uoriduleKy9NQEYdVYPcHy1vsQzRpLlOFUnUIvEm6OegWs6izz6pV9Eo5aiYPspqoZqz4l2geY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878200; c=relaxed/simple;
	bh=JNdCfEGR25uSxBuxirUbdxMej8hZjJQJHE8BUBEOZyM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nb8vTrBts6RwyGxxuY5hoze3FU0+H3F8AhboUX/MmSbNzAySU7rd0FgNKF7uZoMWep22Db9cSWh2HQAhtpmGfMFcwOf3ByqFDXDaWaxIPzr/WyE8Etgzrs2T8XpfCwGWRZSTNwc8UoVeAH3kv1lw2n92kTyxWEBPoeZl7JwxbGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/fgZ/Ek; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/fgZ/Ek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C55C4CEEB;
	Mon,  2 Jun 2025 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748878200;
	bh=JNdCfEGR25uSxBuxirUbdxMej8hZjJQJHE8BUBEOZyM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q/fgZ/Ek3TkN+4nnJlZi/2zR9jiT/wWz5x29gnBJROiBQfO2YUuRDg4TpV1N6FC9c
	 D0KaWi+IO5Gfpd6Y9E1jVA8INHbfsq+4NMK96LMi+4S6YhCO+hMqCQ2WytcasMbrYa
	 Tb4d4PP/fOk6urStFT+w1DnDNe2hnIXlYAtBkHJ6fpnyCZF4Y2BNwFswqyhkr6VxQk
	 wtO4h1sIxc799oWhh6+2WhkQVbknA8VVbFBv149izq0VLPS1AKgDro+hRIv5umrATV
	 noBE4JcYiP/W0YPq9Z1P9QypzJPeQi8z+N2F4BKdUHqIkrt0RvTWJj7oGxTG693971
	 4mZwyojLDrPAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB36A39F1DF6;
	Mon,  2 Jun 2025 15:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_core: fix list_for_each_entry_rcu usage
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174887823276.797356.3230385488643493423.git-patchwork-notify@kernel.org>
Date: Mon, 02 Jun 2025 15:30:32 +0000
References: 
 <4bfedc6d6edfdbdc7f2bde88da75a8329e78abb4.1748704997.git.pav@iki.fi>
In-Reply-To: 
 <4bfedc6d6edfdbdc7f2bde88da75a8329e78abb4.1748704997.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 31 May 2025 18:24:58 +0300 you wrote:
> Releasing + re-acquiring RCU lock inside list_for_each_entry_rcu() loop
> body is not correct.
> 
> Fix by taking the update-side hdev->lock instead.
> 
> Fixes: c7eaf80bfb0c ("Bluetooth: Fix hci_link_tx_to RCU lock usage")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_core: fix list_for_each_entry_rcu usage
    https://git.kernel.org/bluetooth/bluetooth-next/c/6c5d0010e8a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


