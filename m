Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540812;
	b=0pYA/MtJqclqbBJWjj/cG+x19u/4QuBYAthAjSh0F/+DIJ87GbSoz9Hz+jdfD8WKPRx5
	 F9KxAJpp+yk4BztkzamYxICYTDVuIWqJjAVhkpuvyeR/S0MPxLXjklDSN2uPTAPz2Euik
	 kSmS7/lbXAuWNstfZsxPqxsJphht/UC0IUl+K5UEYE7vkSZrnSs3XwMKJb/NXCME+TfEz
	 lCYrsjW0euTNhXCbG3gsTTuqrPKUupZYuJ/m60JrHc32H1EOO9vY1pzeX12eMhmaAeGLB
	 8g6+JjQLXeQ/wQYlSQb8tJ03U3bG9YeejmS+rCakCq0KMXTO5zwOdM9cq+g4poY4PJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540812;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=mhofnMvMs61LnuuAmJGVCgHpQ+Fyvba5KoJcl6Qm9o0=;
	b=it6kiBZADr+ef/EvtB26/HuuC1YTED6eKLPKvSDEC2/NH/6Yey5YKT0TGuj1zBW2P6KV
	 aYtxXQQaYhRcFvi5ntP3YlBoVlcqxeDlycbyeT/VPELtznT03HgDEUOWmc7GlSyd7NnAD
	 OrNh59PuMQLdJHmFJt7wcHYxO9M6DWjMJ2LDmeQ5K6Ak3SfJbGWSXGT0n6zk4dgnwE0rx
	 juiXZTSl1DwV08cL939kVmlROwN6XhCVHV5KlX0AzVrS097Qs2IjnshYqfS+X1+iGCn9a
	 lidZOfCPM7VFrxzuc46wQhwbQ6kftxnwJCyuXZ6GTR7dH0KZm2HVoSH4FU7i/VY6PsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FRyijJ/K";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF01606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FRyijJ/K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC061F000CA;
	Tue, 24 Nov 2026 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540812;
	bh=mhofnMvMs61LnuuAmJGVCgHpQ+Fyvba5KoJcl6Qm9o0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FRyijJ/KgV9lAeJZb8ld/IilgDyxOEQ1XhwvNs7PKC+ylyCyEV9BP1fznM0gcm2pp
	 BPIvReovJSE7fou0uF1QfMINxuFcLDW6qM5eTQCaP0B7lJKnvkbKz9pVdgHCD177k0
	 Egpht/hAmzIhg5dd7g/M3zkEMOJ34lLL1Naf/6IT28bZ5zIDM0fnKydVzUKL81s95+
	 U86cHOpiRK94wG4bOwazyMsshA8h+hgKrd3Pmyq+1CgZdDJGLMTyPl5Xajx+Gs9sF2
	 Knst3o1eoZRxbhbcB1Q77Mgty4n9AletgMmdE1Zxqv8dX92gjBSuQtgTs6yhOUYI0R
	 xWvXn1ZXBsDkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15443938FA7;
	Tue, 24 Nov 2026 17:20:11 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: hci_event: Terminate a PA sync nobody accepts
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179554081051.3669449.8260616423896629775.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 17:20:10 +0000
References: <20261124150851.338673-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261124150851.338673-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Nov 2026 16:08:51 +0100 you wrote:
> The accept mask of hci_le_pa_sync_established_evt() starts from
> hdev->link_mode, which has HCI_LM_ACCEPT set by default, so a PA sync no
> ISO socket accepted is never terminated. This happens when the listening
> socket closes while the sync is pending. Every later sync to that source
> then fails until it stops advertising:
> 
>     < LE Periodic Advertising Create Sync  50:1E:2D:A1:5F:1C
>       (listening socket closed)
>     > LE Periodic Advertising Sync Established  Status: Success
>       (no LE Periodic Advertising Terminate Sync)
>     < LE Periodic Advertising Create Sync  50:1E:2D:A1:5F:1C
>     > Command Status  ACL Connection Already Exists (0x0b)
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_event: Terminate a PA sync nobody accepts
    https://git.kernel.org/bluetooth/bluetooth-next/c/4d4a9dd600df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


