Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540811;
	b=jtM9SJOLiU36gXkMxTkNQ+gIqGrNI+z6KCLwSs6IIp8whlZpWRp/Ua5hB8pMQWSBYhQ1
	 yV1jHOEqudraF79jobHh0UXOsUS/AgrBltmNoFwvUcBr7BpTrJuhHM9vi9wWO+k4nB6y3
	 jdFChRYAfGlBJj8t2FfRq/ArzRGdHEr0sCuxQRYqtCemSDwZ+i17HEbZrTdwB+p84h+eV
	 GwTLxWTPZpbwla7s7H3TeWCTeftCWq0m6lrFUxuwJPKlIkR8j3Yb1feLyfkGLVwQosMIY
	 gO7rzEjBDTeXGEMNsmItAX5dqjJI1jbYs5M3lRT9w7NtJEv8WT0ZtAfoGNUMdLqKdNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540811;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=71QyIFrv30XeX0Q1nPuS/OAonwDswRKIl5VAYgZCAtU=;
	b=IX1PXUS17gLnIcfeAj/QH2bGHq5b2NvuOqIDs3Nw8SrV9WeswiQelF64d91W8us93UsL
	 bgyLbPzE51MqeptOr0XHENAxh+loPvnCcJ3APjWYXEz9fmkswdP1OW2qAjm+OXK6viGqL
	 iExC3PArO8r5dVNdcx3UAmlu8wm1/lFrKiZIpZoQiC+t5OZHl0lLbq3pW0xaihv6SXZRi
	 qb15FTtD4cg9Dpc0ml7hg7p1yjhBt29Nhk3e2JoyWe+cilKcHPYiTx4YlMIOssTiyW9IG
	 B9g3iCRLK16WUlqon2Yia38zjoiARvMH0NDnbpLPBu/L49VVGVuN8X0avCinAfe54eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJARhgTj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F2606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJARhgTj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C891F000C6;
	Tue, 24 Nov 2026 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540810;
	bh=71QyIFrv30XeX0Q1nPuS/OAonwDswRKIl5VAYgZCAtU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WJARhgTj4EWRKx5w32zNSlZCURHGKI1czasix2cT/Ez9A4bSuJDaSU6injXTKlPhB
	 GyAq2U4NAPR49n0Vd5O+/3xqDRKStM5SdFoO70mIMrwP6lDh/MhKih/e/YcXGTM6oL
	 evESKpCOuxIFwm+Xwk+zlwFo3tO5bVzuIOwRtLp3zD1iL4C9qY2LgHJCia22x4TWaP
	 Xgj3BpH2XdwVpKUvXbt5+owx5ui7e/pbuXlAJQ56lZuj9zX8I+S4ATIhMLagQZc8XC
	 EoqF+mV+mTKNrh3ShP9MjCZIv4vhKt8eRPNYsw49Xp/302Pik0aq17aYoNGSYcj/fn
	 VoYMIPtjxcovg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7739E3938FA7;
	Tue, 24 Nov 2026 17:20:10 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: hci_event: Don't keep the handle of a failed
 PA
 sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179554080901.3669449.3906824046778217245.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 17:20:09 +0000
References: <20261124150728.332222-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261124150728.332222-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Nov 2026 16:07:28 +0100 you wrote:
> A failed LE Periodic Advertising Sync Established still stores its invalid
> handle, and the controller gives the same value to the next sync. The
> lookup by handle finds the failed connection first, so the PA reports of
> the next broadcaster go to it and bluetoothd never lists that broadcaster
> (btmon, shortened, on a 6.18.2 based vendor kernel):
> 
>     PA Sync Established: Connection Failed to be Established (0x3e)
>         Sync handle: 0, Advertiser address: 50:1E:2D:00:42:2D
>     PA Sync Established: Success
>         Sync handle: 0, Advertiser address: 50:1E:2D:A1:5F:1C
>     MGMT Device Connected: 50:1E:2D:00:42:2D
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_event: Don't keep the handle of a failed PA sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/3bd17f726f20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


