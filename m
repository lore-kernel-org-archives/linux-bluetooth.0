Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9B25FA05
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526789; cv=none; b=J5oXNZOlRpTW+xiNLhoOXNODWYbTB4hYq/9VIJHmloy3Kg+syjF8Upx0+TEI0InFtlKRNthzm+4xBNAGnF+R7kS7/pX0r3L0e/RjEbjy9t+d/BQdX3ZnRKV62CA9n22IfkfPWOnLvkn1k29rt3eLT4B38aqv7a3gqzRz6EjJLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526789; c=relaxed/simple;
	bh=6kxdVKaC2zdB75NIaMOvkzb8+oFYim6vzVN7sEI05tY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=etO2X9uVH/4j/9J3nVReQfwBzMhFdtFg9U+5GD/xM0Z3s8g/tazx68oy8rK0og9t7eDFHM1aXXTFjuQ42zSqUoiiZpcwdZEPdUbgEYvRc6i1UspPp+wtoUiaeR/PVpcJQJfnHPp1UlCm69kofbnj7GI8gwzNJAWhQEENNQQ+5bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od5L20B1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od5L20B1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808ACC4CEED;
	Mon, 14 Jul 2025 20:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752526788;
	bh=6kxdVKaC2zdB75NIaMOvkzb8+oFYim6vzVN7sEI05tY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=od5L20B1kF8f7+F1Nt/EM+47Tn6TUlydT++aCYL0k8+dbyag7WlGLuReKL0EBUJIT
	 uTwvXGnzsQ7B1myKX6rJtZYDSuoT/QFEx1NSc2qKFZwVW75wDJ/AtXKb0h/AoprsT6
	 btuZt7j56NWYJhDnOGLYs2p6gvsTrhxzzcBP2kb9Jk9lbiNPk0M7ZvR/LwIuqHO8xo
	 dlwQF51mkGKkdAr3dVJatbi25TvCfZ6EnzdCP6YSWTwRKc+85T39xYhMy6cXloAX1i
	 5GEOFOyyhP3C36XTv9aQrLeSoxHhDQEDX0RDcm0UfBQvcD1Kjft0G2PAa7JGCDMPOZ
	 VLwAdJo715kBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A17F9383B276;
	Mon, 14 Jul 2025 21:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc: explain SCO and L2CAP timestamping related
 socket
 features
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175252680949.3985397.4487302451635893257.git-patchwork-notify@kernel.org>
Date: Mon, 14 Jul 2025 21:00:09 +0000
References: 
 <8968b3ef55340c6d7b16c33685aa87e3368b526f.1752514576.git.pav@iki.fi>
In-Reply-To: 
 <8968b3ef55340c6d7b16c33685aa87e3368b526f.1752514576.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Jul 2025 20:36:35 +0300 you wrote:
> Add explanations and examples for SCO and L2CAP timestamping-related
> features.
> ---
>  doc/l2cap.rst | 166 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  doc/sco.rst   | 168 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 330 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ] doc: explain SCO and L2CAP timestamping related socket features
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=893a47e5beb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


