Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D891F3BAB
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628203; cv=none; b=IKiky4KSskfYLuKY9oOtbsrRQQxZlxp93TEZvKPn8DJMEfsoTRt+ZsukNuVSKCnNPdYAY+uv9raLe1QkbKorpVOFk+8k7oOrbuSavgZpLL6E8dIHy/JrJvq7m97VFO+nIl9NvqW/Ra4dBCaAllYtCRS/vHjyTbNHB2X/KLQ0ByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628203; c=relaxed/simple;
	bh=8z7AzU/N0kQeaAeaLadPiJMVNkQN7r0mDjteFKCgcs4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d08QmaY0cO2RXkU1M9acSjT8qPxPGQtO8UGs6sae2elFIjNG4he5vbFYeXtt9oGvkpRNSIS6Kb0OHv02Mi7eQq496s1qfu1YDE86OPj3/izS9rar2BgWcF3cxWAu69EOb5pBJlAesKwaBuqUltZ7xjQJSFP7rRw0NjmFOZv4eNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBToe3iM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBToe3iM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99637C4CEDD;
	Wed,  2 Apr 2025 21:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743628202;
	bh=8z7AzU/N0kQeaAeaLadPiJMVNkQN7r0mDjteFKCgcs4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nBToe3iMb19j5BS4fLQkAaUKTzOzewAUVP55XDicE2bla43L138ay5Rx0UZFgYiR8
	 zrX1FAyxs9HfL3PE72MffQGuN78qdB+5Dl5XT+smG66u9te1ub7exlu7u03+tT5A4y
	 kReBZdqaCzBLbqRL8lKSK3duqa+GGJtKf1MSAOcprqQedJgxuIW+blP0nmPnEqXMX8
	 +t3p5OksRnSbrX66k/DPMVhuJ8OFfDoCcn73fChePrhqIP47U+2kxz3BCMcVJiymZC
	 9gpDZoGjQkQCSwZs0Cfh3tFcwJR5kR01XI/rsqtSeyiugW13Uqki0jRlw+1trUBzC5
	 DJBx+pu0HGgbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADECF380665A;
	Wed,  2 Apr 2025 21:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Do not generate coredump for
 diagnostic events
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174362823936.1678044.3130127126489537873.git-patchwork-notify@kernel.org>
Date: Wed, 02 Apr 2025 21:10:39 +0000
References: <20250402021148.63748-1-kiran.k@intel.com>
In-Reply-To: <20250402021148.63748-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  2 Apr 2025 07:41:48 +0530 you wrote:
> All Intel diagnostic events are part of HCI traces and there is no need
> to generate coredump for the same.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c      |  3 +--
>  drivers/bluetooth/btintel.h      |  6 ------
>  drivers/bluetooth/btintel_pcie.c | 10 ----------
>  3 files changed, 1 insertion(+), 18 deletions(-)

Here is the summary with links:
  - [v1] Bluetooth: btintel_pcie: Do not generate coredump for diagnostic events
    https://git.kernel.org/bluetooth/bluetooth-next/c/c00d13bc7c53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


