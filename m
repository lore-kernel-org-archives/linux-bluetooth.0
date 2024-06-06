Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83B161FC5;
	Thu,  6 Jun 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702830; cv=none; b=YAwR3RqmJ4x2pEw1vWdwKQ7TX51QrUQa6mUP0TdycjOmyzLqHD2w6ec8i98x3ttkKaKOYUN1QSO1n9EAc4wFTF+4IzymxbRFzDANiBrkxHdoedd4CwwqAQ1h/LdMSv6VOKHMcgAlpGF6mqQZ5jRoL3ME6sW8QC8w6r//Z8fKXrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702830; c=relaxed/simple;
	bh=f3k9PHy+8tQvuHXSHVcmvybWcHCsGpAomL+yq5Dn7iU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a+hZyuhySovXjOAqixWX2M/LwUku74LBtI8fgIa3KI5PzFDze6T0/WD9JP/UaH5jPV6bzjqEHwHBWJ8omCgTPxjq3eARdOsm5TT3xJAUzyhCM9/EAr8kzcz1wNSAYUbciRMtBnc+QmKJplXLB3nm/o5+zG+gsEm24IuE4whzV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxIGAvkp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxIGAvkp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BDE0C3277B;
	Thu,  6 Jun 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717702829;
	bh=f3k9PHy+8tQvuHXSHVcmvybWcHCsGpAomL+yq5Dn7iU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oxIGAvkp9xGgiOszw8XVA7BlfMNXTBIRZ1fIvBtgi3bPUOQ158fPCbouXWPYIykQH
	 efYHi2KZbc+osnPJ9xnThCVtxjy1886tQ+ex0u+yY5a7nSio/PrSlLdlrWgXCfeiqY
	 /obKKxPFnH5evZTGJ6TS3rZp6VB2M7c8AdbdHEVPAd5j8Z9WmMjX6LhT/YVOCeMKHx
	 1tY3eVDULcvmdxMxfFAzFymhrAtaDpE7kGV6CL9Uje6RO89WKomeDxv8I4vSN8XIRu
	 gj9Whpw44SC4Ybl16L+KqK51KoYU/hBEtQV9nd1qGhnIwIcVITcdCImwsw6gbcCxe4
	 RMh9SJL9NHxHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 468C8D2039C;
	Thu,  6 Jun 2024 19:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Add BCM4388 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171770282928.6851.17710724113724214544.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 19:40:29 +0000
References: <20240602-btbcm4388-v1-1-210e4b4eeb3b@svenpeter.dev>
In-Reply-To: <20240602-btbcm4388-v1-1-210e4b4eeb3b@svenpeter.dev>
To: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, marcan@marcan.st,
 alyssa@rosenzweig.io, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, sven@svenpeter.dev

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 02 Jun 2024 09:57:05 +0000 you wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> This new variant needs a different core2_window1 and always uses
> beamforming.
> The BAR2 also has an offset (RAM start, presumably), so add that.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Sven Peter <sven@svenpeter.dev>
> [sven: rebased, updated some comments, mentioned 4388 in Kconfig]
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_bcm4377: Add BCM4388 support
    https://git.kernel.org/bluetooth/bluetooth-next/c/0b22b7f8aef3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


