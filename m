Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107E033E360;
	Thu,  2 Apr 2026 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775096431; cv=none; b=EPsIDj55nTanttaUP8X1wqnQoURLq8mfNBGyhMUx/Mwuxy3gMxlqIBtRLbK1xucXABsYdIjEtC7JrTb4BhG47OLLqjr2ra2I8XAoLoacWL2/mxC6mcrCNzbicISo9PgB12cXuS2l550d0xJGFODFwEFJ70u61ZfW8vFAc7UuO98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775096431; c=relaxed/simple;
	bh=VY7eA5+7AoQHzloZuClj4mpWiH2GyQuzGzueYBEwECY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HwcYDbvQKWlArWm8wTj3PzF4YES8fEm0ioJshufaex0CkH+VJWBqvWglWvuK2zlyslNHFJvhh7x1liuGvvqwvLRg9Ai98dXJool/yp0TLhCWgU1CpWq/KkOEQO7ysucRUX8NWcYdcEj+BkLNQuXyc8osCmNS0uSbLv0rJom75ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoeKorNm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoeKorNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99584C19421;
	Thu,  2 Apr 2026 02:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775096430;
	bh=VY7eA5+7AoQHzloZuClj4mpWiH2GyQuzGzueYBEwECY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HoeKorNmhasUfix3cG1g0jzaLLD+wSkzGYwLhhTO4//sXVzJBpJxZVcx2NokWI2tx
	 tmCtm3lkMsgJ5jKAlNv42lo3+wIN+ykuhp6riwtk9blNnJryOXuHUGMT1mwHu3HoVe
	 Ne+thaQIR4K36AjuyA6N43gOenUr6S4FZtk6JDUnIEx6CYDO5vXxY1nq24Gksn5QVo
	 UaK4aBMQd5K7bHtfL2W4JYrLjCJ0J5b2uAqSEX/bocREqdAvzCjjJHYkUppnhWCEV1
	 wjQAiDu5VUGImHoNqezIQnn1KEo+G+7hQTSK4Ch1qucNLOoipsQQw+uaJwM08n3RKO
	 6rzn1nJKTnUhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF723808203;
	Thu,  2 Apr 2026 02:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-04-01
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177509641329.3954047.5436491997819526627.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 02:20:13 +0000
References: <20260401205834.2189162-1-luiz.dentz@gmail.com>
In-Reply-To: <20260401205834.2189162-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Apr 2026 16:58:34 -0400 you wrote:
> The following changes since commit 48b3cd69265f346f64b93064723492da46206e9b:
> 
>   net: stmmac: skip VLAN restore when VLAN hash ops are missing (2026-03-31 19:45:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-04-01
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-04-01
    https://git.kernel.org/netdev/net/c/6d6be7070e90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


