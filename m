Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50D3F0761;
	Tue, 13 Oct 2026 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901210; cv=none; b=i+ldx5zrON+iVUIqPx/3ZuKJFg78InsZCyklI379PWj3SelWxOL+9BSnp6LKYhq2nRO2E3FveHlw0dBUkaZznbhjfR9Ufl59uvaK8i+UykD557oZ1+WZ91dR1yzjFKeOfcDIWDeCTOtGY1Jsd8ghgTs1KhI8t/F+69WV4k5/YM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901210; c=relaxed/simple;
	bh=GHgnCgKT8Dx2CWvVDMhg/FA5Ts9vQBie5hxGm4uHjBk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=POadLtor2IB7UYbF5EIu+rdG3Tb9vOpyGA0oWMguqogUksix70JpMZ2HXEW/33p1jsldWA7+gNyw1fEO6Xk21qBTbFF4zfuCExRCXWt+iee15hjn+FlQaYglG47pOi5KAUMzf6oy3bmOUoIPJfl9G6QG16o7ZjTUMZ7zphFFY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfpQ2EdM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfpQ2EdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F901F00893;
	Tue, 13 Oct 2026 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901209;
	bh=2kyLZJ/2rfXN5bZbtrxEBotazNxgP7vYhNpb4oPxzhY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MfpQ2EdMaE/194szPZg+JGL4yINUy7oRhQg0hdw31KFf74oNOPNS8kK/cJrAyA+W2
	 rbTeJJb2NXa3k8EUAxzg6tScLag8ug1HgMus1vXP8NV7tUetCFLgJHnC2yE2ugkbNd
	 JCYIX2hA1dRvfRt3yrcu+DzOXB57eVP+HZeeZQsqDodV/xA6XReGIvZIPts1L20wDU
	 UpHSM6AH2/oTLaVugq3voH2RknWEPV8j0vHViu3vAKopVFNTNewwwoWkcvtxu+KWpp
	 /6d1ixxn17pW4QpB+YrA0jMZxZ79GYSvo5OFRmv9yhnN8J+61xHyEZ8cH0PHIh38O5
	 sHUXH1PrOGISw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773FA39D237D;
	Tue, 13 Oct 2026 14:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: btmtk: Add MT7928 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179190120801.334087.12991106842776362785.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 14:20:08 +0000
References: <20261008085559.813654-1-chris.lu@mediatek.com>
In-Reply-To: <20261008085559.813654-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, will-cy.Lee@mediatek.com, ss.wu@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 8 Oct 2026 16:55:59 +0800 you wrote:
> Add support for MT7928 (internal device ID is MT7935) which requires
> additional firmware (CBMCU firmware) loading before Bluetooth firmware.
> 
> CBMCU is a new component on MT7928 to handle common part shared across
> the combo chip, providing a better user experience through improved
> coordination between subsystems.
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: btmtk: Add MT7928 support
    https://git.kernel.org/bluetooth/bluetooth-next/c/2c5f7c9b12f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


