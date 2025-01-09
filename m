Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9491684AE;
	Thu,  9 Jan 2025 03:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736394010; cv=none; b=UDlvARsch5cwPa7MNXAZvgOPRXSC+AELX7S71zJuxuZ4uog3RmKs17/Is34Kc9vDt5t19i1Tr6nak9lyn1nLR84SuC041T43++rhmlRRSb3/g3gx08/5Qlv8nZy1Nz8hG1ITaHOPuiplofidInYmRaysNrgfhBqWomQ+3AoLrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736394010; c=relaxed/simple;
	bh=90JsUrL5nuk7wx0a0OtX9zNub/m9y1N1oBwiHaShhC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PhKU4zEi52PCcHtQbr4axyJUUQYk8/V0B8PhLxpXOM1kqNJ0b0P5ZHbf+huy3+U7fNzScR4i2lWSy3Y620/Zrca1LOYrIbZpwJYbsC7aN+231ickzQ3f5ehXorDtlR2ELZaFID9fs09sPPFzTOYKO+rUIfSQrq9nw9vv+TPxixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzk43XaU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzk43XaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA29C4CED2;
	Thu,  9 Jan 2025 03:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736394010;
	bh=90JsUrL5nuk7wx0a0OtX9zNub/m9y1N1oBwiHaShhC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rzk43XaUKuKBA/uYVWdPPmpRygej9wArYhZIpPX9nN5npgR7XEmXny0JKH/L32WBK
	 zX2w7fjgtzHNF3M5W4Itpz1pdTkyVICQ7hyCJf9UAHVU/RlVY5ttdj0sKDowkFdUGo
	 9u+KcNyf18M2NWHinWAoZJfToiHAq6RSvCzSzU7O2X0gCbAtTARBndxlUzZL3rX97u
	 2DzI+Ofe5+oBHqa92gqVPOkWc1xubwkEpMZIjTVaKphIvaGanSni3ELqHhbujMLs8N
	 9NcrBmC182ogvjOdvwIddiW7SSroN/VgqNCnbAQe0eKBpRzOoKzKqjab7KQxe1FKQY
	 p8uEO608ZRlxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34842380A965;
	Thu,  9 Jan 2025 03:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2025-01-08
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173639403198.861924.6286078659211532622.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 03:40:31 +0000
References: <20250108162627.1623760-1-luiz.dentz@gmail.com>
In-Reply-To: <20250108162627.1623760-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Jan 2025 11:26:27 -0500 you wrote:
> The following changes since commit db78475ba0d3c66d430f7ded2388cc041078a542:
> 
>   eth: gve: use appropriate helper to set xdp_features (2025-01-07 18:07:14 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-01-08
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2025-01-08
    https://git.kernel.org/netdev/net/c/6730ee8f083c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


