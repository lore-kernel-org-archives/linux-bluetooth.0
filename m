Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF551A683B;
	Fri, 12 Jun 2026 00:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223640; cv=none; b=LPXhH2vwxvkPmO0NPyJwT2d0D03L6dJsTzcDBe7ZsREs2+pbq0yyu8IVs27xQC4N8c6iAO3hk1o7t+pVPUXrNDe1byxvCd9qE/VrxQgixmf2OK5JibC69A3XIwAB42HSHKl87FcZj80yfSWBa+3KgLBAkpH6F0ya8lGD4qGfRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223640; c=relaxed/simple;
	bh=bnYyWB/jzmiPeC6yb3YhZ+1v8UGLG1/ujyFrsvbhvjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DUdynN4nx1a6i5JbXwJ+crjXrp72CwL9kbJzF8Qzixwg1lbZ9kJtD6UPVVksaL930AcvARi6KxttdPc9Qz7xzfMu9dWqUwyDgyuaQNL5EN6M12GK3VpuiCXveyaB9G2uVovoJ+oOjBnuhTNqbHKb8s2uC9htqN4+GjG6UNw7cd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk7YF5TL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk7YF5TL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A471F000E9;
	Fri, 12 Jun 2026 00:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781223639;
	bh=8q9+Vf2Q0+lZtv0cMssXtgy79bKZooXtJH5VxQFl0ww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Kk7YF5TLTCQTJHfB/zHAzQpdq0CydxJsN23UL/wCSZ+qxzrTQdvneEmJ9UqAsAK6k
	 hjRg+7ycQBtRBLPolqseN/rQyzKFUAhG1V2Yt4sR8TcKePoCQyPuQg0e1uvF4/1Spo
	 bN5YoeHFWh/3g879tCQBvFSjQF69jnyltZsMnfptm+LoSKyNKsoAUdG9q/OtAQxfUk
	 NT2Et/Kj8/VGAuWCh1vAgfDOXw++0F1WP7W95QCyLfhAvr8H4ygqos+t+uQVFVFp+i
	 QTHaZCqq2jG8VIR+QMXPY2AjTEw2tSi365SYlZTV5oq5DHfzyGGJ6G+Krq2FOxa5mg
	 uDyU5G1ceOIeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A4F3930FB4;
	Fri, 12 Jun 2026 00:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth-next 2026-06-11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178122363633.417413.2467188185850827867.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 00:20:36 +0000
References: <20260611183358.176776-1-luiz.dentz@gmail.com>
In-Reply-To: <20260611183358.176776-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 14:33:58 -0400 you wrote:
> The following changes since commit 518d8d0199538a4d6d5e51064044ece71e0c42e7:
> 
>   net: sched: avoid printing uninitialized link speed (2026-06-11 15:44:55 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-06-11
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth-next 2026-06-11
    https://git.kernel.org/netdev/net-next/c/9bbdc7dc4090

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


