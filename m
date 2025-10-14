Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EF524C669
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481028; cv=none; b=DHldMmVXrEXjjqtsXfiDN7YZCZAlcGlpnZYVOy54ezehrgQV9LTwTwCbAuT9RCNm9LUeusqRH3TXR5C0Jk32cyogRdiMQqqjvDZ+p+jgoWDMBG1xDI6Gmph+XowgTqDdM4AyvEjnDzrnbRMNPsfJLBQ9MbfoSGJfUiFTy6uygGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481028; c=relaxed/simple;
	bh=SOKXGFdxW0byNY3bSNFQcZd1K8RiopwYc/xs69oUwt4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f0piktL1cZq3kHfEheThVWKOHBqZH3x+LHKqbTEtJj5GRcTNGs/QucuHee8IcCgxCbLNHMuJCV+4Q63RVE8NuhqjxicFPJXuQNSGVZHTsWMvTa8bsxIYhuRYH/YY+XYU1G4SZcfsuCbVypu3ZLR5pANemS4DFrMiwfJ7qWtLfgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlrECDzJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlrECDzJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52DBC4CEE7;
	Tue, 14 Oct 2025 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760481027;
	bh=SOKXGFdxW0byNY3bSNFQcZd1K8RiopwYc/xs69oUwt4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YlrECDzJK1VsTT2KXfHRtoZIazHDDanzOLYNfW2Ru2cexJ4Bf7hHViI9rTYU1VJ1E
	 qrVvkOSOT0PtaDfCUCrWOoLf/w2LuHGQol5G6MDfUqPvyUGGvNzaYQf/ZJqU7naziP
	 PrpkacdUG655qbNpjfGG0oE3HpSJEZOGe0Gkb3YXP41wxgJChwF1DijP+yDJnH+PLI
	 ENXHYfhaEpmUhqGAL3ycr1Mig5Sd8SOHyYGM2rdyZMQFu0gmRXwgEdjNJU0RPaqWEE
	 kEWeS3g7o3hxpfyNkJe/QtWBdKxKLOVWl8xahgwujdVhXLlq+30P6fTkH9U7LLD4vw
	 qaolmv4z0fL6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34147380AAFF;
	Tue, 14 Oct 2025 22:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] transport: Attempt to reuse object paths
 whenever
 possible
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176048101300.129201.3584298394855914785.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 22:30:13 +0000
References: <20251014202551.423660-1-luiz.dentz@gmail.com>
In-Reply-To: <20251014202551.423660-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 14 Oct 2025 16:25:51 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to reuse object paths whenever possible to make
> scripting a little more predictable by not having the fd number
> being increased regardless of the actual number of transports.
> ---
>  profiles/audio/transport.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] transport: Attempt to reuse object paths whenever possible
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dacb93ddc1b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


