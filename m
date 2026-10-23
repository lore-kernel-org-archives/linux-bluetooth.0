Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794014;
	b=ueMwl8YDCJwxQgmpwA5GK5KWpu4cHYg3GyXKBRShTG3ZgokwpPGNBTJzbuX85Igm2dYX
	 A9hCR6FIBY5X9PvzM5tl9gL74h6reWqzsNHPA3t3cyulUtWdN14Fw3LFbPL9kaUasSmI1
	 +QZhjkSpvC+eY7jm4SDwlyAxLdFcnin4CfTXtvP7knMsUTIrOWxjEHS1h6u94qf2Uwbb0
	 4RgJ3AjgiR/gnSEPjHaQFM9CI6wJlm7drG8VRG5fLvx3dP7HNWH0z1yKRAMLgJ+dyQwBp
	 hc0/Qa+8IAJFGZEw0ggvM4StcjYa1Z3LzTTyNat8L4IFEjo718geh6hzD8JF2I98LBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794014;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=lPJGAhkRWj4/xY6Eh++aiQdpcJwOIqrwUOr0IlI4L0U=;
	b=k/Ad5eQSYUSEhJZAytXmltH8D3KPVTw25tEijUms2ri3IqkkhiWMRJC1JO/u978Pid9K
	 0XU8o4G7qIry+wnJOLEYiSPN2sWFp1oZO22xLvvqlz7ZXadPSWWKoLsTEbcxJciFKiVPW
	 ZvDNyEy51yK2wUPFwvj0GPptV0qv+bLTrKDShXa/R+uRiH2BDiQkBLcJle1k9TsJtJJp7
	 1r80GjK1B8SO5OwOby5mKVLCQJztWPGYhHtrDU/CDMu2E+SECH5y+wSzzUiFRPO/wdMum
	 IgB8u7BWjGRuUT7A/YcYU/Y0GR8NT21dmI6By7z/TKQhuGdpBSwEJCGza6LCfFs/PsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jxa3hncT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158F5606A322
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jxa3hncT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75561F01828;
	Fri, 23 Oct 2026 22:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792794013;
	bh=lPJGAhkRWj4/xY6Eh++aiQdpcJwOIqrwUOr0IlI4L0U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Jxa3hncTL5jmrQoi0DI0l2FBxuDMw1zmRLdRacWFRYDb3pAVafHAwPw7kYEJTl97V
	 Sk36QWujdvenlvhKDIDgW5PgUhlUh5FpTYtEozjZCcrArobjKvYLKydzx6OCWGVh8B
	 KpNFjU+JqqEwUHS4Z6laOmNej7+OnQK6nvAyz7Mj3ffWtMBqmMOZ/Bv5u54uL6t0V/
	 +agwtZIa79ziyGnILu5QHQM+2cEBa8PWX8Qs3OrpEVSD6U0iHWeY7q52Jg0y+UFa43
	 t2sCEXvC58XbchszLZ7aSDA6smTsC7kbrJaJahR+TiQeQx1laFQWYTLSJ7ZbzqT3jg
	 VMfQWPI8RQGlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE5EB391B158;
	Fri, 23 Oct 2026 22:20:13 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ] mesh: Fix Command Disallowed on random address
 change
 in generic IO
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179279401231.1297354.6966004828861249806.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 22:20:12 +0000
References: 
 <AM5P250MB4222047E08E92211215A496AACCB652@AM5P250MB422204.EURP250.PROD.OUTLOOK.COM>
In-Reply-To: 
 <AM5P250MB4222047E08E92211215A496AACCB652@AM5P250MB422204.EURP250.PROD.OUTLOOK.COM>
To: =?utf-8?q?Aur=C3=A9lien_Rivet_=3Caurelienrivet=40hotmail=2Efr=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
 luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 22 Oct 2026 18:01:26 +0000 you wrote:
> send_cancel_done() issues LE Set Random Address at the end of every
> burst of ADVs. The controller rejects that command with Command
> Disallowed (0x0c) while scanning is enabled, per Core Spec, Vol 4,
> Part E, Section 7.8.4, so the address never rotates as long as any
> scan is registered, such as a provisioner discovering unprovisioned
> devices.
> 
> [...]

Here is the summary with links:
  - [BlueZ] mesh: Fix Command Disallowed on random address change in generic IO
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4de4f60f1e78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


