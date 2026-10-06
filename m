Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0543494816
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298822; cv=none; b=CSn77sKYf62k9fCRovkNIJcFvURL3r/OjBCojXoE54CudLHNE5FxZ1rOzzcawdal6ARtSlqZdRiCkA2P0xV9o1QLomRIecL1wdeFkleAjxCNsjVbnogJXye+eg2Z74khuBat7xRb71rRbQU5/vEfoBifsI4FVe1n3+sBWhGvBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298822; c=relaxed/simple;
	bh=+T8k7tltQQyqkFxTBrjYKZQU834nLXIl0MSu3+XcLcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XxpIVecjkq4rEKyhRzvq7QlQ0bOmNW25fRne42Ma8B5W0TUMkhrBfQAeHf19Yz2EjtT6tE5Ra/Fktzv4PXHpCJwIjC9mafitSvU6fjfz61r+Acdiqk3c16cjuFBXV7QonoZwpRAWPtmzLCRnubMgZF3Z6NNYpM+WgTeIPFxOY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7RJaW9v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7RJaW9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AB31F0089B;
	Tue,  6 Oct 2026 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791298821;
	bh=GcvwLm0aS35B6ZvRcZxIriniXmefhI1IBu/uQlI+7bc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=U7RJaW9vsFUBWo8W77JCwHCxL86sM49pUL6oBtQ/rH4+/HgVyCj9++LICEyNyg27q
	 ES5QOuQlEhUywaJA3DhABGh2hjOi3o9qTGxa5G++3XDXFzERXpRI0TT+mG7ByK6+XZ
	 xj34XXD0d941S5pqETe24DoulbvZAUhPFXS+VCW5YJEiAUwkVaqJ2ISBjBz0oCFwYK
	 OHpYFihLWbOUFx3VzQfLybyU26IsBZQBLIGAkP10yFTN+dazSjb45Z1sJXl4BDgMs/
	 Vm15oXOjTrE2QmvIpyMLaAD4jMXwq305Ga2WwVZqeWXtrITnf4vzZDPRpXtY65l44C
	 srkiGZULQ07TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A21F39D5FF4;
	Tue,  6 Oct 2026 15:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: hci_sync: fix mesh adv timeout units
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179129881986.2665799.5801037739103499530.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 15:00:19 +0000
References: <cover.1791223958.git.pav@iki.fi>
In-Reply-To: <cover.1791223958.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  5 Oct 2026 21:13:53 +0300 you wrote:
> For mesh advertisements = adv_info::mesh nonzero, the time units are
> milliseconds instead of seconds like normally.
> 
> This was forgotten in hci_schedule_adv_instance_sync() and
> hci_enable_ext_advertising_sync() which scheduled 1000x too large
> timeouts.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: hci_sync: fix mesh adv timeout units
    (no matching commit)
  - [2/2] Bluetooth: make hdev->adv_instance_timeout a boolean
    https://git.kernel.org/bluetooth/bluetooth-next/c/dedfbdb9bf06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


