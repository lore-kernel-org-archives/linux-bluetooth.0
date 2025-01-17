Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20011A256E
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137410; cv=none; b=Au7SooJEK7oZgpLRrhxVT3p9OT43DX9y7iK0cohxVNfEYr+me8N7koYPZpKiGxD0AGr50UEeJkfm8GCWJy1r1EH8bb5ew5k/9tkx1NDkomBoV1o7O/yaP+VI1pvkGruInZZr6TKaW2Wz8SA/G1j5n/3h4awqVlaBXdeG10SogZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137410; c=relaxed/simple;
	bh=Vm1CHOZ0CfECjDXOGdHTJluKqzU9xGdS42JmCISkzLY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n8CtnymJGoMiO+v26E6Mj5f4fwcrPrQ646b7lr2z8TqlRstXOz/sK9tOTehm0RYhGewuv/EFwp02F4s6CFWgutdCr45pMBobaruczcnQ9D2sSvfM02rRHTfRHViqdmStTekCEdgL+suDySCz42AOfBV88oBdX2ps3aGO3HR/QNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrqRTL7P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrqRTL7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28438C4CEDD;
	Fri, 17 Jan 2025 18:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737137410;
	bh=Vm1CHOZ0CfECjDXOGdHTJluKqzU9xGdS42JmCISkzLY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TrqRTL7Pe5pHpvYfEbpRbbMusxwZffT9kAPW/P28Lf5e6q6k2Wf0ee1SWQRi3usay
	 H4uO24BSZKgfRUgM2QYjEJ5pNFJ0k54AkmTzlTDL3+FcdtIvSCNhWr8KGLhPizGzUY
	 eLOSyzY2INZXuuovPvz5INBhuYB+L8IT6AJrOnUXJoMi+yZUYuarTDZ+t4qpIi+B67
	 iPjUC+mlZkbfTzBSM6+hHMIc+GPBrK/qWdox1A3TNaxvfBkTEdtkkJNIo/zc1Mj7yJ
	 jZ/5zg67P+a6+IV4bJUloZPP51W9A3Sw4N+BbfLikvdL2imQJTWMIk7AGSfBdDyTMe
	 lvgYjUhAdCBxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE078380AA6A;
	Fri, 17 Jan 2025 18:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] shared/bap: Fix BASE parsing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173713743350.2213962.13510645298591326713.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jan 2025 18:10:33 +0000
References: <20250117140632.120501-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20250117140632.120501-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 17 Jan 2025 16:06:30 +0200 you wrote:
> This patch adds some fixes for the BASE parsing logic in BAP:
> 
> The first commit fixes the getsockopt call for BT_ISO_BASE, to
> make sure that the correct BASE length is read from the kernel.
> 
> The second commit adds a missing case in the BASE parsing logic
> for Broadcast Sinks: the BASE structure might contain level 3
> (BIS specific) configuration LTV types that are not present at
> level 2 (subgroup level). These values should also be appended
> to the final BIS configuration.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] btio: Set correct length for getsockopt
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=07e8e726758f
  - [BlueZ,2/2] shared/bap: Append extra L3 LTVs to BIS config
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1479c86ec116

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


