Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBBB14EFF5
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128833; cv=none; b=Fp9lmhFIkm0j+3ZI1RU5UDNEcMzJlzTiYoPyXLyRfyvtDT1DYiPLd4vpn3T6TLpk4raa3svFg1O4/1roI0MmqMmbt+lNiwQ499eM/V9xcJWYKgmYZCT2LEHsTm1MeozmgW40KM14HTXJEbdFi44bwjgbriLnbu4iO/z5T2Ei2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128833; c=relaxed/simple;
	bh=/WtDFE2kg9pE3YKdZktz/rLX0NGFIGOlVwyynPWU/rs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kf3YkQB+SenMfhZ5D0EY//UsWvv/8F+ZWZC3T5Tm/i5j2PkftIBIxMrRpKEt/HIUyFFoE6qJDORCeUwFKheXH14txSHJtE9RvOziECFhi9B1VqKGZCOx9vZFoy6Melj1pDYrmauCqPxkTRppI3SMF2tDOkJABKHYWH0FbQzSn7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPc6aanU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPc6aanU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3E10C433F1;
	Wed, 28 Feb 2024 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709128833;
	bh=/WtDFE2kg9pE3YKdZktz/rLX0NGFIGOlVwyynPWU/rs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TPc6aanUy5drzEzugou2+WrpYhsvsWoA2pBkLJSio0I/+7lTmlAaPaPYuG5Cuc/Pg
	 iMEFc9Sb0ffbGoQkN2bxOawwb7AZMEw3LVgVxCvL8sBNH0n88Rs9Y/bune+f0KDNnv
	 zlhNwiFwQ1kCIcKLK5Z2lEY7mXemCu0SXggdntQg8pRXNLBd7HnUuYuAgGH/TggHrK
	 Z0F49BbhYc5xmwaJ+XyYVhGOMgIhtxvoIQ4K1ad1JL0RtrxJK4SJbkaiGLd+fegEDY
	 Pc1g6MgjlPggfKzUZSY7j9ObMDXoV14dFFiZYaE1K9a4qUxrm22Ba5+NLMkM5B3O2P
	 gBwkYzuaR6NcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D95E9D84BC5;
	Wed, 28 Feb 2024 14:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: hci_sync: Fix overwriting request callback
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170912883288.30835.15310393594185558591.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 14:00:32 +0000
References: <20240227220428.2035718-1-luiz.dentz@gmail.com>
In-Reply-To: <20240227220428.2035718-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Feb 2024 17:04:28 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> In a few cases the stack may generate commands as responses to events
> which would happen to overwrite the sent_cmd, so this attempts to store
> the request in req_skb so even if sent_cmd is replaced with a new
> command the pending request will remain in stored in req_skb.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: hci_sync: Fix overwriting request callback
    https://git.kernel.org/bluetooth/bluetooth-next/c/afe04d6e61dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


