Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7110785;
	Thu, 11 Jun 2026 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200691; cv=none; b=agD7jpGB+M8+eXqLD9msBFjB78MDBNS0L6wCizbdftSKldz94I8LuaWqHqP3If9nJwuH4JUfBqIf6dj0Tcyxf6N3ZkO07x1OvWApLJz1ESv5PMcV1CIdKtqVIdW5uG8i+x7drsWQm+XWgk8SDSHwt/KlxRhIeGnhwKO6h+Wmno8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200691; c=relaxed/simple;
	bh=jTupZYfdlibwO7fHX6qwlBQEh/IEIvd0t6JgvAB0ZDI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=puoQ6/TcnuhRY/7w72t0IOeKqHpAGDAkMonRqkE6/qg3V7I3iXLtrAmmufW3SbVUXsHv76biQ9MPrW8NOTA9bMqPiOyjfReN5PDM0tBzAi4mqfzo31L1f5+YGoFJUcgotzXlYx5s6mpu+25oCWzQtYUmPbA62ZE09n4rWD5p2FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kivoiqx1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kivoiqx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CEC1F00893;
	Thu, 11 Jun 2026 17:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200690;
	bh=Gs00lLWhI4VXZ9S62b5ijwbVL87akkIGVr1Q9lteUEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kivoiqx1Wuzs8zC1sK398UVErkgbLzClya8/iB6XWaUx/SCfT5Nt8CchCIW21AjpT
	 IiLviEpZRupdskKiGG8b3H2XACL4bwGyZHDMYB2/l2xWqfA17XyauP4ZT6y6q7uRr0
	 LEhc37eLmw6F/p4HIcgdMCbg3VBV4Sd1HVm9AvlqDI8iDe7wlEKhFJiHXTcLrewK2l
	 BKZKuCkbCBoqi+s+1kunCseTg3H6wEpqYRcRM8M9VevPlbLXeDLAge8jYhH/IJe08C
	 17gB3ytcM+FtgP2aYfgTm7w5gakW3pb70AjjTecpbYrFORza8M6bFgXnkf8qnw4u5I
	 Vm6k/ARCpxmsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8A3493930F87;
	Thu, 11 Jun 2026 17:58:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-05-14
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178120068734.286318.15929310883148009790.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 17:58:07 +0000
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
In-Reply-To: <20260514172340.1515042-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 May 2026 13:23:40 -0400 you wrote:
> The following changes since commit c78bdba7b9666020c0832150a4fc4c0aebc7c6ac:
> 
>   net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:12 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-14
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-05-14
    https://git.kernel.org/bluetooth/bluetooth-next/c/23f3b04f157c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


