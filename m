Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0414245A2B4;
	Tue,  1 Sep 2026 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788294665; cv=none; b=sCf5spL2v5TXPlHcjf+3cRCADjHxZ+Yt8RhVv2SV5HQ0nJA7M7xtFdnt8zyQWw9xVVJZH5Yl7ee0ougsSUgJjBezqg4+zZfN820Dr+pVQ8rqZlwpzH2nh1DYcumqq4prDNVvudbE9A2Ht84Zh2WQD1obTin0lwxxKU5gDHvfXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788294665; c=relaxed/simple;
	bh=jAv1w+BDUI+9Pt98e7Bd1DGPKqcmFr+S48wTBAsoswg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OkQlLsuLpUmKpeOAF6wVEdGPPkx0jpJR8yH7ngbCtH/azgFkqfG/Vg6QNHI9lBQ5oxf6VeDKW3/6xrJVOojZRrSWyKW40REaTqn/NtcNiiEFWXj6/QGgEYxYk1nwIHGCDEvvu94dHNBa6vrf4S/kNdGDD0fCH08CsjVrQjHCDbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1QnKl6m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1QnKl6m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3B01F000E9;
	Tue,  1 Sep 2026 20:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788294663;
	bh=Pf6D2QdPe3vyn6eNxdFTAjUb0lCC1yH/tOKj9y52YZk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E1QnKl6m5uFvWmenRHuUEL3giM1o2ezbQZRPn9I0OGj1TZL9B1rLbNLQVbXqrwb+3
	 Z6zK+RMHQVkHbBw+VnKaAhuobVxNgCmEFJ2/KJTuXVZtZoL76lGLRK4xVJ6ZUw+Rnb
	 6fSUvFFfHuF8IRZ1BJ0xhnwAvrtzja/3Ky/kSkFgtVtBVPAvkEB7qCx5C0A0oSN+A3
	 I+9hFTaZ/nTXvzy1WalZHXGct3+NxT7LLTHIIhv0f/QpCLyAt7LkotCDWvqHtGw3o8
	 5doFEY6D50uUPSQ1ocJzLJkK+YudWksyEGqdEeKXXLoMeAHU8sQFd9a6R+zE5aWWRc
	 YunmKA0rwim3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5696539253F2;
	Tue,  1 Sep 2026 20:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: Properly disable remote wakeup for
 MT7922/MT7925 on Ryzen platform
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178829460590.1836726.11844830813053776119.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 20:30:05 +0000
References: <20260902-btmtk-ryzen-remote-wakeup-v3-1-8a733d0edd7c@rong.moe>
In-Reply-To: <20260902-btmtk-ryzen-remote-wakeup-v3-1-8a733d0edd7c@rong.moe>
To: Rong Zhang <i@rong.moe>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, luiz.von.dentz@intel.com,
 Chris.Lu@mediatek.com, Will-CY.Lee@mediatek.com, ss.wu@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 rafael@rcpassos.me

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 02 Sep 2026 02:19:18 +0800 you wrote:
> It is reported that a remote wakeup could cause MT7922/MT7925's btusb
> interface completely unresponsive. Resetting the xHCI root hub doesn't
> help at all, and recovering from such a state needs a power cycle.
> 
> All reports seen to be relevant to Ryzen-based laptops. These NICs are
> usually used as OEM components thanks to some sort of reference designs.
> Their popularity on other platforms is unclear. While there is still a
> chance that the quirk may exist on other platforms, be cautious and only
> apply the quirk to direct children of Ryzen platforms's root hubs for
> the time being. In most cases the root hub is on the SoC or PCH, which
> needs the quirk. Unfortunately, this can't distinguish root hubs on PCIe
> add-in cards. Such roughness should be acceptable, as PCIe USB
> controller add-in cards are less commonly used nowadays. On the other
> hand, applying the quirk doesn't hurt any functionalities either, as the
> device can still be used as a wakeup source if desired. Theoretically,
> we could retrieve the root hub's PCI vendor ID with some hierarchy
> magic, but that's too intrusive...
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: Properly disable remote wakeup for MT7922/MT7925 on Ryzen platform
    https://git.kernel.org/bluetooth/bluetooth-next/c/512bf4484766

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


