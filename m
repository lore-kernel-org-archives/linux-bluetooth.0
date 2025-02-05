Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF17204C1A
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Feb 2025 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790411; cv=none; b=C81m81JbDxgo05rEZRYBdVfpHC7UcTk4+EgFijCo3AvBQaxrmehcHJaivush6EP4tYNKLcgvCyeZqXTJO+wVW67SUGRku62TPVewVFlUNb77dK76aVb2QezivMJARMY4PJntVJ6+eA1yV83LeoLvU2jzoxfUzNzq7PX5B/rfUKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790411; c=relaxed/simple;
	bh=D9ROSiHAQqyEazQBOOJy9xHl4K+kqeqXENVMp7YShhA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZSn5/YhMbfimLvRSdo9Z5qd/kw1kqVwYH22KGJv8nJ28/2R/pmWFzwXoulLVtiWW35nw8D3s/z52cWnrG0FOHKWrHI1H9NIS7W5PgQt2+xzNbScCca0WaCcq9QwgBbydk+OUgZqzTXrGJhgxWRZVZtnEgHUjAl6e9X3ay/3v5bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGR/F6KD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGR/F6KD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19BCC4CED1;
	Wed,  5 Feb 2025 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738790410;
	bh=D9ROSiHAQqyEazQBOOJy9xHl4K+kqeqXENVMp7YShhA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JGR/F6KDrdPFzt70zDHzNNw3BxhNLJiYg+Jim390TOksh1xkc8pA8vocshXW4pAgV
	 pyqgGpSYp1ThABTKniLmvVesyVNrnWH5f0o5TPrXBJHfxHb3dUv10C5zxiJYD0bK+b
	 vT/lG9LttvwmPf82EDazTfGxUoCWnPqza7rHHv9EeDmy61RSMhuID9wIVmaJn2kNkF
	 DbpDNFzI24UU0d0MW+C9Iv83qnkf9EpzSVZlxk04xAOqRki+80bK1dJcQ1ERK1ydhu
	 JSHeF+h1ONqeV8F/PsFOwv8twFhgHlc0DHW8cqKKKgclbJXjcIv5vScJwUvHOHG3Me
	 DxdKLR7x1Mqtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E4A380AAD0;
	Wed,  5 Feb 2025 21:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Fix a potential race condition
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173879043827.909143.17996715616415927214.git-patchwork-notify@kernel.org>
Date: Wed, 05 Feb 2025 21:20:38 +0000
References: <20250131130019.1648758-1-kiran.k@intel.com>
In-Reply-To: <20250131130019.1648758-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com, helgaas@kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 31 Jan 2025 18:30:19 +0530 you wrote:
> On HCI_OP_RESET command, firmware raises alive interrupt. Driver needs
> to wait for this before sending other command. This patch fixes the potential
> miss of alive interrupt due to which HCI_OP_RESET can timeout.
> 
> Expected flow:
> If tx command is HCI_OP_RESET,
>   1. set data->gp0_received = false
>   2. send HCI_OP_RESET
>   3. wait for alive interrupt
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel_pcie: Fix a potential race condition
    https://git.kernel.org/bluetooth/bluetooth-next/c/37d0ec8e50ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


