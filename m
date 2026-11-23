Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461017;
	b=KuQANFZFCvf/4g4EHtPAhXx7S8QPU1M0uxtZxqIR2DNv0cb9k7k+fL9wwPHg6Mzu+YDM
	 Of0ZIP7pl9MpdXD1RoJWLWt7rvDJhqgNm36nSdygJCFHKEImkN2Wir+Xz20roU64veWXH
	 Lqq32D/wmA7xZJsXFR958CsAo39E6tv9EpKlAJJk7q09/k7wle7c9oWTqFrnAmP162kHn
	 Xtqh4vMAS5WC0Ng1MkEeJG9MM5f6CNp34s0FRbgd/oBH14BXXQjjR/+Cu5rkqmMFaIzu7
	 3kKg4RpsKyx4jfsKxIt377+UM8VA+X0QUDzUpBLVQIVMRg9++aA7DppNMCEuY1gh2OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461017;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=lqs4DcUJtsag2ueNo6Q8qB9T/5UB8el5sadrbTARVW8=;
	b=bGxu4bzTQMoXXT9QLy7yoLWARtuFDSQrqIUYlP85ZmnG5FVVV7NGlKvDtjvYU0mgz0JO
	 tT1nkon3c6vHkCqsnQjLdZNaHooyyLHGl6AJ89rvF43Sx9FE+52OmjBzcG0maXqNdGGhk
	 2vRvgpGs76s+hvf58e9a/BkqY56MmzftMyVCBpMnEWy9QtJ4WkTXBeaNqvydwdoo+YJbz
	 EXGO6YILH4VLK75bUlNDkUJYkkLOrbwV5eIXt8GTYYABG94bGyi4LCZKBjRBX9SwnK+hk
	 pEFGm9rTlQMWD15aiMDL9TvSi6+YepHLy7bldQ2Dvo2utTQKPxkbm6h4SWbqHmo28ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+LTbgCi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1029D606A33D
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+LTbgCi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA171F000E0;
	Mon, 23 Nov 2026 19:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461016;
	bh=lqs4DcUJtsag2ueNo6Q8qB9T/5UB8el5sadrbTARVW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F+LTbgCixti/ZhKSOWNkjhwaoBIgTSIoFidGAL5hZLVVeTuAp7UzcBqq6+LGALys3
	 Aa0ydqDMB/V1/B1iTLAn775cuDPUzXDgAdjXm6ROckc3P5vcHWLphhdMPZ69IYLgBB
	 dnwcBUpJ9VLSLNZRP5KHOcopAlV/u7f4217ydeRxKSrs+eD5GDzaJNSNkhUQ2tT1eZ
	 tDRt/Ukewki9fjRCpT/7OhIWCdrTkCzHexPRg3TIcIsbUftx6mTt1qhpjjOQbdGA3z
	 aj2J+EAojGt/VMw6nEsx2A+gog09GHj9oOcez5hCjZ2r5BcUJc/QZYxEsAQDERfeJk
	 unjXgswTa/emQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B438A392EE35;
	Mon, 23 Nov 2026 19:10:16 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: hci_event: Don't report a cancelled PA sync as
 failed
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546101526.3063022.16275260322304330469.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:10:15 +0000
References: <20261122201519.2859075-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261122201519.2859075-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Nov 2026 21:15:18 +0100 you wrote:
> When HCI_LE_Periodic_Advertising_Sync_Established is not received in
> time, hci_le_pa_create_sync() cancels the request and returns
> -ETIMEDOUT, which create_pa_complete() reports to the ISO layer.
> 
> The controller then generates the event with status Operation Cancelled
> by Host, after the command complete of the cancel, so it may be handled
> only after create_pa_complete() has cleared HCI_CONN_CREATE_PA_SYNC and
> the next queued hci_le_pa_create_sync() has set it in the connection of
> another request. hci_le_pa_sync_established_evt() then takes the stale
> event for that request and clears its flag, so the event the controller
> generates for that request finds no connection and is dropped.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_event: Don't report a cancelled PA sync as failed
    https://git.kernel.org/bluetooth/bluetooth-next/c/a9e7a232ef4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


