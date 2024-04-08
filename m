Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600FC14431C
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604628; cv=none; b=lSXM7+czA8PBEw2YhQZ/5v2Zn6AIhBEPQKBTJ1JzCwY/xZHIixdjHYK7R/vn7aMTywDMd9E3Xns46pSzeBA1MfR7AuLGyfznqOrcyNNFRkoz51BmzfsS0iOyKa8kpjw0yldV22vuDH6iHZb8dWfBR/Fhd86gv1Hsl3/EtXfMXyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604628; c=relaxed/simple;
	bh=7wbJYxOgi/PJsldjwH+DIyh9yX2J48zEJLkuMfCr46s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=saU8+JmDYr9714fGTcjlHTUhif2/l4vbZdjs5nFfzV0i158a0NnejotdNvrgM++xbAIWElDxzXGfJ793QKKO2wm6wfvz6FmzATSdmFBgzcXdh04Neac3xjuO81VEAsWD04rZ0EqFWBbA/cgSPZtkap2joWy9UhAJAZrCmySgpNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSjsgBZu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSjsgBZu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E84EC433C7;
	Mon,  8 Apr 2024 19:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712604628;
	bh=7wbJYxOgi/PJsldjwH+DIyh9yX2J48zEJLkuMfCr46s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pSjsgBZu/9cw/Sb5xbY05kwsLjAqrUfKkW82Jec+gloI2c/0U/pvZ5qkyOEYiysbb
	 eMcSblaS8lb95JyfPUE6bxNvdBkIPN/NG/pFq9fACE7fUHbNOlgOGSXKlPyaE9lzGw
	 HlVgoQkgTkbjtjrEk4Tmsbr2/1+siBdWnNPe6B+BgbgrD7kEJolnmd7uH6xWCwe6Zu
	 s0tRO2YA6MtaOWkfz9zVmGrdlE/DTRdoMf669URymzVscimyTPfz5YX5BCWGfabvDZ
	 8qd4iFaouyx7JUy1/eANnAz0x22WEmibEsxrLzqy7GqjxkH7CDQlVKFLky0BFYbMZb
	 cDBpmqfte0VvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03965C54BD5;
	Mon,  8 Apr 2024 19:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v6 1/3] input/device: Fix not handling IdleTimeout when
 uhid is in use
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171260462801.8265.7980904192974844335.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 19:30:28 +0000
References: <20240405211145.3463154-1-luiz.dentz@gmail.com>
In-Reply-To: <20240405211145.3463154-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  5 Apr 2024 17:11:43 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When uhid is in use IdleTimeout was not taking any effect, this also
> attempt to force the destroy the input device node to make it useful
> for users that don't want to keep the input node forever.
> ---
>  profiles/input/device.c   | 86 +++++++++++++++++++++++++++------------
>  profiles/input/input.conf |  2 +-
>  2 files changed, 61 insertions(+), 27 deletions(-)

Here is the summary with links:
  - [BlueZ,v6,1/3] input/device: Fix not handling IdleTimeout when uhid is in use
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ea96d7d18bff
  - [BlueZ,v6,2/3] input.conf: Change IdleTimeout unit to be in seconds
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=94c4f445af66
  - [BlueZ,v6,3/3] input/device: Add replay support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c6dea886985e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


