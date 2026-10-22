Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684204;
	b=oyZRRgElFQKn2bQ510Ji5gm9CLLiclTDxH9oAjHvL/xE9LgfTGtgHHftLwYBSI2a8wGx
	 2ftBOGQiDlq6IVQCkZ53rWDnKAVscxQDImsc8puOS25O54e8Vut8dp3GLPMA1R5d8xZUT
	 9Ovqh+guyrKgOx+kIUbxevEsRw+sgtv6eUfUIR80EX9/+1TGfu09vihg5BuxAy+owfsO6
	 NGgBX6oi0yNuif4xK/qV3f18F2n/iVysV/GbUrnz0grq+SaLbWQa+8fWJYHCoDsDv6khH
	 I8IAXAp/q4/B1AAK3Vs8LwW/ApJJR9ePuYsOP1gO3KDCrl9dsHHTmrujJJcVxxw0IwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684204;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=YMFZPVLOjolHkjO7a//48t6ctbhnzielB51AcrhMs3A=;
	b=BUuQASzeQfLmnmzD5vrrcmFTdDHVJHrFF+WnYNZPETtUM3c48lgwJ5vN9NXKXTTokiJv
	 1gtrdLAQtwLPAlNYI/1zayL8zAT02zfW6NQpmFFA+3PFUvk5EKuAk5BknOdTB4w1R51FY
	 RkH/EY+0QrRwbuLZviVF7n8dGT5xyddD3oTQRRPYxyOQmPMlWFdRsjXk2nnXR78+b5jFT
	 Ag1Yd++KsNhAs9e5hTvvPP2HzeNF3eEBzoS0l1wIvCVlVgmHX4LkzJbkKo3N3yPOTackD
	 xM/EgG+9cecYDO5E3Xq1g9nb6X5ySFY4jGOQLxVsQtJpPXWPvKkt94PL7BZgqjnFMEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jATCGwh0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77655606A319;
	Thu, 22 Oct 2026 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jATCGwh0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAA11F031E0;
	Thu, 22 Oct 2026 15:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792684204;
	bh=YMFZPVLOjolHkjO7a//48t6ctbhnzielB51AcrhMs3A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jATCGwh0pvbFj70npzC8KQgDH1BKkIBOzIpJ8LqU486bMWcPiEa1lRfE0pgw5F5oR
	 0Gpld2KJlkW5sFmj5SkAzYwsLeTc3i442Awn0fGXS8+1rPDbrsXEj+08DNsyHt6nZ6
	 lLNnOXm3jtMRkQZooDY8uYTUb/QFfw5/Tkun6Wc1Qt6Y6QblQqCQTPOv+jQ6TvAVSX
	 VgUhHRCshcjzSek5T6HA9pdcmo8Z7QJgAGPvwY4u76XncF9dw2N33tGoud57R9kz17
	 ulh+Q1DydYgQLJ6JkUbmlJejGSRHz8W2tMQ2NvMhJLF918hqxOvXCdePKhdIsu1pyT
	 0z/2WES84UYKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 074603808222;
	Thu, 22 Oct 2026 15:50:04 +0000 (UTC)
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
Subject: Re: [PATCH net-next] Bluetooth: btusb: disable by default Qualcomm
 multi-subsystem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179268420358.16170.5584192397287704019.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 15:50:03 +0000
References: 
 <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
In-Reply-To: 
 <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 22 Oct 2026 17:38:06 +0200 you wrote:
> New knobs should default to 'n'. The mentioned one depends on
> BT_HCIBTUSB, but the latter is enabled on most systems.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> this is a last minute fixlet to avoid breaking expectation for the
> upcoming net-next PR. I'll merge it in a matter of minutes unless
> someone scream very loudly very soon!
> 
> [...]

Here is the summary with links:
  - [net-next] Bluetooth: btusb: disable by default Qualcomm multi-subsystem
    https://git.kernel.org/netdev/net-next/c/1a2c35c49cc7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


