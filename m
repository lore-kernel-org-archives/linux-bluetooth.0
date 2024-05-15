Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0956F1591E8;
	Wed, 15 May 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802630; cv=none; b=X31PORueiVWnxdxnaKTCdrX8HqJG351HZDiR3SPmQTqNQ24/s+DfJmDjhcRfBWGADa7Ve2ApvfijrFcNJMXePd5gjZvMnFg+apqOeejdk0YC+aItl4O/jJ36qGdPYm3IbYT7/3bNEXEyTuGBorZ+uJjiAjRwLwRl9ve6y1o0b4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802630; c=relaxed/simple;
	bh=hWyjfmv2nHBWx3mYTJqtMsHJh9zlKywb3yOcqTJs0SA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Iz5hcZm2k1tPKUx3ikZmHCkQFjCWSuWdJWLPta+2u9woHBqJPyr+yGVIXkSSciC/4ngWNypnw2WWypTO5XW2ReXD+DGlx/o96uFbPnD6+pf6ncomDqAS4M4CPvb0gQCsh9UMYaOQmAXrqQTscpNyVqvC5yRz10NLdO1BWPNuJos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9vAf9m9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9vAf9m9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80193C2BD11;
	Wed, 15 May 2024 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715802629;
	bh=hWyjfmv2nHBWx3mYTJqtMsHJh9zlKywb3yOcqTJs0SA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V9vAf9m9TP7WRM49Z5PaTJ+s8mwPBhagirU4Gfhx4UQGjQF6I+t4CKSDimlAGUDdf
	 cjTfjIJyifo5QBMvSix8u1oUVCJxNvSNRvrFzEiHiy67c0qYL0K1HjHmgFNShPrM2M
	 t5CNA/SHGYqj6V5NzsZMugjmxdotTlhoWVT66fFhnVopeJLj/yKeVt/vQ/kxOqsdXq
	 ZB9irblIE03xaCNUPLS476zAAGldHJrFSgN8qTv2cWfBdMsv4UWx8pUF+EJYxYAQ0p
	 gODA3pu51NNeQejs36gtQolmo2Iyfgblj3k5EIMSmp6pG55qf+GFrGtw65EzhmXKrl
	 DyCp10RwivXWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72D16C43332;
	Wed, 15 May 2024 19:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Add quirk to ignore reserved PHY bits in LE
 Extended Adv Report
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171580262946.22700.3070812147966702981.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 19:50:29 +0000
References: <20240515-btfix-v1-1-d88caf3d5a3f@svenpeter.dev>
In-Reply-To: <20240515-btfix-v1-1-d88caf3d5a3f@svenpeter.dev>
To: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Cc: marcan@marcan.st, alyssa@rosenzweig.io, marcel@holtmann.org,
 luiz.dentz@gmail.com, johan.hedberg@gmail.com, luiz.von.dentz@intel.com,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, j@jannau.net, sven@svenpeter.dev

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 May 2024 18:02:58 +0000 you wrote:
> From: Sven Peter <sven@svenpeter.dev>
> 
> Some Broadcom controllers found on Apple Silicon machines abuse the
> reserved bits inside the PHY fields of LE Extended Advertising Report
> events for additional flags. Add a quirk to drop these and correctly
> extract the Primary/Secondary_PHY field.
> 
> [...]

Here is the summary with links:
  - Bluetooth: Add quirk to ignore reserved PHY bits in LE Extended Adv Report
    https://git.kernel.org/bluetooth/bluetooth-next/c/9dc8ac15ca51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


