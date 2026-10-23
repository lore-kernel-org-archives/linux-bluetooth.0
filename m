Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792793411;
	b=TlIJWHSWVbZuSbInfTVNr9S1OPmQcSzEZzEy5M6IR/flpzM9FMvmAnwYPcit6H2V5r8z
	 FX+qsKHTjVMvIIRo809+TrmhE1IppKA/MT+nzaDQge9BidZI6NR7+t8tjt+DmQdE2IDhS
	 0H7D1Wk4JVUjljqbhvP0Bsh4z0Tkb7irXjH2tOIN28IX5HK9EukvpCqK0K62FSfmxABoG
	 2S1YPPcVPuQKzo4mEQdFKWKtkX+Nupdh/DlhNSFuf22WBh0h5DxZkU/uYW9a7im8FfcCL
	 Sj6WCPBLG9c77JuVsbuK2xnpgZ3Ql/iVIKzo/oQPXa7fKYrVpJU6A0ChuibRf5ui7eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792793411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=6CMiduJ/Wqxtfpz+RWzxC2OkgUKs0OUfnEyG4nC4Y2k=;
	b=bKc3R3o9mRgh26gBqeLvAPraPnHvyFvM77pxyBz3hYjUUVgCl9V1iuhawGszpMJPUu1n
	 mnXdFz/zLQaJhKQtQsAs7py1x/PhAkoQtIuv+Jjc8Tv02BOMF6cYvzNzD7dualZs/ylbG
	 QPVGMd5GTKv/mdgMq8RgFzTWHX/gOvS9404gdFqU6WeYUfqA99UDTM8ZBxOgq8hSv8Uxv
	 Yx16osaQnYXjBgsIHntXBdwhjwaGFVFyVkU+/hAwmQfylOYHzsHw/H58QAAumNVFlhFRU
	 Ol/fp/Vx94mwNY0psMxnbnL+0e+d8c1REcc9lcKb4EQj0cnIjyO4yz8RW52JtBFnBlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i70zcWxY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EAA606A323;
	Fri, 23 Oct 2026 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i70zcWxY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDA81F01825;
	Fri, 23 Oct 2026 22:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792793411;
	bh=6CMiduJ/Wqxtfpz+RWzxC2OkgUKs0OUfnEyG4nC4Y2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=i70zcWxY40Nu29RkiYIsiQeAOjWK9UKiFoUz6RgQuKpBUvloFDCicdmOlHpk/XXFb
	 MWw8L1VrsooED3CPREfKtrVpqdzoPq27DScqg58UWhq2UJ9nwY4iUItumk6FllqDKZ
	 Zo3ILEl6w+ndq/ih8s9hx/vEbYnx9uC1ZjPWtUzSD+7vgVPPlwdwyeTB1/RXQblKP9
	 oFAG+kwUoKpKY1Q/idsjGXOtWs23K1fXO8j+NkW83niGv07LYGZuguxFDzZSaWqrfS
	 Gwa0JalCuURoehTxN/sDn5FbQdaVtZFp2I/lZVOQDYPAd4hDnoF+Hb1Aknh1F8pbWe
	 tCrVemOJuZIrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 04C59391B158;
	Fri, 23 Oct 2026 22:10:11 +0000 (UTC)
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
Subject: Re: [PATCH bluetooth] Bluetooth: qca: Fix the WCN3950 NVM baud rate
 offset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179279340956.1294506.15428171878126640467.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 22:10:09 +0000
References: <20261021195112.41138-1-me@michaelmcallister.org>
In-Reply-To: <20261021195112.41138-1-me@michaelmcallister.org>
To: Michael McAllister <me@michaelmcallister.org>
Cc: linux-bluetooth@vger.kernel.org, brgl@kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, lumag@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Oct 2026 20:51:12 +0100 you wrote:
> WCN3950 uses the HCI transport tag layout that stores the UART baud rate
> at byte 1, like WCN3991. However, QCA_WCN3950 precedes QCA_WCN3991 in
> qca_btsoc_type, so qca_tlv_check_data() writes the baud rate to byte 2
> instead.
> 
> On a Motorola Moto G10 with WCN3950 and cmnv12.bin, configuring a 3 Mbps
> UART therefore leaves the NVM baud rate at its default 3.2 Mbps and
> overwrites the following byte. Firmware download completes, but the
> subsequent HCI_RESET times out and Bluetooth initialization fails.
> 
> [...]

Here is the summary with links:
  - Bluetooth: qca: Fix the WCN3950 NVM baud rate offset
    https://git.kernel.org/bluetooth/bluetooth-next/c/24a4c2f1f7ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


