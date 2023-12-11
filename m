Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F80B52F92
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9OWC+ic"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3C7FC433D9;
	Mon, 11 Dec 2023 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702320024;
	bh=ot3ef9+BNwUMcqgKXjn5uFOP74Xo6AKgluKP1L5+7HM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s9OWC+icPmPlpmM5Ib5zQPe4+2ZIjSdKpZzL7HO+3iMZWLt/b2Mr4/UtnaaUEYssP
	 Q19/iDEk41nLEJOojt+xQrSrgZkl6SWKFU6xJDZktvY9xEK0amOGdDY2acMiEV3XdT
	 eyFK2e5fnf6c7U/bB8kCBzO5gy8ZZNuUu/l4rlwlbRi4J8VC8flCVio7g4h5v8zQdf
	 slm7JgOJwOmuO9koxL0M3DY0/YiBxq2BuL/wuOcU5gqQtIAJKt7RVQbXFh1iyOjWlt
	 +bQVMXpNa1l7cHWzbUK35Of2CLJCKvILx6rkcW2scmOahpywtLWqFAwKOsybI7gZWe
	 fwUfKwatW5N9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD84EDFC908;
	Mon, 11 Dec 2023 18:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] shared/bap: Update Available context for source
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170232002477.25763.17213923004587985956.git-patchwork-notify@kernel.org>
Date: Mon, 11 Dec 2023 18:40:24 +0000
References: <20231211083507.3363494-1-kiran.k@intel.com>
In-Reply-To: <20231211083507.3363494-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Dec 2023 14:05:07 +0530 you wrote:
> Available Context of sink was getting updated instead of source.
> ---
>  src/shared/bap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - shared/bap: Update Available context for source
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=87477b7ffefc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


