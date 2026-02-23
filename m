Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C930FC1A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865853; cv=none; b=biwYbLl4q1sGwKaEU9nDbp9dPePiNdU7RDnB5EJ20ai/M3F4vxW6ZZNmNsV4Alw/NENsy5R8ZjVtjkrLj1o8oZtdi67Wep0poo6m0xqyQAR/Oj3EoTpFuBusnfiSApQnbmwuq+FUxSKm1cA8OOF/2xE8FuEZAlxeDxIAdeedbgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865853; c=relaxed/simple;
	bh=2UWdBB+MDc8UeRDLBZxMlEEfow6bRSpYVeASa+ziYCc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RxhBz1h3CVNKBEUKiKqGWsIFJkiU/TBgO/Af+QPs3Sp9ItWzbta/KvKSBd/mFB8ESLmMVjAa5J6RMMLf+htykLHWAa/z7SyxmAwGh2IgmbNoku6EY8j+L8btvCMOZFQLi5e8K+EH6pOBk2C0eKZpeTaNUhRuxVLjZo7oSqdD/yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lx1ynhvY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lx1ynhvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77287C116C6;
	Mon, 23 Feb 2026 16:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771865852;
	bh=2UWdBB+MDc8UeRDLBZxMlEEfow6bRSpYVeASa+ziYCc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lx1ynhvYJ4pxFys29edGm2ZqkMFXOJZ9Z0j4R9hiZ9hBLSSwjZnkVqtz6y+tKwrAB
	 vQLcOw4Ml/ocE7HfPPcovmsr9Lq8Eb2OApE30/rW81ps238etsZ5dF2I6nT0oOwWan
	 ZRVpWp/6B6wUTToRP74wwLsom9zTvs0oRZTpxtbQk+d2Gy9lip1dCdQrVi3qjtWW41
	 C5lN7LLYvIHWjQTTHA4TZ2lDATrb7mJTgs9ga7PlbB9ShKu+Mp/xgrL58BkkaaF2WY
	 BQh5hxaGxkCQ5bRixGEwL3JwDHXQHEPxDrDazFhYvvUkvfge2HHGS9F6pQp8AhSnrP
	 RfZkwYaATbZhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EA93808200;
	Mon, 23 Feb 2026 16:57:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix not checking output MTU is
 acceptable on L2CAP_ECRED_CONN_REQ
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177186585853.2372049.90807401799515441.git-patchwork-notify@kernel.org>
Date: Mon, 23 Feb 2026 16:57:38 +0000
References: <20260220140930.3367106-1-luiz.dentz@gmail.com>
In-Reply-To: <20260220140930.3367106-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 Feb 2026 09:09:30 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> In order for L2CAP_ECRED_CONN_REQ the given MTU shall be checked
> against the suggested MTU of the listening socket as that is required
> by the likes of PTS L2CAP/ECFC/BV-27-C test which expects
> L2CAP_CR_LE_UNACCEPT_PARAMS if the MTU is lowers than socket omtu.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: L2CAP: Fix not checking output MTU is acceptable on L2CAP_ECRED_CONN_REQ
    https://git.kernel.org/bluetooth/bluetooth-next/c/6a4f124c550d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


