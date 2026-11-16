Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859213;
	b=nme+WfzmB1TDINGjQFE11vUVL66cXPX6MYs6yFJOr8ijO3PS1wug6UrS4IRQ7lqGvL3r
	 j3+ZxwHtytqgdnoNjdyvuyqkmDwzDBgvLexKd9hP3F2rPc5tabl5inePh1ZZpygJqY9dL
	 Air7SmdXPUuZZpNJGLDaDZxVCjuTMhbdkJcruS2r+2cnjegARlQBJumhdN44TNAGn+WdQ
	 lWh4YqDtmKu2ZgiP1syMcuXfN5LL6yQfN1Cmrf/kmRD8Gm8cMQeUJRO1VfmMKHKg580TK
	 YiFDxnw3cf3bnv3GzoQA6w1zb+c3uUMkps1qckU1NZx9KL83PX4Iz2usTiyHH2T5TwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859213;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=3jOQQAxFAPQrUiv9hNG0pHej8Q3l8zqxtcRuEhbSxCM=;
	b=JZYElntPalNyjLGqMO8ZMwKKD/YEfVJm8BI9BH6Vjl7+SWUpLwFpKn7ZObpqqEtBgcnE
	 EWjZ/6zpK2agjDirlIvGQtt9TUKQZYUsDpyrdKM3m1RbjnHOXLmThrhle4BdWHzyGZBKt
	 ruMzvSVfx3nUT2kxU/219G+xQoQkPedGiUFF+hJyfWx3ClfEMwbIlT07QDzrWregTqUWT
	 niM6BuRAs7kbQMnA0sWT2/foZ4vtxb5UmzKnbQW11Y7z+EYx/DcYTVrURBkM3I79PtO0T
	 mDgXoDjyo9l6QalkinSvxtYwctN8/kT+gj1JDXF4Mc8rRypZbroI4MNgcl8CRn1zrjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HeYe8znn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD9606A322
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HeYe8znn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C971F000C4;
	Mon, 16 Nov 2026 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794859213;
	bh=3jOQQAxFAPQrUiv9hNG0pHej8Q3l8zqxtcRuEhbSxCM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HeYe8znnQbLlb5ZFQt6dgNZ6w5YZudn/XAWHPNK8EK6JFdXDv+qg5lbsuVuEN+tUg
	 LuzP2t4ZF3w2CX8tx5tHdsAzjmCrwMbmH3Yo24rLuPiZgfDw4CATcE1iksv5GOTKCq
	 62MI7OVPbYNSWc+SdYe2/cm65V2oARhkyhwXzIqbaIoMrITxcfryXa9Ybss3Qs/4Iy
	 JnzwlO1BtWf5oaZVm9X0vbPqc8iwgw+DyEbCTpLnX3XIvufyjDBOQ7/2yomm9OKf7D
	 CVCS0/1g9zifETrpWdVgUd3Z3Sobi1VpIejdTAIri6B3fN1QsH6NGHP51CghcL82h2
	 WrKaQfbv1zfwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773D9391AFCC;
	Mon, 16 Nov 2026 20:00:13 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v2] advertising: Fix double-free in client_free
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485921202.3860040.16430372342970958452.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 20:00:12 +0000
References: <20261113092759.24927-1-pvbozhko@salutedevices.com>
In-Reply-To: <20261113092759.24927-1-pvbozhko@salutedevices.com>
To: Pavel Bozhko <pvbozhko@salutedevices.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 13 Nov 2026 12:27:59 +0300 you wrote:
> Unregister, disconnect and a failed RegisterAdvertisement can each
> queue client_free() from idle. The second g_free(client->owner) aborts
> bluetoothd. Freeing the client directly while that idle is still
> pending lets the callback run after the client is gone.
> 
> Remember the g_idle_add() id and do not queue another free while it is
> set. Drop the idle source when the client is freed directly.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] advertising: Fix double-free in client_free
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=de977a4eb953

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


