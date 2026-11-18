Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794964208;
	b=HlEDtnZiAwhEq5oQTFXChpiz5eFmMAFBoNbc97m5Xs/CfFmZXk/PV2IbleC3YK4bk6u9
	 chGNyxFeVpLJBjl5auR6nBk/oOa1CIf/eKf1jmEKnlRkVt+V2f/bcWOzX/aivqRkAOrCX
	 l1UzklybqCbWi4oUDtv1+lCu66ubkVdUc+dJ7jlEvLVtyQ2jxwaGho+v/8c9OM80zM3Ky
	 pAYMGMwtDZLcZ38v+VWMUHsk+0Yr0N/4VeW9dtjjVL1ZAd7yvvsOkpwr/DWiduIvDzU++
	 MSPSuxnFvw7n3/df9QjvB2D3o1CJfmMhEUHlPfHNXC0VHeGFRhg0G94mNUBAokhKUJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794964208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=BEwJS0ivuU7/kFpwecEYYU5t203aJ3clGIgLhquHn6s=;
	b=HqIRmQLQlx4XVatcK77WoJMXCEVYSdc9124lGcyXhf6ADhPAM4c8saqpYkuxssOUT42m
	 YlITV2G9rJvzl8sa/HVtdINrU0so59tBJt9ixAimq05+hiSCkixHyEV64JcnCJkYkQtyd
	 xM4tddqVm9lwJmFDGPB1lq2vGiv4kFUSr9AZtdk8FJsom+rtnyGXCNYEIMf8/otRwoUcf
	 LyVpwQckdr5GLb6dgQrGJbhSPTp2fo5MkeA+mykkMZ7tmYYbehFzV58yryimzGOH+6ZxW
	 FrpHeFLS7UFzpqQyB6torNW3EcDYiKEUhJW+fDhm84YLga0tZhhFeDVMxofepxjozfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S/e0iSFW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B133606A31C;
	Wed, 18 Nov 2026 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/e0iSFW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4319F1F000C5;
	Wed, 18 Nov 2026 01:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794964208;
	bh=BEwJS0ivuU7/kFpwecEYYU5t203aJ3clGIgLhquHn6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S/e0iSFWfwfsWvkfwgrtQKscggnWAQpCW4T+I0r7wQ7zf7foj1u6UILzvAFpuVgA1
	 h4UIu482cXPD0a6rn+rYvmkRVgAEeL76Frx/OtIGxXH6cF4tIK1YCC8pnQ4l7TeDRw
	 sBDs+K66gt80zsc641T0C9Cf4IUxG3Hf6I9nP5Ag+ctFGtW/WDvUmzfo/IPr7AivWS
	 KC0EkoGbaGLXw3yiUHMBqlug1T8c8+ZeadhmGq6a0MmNBvClGLthecy1SBEbZEPQJT
	 LULq7MXvHJJ/WFPZupRSnoy+iVyJTdpB4ZSG9jBZzLpUjfNw6o4VJ7C6K2ot7+0ngd
	 xLcSCSbojpkwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A248392B1FE;
	Wed, 18 Nov 2026 01:10:08 +0000 (UTC)
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
Subject: Re: [GIT PULL] bluetooth 2026-11-17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179496420703.1386019.11059029920092045078.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 01:10:07 +0000
References: <20261117171516.3560754-1-luiz.dentz@gmail.com>
In-Reply-To: <20261117171516.3560754-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Nov 2026 12:15:16 -0500 you wrote:
> The following changes since commit 1f2ac56137c51be0601e18a163d817e02a15913f:
> 
>   Bluetooth: L2CAP: Keep recvmsg from resuming a closed channel (2026-11-09 17:04:21 -0500)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-11-17
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-11-17
    https://git.kernel.org/netdev/net/c/7a4e97161014

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


