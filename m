Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42285375F7B;
	Fri,  8 May 2026 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266857; cv=none; b=stL5YNwH11AHz0ou+U43Xgi6V0iMqXpPAqdqJ/39SreMgRb6ArI8yUvcFZqrS2vqBuG5DUm+uVX/FHUcq0JPeyfQwOz7T1Ij99VjDoSFpln9whTWyWe/kPzYASzprtxVnrXdS5P4Enx8XwY5ZQL0V01+eBoXJ/xmo7eRHmKIgZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266857; c=relaxed/simple;
	bh=7s642tMqiyWXhfKHgVpSsbGdfbOsyP68cMDRBDMd5Po=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FJ7+IiTE7SnK4w5NXeyVvJRy10zvwoQte9O7vu0npV6tiWBjvCBYzgFICqD4f0yHS+kNphjimH2B+0mOf/flZ6TurlbAGdZFOjVxAiBlu8dHE22+wox40N99nzO7GbTH+dEUstNgYxmPNQsR9ex9lbxI2LpcDHi7rQSKoLtma6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqLZyNzz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqLZyNzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B2BC2BCF6;
	Fri,  8 May 2026 19:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778266856;
	bh=7s642tMqiyWXhfKHgVpSsbGdfbOsyP68cMDRBDMd5Po=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LqLZyNzzpY8bvIdKyylgj97nBUbny232Xb4z+N3NhlbWKPGc4biJclQgqp7dyeYL7
	 vJp1xP/i1aNS7hZb/CylEw5xaMEdD375MEi8BwFKmLG2KNmFTS+Ofa5jzs9uF9fea9
	 kuhiXqLYNNdyrlfZPAky3eFo+DFg86KgXLPbuT0tc+vtRwpG0yp3qVZQH3u21OzQu5
	 Ia7I3eb5GyzLYYT1jnxHypBMsRkdomgkyRU508vJAGgQyWTQ9L8E35IDav9LfNFaXY
	 dlgNDSRIbJUxwsHoLfJO0E06Jy/+j6ANVSL/Z8qQchMyYg7tpD0sSgmsPtLaeK9MWm
	 TQ9KbkLHStXHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDA4381197C;
	Fri,  8 May 2026 19:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: serialize accept_q access
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177826680530.808173.13571641785763854234.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 19:00:05 +0000
References: <20260506114338.2873496-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260506114338.2873496-1-n05ec@lzu.edu.cn>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jannh@google.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, wangjiexun2025@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  6 May 2026 19:43:30 +0800 you wrote:
> From: Jiexun Wang <wangjiexun2025@gmail.com>
> 
> bt_sock_poll() walks the accept queue without synchronization, while
> child teardown can unlink the same socket and drop its last reference.
> The unsynchronized accept queue walk has existed since the initial
> Bluetooth import.
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: serialize accept_q access
    https://git.kernel.org/bluetooth/bluetooth-next/c/303bd23ee2e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


