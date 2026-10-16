Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C6F4D9561;
	Fri, 16 Oct 2026 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108814; cv=none; b=Yekhm2X508KEj6hePNgHOs19n1YfW/+fY5OBYVTftEC2j8Z9wrEIhZlUw6p7TZE15onJzdmp/RlWkePa+L5iDPceHLFKKjuH14AW8XJK7N1xB4uAIz7kEZz5z7sT2cTWc64kyn6EeiJW32MuxZiXpKddD3V1QVhK+Z+K8pHcPbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108814; c=relaxed/simple;
	bh=AvtPLwaCpwF2Gw0JfpkxvGaovgVuWyHfAfVF/97CiT4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o8pfRUEvhiefkGiTDmUXDcBecSfisxT0HCclY05jQYaxw01LGQdrGX3eMszd/qhe2KfD5oPM6cVjaeTO6kKfbkbsFSImUQ9vyEMSOkiLQzuEyTvQMhIk0OHXAOQstCgwUJ4yXfTYXsCINCqNeXwO5dWDeNDE0pTKMPTm7+PXKJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8jUCHGL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8jUCHGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078D01F000C4;
	Fri, 16 Oct 2026 00:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792108813;
	bh=tL+KxbIRBqhL/Vs9+45Fh8r4UYWtakW6EBgqsM//EgQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T8jUCHGLGlbJgDOdsrkMgh/TA3/xJhUiho1QGI7lw5Z53VfYWlrlsgAJJAWc6Ceff
	 wyrN7Yhz4vlEfT6Yj7UFe7Aq6M5CMJmxXeNj2XQ/6tNRk092LTaQT9f6wP66Bd43By
	 4ZaRsRjNAV4erTn9ZHkGWjsNmPoCIJttG/1xWUCpWwZiHooqErKk2iv1EkAx7NIwLs
	 lz4e99TcEY6E4Ze7eIwW7idnqJiUUYMr4Uqt4HHYz20WKjYKzG2RbPvlXnT9Ox32ME
	 DfMtxrvZ47kzpZRqUW6340E55QGkF+bQxX0F/GqS2uPiVTkq7qqQu1jm2Iw2GGbifY
	 cNkxR2d3zYh2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15673808209;
	Fri, 16 Oct 2026 00:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth-next 2026-10-14
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179210881178.4163852.17244496645953243826.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 00:00:11 +0000
References: <20261014184327.1648397-1-luiz.dentz@gmail.com>
In-Reply-To: <20261014184327.1648397-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Oct 2026 14:43:25 -0400 you wrote:
> The following changes since commit 05b5019b01fb9443b09ae4ed34af1135a80a84c8:
> 
>   net: alacritech: fix dma_free_coherent() in error path (2026-10-13 15:48:29 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-10-14
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth-next 2026-10-14
    https://git.kernel.org/netdev/net-next/c/07380336e09d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


