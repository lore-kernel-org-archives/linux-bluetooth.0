Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505808;
	b=ZqLQUltPVuY88mcgX3KEF5dzozPdppoU81gyMDUGEGBE0UawdWW74ZzNLSt2puu8qBZm
	 iH1QZP96YHmd6Yth3o7t5FUZm8aFETiLRgI1fcWQgODw8YnPNXaTZVLe9a39+FlOOZ2dx
	 tadVvqDFU/AiD7a8Ue6eHoYtfLJ7f4rYR04K3333Q8AIyLZ8xeuYDn1bM87Oig01ih+w5
	 oXiwYdyAg1VOAVi6nOoirb8C6u+euJsD07Psgprf2NWu1bOoNL9bFXPguLg2O+jvznmBN
	 qoix0b0hBvUMRP+viyxVQAqfpF8X1KJlr2oHS8qH302oDg5xsFwaeAFqV3uicUho9fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=mCLWbWSfmz7oe3xjpMCycZnt3k/d8hkqtETv8IkAh5o=;
	b=g911cJKLLGX+Rfilk/PE7xdEIE4HjNF77TJ/YT5MFP4NOrSQi00ieCNspLIBfbAYr4FP
	 ZHJvuS8LbvJLV1U6U8mBeFPRb6KrREhX9Sw5wkhIYWu8XIYzCBxMPTrt/J5L3FvnhekND
	 A1cIkgFod996thmtQRqZdXb+GSyHnRifNmmtnxWYglIwoxeLBJF2HYAHIkQK/Y5jxygzK
	 GH1chOkUlCFHD8HVD84ONj5jL7z2BoD7Xv31Ox6597VlqwYm13+f0T9VN348yJeupD/+f
	 Ms0+MnW+E0CYoJbo3m5VIBAfeaxS15pZN9G1DsbPdMcf8K0IFUcVK9dxWjbCZQ6y0Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVBnscxj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698AA606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVBnscxj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458951F000C4;
	Thu, 12 Nov 2026 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505808;
	bh=mCLWbWSfmz7oe3xjpMCycZnt3k/d8hkqtETv8IkAh5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lVBnscxjkDzBlmsGsMQCazmKFODgjz7O0BBBEhfe8J6dQIwkre+B1MqgPomYBbMqo
	 tX/LxMsV/iwXSWWWagrdDA/JQpDlNXJSkgeOVQfvs9j4Qw+pgF6Rzq36jOHxbfd7vl
	 fUo0TmB0eR1uQFCBr1mRIPMUrACt9BJhor0ZX1jfWOxZ4D6OIYLjjGnZNuDhzITQlp
	 oX2UdGRP6XvxpRebwbCU2v3fHHp1sn5UQTPtkQdthyFBcCx9rxGdAKkPGMHaFq5GpR
	 Mf5eBmUOT/uXD8POB2dkw4BOS+W3Wom7BAts8cYtg+vt0fHct/EjTLZFEoULpPRFaZ
	 9brRWl825BRzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3A9380AA78;
	Thu, 12 Nov 2026 17:50:08 +0000 (UTC)
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
Subject: Re: [PATCH v2 0/3] shared/gatt-client: Track internal discovery reads
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179450580703.563116.10409527926595397710.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 17:50:07 +0000
References: <cover.1794432472.git.cochcoder@proton.me>
In-Reply-To: <cover.1794432472.git.cochcoder@proton.me>
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 21:42:55 +0000 you wrote:
> Track Server Features and discovery Database Hash reads in pending_requests
> so client cancellation releases them before the client is freed.
> 
> Patch 1 adds shared request support. Patches 2 and 3 fix each read with
> separate native ATT tests. Both depend only on patch 1; either fix and its
> tests can be reverted independently.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] shared/gatt-client: Support pending GATT helper requests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4be786143db8
  - [v2,2/3] shared/gatt-client: Track pending Server Features reads
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2e6bb945d6fa
  - [v2,3/3] shared/gatt-client: Track pending discovery Database Hash reads
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


