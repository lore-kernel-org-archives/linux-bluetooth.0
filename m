Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235051E9B35
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747681793; cv=none; b=nMCukNORiZIbVZjHfKPOAumyjZazWia/pX1yqjNKr2Tmul/QEQK+Su7bzimPs28Byh+nrJHVWUgkQo6C09QXoyt6cPEJc6JiZioo05gYpeeXSKx3O72iP6GIsUKuKHrhp5iVF80Mxi16HabFXQqbrUJtqCKaxJCcuNlpBh7paYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747681793; c=relaxed/simple;
	bh=fhl4XI/qXg1BbduOegC8WQR9pe2gLiB6+aRIcVEPB7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JY17ELO3cmHmlUiLHqueAZUBgmZHEl1XQFdVFg0xyluB1Kd4+H2SrvRC0GZBagH2poJNNhT47YciUN0T94GspYVFRyFWN6D8Xda3NwSgJt/AKM+6KeYnwClcst31YEe+fYzanDWh0RyONfzbnlUg1zLBypge3kytqIXSPiahELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4oDrS8N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4oDrS8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C372C4CEE4;
	Mon, 19 May 2025 19:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747681792;
	bh=fhl4XI/qXg1BbduOegC8WQR9pe2gLiB6+aRIcVEPB7Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W4oDrS8NBH64vCUT4aGRyYY0rtKX21mVJwaGZR8N8pwP2QpuH1oyGlCeaOIMKZVGy
	 OqMBJRUeSNnFtih++8BYNBY4yY9x2IW3tjZyRDDMJkCqSeHOyspkLcwVgbUh3W1RqB
	 IXvMy3dDiPKHHkBMLzoPjG+8wnW4K+a1sRROsBZHokTzXYKQ7i+DqG12bXWBq2+Us8
	 yYhSlS7KupYABHiLkLCGAIBJtqQH+lwilZKwaDc4nUXEgOO9qpSz17QQmRJChzYHeA
	 s/rVZxa4zbi9TANbD26L1iyOVElk2QuLdEAo9Pm+6c85jyZgRmyzlnG1qkI1GVPT19
	 Dss+2aOnclHzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE3D380AA70;
	Mon, 19 May 2025 19:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client: Fix crashing command info
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174768182875.1037362.1344435698283226785.git-patchwork-notify@kernel.org>
Date: Mon, 19 May 2025 19:10:28 +0000
References: <20250519142009.2493740-1-luiz.dentz@gmail.com>
In-Reply-To: <20250519142009.2493740-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 May 2025 10:20:09 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If command info is called without any parameters, and without connecting
> any device, it will call find_set which doesn't check argc and argv are
> actually valid.
> 
> Fixes: https://github.com/bluez/bluez/issues/1251
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] client: Fix crashing command info
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6a8fb8a00e53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


