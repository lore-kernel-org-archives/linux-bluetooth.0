Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5213A272
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221225; cv=none; b=H+IC5rcySjr94dGLn8e0scXgd6igdonWNdnruQBhAyPfH6r2Q11QFTd/2irR2YEDqRVoVlCPur/v2Vuobmk+GqCBEwD4odFPTjvF1XV24JAswN0F8BeHjE50ot26q6poCBe1ZSaXfiKPmPHLlFT5QQW2TH5yk1UJAimXsYtq/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221225; c=relaxed/simple;
	bh=GNrvTmx2mJRJ4hzTXHBdZtg1SFB3FSeGlRdT/l0XcWc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ab6DqgGluMMQCiBWJ+DFlQaNBrkxtzraeMm1t1uwldX1Lxd8L1XkWuPDHApZga3Sp4coxNH69YTqTHwFC7ZvDYsGEZ5qd0pT4AkWgU5iX9f9aFY/1cyZ1GXor/qxl1GRxiBanlSmKOinjf3IuJSuLIo75y53VwdjGwfZcl1ElqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMuHOVZV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMuHOVZV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B90DC433C7;
	Thu, 25 Jan 2024 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706221225;
	bh=GNrvTmx2mJRJ4hzTXHBdZtg1SFB3FSeGlRdT/l0XcWc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CMuHOVZVH0LZCh2eNOBAjpVNBXaTKdYEfRWkpHCclRZT5V+Uno4Pqm4i5XPq6J23Q
	 ZnRsIx5x0CFSsz6pR/jBYjq4ZE45TAJyc7bi6fT+7PPVk8/siZekTq9bS+rlTyjXeS
	 Pod23CT+r6Qjk0MKM9IYc5cMzMfQWlt6C0yxIXqQyyj37oA9ny3b7chC7YsMVrvyIm
	 CffqTSQjsy06P2YIur+8uNDiWyag1QIRefqMs3dQDr4Qyl/fJu6ZqDWN8TICIlgBnU
	 kFttY0hS47jnDxM7IDHnK3lTNXsR4booszMnwYH6muLQpmStf1yGzOgxU7jMHO7mxX
	 7AOsYF9yo7m0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44E35D8C966;
	Thu, 25 Jan 2024 22:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bap: Fix update of context
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170622122527.3098.15721809471546714184.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 22:20:25 +0000
References: <20240125125156.1679513-1-kiran.k@intel.com>
In-Reply-To: <20240125125156.1679513-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 Jan 2024 18:21:56 +0530 you wrote:
> Fix context getting updated with support_context.
> ---
>  src/shared/bap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - bap: Fix update of context
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2e2e50011d0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


