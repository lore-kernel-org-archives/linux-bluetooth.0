Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74F54DAF8D
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583501; cv=none; b=mgtqpybvioah8Y0HJKEsRRQ7ndylxp7cmSi+a6riXgC8xf8jsfVel2QwUEqxZ17Xi51Y6mRUqgIJFi+H8DeFimt+MAC+o2h4ztxI2WZAW95ejr561dN6OD9IObRiZUkZZITEXILBHgG6ans2LefHi/HYwTpJo4u8ronYefPDLcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583501; c=relaxed/simple;
	bh=CbKU9ABMq4jMlw1J+jnMp/kv7UXzUASW6kp8fPENXsg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eeJJoqWmuBKSoVkSUpdr1T6oKXukQHHXd+aPgbIa17hl85acU0TjPKFUHD7dugvJyNMs3mJRk4OT7euMQxQ7CUFK/pl5hWyUFPlF29aPR0gvisr9pVpc/18BdGz8YOtBykS7UzRFwx8J7/BPX0WTo6j5musWBMMPrFRQ1C7KCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hts4+IU+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hts4+IU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB4A1F0089F;
	Wed, 16 Sep 2026 18:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583477;
	bh=gxhI8+KB0oMjpjgnhhgDGDVggqayaHLDR2WmATk9F7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hts4+IU+5r1f8MZmUVCMsflFJHNOdh71fjMcupr79AwKKjk41C+pk0qGYvSio+Omt
	 OFclqdT9dPWe83z8PKw+ocaGdnKKB2vHIo3UnkgF2BVcpY/SZhNupv9Cwtdw2uy0Fz
	 /I62QgG+whCJyUPAmGUH2RMAzwUznaEUf0EVMSjh8QQMkcGqdkCNVLAUIW+a2SNpAW
	 ai8dLeziP4xGir+psxFHqEUclFVNu9w3fQEBF+s8wESUS2Wmz0Q/GlzicQ/CGcAirI
	 tQ4Ol7LzD1Og3LDw6LdGl3jgbjgMHc4eWGPRU+d5/uk7HGF1TT7ig9IcIJqVYrN4Al
	 WL9BPpoMd3IuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B1639E8A52;
	Wed, 16 Sep 2026 18:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] test-runner: Enable interrupt remapping for PCIe
 passthrough
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178958341112.3229304.24757968331420535.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 18:30:11 +0000
References: <20260915213723.1242672-1-luiz.dentz@gmail.com>
In-Reply-To: <20260915213723.1242672-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Sep 2026 17:37:23 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> A device passed through with -P fails to allocate its MSI-X vectors
> (-ENOSPC) as the guest has no way to remap interrupts, so give it a
> virtual IOMMU with interrupt remapping enabled, which in turn requires
> the irqchip to be split.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] test-runner: Enable interrupt remapping for PCIe passthrough
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a410e06a4b61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


