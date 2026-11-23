Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795470608;
	b=c/+OlHIMTDGi3B1d6EupTfECUKjh/EdVxck7AF96F7k9FgS7VSF09U4mzTBCMw6tY1hH
	 zsjKPDFwqTDIGhDNvg/qcu1Ty3xQ9QJE/BM7fnUsN5OtYYR1ezJeQfd6Y5/+9d/hCVzkn
	 CMD4tLYAzyHu/vuxWKGHjnYVaP35Vyul1HL2tVCYrPCQ/45mbR5Xy+UoyyUPTGno0Jqa7
	 mGgCEje/WblUZMx4W0dZFbDS+ofD6s5Rp6vnRSUcThCi4Phcy5Uskxw6jYu7EW+1GtD4z
	 1EO49oql0r8Shjx0Lg427LuRuZXY/rj4evGbp1N0o8l/dQPnzQnkIaw57MZ/AWpxt7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=5WdIsFyWntKNxW3GQxmDys0mXQlR7ZAK3iCHmf34w9o=;
	b=FkO9zGtLq0D6mK7NzHpFjzVl7mV8cO3IEBljJvqIK8PtOwaMnzcrGjN43ONPm3CetTmy
	 he0+Dq3omjFGJOSDndSZSf61btZXH76/MDR1meu5Jg/zM6sQxOBmqwwetw8xCUOyPj6YV
	 AGVxFDP/UJJTCu6UO/QcIE2tZuT7k2fjLLk5DOBRS4as7eCHSlQTRcY7SUYmapvfNEFUG
	 t6QjZKJb1EHCE4qL7WkMlMCoy3ZQrc0mR2odiPP0wOcVUmdcr1JXlEqtPRqB6MJwFjIe9
	 TpT/Z8Ashx8IbwU57KQUITOPlhou/5JXx1tAEw0fhGbGl8mEo2ihn9qHy+kc8+SLhDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fk0DlZqr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4543B606A326;
	Mon, 23 Nov 2026 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fk0DlZqr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2421F000D1;
	Mon, 23 Nov 2026 21:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795470607;
	bh=5WdIsFyWntKNxW3GQxmDys0mXQlR7ZAK3iCHmf34w9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Fk0DlZqreQTvlftJCk65f2gt8iIE5bExm3vtoQtvRYBK4InHPOUGJjL5joclEd1Ql
	 Nxihih/RJQfEf/mpo3YRTymfXp1K6QwRihXIKH4vJMo9J0An3R+R0OKltwiEWRHYrr
	 uwwhkaioiwOJ4i7rNif94jBryCSmvi4Z7CugEcNpX3egeKy+zgII+3WYtPzQAJ5pm7
	 GhJ4tAxQ2rGCJu3QLp3XyA+cItrvdttg4ezk8K0JDjcC20mJgePH5Ij54Qhb9cwHYb
	 X7v7eXSqyOnFjqyE+JJqFbGGjCqyLFs3A0xQ7TgfByEDsApZinXKNRM7dFaVAocpBU
	 kJUqEwYZ1GCGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B48F0392FFF8;
	Mon, 23 Nov 2026 21:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-11-23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179547060652.3141439.13603620067309586882.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 21:50:06 +0000
References: <20261123173408.3632176-1-luiz.dentz@gmail.com>
In-Reply-To: <20261123173408.3632176-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Nov 2026 12:34:08 -0500 you wrote:
> The following changes since commit 5beb86f98c3d45f6d64be5b6d6c77480487b41b4:
> 
>   Bluetooth: L2CAP: return LE credits from recvmsg under the conn lock (2026-11-17 11:39:36 -0500)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-11-23
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-11-23
    https://git.kernel.org/netdev/net/c/639a75a3539f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


