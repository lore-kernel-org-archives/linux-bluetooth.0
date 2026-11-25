Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626608;
	b=RmRFpexYcVbSUYxEaHCvFlVBn21gL7tZJ/ZWkikXKu0JwSWyqPz9xWJloaXwoe0vBBka
	 eJWrLM6cmuMUjLd2uEA0tZM5xaY+G83zdlvK4mE1xNoda6JaVQocNKT5H8lCG1yL82UFL
	 qbrPSoao+QDcMMtb8ilsr3LAS27fVS2Z1n7qn/VpIQwg8B1InD05RO8eOSyjKh3FlWKnr
	 4/ZjV8xdGDVuJUFQ1j8PXW6HxKmXhXIsw7uYsiYhtN+wZD7t90fx1yfFDz70uXZgWRfue
	 3pl72kd+09fZlFgWs+vipC7lWUx0rYFR2ZChpsMy9bT84lTlW8Ix2M+ud5zBSCrVnUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=7iDKVKuKwBohv4y9lKH75gZLVDpOF3jw5yJt9YosAzw=;
	b=nxahwPDV91sZjWfJQZCkafkaOqT2xbGwQJMT7pRqUQjBvJLrCl99F61nsgvpnk6JLS+c
	 GB96WBNWZTYut71aP2FFmuXbO8/VhYC1E5OfoBDksN5LzyM+sCocR28OvXQ3aCeYyb9cX
	 kv6GdlRuLYW93e4KagjGaN7e8niKKzl7WEEDijFowTNbSQXs5rw+QTGrQLmxlnWd7oei0
	 5EC48QKILL0ezBMJyfkYfK+PiZB97btmSyXxOOoxlU8oQx2lsmSx+QdZSwsfjhu4QQ0b8
	 Zt5y+3fwRGciYDCaGCZn1NfxGkWj6TJFlHbamCfdFiU8DMd/nr+YAapO8aZC9Rxb4PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N8YF/rlq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F05E606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8YF/rlq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4345C1F000C4;
	Wed, 25 Nov 2026 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626608;
	bh=7iDKVKuKwBohv4y9lKH75gZLVDpOF3jw5yJt9YosAzw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N8YF/rlqxnNQpQRXipT2FyRcEhqqUEK2msOwjgg1o3rEgmAq6DnxCz9O1kL34z2IL
	 /gLI1U32gwC678+TuepCDUpWUF8vkqsmnRV4eaGi3Y5xQxGh/W4d49eb2iArbppKBD
	 MTnZs/ei2uxRBn6HsPcKCq1yR8nLQPOVCzvHmbG+peiYjd6vPTdG0sVqax4vFlOVqr
	 pWu9cMmwgT3m15Q1CcUKM/B1Y4MLg3Pw3YAtKgTrvSpK2VyJpjwgMw+tQhyMn66OX4
	 MDlGmuxmsI2Tgw6ttIXhVeMZTqiNejTzq7J+0Lk6v1nKyn/FJ5/WW4K0SxkJQGntQB
	 ntBuB/zsNc8Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3E0380821E;
	Wed, 25 Nov 2026 17:10:08 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ 1/3] shared/vcp: Notify Volume State on Mute
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179562660705.1207837.13801506021223915525.git-patchwork-notify@kernel.org>
Date: Wed, 25 Nov 2026 17:10:07 +0000
References: <20261124143601.245340-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261124143601.245340-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Nov 2026 15:35:59 +0100 you wrote:
> A Mute operation on the Volume Control Point sets Mute and increments
> Change_Counter, but unlike every other operation it does not notify
> Volume State. A client that keeps Change_Counter from the notifications
> then writes its next operation with a stale value and gets Invalid
> Change Counter.
> 
> Fixes: b8a113ecbabc ("shared/vcp: Add initial code for handling VCP")
> Assisted-by: Claude:claude-opus-5-5
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] shared/vcp: Notify Volume State on Mute
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7f8bdd8ec535
  - [BlueZ,2/3] shared/vcp: Keep Change_Counter on operations that change nothing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a270559b0012
  - [BlueZ,3/3] unit/test-vcp: Add tests for Volume State changes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eb36d50744e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


