Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956842A1BF;
	Wed,  7 Oct 2026 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791334208; cv=none; b=VP04bLNlRvPrYjteIqATAGWDTtzjvlCxh5p78t6bCTzitUUBesSh/4XHMstY3EMDAbA2mmfXe0TEHQzT1Hn0aiV49yUYhf5cI1jjcsbRLiykEgIGvSXtDjSiwW9cQIESO4m1azqL+H6Mw50UXyD2kaPS6AS4OqzpcnzSvNLJTU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791334208; c=relaxed/simple;
	bh=5/jXB2pTOVdmgaZNXJkIYNmL3HlV//TPCiz/d0KW9d8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eCMBBfd/TL5BkHPfit/gxc9PaFiGiNTghEkigHAiOy9DG6WB3nwZmlJgbdVeRzWhtd1K02En47O2Ykm+xhp5kscCirSThKnXcRh6ea45TBBh9SN8ERNegjl/TuX+zVj/SkpxYQqc0CJNS4nTTe3L/mlcktN8aTwUjMRDqv7PAoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDns6IDJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDns6IDJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA4A1F0089C;
	Wed,  7 Oct 2026 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791334207;
	bh=PcIFA4BP48kfw7mcjRNkpIPLNqDGoegboBr0PH1YYpc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eDns6IDJB6CogwBhlNZ0/9NCn/JVHrNP5Z70yDGCJRaVraqVYqfxsDYaFcBu9xczZ
	 Ne2ApcIXSgsQXbTrM70OMNA8h9FSFuWx+pxo/YiwvDKhYfwvTsbKYfMcKUbYWk1McY
	 huduA1qL0uJfTAI/NrYM0hAAw5domLJqDdaJcQZp1nAN+Ff4xAqEFN7eMMHdpw3CIa
	 2A8/hp3/XygesvgTL/JPqIqr+dmr4NlzBSLVZJVcpcW4Eiqj7GKNfvdd3GLWxenqQ3
	 g+2ckd0PEhEFw0Op+mJjfIaPc5AsrrSRgCwWxv/jChxntQeXbikH5I3a42PFUpq5K1
	 dAC8EhvifCilQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774B43806541;
	Wed,  7 Oct 2026 00:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-10-05
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133420628.2847663.15335893484734356127.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 00:50:06 +0000
References: <20261005194436.3594085-1-luiz.dentz@gmail.com>
In-Reply-To: <20261005194436.3594085-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Oct 2026 15:44:36 -0400 you wrote:
> The following changes since commit 848a7a91c7f03675d3bd8db6f7721cbf9cb50e21:
> 
>   Bluetooth: hci_core: Serialize SCO and ISO scheduling with teardown (2026-09-28 11:00:20 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-10-05
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-10-05
    https://git.kernel.org/netdev/net/c/c5c4e1701059

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


