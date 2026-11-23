Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462812;
	b=NdvhIY1tsWVkAMJ88dlM7UKaR4NiikU1eTMGV4ejvRGZywcw7H6ptuyIIRCqL4U42ImD
	 u6RbtflFaa/i16quhInYNl5hK0Q7JhTZJo9cJ7Mi1sdfJdH6hHx01XFKprk8k29Bg9Cg2
	 Zlhsy1Y+ulDChrYpdayvRdVhB1Ru7ufC3DvfjPSI7EfKjS5P3rBRrHqRUfXJ4RDnbw6dt
	 US785QugvQj2qfXuSpriSgagBpG43aG7fnKbH8RSNZRytTfoMSIR4Z/Myegbl/zhgC0p9
	 h+lMKAH7Unmx5xZx3AM7pnm/ur3m++p/mRIM4pD25P0NamU3kMvSw7s9pHS4dSxgqNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462812;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=AFBoJzQQ4+aNW+F2g6PdB2mjnLlLQvHcVLCNKGs5k4U=;
	b=VJchGFJ5zNc+JXAQ1wfXtH4tqaIu1ZgbMC2zOWpAkCLR8KortVeCLj7FR2To8vwfEool
	 RPzuR8pHy23Fvy+LHSCkJ3XgjLam3PsvHpEtPa8o8KTWbBpqR2HUfrGbgzD28G+rjBjaW
	 yMB3+Lycw3rbggMcGCDxbh2h+iDma2I6bBqEpfjPeGQyaVou/5klb6K3a4PWe81cxDdT3
	 FvVV2MKfyk2xjF3m6uIz+hM5s2PFyFQFOZQKInertzJnOQRVw2OG2ZiDDLHUnGq3gN5tY
	 24hfFiGzHTo+6KdF9JMPp6u4hrxCmB2SyVRxC739cKTUXHnFdLUyprftUwlX/JiP80g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzxatAwm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BF4606A681;
	Mon, 23 Nov 2026 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzxatAwm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C083F1F00AD4;
	Mon, 23 Nov 2026 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462811;
	bh=AFBoJzQQ4+aNW+F2g6PdB2mjnLlLQvHcVLCNKGs5k4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OzxatAwmvVCC09YTX3UL5HSzv9KyzUAcr6SqY9F9XfNFFbh+99kPY6Dc1P9ktjLpo
	 elUudpZKad9403hBrN6hz6f2zqQetPzlqJBblAFp8azf+VuRLUwwdLBfjzaAz2fRN+
	 4NPBWIx6rCpzycLPqF7oStS66FXzrV9rXZdb9kIPQIn3sC56cxPDkjexENgnKVn3QH
	 prDH1sCbipxH251p/14gZa7zVIyvMmb6lQ8sAuOr7PQ0FrJCANoxvhASOdg+lCzm/F
	 d4e9oznOf8if+gJk8PmNs5BNOzLAT4xy69+LSy2uO7X4w2Y3ydK1gRQw+TGFkH4dXJ
	 3tAqmsQBoqwKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44E9392EE3B;
	Mon, 23 Nov 2026 19:40:11 +0000 (UTC)
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
Subject: Re: [PATCH v2] Bluetooth: btbcm: Add entries for BCM4364B3 UART
 Bluetooth
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546281026.3078240.5509562284219485596.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:40:10 +0000
References: <20261122165132.14015-1-jperlow@gmail.com>
In-Reply-To: <20261122165132.14015-1-jperlow@gmail.com>
To: Jason Perlow <jperlow@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Nov 2026 11:51:32 -0500 you wrote:
> The BCM4364B3 combo chip on Apple T2 Macs, e.g. the MacBookPro16,1, has a
> UART Bluetooth controller that reports LMP subversion 0x3032 (001.016.050)
> on some units and 0x305b (001.016.091) on others.  Neither has an entry in
> bcm_uart_subver_table, so the controller is logged without a name:
> 
>   Bluetooth: hci0: BCM4364B3 Trinidad Olympic GEN (MFG)
>   Bluetooth: hci0: BCM (001.016.091) build 0115
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btbcm: Add entries for BCM4364B3 UART Bluetooth
    https://git.kernel.org/bluetooth/bluetooth-next/c/fe88794c9e0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


