Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AAD3C2BA4;
	Wed,  9 Sep 2026 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982870; cv=none; b=Th2NJNPHDYceYIRLs38/coiqbps9AYuqKqE1PagUQuw8cBQoz1opw4SxhfVebJvxWYAdTgqvaGvC1B+uIysdtMdw4+DXIEABup3yQyIVBDtj5u9K5FfgTh94kei+ykmPfGq8Qk/L67EGN0muZ+0UY7iloGHN2vF8dPk5NEaKVBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982870; c=relaxed/simple;
	bh=9+8VuQQNZIn/z0wa4bnrLLCHtnY03w3k4Mp7dhxxPtE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cQEuFgv88wggxRab5D+UtqWueTvJNHFuQIiYks7xrfnpX7A6bvECQGUN9tYupyXocVxBfBSSjioHCcfS+fbq7k274H0sJzTJqjUFCyqvfJiZB5f0Pd+ZdpwwYlVQFkAQiia5NRx0FAb/WsfICLwOO8wwKPzQHaS88070GhYjhbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9IVY7fF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9IVY7fF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6727F1F00893;
	Wed,  9 Sep 2026 19:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788982868;
	bh=h/IlKkvLoViYU3HEaufUHn4QrX6VBO2i/QrNGRaOVCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j9IVY7fFiXzzreUGV9XtA9DxSUAZtkuyq1QzCO2Cc/CqC6D30cMgg+ZrIiCRQ9LRQ
	 pAvv97/cKVwZtK0vs+FOoOn3Bs/21IxBbJezw+yGYQaMs0jvZ5ErHJOFMjCeLm9Iqq
	 zDTdndOF2r2r7QS8f7Dh7xg7IKSgGJVaORlBLiL+jvkhAidc0yxiKS+kn4DKZtl/wK
	 f003WotGDPPoJ4t9Vet9kFDg+MjG3ghWs09JdCThbDSZkMCZBQMw1f2bVUE5BUwkhh
	 lRJIqccw1Fioy+N7WkC3dRzsdaD+7WNKzqonNi0jMnekHDSQmgibb7E0wOfL+f8djr
	 5CWua8g8CcatQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93973380AA63;
	Wed,  9 Sep 2026 19:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] Bluetooth: dial the address the peer is actually
 on
 air with
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178898280613.1023805.6938780571676141703.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 19:40:06 +0000
References: 
 <20260909-for-upstream-le-connect-on-air-addr-v3-0-0e49c4e7abc2@podgorny.cz>
In-Reply-To: 
 <20260909-for-upstream-le-connect-on-air-addr-v3-0-0e49c4e7abc2@podgorny.cz>
To: Radek Podgorny <radek@podgorny.cz>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 luiz.von.dentz@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 09 Sep 2026 00:29:35 +0200 you wrote:
> An identity address only reaches a peer advertising an RPA if the
> controller resolves it for us; where it cannot, the host has to dial the
> peer's on-air address itself. v2 did that by keeping the RPA in conn->dst
> when the controller will not translate, which Luiz asked for and which
> holds for as long as the peer is still using that RPA.
> 
> It does not hold once a peer turns privacy off. hci_connect_le() swaps in
> the cached RPA whenever the IRK has one, nothing ever clears that cache,
> and a peer that stops sending RPAs stops producing the reports that would
> refresh it. Before this series the conversion in __hci_conn_add() hid the
> problem by turning the stale RPA back into the identity address; keeping
> the RPA exposes it, and every connect attempt goes to an address the peer
> has abandoned.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: forget a peer's RPA once it advertises its identity address
    https://git.kernel.org/bluetooth/bluetooth-next/c/fb3a817741b1
  - [v3,2/2] Bluetooth: put the peer's on-air address on air when we cannot resolve
    https://git.kernel.org/bluetooth/bluetooth-next/c/e35544d23359

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


