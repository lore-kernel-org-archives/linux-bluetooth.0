Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327013;
	b=ZLpmK7jNPoDgjfLDAUkj6tBzP4Ab+udpdp5zjuoEoe+e4HWBlPBeaYSYFUOqF05m+b7W
	 RqiWNe7RCT11xEosMzcktTdu3tO8OA+KRaEemcwUKl4SrebjaJkpRwcSWC6KltvKonwew
	 GdKJhCWYYomWdvl3rUFBUiOmwKCm4Y6epgwqAFs1eOhkBolm6hagT/ba/KEVVPWORgXZm
	 ezJppwMIj+YcZn6xqABX/Z/rFUKXHoIUsArtSuKLwgQP3fXWZjUH5SKKGinyNusWXRye4
	 L4Lz+Pidht7ymHPpvhe5PkWnuqy/Aw+Atqm+G2RcdXLO7j6WugCegvvuWGvISSJMAqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327013;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=yX02VM28Gy461tX2XBeizIzwB2YYQs8XerdPIQYHiQw=;
	b=obZ8v+ibwd64i4XcNgTk+xHhdvS+hlINY5I+5nuzGUwwfQnp/fwVC9NOZsqLeZsafj/H
	 Je7KEe1Mwo0lcdZHtn0/tF8gO9NFLkpQK1B09E5T4A+3M54GBHuZEXaM8GAaMDIJjCHHm
	 fYf9PFyOvitAWUlxRnOsYDF+fvogwdA4OpBYqZS5lamaE7HnLMmerq2shOijopJ6+cAcw
	 YgghEDvuC0vcFg3lQ4Q5HgJKU3k/1sVLN5sjvVMEsXMdjqpdDtxhdQqumS8T7vVX/4Ckz
	 LqEbLkpnVHyd+3ydap+a5DWVi7xFvZiZPOLyeRO9M6FbVxn+DaPNMRmKyFgmKNx+pzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Llczy6L0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A57B60A2604;
	Tue, 10 Nov 2026 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Llczy6L0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54F11F008A5;
	Tue, 10 Nov 2026 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327012;
	bh=yX02VM28Gy461tX2XBeizIzwB2YYQs8XerdPIQYHiQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Llczy6L0qA9pqdSQStYP+I7+Ko/Ho1LsrH0vRlZqbNsxuRXVzlr7UdX8RfRQHqyhq
	 wh+mwIakgdBfGRA2mBhNuwPOLs548IrzAUYm41HeUhcbjcgAQQ9bbxC14AgTHzpHZg
	 DnE9KmtNiEQRb/lxe0gMq2l1lBRJiTi0ZfKfhVKWytEStEy643hzqnbnwBnY20eZoC
	 huFQP0JchTYG/vFNIBHCP/S1dtWsp+i0hqHL+Ka85/B2XMiPPvKvCW1xlTUVc2TmTP
	 0Cr0kvjXW/RylUToRcT1pJfGjTxMDw4VIBmU5xtldR9r77KUZUV4FQ7ZejbJVv+06s
	 u64n0Vm0dMlAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B0B039D267B;
	Tue, 10 Nov 2026 16:10:12 +0000 (UTC)
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
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Protect the receive reject-list
 lookup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179432701117.4062787.3195406436831502878.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 16:10:11 +0000
References: 
 <pm-bluetooth-objects-candidate-0157-v8-a3b1b1bb30aa6b263b32@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0157-v8-a3b1b1bb30aa6b263b32@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 25 Oct 2026 00:35:21 +0800 you wrote:
> Reject-list entries must remain alive throughout a lookup. Management
> updates the list under hdev->lock, but l2cap_recv_frame() traverses it
> under conn->lock after l2cap_recv_acldata() has released hdev->lock.
> 
> An established LE connection can still receive ACL data after its peer
> has been added to the reject list. If a management socket unblocks that
> peer during the receive-side lookup, the following ordering is possible:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: L2CAP: Protect the receive reject-list lookup
    https://git.kernel.org/bluetooth/bluetooth-next/c/df33621e7036

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


