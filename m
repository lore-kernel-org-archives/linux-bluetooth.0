Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7517C205
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903036; cv=none; b=eXdEXYDRGzjF0cVG5Og0cgYvWhjDGdHDLpwZqJ0qeD7360bY0Wqlg1M2JsVOyqBqDQtZLPy5uKaD72YFiFSaq/sZ/p4tXcvT65zseeTk4fxN7gQ5yS0Tp1pwXrb7G23NQKHX1SNIu7XmEHOaPLHx8ZnCJPBhSdOD/YPdR6BkTQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903036; c=relaxed/simple;
	bh=RZ+ai00cDvAl3o4zxwAeE97jOxhIvb7/0bcsRHEdLnM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cpauyexckvnXXftq0RaB34G6J7Eqv/cSS/FJpzX7VgLHI/3uQe5LtR4HzI+6mAGM56daLUx5+ZtK1j1tAx/uxthLc0wK7v0tOLH5CCSIrcfs8n7JbfhY5ntdk+/JcMfVFV2GQWOPxa6aIH6ZMhl+7y/RU++kF/DLeVdVZKZisIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/wVq9iK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/wVq9iK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CADC4CEE2;
	Mon,  9 Sep 2024 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725903036;
	bh=RZ+ai00cDvAl3o4zxwAeE97jOxhIvb7/0bcsRHEdLnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J/wVq9iKOOLKilMrDaD/NN4HN1PLKxnEQFtvnpDiSHiPk4wpap0dabKLqcWl709SW
	 syG5b7E4UdVoeyYYLWf0Ok4UoT0hQ+RWu+IUFQ7tNc0Yv2FvQ3UjZfoaGbrCPInxX9
	 /sCmCZYexFbNtz5wyXyQc9Ga34doDO9c1quh+CHm6G4pKBi5Drhi1VC5ZjBBqYuzPQ
	 6IDdGo804IMoaeEalAXIzND/pOrX+uuxawSz910dy+dVTtCs92NSRNL8HWfaaAi4T1
	 JzrQ8E/zFcnu4v5PdsSqhl6gi+WEhn6uRfeQJv0B95LgBX775IyE5OefXxQnQw61i1
	 OZpP1nuWKaWgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FF03806654;
	Mon,  9 Sep 2024 17:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools/mpris-proxy: Add systemd user unit
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172590303717.3870513.10000246983993833488.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 17:30:37 +0000
References: <3548acb9bee2d1d8e0bd8e650a8557241e9e76ca.1725373981.git.agx@sigxcpu.org>
In-Reply-To: <3548acb9bee2d1d8e0bd8e650a8557241e9e76ca.1725373981.git.agx@sigxcpu.org>
To: =?utf-8?q?Guido_G=C3=BCnther_=3Cagx=40sigxcpu=2Eorg=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  3 Sep 2024 16:33:15 +0200 you wrote:
> That way it will be started automatically which is convenient on phones.
> Distributions can then decide part of which install the unit should be.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  Makefile.am                  |  3 +++
>  Makefile.obexd               |  3 +--
>  Makefile.tools               |  3 +++
>  configure.ac                 |  9 +++++++++
>  tools/mpris-proxy.service.in | 13 +++++++++++++
>  5 files changed, 29 insertions(+), 2 deletions(-)
>  create mode 100644 tools/mpris-proxy.service.in

Here is the summary with links:
  - tools/mpris-proxy: Add systemd user unit
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=daa86e06c376

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


