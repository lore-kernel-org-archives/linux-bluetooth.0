Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358809;
	b=yxcp52TVAzecbRU528sAPWDj+MVc3rl/pzS/VSseQmIZVoJY4pHH0YsUkutfL/MF0EJx
	 mkFD9fixjoC7e37lw/D0dBpoY6Y6MOFCzJ7syirKqRfGGBPeEJdv8c1Ew749oe6WRIXcc
	 efRpwByQQ7NxmfSl+28m/Gi9//vggOS/YY69pPrYUjK4uJmDQKSbDiy5s/0OJMhbyGyJz
	 RVBwdIIRhq+somvTJAwQy9bSwigsto15HqqkYbYM1hlcY6KR8BmfY4BljVKa2Bac/UMMi
	 Mz1F2DyKyvK9CglBp69c72LgZHTja3Zflgft6sd2xsT3C6mH4AFYge32ChZPEUyyEeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Hjqby1IHlHWVQzLbmD1irdLHr+riAfVpOSnmVsrMssE=;
	b=CEDRgE159qgW9gZ7RvSA8ZWrnMcCWkV7LeFQe86DLz7aSsYIt5oLe0vJC+GR9AnES3OM
	 8wpryy2gqcIIpmQkYAYfwTQBZ6h0esYwLa+Sv+puLH7wWkJgd7FQiMjHj5jlrDWfpv3Yj
	 uNi60ZrQ6csvoaRC7BGVFSfl0LrWZ0r7WHEaIoXFhshqLZDDsUco692ADtP+6VGd3SBoQ
	 kvBQrpl9Pk45khoBONY1WMtzaeW0TPDSmXYae43Ibs/IPYjagMDNtj9dT81tyc7oVw0SD
	 tGU6chwWQlqwj+R42o788y0xEtus30bko7T+qjgR7boNqAKDDiQAcfnLRwfdnqAroeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h/ixYkwg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94001606AA12;
	Wed, 11 Nov 2026 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/ixYkwg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5D41F0089F;
	Wed, 11 Nov 2026 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794358809;
	bh=Hjqby1IHlHWVQzLbmD1irdLHr+riAfVpOSnmVsrMssE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h/ixYkwgb9s7Mkbdao/NF7zShW8UU+Q3QHsLR+hgasHeOZ1U1BJZ99ZKRfy0ZPKww
	 NFyIRISOZ+f9UVZ72TaKaEbG+6qV6LxA4I2Mheolfzg+Rw/6jFybpN2CV3qspFkNe4
	 bnXxcz23l7AIxcWwOKiMw+gwvGLML7cVowo7QnMhw5IK3zXPPTktU+NmhklOGsUdA9
	 j31eTyAUl9HBFqEAhoXI/2QzOV5GoQTCQXaDWFPpGfYaFdhjZTQaaa2Yd3OlP5XZze
	 dd53zlAI347214eLA08C/yKSktDFM2SdY34b7BwqdNT6guF5uaYdqySbFNKNwB+QGf
	 OVCXt4tF4HhCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E17F39E8A55;
	Wed, 11 Nov 2026 01:00:09 +0000 (UTC)
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
Subject: Re: [GIT PULL] bluetooth 2026-11-09
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435880792.145868.10579908656276928259.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 01:00:07 +0000
References: <20261110024313.2023223-1-luiz.dentz@gmail.com>
In-Reply-To: <20261110024313.2023223-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 21:43:13 -0500 you wrote:
> The following changes since commit 60b10121db602a43ada3dbc39792bbf93d25991b:
> 
>   Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery (2026-11-02 17:09:03 -0500)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-11-09
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-11-09
    https://git.kernel.org/netdev/net/c/bfa217bf0bff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


